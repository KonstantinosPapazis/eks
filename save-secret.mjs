import { Octokit } from '@octokit/rest';
import * as sodium from 'libsodium-wrappers';

(async () => {
    // Wait for sodium to be ready
    await sodium.ready;

    const octokit = new Octokit({ auth: process.env.TPA_CLASSIC_TOKEN });
    const owner = 'KonstantinosPapazis';
    const repo = 'deployments';
    const secretName = 'KUBECONFIG_BASE64';
    const secretValue = process.env.KUBECONFIG_CONTENT;

    // Fetch the public key for encryption
    const { data: { key, key_id } } = await octokit.actions.getRepoPublicKey({ owner, repo });

    // Encrypt the secret value
    const messageBytes = Buffer.from(secretValue);
    const keyBytes = Buffer.from(key, 'base64');
    const encryptedBytes = sodium.crypto_box_seal(messageBytes, keyBytes); // Correct encryption function
    const encryptedValue = Buffer.from(encryptedBytes).toString('base64');

    // Store the encrypted secret
    await octokit.actions.createOrUpdateRepoSecret({
        owner,
        repo,
        secret_name: secretName,
        encrypted_value: encryptedValue,
        key_id: key_id,
    });
})();

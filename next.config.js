/** @type {import('next').NextConfig} */
module.exports = {
    target: 'serverless',
    async rewrites() {
        return [
            // Rewrite everything to `pages/index`
            {
                source: '/:any*',
                destination: '/',
            },
        ];
    },
    reactStrictMode: true,
};

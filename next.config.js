/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: false,
  swcMinify: false,
}

const moduleExports = {
  async headers() {
      return [
      {
        source: "/api/:path*",
        headers: [
       { key: "Access-Control-Allow-Credentials", value: "true" },
       { key: "Access-Control-Allow-Origin", value: "http://localhost:3000"},
       { key: "Vary", value: "Origin"},
       { key: "Access-Control-Allow-Methods", value: "GET,OPTIONS,PATCH,DELETE,POST,PUT" },
       { key: "Access-Control-Allow-Headers", value: "X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version" }
      //  { key: "Connectino", value: "Keep-Alive" }
      ]
      }
      ]
  },
  async redirects() {
    return [
      {
        source: '/account',
        destination: '/account/profile',
        permanent: true,
      },
    ]
  },
};

// module.exports = nextConfig;
module.exports = moduleExports; 

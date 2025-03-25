const client = require("prom-client");
const register = new client.Registry();

client.collectDefaultMetrics({ register });

const getMetrics = async (req, res) => {
  try {
    res.set("Content-Type", register.contentType);
    const metrics = await register.metrics();
    res.end(metrics);
  } catch (err) {
    res.status(500).end(err.toString());
  }
};

module.exports = { 
    getMetrics 
};
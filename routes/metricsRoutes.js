const express = require("express");
const { getMetrics } = require("../controllers/metricsController");
const authMiddleware = require("../middleware/authMiddleware");
const router = express.Router();

router.get("/metrics", authMiddleware, getMetrics);

module.exports = router;

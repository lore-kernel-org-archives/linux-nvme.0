From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Jul 2017 11:09:42 +0300
Subject: [PATCH v8 5/7] mlx5: support ->get_vector_affinity
In-Reply-To: <1499933384-17407-1-git-send-email-sagi@grimberg.me>
References: <1499933384-17407-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499933384-17407-6-git-send-email-sagi@grimberg.me>

Simply refer to the generic affinity mask helper.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Acked-by: Leon Romanovsky <leonro at mellanox.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/infiniband/hw/mlx5/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 9ecc089d4529..2b09a3c69c26 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3562,6 +3562,14 @@ static void mlx5_ib_free_rdma_netdev(struct net_device *netdev)
 	return mlx5_rdma_netdev_free(netdev);
 }
 
+const struct cpumask *mlx5_ib_get_vector_affinity(struct ib_device *ibdev,
+		int comp_vector)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+
+	return mlx5_get_vector_affinity(dev->mdev, comp_vector);
+}
+
 static void *mlx5_ib_add(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_ib_dev *dev;
@@ -3692,6 +3700,7 @@ static void *mlx5_ib_add(struct mlx5_core_dev *mdev)
 	dev->ib_dev.check_mr_status	= mlx5_ib_check_mr_status;
 	dev->ib_dev.get_port_immutable  = mlx5_port_immutable;
 	dev->ib_dev.get_dev_fw_str      = get_dev_fw_str;
+	dev->ib_dev.get_vector_affinity	= mlx5_ib_get_vector_affinity;
 	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads)) {
 		dev->ib_dev.alloc_rdma_netdev	= mlx5_ib_alloc_rdma_netdev;
 		dev->ib_dev.free_rdma_netdev	= mlx5_ib_free_rdma_netdev;
-- 
2.7.4

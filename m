From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  7 Jun 2017 19:02:40 +0300
Subject: [PATCH v5 for-4.13 4/6] mlx5: support ->get_vector_affinity
In-Reply-To: <1496851362-1344-1-git-send-email-sagi@grimberg.me>
References: <1496851362-1344-1-git-send-email-sagi@grimberg.me>
Message-ID: <1496851362-1344-5-git-send-email-sagi@grimberg.me>

Simply refer to the generic affinity mask helper.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Acked-by: Leon Romanovsky <leonro at mellanox.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/infiniband/hw/mlx5/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 0c79983c8b1a..cf31cf54804c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3562,6 +3562,15 @@ static void mlx5_ib_free_rdma_netdev(struct net_device *netdev)
 	return mlx5_rdma_netdev_free(netdev);
 }
 
+const struct cpumask *mlx5_ib_get_vector_affinity(struct ib_device *ibdev,
+		int comp_vector)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+
+	return pci_irq_get_affinity(dev->mdev->pdev,
+			MLX5_EQ_VEC_COMP_BASE + comp_vector);
+}
+
 static void *mlx5_ib_add(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_ib_dev *dev;
@@ -3694,6 +3703,7 @@ static void *mlx5_ib_add(struct mlx5_core_dev *mdev)
 	dev->ib_dev.get_dev_fw_str      = get_dev_fw_str;
 	dev->ib_dev.alloc_rdma_netdev	= mlx5_ib_alloc_rdma_netdev;
 	dev->ib_dev.free_rdma_netdev	= mlx5_ib_free_rdma_netdev;
+	dev->ib_dev.get_vector_affinity	= mlx5_ib_get_vector_affinity;
 	if (mlx5_core_is_pf(mdev)) {
 		dev->ib_dev.get_vf_config	= mlx5_ib_get_vf_config;
 		dev->ib_dev.set_vf_link_state	= mlx5_ib_set_vf_link_state;
-- 
2.7.4

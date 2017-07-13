From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Jul 2017 11:09:39 +0300
Subject: [PATCH v8 2/7] mlx5e: don't assume anything on the irq affinity
 mappings of the device
In-Reply-To: <1499933384-17407-1-git-send-email-sagi@grimberg.me>
References: <1499933384-17407-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499933384-17407-3-git-send-email-sagi@grimberg.me>

mlx5e currently assumes that irq affinity is really spread first
irq vectors across device home node cpus, with the new generic affinity
mappings this is no longer the case, hence mlxe should not rely on
this anymore.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 739e181ff633..1ae40e08b50a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3733,18 +3733,8 @@ void mlx5e_build_default_indir_rqt(struct mlx5_core_dev *mdev,
 				   u32 *indirection_rqt, int len,
 				   int num_channels)
 {
-	int node = mdev->priv.numa_node;
-	int node_num_of_cores;
 	int i;
 
-	if (node == -1)
-		node = first_online_node;
-
-	node_num_of_cores = cpumask_weight(cpumask_of_node(node));
-
-	if (node_num_of_cores)
-		num_channels = min_t(int, num_channels, node_num_of_cores);
-
 	for (i = 0; i < len; i++)
 		indirection_rqt[i] = i % num_channels;
 }
-- 
2.7.4

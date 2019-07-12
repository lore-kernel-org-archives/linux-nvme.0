From: Parav Pandit <parav@mellanox.com>
Date: Fri, 12 Jul 2019 04:34:52 -0500
Subject: [PATCH] IB/bnxt_re: Honor vlan_id in GID entry comparision
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190712093452.X5EZMdERUK1rmD3PEqywRi4ORA-7gl5bhKIZhQcjOWo@z>

GID entry consist of GID, vlan, netdev and smac.
Extend GID duplicate check comparions to consider vlan_id as well
to support IPv6 VLAN based link local addresses.

Fixes: 823b23da7113 ("IB/core: Allow vlan link local address based RoCE GIDs")
Change-Id: I2e026ec8065c8425ba24fad8525323d112a2f4e4
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 4 +++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 48793d3512ac..8567b7367669 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -296,7 +296,8 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	}
 	free_idx = sgid_tbl->max;
 	for (i = 0; i < sgid_tbl->max; i++) {
-		if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid))) {
+		if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid)) &&
+		    sgid_tbl->tbl[i].vlan_id == vlan_id) {
 			dev_dbg(&res->pdev->dev,
 				"SGID entry already exist in entry %d!\n", i);
 			*index = i;
@@ -351,6 +352,7 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	}
 	/* Add GID to the sgid_tbl */
 	memcpy(&sgid_tbl->tbl[free_idx], gid, sizeof(*gid));
+	sgid_tbl->tbl[free_idx].vlan_id = vlan_id;
 	sgid_tbl->active++;
 	if (vlan_id != 0xFFFF)
 		sgid_tbl->vlan[free_idx] = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 0ec3b12b0bcd..7a1957c9dc6f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -82,6 +82,7 @@ struct bnxt_qplib_pd {
 
 struct bnxt_qplib_gid {
 	u8				data[16];
+	u16 vlan_id;
 };
 
 struct bnxt_qplib_ah {
-- 
2.19.2

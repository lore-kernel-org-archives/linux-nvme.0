From: Parav Pandit <parav@mellanox.com>
Date: Fri, 12 Jul 2019 04:34:52 -0500
Subject: [PATCH v1] IB/bnxt_re: Honor vlan_id in GID entry comparison
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190712093452.PdTgtQ24dZbMUtaBdolUjgWScQaSE2DJvjOLi1pdbJg@z>

GID entry consist of GID, vlan, netdev and smac.
Extend GID duplicate check companions to consider vlan_id as well
to support IPv6 VLAN based link local addresses.

GID deletion based on only GID comparision is not correct.
It needs further fixes.

Fixes: 823b23da7113 ("IB/core: Allow vlan link local address based RoCE GIDs")
Change-Id: I2e026ec8065c8425ba24fad8525323d112a2f4e4
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 5 +++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 7 ++++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 37928b1111df..216648b640ce 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -488,6 +488,8 @@ static int bnxt_qplib_alloc_sgid_tbl(struct bnxt_qplib_res *res,
 				     struct bnxt_qplib_sgid_tbl *sgid_tbl,
 				     u16 max)
 {
+	u16 i;
+
 	sgid_tbl->tbl = kcalloc(max, sizeof(struct bnxt_qplib_gid), GFP_KERNEL);
 	if (!sgid_tbl->tbl)
 		return -ENOMEM;
@@ -500,6 +502,9 @@ static int bnxt_qplib_alloc_sgid_tbl(struct bnxt_qplib_res *res,
 	if (!sgid_tbl->ctx)
 		goto out_free2;
 
+	for (i = 0; i < max; i++)
+		sgid_tbl->tbl[i].vlan_id = 0xffff;
+
 	sgid_tbl->vlan = kcalloc(max, sizeof(u8), GFP_KERNEL);
 	if (!sgid_tbl->vlan)
 		goto out_free3;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 48793d3512ac..0d90be88685f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -236,6 +236,9 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 		return -ENOMEM;
 	}
 	for (index = 0; index < sgid_tbl->max; index++) {
+		/* FIXME: GID delete should happen based on index
+		 * and refcount
+		 */
 		if (!memcmp(&sgid_tbl->tbl[index], gid, sizeof(*gid)))
 			break;
 	}
@@ -296,7 +299,8 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	}
 	free_idx = sgid_tbl->max;
 	for (i = 0; i < sgid_tbl->max; i++) {
-		if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid))) {
+		if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid)) &&
+		    sgid_tbl->tbl[i].vlan_id == vlan_id) {
 			dev_dbg(&res->pdev->dev,
 				"SGID entry already exist in entry %d!\n", i);
 			*index = i;
@@ -351,6 +355,7 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
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

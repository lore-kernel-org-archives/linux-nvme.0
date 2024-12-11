Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC41E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4uLsQcFzdC0sQvyi89Tv55TGfj5k3klJiZJ/npGc9Js=; b=YCyyiHXKhgUCJj+DpaNzOJcwvP
	ELItb2NIBI1NX+eT92aPn0hcVeAciCPrsSK9Hj+TQ4m+FbVFGnMQ/Nq2ZuhE7NOUsm4jWyopzYElo
	O9It/D8n4Rv2sIw5l+aZ7T6FsUMyym1PcQ5nixKO223v0pxtFyKNAwvqFzIh4SLzSn6NLo7C84ZfM
	aAP6x2X0xmMcHLCoMZuBEEseQ+uIZKPVjhpgglpbYModsceJYktNPcmAbs8zrGCUCzXUA1wcmXz0K
	HRO7caUgPxcu+/TXwFMuWl6rSnwZGvIJ2BI85n7HxMgXaf6RzY8I7J+Jia6LcXK2yXRIU6/0fWssg
	Oalrp3Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIYJ-0000000EJYZ-0MUu;
	Wed, 11 Dec 2024 08:58:39 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIYG-0000000EJWP-2Z8G
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 08:58:38 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB0HEpI025926;
	Wed, 11 Dec 2024 08:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4uLsQcFzdC0sQvyi89Tv55TGfj5k3klJiZJ/npGc9
	Js=; b=I4k8wvp6zy+Uj7mLxsJCYWCg1scfA7td45yc6Fo3EvyM5NN9Pc/OL5Yfm
	QFtVIGMD1DzP4zykNyugT2Vmze7My2yxZocHzCgA+X2LfRQj0pLx33EzAlol1h0o
	6ePaG3G396sfR8wAJun6gJ9gDPq1mOm7PH0lfWwvYAug0F50T0ji3ANfA7YwUr5a
	gZGUpM0W84dk5haG0CD5KDTTXxI7WIbt6VyqVdjmauSZTX7rSdLziOfn2Hz2bRlS
	oQrXXuNVG/5PnKskikk956u+t3NUdcTPxIRbuYmw1kSfjAgsM+PI+sB1hRl0hTCH
	9aHTAvr3aDawHQZ68qQrgJb4Y/Asg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqbcxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:58:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB7nqsi023029;
	Wed, 11 Dec 2024 08:58:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wk06vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:58:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB8wIXw54722830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 08:58:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A85ED20043;
	Wed, 11 Dec 2024 08:58:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D1420040;
	Wed, 11 Dec 2024 08:58:16 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.85.18])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 08:58:16 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
        axboe@kernel.dk, shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
Subject: [PATCHv2] nvmet-loop: avoid using mutex in IO hotpath
Date: Wed, 11 Dec 2024 14:28:06 +0530
Message-ID: <20241211085814.1239731-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: prwdWgMX60g-RPWjKs-wjr8qvyU2U_Vj
X-Proofpoint-GUID: prwdWgMX60g-RPWjKs-wjr8qvyU2U_Vj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_005836_782484_68067280 
X-CRM114-Status: GOOD (  27.16  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Using mutex lock in IO hot path causes the kernel BUG sleeping while
atomic. Shinichiro[1], first encountered this issue while running blktest
nvme/052 shown below:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 996, name: (udev-worker)
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by (udev-worker)/996:
 #0: ffff8881004570c8 (mapping.invalidate_lock){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x155/0x5c0
 #1: ffffffff8607eaa0 (rcu_read_lock){....}-{1:2}, at: blk_mq_flush_plug_list+0xa75/0x1950
CPU: 2 UID: 0 PID: 996 Comm: (udev-worker) Not tainted 6.12.0-rc3+ #339
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x6a/0x90
 __might_resched.cold+0x1f7/0x23d
 ? __pfx___might_resched+0x10/0x10
 ? vsnprintf+0xdeb/0x18f0
 __mutex_lock+0xf4/0x1220
 ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
 ? __pfx_vsnprintf+0x10/0x10
 ? __pfx___mutex_lock+0x10/0x10
 ? snprintf+0xa5/0xe0
 ? xas_load+0x1ce/0x3f0
 ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
 nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
 ? __pfx_nvmet_subsys_nsid_exists+0x10/0x10 [nvmet]
 nvmet_req_find_ns+0x24e/0x300 [nvmet]
 nvmet_req_init+0x694/0xd40 [nvmet]
 ? blk_mq_start_request+0x11c/0x750
 ? nvme_setup_cmd+0x369/0x990 [nvme_core]
 nvme_loop_queue_rq+0x2a7/0x7a0 [nvme_loop]
 ? __pfx___lock_acquire+0x10/0x10
 ? __pfx_nvme_loop_queue_rq+0x10/0x10 [nvme_loop]
 __blk_mq_issue_directly+0xe2/0x1d0
 ? __pfx___blk_mq_issue_directly+0x10/0x10
 ? blk_mq_request_issue_directly+0xc2/0x140
 blk_mq_plug_issue_direct+0x13f/0x630
 ? lock_acquire+0x2d/0xc0
 ? blk_mq_flush_plug_list+0xa75/0x1950
 blk_mq_flush_plug_list+0xa9d/0x1950
 ? __pfx_blk_mq_flush_plug_list+0x10/0x10
 ? __pfx_mpage_readahead+0x10/0x10
 __blk_flush_plug+0x278/0x4d0
 ? __pfx___blk_flush_plug+0x10/0x10
 ? lock_release+0x460/0x7a0
 blk_finish_plug+0x4e/0x90
 read_pages+0x51b/0xbc0
 ? __pfx_read_pages+0x10/0x10
 ? lock_release+0x460/0x7a0
 page_cache_ra_unbounded+0x326/0x5c0
 force_page_cache_ra+0x1ea/0x2f0
 filemap_get_pages+0x59e/0x17b0
 ? __pfx_filemap_get_pages+0x10/0x10
 ? lock_is_held_type+0xd5/0x130
 ? __pfx___might_resched+0x10/0x10
 ? find_held_lock+0x2d/0x110
 filemap_read+0x317/0xb70
 ? up_write+0x1ba/0x510
 ? __pfx_filemap_read+0x10/0x10
 ? inode_security+0x54/0xf0
 ? selinux_file_permission+0x36d/0x420
 blkdev_read_iter+0x143/0x3b0
 vfs_read+0x6ac/0xa20
 ? __pfx_vfs_read+0x10/0x10
 ? __pfx_vm_mmap_pgoff+0x10/0x10
 ? __pfx___seccomp_filter+0x10/0x10
 ksys_read+0xf7/0x1d0
 ? __pfx_ksys_read+0x10/0x10
 do_syscall_64+0x93/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f565bd1ce11
Code: 00 48 8b 15 09 90 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bd e8 d0 ad 01 00 f3 0f 1e fa 80 3d 35 12 0e 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
RSP: 002b:00007ffd6e7a20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f565bd1ce11
RDX: 0000000000001000 RSI: 00007f565babb000 RDI: 0000000000000014
RBP: 00007ffd6e7a2130 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000556000bfa610 R11: 0000000000000246 R12: 000000003ffff000
R13: 0000556000bfa5b0 R14: 0000000000000e00 R15: 0000556000c07328
 </TASK>

Apparently, the above issue is caused due to using mutex lock while
we're in IO hot path. It's a regression caused with commit 505363957fad
("nvmet: fix nvme status code when namespace is disabled"). The mutex
->su_mutex is used to find whether a disabled nsid exists in the config
group or not. This is to differentiate between a nsid that is disabled
vs non-existent.

To mitigate the above issue, we've worked upon a fix[2] where we now
insert nsid in subsys Xarray as soon as it's created under config group
and later when that nsid is enabled, we add an Xarray mark on it and set
ns->enabled to true. The Xarray mark is useful while we need to loop
through all enabled namepsaces under a subsystem using xa_for_each_marked()
API. If later a nsid is disabled then we clear Xarray mark from it and also
set ns->enabled to false. It's only when nsid is deleted from the config
group we delete it from the Xarray.

So with this change, now we could easily differentiate a nsid is disabled
(i.e. Xarray entry for ns exists but ns->enabled is set to false) vs non-
existent (i.e.Xarray entry for ns doesn't exist).

Link: https://lore.kernel.org/linux-nvme/20241022070252.GA11389@lst.de/ [2]
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/ [1]
Fixes: 505363957fad ("nvmet: fix nvme status code when namespace is disabled")
Fix-suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
- Added nvmet_for_each_enabled_ns wrapper for xa_for_each_marked (hch)
- Added nvmet_for_each_ns which iterates all namespaces (hch)
- Removed now ununsed function nvmet_subsys_nsid_exists
- Pick up Reviewed-by: Hannes Reinecke <hare@suse.de>
- Pick up Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
- Link to v1: https://lore.kernel.org/all/20241129104838.3015665-1-nilay@linux.ibm.com/
---
 drivers/nvme/target/admin-cmd.c |   9 +--
 drivers/nvme/target/configfs.c  |  12 ----
 drivers/nvme/target/core.c      | 108 +++++++++++++++++++-------------
 drivers/nvme/target/nvmet.h     |   7 +++
 drivers/nvme/target/pr.c        |   8 +--
 5 files changed, 79 insertions(+), 65 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 2962794ce881..fa89b0549c36 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -139,7 +139,7 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 	unsigned long idx;
 
 	ctrl = req->sq->ctrl;
-	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
+	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		/* we don't have the right data for file backed ns */
 		if (!ns->bdev)
 			continue;
@@ -331,9 +331,10 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
 	u32 count = 0;
 
 	if (!(req->cmd->get_log_page.lsp & NVME_ANA_LOG_RGO)) {
-		xa_for_each(&ctrl->subsys->namespaces, idx, ns)
+		nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 			if (ns->anagrpid == grpid)
 				desc->nsids[count++] = cpu_to_le32(ns->nsid);
+		}
 	}
 
 	desc->grpid = cpu_to_le32(grpid);
@@ -772,7 +773,7 @@ static void nvmet_execute_identify_endgrp_list(struct nvmet_req *req)
 		goto out;
 	}
 
-	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
+	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_endgid)
 			continue;
 
@@ -815,7 +816,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 		goto out;
 	}
 
-	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
+	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_nsid)
 			continue;
 		if (match_css && req->ns->csi != req->cmd->identify.csi)
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index eeee9e9b854c..c0000db47cbb 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -810,18 +810,6 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	NULL,
 };
 
-bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
-{
-	struct config_item *ns_item;
-	char name[12];
-
-	snprintf(name, sizeof(name), "%u", nsid);
-	mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
-	ns_item = config_group_find_item(&subsys->namespaces_group, name);
-	mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
-	return ns_item != NULL;
-}
-
 static void nvmet_ns_release(struct config_item *item)
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1f4e9989663b..fde6c555af61 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -127,7 +127,7 @@ static u32 nvmet_max_nsid(struct nvmet_subsys *subsys)
 	unsigned long idx;
 	u32 nsid = 0;
 
-	xa_for_each(&subsys->namespaces, idx, cur)
+	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, cur)
 		nsid = cur->nsid;
 
 	return nsid;
@@ -441,11 +441,14 @@ u16 nvmet_req_find_ns(struct nvmet_req *req)
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 
 	req->ns = xa_load(&subsys->namespaces, nsid);
-	if (unlikely(!req->ns)) {
+	if (unlikely(!req->ns || !req->ns->enabled)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		if (nvmet_subsys_nsid_exists(subsys, nsid))
-			return NVME_SC_INTERNAL_PATH_ERROR;
-		return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
+		if (!req->ns) /* ns doesn't exist! */
+			return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
+
+		/* ns exists but it's disabled */
+		req->ns = NULL;
+		return NVME_SC_INTERNAL_PATH_ERROR;
 	}
 
 	percpu_ref_get(&req->ns->ref);
@@ -583,8 +586,6 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 		goto out_unlock;
 
 	ret = -EMFILE;
-	if (subsys->nr_namespaces == NVMET_MAX_NAMESPACES)
-		goto out_unlock;
 
 	ret = nvmet_bdev_ns_enable(ns);
 	if (ret == -ENOTBLK)
@@ -599,38 +600,19 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
 
-	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace,
-				0, GFP_KERNEL);
-	if (ret)
-		goto out_dev_put;
-
-	if (ns->nsid > subsys->max_nsid)
-		subsys->max_nsid = ns->nsid;
-
-	ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
-	if (ret)
-		goto out_restore_subsys_maxnsid;
-
 	if (ns->pr.enable) {
 		ret = nvmet_pr_init_ns(ns);
 		if (ret)
-			goto out_remove_from_subsys;
+			goto out_dev_put;
 	}
 
-	subsys->nr_namespaces++;
-
 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
+	xa_set_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
 	ret = 0;
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
-
-out_remove_from_subsys:
-	xa_erase(&subsys->namespaces, ns->nsid);
-out_restore_subsys_maxnsid:
-	subsys->max_nsid = nvmet_max_nsid(subsys);
-	percpu_ref_exit(&ns->ref);
 out_dev_put:
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		pci_dev_put(radix_tree_delete(&ctrl->p2p_ns_map, ns->nsid));
@@ -649,15 +631,37 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 		goto out_unlock;
 
 	ns->enabled = false;
-	xa_erase(&ns->subsys->namespaces, ns->nsid);
-	if (ns->nsid == subsys->max_nsid)
-		subsys->max_nsid = nvmet_max_nsid(subsys);
+	xa_clear_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		pci_dev_put(radix_tree_delete(&ctrl->p2p_ns_map, ns->nsid));
 
 	mutex_unlock(&subsys->lock);
 
+	if (ns->pr.enable)
+		nvmet_pr_exit_ns(ns);
+
+	mutex_lock(&subsys->lock);
+	nvmet_ns_changed(subsys, ns->nsid);
+	nvmet_ns_dev_disable(ns);
+out_unlock:
+	mutex_unlock(&subsys->lock);
+}
+
+void nvmet_ns_free(struct nvmet_ns *ns)
+{
+	struct nvmet_subsys *subsys = ns->subsys;
+
+	nvmet_ns_disable(ns);
+
+	mutex_lock(&subsys->lock);
+
+	xa_erase(&subsys->namespaces, ns->nsid);
+	if (ns->nsid == subsys->max_nsid)
+		subsys->max_nsid = nvmet_max_nsid(subsys);
+
+	mutex_unlock(&subsys->lock);
+
 	/*
 	 * Now that we removed the namespaces from the lookup list, we
 	 * can kill the per_cpu ref and wait for any remaining references
@@ -671,21 +675,9 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	wait_for_completion(&ns->disable_done);
 	percpu_ref_exit(&ns->ref);
 
-	if (ns->pr.enable)
-		nvmet_pr_exit_ns(ns);
-
 	mutex_lock(&subsys->lock);
-
 	subsys->nr_namespaces--;
-	nvmet_ns_changed(subsys, ns->nsid);
-	nvmet_ns_dev_disable(ns);
-out_unlock:
 	mutex_unlock(&subsys->lock);
-}
-
-void nvmet_ns_free(struct nvmet_ns *ns)
-{
-	nvmet_ns_disable(ns);
 
 	down_write(&nvmet_ana_sem);
 	nvmet_ana_group_enabled[ns->anagrpid]--;
@@ -699,15 +691,33 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 {
 	struct nvmet_ns *ns;
 
+	mutex_lock(&subsys->lock);
+
+	if (subsys->nr_namespaces == NVMET_MAX_NAMESPACES)
+		goto out_unlock;
+
 	ns = kzalloc(sizeof(*ns), GFP_KERNEL);
 	if (!ns)
-		return NULL;
+		goto out_unlock;
 
 	init_completion(&ns->disable_done);
 
 	ns->nsid = nsid;
 	ns->subsys = subsys;
 
+	if (percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL))
+		goto out_free;
+
+	if (ns->nsid > subsys->max_nsid)
+		subsys->max_nsid = nsid;
+
+	if (xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL))
+		goto out_exit;
+
+	subsys->nr_namespaces++;
+
+	mutex_unlock(&subsys->lock);
+
 	down_write(&nvmet_ana_sem);
 	ns->anagrpid = NVMET_DEFAULT_ANA_GRPID;
 	nvmet_ana_group_enabled[ns->anagrpid]++;
@@ -718,6 +728,14 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->csi = NVME_CSI_NVM;
 
 	return ns;
+out_exit:
+	subsys->max_nsid = nvmet_max_nsid(subsys);
+	percpu_ref_exit(&ns->ref);
+out_free:
+	kfree(ns);
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return NULL;
 }
 
 static void nvmet_update_sq_head(struct nvmet_req *req)
@@ -1394,7 +1412,7 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
 
 	ctrl->p2p_client = get_device(req->p2p_client);
 
-	xa_for_each(&ctrl->subsys->namespaces, idx, ns)
+	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns)
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 58328b35dc96..7233549f7c8a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -24,6 +24,7 @@
 
 #define NVMET_DEFAULT_VS		NVME_VS(2, 1, 0)
 
+#define NVMET_NS_ENABLED		XA_MARK_1
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 #define NVMET_NO_ERROR_LOC		((u16)-1)
@@ -33,6 +34,12 @@
 #define NVMET_FR_MAX_SIZE		8
 #define NVMET_PR_LOG_QUEUE_SIZE		64
 
+#define nvmet_for_each_ns(xa, index, entry) \
+	xa_for_each(xa, index, entry)
+
+#define nvmet_for_each_enabled_ns(xa, index, entry) \
+	xa_for_each_marked(xa, index, entry, NVMET_NS_ENABLED)
+
 /*
  * Supported optional AENs:
  */
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 90e9f5bbe581..cd22d8333314 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -60,7 +60,7 @@ u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask)
 		goto success;
 	}
 
-	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
+	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->pr.enable)
 			WRITE_ONCE(ns->pr.notify_mask, mask);
 	}
@@ -1056,7 +1056,7 @@ int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl)
 	 * nvmet_pr_init_ns(), see more details in nvmet_ns_enable().
 	 * So just check ns->pr.enable.
 	 */
-	xa_for_each(&subsys->namespaces, idx, ns) {
+	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, ns) {
 		if (ns->pr.enable) {
 			ret = nvmet_pr_alloc_and_insert_pc_ref(ns, ctrl->cntlid,
 							&ctrl->hostid);
@@ -1067,7 +1067,7 @@ int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl)
 	return 0;
 
 free_per_ctrl_refs:
-	xa_for_each(&subsys->namespaces, idx, ns) {
+	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, ns) {
 		if (ns->pr.enable) {
 			pc_ref = xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
 			if (pc_ref)
@@ -1087,7 +1087,7 @@ void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
 	kfifo_free(&ctrl->pr_log_mgr.log_queue);
 	mutex_destroy(&ctrl->pr_log_mgr.lock);
 
-	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
+	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->pr.enable) {
 			pc_ref = xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
 			if (pc_ref)
-- 
2.45.2



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B01E66886
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Dec 2025 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sTUvgoTGpDZ/KiV2v3A4tV9ubdJPUZLWonWSpgDuhWg=; b=LeLUDETNolbvchLQGyYp/ELg7E
	3OO9TswPIYg7VpD3T7ue9J5cwV9pWzjH5YQl8oy8bY66DpZn4C2Jr5RiMH0yD7P0iQj6I1qJcz3u3
	iGBwOJJXRhlr+YnJ3xJ4sktYcaqPXENQC8Rgf4tSOa+hrFNw1+667n5KqGI3sRK7XDWDPEqGGVU92
	90CfEzTgCtkZzzl83U9ZICSEzwbfqrp5TG3jSX9E0ZRsESYk6/YnegkTLl7ixD/nIqGEKE63Aps0f
	nukl85k5KAoC/LDYTd5Ja/xC9+3zzDPLCSvMkuFKu6+gA97ZBVUuYNtCtN/nE1mNAC1TjjUch4uKc
	Lvj/234Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXE0H-0000000CDZU-2ORl;
	Sun, 21 Dec 2025 07:37:21 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXE0F-0000000CDZ0-0zkw
	for linux-nvme@lists.infradead.org;
	Sun, 21 Dec 2025 07:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766302639; x=1797838639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uUL5QAPOF4K1Ysm1GkNlWfPaYOwVrdgFvvRJNVoenFA=;
  b=ggOHRHkjUlrDuuBS0rEY0jxkwWiOc5ZrDzv8VIqIeJ8uHpQzF3G6A6/1
   IBGl+RogcZc5204b//1d2a2Ri/LxRYaxv1DroYR5fUZMYPe8dYGmCxSDR
   r/uWmjUvijzgSyBJkPjQNJE+mmgjdNN60EyAicyX1cH5+lqmG65ckTbAw
   TjSJixrOV/NwtS6jvpbHJfEUkZAwfTx01KFdFW/8neRw9gsk2ydc9pEif
   0hu10eHGWbDJa69FhyxOHRLkSHZzNyy4MuqsVUcLvkicVKevYBgBTx6BB
   xSF1zHVZ7UgeyLUorQLNFLdrzpqyGcEiukNL6HbXapGpg6DG5mp7xqptg
   w==;
X-CSE-ConnectionGUID: Y9BK2lAuRCWnliR5G35odg==
X-CSE-MsgGUID: wlAqZQJeRsqklVxshjxBWg==
X-IronPort-AV: E=Sophos;i="6.21,164,1763395200"; 
   d="scan'208";a="138298015"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2025 15:37:17 +0800
IronPort-SDR: 6947a3ac_yb5gzeUv7b3h/xNOqZkHbzmpg5/jjq2t/D3EFkSG0f/JJzj
 FSV1UshWYyiRsq9v8ic1RD9kdxTHY+cBQ/mykuw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2025 23:37:17 -0800
WDCIronportException: Internal
Received: from jt6pxd3.ad.shared (HELO shinmob.wdc.com) ([10.224.105.96])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Dec 2025 23:37:15 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvmet: do not copy beyond sybsysnqn string length
Date: Sun, 21 Dec 2025 16:37:14 +0900
Message-ID: <20251221073714.398747-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251220_233719_300608_490A56BC 
X-CRM114-Status: GOOD (  14.70  )
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

Commit edd17206e363 ("nvmet: remove redundant subsysnqn field from
ctrl") replaced ctrl->subsysnqn with ctrl->subsys->subsysnqn. This
change works as expected because both point to strings with the same
data. However, their memory allocation lengths differ. ctrl->subsysnqn
has the fixed size defined as NVMF_NQN_FILED_LEN, while
ctrl->subsys->subsysnqn has variable length determined by kstrndup().
Due to this difference, KASAN slab-out-of-bounds occurs at memcpy() in
nvmet_passthru_override_id_ctrl() after the commit. The failure can be
recreated by running the blktests test case nvme/033. To prevent such
failures, replace memcpy() with strscpy(), which copies only the string
length and avoids overruns.

Fixes: edd17206e363 ("nvmet: remove redundant subsysnqn field from ctrl")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
FYI, here I share the WARN which caused the blktestes nvme/033 failure.

[   32.011546] [    T994] run blktests nvme/033 at 2025-12-20 20:49:57
[   32.176786] [     T81] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   32.181701] [     T81] ==================================================================
[   32.182619] [     T81] BUG: KASAN: slab-out-of-bounds in nvmet_passthru_execute_cmd_work+0xe0a/0x1750 [nvmet]
[   32.183718] [     T81] Read of size 256 at addr ffff888146030fc0 by task kworker/u16:4/81
p
[   32.184899] [     T81] CPU: 1 UID: 0 PID: 81 Comm: kworker/u16:4 Not tainted 6.19.0-rc1+ #69 PREEMPT(voluntary) 
[   32.184903] [     T81] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-8.fc42 06/10/2025
[   32.184905] [     T81] Workqueue: nvmet-wq nvmet_passthru_execute_cmd_work [nvmet]
[   32.184919] [     T81] Call Trace:
[   32.184921] [     T81]  <TASK>
[   32.184923] [     T81]  dump_stack_lvl+0x6a/0x90
[   32.184939] [     T81]  ? nvmet_passthru_execute_cmd_work+0xe0a/0x1750 [nvmet]
[   32.184950] [     T81]  print_report+0x170/0x4f3
[   32.184954] [     T81]  ? __virt_addr_valid+0x22e/0x500
[   32.184958] [     T81]  ? nvmet_passthru_execute_cmd_work+0xe0a/0x1750 [nvmet]
[   32.184969] [     T81]  kasan_report+0xad/0x150
[   32.184974] [     T81]  ? nvmet_passthru_execute_cmd_work+0xe0a/0x1750 [nvmet]
[   32.184986] [     T81]  kasan_check_range+0x115/0x1f0
[   32.184989] [     T81]  __asan_memcpy+0x1f/0x60
[   32.184991] [     T81]  nvmet_passthru_execute_cmd_work+0xe0a/0x1750 [nvmet]
[   32.185003] [     T81]  ? lock_acquire+0x16a/0x2f0
[   32.185008] [     T81]  ? __pfx_nvmet_passthru_execute_cmd_work+0x10/0x10 [nvmet]
[   32.185019] [     T81]  ? lock_acquire+0x17a/0x2f0
[   32.185021] [     T81]  ? process_one_work+0x722/0x1490
[   32.185024] [     T81]  ? lock_release+0x1ab/0x2f0
[   32.185027] [     T81]  process_one_work+0x868/0x1490
[   32.185031] [     T81]  ? __pfx_process_one_work+0x10/0x10
[   32.185033] [     T81]  ? lock_acquire+0x16a/0x2f0
[   32.185037] [     T81]  ? assign_work+0x156/0x390
[   32.185040] [     T81]  worker_thread+0x5ee/0xfd0
[   32.185044] [     T81]  ? __pfx_worker_thread+0x10/0x10
[   32.185046] [     T81]  kthread+0x3af/0x770
[   32.185049] [     T81]  ? lock_acquire+0x17a/0x2f0
[   32.185051] [     T81]  ? __pfx_kthread+0x10/0x10
[   32.185053] [     T81]  ? __pfx_kthread+0x10/0x10
[   32.185055] [     T81]  ? ret_from_fork+0x6e/0x810
[   32.185058] [     T81]  ? lock_release+0x1ab/0x2f0
[   32.185060] [     T81]  ? rcu_is_watching+0x11/0xb0
[   32.185062] [     T81]  ? __pfx_kthread+0x10/0x10
[   32.185064] [     T81]  ret_from_fork+0x55c/0x810
[   32.185066] [     T81]  ? __pfx_ret_from_fork+0x10/0x10
[   32.185068] [     T81]  ? __switch_to+0x10a/0xda0
[   32.185072] [     T81]  ? __switch_to_asm+0x33/0x70
[   32.185074] [     T81]  ? __pfx_kthread+0x10/0x10
[   32.185077] [     T81]  ret_from_fork_asm+0x1a/0x30
[   32.185081] [     T81]  </TASK>

[   32.211854] [     T81] Allocated by task 1052:
[   32.212651] [     T81]  kasan_save_stack+0x2c/0x50
[   32.213499] [     T81]  kasan_save_track+0x10/0x30
[   32.214313] [     T81]  __kasan_kmalloc+0x96/0xb0
[   32.215104] [     T81]  __kmalloc_node_track_caller_noprof+0x2e7/0x8d0
[   32.216072] [     T81]  kstrndup+0x53/0xe0
[   32.216784] [     T81]  nvmet_subsys_alloc+0x243/0x680 [nvmet]
[   32.217710] [     T81]  nvmet_subsys_make+0x95/0x480 [nvmet]
[   32.218585] [     T81]  configfs_mkdir+0x457/0xb30
[   32.219365] [     T81]  vfs_mkdir+0x615/0x970
[   32.220093] [     T81]  do_mkdirat+0x3a1/0x500
[   32.220813] [     T81]  __x64_sys_mkdir+0xd3/0x160
[   32.221583] [     T81]  do_syscall_64+0x95/0x540
[   32.222333] [     T81]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[   32.223734] [     T81] The buggy address belongs to the object at ffff888146030fc0
                           which belongs to the cache kmalloc-32 of size 32
[   32.225728] [     T81] The buggy address is located 0 bytes inside of
                           allocated 21-byte region [ffff888146030fc0, ffff888146030fd5)

[   32.228244] [     T81] The buggy address belongs to the physical page:
[   32.229238] [     T81] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x146030
[   32.230466] [     T81] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   32.231539] [     T81] page_type: f5(slab)
[   32.232239] [     T81] raw: 0017ffffc0000000 ffff888100042780 dead000000000122 0000000000000000
[   32.233443] [     T81] raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
[   32.234692] [     T81] page dumped because: kasan: bad access detected

[   32.236259] [     T81] Memory state around the buggy address:
[   32.237135] [     T81]  ffff888146030e80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
[   32.238303] [     T81]  ffff888146030f00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
[   32.239531] [     T81] >ffff888146030f80: fa fb fb fb fc fc fc fc 00 00 05 fc fc fc fc fc
[   32.240676] [     T81]                                                  ^
[   32.241679] [     T81]  ffff888146031000: fa fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
[   32.242843] [     T81]  ffff888146031080: fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb
[   32.244019] [     T81] ==================================================================
[   32.245229] [     T81] Disabling lock debugging due to kernel taint
[   32.247366] [   T1063] nvme nvme5: creating 4 I/O queues.
[   32.249203] [   T1063] nvme nvme5: new ctrl: "blktests-subsystem-1"
[   32.251921] [     T86] nvme nvme5: Duplicate unshared namespace 1
[   37.389407] [     T86] nvme nvme5: Removing ctrl: NQN "nqn.2019-08.org.qemu:deadbeef"
[   38.286242] [   T1179] SoftiWARP attached
[   38.349942] [    T994] run blktests nvme/033 at 2025-12-20 20:50:03


 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 96648ec2fadb..67c423a8b052 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -150,7 +150,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 	 * code path with duplicate ctrl subsysnqn. In order to prevent that we
 	 * mask the passthru-ctrl subsysnqn with the target ctrl subsysnqn.
 	 */
-	memcpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
+	strscpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
 
 	/* use fabric id-ctrl values */
 	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
-- 
2.52.0



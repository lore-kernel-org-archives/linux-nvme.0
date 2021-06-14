Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBAFC48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:38:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A191C61246
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A191C61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C1FgwSsEpmmgYah+/qtTD8XhiQ/qmnNYfpCKG70INzI=; b=nZmChO99GCS5ch
	GrTHABVQKL0MzAfQmdQdKV62wKmWDEPgM48JR7vbI5bMYCg4KKfb0ITmIWe3wdvu2Zv31lMjhUaOa
	gP0mLLI8cQgpYbovh8aiE0ZTx9KnBHGyuIgAkZOjh6f3mAuqqbkFyq21NIFduQHhhGjJIN2fPOAjW
	OhWrM6qSVxnWazR9r9Mttc791IaNzkSx21xKyIAm59j0dwk0elEbjY+oteOyc68AMJyH1Qm7N/b8M
	ArOHejVUz7lNX4KjITd9vkGe80REjHZECW5vKW8AyqJe3pgscc6XTAqZNkit4M0r5bsk3JMrYPwCC
	iD3WZtQslFo6zOIDMmrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsbYC-00Bu3k-Qa; Mon, 14 Jun 2021 01:38:04 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsbY7-00Bu2A-4X
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 01:38:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623634688; x=1655170688;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5NiUo6OG03gTUln1C+DzsFZcYfDyeiHw+zhwI8dWqaA=;
 b=fr1WRTsTChp104h6hqloKKW9m8R3AkXLcmESHDTQns0VQIocNT1Jth+Q
 dcqv+9UVT4qvx1FyoNsERbOi9fQkOcchz0ITtzBMKO45WcfhyKaED+yrn
 S+tVkieZ0IYBP93p9/m4fdOjpvYC2k1QPVmP2jR3mTAk/mV561Zq74Hl9
 fB64HRFLuEpJ5B+rBT5La+fNxOzFpUe7/fDTYTgC+5dtRrX+A/U2mK/N9
 GfZIXC8LX1S5qD3yVhDYMfxAf5PcKFxArGFpUzKNSSK0npM5qOfCgplpE
 l5NKKafH906oBqYX18ls5T52wA10m/k5XQHlJaKyHCK0FOW8QpZXXTUzc g==;
IronPort-SDR: HY+PZZVZxYQ+J89EBIfwE4fA4A7kxrLu+kSXojsTv+V6kQzt9cqk9pfddIuvpkMru1a0ZkmMeA
 7HaI9BAP7+UMhh7jzxEavQ+FgN1Tn8f2QGhg7yy0Sp/0PWMQyqf+8zzoYkFV8E48bcoGRlRXt1
 np0KSoZVzKcSYFUr4iDE3HcZLQf9dxa3U80cFyJvrR8xFaDp5u0IWfpmQF1dHTj0vl0pMdVQBy
 vFDHAqeyo666zDjuzCztYjrv+UtePxcNDcE/eG/s+7nMnX3LAMLyB79M7iRah+H/gKYQKGWfd/
 l1k=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="275559735"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 09:38:02 +0800
IronPort-SDR: UmjjId8UoBwLKe3VGdMUcjAGZbjrQUZcp0WJr8k0VzsKcx0FhufxXwg5sTZ1/1Y3iivZU37nIE
 YqExid00RYjkfP0eCmFUIHC3NcFwXyybGnn5k40qPPvxz8qwqRnnvJcPhK/IoF2E6rV7QDpy5o
 321uCQD3gz0EaJFiYz+z0nQ5K3uZgJmCYWIfQNVDwe4Eyp9hwx00O0rqI5w+mLGIUWIr9jY6DZ
 kFpQ/1bF7c4t+wNUiFqiB5k3iXRsKMKl7360dFXWr9OH2Rz0r5R2Cp5Hg/e3kc8ghpDeOm2KnI
 Yb1Esra03nyhom67S4bIge5V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 18:16:52 -0700
IronPort-SDR: Dub3zIRqh175LDO1Dq9IsfV64tqvI/4TIVFaN3Veak5P2CrrHay9dwr8x9lLnjOHf6Oeftzy1v
 9ilxhPfU63TUg7t/TJfjif/38hTyAcucFi0xpltqdIQimzSBerrWXpc3KL/AohGt16Zsxy0riD
 YCa14NDVfzCdpZNT4wstJavWS/BZys/aYyEdxFniaNU9JQ/G/S6tzDqeHQsgBl1D0emScWKWRS
 CPoe+WcyLky4E2j2RS3dvT/6huu+PuutzeXrtD0KdsTpK+mucw+lZsszyuzUbPcmT5c0mfEEP2
 Tqw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 18:37:55 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, dwagner@suse.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/1] nvmet: use subsys->max_nsid to report MNAN value
Date: Sun, 13 Jun 2021 18:37:53 -0700
Message-Id: <20210614013754.37940-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_183759_304939_23F1EA09 
X-CRM114-Status: GOOD (  15.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Instaed of using the NVMET_MAX_NAMESPACS use subsys->nax_nsid to set
the MNAN value since nvmet controller supports the ANA Reporting.

Without this patch we get following error with connect command :-

[337976.409142] nvme nvme1: Invalid MNAN value 1024

I've ran blocktests [1] and they pass on the top of this patch on
nvme-5.14.

-ck

Chaitanya Kulkarni (1):
  nvmet: use subsys->max_nsid to report MNAN

 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

# git log -1
commit 353d099f43f8372010bdfa16a9b6ef1cc0233b6f (HEAD -> nvme-5.14)
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Sat Jun 12 15:10:43 2021 -0700

    nvmet: use subsys->max_nsid to report MNAN
    
    For Spec regarding MNAN value:-
    
    If the controller supports Asymmetric Namespace Access Reporting, then
    this field shall be set to a non-zero value that is less than or equal
    to the NN value.
    
    Instead of using NVMET_MAX_NAMESPACES use subsys->max_nsid to set the
    MNAN value.
    
    Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
# git format-patch HEAD~1 --signoff 
0001-nvmet-use-subsys-max_nsid-to-report-MNAN.patch
# ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
umount: /mnt/nvme0n1: not mounted
+ modprobe -r nvme-fabrics
+ modprobe -r nvme_loop
+ modprobe -r nvmet
+ modprobe -r nvme
+ sleep 1
+ modprobe -r nvme-core
+ lsmod
+ grep nvme
+ git apply ./all-fixes.diff
+ sleep 1
+ git diff
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb30cb942e1d..a7f7b4dd8d37 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -692,7 +692,8 @@ static struct nvmf_transport_ops nvme_loop_transport = {
        .name           = "loop",
        .module         = THIS_MODULE,
        .create_ctrl    = nvme_loop_create_ctrl,
-       .allowed_opts   = NVMF_OPT_TRADDR,
+       .allowed_opts   = NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
+
 };
 
 static int __init nvme_loop_init_module(void)
+ sleep 1
++ nproc
+ make -j 64 M=drivers/nvme/ modules
  CC [M]  drivers/nvme//target/loop.o
  LD [M]  drivers/nvme//target/nvme-loop.o
  MODPOST drivers/nvme//Module.symvers
  LD [M]  drivers/nvme//target/nvme-loop.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/host/ /lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/target//
/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/host/:
total 9.1M
-rw-r--r--. 1 root root 4.0M Jun 13 14:23 nvme-core.ko
-rw-r--r--. 1 root root 639K Jun 13 14:23 nvme-fabrics.ko
-rw-r--r--. 1 root root 1.2M Jun 13 14:23 nvme-fc.ko
-rw-r--r--. 1 root root 1.1M Jun 13 14:23 nvme.ko
-rw-r--r--. 1 root root 1.2M Jun 13 14:23 nvme-rdma.ko
-rw-r--r--. 1 root root 1.1M Jun 13 14:23 nvme-tcp.ko

/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/target//:
total 8.3M
-rw-r--r--. 1 root root 718K Jun 13 14:23 nvme-fcloop.ko
-rw-r--r--. 1 root root 623K Jun 13 14:23 nvme-loop.ko
-rw-r--r--. 1 root root 1.1M Jun 13 14:23 nvmet-fc.ko
-rw-r--r--. 1 root root 4.0M Jun 13 14:23 nvmet.ko
-rw-r--r--. 1 root root 1.1M Jun 13 14:23 nvmet-rdma.ko
-rw-r--r--. 1 root root 868K Jun 13 14:23 nvmet-tcp.ko
+ modprobe nvme
+ git co drivers/nvme/target/loop.c
Updated 1 path from the index
# cdblktests 
 blktests (master) # ./check nvme-
./check: no group or test named nvme-
 blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  41.158s  ...  40.884s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.194s  ...  10.179s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.780s  ...  1.790s
nvme/005 (reset local loopback target)                       [passed]
    runtime  2.249s  ...  2.229s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.156s  ...  0.157s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.107s  ...  0.100s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.794s  ...  1.810s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.745s  ...  1.758s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  42.438s  ...  36.312s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  325.840s  ...  305.214s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  9.217s  ...  9.089s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  25.653s  ...  23.342s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  21.644s  ...  20.553s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  21.054s  ...  20.377s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  21.955s  ...  21.895s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  22.402s  ...  21.234s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.782s  ...  1.755s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  2.332s  ...  1.785s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.952s  ...  1.747s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.966s  ...  1.790s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.183s  ...  2.192s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.831s  ...  1.828s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.748s  ...  1.734s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.749s  ...  1.748s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.859s  ...  1.745s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.777s  ...  1.745s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.764s  ...  1.740s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.277s  ...  2.245s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.422s  ...  0.414s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  5.982s  ...  6.045s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.060s  ...  0.063s


-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

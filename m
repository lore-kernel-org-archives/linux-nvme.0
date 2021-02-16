Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4927C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9194C64E08
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9194C64E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZBr8Jtfgxd0gq6i1dmrsvezNfDBOr5skzEEA2pHB1oQ=; b=emNRvibWmLbz13FyUepeo8n+BL
	cckHLdzP0TkqWWUnAbN4nE56ybbfH3pfJ+/dtZsoi6xZe9b0btyFNxTraYct8hO0OSLbOdQ/iXAOS
	+r8N+VpD+Nzl01Kuk0R2321/MeZi7pqI/sx4nYwOf3DNS9ROnWBisJHoVLPXAXoqTRFdHMK8/5029
	y64RsJyhS6RANonrS8GNyUcz7vfOKovKy1eME1mMUCkJtJNtpR8tUhRniWf3HGYCG9hZhmWq5WsfB
	CpJdFm34/7R6BSZyFK6lU2i1w0ybnI9wMHXcvSo9KlMAbLlaD1JosWxJGbQoU1aQ45+WGqoL+eX7U
	n768eRzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lC7wN-0005MP-7R; Tue, 16 Feb 2021 21:31:27 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lC7wE-0005LH-4Y
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 21:31:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613511078; x=1645047078;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4fOzWhfCmx5MPC9tyxWr3p9DpdjCZxsHPf1VTsqSD9g=;
 b=bbPINcsljytfgWWGhqddCQt17rfC5G0YWiS0aDp9355Qmnn+FBM5vIal
 IrG1QtjqM6mPeh9Jn63AVDgtgxqrwkHjjX5bSfHQsIt5bd1swWGKu8s6A
 71Dz3kliRnkPVit9bhX+DQzR5JtJWusDMipWOW8E9YO4V536DE3vVrjwJ
 C0iSHPJJNG85JvN7Y0kUvlrKbiepyKwuLpagovKTWJBk5B4E+XU6oHUAj
 pRfuyhRPPtqqd9mqRM39ycKoX1Vznkrxy5NFltXgDc7U7iNbmTb+g7gyR
 o2/OX4XGZj2LDMXJNoGsvmvYLe5Xpwnx6g5I2685EuzYZ3phoembH2NFM w==;
IronPort-SDR: h33bMizW3EMOM21fj0A4qnzW3KAJEJjlZ6hlVjVdoNgVScJOonjb/jdzE1iZU3chJ6i/P+JHWv
 LbeyUHU7r/CQhN8KryHq7MsAW6hqT+kFxTXQeEuK36RT35mjd2L0YPQF2OCcJE7UKDzNab3yZt
 i17HkY5vP7TBcX7lxR6qbKGIrYJqSeKbxwg/9cF227kwf+TSWWcHXhC7/BAnx/mNDxfDaitYV7
 zGFuPAys2gWY10Zm76N0RA/ICjaMFQtZyBElEU1Wuz5RiYOlDYsuDo+llZEUVIW0vXIVNY68mJ
 kC4=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="161270753"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 05:31:14 +0800
IronPort-SDR: 7xbobpXJnKIeOQneQeICmYUUgVNB7Q5lBXISIhkV9FurTtfAVBP380flp01IS9o1ixqyrK7neF
 5huKsftQfsf/suurs1ia7XcRSSC6fS+oTr0Beb933Xc+wEzRb5cK79I8wXwIUKE/r9aO8Pnctg
 YpHdOlCxtoTiqf8iWSI2xvPDT0HxFxVHVRWbHyPzx+9afhR8tE2MNJsWUPfH4d0cqIh/Wtjrj8
 KMOCLM0j3O7Tl57X4JLgaoBrYfGpgrMIJZbNBsPhX7+fvkv7KvcUB0Ye7vajz2vZnfuY8KKfAM
 Hi6uTOfLNsYe+4sroAqsxpBS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 13:14:46 -0800
IronPort-SDR: rYkPe3pTmL5QjyEKL4stDG2Ak4ipbbB9228jt+pvSQJG+sxunOdGf4ZZwHfd3u/9wdtBOyjXBj
 Hymhv5scT3sD6I4hm6wbFZkh7uh3pNtNJddLFwueHVgdFWsO90X1kvhIUQrZ9S09ITvEaJLdgD
 qOFyfkwjEqN6+gVdO7uTEFSxqoTfUmsDsTUnwewCOBX8Hx26Ee1qb57qD5iixbqmQGJYgSkWLp
 61haGKRgV1mkJqQMSbmIdIs6joLJ4m8rpB13sxqRswK3glBGdOamPDfftMJ6TbtNgie9rDKk+W
 D0U=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 13:31:14 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/6] nvmet: cleanup and status, error log fix
Date: Tue, 16 Feb 2021 13:31:06 -0800
Message-Id: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_163118_440156_6781E78A 
X-CRM114-Status: GOOD (  14.84  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This removes duplicate status value assignments, unnecessary function
parameters and fixes the error log page update.

Since the current nvme-5.12 is broken I've tested this series with the
debug diff which is listed in the test report along with the blktests.

-ck

Chaitanya Kulkarni (6):
  nvmet: remove duplicate status assignment
  nvmet: set status on actual error condition
  nvmet: check and set the right err location
  nvmet: remove unnecessary function parameters
  nvmet: remove unnecessary function parameter
  nvmet: remove unnecessary function parameters

 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/core.c        | 58 +++++++++++++++----------------
 drivers/nvme/target/fabrics-cmd.c | 18 +++++-----
 drivers/nvme/target/nvmet.h       | 10 +++---
 4 files changed, 43 insertions(+), 45 deletions(-)
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
+ git diff
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..cedf704adac6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1167,7 +1167,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
                if (ret)
                        goto out;
                bio = req->bio;
-               bio_set_dev(bio, bdev);
+               if(bdev)
+                       bio_set_dev(bio, bdev);
                if (bdev && meta_buffer && meta_len) {
                        meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
                                        meta_seed, write);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb6f86572b24..38fffee6b85e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -688,7 +688,8 @@ static struct nvmf_transport_ops nvme_loop_transport = {
        .name           = "loop",
        .module         = THIS_MODULE,
        .create_ctrl    = nvme_loop_create_ctrl,
-       .allowed_opts   = NVMF_OPT_TRADDR,
+       .allowed_opts   = NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
+
 };
 
 static int __init nvme_loop_init_module(void)
++ nproc
+ make -j 64 M=drivers/nvme/ modules
  CC [M]  drivers/nvme//target/configfs.o
  CC [M]  drivers/nvme//target/core.o
  CC [M]  drivers/nvme//target/admin-cmd.o
  CC [M]  drivers/nvme//target/fabrics-cmd.o
  CC [M]  drivers/nvme//target/discovery.o
  CC [M]  drivers/nvme//target/io-cmd-file.o
  CC [M]  drivers/nvme//target/io-cmd-bdev.o
  CC [M]  drivers/nvme//host/core.o
  CC [M]  drivers/nvme//target/passthru.o
  CC [M]  drivers/nvme//target/trace.o
  CC [M]  drivers/nvme//host/trace.o
  CC [M]  drivers/nvme//host/lightnvm.o
  CC [M]  drivers/nvme//target/rdma.o
  CC [M]  drivers/nvme//target/loop.o
  CC [M]  drivers/nvme//host/zns.o
  CC [M]  drivers/nvme//host/hwmon.o
  CC [M]  drivers/nvme//target/fc.o
  CC [M]  drivers/nvme//target/fcloop.o
  CC [M]  drivers/nvme//host/pci.o
  CC [M]  drivers/nvme//target/tcp.o
  CC [M]  drivers/nvme//host/fabrics.o
  CC [M]  drivers/nvme//host/rdma.o
  CC [M]  drivers/nvme//host/fc.o
  CC [M]  drivers/nvme//host/tcp.o
  LD [M]  drivers/nvme//target/nvme-loop.o
  LD [M]  drivers/nvme//target/nvme-fcloop.o
  LD [M]  drivers/nvme//host/nvme-fabrics.o
  LD [M]  drivers/nvme//target/nvmet-tcp.o
  LD [M]  drivers/nvme//host/nvme.o
  LD [M]  drivers/nvme//target/nvmet-rdma.o
  LD [M]  drivers/nvme//host/nvme-tcp.o
  LD [M]  drivers/nvme//target/nvmet.o
  LD [M]  drivers/nvme//target/nvmet-fc.o
  LD [M]  drivers/nvme//host/nvme-rdma.o
  LD [M]  drivers/nvme//host/nvme-fc.o
  LD [M]  drivers/nvme//host/nvme-core.o
  MODPOST drivers/nvme//Module.symvers
  LD [M]  drivers/nvme//host/nvme-core.ko
  LD [M]  drivers/nvme//host/nvme-fabrics.ko
  LD [M]  drivers/nvme//host/nvme-fc.ko
  LD [M]  drivers/nvme//host/nvme-rdma.ko
  LD [M]  drivers/nvme//host/nvme-tcp.ko
  LD [M]  drivers/nvme//host/nvme.ko
  CC [M]  drivers/nvme//target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme//target/nvme-loop.mod.o
  CC [M]  drivers/nvme//target/nvmet-fc.mod.o
  CC [M]  drivers/nvme//target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme//target/nvmet-tcp.mod.o
  CC [M]  drivers/nvme//target/nvmet.mod.o
  LD [M]  drivers/nvme//target/nvmet.ko
  LD [M]  drivers/nvme//target/nvme-loop.ko
  LD [M]  drivers/nvme//target/nvmet-rdma.ko
  LD [M]  drivers/nvme//target/nvme-fcloop.ko
  LD [M]  drivers/nvme//target/nvmet-tcp.ko
  LD [M]  drivers/nvme//target/nvmet-fc.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/host/ /lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/target//
/lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/host/:
total 8.0M
-rw-r--r--. 1 root root 3.0M Feb 16 12:45 nvme-core.ko
-rw-r--r--. 1 root root 643K Feb 16 12:45 nvme-fabrics.ko
-rw-r--r--. 1 root root 1.2M Feb 16 12:45 nvme-fc.ko
-rw-r--r--. 1 root root 1.1M Feb 16 12:45 nvme.ko
-rw-r--r--. 1 root root 1.2M Feb 16 12:45 nvme-rdma.ko
-rw-r--r--. 1 root root 1.1M Feb 16 12:45 nvme-tcp.ko

/lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/target//:
total 8.2M
-rw-r--r--. 1 root root 712K Feb 16 12:45 nvme-fcloop.ko
-rw-r--r--. 1 root root 619K Feb 16 12:45 nvme-loop.ko
-rw-r--r--. 1 root root 1.1M Feb 16 12:45 nvmet-fc.ko
-rw-r--r--. 1 root root 4.0M Feb 16 12:45 nvmet.ko
-rw-r--r--. 1 root root 1.1M Feb 16 12:45 nvmet-rdma.ko
-rw-r--r--. 1 root root 852K Feb 16 12:45 nvmet-tcp.ko
+ modprobe nvme
 gitlog -7 
7f0c29a24505 (HEAD -> nvme-5.12) nvmet: remove unnecessary function parameters
e8e1ea8fb333 nvmet: remove unnecessary function parameter
f169254686f6 nvmet: remove unnecessary function parameters
fc38bf1595ce nvmet: check and set the right err location
9b176efea50a nvmet: set status on actual error condition
0384837a4690 nvmet: remove duplicate status assignment
9bb31b0ab2e3 Merge branch 'nvme-5.12' of git://git.infradead.org/nvme into nvme-5.12
# cdblktests 
# ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  35.423s  ...  36.789s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.159s  ...  10.177s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.808s  ...  1.743s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.126s  ...  0.141s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.098s  ...  0.096s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.777s  ...  1.756s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.727s  ...  1.709s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  29.228s  ...  19.931s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  199.625s  ...  267.604s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  72.525s  ...  49.320s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime    ...  335.511s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  20.695s  ...  21.308s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  22.596s  ...  21.888s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  16.349s  ...  19.097s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  15.889s  ...  19.393s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.655s  ...  1.718s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.718s  ...  1.747s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.662s  ...  1.700s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.713s  ...  1.702s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.100s  ...  2.131s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.711s  ...  1.739s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.663s  ...  1.708s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.666s  ...  1.692s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.652s  ...  1.798s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.650s  ...  1.713s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.648s  ...  1.695s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.011s  ...  2.168s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.310s  ...  0.379s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  5.474s  ...  5.774s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.043s  ...  0.051s


-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

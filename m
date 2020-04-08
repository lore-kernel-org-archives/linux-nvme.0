Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D75C2D0EA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 04:16:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1852074F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 04:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L8RTtA7+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CqScQ+Sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1852074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bDV87zxAdMZ4Erw+ERBKuGGCtJZcDKXoNSZeyfv8ltc=; b=L8R
	TtA7+eaotVpX4r8Ky7v/vlKggb2iADgm10zM+V2vIquu8Yn0CTPcojetZzfpmKZoTPSonym6OMfvB
	o2cByWd/aoiy7rzo7WmxmzwuM6ud9Yugbm4+1W3AnqLYpOrsXAHk1/y3zGr24gGnGzhRTNuhfpThj
	VFZzuI1WeJ+excFHHAo9JbovHgLKD5owSi4dKbIhjkWXDgfqtdK1rHidGF2pqUQh8skmZC5ZwNi/X
	kGwEGXwKTs2EH3OpEDVLQ681g+VACKXtCVa8i09cZ87amfelIYa0cdsPJkCawOrhl0UjC2vW4792a
	F6tQM5KfJj9U85DhW+DZz6CNZTPzT6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jM28n-0001ch-HS; Wed, 08 Apr 2020 04:16:41 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM28k-0001cF-Nz
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 04:16:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586319398; x=1617855398;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Nq0q+Lu6gL1vwFttxybB/yuM6KIdHpEa9yuIHeci3VY=;
 b=CqScQ+SjpmeMJZDUof5jdL8JeXdEOfTtH+pRuHGRk758kvOJuCNPitYv
 D6AD91bDNkIxYTEpPj8SUdHDv/t1eKCGeA4r8ZtYFyZxq/Kpr4J+o7Noc
 g8D5MFcSUEBvqXrvl1zLWkNH+Lhe9Ld0/ZnoCfvC+CuN33HgTIdoUb2vL
 PKC7uNLyMw4fgXw/6ZLwMBG9pi8SMsxurG7D/+XNL6M1Wc3e2PCWCU25g
 T7aP06/vvTG5xe1BoVts0uqTnr8O837q8sm4jv1ujdjJKwMNrVMd0gnV3
 sGk+QCSlk7ZLVRpeIckkLQEDPBYGhpRYSboVNcdqbXPqRHKs4DIDx6xFc g==;
IronPort-SDR: PJvAQ7r52jxZ9lUj3h85YzCodXYuiR/PmAxO/LemCoqixoBPO2kHPOxiDcJc/mOjdpZAzIsKeh
 HTpo72Oy8M9upQs3PaYMgSwCBUBAwKMVJSrhmhBHYA92k62miFhJX9u4/v2PJ0aLK1H+uOKsPi
 n2aOHiydy6Lj3dKV6edJwpv2YlYKCzPMl6du3weDb6l1sN0bn7zsf23pnOHB7FQl43EcOVFEg8
 MhXFXFg3ynBfLSauD2+rqfat+eEb+S5BMuXNxNRFqZAQXu9CtqU/oOpihK3DkHXY7Bu35Jibuc
 3pA=
X-IronPort-AV: E=Sophos;i="5.72,357,1580745600"; d="scan'208";a="134830998"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 12:16:37 +0800
IronPort-SDR: AgoT8WjKH2lt8qSRfK18s+w3zH6W+UShR1sIo3rJN9qXZM6yz4Zyz05OPqc4YNyoe0N+qvKsy7
 SSUYofHzzSRzo0Bwl9qSGOnYRqQozNVMlsCsKp38jf2mllUPArmZ5dqWZF/Dw2QaZSYE508cDw
 RiE5mD4u05Hidtn7Frsorywe5p9eNTyFADLuwVhYax5VNaaAy86okR7qYhX0K3M5MVjPshoU0P
 pvopOg0cTwMBEBvMnQuy4r8y7JZOTpglsKlaQ85V+fD5ZWYtRFLEm9moOPaTRGjdvJThdK5hif
 sR3RHWXhFSEJQUnxM/bGQvi5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 21:07:51 -0700
IronPort-SDR: er7XutDZR1tLd1eUoWdQIBGDJpUVnpTJV+P1zFQP+rvCJ15/CCAjOctk2XRd+Zn66bz+8FSzTN
 XgcmP48DgZHl5OPzvLf2n3N3u+2cpe2XLT1b5DQ6tU4+ZmXrUu0dAbEAAQC/lkPKdkpW7K0zEo
 PR1oVt2zEral6OBHqGugVFsgabAUOyaVEsSY5xFjWvWnvaZzRgWoSu4VdgfWyZRr51hkqAF6Ao
 OsYAAp1xV7ydsfZyNtVQTlbdGj0tO2Xgoh9uKSDPXFi5g3ETzicqwBuqgs2BtV/zhcMn3qGp4Z
 a5M=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Apr 2020 21:16:37 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/2] nvmet: add revalidate support
Date: Tue,  7 Apr 2020 21:16:31 -0700
Message-Id: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_211638_853774_021084C4 
X-CRM114-Status: GOOD (  15.03  )
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
Cc: ailiop@suse.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: multipart/mixed; boundary="===============7453279538317937831=="
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============7453279538317937831==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi,

This patch series adds support for the NVMeOF target bdev-ns and
file-ns size re-validation.

The first patch adds bdev/file backend revalidation helpers which
was posted by Anthony Iliopoulos. I've fixed the comments posted on V1
by keeping the authorship of the patch.

The 2nd patch is needed since the change of size detection on the target
should generate the AEN to the host. Right now there is no mechanism
that allows us to add callbacks for the block and file backend so that
we will get the notification (if anyone knows please let me know, I'll
be happy rework this series). So this just adds a simple per namespace
thread which checks for the size change and generates AEN when needed.

I'm open to use different thread model.

Without second Patch:-
-------------------
1. Build null_blk based XFS file system :-
[ 3854.406993] XFS (nullb0): Unmounting Filesystem
[ 3865.803947] null_blk: module loaded
[ 3869.870398] XFS (nullb0): Mounting V5 Filesystem
[ 3869.873697] XFS (nullb0): Ending clean mount
[ 3869.873826] xfs filesystem being mounted at /mnt/backend supports timestamps until 2038 (0x7fffffff)
2. Add nvmet file backed namespaces and connect to host with nvme_loop.ko.
[ 3889.258370] nvmet: adding nsid 1 to subsystem fs
[ 3890.276583] nvmet: creating controller 1 for subsystem fs for NQN nqn.2014-08.org.nvmexpress:uuid:f67d5ee8-b2df-44a3-81f2-c827705db7e2.
[ 3890.277202] nvme nvme1: creating 64 I/O queues.
[ 3890.293196] nvme nvme1: new ctrl: "fs"
[ 3890.295363] nvme1n1: detected capacity change from 0 to 10737418240
# dmesg -c 
# dmesg -c 
3. Verify the backend file information :-
# cat /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/device_path
/mnt/backend/nvme1n1
# file /mnt/backend/nvme1n1
/mnt/backend/nvme1n1: data
# ls -lrth /mnt/backend/nvme1n1
-rw-r--r--. 1 root root 10G Apr  7 20:51 /mnt/backend/nvme1n1
4. Change the size of the backend file :-
# truncate -s 5G /mnt/backend/nvme1n1
# dmesg -c 
# dmesg -c 
5. Check the host size block device size.
# lsblk | grep nvme1n1
nvme1n1           259:11   0   10G  0 disk <-----------------------
#

With the second patch:-
--------------------
1. Build null_blk based XFS file system :-
[ 3979.363104] null_blk: module loaded
[ 3983.418615] XFS (nullb0): Mounting V5 Filesystem
[ 3983.421752] XFS (nullb0): Ending clean mount
[ 3983.421887] xfs filesystem being mounted at /mnt/backend supports timestamps until 2038 (0x7fffffff)
2. Add nvmet file backed namespaces and connect to host with nvme_loop.ko.
[ 4002.801019] nvmet: adding nsid 1 to subsystem fs
[ 4003.818375] nvmet: creating controller 1 for subsystem fs for NQN nqn.2014-08.org.nvmexpress:uuid:3c1d7670-7f65-41b5-b488-9249220b76e8.
[ 4003.819076] nvme nvme1: creating 64 I/O queues.
[ 4003.834461] nvme nvme1: new ctrl: "fs"
[ 4003.837448] nvme1n1: detected capacity change from 0 to 10737418240
# dmesg -c 
3. Verify the backend file information :-
# cat /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/device_path
/mnt/backend/nvme1n1
# file /mnt/backend/nvme1n1
/mnt/backend/nvme1n1: data
# ls -lrth /mnt/backend/nvme1n1
-rw-r--r--. 1 root root 10G Apr  7 20:53 /mnt/backend/nvme1n1
4. Change the size of the backend file :-
# truncate -s 5G /mnt/backend/nvme1n1
# dmesg -c 
[ 4041.181065] nvme nvme1: rescanning namespaces.
[ 4041.529446] nvme1n1: detected capacity change from 10737418240 to 5368709120
# lsblk | grep nvme1n1
5. Check the host size block device size.
nvme1n1           259:12   0    5G  0 disk <-----------------------
# 

Regards,
Chaitanya

Changes from V1 :-

1. Just use ns->size = i_size_read(ns->bdev->bd_inode) in the
   nvmet_bdev_ns_revalidate().
2. Remove !file check and use fill line for vfs_getattr() call in
   nvmet_file_ns_revalidate().
3. Add wrapper nvmet_ns_revalidate().
4. Add 2nd patch to introduce per namespace thread to monitor the size by
   calling nvmet_ns_revalidate() and generate AEN when size change is
   detected.  
5. Change return type of the nvmet_[bdev|file]ns_revalidate() from void
   to bool.

Anthony Iliopoulos (1):
  nvmet: add ns revalidation support

Chaitanya Kulkarni (1):
  nvmet: add per ns thread to generate AEN

 drivers/nvme/target/admin-cmd.c   |  2 ++
 drivers/nvme/target/core.c        | 34 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 12 +++++++++++
 drivers/nvme/target/io-cmd-file.c | 16 +++++++++++++++
 drivers/nvme/target/nvmet.h       |  4 ++++
 5 files changed, 68 insertions(+)

-- 
2.22.1



--===============7453279538317937831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7453279538317937831==--

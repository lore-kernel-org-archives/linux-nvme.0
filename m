Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4692C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB5320774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BeUuOD++";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jm+6oAL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB5320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0L5lR0B3ZGafr8MmVmn+cMq4NAYp+zaJr2bSQmPIKqs=; b=BeUuOD++XmtMtQjRM4tL3+uW1
	XubWO96Hg5Tm4JtAJJnJdthOrr9z8EvfvyPG6C+yB+5nfLOYo6UbJm7WrFDiiETG/DijYf4MRGcxx
	21ob5qmymZ/bHI9bXsXbx3QlR02RrPHeZGO9H4wVJUkehTXmTMBfiBvGdo27kjvp8rAmgUCts1UWE
	vUe5F7A9hI+gylLwRpZnU1oM/xS8srSQMCR8Q1taGV1VFnKKfuspDcT6/WkzxHyaFovIBjKWXovD1
	Pl97vAv9/1ZI3abQ/6LNMZ91fr/yQ1HvaSVJPgZ1nEX6quX2N7lI9E11Ey20pCP8HMJJOt6kZY8il
	kWQBVoR1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5CyF-0007Pf-9O; Mon, 10 Aug 2020 18:56:31 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5CyC-0007NO-54
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085789; x=1628621789;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PExzLCC0ScloE7qMxGHYtJ5BbslOilOCEPSoCl7YL0s=;
 b=jm+6oAL4MOEdpmxQLublEJK6Q/nZ1I55tSH3wkAFWaRxrK1gOynkjvYk
 NtcbsPtWfZ/j4p4ZliyarTk4lTSwU/PphPYj/OLuxkmj/B4GwkxUUKnDu
 CYayQ32ST0rvQzlvR48Vef9wA2A+1S4fZeV4L7727sCRYVAvt0/fmOutP
 Tc+gwmzvydIe55B0aMfJV8vYZLiYbCYzlFfwIiMNmxLTfPeQbvsUZXFDh
 /pVpXRGKu8pheJ6FPiTuN0YjGDKbcT/HCjM7f4lRqeXWH8XPG/rxRcC5O
 tEMvJVsKYFD5ItlJcPQfLYWMkMGBEMLkj3RfXczVWzsU90FvZjF+whIZS A==;
IronPort-SDR: +MtROmSf+3rEdLZR+atzbpPsplb8uSbncB17rNp/yKXkW3vOIEMQGy1+eunOec+KfIYyrc6qmi
 lKykEACPuBdJ5hmhrX3JjWxhTkbPks1hFqcvrFEsyVcmTxn9oDpYM+UEP1fPXlObvVyOomXFOz
 ULEfAFcBNf/Ot5whoUlqlBFpGha+ZZHj3ZPgSWXtuQkWEzmrUQqgqyTzTCA+FzJxnp/p+cp5S0
 cRSGugS5CSnCsQnNYx8wTWNyaj/9X2z4E57yWTHoBTy4sDzbuEU7UO4ZvPRc+NBAAcRdyhBojc
 vcU=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="148924370"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:56:28 +0800
IronPort-SDR: As4HGk05JFbBanncPRQh2fJbpE6IdOmcPzQQ0pSepYbiy0FBBLn2d5FIiU+wTNJ5dNRA+Zvb0u
 II9gjYvlrdgw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:44:20 -0700
IronPort-SDR: l0dOSZIppYVuIELWOrzNWDPr3NhryCggygDDd725iqlyzoNTnktkcOgtFbojJ5NOakQYH8wJqz
 14fvcOl/Xx9Q==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:56:27 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 11/14] nvmet: fix nvme module ref count Oops
Date: Mon, 10 Aug 2020 11:54:53 -0700
Message-Id: <20200810185456.7713-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145628_390954_7224F4C9 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the passthru controller enable path current code doesn't take the
reference to the passthru ctrl module. Which produces following Oops :-

Entering kdb (current=0xffff8887f8290000, pid 3128) on processor 30 Oops: (null)
due to oops @ 0xffffffffa01019ad
CPU: 30 PID: 3128 Comm: bash Tainted: G        W  OE     5.8.0-rc4nvme-5.9+ #35
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.4
RIP: 0010:nvme_free_ctrl+0x234/0x285 [nvme_core]
Code: 57 10 a0 e8 73 bf 02 e1 ba 3d 11 00 00 48 c7 c6 98 33 10 a0 48 c7 c7 1d 57 10 a0 e8 5b bf 02 e1 8
RSP: 0018:ffffc90001d63de0 EFLAGS: 00010246
RAX: ffffffffa05c0440 RBX: ffff8888119e45a0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8888177e9550 RDI: ffff8888119e43b0
RBP: ffff8887d4768000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffc90001d63c90 R12: ffff8888119e43b0
R13: ffff8888119e5108 R14: dead000000000100 R15: ffff8888119e5108
FS:  00007f1ef27b0740(0000) GS:ffff888817600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa05c0470 CR3: 00000007f6bee000 CR4: 00000000003406e0
Call Trace:
 device_release+0x27/0x80
 kobject_put+0x98/0x170
 nvmet_passthru_ctrl_disable+0x4a/0x70 [nvmet]
 nvmet_passthru_enable_store+0x4c/0x90 [nvmet]
 configfs_write_file+0xe6/0x150
 vfs_write+0xba/0x1e0
 ksys_write+0x5f/0xe0
 do_syscall_64+0x52/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f1ef1eb2840
Code: Bad RIP value.
RSP: 002b:00007fffdbff0eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1ef1eb2840
RDX: 0000000000000002 RSI: 00007f1ef27d2000 RDI: 0000000000000001
RBP: 00007f1ef27d2000 R08: 000000000000000a R09: 00007f1ef27b0740
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f1ef2186400
R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000

We fix that by taking a module ref count in nvme_get_ctrl() and release
that ref count in nvme_pt_put_ctrl().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c       | 5 +++++
 drivers/nvme/target/passthru.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..ba019c0b514b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4608,6 +4608,11 @@ struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
 
 	ctrl = f->private_data;
 	nvme_get_ctrl(ctrl);
+	if (!try_module_get(ctrl->ops->module)) {
+		pr_err("try_module_get failed\n");
+		nvme_put_ctrl(ctrl);
+		ctrl = ERR_PTR(-EINVAL);
+	}
 
 out_close:
 	filp_close(f, NULL);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 32f4951a1df7..5925e93c4682 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -488,6 +488,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 
 static void nvme_pt_put_ctrl(struct nvme_ctrl *ctrl)
 {
+	module_put(ctrl->ops->module);
 	nvme_put_ctrl(ctrl);
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

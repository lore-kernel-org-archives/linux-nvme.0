Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B88606A329
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KT1/IT8X;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=uVRGv/HS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qt+PZYhf7moATmrnYKqOmwNJHY0piXh7VUHf25O4hOA=; b=KT1/IT8XpeaW4Qrp2aQIe0FRh7
	cwrFCkXWbyKgsYGIlHXMa73dtHfzcS7uFshYdHYfydSr8ZVnrocGGMNHflaJ43G5xSAhgYb5xP3uV
	JJ5b0B2i89Uap1TkIITGEI2fJtf59b6PZxv0kJsbleFsTcqH0sXtaEsoh0JUnbcJQr32q5WTqvA/b
	g1eZQB1/STl8XYdjnR/ZdTJiaj9ilw+J08IIvASF/hylF6CEV9nMlqxqJwU6gjumihzVuoJqW3GlI
	HkqNIC4r+07ufutk9DWex/pZY3E/TqcM+pmHdOomwsPmyw1ohROJnNnSDJz+DaZ4wyWt/2H9+aXlC
	FvQShkYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJAJ-0000000GeHm-3heG;
	Sat, 14 Nov 2026 19:11:55 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHXp-0000000GWyP-35FL
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 17:28:07 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jRh0b3hp4z4xPS1;
	Sun, 15 Nov 2026 01:27:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677279;
	bh=sB1aNW+0iZJGGQWzuqfYmutpRzCDePbP1duuwkfP40U=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=uVRGv/HSU3xSduRb81XbodjAeDn7FyXBM7Kj97WR1L1tiwfCGWxm9WJ9tcYxYg8fT
	 SFEAXgZijZVhSD2uCcEow/r53FYOfRKio6q/aMcqjtZ6VcKA0D2UaTZfxm249HWr/I
	 hMdJGsE7wlL3EU//HVEFa5EvUHOhnxAYJjcpcIzCQJy2UfDc3eApnCJVSdny1PXf+t
	 FHaGtQTvIVvUk7zaNv/F/PtgsiNJX6TpDLE9mySQ0ea2A573/xKr7rrhaL1Pz6h620
	 CNezuHvHoDyEGpk3i2Tn2PEF7px8/Oe3rFC6U//a5mTNPz18fbwuGyAaU9GXuAxNqn
	 /Ks2K8TfCrYVQ==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6AEHRrRE016766;
	Sun, 15 Nov 2026 01:27:53 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:57 +0800 (CST)
X-Zmail-TransId: 2afb6af89a1d225-561cf
X-Mailer: Zmail v1.0
Message-ID: <202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn
Date: Sun, 15 Nov 2026 01:27:57 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDQvNV0gbnZtZTogZGVjb2RlIHRoZSBGRFAgR2V0IEZlYXR1cmVzIHJlc3VsdCBhcyBhIGR3b3Jk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6AEHRrRE016766
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:27:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A1F.000/4jRh0b3hp4z4xPS1
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_092806_124801_07346B02 
X-CRM114-Status: GOOD (  11.73  )
X-Spam-Score: -4.4 (----)
X-Mailman-Approved-At: Sat, 14 Nov 2026 11:11:54 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_query_fdp_info() passes a struct nvme_fdp_config, which is exactly
four bytes, as the result buffer of nvme_get_features():

	struct nvme_fdp_config fdp;

	ret = nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
				&fdp);
	if (!(fdp.flags & FDPCFG_FDPE))
		return 0;
	ret = nvme_query_fdp_granularity(ctrl, info, fdp.fdpcidx);

nvme_features() stores the result with

	*result = le32_to_cpu(res.u32);

i.e. it writes a CPU-endian dword through the pointer.  On a big-endian
host this puts the flags byte in the fourth byte of the structure, so
fdp.flags is always zero and FDP support is silently disabled, while
fdpcidx would be read from the wrong byte.

Read the result as a u32 and decode the flags and the FDP config index
explicitly, which works on both endiannesses.

Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 under QEMU/TCG (guest s390x, big-endian),
loop transport + file-backed namespace.  The nvmet target needs no FDP
hardware: a TEST-ONLY stub (applied to both kernels) advertises FDPS and
answers the FDP Get Features / configs log / RUHS commands; the only
difference between the two kernels is this patch.  The FDP probe runs
during namespace scan; the verdict is
/sys/block/nvme0n1/queue/max_write_streams (= nr_plids):

  unpatched (big-endian): max_write_streams=0  FDP silently disabled
  patched   (big-endian): max_write_streams=1  FDP registered

On x86 (little-endian) both kernels report max_write_streams=1, i.e. no
regression.

 drivers/nvme/host/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c1..45feafa00325 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2339,8 +2339,8 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	struct nvme_ns_head *head = ns->head;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_fdp_ruh_status *ruhs;
-	struct nvme_fdp_config fdp;
 	struct nvme_command c = {};
+	u32 fdp;
 	size_t size;
 	int i, ret;
 
@@ -2351,10 +2351,10 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		return ret;
 	}
 
-	if (!(fdp.flags & FDPCFG_FDPE))
+	if (!(fdp & FDPCFG_FDPE))
 		return 0;
 
-	ret = nvme_query_fdp_granularity(ctrl, info, fdp.fdpcidx);
+	ret = nvme_query_fdp_granularity(ctrl, info, (fdp >> 8) & 0xff);
 	if (!info->runs)
 		return ret;
 
-- 
2.43.0


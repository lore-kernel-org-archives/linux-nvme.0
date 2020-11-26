Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AEFC63798
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE0E206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sMXPqYhO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="amBfafda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE0E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JfF59PK2LvP3OeJ7rAhzLR5r0RZEG/zNVWGF8zT11Pk=; b=sMXPqYhOqrvCHCjBUGQv5TBRO
	t2X5qayTc4TJpAk8YtDvgcLI3UAceEY7MxZLs9tBtkVfwSLf+UxJGR5Lao89YnNEpr/hPKjYPKqzC
	7WRrly3AhKta24hwYiE8r67utbJGdxlJ2PX10o6gpZVfCAF3IgK0QKhfQjnX/7kLL0/uijVGgqGiY
	y94SuNAYr/L5lSksponvQk4TI+1BmNR+NPSOVDV7vuHaQ/yI7gcUMByUp8nHz9lQZCoZon4vsqv6d
	fk6CgmH0M7tt8iupYGnwebIpNrSP2hinWLbBQ4spDhjPP5mvgzF9BRNSAkY5CjXm7iIxlBM2z0XpG
	NNnK8lHYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki7Ei-0005SH-L1; Thu, 26 Nov 2020 02:42:20 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki7EW-0005Nd-Aq
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 02:42:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606358528; x=1637894528;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5Iw7w/DZLZaDG8VLkQP5pskn7Zl3Ct/yjTxMj+mxhCQ=;
 b=amBfafdajin91UNcvQKzr73OdJeCzh9t/bE6MbmgVGy0G6L1MOC7MpLg
 jRVeiWXmle4kGlf2MHZdnmH3od413pJB5NrP2UGqsulUJDs1qHSJDO4zR
 hphIyB2t+LjId6Q/v/3Wp5Z7kdoR58ZWfxF4UFdDhdhep1grJNrTJLPZr
 EMYuf0Bn6OPNpwiD0dMDBbsAcZRdSyF2Twhw/N+mDMTmpzINXtAZK9f3C
 fPrScLm6zkXecb0IA4ngkyBoFDGNj/o62XIZdZEX8JWylE3rAXV8IixgA
 NFZlBiznE1mbJ3trfTUDVpaf60Y3HD4SO00BBBzp9vL2ruwct1xIIpQtr A==;
IronPort-SDR: l9m8b5sKyKdnvMh8L6X/lGD3hPsCMnB4ma7QCZBX4ij2FRDW/vYl2d6aG0VeiWF/rCQclwllmU
 9/t18KqIEeyZ68jCg2bOQZFuibsL6eGk4QicvOYEvduOumfVJVwKB6ggZwEOSM+8GMtQfnbFPl
 R5AwUk2+7ovaWSeSpo4fYfJ2ROZsd+HWIG6OamQgoiwifhfT2o9MNNL9GwNZfRtxZb1yasl3gb
 oya11W+zK763GnuhagRofayqUQb+4MMJ6t4yOMITJioIvRZXnO5KP3ge4gW80DocBxFtIXowdz
 fhI=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="153445829"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:42:07 +0800
IronPort-SDR: QnqLCbsK/he8M9H8KSlm+CnDzkJ779l7+RLZuSwB4x7rCUZIFFkR/gbUN5Pu8/FHnHM0lIuJrt
 459FcwYGcyx9MUz7Kl0Q0/5nyb0iiOKog=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:26:29 -0800
IronPort-SDR: OT+ipo9IUtxLKQzFh1Yo+PY1jKiSNkSqbQL8MrcRG0FJM8iIsfre24ixAEpDApW2GE+fu8X2+1
 8sVkgdza+FfA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:42:07 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 8/9] nvmet: add zns bdev config support
Date: Wed, 25 Nov 2020 18:40:42 -0800
Message-Id: <20201126024043.3392-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_214208_606521_0398075C 
X-CRM114-Status: GOOD (  12.64  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For zbd based bdev backend we need to override the ns->blksize_shift
with the physical block size instead of using the logical block size
so that SMR drives will not result in an error.

Update the nvmet_bdev_ns_enable() to reflect that.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..f8a500983abd 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -86,6 +86,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
 		nvmet_bdev_ns_enable_integrity(ns);
 
+	if (bdev_is_zoned(ns->bdev) && !nvmet_bdev_zns_config(ns))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

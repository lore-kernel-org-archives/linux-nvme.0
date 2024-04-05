Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85303CD11C2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 05:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XwGUMBIOpDVVqKs7ojfsr5AWwVxWVDs6Nc6U5w8TgKw=; b=wmcIgCIbK+fgkMnv19LEW38iPd
	1LfD+qUbNxDRZTnzY6VG6wD0OlEsOw0cIwGdpRSRr6sdFF2eS/5qo6Hoqjo9Ar9ncninoWRB865rw
	JjZYUiNqAi4mK4RvVQmGsnMERW5mDw6LvfqAxTfgSqtku6x0HDeA7IkXSLyD4Owq0teNTbSpXRySB
	XRyIaEh4SkNYHjNOwfTPCZrGeVuXT6xyOmkD5Ek1iT8HBsffN3AbwP8wLTwhBdB52gMTgoSlXAaTI
	Clyc++7OVFYaCOdGLCeVvsj4z+S202lCq83UYsNt2sFairMTmYQkPkEBFOpTwXYXv+2dfCZE3XKAM
	C/xjKL5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscSj-00000005LaJ-0KKI;
	Fri, 05 Apr 2024 05:50:05 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPe-00000005BBs-0SEc
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:43:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 93C07CE3615;
	Fri,  5 Apr 2024 04:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4B8C43394;
	Fri,  5 Apr 2024 04:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292169;
	bh=Xc+57Y8lhUKrfxnA8kI7YV8+a6Tg3KWZjsI74h+yUyE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mGUyynG9Mo3HkZ9XmAgQqZhz83//ZBydmHrnyxkUagSWojfZkODGyEju2rWatBHRw
	 jvB56KCnBY4GezSGy1SGzOPlt9+XHbBl2i87ARFogqSJ5Om9A4FWTwCBUM7+f4um/D
	 qfyzHjmSDIzaZkkK+SX9/XjNX9xCpIsuf0jj6MNJU8NyoeQM1owS7kO+Cmv7IS9DT2
	 isqLqAcT+hkzJwZC06Jbxhnl2hjfRDr3M4+4mbhA6cYzwi/KCIqYW8irKN2OCjRzyo
	 XTwVCeJzoMBokTu7RFiBHKy1OMuJTOQJGMx0zb5vDA5lHJVxUY7PW2BEiM2gsdtZ9p
	 5DACRfU7nSwtg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 27/28] block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
Date: Fri,  5 Apr 2024 13:42:06 +0900
Message-ID: <20240405044207.1123462-28-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214250_890837_A45B8AA4 
X-CRM114-Status: GOOD (  10.40  )
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

Now that zone block device write ordering control does not depend
anymore on mq-deadline and zone write locking, there is no need to force
select the mq-deadline scheduler when CONFIG_BLK_DEV_ZONED is enabled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 9f647149fbee..d47398ae9824 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -100,7 +100,6 @@ config BLK_DEV_WRITE_MOUNTED
 
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
-	select MQ_IOSCHED_DEADLINE
 	help
 	Block layer zoned block device support. This option enables
 	support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
-- 
2.44.0



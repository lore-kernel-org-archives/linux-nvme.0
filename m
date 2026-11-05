Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E581606A32C
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tWO8VLD0;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NPstuyXM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T1o5UTfe4UjNf49g5ls7TMMNr/+HIOPH/BnI3ElGqoc=; b=tWO8VLD07hgK12
	TuQ4+kqFvvIpl18+oWeQ6EdbmWXFaRkjx77XDnbmiI5tZHSIeeWBgbCr4vSX9vxXo6+odz+oEHKGt
	R1zaEeCmTZoesjDBtBJonB07pTGZutpTGapflmyuDqT9sCW7KOwsDN3YybIC+fNIcxzeY/id/mZvL
	bix+Uqsrg6g1onj9dODExf9oc7zVQDRIATRDPP6efb3Yy2QxmqGdiG8FdoK3kzVoRUbnqRW3+S7Mk
	f3L/l0eYv1CsnLd/Q0muvKNRDqCKECGH434WFczxsfMVCfx6t+dcjI68Fwqev9nv4H/KNXlr/UR80
	y6FF0FAk28sJa3Gd5+xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwY-00000007XRd-1yVr;
	Thu, 05 Nov 2026 02:11:10 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwT-00000007XM1-0apG
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 02:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793844663; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=T1o5UTfe4UjNf49g5ls7TMMNr/+HIOPH/BnI3ElGqoc=;
	b=NPstuyXM2Wbq01oeU1pN8EDOKsX6WXRpS0FeyY9AVLIdQ3g7mHWjLkWaBUtdRoJnj88hK6ijEj64Y2o+umqVGfad7M3Gc6Im3IJzb/QMMrx+VSCsf+KSNgPcELHPYdcoO6QBhUzgMde4vKu3zJg74SSBz1x8woayqTBDp5V+Q8A=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XE770cS_1793844661;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XE770cS_1793844661 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 10:11:02 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/9] nvme-fabrics: remove dead hostnqn already-assigned check
Date: Thu,  5 Nov 2026 10:10:46 +0800
Message-ID: <20261105021051.1667222-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261105021051.1667222-1-kanie@linux.alibaba.com>
References: <20261105021051.1667222-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_181105_337379_1F5FC77A 
X-CRM114-Status: UNSURE (   9.24  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The opts->host check in the NVMF_OPT_HOSTNQN handler can never fire:
options are parsed into a freshly allocated struct, and opts->host is
only assigned after the parsing loop completes. A duplicate hostnqn
option is already silently overridden by the strscpy() into the local
buffer. Remove the dead check.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/fabrics.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3d7ad86c1955..c262538523fb 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -872,12 +872,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->fast_io_fail_tmo = token;
 			break;
 		case NVMF_OPT_HOSTNQN:
-			if (opts->host) {
-				pr_err("hostnqn already user-assigned: %s\n",
-				       opts->host->nqn);
-				ret = -EADDRINUSE;
-				goto out;
-			}
 			p = match_strdup(args);
 			if (!p) {
 				ret = -ENOMEM;
-- 
2.43.7



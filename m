Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568EE606A328
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Nm2vyren;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QwGkRYwS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T1o5UTfe4UjNf49g5ls7TMMNr/+HIOPH/BnI3ElGqoc=; b=Nm2vyrenp0jLg4
	eNv5ZxGPNlDyQIWF3GqPezXF2VQbUR0ghSAubKni+Z8MW9WBW2Xn59TYq730QkoiXMlRpewingcq6
	y1exWmHBQCHUfWDfzAxYZ44UD7TQCZengJzqEJbc6zl/QtWhfIY0to7ieUp2dMxRI3UsEhzSMuf+3
	QOnul0PDhYvdIf5myD/rhw08/tTOB6IqeEX0eiaWd1tWx+En8UJcMHgdCi3VvCsvveFH+UQvGBM5Y
	VdSZMsDb/EJW81zb1wsruSIgThRCam+QfUMuqLqLGekzveFIOugq9xHpjSlkfZsREpA+vc2tzetNL
	G/Ni84zQX6ugZ3UBDjvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gE-0000000B3yA-4AbH;
	Fri, 06 Nov 2026 02:27:50 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gC-0000000B3ug-06rs
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793932066; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=T1o5UTfe4UjNf49g5ls7TMMNr/+HIOPH/BnI3ElGqoc=;
	b=QwGkRYwSH0GTLHn/GtXH3ffn0vX9O5q86hPxdVjJKPj4Pxn3vCFWbaKm/tL9pHVWVgCV3gObDFGdj1hrF5ffdS6LM43LqA7Ccc7MhKZo20h7tAVWgV5bZAVnDeeB15G01vyfPLH/fLZM/SJvMMNZjtG1Ig8Js5/nDdyxG14b2l0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA2NtH_1793932064;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA2NtH_1793932064 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:27:45 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 4/9] nvme-fabrics: remove dead hostnqn already-assigned check
Date: Fri,  6 Nov 2026 10:27:31 +0800
Message-ID: <20261106022736.3582824-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_182748_221021_8892B096 
X-CRM114-Status: UNSURE (   9.30  )
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



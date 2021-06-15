Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9835C48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:31:40 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833B760BBB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833B760BBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wybihjSiF1CSdjOkKRkCMWo99BAqLSbgd0nrQaHVa0c=; b=vV/kXUxMJTFk91
	ocqptMNKnXiNXI899eA5mR7OdmPKN9bsp7B+8282KfTkr4K2AY8Xf1yZ4er434AzxIdu0MWmwqhxF
	bHh4jOaX9Oe+lGm0MqBgtTXgWH/wt09TolZQOlqDhc627rNQXVsFwO8iI4CDt8XbKVY0rE64oxMyg
	0KHPCjAelg0TWMmze9Q3NpA9lhKOznJYKq7hgvTfQSZ5bxZXWDMcr5A9b0oas9dEAQtRnPzkHIRFJ
	xjxtvX4PwECRAcUWjg9xboNtGBii8UpW6/ZqTzm1aBiAsnfOI9PgukPc5Bd7uz9ijtEZqWb47Tum2
	Kzhd8HoFBwIuvcENzGQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltA5l-000bgC-MP; Tue, 15 Jun 2021 14:31:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9Lm-000FmL-R3
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:43:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=zmrviQMw+JlPdB4kdVftou4OSnT6/3UW41m9IYLR5zc=; b=HHWcpVUgybsgwyZf3vYZ4pDRo3
 y8sJAE2WnqN3VIQKEfdevA8GjOs4XihI/lVEAyDHzgbn1QVWDDMwA49w4rljFpkjJv0/N9YeSY1Re
 e4FGWNm2GjWUZU1Cie+Ns61iNuw6pOgb3K97CBQKwE16w0EgED/0VQQq+I1171FhkSzpGsyKC+xoh
 7DSuiu6NrP+Dvq6oXC5ziXL/BU3nFthgNEfircN1iqU+554+oOWjF/zEKXF9LLOjxH+Y4dBroqHCO
 fWDQ2mit2W3Si25+ZCnRzSPHvsJXs87wrPaMo+gUH0SVHD+5/L0Rx7Z3pKc2Pae53wNP8gKTbMTtb
 rYpzNlUw==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt8tC-006nOY-DJ; Tue, 15 Jun 2021 13:14:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/16] block: define 'struct bvec_iter' as packed
Date: Tue, 15 Jun 2021 15:10:30 +0200
Message-Id: <20210615131034.752623-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

From: Ming Lei <ming.lei@redhat.com>

'struct bvec_iter' is embedded into 'struct bio', define it as packed
so that we can get one extra 4bytes for other uses without expanding
bio.

'struct bvec_iter' is often allocated on stack, so making it packed
doesn't affect performance. Also I have run io_uring on both
nvme/null_blk, and not observe performance effect in this way.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 include/linux/bvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..a0c4f41dfc83 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -43,7 +43,7 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
-};
+} __packed;
 
 struct bvec_iter_all {
 	struct bio_vec	bv;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

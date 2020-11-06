Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF82C5517A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:02:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1392C22242
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IHN5MPZG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="soNcve2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1392C22242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EC/YJXZxyvq9tkIkhbGkiORAklxt1Ngwfv08bdIiWR0=; b=IHN5MPZG4ZB8OGErIK/wqgy+4
	wpWvLAaWcc6NVLCGSW512mLr4VVuf+KSNyXQZk0EKTLQQP6Naez4BEl2gckgAjpbZ4tLDV0+8PvZa
	7FeXzSXeanIoKb7prSIn3wWTuLShTJlp7y63TYXD0ZQ3J4Zu8erKgnYSeb4EK+H9+HadAl3dJNS10
	/htcy5yfdCt6udPoWbDfZ6DcvsaZzdm5hqX0noR0Bvlk9Si3M/uHpc9/gMPhzeRhw0RsdENfZoGOh
	BT7c5ce30qRnim7PWxlZTj46oSNAUUBkQNVMBeYAKz1andJec2h+EwR/05H3luWT4LiSbMQAB2+aC
	8l8/YwHMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb57Y-0001HY-7Z; Fri, 06 Nov 2020 17:01:52 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb56e-0000rp-ME
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:00:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zgGEpEC881xygcChLUzP5MM+TPIgCL+RooeJy/MEFvk=; b=soNcve2wKJLNlkdIcwhFKrP00x
 UXFJJhudsSkX2SoBn5CzMojAj0uyR2/WZqlCmQ/roDA/tjn6xVSzQu+640oHm0jxA9uJO+KPDZB2G
 Oq2rKjg3PcmQ6QJuv02gmSnlDR6+W0FJ6I7CDF1vKR8DUcOpumtVWqKYU3Q/xYP3DNgg/KR7V8uUp
 Sjtqu2gdb19JzmLSGzPhptvO846Ick13R0oTl58IwEn9Oipv/GhF9Np9hw63jsKDkQlT4dpJYLiPQ
 3KZ01uvW3ys592KHNx+H/xFfQw/zHmxKjSRmJL0sZrzTcbmwZJDE7aGagChRGvl6uO9r0hehlSsVR
 mhF6EdYw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56Z-0002Pa-5l; Fri, 06 Nov 2020 10:00:52 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56U-0004sz-Hw; Fri, 06 Nov 2020 10:00:46 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:25 -0700
Message-Id: <20201106170036.18713-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com,
 iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_120056_895473_83C2C03B 
X-CRM114-Status: GOOD (  12.78  )
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
Cc: John Hubbard <jhubbard@nvidia.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Don Dutile <ddutile@redhat.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We make use of the top bit of the dma_length to indicate a P2PDMA
segment. Code that uses this will need to use sg_dma_p2pdma_len() to
get the length and ensure no lengths exceed 2GB.

An sg_dma_is_p2pdma() helper is included to check if a particular
segment is p2pdma().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/scatterlist.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 36c47e7e66a2..e738159d56f9 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -39,6 +39,10 @@ struct scatterlist {
 #define sg_dma_len(sg)		((sg)->length)
 #endif
 
+#define SG_P2PDMA_FLAG	(1U << 31)
+#define sg_dma_p2pdma_len(sg)	(sg_dma_len(sg) & ~SG_P2PDMA_FLAG)
+#define sg_dma_is_p2pdma(sg)	(sg_dma_len(sg) & SG_P2PDMA_FLAG)
+
 struct sg_table {
 	struct scatterlist *sgl;	/* the list */
 	unsigned int nents;		/* number of mapped entries */
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

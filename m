Return-Path: <SRS0=NJ67=AU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE6C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2020 23:40:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BA020672
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2020 23:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JbosIDUz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JQ1QeUQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BA020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RDR1DHXVjIvhPzUqaqBFG5s4N0vshgiuQ9Ifg3jGCLs=; b=JbosIDUz9DBltTwNl3Nvump4H
	wdcDwvVFUrcRbqBP1n1RDLt6nIN2fi3a0VsDptKorWfjvfEZ/oCxZpiB9fjk+BmJJT05AQgmYpO8O
	QkG1xKJyBI2agS9XnvMMMoNFPWtyKNtSSdsdOUpbWkNA6ZkvaCMSUiV+IlINkHTdcGqct66Gfhz/2
	B7tVBHyONzZaoSMovYOFugjUfYGHw7v96Vx7cPk7YKhX4xhdiAnNrTpyR34VLsStrvwiM4qS5MWoL
	PytyuxYSmwT010rhvudf6lHGyguAjXfn/w8MPpNYo+ZJLm4o+3izV2zy08Yze0NML6apxlLEF2DaT
	4ITc/XYdQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtg9b-0003lE-1u; Thu, 09 Jul 2020 23:40:35 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtg9Y-0003kS-Iz
 for linux-nvme@lists.infradead.org; Thu, 09 Jul 2020 23:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594338042; x=1625874042;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qV7EbN58ccGO+dHlecsUYhELzf0x9mQna5RWCMyQ0zE=;
 b=JQ1QeUQTztsALzMc/vyfRFDM1y49pK7rNjTLbUA/5/ByZSiJTehlnvwn
 3DyMs5P/Venk3GlQ4vN96VzSUUVEpaQtrPS2+F0bQ2knH7GqAWq6/IVv2
 i18EqW3S++N26jDHJzGK5SiXKRFehaPBJl0u/Zy3bFS6JdayrX1FMYQtr
 vGag/jHkM60oLgPuDwDZfH8koldAxLdtCIjwXRn8FFUzdeb0LTS8NM1NB
 2aeojPWL0OREsHzxZADZOd9oglqFlCjOjlGYjGNVGKsH9J3EAr+zg8tls
 QVw4BPnhT8CeqmR0cchf29F6EohyUHj2NZiqevMfqKrVlHBgn2H6VE8Ql g==;
IronPort-SDR: K1YKouZn1FKLD3atxcPROUkP6UMBCKwOe284t2FcAOqMrTVM43aNpGxAi+WUHqIONesUXiCR+W
 gf/bNGC9lcFNlM6CruzNZ1m2mGM+faY7WpVLO15S7REgxWUuVy73TJI/r0wasWb8Z886iOqIgR
 kAzxULq/bNbnJlFvxjHeHy7cK4CnAPKwkXOQXhqFDlhAoIp6n45avYfWrxJySwHWj9wy+Vo9q9
 eQKnEz50JI6ZqVBx+IitF2ppm8TogRyIsPaz2N7OgU87Gw52IAYS2bQADOK56Xqi4gYhlytVAv
 PH8=
X-IronPort-AV: E=Sophos;i="5.75,332,1589212800"; 
 d="scan'208,223";a="245096145"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2020 07:40:35 +0800
IronPort-SDR: 7G4tBgqbTmbq9lzgMYNZ0OcZ5lDbljruAbrFIwVyIVNOvCVebiRUzdw5IRAlFNoU7FQxSJvAsr
 bz31PPSIooq3G95I17/aTLnU5IJJFjJzk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 16:28:30 -0700
IronPort-SDR: rmCxVKLMRiEvF2gmGP+j6vr5BomVC66peHm1mWXQeWWBlythK30P6W8hurwONaTpIEY6CbEA2F
 jfJhSAM4FljQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2020 16:40:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH V2 2/2] nvme-pci: use max of PRP or SGL for iod size
Date: Thu,  9 Jul 2020 16:40:25 -0700
Message-Id: <20200709234025.10673-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
References: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200709_194032_781668_EA018988 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From the initial implementation of NVMe SGL kernel support
commit a7a7cbe353a5 ("nvme-pci: add SGL support") with addition of the
commit 943e942e6266 ("nvme-pci: limit max IO size and segments to avoid
high order allocations") now there is only caller left for
nvme_pci_iod_alloc_size() which statically passes true for last
parameter that calculates allocation size based on SGL since we need
size of biggest command supported for mempool allocation.

This patch modifies the helper functions nvme_pci_iod_alloc_size() such
that it is now uses maximum of PRP and SGL size for iod allocation size
calculation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 68f7c090cf51..8b6792005360 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -363,14 +363,13 @@ static int nvme_pci_npages_sgl(unsigned int num_seg)
 }
 
 static size_t nvme_pci_iod_alloc_size(struct nvme_dev *dev,
-		unsigned int size, unsigned int nseg, bool use_sgl)
+		unsigned int size, unsigned int nseg)
 {
-	size_t alloc_size;
+	size_t npages_sgl = nvme_pci_npages_sgl(nseg);
+	size_t npages = nvme_npages(size, dev);
+	size_t alloc_size = sizeof(__le64 *);
 
-	if (use_sgl)
-		alloc_size = sizeof(__le64 *) * nvme_pci_npages_sgl(nseg);
-	else
-		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
+	alloc_size *= max_t(size_t, npages_sgl, npages);
 
 	return alloc_size + sizeof(struct scatterlist) * nseg;
 }
@@ -2812,7 +2811,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * command we support.
 	 */
 	alloc_size = nvme_pci_iod_alloc_size(dev, NVME_MAX_KB_SZ,
-						NVME_MAX_SEGS, true);
+						NVME_MAX_SEGS);
 	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
 
 	dev->iod_mempool = mempool_create_node(1, mempool_kmalloc,
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

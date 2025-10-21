Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D10ACCD184
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLV9Gtx5uK2SMsvwBzs64/ozwQoabLelFppdG4GTYWk=; b=c5MdBPJR5JYYsvjJBXfdlM9bxE
	RRgDVjFiYwOP1HOIuzdK0pHCDlhcsgOivPw8g3xKyZIJnI6xe15zMLkKSeV6wiB4+eqA5bdliddpM
	fsD//BouOp3TpCym4W71wTeKKk4Yyj2rRqAEQinQEaBW7OgtC/u7p6lBOuhmiy1/rCkaWoeh0vQuu
	t0eoSAWwgTOkD8ey5JrlQcT6wkk6cHOSPyPXRbsfh8GRs43olQqtNnLm5ivDD6Od9Lbu/BSFgSf1D
	y1EMqTko+kGGGZtaidT9+jZ9fp/iRQ1qi+hxfMClvwwrFJdtDE9lbgTUZij5u0GgWglLy4Kp+V6fb
	oCxXwkVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBEOy-0000000HXsV-1mKz;
	Tue, 21 Oct 2025 15:35:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBEOx-0000000HXs4-0t9w
	for linux-nvme@bombadil.infradead.org;
	Tue, 21 Oct 2025 15:35:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GLV9Gtx5uK2SMsvwBzs64/ozwQoabLelFppdG4GTYWk=; b=Wg1hPMsN6t18TS3oqN87rWNuxr
	g+X1BrXOQorFHeFdl4tyjjvUk7bhGnfiKhyJweNnGxAAIW35caZV6cHvnvm9X749Gxy87xwmUQCh+
	sY9uxaekV7+o9vlqllzy0pBxZLXHXKLOUyj9C0YMb3vRycPC3MKDDSDKPRECPxcdvOePv2idE1ksK
	cc0qS2nZDZG09ea5MKjuFpfyvUetsTWY7A0YyPSmXhYNXOpeabtMYY6/qF0+N1gejK9OVi9V4due6
	4w3HqKOZ0FpHfprFvdLc7yxOMEguDkko+14SUwN54vNOJZgVMJnQzPE8j75XSCFYs0V1G7pRMx4nS
	NGgVCIpg==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBDX2-00000000pL5-3gOi
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 14:40:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B7C4227A87; Tue, 21 Oct 2025 09:19:35 +0200 (CEST)
Date: Tue, 21 Oct 2025 09:19:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] nvme-pci: always use blk_map_iter for metadata
Message-ID: <20251021071935.GA31479@lst.de>
References: <20251020182444.2587155-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020182444.2587155-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_154013_967064_02D9DDC4 
X-CRM114-Status: GOOD (  17.30  )
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

On Mon, Oct 20, 2025 at 11:24:44AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The dma_map_bvec helper doesn't work for p2p data. Rather than special
> case it, just use the same mapping logic so that the driver doesn't need
> to consider memory types.

We already consider the memory types for the data path, so treating the
metadasta path where p2p is even more unlikely sounds like the wrong
tradeoff.  If we have a single segment we just need a single
is_pci_p2pdma_page check to skip direct mapping path.  Something like
this untested patch:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f0..c8cfcc64d5ca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1042,7 +1042,7 @@ static blk_status_t nvme_map_data(struct request *req)
 	return nvme_pci_setup_data_prp(req, &iter);
 }
 
-static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
+static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	unsigned int entries = req->nr_integrity_segments;
@@ -1073,7 +1073,9 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
 	 * mechanism to catch any misunderstandings between the application and
 	 * device.
 	 */
-	if (entries == 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD)) {
+	if (entries == 1 &&
+	    !(nvme_req(req)->flags & NVME_REQ_USERCMD) &&
+	    nvme_ctrl_meta_sgl_supported(&dev->ctrl)) {
 		iod->cmd.common.metadata = cpu_to_le64(iter.addr);
 		iod->meta_total_len = iter.len;
 		iod->meta_dma = iter.addr;
@@ -1125,10 +1127,12 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct request *req)
 static blk_status_t nvme_map_metadata(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio_vec bv = req_bvec(req);
 
-	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
-	    nvme_pci_metadata_use_sgls(req))
-		return nvme_pci_setup_meta_sgls(req);
+	if (((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
+	     nvme_pci_metadata_use_sgls(req)) ||
+	    is_pci_p2pdma_page(bv.bv_page))
+		return nvme_pci_setup_meta_iter(req);
 	return nvme_pci_setup_meta_mptr(req);
 }
 


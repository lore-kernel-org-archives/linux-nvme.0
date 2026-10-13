Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CA3CC6B0F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQTiv8sNvjBDuE64wUVMIgKUGqNy6c5d7UDuD9XA1VQ=; b=WJeFhr7uFi0Di6dbZIKy4KxEm9
	AVk06xQMfcbx4c442CSM/SrIw1Lz6bGLIryoS2ngA1M+4dk5PX1582P7nd57P1ex7oQhUhWVCqnx4
	Nwtem5AyiKtpdxVVaYdoNEGbqxuhoWP+s/vjP8SCIoH4sSVmRxEk11JP8OGtvBEbmnDrSFvLGFyHA
	TtqAD+2iv8HO4Jww3v2ZQxCOGkNRLWJD/1IR2SNp2vMRj3BaEt1ts8dcbXvhW9wLGVS8cGgDIzT7q
	0X4WtzEFfANblg6lNfoZDipsEnv+TFiZgxkRZWGI0AT75XO+3iBA3w+q6OlwWbb+6I27QEJP61SKu
	9D+NES3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdLU-0000000D4F1-36pA;
	Tue, 13 Oct 2026 14:19:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdLR-0000000D4Ee-2EXd
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:19:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D063227A88; Tue, 13 Oct 2026 16:19:05 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:19:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart2021@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: bound the FCP command data length before
 allocating buffers
Message-ID: <20261013141904.GA14323@lst.de>
References: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_071909_720229_2064BAFD 
X-CRM114-Status: GOOD (  17.17  )
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

On Tue, Oct 13, 2026 at 07:40:38PM +0900, Yehyeong Lee wrote:
> nvmet_fc_handle_fcp_rqst() takes the data length straight from the FCP
> command IU (cmdiu->data_len, a 32-bit value from the wire) into
> fod->req.transfer_len and calls nvmet_fc_alloc_tgt_pgs(), which hands it to
> sgl_alloc() with no upper bound.  nvmet_req_init() only parses the command
> and clears transfer_len; nvmet_check_transfer_len(), the only other place
> the length is checked, runs later from req->execute(), after the allocation
> has already happened.
> 
> A remote, effectively unauthenticated host can therefore declare a huge
> transfer length and make the target allocate that much kernel memory for a
> command that never delivers the data.  nvmet-tcp bounds the equivalent
> length and the rdma transport is limited by its 24-bit SGL length field;
> the fc transport had no such limit.
> 
> Reject a command whose data length exceeds NVMET_FC_MAX_XFR_LENGTH before
> allocating anything.  The ceiling is 16 MiB, the largest transfer any
> in-tree fc LLDD can describe (lpfc maps up to LPFC_MAX_SG_SEG_CNT 4096
> segments, qla2xxx 1024), so no in-tree configuration is rejected.
> 
> A command declaring 4 GiB reaches sgl_alloc() unbounded before this change;
> afterwards a length above 16 MiB is failed with SGL_INVALID_DATA before any
> allocation is attempted.

The bounds check is obviously a good idea, but we really need to tell
the host about it using MDTS, don't we?



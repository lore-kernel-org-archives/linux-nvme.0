Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED87CCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 08:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9z8knp6XglMpVN4kwNt5Kwx3LeN3VRytjL2d3j6CX3U=; b=vsWM6kKR6DV6mxEZRwAfTsbuxJ
	DoyItD+yTILJGdjuXvtDAVMRzVtR0h1Y1OPo3ggyM/pWSKd9oJx4BpsjlpULlrxwGyFgnUCt3EKqf
	uAsygl9LlRici1dw5obzLXP+Nnc9zneeqkCiDKn8WfD2tDGFfnswzLYf7kHtjc0lreG+964NzlQry
	gyeHOgqGJmeTanWpeQMU80xCFiX/SllrAhVIY1vel9I/zcgezdG22PGjoE/BI89sQncVVs0FIgrHX
	RX7afELB2h9I1/PaMhIaD2AyiuS7Q5oOUboUYtoTe8ULlvDF0F2eiPXOpk8/s93gPuHgh2HM2mGEw
	MA3hSkQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1u4-00000000NMh-3idd;
	Wed, 29 Oct 2025 08:51:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1u2-00000000NMK-0wfh
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 08:51:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2108227A88; Wed, 29 Oct 2025 09:51:27 +0100 (CET)
Date: Wed, 29 Oct 2025 09:51:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
Message-ID: <20251029085127.GA32307@lst.de>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org> <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_015134_409697_E5B76A1C 
X-CRM114-Status: GOOD (  14.00  )
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

On Tue, Oct 28, 2025 at 04:26:20PM +0100, Daniel Wagner wrote:
> nvme_fc_ctrl_put can acquire the rport lock when freeing the
> ctrl object:
> 
> nvme_fc_ctrl_put
>   nvme_fc_ctrl_free
>     spin_lock_irqsave(rport->lock)
> 
> Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



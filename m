Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B5C83F1D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMjRaeyYyMiW4lgkC0agJmfkBl0v4/vUo6ENpW1qnZk=; b=MKd84GcSfdW6XBi9d4U0Ug3fX8
	q6CBghCNBNcDZCflO4IucBIxm3D09TJXIk7YOo3/Ya0rVLgXFbuHu9Wck1dIoCyzEIuqIwINXrVio
	chBqaUBDLHfDXq2wVhA58CQoLGKPcgiiyjC5NoF9B/Lgd1z8Uo04pP0y4fZ8BCrUwX9YXAAs/Cjiv
	XYQyefdTQugbMMk7Ql0IbpWMiD1ukA3o0KAwTAzDXuj/mha27M6zPojQNM3l+6xyVga9FbdWsOlbN
	mGGfvouifVbdgUrCeTGBTBImNYbb5iFnhsZVI2tGrAEOWPEj0fzBQ4wdykl0Cnzt7Qroh1AwGd5Xh
	pIV4gdLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubaSK-00000004P7z-0xzN;
	Tue, 15 Jul 2025 07:52:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubaQD-00000004Oml-19H9
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 07:49:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F006068B05; Tue, 15 Jul 2025 09:49:49 +0200 (CEST)
Date: Tue, 15 Jul 2025 09:49:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"yi.zhang@redhat.com" <yi.zhang@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: revert the cross-controller atomic write size
 validation
Message-ID: <20250715074949.GB20468@lst.de>
References: <20250714144406.1692041-1-hch@lst.de> <20250714144406.1692041-2-hch@lst.de> <f927a6d5-16c5-4a21-bdc1-22f5d5d09933@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f927a6d5-16c5-4a21-bdc1-22f5d5d09933@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_004953_451226_34D5C831 
X-CRM114-Status: GOOD (  10.60  )
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

On Mon, Jul 14, 2025 at 08:43:52PM +0000, Chaitanya Kulkarni wrote:
> s/This drop/This drops ?
> s/revers/reverts ?

Thanks,

I've fixed these up.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E08CE8E94
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xcFEPAu7Dm7XKGg1spso25JgWqnV5UedNBR1oir2uUo=; b=MfXzY3hoLdtLEWlFY/N8EUF0kv
	CDVmA+1reRAVtv2V2x9/9D0yOzZmlugaRJ97UtpN8IcA2nAtS6nQHLZpS2BLEZRd06oBEJIjMvSTM
	gdaqY9lF5kkl+DCkErDE9UbwPdLIXcifo6nPnVWCiW8uoFIOVse/KDnFPylk4ayKTUc12KvgALMMM
	BCXgF2ZTcRiXn5Rex0er5/YJx6Uo4uClBBCm8gYCopaOoODNH6urtp/+zt+MVmLYVrufB53kMR+uc
	tHIcBwr5xNJTXv+bcRrSZmL4gPC43V755tQhik6ls0yICFI/g1n9LEFtuHJtgjwq97GDgcnRmTGYT
	lwPd72AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t40yP-0000000191I-1AE8;
	Thu, 24 Oct 2024 16:46:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3zrE-00000000vmB-0CaN
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 15:34:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A8164227A88; Thu, 24 Oct 2024 17:34:31 +0200 (CEST)
Date: Thu, 24 Oct 2024 17:34:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, martin.petersen@oracle.com,
	joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCHv2] nvme: module parameter to disable pi with offsets
Message-ID: <20241024153431.GA10173@lst.de>
References: <20241024152702.2998364-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024152702.2998364-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_083440_266150_AF776484 
X-CRM114-Status: UNSURE (   9.82  )
X-CRM114-Notice: Please train this message.
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

On Thu, Oct 24, 2024 at 08:27:02AM -0700, Keith Busch wrote:
> +static bool disable_pi = false;
> +module_param(disable_pi, bool, 0444);
> +MODULE_PARM_DESC(disable_pi, "disable protection information if it has an offset");
> +

The variable and module paramter are a bit misnamed now.  Also please
add a comment explaining why we have this seemingly odd flag.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B47EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 12:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85ogDHtj26QaBPP5DyHbb7WABYmcBXxvQ9ryBAXXtaY=; b=vYZ0k6F8enjSI8qoLfllkjpgBf
	I0e/VYfzryQkOPpGS33QZR8gyabOvhLhVgVk/c6rRIw2gfvCKs9fjctsZEV3P66oVlaj7FOx6UH3T
	FmDvye9hYGsraKWMWmQumLPNrfBSO3kzq84gbDDIXVNDD08zZKokU3qehgZqeU++3EiGg2UTwfxev
	0Gwp6cC+LYwKOXXQOuM3bdGJ+Mfct7hB6jqQ/oD+LMO7ieptGpq/RbanjD5ee+O81LoXmzdaDnjxU
	zyQVerOR/QsfFEepEmcmn1vDRcvP+GRVJzqhIHeFhcfUrXrc/xvPkEfTlEkTGPog5hQDZPBBYvjbP
	le69eoWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp8sl-00GWbh-0I; Mon, 22 Nov 2021 12:57:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp8my-00GTpd-QD
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 12:51:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 756D368AFE; Mon, 22 Nov 2021 13:51:09 +0100 (CET)
Date: Mon, 22 Nov 2021 13:51:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kch@nvidia.com,
 linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCH] nvmet: use IOCB_NOWAIT only if the filesystem supports it.
Message-ID: <20211122125109.GA32499@lst.de>
References: <20211122100827.290117-1-mlombard@redhat.com>
 <38d3f20d-36e3-c813-e00e-92e1bfb3e27c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d3f20d-36e3-c813-e00e-92e1bfb3e27c@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_045117_037457_DD1AC41F 
X-CRM114-Status: GOOD (  12.37  )
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

On Mon, Nov 22, 2021 at 12:21:46PM +0200, Sagi Grimberg wrote:
> I'd suggest to fix the alignment if we are touching this.
>    		if (likely(!req->f.mpool_alloc) &&
> 		    req->ns->file->f_mode & FMODE_NOWAIT &&
>  		    nvmet_file_execute_io(req, IOCB_NOWAIT))

I had the same though and wil fix this up when applying the patch.


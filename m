Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16BEC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 06:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r7lhShmNigto730TKjaoQuWxV9GpkGOm1l1wMHl46XM=; b=sEgWIA3bF9s6YJJ4gavBhd/YXb
	XIiiZmSRY/t5jrlEAF5nFg9yqk0DFXxnIkB3lp7rvfri4MoVLsgl/axFpHpAlH91YHTlDXOIxa8nv
	vRkHK2QS+i0BpinShX4qa3k6v9AukjPX+WrzCajtM81cEMCcZ8B0oGf8conqoLRa0qfLx6TZfSvqh
	RPMitdqlSWgsB9Nzz3soOxJO+bixVJpfdcpr+VhqzI0vpzXCHMEwhCFSE4lSkMnOr5tCUvL+AUNFd
	2k65fk3IfFaM9lQpMgyJBd7wY4QMKRuWFC3FDUMk9kDCKM48bs9c3ar61fQg7oCQtYmY3PzM8RTTu
	fNwJAnnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvA7x-0000000FWKC-1kQM;
	Fri, 12 Apr 2024 06:11:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvA7u-0000000FWIg-1Zqv
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 06:11:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9B52068C7B; Fri, 12 Apr 2024 08:10:56 +0200 (CEST)
Date: Fri, 12 Apr 2024 08:10:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Is idenditfy ctrl cmd supposed to return a 'result' for RDMA?
Message-ID: <20240412061056.GA32319@lst.de>
References: <pdazbshqj2kqkhtmdp4m4qtaqexu7bfio2ccampteskuugqmkf@srgzsimaj3bn> <gzutb6z3rv377tazt3evxetc3w3uggw7gx52p3edoiubzgry6j@hcfmkjj3iodp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gzutb6z3rv377tazt3evxetc3w3uggw7gx52p3edoiubzgry6j@hcfmkjj3iodp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_231106_582196_38AD1130 
X-CRM114-Status: GOOD (  21.31  )
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

On Thu, Apr 11, 2024 at 09:24:20PM +0200, Daniel Wagner wrote:
> On Thu, Apr 11, 2024 at 12:51:40PM +0200, Daniel Wagner wrote:
> > but got a bit lost in the RDMA code. So I am not sure, is this supposed to
> > happen?
> 
> After reading up in the spec, it doesn't seem so. After adding

I don't think anything requires reserved fields to be cleared, at least
I can't find anything in the spec.

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index f5b7054a4a05..a297020f4bea 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -486,6 +486,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> 
>         kfree(id);
>  out:
> +       req->cqe->result.u64 = 0;
>         nvmet_req_complete(req, status);
>  }
> 
> 
> the problem goes away. I've also noticed that many other commands return
> a lot of 'funky' results as well. I haven't understood why setting
> the result explicitly to 0 is necessary for RDMA yet.

that being said I'm fine with clearing the CQE, but can we find a way
to do this in common code?


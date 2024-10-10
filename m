Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B18CF07BF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xb7CpvzmCpGxlp18+AK6r/HFPehp5XgOHICXJfftHkc=; b=PED+QXEqaCC7XuXiTMnXs7TtmV
	nYFkI+IhldvBOHAB8UdRc9+LyuKM56toVCKyBNSiQiI+PQ0k0dcStHv+9FpKs1hyLUFTliefquPvc
	x458DBzBEAoQptc6HAnT/pb7ce9cmNxTfhNbGwF3V1ljm3KzFFWfXSQ6ECYyz0FJemWwJ7FCY9Em1
	BWGOjy+oTNuDGuPc5xzfuHvQ5iek+23tDL45Pd0Ba5oy53nPHBhNaYw/bsul0IIPRLNuKQU/j/VXe
	h4oPzLPVibhJRXFDG4XcHdf+MbRTAr+z5Fvvm5xDyJmXqVpZyl5idbV6WAvMop2Om6cs883ZVpUpX
	CkNTDROA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syoUt-0000000BzXS-1H7B;
	Thu, 10 Oct 2024 08:26:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syoMJ-0000000Bx5B-29KT
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 08:17:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D79C227A8E; Thu, 10 Oct 2024 10:17:14 +0200 (CEST)
Date: Thu, 10 Oct 2024 10:17:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on
 stuck partition scan
Message-ID: <20241010081714.GA8013@lst.de>
References: <20241007100134.21104-1-hare@kernel.org> <20241007100134.21104-3-hare@kernel.org> <ZwQmK6dZ_goSQ4Cg@kbusch-mbp> <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de> <ZwWY8d3vOLUaYaJ6@kbusch-mbp> <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de> <Zwa-MBS6wn_dGxge@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwa-MBS6wn_dGxge@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_011719_720424_F7AF2F1D 
X-CRM114-Status: GOOD (  19.82  )
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

On Wed, Oct 09, 2024 at 11:32:32AM -0600, Keith Busch wrote:
> On Wed, Oct 09, 2024 at 08:23:45AM +0200, Hannes Reinecke wrote:
> > With my testcase _all_ paths return NS_NOT_READY during partition scan, so
> > I/O is constantly bounced between paths, and partition scan never returns.
> > Doesn't matter where you call it, it's stuck.
> 
> Assuming you mean a differet status, like NVME_SC_INTERNAL_PATH_ERROR, I
> can recreate a stuck scan. Let me get one more shot at fixing this by
> suppressing the scan to another context. This one is successful in my
> tests:
> 
> ---
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 48e7a8906d012..e1fd53ff2c0ca 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -580,6 +580,20 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>  	return ret;
>  }
>  
> +static void nvme_scan_work(struct work_struct *work)

scan_work feels a little too generic.  Maybe part_scan_work?

Otherwise not pretty, but by far the best idea so far, so I guess should
go with it.  Can you also add a big fat comment explaining the rationale
for the actual submission?



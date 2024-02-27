Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6018C5478C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=af7x+9XyGriFG11mPuKrh/48BPo5FaZITyInpvbr7W4=; b=libQrfC7VSsuYZfyH6bOk/Cpn3
	k7ccqdouRsKxspAXM7lpvada2wUdr5blpyvQTAUfzBsAOKjaJc5N2AaIisKKp3zxCiDkZmtUOoYcv
	2CWcm0r7gfv9kA5iqm7+mM5sDq7mZ9XefxL7Z1XMduI4b0a4snwD8mmlyB5dtpe7IF1COq6bAheSw
	ktszWbXTs1CkNLeAsQd89ruDfrAgheADVsLcJev4GKj1+Z1qNVcmMfCxh95wvsrEtpHngAPN+dqpq
	LNt5FxQGFwPkSrZDrmzj6Pj43GsBM3G0swclMBwWOmw+eQWFNaNFaOhmWhzOfUeGmwKLLZJYixdmE
	QB1yZYSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1revf6-00000004wXu-1R6v;
	Tue, 27 Feb 2024 11:30:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1revf3-00000004wXV-2WNS
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 11:30:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5943861482;
	Tue, 27 Feb 2024 11:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D62BC433F1;
	Tue, 27 Feb 2024 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709033412;
	bh=kdrZaX0aMKIkA+JGeMkKBVsvA05i0ftiJZuPnMvGgP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHOX5rpX6BtMKfbOHHkQRkSOBZi6bLMMy0wao6khQStgIZm1d1qkcj1x7f+WTuxf2
	 t43rqIOoAYCXZXM+0z28Q5aPOzeDTgrDf9auFw17UX/gJPb0dNe+sW7vEtU+Bd2lCR
	 sUIzylUAVVqEdhvwpWRcUZ3y4swv8UWZVcbLz7ksl4blN9rGrURxyv44peMxBrf5FO
	 V8THu/sFza5RyopfTx/5+7sw2YjmKOR+/jdtWjQ+9WjUl4FnyIEOhk5DkrVl0WKV/H
	 LLJ89HcJ0hcwesqoGZqet+1jKymjr/gArdqFGkoz5ckIpfFcBNbSNwTkfUZQsiX0t6
	 MH2MMNrhR9Mog==
Date: Tue, 27 Feb 2024 13:30:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	linux-rdma <linux-rdma@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA
 mapping operations
Message-ID: <20240227113007.GD1842804@unreal>
References: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_033013_709814_3B710769 
X-CRM114-Status: UNSURE (   9.84  )
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

On Tue, Feb 27, 2024 at 08:17:27AM +0000, Chaitanya Kulkarni wrote:
> Hi,

<...>

> In order to create a good platform for a concrete and meaningful
> discussion at LSFMM 24, we plan to post an RFC within the next two weeks.

The code can be found here https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dma-split

Thanks

> 
> Required Attendees list :-
> 
> Christoph Hellwig
> Jason Gunthorpe
> Jens Axboe
> Chuck Lever
> David Howells
> Keith Busch
> Bart Van Assche
> Damien Le Moal
> Martin Petersen
> 
> -ck
> 
> [1] 
> https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net
> [2] https://lore.kernel.org/linux-iommu/20200708065014.GA5694@lst.de/
> 
> 
> 


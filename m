Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AC7D116E2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 07:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ffkDnetzk18mDf3aCrXgJlyJnVNlcvf5A1CXkCAaPA=; b=2nxeEnolq6Tb2L791xQ4il1cH5
	NwuAXXvvLGRjNmv45boJ3mxwIPoyazT6xuWWxAF50s4pPmkJxTmhFQ/NH7QelU4w5/rPLE/4po7lb
	55bQB/3fgRabDK6YYbm0cPMLxQ0wEhTZhSbltfmZVYg3raW94TyZ+GPWWkpzbec7JpoGe6Qq616cV
	/yyOiUbKIXGpSyExS8qO+L5l8x0mNkIGdgmR3Kyj1uFYXX5fWZGwY4bIhitPh4rVKj7qQJRVXwuFc
	7M8ZeZGJWM3Sn0vFZfwSGqjhVX1qe6cSHMZs+SbBx8tBRrVt41QFC22rR3M5p0tWzJycEFh041erp
	5XYkhLQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPyJr-000000033Mm-0rN6;
	Mon, 01 Dec 2025 07:27:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPyJo-000000033M9-0TcX
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 07:27:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 970BD6732A; Mon,  1 Dec 2025 08:27:27 +0100 (CET)
Date: Mon, 1 Dec 2025 08:27:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 2/4] nvme: reject invalid pr_read_keys() num_keys
 values
Message-ID: <20251201072727.GA20845@lst.de>
References: <20251127155424.617569-1-stefanha@redhat.com> <20251127155424.617569-3-stefanha@redhat.com> <69b3b390-77fe-440c-8747-096c0b26a112@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b3b390-77fe-440c-8747-096c0b26a112@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_232732_318785_9E09DA99 
X-CRM114-Status: GOOD (  21.98  )
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

On Mon, Dec 01, 2025 at 07:11:31AM +0000, Chaitanya Kulkarni wrote:
> On 11/27/25 07:54, Stefan Hajnoczi wrote:
> > The pr_read_keys() interface has a u32 num_keys parameter. The NVMe
> > Reservation Report command has a u32 maximum length. Reject num_keys
> > values that are too large to fit.
> >
> > This will become important when pr_read_keys() is exposed to untrusted
> > userspace via an <linux/pr.h> ioctl.
> >
> > Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> > ---
> >   drivers/nvme/host/pr.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> > index ca6a74607b139..156a2ae1fac2e 100644
> > --- a/drivers/nvme/host/pr.c
> > +++ b/drivers/nvme/host/pr.c
> > @@ -233,6 +233,10 @@ static int nvme_pr_read_keys(struct block_device *bdev,
> >   	int ret, i;
> >   	bool eds;
> >   
> > +	/* Check that keys fit into u32 rse_len */
> > +	if (num_keys > (U32_MAX - sizeof(*rse)) / sizeof(rse->regctl_eds[0]))
> > +		return -EINVAL;
> 
> de-referencing res in res->regctl_eds[0] is safe in this patch ?

sizeof does not dereference pointers in the expression.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EEBC5ACD1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Yh8YlZfWC+YQIPKrLCEYUXdbkvhoi+H4vPy+ESTo3I=; b=hlF/m91WJ5nbIZ5z7nuNN73wPX
	V/K3jFTyLwYjBAF1RioVZ4fywP6dH4xB1RK4J2MbE3cihhccEde3tEOHy2X0uRtv+LOnNAJ2AZRVP
	m49SAGCxlFNAwXygXXrfTwqy5Tfo8YOLrDZYouFZxLkHtEiBMhT4ZoCC5KLqLFT2v5vZiJnpqrRO0
	KMmTyjv3agdIas6qXgQoQqwipe2HIzEKvB+QTsHKo924DHvol8EIkae+3NDPWZE1eDCct5DjOGjWY
	WZYkfuFnuEPHvUISrouk15WnJTdhlxb9ZL3y/KwQYxdlUZnWn42E5RZwyvys0kwzemWfkvj4qVLP1
	Io/eH9fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTEk-0000000FF3H-1cy6;
	Fri, 20 Feb 2026 16:20:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTEg-0000000FF1N-34R6
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:20:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F8A268B05; Fri, 20 Feb 2026 17:20:07 +0100 (CET)
Date: Fri, 20 Feb 2026 17:20:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] nvme: update nvme_id_ns OPTPERF constants
Message-ID: <20260220162007.GA15462@lst.de>
References: <20260220032809.758089-1-csander@purestorage.com> <20260220032809.758089-3-csander@purestorage.com> <20260220160741.GC15071@lst.de> <CADUfDZrx0pvf4HLk73vMmJNLQ8cE8S0FLLTj-hUE7a4f=uE-RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrx0pvf4HLk73vMmJNLQ8cE8S0FLLTj-hUE7a4f=uE-RQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_082010_911191_5674DD44 
X-CRM114-Status: GOOD (  19.29  )
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

On Fri, Feb 20, 2026 at 08:17:29AM -0800, Caleb Sander Mateos wrote:
> On Fri, Feb 20, 2026 at 8:07 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Feb 19, 2026 at 08:28:05PM -0700, Caleb Sander Mateos wrote:
> > > Since NVM Command Spec 1.1, OPTPERF comprises both bits 4 and 5 of
> > > NSFEAT in the Identify Namespace structure. Replace NVME_NS_FEAT_IO_OPT,
> > > which represented only bit 4, with NVME_NS_FEAT_OPTPERF_SHIFT and
> > > NVME_NS_FEAT_OPTPERF_MASK.
> >
> > As you're deeper in this than me:  do the older specs require the
> > other bit to be cleared to zero and this is all compatible?  Or do
> > we need to guard it somehow?
> 
> In NVM Command Set spec 1.0 (NVMe version 2.0), OPTPERF is only bit 4
> of NSFEAT and the higher bits are reserved. I think it seems
> relatively safe to assume bit 5 will be reported as 0 on controllers
> advertising older NVMe versions, but you're correct that the host
> should technically check for version >= 2.1 before using bit 5. Let me
> know which approach you'd prefer.

Not entirely sure, but either way the code should have a big fat
comment about this.



Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766E9C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:56:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E250064E46
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E250064E46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/ZZrX4KoJKWdSmdUdXwAIRnkgpuwmGY9pJpy/009P4o=; b=J69aIXkh2k1opuVKwEYVLLTVr
	HpJ8ePs9gPjSj7iAtTYjBKLrhkpXEeT4E7/dzovVYfDe7w7MqlVmdCBCGNYJh6q2IvTfBQAPUAyGw
	4X6RjI4dvV3Q6iJ+eHWfQgspVlL1n7bh2xrL4DJW+EUE0cM3kixiyW/STu344ylFHOyQWEqb9sJXi
	IjNjqHouYnUEoU0ZMQ5ZccGcw3C93zsqJJKOiZ8Hy1g2jUtwG7Yxmo/dYnDPJnkUJJ+uhX1ZzmLCn
	C78wKeaihET9k0WNOOhz9dddAt7FiPFJR2dzCeYk2zUccSdg2Qb7PinbSRsixF1RiTs19neufkR6j
	xAAYnmCKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7LSO-0005bL-PC; Wed, 03 Feb 2021 16:56:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7LSJ-0005Z8-6s
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 16:56:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D16A468C7B; Wed,  3 Feb 2021 17:56:25 +0100 (CET)
Date: Wed, 3 Feb 2021 17:56:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Or Gerlitz <gerlitz.or@gmail.com>
Subject: Re: [PATCH v3 net-next 01/21] iov_iter: Introduce new procedures
 for copy to iter/pages
Message-ID: <20210203165621.GB6691@lst.de>
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-2-borisp@mellanox.com> <20210201173548.GA12960@lst.de>
 <CAJ3xEMjLKoQe_OB_L+w2wwUGck74Gm6=GPA=CK73QpeFbXr7Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ3xEMjLKoQe_OB_L+w2wwUGck74Gm6=GPA=CK73QpeFbXr7Bw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_115639_445374_28EC5E89 
X-CRM114-Status: GOOD (  15.75  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Linux Netdev List <netdev@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Or Gerlitz <ogerlitz@nvidia.com>,
 smalin@marvell.com, Sagi Grimberg <sagi@grimberg.me>, yorayz@nvidia.com,
 benishay@nvidia.com, Jakub Kicinski <kuba@kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, axboe@fb.com,
 Alexander Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>,
 Ben Ben-Ishay <benishay@mellanox.com>, boris.pismenny@gmail.com,
 David Ahern <dsahern@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>,
 David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 02, 2021 at 08:00:51PM +0200, Or Gerlitz wrote:
> will look into this, any idea for a more suitable location?

Maybe just a new file under lib/ for now?

> > Overly long line.  But we're also looking into generic helpers for
> > this kind of things, not sure if they made it to linux-next in the
> > meantime, but please check.
> 
> This is what I found in linux-next - note sure if you were referring to it
> 
> commit 11432a3cc061c39475295be533c3674c4f8a6d0b
> Author: David Howells <dhowells@redhat.com>
> 
>     iov_iter: Add ITER_XARRAY

No, that's not it.  Ira, what is the status of the memcpy_{to,from}_page
helpers?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

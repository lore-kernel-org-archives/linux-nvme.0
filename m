Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F8C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 10:02:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF59764DD4
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 10:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF59764DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cUih/C/A2WH+dufTju/tYFzZJP3qyFqACsfbe3CPoyM=; b=n7Dxc5xJWlYzsxJVKTjMyickb
	VAsAOHC/5EBFKLFANLRcgLFK7o43roPgglixVqZug12Qc0/6Fl7i3DFJqBzARKPMchEpbgQW/FTYj
	f3H40G+7O1aLls1wd1yGdo2whs6skpwz4mVfBTkQdiHH1inLUtp8H6Qp9WyWhbKrMqZ89SWvLGi5M
	4cj38xGihTkr9+uS29Aia06LVD5MqT1MZvb2BQ5iXhbMmpXxcwZphj2z4qN+f6ALEZ1HY/YyJIugc
	1CkTyx7T9tnFKiaVYUIzXLv/MXEYuGD42+uDLwVsB7HICwPoc9dA329IRqR0KBMDLsxOTNdy9puq+
	CZ0+AiUtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7Ezg-0008Lc-PW; Wed, 03 Feb 2021 10:02:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Eze-0008Ku-4m
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 10:02:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2102E6736F; Wed,  3 Feb 2021 11:02:35 +0100 (CET)
Date: Wed, 3 Feb 2021 11:02:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 net-next 07/21] nvme-tcp: Add DDP data-path
Message-ID: <20210203100234.GA9050@lst.de>
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-8-borisp@mellanox.com> <20210201173744.GC12960@lst.de>
 <CAJ3xEMhninJE5zw7=QFL4gBVkH=1tAmQHyq7tKMqcSJ_KkDsWQ@mail.gmail.com>
 <80074375-2d37-d9b9-afbe-1f3d1db4a41f@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <80074375-2d37-d9b9-afbe-1f3d1db4a41f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_050238_325014_34E5A7BD 
X-CRM114-Status: GOOD (  14.94  )
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
Cc: smalin@marvell.com, David Ahern <dsahern@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 Or Gerlitz <gerlitz.or@gmail.com>, Or Gerlitz <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 03, 2021 at 12:56:35AM -0800, Sagi Grimberg wrote:
>
>>> Given how much ddp code there is can you split it into a separate file?
>>
>> mmm, do we need to check the preferences or get to a consensus among
>> the maintainers for that one?
>
> Not sure if moving it would be better here. Given that the ddp code is
> working directly on nvme-tcp structs we'll need a new shared header
> file..
>
> Its possible to do, but I'm not sure the end result will be better..

In the end its your code base.  But I hate having all this offload
cruft all over the place.  Just saying no to offloads might be an even
better position, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

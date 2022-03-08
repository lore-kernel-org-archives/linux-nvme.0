Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB79C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 07:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IYbuICA/X2T0MBgKeuWaZurAzzwr+XUnK67HpqkEe9w=; b=L3pf44yI1FkxQ2u6XXprvL6v4L
	Rp3iy2LU5cSq52ynd1lO+kuoxnNUhcysVyyjQpavulR8Tl1X6xu2LmpicS47IppQeyfJ74+TawGlq
	ymc76AfegAHrsAvl7YZv/ZtRAFrkEXVLUPJKZ8o/+j/v4uz0gOrRwHK/pqKxaL9nYKfRnFqUw80a1
	Iinmv2PATBRd6yagpGvtCTq4fGcwpGg0tbTVuxEsRazB8irJcfwoxvSdG0bD/tFeCwDQ9ZObKULOd
	zQ44eCqcYbINfz9UZkmdY0pCygc1MDDDkxCq4VIAny22AV8jrD6ZSO7vQIr3o5QVRsKnDPxOhQ26i
	0LeF6jCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRU1K-0030cF-KX; Tue, 08 Mar 2022 07:12:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRU1H-0030bM-Ua
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 07:12:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AA5B668AFE; Tue,  8 Mar 2022 08:12:27 +0100 (CET)
Date: Tue, 8 Mar 2022 08:12:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220308071227.GB24575@lst.de>
References: <20220304092754.2721-1-sunmingbao@tom.com>
 <20220304092754.2721-3-sunmingbao@tom.com> <20220304162032.GA12250@lst.de>
 <20220305150915.00006b44@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305150915.00006b44@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220307_231232_154742_17013EB1 
X-CRM114-Status: GOOD (  18.39  )
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

On Sat, Mar 05, 2022 at 03:09:15PM +0800, Mingbao Sun wrote:
> Well, actually I did have thought whether the calling of network API
> here is proper. Since I did find that there is no call to APIs of
> PCI/RDMA/TCP in fabrics.c.

Yes - for a good reason.  Without networking support your patch won't
even compile (both the host and target side).

> But I hope the following could make a defense for it:
> 
> Anyway, we need to validate the tcp_congestion passed in from
> user-space, right?

Do we?  It seems like no one else really calls this routine to verify
things.  In fact it has no modular users at all in the current tree.

> The role of nvmf_parse_options is similar to that of
> drivers/nvme/target/configfs.c from the target side.
> And both of them can not avoid handling specific options of the
> sub-classes (e.g., NVMF_OPT_HDR_DIGEST, NVMF_OPT_TOS, NVMF_OPT_KATO).

NVMF_OPT_KATO is completely generic, but yes, there other two are
transport specific.  None of them calls out into other modules
that would need dependecies, though.

I'm also a little concerned that no other in kernel user like iSCSI,
NBD or NFS has any code like this.


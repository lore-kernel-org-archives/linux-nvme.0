Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3690FC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BCrY8/StYjMeahbCeSSq+/bbjZi5F+qV1IRkaWz1upc=; b=dk/BUX5I0x6y9UidWxZxUmOYIf
	gelbURI0py4ycxVi4IhCnWE7SU+wB7qoe9sfzekzC/t4BYp0mmgzlUTTXbWlM+a885GBa0XDeAs7i
	nLYLaXv1eJcwtgEHQ35bx0v8M1n5mIfU5EbRa3W2vPD7nUabCRhMzSS+PxEwvGljDV1G+Gmisl7gJ
	/awX35SdpYjnJXB7qE+ePLgUqfictUm2xpnm5SEM2fDxD7pNmtw19xXx2M6VNN1eCOjj6lglo01GH
	MoA+ORXHaq9Ag0dzjO5NsaQpl9P+Pe7OVhypqU/hzqLxUhl4spqvyoMvSxgkWxrrtDa/n5gF3PKTv
	9e5ucMVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBdrN-004q37-Qx; Wed, 13 Jul 2022 15:01:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBcyJ-004DI7-I8
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 14:04:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 36406B81FEC;
	Wed, 13 Jul 2022 14:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0153C34114;
	Wed, 13 Jul 2022 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657721049;
	bh=ZAU0L5kK4Sf9McbG926Hj/XUT0R01MpGmbcgsJYk0eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfznMmDaQH8d32YdV1e+uqSCeYmXGCrB04FZaz89S34KHt+hYUNSByGZqfuyt8WaJ
	 OXEs5vq9mIuJZVjZSfiO3VQGq17tu956YqCQYKrTviTMbGlc/FmaBatE1ij2Un8cJu
	 ma92AqTrKLaKbwKsTf3ddF93RILXggb102oGrWXD7NNZjvJ0hxyvCPlaUMGd3Ubtz/
	 P+fi5Q43yiUn4WjZ/LMf/PljTOCIuc0JYEQpQedQnEJpRE9jzeed85Y7qufijypS2/
	 Q46HfTgC5K/9xlwN6PWBZk/CAVeoGTHOEELqfB+2XjR98j1PjCER8gYkAAQGulFCBe
	 XpJ/yVKe1IYTA==
Date: Wed, 13 Jul 2022 08:04:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"agk@redhat.com" <agk@redhat.com>,
	"song@kernel.org" <song@kernel.org>,
	"djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"javier@javigon.com" <javier@javigon.com>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <Ys7Q020ELE80OL+X@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <5ffe57d3-354c-eabe-ea38-9c4201c13970@nvidia.com>
 <Ys639LsjBUGPNErd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys639LsjBUGPNErd@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_070411_770860_311828A7 
X-CRM114-Status: GOOD (  14.07  )
X-Mailman-Approved-At: Wed, 13 Jul 2022 08:00:42 -0700
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

On Wed, Jul 13, 2022 at 01:17:56PM +0100, Matthew Wilcox wrote:
> The firmware needs to prove to me that it *did something*.  That it
> actually read those bytes that it claims to have verified.  The simplest
> way to do so is to calculate a hash over the blocks which were read
> (maybe the host needs to provide a nonce as part of the VERIFY command
> so the drive can't "remember" the checksum).

From a protocol perspective, NVMe's verify command currently leaves 8-bytes in
the response unused, so this could be a reasonable way to return something like
a crc64 of the verified blocks. The verify command starts at an arbitrary block
and spans an arbitrary number of them, so I think a device "remembering" all
possible combinations as a way to cheat may be harder than just doing the work
:).

But this is just theoretical; it'd be some time before we'd see devices
supporting such a scheme, assuming there's support from the standards
committees.


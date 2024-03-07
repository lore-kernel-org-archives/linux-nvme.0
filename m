Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F482C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5zuLqYXEcrU0IPXnJfRZey6qQ6C1CibUgZYtXv3ee+4=; b=PN5UYBJFaBsz9/SLnYJahPT5t0
	XTtINUDi4eNFTcgnqpzNk2mqdAe6rTh/4NhU9+ysk5lNF2jHfnSRMJAsREGxoyPvFTyNmaH9NyCPl
	3LopLerqO0EjBVY9CqTLLu6p+KJM1hX6k5GRodiOzo7cGIqV6znnZGomkrwLDgC61ukCb787Eq5Mz
	8Ybx63zR13XPtI/8kEmMEs3rySIzLncNmRV3u2ie8Yx6jqbC4qC7jB11oOqKsblbqfnj7m1HXQmQO
	pfeb+Q1v/ceddRRcU8NU0gO76IhXLRNTzTqr2nd9RzY+FlRIy0hDPu1/XhOCjgzF5aM3dVXAvnOc9
	EwdLolEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8C9-00000003QnS-1inm;
	Thu, 07 Mar 2024 07:29:37 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8C6-00000003Qme-3F6u;
	Thu, 07 Mar 2024 07:29:34 +0000
Date: Wed, 6 Mar 2024 23:29:34 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: "kbus @pop.gmail.com>> Keith Busch" <kbusch@kernel.org>,
	NeilBrown <neilb@suse.de>, Tso Ted <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jan Kara <jack@suse.cz>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <Zels3qAHksXonaAs@bombadil.infradead.org>
References: <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <ZYUbB3brQ0K3rP97@casper.infradead.org>
 <ZYUgo0a51nCgjLNZ@infradead.org>
 <9b46c48f-d7c4-4ed3-a644-fba90850eab8@acm.org>
 <ZZxOdWoHrKH4ImL7@casper.infradead.org>
 <ZdeWRaGQo1IX18pL@bombadil.infradead.org>
 <ZdvIlLbhtb7+1CTx@dread.disaster.area>
 <ZdytYs8W9o0CIu_C@bombadil.infradead.org>
 <ZekfZdchUnRZoebo@bombadil.infradead.org>
 <ZelRRFTBvpyXeVGD@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZelRRFTBvpyXeVGD@dread.disaster.area>
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

Then it does seem we have everything we need already, and no changes
are needed. Because these drives *do* support the logical block size
advertised, it's just not optimal.

On Thu, Mar 07, 2024 at 04:31:48PM +1100, Dave Chinner wrote:
> Sure, doing 512 byte aligned/sized IO to a 4kB sector sizer device
> is not optimal. IO will to the file will be completely serialised
> because they are sub-fs-block DIO writes, but it does work because
> the underlying device allows it. Nobody wanting a performant
> application will want to do this,

It's a good time to ask though if there may be users who want to opt-in to
promote this sort of situation so that the logical block size is lifted
to prevent any IOs. For NVMe drives it could be where the atomic >= Indirection
Unit (IU). This is applicable even today on a 4k IU drive with 4k atomic
support. Who would want this? Since any IO issued to a drive which is
smaller than the IU implicates a RMW, it means your if you restrict the
drive to only IOs matching the IU could in theory improve endurance.

> but there are cases where this case fulfils important functional requirements.

Sure.

> e.g. fs tools and loop devices that use direct IO to access file
> based filesystem images that have 512 byte sector size will just
> work on such a fs and storage setup, even though the host filesystem
> isn't configured to use 512 byte sector alignment directly
> itself....

It would seem like quite a bit of things. This is useful, thanks.

  Luis


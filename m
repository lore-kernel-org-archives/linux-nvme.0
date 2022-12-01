Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C3CC43217
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hi8NdwJcM2fnWBK6zyZaE0cHTgaGCouT43ExNdFRJkk=; b=ptSHZup2GsjaTcYQzFLh/mubBb
	YkY/pz3s1P2VoBnYz1XJtppvX9qX7pzVVdb5ZbDB73b3bElT03Q28lFvGWzDu6TvBOrUWYvtQ71mY
	A8l6u6bzN7Zsfv+n52so0UnV+cf+SqnaYrb171iOXAZ3kkXjsXSv5VlmcrbyMogxGpqd89RM30y93
	WQchwmL9KvoC/djDtEQAxhZOFA1+qKi0O4NYwG8Lmre2Idi2WxZVoTDfjJ8AKJHuF3+8jHid79M62
	pgCLY5lr2KcIEHde9e90aiIN37GO9stxh8SGndZ9B79NxhtfuO9xvUyRlCtSk5rLE+pN9ntmFWRaT
	Y5MVtuAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0pUS-00Ac2g-B3; Thu, 01 Dec 2022 19:45:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0pPA-00ATcs-9n
	for linux-nvme@bombadil.infradead.org; Thu, 01 Dec 2022 19:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hi8NdwJcM2fnWBK6zyZaE0cHTgaGCouT43ExNdFRJkk=; b=cc9S5eKoMZCC56Mi2GED9exshH
	VZD2iiW36YGQyBWoDNPRIWt2l51l2Eht+QKl3ns0X+gRVBh58/2N2JIMojPf6IcsuOstG6z4PemuI
	mJWOUjwQ11+KzOkv3LRrbwc0uyOP2JKggZamzlGzGDbJ6YYkDeKYUw/zKj59m34k4vQiyJqm1qSM4
	/2vevWwCXJxm607nETe6Y43BQ77fiJVLzuahwD6Fg7DI+RC9zbLu2o76gw8rHts3txHktL7GW7GTJ
	GDatpCfDDAt0OAEmVRZA2awdw/CGwGNyXX6aaosdmQYKxXlaSxa0TMuJUeOGrYI0leJsFHzHcTvQi
	mvMfx+Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0pPA-00GrMY-3M; Thu, 01 Dec 2022 19:39:32 +0000
Date: Thu, 1 Dec 2022 19:39:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"javier@javigon.com" <javier@javigon.com>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
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
Message-ID: <Y4kC9NIXevPlji+j@casper.infradead.org>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
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

On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
> So nobody can get away with a lie.

And yet devices do exist which lie.  I'm not surprised that vendors
vehemently claim that they don't, or "nobody would get away with it".
But, of course, they do.  And there's no way for us to find out if
they're lying!



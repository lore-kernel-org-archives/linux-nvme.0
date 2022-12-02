Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37037C4321E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=27NS99M69QiQRjMGEGxCvO79i9Xj//1w3PPVyWlTuHU=; b=0g+zDtcMsti9SkcRv+gr4gQsaT
	VRyMh02QOyxdTpwsAXcbe9I7ruU4oEosqz2GXzu9vCEvFRD9UrLE7GazRqmJc+9T35S6Anfub1N6D
	mFFnJ1xHVQ2adM2swL+HjcBOiyg0V45p1McaZouGyeJDCYmKZISO8IjKwFfMvFVZ9+rWPVnfDJqTA
	pi4vUiRta78uIoPQMlSQ5X5z1WyR3NxyAmoG9CJjVqg41yx/3MTDT94zkyySVbDmyNPIEa/YX3DAa
	s7MVKZxgfdYtfViJoMQUFdJVKbLgYX3yAVhEsNxiq763JU7LXxsk7La3XzsdPIGG5EOVOjc7DCwAx
	hdiN0sfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p17Ui-00GwZs-19; Fri, 02 Dec 2022 14:58:28 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p17Ue-00GwYG-TI
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 14:58:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DA18EB8216E;
	Fri,  2 Dec 2022 14:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85441C433D6;
	Fri,  2 Dec 2022 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669993101;
	bh=/n5CLN7ON3ycvsyEi1YxKOhSSwA+7yJQAUZB1mnM43M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLW0hD+C9SLzRYcnnlslZYKphSt6MEcrihJeqdPpaJqTSgTHwpwCUV+1K4ySL51iI
	 zwZnFsZstRt/oSuTBO2XFUPYkY64e0lrv2BoJFAwCHsrL3Sghpaqm2jkhbusu2UmvU
	 L/pTsacxpT1DBAz36cESjdsRiQHtomfdRR9TEe707Cnv0BpwVQaQ4fFgOoGRPrwjoR
	 p+0Zc73/Pw/hXzl+y8PuQrVRHcfZhA+DjhmKa1k+0sj8qD7jELK8hHYqoVBkWygG7V
	 f1UQYT8rEc62M9Q/BTjYXZIsFJC7aXrqJX8DY/uv65a0YnMRw0fryjCHbkDqWgEb4n
	 7P7XZYU+Tn6Mg==
Date: Fri, 2 Dec 2022 07:58:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
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
Message-ID: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
 <Y4kC9NIXevPlji+j@casper.infradead.org>
 <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_065825_130102_E2B125AA 
X-CRM114-Status: GOOD (  14.47  )
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

On Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
> On 12/1/22 20:39, Matthew Wilcox wrote:
> > On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
> > > So nobody can get away with a lie.
> > 
> > And yet devices do exist which lie.  I'm not surprised that vendors
> > vehemently claim that they don't, or "nobody would get away with it".
> > But, of course, they do.  And there's no way for us to find out if
> > they're lying!
> > 
> But we'll never be able to figure that out unless we try.
> 
> Once we've tried we will have proof either way.

As long as the protocols don't provide proof-of-work, trying this
doesn't really prove anything with respect to this concern.


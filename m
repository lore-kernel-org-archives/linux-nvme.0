Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03400C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBKO9U91cuGTh8tpomIJKH23cKRY4Ko/DagSMWIrj80=; b=DJrLLPIaO+WQTCYDZk2+Lj9fs3
	CzjVOyQMRCdt0JZ10rxQIVKJU7hfL04tERxw1EZ4qNvShdAWJ/tKY23aNNAf7IH1HklCv6LJG24qz
	RkIxvi0CjLEvWIqdcVClpIUjJWBejlPWPV00YHdV+AV9E58nqTSI1S7qcohKhAzBPNJOpDAAEkXqp
	UBWLJJoQ5g6fyT8DOylJ5zw79YJjyGTreqNaSIsUePOKphCI6+CC4TN+Qbfav7fKupf6MKwmGYCDB
	pllqAjshnyQ5NJJ1Sbtu9hHcDiarXbveinGCLp3Wken1AorJoKdjNb44AOONXz0yivndI31axd4Hj
	J6NjF89A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4cEb-008l50-LA; Mon, 12 Dec 2022 06:24:17 +0000
Received: from hoggar.fisica.ufpr.br ([2801:82:80ff:7fff::2])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3zZ3-0005By-4P
	for linux-nvme@lists.infradead.org; Sat, 10 Dec 2022 13:06:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
	s=201705; t=1670677594;
	bh=k1rB58ErS/iAm3rvDzRcxYOQIzkcaaY3A2e6xx7mlFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHKVbmYv/YFYZllRLCOIH8/JNqr/AU+5bRs16lFbyUXjTh7F7BH46s/jTRqyzCniU
	 jCPEv1ThwCqjr4A8kOIHv9l/5BX/OSQQ13CmR4u2m67gBeQMDIHQluny8vp/QbN/4G
	 D5rjr8hSn15BmYDUgEKDpZ/xba31C2HcH5hT6/qBvnCXtIcRXwJLsGIpqpT9f9M81N
	 dPgyaVmalT7cQoChT6zWzEYCmKuXmdBiD466MF+ayduNMhda/w6fg9IWIi3iB8n2w/
	 aIybLvPPecoA253cylTCCqdGE91bsE0w/9GIvhHg0Oc4qNIw9QxkKIoB+LNo5A6Oxu
	 0EcUYcQGhFuXg==
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
	id EDAC5362037A; Sat, 10 Dec 2022 10:06:34 -0300 (-03)
Date: Sat, 10 Dec 2022 10:06:34 -0300
From: Carlos Carvalho <carlos@fisica.ufpr.br>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Clay Mayers <Clay.Mayers@kioxia.com>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>,
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
Message-ID: <Y5SEWnNUpgKxOB/W@fisica.ufpr.br>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
 <Y4kC9NIXevPlji+j@casper.infradead.org>
 <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
 <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
 <f68009b7cc744c02ad69d68fd7e61751@kioxia.com>
 <yq14ju5gvfh.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yq14ju5gvfh.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221210_050650_041984_3E3D7D2E 
X-CRM114-Status: GOOD (  15.48  )
X-Mailman-Approved-At: Sun, 11 Dec 2022 22:24:04 -0800
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

Martin K. Petersen (martin.petersen@oracle.com) wrote on Fri, Dec 09, 2022 at 01:52:01AM -03:
> I suspect that these days it is very hard to find a storage device that
> doesn't do media management internally in the background. So from the
> perspective of physically exercising the media, VERIFY is probably not
> terribly useful anymore.
> 
> In that light, having to run VERIFY over the full block range of a
> device to identify unreadable blocks seems like a fairly clunky
> mechanism. Querying the device for a list of unrecoverable blocks
> already identified by the firmware seems like a better interface.

Sure.

> But I think device validation is a secondary issue. The more
> pertinent question is whether we have use cases in the kernel (MD,
> btrfs) which would benefit from being able to preemptively identify
> unreadable blocks?

Certainly we have. Currently admins have to periodically run full block range
checks in redundant arrays to detect bad blocks and correct them while
redundancy is available. Otherwise when a disk fails and you try to reconstruct
the replacement you hit another block in the remaining disks that's bad and you
cannot complete the reconstruction and have data loss. These checks are a
burden because they have HIGH overhead, significantly reducing bandwidth for
the normal use of the array.

If there was a standard interface for getting the list of bad blocks that the
firmware secretly knows the kernel could implement the repair continuosly, with
logs etc. That'd really be a relief for admins and, specially, users.


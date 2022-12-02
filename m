Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBD7C352A1
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Dec 2022 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZOCfLUmokrVQ7+q+3VAv/fMPpCAv++YncqlYLezfCKI=; b=gP/Yz+0CEqSD+x6SvDS3IMEiFG
	aR7LooEGVTWiKRpa0xwi5cB2P1pEcYyJmc/XFcIMQTJ+tk1qjB0g8014JQXXLf5cYkaXua9p1eXOc
	N66wqLE+eV9ZRagr8z/ObrkvjmOMzp2UeNO9H0Bh+apX3lcuGoPwQKDyuhMoakXlJYn2fSNKqoSJq
	d9nWwnf9n0UVCBLpCsMUeVCxyDayYtqycKwriIr0SRyDdUAPSa8IKwVu3AsGfh+uOdWQhkzdDNmeg
	m+HNw0F36BL1QLbQd1Bp6Pmg4fsn9B0JQBm0EE43c4Cuabkbq/Af/1zYAZgyRR4m/LROlPdNKIgyi
	/mwda9mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1UcQ-003vNR-Di; Sat, 03 Dec 2022 15:39:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1BEs-000pFE-8J
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 18:58:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7E57061CD5;
	Fri,  2 Dec 2022 18:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DC5C433D7;
	Fri,  2 Dec 2022 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670007501;
	bh=HOh3Cp0n7LazD+GQRWKmIbl4e99o0522H/+1Wb/zFpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jueI8u5WzpHJXBCeK/s4VvCOnYb+rztUFEYYWKB4165BfMWRW5GyhTygwbxjm2WX0
	 Tx8XueKkLaPFVj+VRFYDOK3LRCtzyrpkwJzIkOr/sv/sOQtsjS3Ar1m+++x5tnsxCW
	 kCUvTXgv909+I5LfeYCwXjff5eR6WT8Ipxpjy2kg1EnYL8tZSoOwqnP4Q5p//pzfuB
	 O1aQIP2YphtTLJMj4IU/3JpUAfxOOISMMi9L2O6aWaJghElC+tyWIOxlKB1SY83zid
	 MWFT3KMYEK0NF74IvZMbByMQ4JX+6x3gDGn7JQeV9V2rUZh9f8qCiuoIgJBXRcWBbK
	 X2gsRBM/jCbrw==
Date: Fri, 2 Dec 2022 11:58:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Clay Mayers <Clay.Mayers@kioxia.com>
Cc: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Y4pKySy9Wi2ULEOU@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
 <Y4kC9NIXevPlji+j@casper.infradead.org>
 <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
 <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
 <f68009b7cc744c02ad69d68fd7e61751@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68009b7cc744c02ad69d68fd7e61751@kioxia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_105822_361339_5194A1E8 
X-CRM114-Status: GOOD (  14.64  )
X-Mailman-Approved-At: Sat, 03 Dec 2022 07:39:50 -0800
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

On Fri, Dec 02, 2022 at 05:33:33PM +0000, Clay Mayers wrote:
> > 
> > As long as the protocols don't provide proof-of-work, trying this
> > doesn't really prove anything with respect to this concern.
> 
> I'm out of my depth here, but isn't VERIFY tightly related to PI and
> at the heart of detecting SAN bit-rot? The proof of work can be via
> end-to-end data protection. VERIFY has to actually read to detect bad
> host generated PI guard/tags.  I'm assuming the PI checks can be
> disabled for WRITE and enabled for VERIFY as the test.

I suppose if you happen to have a PI formatted drive, you could WRITE
garbage Guard tags with PRCHK disabled, then see if VERIFY with PRCHK
enabled returns the Guard Check Error; but PI is an optional format
feature orthogonal to the VERIFY command: we can't count on that format
being available in most implementations.


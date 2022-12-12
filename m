Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057DDC4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 06:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zmESsql5DsN+fcriCG0lZ8Q2HjeaaqSz2wG+VrAjhqk=; b=NtH6tBmvE0pAukJizi/O71gBsZ
	5Sau+3cGtoB0R11R6ROjnEcRweqUm+pxSAZJKZbjXjaX5UFFL5u2/pOcoW2A//gfola909rzRU5ZP
	lfUNBEZ3TeOYTnXzfJpo+uWddFya4FU8EPueMaXCiV700AEMigB497rEWGsBgcYX13rZ+9eJkEYLi
	LhFn4e7DIzB8oBhfYxlMm9i2Sm0Uh3jZdrvyh4MLQfF2F7VCDDWeuXn9IWVZNxDhDussNk2Ad0QUz
	9euiRrPtNDdchSk/oT66hhuDG1mEujHcrrWL1iycBfuJkKVh4HAjh8h33rpFRsJlhhHwwxpyaXo0c
	IvLI1qmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4cLd-008pRM-D2; Mon, 12 Dec 2022 06:31:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4cKl-008otP-QD
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 06:30:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70C1268AA6; Mon, 12 Dec 2022 07:30:18 +0100 (CET)
Date: Mon, 12 Dec 2022 07:30:17 +0100
From: "hch@lst.de" <hch@lst.de>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Clay Mayers <Clay.Mayers@kioxia.com>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
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
Message-ID: <20221212063017.GA9290@lst.de>
References: <20220630091406.19624-1-kch@nvidia.com> <YsXJdXnXsMtaC8DJ@casper.infradead.org> <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com> <Y4kC9NIXevPlji+j@casper.infradead.org> <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de> <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com> <f68009b7cc744c02ad69d68fd7e61751@kioxia.com> <yq14ju5gvfh.fsf@ca-mkp.ca.oracle.com> <Y5SEWnNUpgKxOB/W@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5SEWnNUpgKxOB/W@fisica.ufpr.br>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221211_223040_195433_645D9348 
X-CRM114-Status: GOOD (  16.17  )
X-Mailman-Approved-At: Sun, 11 Dec 2022 22:31:32 -0800
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

On Sat, Dec 10, 2022 at 10:06:34AM -0300, Carlos Carvalho wrote:
> Certainly we have. Currently admins have to periodically run full block range
> checks in redundant arrays to detect bad blocks and correct them while
> redundancy is available. Otherwise when a disk fails and you try to reconstruct
> the replacement you hit another block in the remaining disks that's bad and you
> cannot complete the reconstruction and have data loss. These checks are a
> burden because they have HIGH overhead, significantly reducing bandwidth for
> the normal use of the array.
> 
> If there was a standard interface for getting the list of bad blocks that the
> firmware secretly knows the kernel could implement the repair continuosly, with
> logs etc. That'd really be a relief for admins and, specially, users.

Both SCSI and NVMe can do this through the GET LBA STATUS command -
in SCSI this was a later addition abusing the command, and in NVMe
only the abuse survived.  NVMe also has a log page an AEN associated
for it, I'd have to spend more time reading SBC to remember if SCSI
also has a notification mechanism of some sort.


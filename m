Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F511C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 01:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p6PzlAy7ELGFoVZquJzLBtjVeqxfG6WWLoDc1bX1xqY=; b=wCQcCfInysutNIH6RHEPcOwvbc
	+QSYYCM1JbIwo8XUIUT+bKw1golXj4WZayqUmQkv14enslXawJOLOVF8QFoCMCoi09A4VU1AYWP1N
	imVt2YC4DgCUQGny35LzMniWOM4yPf7sx2Qy0avUPfs6SlyUh9DTFzA3QaifxqOfgOKWCHQgoU64u
	F2bRblXQrZhxXcQWKb3t0dsttff91DH9EGecthErZ97DqNC/q1qdBW/v92v1SUDu4LEgneOKcKIWC
	O25ahuQJjMYxDcIs/sb5Lh860dBDvsX+hUyHnY2WW9Hgu9kfKYmXkMDO6GRo5ZC29BHGdSWCNTOGL
	vkDlzRpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUIP2-00B4m9-Ka; Wed, 16 Mar 2022 01:24:40 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nUIOz-00B4lt-TZ; Wed, 16 Mar 2022 01:24:37 +0000
Date: Tue, 15 Mar 2022 18:24:37 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <YjE8VZ1bbdE9nV0C@bombadil.infradead.org>
References: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
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

On Wed, Mar 16, 2022 at 09:46:44AM +0900, Damien Le Moal wrote:
> On 3/16/22 09:23, Luis Chamberlain wrote:
> > What applications? ZNS does not incur a PO2 requirement. So I really
> > want to know what applications make this assumption and would break
> > because all of a sudden say NPO2 is supported.
> 
> Exactly. What applications ? For ZNS, I cannot say as devices have not
> been available for long. But neither can you.

I can tell you we there is an existing NPO2 ZNS customer which chimed on
the discussion and they described having to carry a delta to support
NPO2 ZNS. So if you cannot tell me of a ZNS application which is going to
break to add NPO2 support then your original point is not valid of
suggesting that there would be a break.

> > Why would that break those ZNS applications?
> 
> Please keep in mind that there are power of 2 zone sized ZNS devices out
> there.

No one is saying otherwise.

> Applications designed for these devices and optimized to do bit
> shift arithmetic using the power of 2 size property will break.

They must not be ZNS. So they can continue to chug on.

> What the
> plan for that case ? How will you address these users complaints ?

They are not ZNS so they don't have to worry about ZNS.

ZNS applications must be aware of that fact that NPO2 can exist.
ZNS applications must be aware of that fact that any vendor may one day
sell NPO2 devices.

> >> Allowing non power of 2 zone size may prevent applications running today
> >> to run properly on these non power of 2 zone size devices. *not* nice.
> > 
> > Applications which want to support ZNS have to take into consideration
> > that NPO2 is posisble and there existing users of that world today.
> 
> Which is really an ugly approach.

Ugly is relative and subjective. NAND does not force PO2.

> The kernel

<etc> And back you go to kernel talk. I thought you wanted to
focus on applications.

> Applications correctly designed for SMR can thus also run on ZNS too.

That seems to be an incorrect assumption given ZNS drives exist
with NPO2. So you can probably say that some SMR applications can work
with PO2 ZNS drives. That is a more correct statement.

> With this in mind, the spectrum of applications that would break on non
> power of 2 ZNS devices is suddenly much larger.

We already determined you cannot identify any ZNS specific application
which would break.

SMR != ZNS

If you really want to use SMR applications for ZNS that seems to be
a bit beyond the scope of this discussion, but it seems to me that those
SMR applications should simply learn that if a device is ZNS that NPO2 can
be expected.

As technologies evolve so do specifications.

> This has always been my concern from the start: allowing non power of 2
> zone size fragments userspace support and has the potential to
> complicate things for application developers.

It's a reality though. Devices exist, and so do users. And they're
carrying their own delta to support NPO2 ZNS today on Linux.

> > You cannot negate their existance.
> > 
> >> I have yet to see any convincing argument proving that this is not an issue.
> > 
> > You are just saying things can break but not clarifying exactly what.
> > And you have not taken a position to say WD will not ever support NPO2
> > on ZNS. And so, you can't negate the prospect of that implied path for
> > support as a possibility, even if it means work towards the ecosystem
> > today.
> 
> Please do not bring in corporate strategy aspects in this discussion.
> This is a technical discussion and I am not talking as a representative
> of my employer nor should we ever dicsuss business plans on a public
> mailing list. I am a kernel developer and maintainer. Keep it technical
> please.

This conversation is about the reality that ZNS NPO2 exist and how best to
support that. You seem to want to negate that reality and support on
Linux without even considering what the changes look like to to support
ZNS NPO2.

As a maintainer I think we need to *evaluate* supporting users as best
as possible. Not denying their existance. Even if it pains us.

  Luis


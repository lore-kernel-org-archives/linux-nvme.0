Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631A2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 00:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CFP2Sru0tYWchcwqq3XzxvQJc3sFwx3lg2SlcC28hc0=; b=DbCpjK/2zzSl2/icqaZpKJC11w
	KpaO0/FoP7fPiFGDgR3dS7KrtVekVw7cYXa0n0FOs2dMTxNmJwTVW/sHDXR9RrWDWVxeVAAbjJXwY
	xPOclqIYxF5HxwY6xgaETBr08pFuC8V/lS75EO/dxmTI4qT86IVAue6VPfBGn6LQN2h4NqsuVN79R
	IAqyr7zusJbEyGAfgBN9sdyb62pRiaELsrALCVMOOkuuMAMI0TLyNxX6LO8T3ypfMNcxc9XpimF4h
	mnGU+KZLSzKobF7phTnZzIC4aCVrOL9bqZ0ZPC7QmVYsDEm9OUeAtIT9OAxkWJIJc8HXBCIu/T3lR
	h9INTm3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUHRs-00AzZX-SP; Wed, 16 Mar 2022 00:23:32 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nUHRq-00AzZ8-Hf; Wed, 16 Mar 2022 00:23:30 +0000
Date: Tue, 15 Mar 2022 17:23:30 -0700
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
Message-ID: <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
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

On Wed, Mar 16, 2022 at 09:07:18AM +0900, Damien Le Moal wrote:
> On 3/16/22 02:00, Luis Chamberlain wrote:
> > On Tue, Mar 15, 2022 at 02:30:52PM +0100, Christoph Hellwig wrote:
> >> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier González wrote:
> >>> but we do not see a usage for ZNS in F2FS, as it is a mobile
> >>> file-system. As other interfaces arrive, this work will become natural.
> >>>
> >>> ZoneFS and butrfs are good targets for ZNS and these we can do. I would
> >>> still do the work in phases to make sure we have enough early feedback
> >>> from the community.
> >>>
> >>> Since this thread has been very active, I will wait some time for
> >>> Christoph and others to catch up before we start sending code.
> >>
> >> Can someone summarize where we stand?
> > 
> > RFCs should be posted to help review and evaluate direct NPO2 support
> > (not emulation) given we have no vendor willing to take a position that
> > NPO2 will *never* be supported on ZNS, and its not clear yet how many
> > vendors other than Samsung actually require NPO2 support. The other
> > reason is existing NPO2 customers currently cake in hacks to Linux to
> > supoport NPO2 support, and so a fragmentation already exists. To help
> > address this it's best to evaluate what the world of NPO2 support would
> > look like and put the effort to do the work for that and review that.
> 
> And again no mentions of all the applications supporting zones assuming
> a power of 2 zone size that will break.

What applications? ZNS does not incur a PO2 requirement. So I really
want to know what applications make this assumption and would break
because all of a sudden say NPO2 is supported.

Why would that break those ZNS applications?

> Allowing non power of 2 zone size may prevent applications running today
> to run properly on these non power of 2 zone size devices. *not* nice.

Applications which want to support ZNS have to take into consideration
that NPO2 is posisble and there existing users of that world today.

You cannot negate their existance.

> I have yet to see any convincing argument proving that this is not an issue.

You are just saying things can break but not clarifying exactly what.
And you have not taken a position to say WD will not ever support NPO2
on ZNS. And so, you can't negate the prospect of that implied path for
support as a possibility, even if it means work towards the ecosystem
today.

 Luis


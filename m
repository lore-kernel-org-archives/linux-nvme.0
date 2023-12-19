Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA968C46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GuKo81d+ZgXaWDIqIqaFeV+6nzSdLOAzkziHliIAKfg=; b=ZUyS7DmSALrH4HQibwQtEvpfO3
	aut69p64HPn4Nkqmr54vRDrjCw4MIkR3VKR7f5G6TOppnckF0lxcTtsUV3NgcdtLKCVL9ECEmmmiL
	N3iArD6QhRF+O+mC15rSrOyv7ZjoOQwcjsGi5OqDlmu/51/Ubzv/yiDH3JuzCntmYDXD3u6FIKqdB
	G1crpfEvWZcFAdRsdfL5Ud3v/KmyP4mUlu9r49r8lbCb50ntgoYZyW/h4FShCUbCEw1Um3/u74QTn
	xdx5IJCsRX//V3lJhMydWpch0o7Ekr/00eupimpU0aA8WCUiPGP4IdzzCpdy3YeSlhFQ/0G2Haf6j
	smayVh2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFXUm-00Dacu-1o;
	Tue, 19 Dec 2023 10:38:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFXUj-00Dabv-1z
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 10:38:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A192468BFE; Tue, 19 Dec 2023 11:38:25 +0100 (CET)
Date: Tue, 19 Dec 2023 11:38:25 +0100
From: "hch@lst.de" <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>,
	"Naohiro.Aota@wdc.com" <Naohiro.Aota@wdc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= <Chun-hung.Wu@mediatek.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Subject: Re: [PATCH 3/5] block: remove support for the host aware zone model
Message-ID: <20231219103825.GB14379@lst.de>
References: <20231217165359.604246-1-hch@lst.de> <20231217165359.604246-4-hch@lst.de> <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com> <190f58f7-2ed6-46f8-af59-5e167a0bddeb@kernel.org> <f19c41b9ea990e6da734b6c81caeebb73fb60b29.camel@mediatek.com> <do3ekgymdpa4skyz5p3dp6qcqq7zuty73qrpmftszmffunnxpm@fyswyalaxzfq> <dbc4a5b4296effd88ba0ef939aa324df0969545c.camel@mediatek.com> <0a329050-0010-47cb-8c7b-a2f0863a21e8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a329050-0010-47cb-8c7b-a2f0863a21e8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_023837_806649_2B8FBF01 
X-CRM114-Status: GOOD (  15.13  )
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

On Tue, Dec 19, 2023 at 05:12:41PM +0900, Damien Le Moal wrote:
> >> Since we cannot create lambda as in other fancy languages, we need
> >> two
> >> functions...
> > 
> > Not really, there is a "void *data" can be used.
> > 
> > The device_is_zoned_model() is just the same as the device_not_zoned()
> > with (bool *)data = false.
> > 
> > It's very minor, so is okay to ignore my preference.
> 
> Send a patch on top of Christoph's series if you want to clean this up.

I'll need to respin anyway, so I'll look into incorporating the
suggestion.


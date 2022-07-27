Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F92C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87PpohpIQw2/2uejY1wH41QfeQi8AtRn7VZFb7SjhYA=; b=t1tvNXX1niwzkQRZnWW2PZvU9x
	kVG3HlfSky22tuGnr8arkjOthXnLQ4IvzfJKP9b898is3WNm6Rgm8ten7ssjF2WlHCWpdoOXae/ze
	XFiudPISV7CyK65ddLj2+93nciSqBA0j0y34rzmENmJBmra5CVGB4tgT2O8JcVEv4rwZywN73gc8E
	b9MgguIUONJovBHZTR14SIl1cfbUOSMycqdiRmeL6qZjevmsl+WwktRKAUVouL4as0Zt1i7VwL1vo
	Nogvb8Iirbydx/HGR8zSLgpylpP8hnqFLXnl5BBp6NcZtIpGJa0L2HMPCncsiaa1HKN8o+AJbKQuz
	i/RW+Ytg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGhex-00EKhQ-PZ; Wed, 27 Jul 2022 14:05:11 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGheu-00EKdJ-KN
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 14:05:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=87PpohpIQw2/2uejY1wH41QfeQi8AtRn7VZFb7SjhYA=; b=umCU0DL1bjKE1YAZuuK/2KMKIR
	va3iBrAYx+CAGHHWzo199YCpVxiTZhrsNZuAqt/isCyAbeSHmTtePkotiiL10FMsFM7TFP97de5HV
	WZVZXQ5Te55WFKRBD8G05o5sjnN02sjWq83oX036/zWLWYwLOotLOvZA0IPiin+6pJ1eNBPDTqGbv
	pRVTcEX2u6YwV0gmW9m6oxoXErCQaNOagKV5DlYuB1aYv7hN0aOJxGnoe2h0Wz4MInQRwDcUOrzpu
	6WX2ErHHV7GxOjOC1M78bgtLWkwdMiBq9O2GldjJVjaYwRauNtQp8y2W3/tmaGSf5iv4H4hi2h9NI
	GZPJno8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oGhei-00GNnL-BO;
	Wed, 27 Jul 2022 14:04:56 +0000
Date: Wed, 27 Jul 2022 15:04:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <YuFGCO7M29fr3bVB@ZenIV>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuB09cZh7rmd260c@ZenIV>
 <YuFEhQuFtyWcw7rL@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuFEhQuFtyWcw7rL@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_070508_692422_9386E120 
X-CRM114-Status: GOOD (  15.63  )
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

On Wed, Jul 27, 2022 at 07:58:29AM -0600, Keith Busch wrote:
> On Wed, Jul 27, 2022 at 12:12:53AM +0100, Al Viro wrote:
> > On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:
> > 
> > > +	if (S_ISBLK(file_inode(file)->i_mode))
> > > +		bdev = I_BDEV(file->f_mapping->host);
> > > +	else if (S_ISREG(file_inode(file)->i_mode))
> > > +		bdev = file->f_inode->i_sb->s_bdev;
> > 
> > *blink*
> > 
> > Just what's the intended use of the second case here?
> 
> ??
> 
> The use case is same as the first's: dma map the user addresses to the backing
> storage. There's two cases here because getting the block_device for a regular
> filesystem file is different than a raw block device.

Excuse me, but "file on some filesystem + block number on underlying device"
makes no sense as an API...


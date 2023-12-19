Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E617C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zuGhO8i3ZiSAExfeQ5Od0dl4I/eaGPN8DqgVTFU9kew=; b=IN3pWNJMxtH4SY5gFhVy7Qc6+w
	HEAcSYFo8Iorf6I2jiuIJwti2e4AtFv3VwVnJILVjwyrXH2WmaP1rEvYWLt/Jb1BGsuTK4qYlpcet
	1KZqE047I9r+w99DdNVmhcHsO53TdQo0FEjrvIdLewGRwyk8uYPoJkfBZk7GTRoXVqaZh1QhLCMYo
	BJx1ZaWWOAAOgzMrWl4ZR8T2YCmJwa0dZdCgkt3BuRhQoqFE5GXLIaCvwmOHjssEI8DEmXloDf2b/
	EUYOtohIkdMuJF2CAWEWTKpah9Y1kHD9Qmu5s9uXRZ/z8zlV+3KUlacK1Tyyb7Y9SRsH1E+gL3vGW
	FnTV0hGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFaCA-00ECn6-2H;
	Tue, 19 Dec 2023 13:31:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFZ21-00DzJQ-0T
	for linux-nvme@bombadil.infradead.org;
	Tue, 19 Dec 2023 12:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zuGhO8i3ZiSAExfeQ5Od0dl4I/eaGPN8DqgVTFU9kew=; b=EEuhThj7thf/TUwMFDZdytzZjj
	Ca3mSa7vBT+0kxWqCq87IVzohRysRTx3QOu05gQy4tYJgLpJGFyQEJLbbkp2qJi1HPO8aDtmQfvas
	g1P0x7l85LuZXYnFxDrtjnni2idr/QD2LH9Bd6/KkOf1/JZfz5tvgi6XOz/Io2gwFz3LYW3oRDoub
	WBhYuZeZHgTHF+TarsYsF2lfqDmYbHYK3El3+8GqUSsJ5p8W3r0xw3pzzJ8hciURaZ9eCJKqbnPv0
	yp8xdqCFirl/bVNwXQaNLrAhH8z/Y4kpE8NI9DJvGI56Oy57G3xGr0yY8el2RUx8H6JPVSweLcx+r
	FW5vTHRA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFZ1x-00DTy5-1D
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 12:17:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 01BCC68BFE; Tue, 19 Dec 2023 13:16:49 +0100 (CET)
Date: Tue, 19 Dec 2023 13:16:49 +0100
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
Message-ID: <20231219121649.GA21736@lst.de>
References: <20231217165359.604246-1-hch@lst.de> <20231217165359.604246-4-hch@lst.de> <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com> <190f58f7-2ed6-46f8-af59-5e167a0bddeb@kernel.org> <f19c41b9ea990e6da734b6c81caeebb73fb60b29.camel@mediatek.com> <do3ekgymdpa4skyz5p3dp6qcqq7zuty73qrpmftszmffunnxpm@fyswyalaxzfq> <dbc4a5b4296effd88ba0ef939aa324df0969545c.camel@mediatek.com> <0a329050-0010-47cb-8c7b-a2f0863a21e8@kernel.org> <20231219103825.GB14379@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219103825.GB14379@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_121701_630046_C13EBBC7 
X-CRM114-Status: GOOD (  14.18  )
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

On Tue, Dec 19, 2023 at 11:38:25AM +0100, hch@lst.de wrote:
> > > It's very minor, so is okay to ignore my preference.
> > 
> > Send a patch on top of Christoph's series if you want to clean this up.
> 
> I'll need to respin anyway, so I'll look into incorporating the
> suggestion.

I did look into it and the iterate callbacks confuse the heck out of me.
So I'm not going to touch them in non-trivial ways here and will leave
it for follow on cleanups as needed.


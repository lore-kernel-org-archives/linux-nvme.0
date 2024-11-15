Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1AFD68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 16:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=veMkJq9q+kGKKZj9Qv5GNLbU/IHDs7X+vABTAhrJdco=; b=o/1lk/0aPfG60FD7p0hOLmhMTd
	757t+0xgZLfiBiAQHpLovyGF09IdjF9fJl4OMmTKY3KLY6plw3h7iGO/Y99Vb9Ksf/67CjDUPIsZV
	tHBdQRRHhhkjesU1+VKIDVWPLjyRPN1eubQjWojx4xktVsi9stEUWc1dO4CB+8tYeWLwGQWfl49MU
	13lkePsbmnmvJ43PxIR2U5s06tYiFlvuOy//wn0woH4WaYJbslzlN/MkxaVYr7K83bDUCQjbm97PO
	dpqWbBiDtlBYetzOGRoAeoy0F83imaGgXuXXpjkT531G54m3Dkv+PseRLdmaomChIrVNAMWr2uoOZ
	x3Uacp6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBza7-00000003Rjo-08tE;
	Fri, 15 Nov 2024 16:54:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBza4-00000003Ri9-2p4p
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 16:54:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B41D67373; Fri, 15 Nov 2024 17:53:49 +0100 (CET)
Date: Fri, 15 Nov 2024 17:53:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	Pierre Labat <plabat@micron.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [EXT] Re: [PATCHv11 0/9] write hints with nvme fdp and scsi
 streams
Message-ID: <20241115165348.GA22628@lst.de>
References: <CGME20241111103051epcas5p341a23ed677f2dfd6bc6d4e5c4826327b@epcas5p3.samsung.com> <20241111102914.GA27870@lst.de> <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com> <20241112133439.GA4164@lst.de> <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com> <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com> <20241113044736.GA20212@lst.de> <ZzU7bZokkTN2s8qr@dread.disaster.area> <20241114060710.GA11169@lst.de> <Zzd2lfQURP70dAxu@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzd2lfQURP70dAxu@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_085400_855751_875C5BA2 
X-CRM114-Status: GOOD (  17.06  )
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

On Fri, Nov 15, 2024 at 09:28:05AM -0700, Keith Busch wrote:
> SSDs operates that way. FDP just reports more stuff because that's what
> people kept asking for. But it doesn't require you fundamentally change
> how you acces it. You've singled out FDP to force a sequential write
> requirement that that requires unique support from every filesystem
> despite the feature not needing that.

No I haven't.  If you think so you are fundamentally misunderstanding
what I'm saying.

> We have demonstrated 40% reduction in write amplifcation from doing the
> most simplist possible thing that doesn't require any filesystem or
> kernel-user ABI changes at all. You might think that's not significant
> enough to let people realize those gains without more invasive block
> stack changes, but you may not buying NAND in bulk if that's the case.

And as iterared multiple times you are doing that by bypassing the
file system layer in a forceful way that breaks all abstractions and
makes your feature unavailabe for file systems.

I've also thrown your a nugget by first explaining and then even writing
protype code to show how you get what you want while using the proper
abstractions.  But instead of a picking up on that you just whine like
this.  Either spend a little bit of effort to actually get the interface
right or just shut up.


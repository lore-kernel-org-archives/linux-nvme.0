Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C1AE88D70
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 04:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wlvLXwJfFjZbNs8KeJ75jbz3sMVhqOGXKKb58Lo082A=; b=VNWOJ5D4Tli8zyJ854ePJTNGVe
	YN7UWG9JQ57ohA+HkTfuBTtIE4xMdhGz97CFK5SkFfn6ZprbGutks6/h4IeI+F9YLNDjqUTMbT2eB
	Q8F+6cjMHsYvKkiPZPdS/rjQ0u4Yd1LpG3NiWsPO0YsnhHkQcAJMRcepHsfg5+ibkCsQfwMwVaDen
	6CTPA4Ey2oUtVrfTDM2LLKKC9Xe6FqOskR0wpm7EaQSky99k3yrG3EHfvTWeWBqHSzNF8OLYnx/Ew
	C7sjXYyMek44SWPxDF7L/cBrMCcDdVFLvoQeAF0HmohY5DVvolW2a6ReEw6vL/n5reTTTqO+yBA1A
	zxxEa0zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ssC-000000037Lz-1ulZ;
	Sat, 04 Apr 2026 04:44:40 +0000
Received: from mail.ispras.ru ([83.149.199.84])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8aw7-00000001osq-0Se8;
	Fri, 03 Apr 2026 09:35:32 +0000
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7C6E8406C750;
	Fri,  3 Apr 2026 09:35:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7C6E8406C750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775208922;
	bh=wlvLXwJfFjZbNs8KeJ75jbz3sMVhqOGXKKb58Lo082A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkajyW/MO2/WOtf2CjU7BA1zf+P12pO0nzZUK3ic6z9goAhAh/LpcCOw758fUn1+l
	 pjThZBskY0/QlKbnsWNFBMbHwoP0x0TK8fopvjnWZNjQc5p3bgHz9sYLL2qUY4leqf
	 ePN3zoAj1yOaWjRBs6Nf1aFS61xyY8SnKLCM1bbg=
Date: Fri, 3 Apr 2026 12:35:22 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sven Peter <sven@svenpeter.dev>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Sasha Levin <sashal@kernel.org>, 
	Peter Wang <peter.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Seunghui Lee <sh043.lee@samsung.com>, Sanjeev Yadav <sanjeev.y@mediatek.com>, 
	Wonkon Kim <wkon.kim@samsung.com>, Brian Kao <powenkao@google.com>, Hannes Reinecke <hare@suse.de>, 
	Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 6.1.y 5/8] nvme-apple: remove an extra queue reference
Message-ID: <20260403123041-90f6c38394b8f71e66844864-pchelkin@ispras>
References: <20260401-pliny-ashley-ff03a0b6@mheyne-amazon>
 <20260401232116-53765a086f3855a30962fb81-pchelkin@ispras>
 <20260402-anti-cuba-1ea02cea@mheyne-amazon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402-anti-cuba-1ea02cea@mheyne-amazon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_023531_323422_142028E3 
X-CRM114-Status: GOOD (  23.19  )
X-Mailman-Approved-At: Fri, 03 Apr 2026 21:44:33 -0700
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

On Thu, 02. Apr 12:31, Heyne, Maximilian wrote:
> On Wed, Apr 01, 2026 at 11:45:57PM +0300, Fedor Pchelkin wrote:
> > Hello,
> > 
> > "Heyne, Maximilian" <mheyne@amazon.de> wrote:
> > > From: Christoph Hellwig <hch@lst.de>
> > > 
> > > [ Upstream commit 941f7298c70c7668416e7845fa76eb72c07d966b ]
> > > 
> > > Now that blk_mq_destroy_queue does not release the queue reference, there
> > > is no need for a second admin queue reference to be held by the
> > > apple_nvme structure.
> > 
> > This patch is probably buggy in upstream.  It removes extra reference
> > ->get, but doesn't remove the corresponding ->put which is located
> > inside apple_nvme_free_ctrl().
> 
> Now I'm seeing this as well. Has the same problem as the pci driver in
> 6.1 where blk_put_queue is called from nvme_free_ctrl() and again from
> apple_nvme_free_ctrl(). Thank you for catching this. I don't have the
> hardware to test this.
> 
> Are you going to send a fix upstream? It's looks to be broken on master,
> too.

I don't have the needed hardware either but will send the patch for review.

> > 
> > That said, the other part of the backport series FWIW looks good to me,
> > and I've also verified it resolves the 6.1.y regression.
> 
> You may leave a Tested-by if you want ;-)

I'll leave it for v2 then.


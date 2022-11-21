Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09633C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 07:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FHbhu08gNk5t+fnOpKzzprD4vOC9Usb24XnLYVQH5iU=; b=Qzjg5bw9aWKBeIU2U5Fik1yQdp
	N6y/gcGvFqd36ESxIkhoHNQfz+7akgsaqFSW3+jvx/6fRbSWEF8wPKdf9kzOuVR+If65ZpPUY9z/+
	3kZm0NpnlTfQVguy3F0y4ALwF8cfGT91vvhlBBc28rU8xQ62K0yjm8/ll4cIhDZ+9QAI9VQIOMAON
	UxpzAe0cSFJWCctD7bOvRhBHM9jG8f7T5/9+E9I0VRpn2HVDlXvyu7+EXbOEm+22DBnEtsy8WP5Po
	sv4RUCQTzyIZjQoOOGC65GOwZMA1IleM48rCO4SiSzc6EivXHCxmEMuL1QS2AS3tyg+0kJnjlb70M
	GtMoZFUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1W3-00AZr7-AN; Mon, 21 Nov 2022 07:46:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1Vz-00AZp6-Ah
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 07:46:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1BCFA68AA6; Mon, 21 Nov 2022 08:46:48 +0100 (CET)
Date: Mon, 21 Nov 2022 08:46:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221121074647.GD24507@lst.de>
References: <20221116130104.2186334-1-hch@lst.de> <256d34ff-3979-9780-4426-6d913a3a9707@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256d34ff-3979-9780-4426-6d913a3a9707@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_234651_554341_3CF6C1F5 
X-CRM114-Status: GOOD (  13.52  )
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

On Wed, Nov 16, 2022 at 08:49:42PM -0700, Jens Axboe wrote:
> Honestly, I think this is a mess, and it's exactly why I didn't like
> going down this path to begin with. I'm assuming that last 'now' above
> should be a 'not'? This approach is not going to be maintainable.

What else can be we?  Allow people to put the driver into all kinds of
weird states without us even knowing and just deal with it?

And yes, it is a mess but so is the complete lack of layering in
NVMe (and a lot else..).


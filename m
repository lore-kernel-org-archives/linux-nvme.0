Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A82DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 06:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8nNcmiQWw81uhO1BpHp8hoCkYb4tAWBWEU791ewlONk=; b=Xr8ojVhChjeyqInwp70q0uPH+l
	PpsKotpRZLC5NISJNQuzYtq8bkPacqyeNEt8vM7j70S2LOQTxUDpqlIMuZS3LXPUPrCdzrdXOyMzf
	kePowBzaKh129tiwCvOX9wCynLSIk16+Ea91+vTDKgleIMffgJWOTalIiiItpsv7qOH5wMPblOOtf
	JHUMoCcnpCsAn/Vts7wv2awhxbpsZM5YWEzaNV1R+oiWPPbYbpg0AukKmFCcTyNarBIDg+55/w2qw
	gXkwiwX83Xx6VKSOUzN5CTp90YoOew//4hSqbfffOBWRXwafxbHinXGu2O9EaaZCuC8BKVdsRempJ
	Nhsb4p9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXGmR-00Fn8r-4Z; Thu, 24 Mar 2022 06:17:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXGmD-00Fn34-Jm; Thu, 24 Mar 2022 06:16:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D871768BEB; Thu, 24 Mar 2022 07:16:50 +0100 (CET)
Date: Thu, 24 Mar 2022 07:16:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sven Peter <sven@svenpeter.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 7/9] nvme-apple: Serialize command issue
Message-ID: <20220324061650.GB12330@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-8-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-8-sven@svenpeter.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_231653_825123_993104A8 
X-CRM114-Status: GOOD (  14.23  )
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

On Mon, Mar 21, 2022 at 05:50:47PM +0100, Sven Peter wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> This controller shouldn't need serialization of command issue since
> the SQ is replaced by a simple array and commands are issued by writing
> the array index to a MMIO register.
> Without serialization however sometimes commands are still executed
> correctly and appear in the CQ but never trigger an interrupt.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> [sven: added our best guess why this needs to be done]
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

This really should go into the previous patch.


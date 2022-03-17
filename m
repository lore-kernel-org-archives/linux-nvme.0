Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BF3C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Mar 2022 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ggiw5fQyf6Gbd87VNO7aC1zqIMOx1BmTS3MtIe0hMk=; b=tAeAy7tPCa6Tg8Rqauf0ThRo0l
	KNXr5+K6PtnJVGMc8XhBNb8ejC4yWn1YVaZe2Tmq2iHxI+PFdWwH/oEDWExCcMO9l9x8TUq1PQIBx
	nzLsLO8MeyEyLiHqYfzT0wzIGqglxlUM8oCU0a7W2w1udlVrwQCPOpBhBVYBs6e9lkXj9hiliUCXn
	mi7wWrboQN3vYXsLS0N6azNpv8jeJaArf6DKIhill6EttLKrk7EyGce4+la6qV01H6WL9eNiffcyG
	9wnh4i667GfqhlojgORXaBxqavbitKLQpGO4ImaQ/daI0yTM97s7sleCuAkDKrMf/gbGNEMMvcNxN
	YSmE2a+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUteE-00Gsza-9h; Thu, 17 Mar 2022 17:10:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUteA-00Gsyk-RN
 for linux-nvme@lists.infradead.org; Thu, 17 Mar 2022 17:10:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A04C1611A6;
 Thu, 17 Mar 2022 17:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E86EC340E9;
 Thu, 17 Mar 2022 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647537045;
 bh=X39R4FQ/x4nZo2jv1DIbnYCKF4y0knuFmpo5vgzXrE4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pdxHC5os8oZCBIRCvPA/pv82YQvkB4QM4R3ZeV2+8yGKaNIUN7wFH4w5bqsnbFLkc
 gKVTo6jJpYOna3TlhMQXzQ8p40uqlq/VA1V6vWruCIoXE+UlCbl5WCixqf2aojSvrW
 x1Q62Qo05y1uZ1yKi37i8FCPSwMWweOWLBhJcYuw9ajTog1r1Vtd+LQY62+MVkf8GW
 i2rWsDeEJQfPG0JsXbcgrhMZSaMzeeQFOu+glU8xpKCUvxMz5NMu+KAa9odlHBh0l4
 X9Ks70MPZ8aAnssLbeCKC3PL5L5+U6EwUFD67bnZ1vqE+W0obVUHqOktk+wmrYivX/
 bxP10nA5f6QRg==
Date: Thu, 17 Mar 2022 11:10:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mark Hsieh/WHQ/Wistron <Mark_Hsieh@wistron.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] [v2] nvme-pci: disable write zeros support on specific
 SSDs
Message-ID: <YjNrkknvwFYhW3ME@C02CK6Q3MD6M>
References: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
 <20220315132202.GA12452@lst.de>
 <TY2PR02MB2752B1742028968B3DAE02EBEA129@TY2PR02MB2752.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR02MB2752B1742028968B3DAE02EBEA129@TY2PR02MB2752.apcprd02.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_101046_980544_644A8EB3 
X-CRM114-Status: GOOD (  17.32  )
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

On Thu, Mar 17, 2022 at 07:03:52AM +0000, Mark Hsieh/WHQ/Wistron wrote:
> Sorry late reply as it take a while to confirm with Micron engineering team.
 
It would help keep the thread readable if you send mailing list messages in
plain text. 
 
> But more importantly something seems really broken here if the device claims to support Write Zeroes but then doesn't claims it is not supported.
> 
>   *   We support write zero command indeed, but if host send too much write zero commands in due to the architecture design, we need spend lots of time to handle it, so we want to add 2450 in the google check list to resolve this issue.
>   *   2450 doesn't violate the write zero command spec, but total write zero command handle time will be too long for host point of view.
> 
> Can you see if this only happens with some I/O size?  With our without the nounmap flag?  Does the device report non-MDTS command limits?
> 
>   *   If the LBA range of each write zero command is quite small, it will let drive spend more time to handle it.
>   *   With noun-map flag (Deallocate = 0)
>   *   We report MDTS as 256KB, but write zero command doesn't take it as a reference.

The driver already limits Write Zeroes to MDTS if it doesn't report non-MDTS
limits. The spec doesn't require a driver do that, but we do out of an
abundance of caution.

So you are saying that sending many small Write Zeroes is taking more time on
the drive side compared to a single larger Write Zeroes? Would it be successful
if we weren't splitting these?


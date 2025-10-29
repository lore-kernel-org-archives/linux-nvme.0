Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABF8CCD1BF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 07:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eqHXfSnAIEHc8C44+lPKMDpg791Qj89f0A7UB4bdnSI=; b=naiZIixPBjNIOVLGlSvVr4B+Kc
	gSPdjZ9IjMCCjdbj4vkJ+L+pk0dMhV+GbOdGntZXfc9ExWaXBRTDVKnw7CUICA1IBiS07Hh/GcWIU
	PVkze8J7MGWekUM1F3MFE7zPpXICx65L49iaq9qQK/16QG/Iu0pkLpUPdtlTW/DkubMYBKbPXAsLL
	mYjSx11P//w9oqnYjoxWxBwBtaEJ7JdYhbnUM9BMFdrl5E1vSELbYykrPzXtMsW8BQAFVjpmLLWvf
	fb+Q0G0rTPno1MJ4Rvd/dPydnjFBChAzkpyFhfXjLka8rsswgepas75kUvjMAwLhuc7NYYuhuT5Rq
	jQQFalmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0qt-000000008Up-1XXT;
	Wed, 29 Oct 2025 07:44:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0qq-000000008Ty-0Ini
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 07:44:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 11554227A88; Wed, 29 Oct 2025 08:44:04 +0100 (CET)
Date: Wed, 29 Oct 2025 08:44:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
Message-ID: <20251029074403.GA30412@lst.de>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_004412_255028_BCE15551 
X-CRM114-Status: GOOD (  18.50  )
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

On Tue, Oct 28, 2025 at 01:54:56PM +0100, Daniel Wagner wrote:
> Obviously, using the correct IDs is really hard. There are at least two devices
> which share a the device id and one needs the bogus id workaround the other
> doesn't.
> 
> We discussed the idea to pass through configuration from the kernel command line
> at ALPSS. I am not sure, how far we got with this yet. What about something like
> this here?

The Intel devices are dual ported and multipath cabable, too.  Which
isn't surprising at the dell one is just an OEM version of them.

But more imporantly dropping the quirk for multipath devices is
fundamentally the wrong thing to do, as we really need proper IDs for
multipathing.  So just add another entry for the Dell device using
the dell subvendor/subdevice id that does not have the quirk.



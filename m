Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 16:48:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571C423358
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 16:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571C423358
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LOGhck8YDY7GU/jJkW2SJ6920+XS36rgpeJsj/ncZOk=; b=vGxTmhyWDtJatjaNd3aC7FeBL
	zJh5rBVhIxRh0hGOTwRLKzlW5hAhPW/HfxT+IKAmbyf4XwbYbJ5hYL1Z/EAKyvIfl+7l//Tre/HNa
	AnZweHou9/9V4AXax4pwpvwz9FL/a0UKp/nhUazXIbYvygGN6gLGFZrxvMvLm+kv4av0YOE76seBb
	sTGySzqgyYOYoiJVyWMSGn5yavDQsgOCx73AQOfy9HYNIFFwnXzDY7m6k5GfLEgkvwqoygWECYZPq
	qUupk08sISKZWjj4MWs3oD+3V+kRVVYk3duZJ/a5KI+iBjAl96z+Rn1MyVXuiMQ5nCC/BuxFDx76j
	Nv6riZ0qg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2Gel-0005Xy-21; Wed, 20 Jan 2021 16:48:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2Geh-0005WE-Dy
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 16:48:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3579A68B02; Wed, 20 Jan 2021 17:48:25 +0100 (CET)
Date: Wed, 20 Jan 2021 17:48:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marc Orr <marcorr@google.com>
Subject: Re: [PATCH 2/2] nvme-pci: fix error unwind in nvme_map_data
Message-ID: <20210120164824.GA21874@lst.de>
References: <20210120094915.3198346-1-hch@lst.de>
 <20210120094915.3198346-3-hch@lst.de>
 <CAA03e5Hb49rpNq2A8hmvo6tVrLnon0yAUiZvWvd8THCXyDQ-kg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA03e5Hb49rpNq2A8hmvo6tVrLnon0yAUiZvWvd8THCXyDQ-kg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_114827_608821_A3BEC27C 
X-CRM114-Status: GOOD (  11.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 20, 2021 at 07:23:39AM -0800, Marc Orr wrote:
> On Wed, Jan 20, 2021 at 1:49 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Properly unwind step by step using refactored helpers from nvme_unmap_data
> > to avoid a potential double dma_unmap on a mapping failure.
> >
> > Reported-by: Marc Orr <marcorr@google.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Should these patches go to stable?

Yes.  I've added the proper fixes tag:

Fixes: 7fe07d14f71f ("nvme-pci: merge nvme_free_iod into nvme_unmap_data")

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

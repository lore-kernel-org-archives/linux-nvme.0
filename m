Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC1CCC6B38
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPAPoWpMnWCgERM6/03DlQ93cyR83ZzdetBkwnMCxoU=; b=hHcLiujRNvCZ/RWUapXzdD+jBX
	rF/RKr13k92F/ILNheIJH8z9bPkxKpDdznpMTEbn4rqa3wg5iujuIIHYlCqHpHKHYiPwQi3g8A4Xa
	eSUBl6bpPrGCOYLa8IaAHt7KgfBu8dofpsqq1SmwaXsk3yLZDU1PNm2jZX0EkQahFJIGbofdxEPRz
	cSc8baR4M5Slznt70AQdPWgcr3kCQegucFLwOdsQss5TzbEp88aZpGXvwr4YB2wGo7+PCpkHkx08K
	tnByKjNZeZUNPzk7cZU5qq6B0lsbY/eOx3fUxy9tixOjQVZ0bhU8Nv973V5GT8cpe+wGf5xmNuN3c
	X+2jF8EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHm9E-00000003bO5-2Sm6;
	Fri, 16 Oct 2026 17:55:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHm9C-00000003bNS-2U9h
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 17:55:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A78C260202;
	Fri, 16 Oct 2026 17:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE6D1F000C4;
	Fri, 16 Oct 2026 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792173313;
	bh=mPAPoWpMnWCgERM6/03DlQ93cyR83ZzdetBkwnMCxoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T1+96Y+Mqeok+XmzPCMqvuWtVWUenQmiTw+1ry/2++I2V3Vra9Dgi+RKvemBYDXsV
	 NKRfwBfUycnt/D2MqENH9ZEEOI7/zy/X7JapPxITQ/SkT2973yajxBa62hGFFcgpOE
	 qZX81q4jMv6jKKfFbRXnwrX1v9Qj/rcqhPzKQlD1ufpsk9VANorhbrGKmqSBJZNj9w
	 GjXi1WsbHw5zRNWNybKjeLMk3W5lmA1VvbYlbhjExpbQZk1RJRblmgJgT/ice6gmW7
	 QKoEmAFldQm9+lVOqPMDCqOzyuhmY/B9M6xg71JIXr5Md3WOin1S+rQUpVQRvPBOHn
	 scoEgzZ+9AxQg==
Date: Fri, 16 Oct 2026 11:55:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	Erwan Velu <e.velu@criteo.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
Message-ID: <atJk_2FmzjUZYO_Z@kbusch-mbp>
References: <20261016141208.2641974-1-e.velu@criteo.com>
 <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
 <atJeazM_rJ0uj3vt@kbusch-mbp>
 <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
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

On Fri, Oct 16, 2026 at 07:43:24PM +0200, Erwan Velu wrote:
> This disk is configured by default with VWC_PRESENT enabled, but the
> Volatile Write Cache is disabled (NVME_FEAT_VWC_ENABLE=0), so the
> device has a Volatile Write Cache, but it's disabled.

...

> In this table, with my patch, I've enabled and disabled the volatile
> write cache using nvme set-feature -f 6; this only affects
> NVME_FEAT_VWC_ENABLE, and VWC_PRESENT is still reported as present.

...

> Hope that's make it more clear,

Unfortunately, no: there are contradicting statements here.


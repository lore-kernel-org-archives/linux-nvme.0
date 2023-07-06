Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A199EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jul 2023 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UdIp+nEXw+C5MAmBoBJzWP172u2PlADEt9KjFZMwCzI=; b=hTWQ6To00cRS1ORrAKGI/pRM69
	s1JZiEvOgxk2wOXzyjbIHKNcweXcEvtXDxjHb9rmUUmvfuE8QscRvn4wmNGx8yPM+CuAJqmCs1+5r
	lLDfC414bpzfZ+4RnNKtpJX6Iz2P2rsiqK3v58Hv2uwWLGnfHZCrBebtbb+cIN3vfrPljC9SJ3YNM
	0K+lcZeV0bx8SkPhOv9IJyuBwBf5/qTIXSEfxquW4vLMz441FUGwEWpAM8b3blXZ0dPAEpO6nKXD3
	qCXWWcFTrdTPimSlE1q59Na+UqDmU3PmyIeIKhmZCizzBfqASfugw+VbGYyhOQjAA1W9vYchaZrMk
	j0U3iJXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHQqP-001zto-1N;
	Thu, 06 Jul 2023 15:24:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHQqM-001ztF-22
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jul 2023 15:24:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 43DC260A20;
	Thu,  6 Jul 2023 15:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEE2C433C8;
	Thu,  6 Jul 2023 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688657068;
	bh=+00e39QnG95fJ17P12koDbMccqG+KIhfDMOfWR+/EM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGaG7F/qewGDHOb3MLw8W+QrHzR1PaVITchpeNAxKO0RFIFMS0Lq1D3MVcbYusnTE
	 CP3tGKk/2ItuRzn8e0zMuvL7ubARFvZqdCA9fyag/4j6EkgofGT9n6KSKS6uKerWI0
	 1axJ1MqyD8f7O4DrQOeaU+HU8HRgS8MFNoJNntTtSDcNLBLihk+tdsRMdCPj84Z4Iz
	 sIUVUU5GfJ8BB9XIkHogaRAm+FkSVttITxAYyVVJwTGs8boDRfzAxaS+Namnghwuvy
	 dCgBFRejFXsMj2MCTrldXJRP7ZJc35qb5Euf2vu8gywFW/Jy1q/rOoTuVgjI/W8fic
	 lgwUncx5JPGwg==
Date: Thu, 6 Jul 2023 09:24:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] nvme: ensure disabling pairs with unquiesce
Message-ID: <ZKbcqrjuwlW23WV+@kbusch-mbp>
References: <20230630174706.3807872-1-kbusch@meta.com>
 <20230706125134.GA12730@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706125134.GA12730@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_082430_733436_BA18B8B9 
X-CRM114-Status: GOOD (  18.68  )
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

On Thu, Jul 06, 2023 at 02:51:34PM +0200, Christoph Hellwig wrote:
> > +static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown);
> 
> Can we rename nvme_disable_prepare_reset while we're at it?  The
> name already is a bit suboptimal in the xisting code, but with
> the new calles becomes really confusing.
> 
> nvme_pci_wait_for_reset_and_disable is what I could come up with.
> It feels a bit too verbose, but at least it's descriptive.
> 
> > +disable:
> > +	if (!nvme_disable_prepare_reset(dev, false) &&
> > +	    nvme_try_sched_reset(&dev->ctrl))
> 
> Why do we wait for a reset just to schedule another reset here?

nvme_disable_prepare_reset() just waits for the ctrl->state to become
"RESETTING" so the code path knows no one else can schedule a reset
during disable. The actual reset has to enable happens later.

The following nvme_try_sched_reset() just does the required 2nd part if
the state change was successful. The only way that should fail is if the
controller was removed during the disabling.

There is a problem with multi-namespace, though: the reset_work
synchronizes each request_queue while in the RESETTING state, so if each
request_queue's timeout handler blocks for the RESETTING state, then
it's a deadlock. I will need to reconsider how to fix this.

> Also I feel splitting out the changes to wait for reset from those
> that add the unquiesce when we can't reset into another patch
> would probably help beeing able to understand the changes here.


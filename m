Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64851C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 17:09:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E6B61053
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 17:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06E6B61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=movementarian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DZhOvqeh2e3iOLAMOZGHUrzN4LD7ujq4oWRYk+ny2yg=; b=fgcESB7WrTUZfQFFFPnJ/mhJqu
	Ep9NJlNeYQpqjm8mA2awOda23+z2Gcn3FFUBy9Dz8B3VAGV/kgi3Roo+6Z3sWMKaE4xNNltvOgw/2
	blXzZ0aC00ztZPbRkj4WZzLfYXcI/Jef/zrDYqRa0B4YTOSCRfY/lYkm5ag5pYBOcpLdtORnpQm2u
	wFh02xs39jKUdbpW9NZr2od3IFB7omTen9uvGIdT9PGRH1iU9gSGMYVMyNeHUaS12DLKcV2CuKmYR
	lb2PZYi5vQ7a+mANylARQsffifCwWRiSjlzKQfOUiLNa2DrVdziCKhabC4RWI6Wo72ux41RWS/U04
	8emnhZpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb4Eb-003wsp-3E; Thu, 14 Oct 2021 17:09:37 +0000
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb4EY-003wsR-9u
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 17:09:35 +0000
Received: from movement by movementarian.org with local (Exim 4.94)
 (envelope-from <movement@movementarian.org>)
 id 1mb4EU-003hGV-Fj; Thu, 14 Oct 2021 18:09:30 +0100
Date: Thu, 14 Oct 2021 18:09:30 +0100
From: John Levon <levon@movementarian.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 2/2] nvme-pci: remove cached shadow doorbell offsets
Message-ID: <YWhkSnjjTo3YioC+@movementarian.org>
References: <20211014164543.1821327-1-kbusch@kernel.org>
 <20211014164543.1821327-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014164543.1821327-3-kbusch@kernel.org>
X-Url: http://www.movementarian.org/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_100934_368281_E8302806 
X-CRM114-Status: GOOD (  10.09  )
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

On Thu, Oct 14, 2021 at 09:45:43AM -0700, Keith Busch wrote:

> And when this feature is in use, the specification requires all queue
> updates use this mechanism, so don't don't treat the admin queue
> differently.

Hi Keith, I think you might have missed the other email from me?

This would cause implementation difficulties for a controller, right?
Currently we presume that the admin queue's shadow doorbells aren't valid, so
always look at the BAR0 location. Given we need to support older Linux versions,
we don't have any non-hacky way to handle this: we'd need something horrible
that presumes those Linux versions - and any other driver implementations -
always leave the admin queue shadows at zero, so if we see a non-zero value, it
must be doing shadow doorbells.

It's unclear to me what the advantage of fixing this is, given Linux has been
out of spec for so long.

regards
john


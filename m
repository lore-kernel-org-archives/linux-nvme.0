Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0251DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 17:49:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79E26105A
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 17:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C79E26105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hqctqr/lM812x6fw7URFVgleoBq/Bu99fiP57v88R0k=; b=aqw3mO/xFDFedQv1oBgrnp3FPP
	Y25/i8pt2JfEEnm83K5xWA17N7GMyoYJ15FH+WItkQSBxUP9GArUlI4ZuBLPwP3YVz2nTJrrWUY6M
	X/FvzmOlJbGtNeOg9rUnSytYXrKliulL8QUGqJmLqo3sL2+iYQWjnz2HaSUexa2P43Lz2U5gPVDGc
	Wd0g7iHbX9ZKrupAH90WKvVf8jkOJXqwUkZhcK413/PNeAcl9jj1y5PqwQ+8i78lo48EvLEGW4NKc
	dOE3m5+/kZNh4soBEDzW91O7C/kiR0UlpvoEQrD5BvjORiKpWKe5K8+dCTh+5Lor8L+gUWzxpMpu3
	Mt3oxxWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb4rP-0040TF-Pt; Thu, 14 Oct 2021 17:49:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb4rN-0040Si-Dv
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 17:49:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C107061056;
 Thu, 14 Oct 2021 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634233781;
 bh=YU3EtYnixobIdUS9ABbN2yMAWsvGR8HPbAA8iK9hxmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aF/Ij8Ft7Kyu9cwCF3Ei9tsUvlRWxIybw79CMFFAZbdt2/U0myWrspgEf8YvGOkXq
 NxcHARf8mSxBtKqIwOVeaAS8i2irqUKOhvNHGcUp6sRQyxz5JuLThgABUyK/qakbea
 HEupb6TsxfEvnJOpW8jHyGnwhLSmXlpQchdXEZFNteuiUx3dh+5BSSH3eUOTyAvsCt
 LtFG9XN9PVrYJtm3TIZ3lAsKl9wzrPx7p7FsQcrly4vE01MIWv0rdZiKwtL0EHSHpN
 Bx6x3pzjAkRekdMZjPFSqnCs6UpaH3G2l2Vj3pbYoYziDXnZie80gLdDAlySjumXGX
 YKG9MqfqLVxFQ==
Date: Thu, 14 Oct 2021 10:49:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Levon <levon@movementarian.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 2/2] nvme-pci: remove cached shadow doorbell offsets
Message-ID: <20211014174938.GC1821373@dhcp-10-100-145-180.wdc.com>
References: <20211014164543.1821327-1-kbusch@kernel.org>
 <20211014164543.1821327-3-kbusch@kernel.org>
 <YWhkSnjjTo3YioC+@movementarian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWhkSnjjTo3YioC+@movementarian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_104941_514446_63C14BF2 
X-CRM114-Status: GOOD (  19.12  )
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

On Thu, Oct 14, 2021 at 06:09:30PM +0100, John Levon wrote:
> On Thu, Oct 14, 2021 at 09:45:43AM -0700, Keith Busch wrote:
> 
> > And when this feature is in use, the specification requires all queue
> > updates use this mechanism, so don't don't treat the admin queue
> > differently.
> 
> Hi Keith, I think you might have missed the other email from me?
> 
> This would cause implementation difficulties for a controller, right?

If the controller is not maintaining the admin queue shadow, then the
event index will always tell the host to ring the doorbell, right? So
the same host behvaior would ultimately happen.

> Currently we presume that the admin queue's shadow doorbells aren't valid, so
> always look at the BAR0 location. Given we need to support older Linux versions,
> we don't have any non-hacky way to handle this: we'd need something horrible
> that presumes those Linux versions - and any other driver implementations -
> always leave the admin queue shadows at zero, so if we see a non-zero value, it
> must be doing shadow doorbells.
> 
> It's unclear to me what the advantage of fixing this is, given Linux has been
> out of spec for so long.

Ah, I skimmed the part that said we are not up to spec compliance, so
aligning with the spec with any feature usually justifies itself. I see
your point was the opposite :)

I don't consider this part of the patch to all that important, though,
so I can leave the admin queues alone if it's concerning.


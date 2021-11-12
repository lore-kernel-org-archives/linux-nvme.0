Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEB2C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 16:19:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273C360FBF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 16:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 273C360FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a7MsTfsWedMtkpy0aKpM769sXADzRZObaN21LWCBI4Q=; b=NujPPfHk/tbxNQbhB8L3jm/OPd
	BhAj9D/PZ1OVKtbqIvWDEpUn/aRB616zlQQRtGQ9a0Zt4zt/w0TxZRsckiiVOtIK2sTPEa1DMKylM
	BV2W7VFdXYD20U8gzcthfGAyVhUoosY1NMqaZlR/zzHkRkeCWETjmQQgBw7yBfxENSC/CmLAg/J53
	SJW/GrnMZ55v9rp0gWOPcXlgZGhrGNpLX/Bbfjt/h1WVvkaug+hzHOhdRJ4FrsNZ4NWMy7wAhuFUD
	Tfm45lxoXP6dAdhcHX640nsPALNBZgsYfFjeVaYT3kLVYrE4rdTIhOsYevkv21Qug9l2SiwMi+sEz
	6cPxQ6uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlZGx-00BDaM-Bl; Fri, 12 Nov 2021 16:19:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlZGv-00BDZz-9t
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 16:19:26 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A819660EE2;
 Fri, 12 Nov 2021 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636733965;
 bh=deKjYhvu0O/NYaZlRwK9sf4264HaDXl4ovklMBhkI5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GzbYmrKL1OjbBPOGZDmmi1Pulfx82OWjczgjVYx6RkMwgVfsVPvZi5prQNEuTTlzZ
 RWUBX8N8xyQFqrUBRCGC7uKes4n3juR8b2sZL2lH935RiWo7rFch/dMbriJsVtvFHF
 zJxRrBu5PZ1cYWaFDrLZPqB/WyPNAUROYhceDIiM2kDLyinG3WJbLhpSiJk9c4aH9h
 1ky03lPFichzvfB5pOHivw14adT6IfXECZA9fJPtmA1HmWjANJUwYAq0Lcrx1CCdSz
 Mzelcm/dyrd1yMo3Oe2wQZs0G2G9KWJlcR6w7iuCWkBaXRLjdsZbgPHjk8E1aayP3O
 E2KdpXAfOU3Rw==
Date: Fri, 12 Nov 2021 08:19:22 -0800
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: keith.busch@wdc.com, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
Subject: Re: nvme-cli release naming strategy
Message-ID: <20211112161922.GA2889444@dhcp-10-100-145-180.wdc.com>
References: <2f583f14-bdc4-2d7c-3e3b-cbaa7809eef8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f583f14-bdc4-2d7c-3e3b-cbaa7809eef8@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_081925_379469_E90AFD86 
X-CRM114-Status: GOOD (  14.89  )
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

On Fri, Nov 12, 2021 at 04:49:37PM +0100, Daniel Wagner wrote:
> Hi Keith,
> 
> I was thinking on how we want to handle releases with
> the master and  nvme-cli-monolithic branch. I think it
> would make sense  to rename  nvme-cli-monolitic to
> something v1.x and  keep it maintained for a while alife.
> 
> And the master would be marked as v2.x. This would
> avoid a flag day release which we force to switch
> the users from monolithic version to the splited
> version.
> 
> What do you think?

Yep, I was thinking the same thing: once we feel the master branch is
stable with the backend library split from the command line utility, we
should start a new v2.x version naming. If there's any reason to make a
release on the old one in the meantime (I had to tag one yesterday due
to an unfortunate bug in v1.15), that branch can continue using the v1.x
names.


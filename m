Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE29BC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMLtHIAPRGvSMXL+Pc1HNUkoImtudH/L/kGmz6hz2pA=; b=P1QN8vIBZDBJgHw8mGdNjckpzU
	4gM3K/ILo9UA12YA/1/yjLbZgzEtoDRb63CzVZAv2LYWg/B4V/ifwHEP/2dS5jUJBxP7GGiy+ZcSF
	/mN5nlsFdhlZqo+/j+rxaeFGoeEwPEi31EKrXTMaGVQJqtyNfgx0OZGNqXudlIRxQZ9xGo+dpFRMk
	Nelc0L8ABptNEOF13xNcjYpWRf3lOIc1qDyA/bbc5pxlu5lRbRnbF+EELb9Ike47qW/4NfNdX0q3H
	nk08+LvvXPtTpwBvjpmCtJgLsH3w/LU7UlqtvB/iCn2xz3hRgAqEw/1gMDxzIAUhxUJRLPx6j9nGo
	pjYfElNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRzFr-009SDu-Cg; Wed, 09 Mar 2022 16:33:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRz5g-009Mwk-BA
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 16:23:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A8CF8615F1;
 Wed,  9 Mar 2022 16:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E15C36AE7;
 Wed,  9 Mar 2022 16:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646842985;
 bh=zF5/AdWVE/2sGvAF1NjCgoSwpKKO01Iyw23sv7yBAcs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Puf3Xq2jyikYiwy6x3RYru5BxZrdpMY3fFA6CnP22nyu30M9GMAGtNAV65BkXHNxe
 Dg9fIhk8t5HQOHVJSY8htKsRmjJFLAYScFApuuEyzgGr5xdr1vdITbEyuhbJ531k+j
 KspsW239sHOwLJvqEUmtjyYfnLhOO/g1mvFqC0b3GYkukAkS/P0rUK2U/3ruxu/3FX
 VzMjH+TxQiaAddZlllnZKh8JMbMWEiuzaDK3uNiPpuL4E3jshocjgBSc/2NuvqHCBj
 ycxNtuoL/7OVSPimjarMF0JkUqzvJKqNE2CfZhpyKIQX1gmlos06/67TaIxZQT3DxU
 dqHjrusEqW9OQ==
Date: Wed, 9 Mar 2022 08:23:03 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 axboe@fb.com, Sagi Grimberg <sagi@grimberg.me>,
 Ming Lei <minlei@redhat.com>
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220309162303.GB3949054@dhcp-10-100-145-180.wdc.com>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220309062630.GA31508@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309062630.GA31508@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_082308_475382_1313F6F8 
X-CRM114-Status: GOOD (  22.66  )
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

On Wed, Mar 09, 2022 at 07:26:30AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 08, 2022 at 05:45:20PM +0100, Maurizio Lombardi wrote:
> > We suspect that the root cause is that the nvme-host driver doesn't
> > enforce the 4096 byte limit for the IDENTIFY commands as the
> > nvme-target does (see the nvmet_execute_identify() -->
> > nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE) code).
> > So if we pass a 8192-byte buffer not aligned to the page size, it will
> > need 3 pages on archs where page size is 4k and the nvme spec says
> > that the data buffer may not cross more than one page boundary.
> > 
> > Does it make sense to you? What's your opinion on this?
> 
> Combination of a broken application (does what the spec explicitly
> tells it not do) and broken hardware (does the most stupid thing when
> fed invalid input), not much the driver can do here.

There's nothing the hardware can do either to know it was given invalid
input here if PRP2 is page aligned. There's no way it can tell the
difference between a PRP List vs PRP destination.

> But we really should talk to the nvme working group to ECN the text
> for the single PRP requirement to spell out the consequence in more
> detail, and maybe also mandate how it is handled for the next spec
> version.

It's not a "single PRP requirement". The spec just says the "data
structure is 4096 bytes". This can validly span 2 PRPs if the first one
has a non-zero offset.

The spec created the "NDT" command field to help detect mismatched
host/device PRP expectations. Unfortunately it only applies to
vendor-specific commands, and no one implemented it anyway.


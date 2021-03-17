Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5458C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 17:02:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBF661580
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 17:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBF661580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1QfSmyOkBsY+ogWK/3ZzOlzLL5s2/Gem8cZaNChtNmo=; b=Yc4ja7/Kwn3Ir/f+olZlkSW7F
	GcuwISuvd/kAo6U+CNUkh8rXg96oPNgupKdieG6HZlrl27bpeiu30ABtMuebsBvLF7zIN30lsR94Z
	sbSn8ncISA6qlZ8FLuPk0J5hrMc9QBF+eW4X9ZHS74jhCfwGSYURDvPtqm+zIEnc0oxxK45W/rdrv
	axf6/SCcc4UKDtIN8SILSHRVO2Qfj+27+8TlZWbhPPoPGhgOk0M4xpKcZpW8SwVqtVMOR6Kdop/zA
	lBky1/ogLrMKBmHXWLTwpTa0PfiKa9UO6BoZHRiW94DlTniv+Fk3qibIwQs3f2VsfCIbaHx9xxSL+
	T0BiUthiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMZYn-003bGg-Pn; Wed, 17 Mar 2021 17:02:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMZYj-003bGK-S0
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 17:02:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4935068BEB; Wed, 17 Mar 2021 18:02:12 +0100 (CET)
Date: Wed, 17 Mar 2021 18:02:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
 chaitanya.kulkarni@wdc.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
 javier.gonz@samsung.com, nj.shetty@samsung.com, selvakuma.s1@samsung.com
Subject: Re: [RFC PATCH v3 3/3] nvme: wire up support for async passthrough
Message-ID: <20210317170212.GB25097@lst.de>
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140240epcas5p3e71bfe2afecd728c5af60056f21cc9b7@epcas5p3.samsung.com>
 <20210316140126.24900-4-joshi.k@samsung.com>
 <20210317164550.GA4162742@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210317164550.GA4162742@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_170213_966691_5CFF31F1 
X-CRM114-Status: GOOD (  16.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 17, 2021 at 09:45:50AM -0700, Keith Busch wrote:
> > +	if (ioucmd) { /* async handling */
> > +		u32 effects;
> > +
> > +		effects = nvme_command_effects(ns->ctrl, ns, cmd->common.opcode);
> > +		/* filter commands with non-zero effects, keep it simple for now*/
> 
> You shouldn't need to be concerned with this. You've wired up the ioucmd
> only to the NVME_IOCTL_IO_CMD, and nvme_command_effects() can only
> return 0 for that.
> 
> It would be worth adding support for NVME_IOCTL_IO_CMD64 too, though,
> and that doesn't change the effects handling either.

There is no good reason to support the non-64 structure in new code.
And we really should support the admin command submission (on the char
device node) as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

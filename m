Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F905C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:53:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D988D64DE1
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D988D64DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8DFWm/wmpJE4zalGMzyS69r8GnVvmrjysZl0VlvOHZI=; b=Uf4IAZkjIb9i1Iun0NT+KnDdU
	clcnKRWaKdJvr/RpOp+SlG7QyoM89zOqTmXpWIZyPjVfjr793lBJqJ4eILsfIER8I1DZDkdxMMqZY
	ZCpcBcsqlGvec3CDm4TqemdBHvMBLIuMdPB4gwJMVBNoAhtd0UpCLjVEvWQlisWSsTD/hlsnMzMhN
	v2RlerPEFSAbddQBlp1AmCmOtg9d+pwjgjIeodAfrPXrAO81Ot6yRb7D+s7+fiyGyfzV5u7iU/18W
	t3VyzfdZA3faGWnWKjJVnzCnlu+tv3pY+iSXsbjC2xWyp9O4UoL+/PXwxyXSiZJvfocTq/hS+yfUl
	Sy4RcibiQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Zpw-0005Yk-1U; Fri, 29 Jan 2021 19:53:44 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Zpt-0005Xd-1K
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 19:53:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611950019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0J21DD7jJL7TSht0yci+YH5LHUMj+xx+HAE977VvT8=;
 b=Vo1HH7AEcllvVsrGdiM2RB5cyHATqwD4VEcsd/Tt3BQqs96s25lhqtxAqi0WkySveHwVCI
 J0IbU71RUqKenX2bLIcT5BivqvJQXGtl6zNs9h20Q+L9Fly18UWpWK2yUYfcqejOKpU8VY
 S1liVO/J+7qQYUhjVX55bwkoqN81DJc=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A2F1CAD8C;
 Fri, 29 Jan 2021 19:53:39 +0000 (UTC)
Message-ID: <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 20:53:38 +0100
In-Reply-To: <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
 <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_145341_229388_C0B7B693 
X-CRM114-Status: GOOD (  13.93  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2021-01-29 at 11:10 -0800, Sagi Grimberg wrote:
> 
> > From: Martin Wilck <mwilck@suse.com>
> > 
> > With this option, "nvme monitor" will keep created discovery
> > controllers
> > running even after it exits. If running in the initrd, this is will
> > be
> > done automatically. That has the advantage that the new monitor
> > instance
> > that will be started automatically after switching root can simply
> > take
> > over the already created discovery controllers.
> 
> Why not make it the default?

Well, we've had a lot of discussions about persistent discovery
connections not being universally loved. So I thought I'd make cleaning
up the default.

All this can be discussed of course, that's why I called it an RFC.

Martin





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

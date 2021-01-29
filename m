Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA0C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:45:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667E564E0F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667E564E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dOJ07hOJH/d7EWk2ynX2Z5Ax6d9QXCD7rARclA1YrKU=; b=yD4/MD56ZC1GybZjzRM5j3z+O
	FoDfdjHdlfUiwtvkGzzY7hdMW2DOLhdzGaGWSCl5Zbz47X6X2hQuiaU4iFbzKmQ9nNcdebT0wpoJs
	aNh2w00/jgguVyRsiPO1s9EdOUAjgkI0GS4lzeM2g+b+WeH4siWEdpjLIakvPQTp0Psg9YMs6JBgM
	lpKBiLX9LVFjowE8/WJzz1k4Ola1KhHIYNiImiKY4NB0ritk0LRys50HZ0rkU5dFYAMXvohY3TGtp
	viqYVSTjFHvLobWnOtnZQLXi9lizkbErG+cGOxKhZN94ZXqpniOdBQTVeK6Gfchr/zSXVlfaq4S4s
	PTxiTaCIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5ZiI-0004Jo-HA; Fri, 29 Jan 2021 19:45:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5ZiC-0004Io-Ch
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 19:45:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611949543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWxj6sjYCy84Q7+J8wM2+WvyAI2s1cuNJ2n2Cedw6sw=;
 b=Alc5e3nikEC1CGBqsHUlUOSwomX8tXRKLrlX/toYQSl2AR4Pu9qSAa9skZ9K6+VBHtaTcP
 IL4ptATaGcRSn78+Lieq11Oxq4Kqij+vB7AicOIcJchBZ/T2d+OpRrrTj7jS8Bq4NSdWPx
 8Bc+cBaTZIkku8its2NKOLy/rWodahE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3F972AD29;
 Fri, 29 Jan 2021 19:45:43 +0000 (UTC)
Message-ID: <fb3b5117db55ebb91b490d56b7817daafc5fc84e.camel@suse.com>
Subject: Re: [PATCH 18/35] monitor: add "--persistent/-p" flag
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 20:45:41 +0100
In-Reply-To: <6d6104c8-708f-d09c-7b5e-5bcd6bddf223@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-19-mwilck@suse.com>
 <6d6104c8-708f-d09c-7b5e-5bcd6bddf223@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_144544_555390_A46F4C7F 
X-CRM114-Status: GOOD (  12.67  )
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

On Fri, 2021-01-29 at 11:02 -0800, Sagi Grimberg wrote:
> 
> > Without this flag, AENs on created controllers won't be received.
> > While --persistent is probably the behavior most users will want,
> > it has to be explicitly activated, to be consistent with the
> > connect-all command.
> 
> What is the usage model without this flag?
> 

 - listen to other events that would require a discovery, currently
simply fc_udev_device. In the future, network events could be added.
 - listen for AENs on persistent discovery controllers that are created
by other means, e.g. manually.
   
See also our discussion about the cover letter of this series.

Martin




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

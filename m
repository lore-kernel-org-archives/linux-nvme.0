Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0680BC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 14:18:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B74764DF1
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 14:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B74764DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1jrhWYgk0h7b5k6gVlJL2jkPICSK+l7LX3MHF71mhPs=; b=exby4jzgK1S/jxHrpPLDp1tKQ
	QY+nIGDunxeXO2b+Bf0ElkQVM6Gl3IlcBgp89/KXhfzr/2FGmXL5ns/w4VByGZZrtN/9xPAJRP+ly
	ShfW2vX8+8Nwwskh4PioLtr9B0T5zY86NN0azV0rHe88bbmKy8CdPVpjhOdgrrV9KFnIpC03ZKXtz
	d2jvyjS9YP5zxzbRNVjenqFzQhAnVe+2JXAOy5UjNsXXOheJp6ZGwIfFF96u1kqFQkDQuPTZURK5+
	hAE8IUBW+i6iHDfD+yZ8RcW9TWQ+Gbdiu7dMff1mCKUnFuSXAaHntUJe5uWRWhRHrhgxdf3A3xW8u
	nfhvmlc/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5UbF-00064C-9Q; Fri, 29 Jan 2021 14:18:13 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Ub9-00062z-TO
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 14:18:12 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611929887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPvXblaohWa0XgHxbwLufXVc5JgrFGP6qZHTGnwIzBA=;
 b=NrqeNHxTVu8fQb1YVHH9K3xNPbHFVMEWJUuhWBXuZNQY00dQWtVHJ0CQn+46BlbR2IsxOO
 e52dCNJWVNgvD3HWJt6oJ/ZNvu6dELHnr1S/ApxOjr5RcXHDmWVAxDGkMWC280v0lj7M2a
 /nuvS06VL1ofxhKl95j/TlRbTK/O2fE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DC2CFB173;
 Fri, 29 Jan 2021 14:18:06 +0000 (UTC)
Message-ID: <292a1b5ddd336c446ae63c06ee275af165c81ebc.camel@suse.com>
Subject: Re: [PATCH 22/35] conn-db: add simple connection registry
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 15:18:06 +0100
In-Reply-To: <322b27a0-ff3e-265b-4c69-fae54466631e@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-23-mwilck@suse.com>
 <322b27a0-ff3e-265b-4c69-fae54466631e@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_091808_062137_642802C1 
X-CRM114-Status: GOOD (  15.37  )
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

On Thu, 2021-01-28 at 17:59 -0800, Sagi Grimberg wrote:
> 
> > From: Martin Wilck <mwilck@suse.com>
> > 
> > The monitor works best if it maintains a discovery controller
> > connection
> > to every transport address that provides a discovery subsystem.
> > 
> > While controllers are easily tracked in sysfs, addresses
> > ("connections"),
> > i.e. (transport, traddr, trsvid, host_traddr) tuples, are not.
> > Create
> > a simple registry that tracks the state of "connections" and their
> > associated discovery controllers.
> > 
> > A detailed description of the API is provided in the header file
> > conn-db.h.
> 
> If this is more flexible, perhaps also the main fabrics 
> discover/connect/connect-all can be converted to use it as well.
> 

Yes. Could we do that in a separate step later.

Regards,
Martin






_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

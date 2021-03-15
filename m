Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E9C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:51:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D82D64EED
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D82D64EED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RzCubtQOFddV6mXfUGDf0CZPGuLlvRPZouFY+DdEPqQ=; b=CtSPLRFLsLWjjQFfKPB7gRc8G
	7Btb+ovuSk9SEau0UsgD3qb8cip27J4C6Js1yqIEh8rParnG/wqQ9tFwcA3dKbbGOpYLbe7PSNvap
	/qvVF/KwsqeWRWp1ZnnR4i/clBcWEcVUvSS8Lqq6CKOAHRz2a2wMbdapFoRjcWiuAO7oNZz7YfvLr
	zY+zSDMklw3JCMv5XGy79ZQNCNPkEp+a/ZSZfwv07OYoUbhEnDZDTlMK0DRQrvFv3qyDlABskqCHS
	lcmRdEukepYa/WvDVm6t6ftPiozoLUPkUgk0IMKr6JLOMxFWfVkbI6+5JppzkSwtrOl9iyAunTTQI
	YK3OoqP+A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLrNZ-00GbD6-St; Mon, 15 Mar 2021 17:51:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLrNR-00GbBa-Ow
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:51:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1615830697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/PJVi9hiWnr8xUCoRzqBwZciFh6RrBCw2F90YTcoDU=;
 b=s14zfNzUX5013BIBHl7olcRdluVhWqeJIdTqVp3u5xDLKgRbk7SQezasrzWPjMdH9dYG9x
 op+Ofs1Aw/HvNOviRvggnqU2tgoyKCVwja7MKwV0IzvdhBg9ZOOfxMs73LZC58k2ypFcgo
 1QPgdG3BvQU23byXhL4I7XuC7G/7was=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1EACCAE8F;
 Mon, 15 Mar 2021 17:51:37 +0000 (UTC)
Message-ID: <de4c79b8711c0f185fdcaba3e7a3c17a1d66d42e.camel@suse.com>
Subject: Re: [PATCH 02/10] nvme-discover: assume device given on command
 line is persistent
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Keith
 Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
Date: Mon, 15 Mar 2021 18:51:36 +0100
In-Reply-To: <31587366-3fd9-4126-73bb-38419b72cfbe@grimberg.me>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-3-mwilck@suse.com>
 <31587366-3fd9-4126-73bb-38419b72cfbe@grimberg.me>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_175138_488346_7AF1A595 
X-CRM114-Status: GOOD (  16.99  )
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

On Mon, 2021-03-15 at 10:41 -0700, Sagi Grimberg wrote:
> 
> > From: Martin Wilck <mwilck@suse.com>
> > 
> > After commit "nvme-discover: lookup existing persistent
> > controllers",
> > controllers without the "kato" sysfs attribute will never be used
> > by
> > do_discover(). This makes sense for controllers found while
> > traversing
> > sysfs in find_ctrl_with_connectargs(), but if the user passed a
> > device explicitly, it should be used, even on older kernels that
> > don't support the "kato" attribute.
> > 
> > Furthermore, make sure allocated memory in
> > ctrl_matches_connectargs()
> > is freed.
> 
> This is getting slightly convoluted... what is the motivation again?
> 

Currently, users need to specify *both* connect args *and* a discovery
controller device if they want to reuse an existing discovery
controller, which doesn't make much sense from a usability point of
view. The idea is to simply check if a matching discovery controller is
available.

But if we do that blindly, we may erroneously use a temporary
connection that has been set up by some foreign process, and may go
away under us. That's why we do the kato check. But as you pointed out
yourself in your comment on 01/10, that would completely disable using
existing controllers on older kernels that don't have the "kato"
attribute. This patch changes the behavior such that if no kato-
attribute is found, we trust the user if she specified the controller
explicitly, but we don't trust just random controllers found in sysfs.

Thanks,
Martin




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

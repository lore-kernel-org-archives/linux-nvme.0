Return-Path: <SRS0=/IAj=27=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E050C282DD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 17:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511AC2064C
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 17:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KiVw2G1N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB4sy+pm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511AC2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pXj1e6Fxo9G70YQaJS3ZMvzLXZ24jbAtduTypAK7Qyo=; b=KiVw2G1N5Ml50c
	WDZfsGnD7u0BvuQwrhRWTQ4tPpKQOEo7R0rJFvUi7WF7NDGsKFdg0P6bQLb4u8ICgUyZ59caGdN7G
	6/IL1zJShEzaHqVfgPVgn1ctIdUPBmQv0Yi/zY4mXnw7Onzs6Ry5BKf1obXZioJlQX/8tq1DYyaKO
	COwDCoW1Z9N5GQnLq8jqAWENJhzh0ydfCqFZ5hF2tOdsBTlkTFKIvbvAnccO6z6vsrdvNCKku6zKV
	NfzoWq+BNZ3oZki8/zDd1I9cwHr6pzYpNpoIzqErBQZGU4iCWwnuP67sYxUYAEyG6ygMKrC1m+8Th
	p8hp2rY0328ynQfvmtag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipxo5-0004Ap-CV; Fri, 10 Jan 2020 17:10:45 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipxo1-00049z-Ne
 for linux-nvme@lists.infradead.org; Fri, 10 Jan 2020 17:10:44 +0000
Received: by mail-pj1-x1044.google.com with SMTP id n59so1256879pjb.1
 for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2020 09:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iBvXLyc1YHRba12d1qGOEAYppdC7uysd/CuW1Cdr6XE=;
 b=JB4sy+pmPxNmEF/IdqEUR4mvTdV9p7qM1GbSFbiOx+lPHtjw21+yh3LyCdNHutFle3
 oNfFdIM17nKtIUnrPFaH30yfEcIU8rZIxG+HQ/vIxaCBN9wccSmvvDjNUkHOzHW74bbK
 UbDCOFCQcWSEKDM+Zfh8d1OybJn/+DtMAe76/m2XcfjrnXJa4sOR5YPNIONcQNZT/dTM
 wI+E5MsdSSnOUcoVfETiO13aGp/6LYAQx60L27zX4xESNKkyJRm20JTK7go67aubHdrc
 j6yr4ScXzkAXLzEQCLMbRyONEGuwDDMMU7b4Pgz/I0GXhHeDS2+x1jrT8egiJhG1Y1+k
 COVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iBvXLyc1YHRba12d1qGOEAYppdC7uysd/CuW1Cdr6XE=;
 b=VUpJr0fxb4qYdawYkFjw2EpDl4MZosCjDFJOz/3JvUA6rU36ow8KwlhhelvRZTB9NM
 do1JoVwGtLeBcx41cXz4+U5p1slLqTzW8HN2FH1zjlmKKkcbUqbCFcVOBIm1F9/7299Q
 KUDtgHLR2Wb6H88z3jiS4/fophGSdxyZ97hVXtrcEjat0TdS6b33qRQqYHnKonubNeIr
 zA3wsAHhVZF2xXmfLidky1Lc61YJwCBzZWY/WNSsdWk+lEPCJ/LugUU6QypbH+5DIgNx
 LzXRT9Js6jw7WduCi9HbdwXOhH7r5XaaT5ysbdjtRKxZ79uxCopgswd1vtWTRhZMdz4H
 MsZw==
X-Gm-Message-State: APjAAAWJdsOL4JvuwGzINqihoNlWs2B8zO3D06mCCkjFgRDK7joJomLU
 /CerGZmHltTiUbNKKLNJoF0=
X-Google-Smtp-Source: APXvYqyiUQHL4oDGEs33ymGs27Au9/cwS1DqjKduPQN1wB28qGjOj93x44RdJ71530eJVmu4wl22gQ==
X-Received: by 2002:a17:90a:c583:: with SMTP id
 l3mr6263355pjt.58.1578676239815; 
 Fri, 10 Jan 2020 09:10:39 -0800 (PST)
Received: from workstation-kernel-dev ([103.211.17.220])
 by smtp.gmail.com with ESMTPSA id b8sm3730301pfr.64.2020.01.10.09.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 09:10:39 -0800 (PST)
Date: Fri, 10 Jan 2020 22:40:33 +0530
From: Amol Grover <frextrite@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] drivers: nvme: target: core: Pass lockdep expression to
 RCU lists
Message-ID: <20200110171033.GA23748@workstation-kernel-dev>
References: <20200110132356.27110-1-frextrite@gmail.com>
 <20200110163134.GA18579@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200110163134.GA18579@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200110_091041_769633_7DCA0BA6 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Joel Fernandes <joel@joelfernandes.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, Christoph Hellwig <hch@lst.de>,
 Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Jan 11, 2020 at 01:31:34AM +0900, Keith Busch wrote:
> On Fri, Jan 10, 2020 at 06:53:58PM +0530, Amol Grover wrote:
> > +#define subsys_lock_held() \
> > +	lockdep_is_held(&subsys->lock)
> 
> This macro requires "struct nvmet_subsys *subsys" was previously declared
> in the function using it, which isn't obvious when looking at the users. I
> don't think that's worth the conciseness.
> 

Hey Keith,
If I understand correctly, you're saying `*subsys` is always declared in the
function using it, right? I too think, this could cause confusion to the person
going through the code, I'll fix it right away.

Thanks
Amol

> > @@ -555,7 +558,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
> >  	} else {
> >  		struct nvmet_ns *old;
> >  
> > -		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
> > +		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
> > +							subsys_lock_held()) {
> >  			BUG_ON(ns->nsid == old->nsid);
> >  			if (ns->nsid < old->nsid)
> >  				break;

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

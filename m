Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84525C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:17:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EC0600CD
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EC0600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b9FXnMZImGwDHMrbLozpjWiD8LnEuh75le40fIvaOG8=; b=lBwGeT5dYN+bD0PBLJjoF0NRl
	Sedr6hvtLeBAwO/peefJ0bl/lBQ/HIpZHHCxxMXxbQz/Rep5PSUW3a4S4m+YLbfZAkxkTjR5knKKb
	iaOWjCz21PZgL5cSp2E1UfF1FiKzXYdmE3c7z8RfiCU8Gct082faAPGg3aDo1bRHAthzwJDX0B3cZ
	ggqKWO30wlqsj9QfPSCbROuyaFge09Hh/BOpvzoikXYUa8M0DqiBsVvFdKwtAGLNdP+JYfjrIS1CM
	MQYoN5JcfLxPxrh651BivoAZuybZ2ydqLU/pfPUwmqr91ClDXClnKFsno3gogRCj3b4IUx3uvrWqf
	M96cXNDIw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZYGP-00GfcR-G8; Thu, 22 Apr 2021 12:16:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZYGJ-00Gfbq-Cg
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 12:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=eiYxhR0n4BysWH9H/JlFnXWdptsAOXFkF+0f/vVZNdY=; b=mRccZWzBP0TNMV6ghgBf4gp34y
 +vZiE50fcoigaA2jkwCVLgyP6amNWs8NA53K/FCD9gLbZ09byc6E9z10xbL0daj/XlKjwzlleJ9tK
 XdRA6isJANOGlKeh4f2DUQy3PtaQrgOHvyZkO5s2E/lGOcmJ3pZfP41TYUg3nZeCTEqSqZ9UA2qI1
 aCLTuFmYrc1EFO4zyW+kPTHwNk1PCQ9mvcbStfKzzc8qeWWtGf3jGT6tL2wjsStM5CCN5FVoINX0o
 0RoooRtLlM01AhWfru/pCdUoJs1jUXVNwLZcwCHxHn0ZZrtsRpjBiTjFt3Vj3M5rST0LDIUl7uXIP
 HrAxw29g==;
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZYGG-00Df8S-NO
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 12:16:50 +0000
Received: by mail-il1-x134.google.com with SMTP id y10so15749561ilv.0
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eiYxhR0n4BysWH9H/JlFnXWdptsAOXFkF+0f/vVZNdY=;
 b=dF8Ev+3Wsvk5RfBiHrzcSNe9i4kJm55Je+5a6AhHp37w37YHbnCpL43wtnk+RADyae
 qfNU11hoje6Aj0qhFAdvc+ysPr+f6QiN5nMasnPXSAaG5kx454rNKl/kgX5GK9jz8RK2
 xujZnYkXV7YrYJ59rbH3JrGKl1xQybEs1cbip2X4zHMsQUB+DG0U+3hdx46U4a2URvup
 zdMDt3nCT4YyjbcNQW5MDATd3vyclNQpmNSHR0cTfDN5xPRgu1NrJJtTHbNeDxEMqtK1
 EKE1FgmAsvLwnrMvZq0aD0pNX/jeEu4SrDZBQA0fWYbcjO5OwWI4lP1eLk6ohZRMW0ue
 +kHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eiYxhR0n4BysWH9H/JlFnXWdptsAOXFkF+0f/vVZNdY=;
 b=Qc7mtLYiedO+POj0Y4wPEh3Q2vcYr3xL/6PZTaXzQLltl9HRM0F/3ZxCv6YDocSbqx
 G53iF4CQuVbuB0/e6OsbKL31f1zAaKlkLc4AHoyu3y5xRDxQXre11m4b+gEstg1yzYWk
 m6GdwAog/ezNmdoDIWbSaWG3O715AFHNaXAGyTlMenlrXnKLvwrkesCXQu2N+VqZzCjm
 tnHkyBSwc44Us7xF212v3LQJBY7TQNXPa/GuVj6K7TLHAdimiJ4ab1E1Xjcc6Et8dzyY
 Gkvivxt29zweOMi3RjQ+UY+a3fQXUf6fSGvy3naWbfuJvPGlk/8owoGiqyzKdEUWs7wo
 KlyA==
X-Gm-Message-State: AOAM532O/6mpo73Z7F9qxNxyvl3gK24DyspeYqdccIRno8kE5yKt/OsN
 3FUWewUUN+WYSCmlYHncD9/gIn+vDu5VPcW9d5pFQgHxhak=
X-Google-Smtp-Source: ABdhPJwvDPCVin89bi2BALGAGN6AALbAq5AquZS4nK4Jkq5m6/wDFYGcE8dMlQE8RZ/LIybGbiV+teYvCxUNHpAxN9A=
X-Received: by 2002:a92:7307:: with SMTP id o7mr2505636ilc.5.1619093806419;
 Thu, 22 Apr 2021 05:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <BL0PR1901MB2020A15CA929276AB8FC7E52EE489@BL0PR1901MB2020.namprd19.prod.outlook.com>
 <20210421023205.8743-1-houpu.main@gmail.com>
 <BL0PR1901MB202094CEE464326497214246EE479@BL0PR1901MB2020.namprd19.prod.outlook.com>
In-Reply-To: <BL0PR1901MB202094CEE464326497214246EE479@BL0PR1901MB2020.namprd19.prod.outlook.com>
From: Hou Pu <houpu.main@gmail.com>
Date: Thu, 22 Apr 2021 20:16:35 +0800
Message-ID: <CAKHcvQjSn1EnsfKZ4xW8LXp0mvfiTeDpFhQ1rbrfvn09v9fY=Q@mail.gmail.com>
Subject: Re: kernel panic due to a missing work initialization in case of zero
To: "Engel, Amit" <Amit.Engel@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_051648_838658_6989EE22 
X-CRM114-Status: GOOD (  25.15  )
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

On Wed, Apr 21, 2021 at 9:29 PM Engel, Amit <Amit.Engel@dell.com> wrote:
>
> Hi Hou,
> Yes, commit 7b96918a173 (nvmet: avoid queuing keep-alive timer if it is disabled) fixes the panic we hit.
Thanks.
>
> One comment:
> It might be more elegant to move
> INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
> From nvmet_start_keep_alive_timer To nvmet_alloc_ctrl
> This way, we will not INIT ka_work each time the keep alive timer is started
> (each nvmet_set_feat_kato for example, will start_keep_alive_timer)
> IMO it make more sense to INIT_DELAYED_WORK only once (as part of alloc_ctrl)
>
> Let me know what you think and if you want me to provide this minor change
>

Yes, this makes more sense AFAIK.
I'm OK with it.

Thanks,
Hou

> Thanks
> Amit
>
> -----Original Message-----
> From: Hou Pu <houpu.main@gmail.com>
> Sent: Wednesday, April 21, 2021 5:32 AM
> To: Engel, Amit
> Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me
> Subject: kernel panic due to a missing work initialization in case of zero
>
>
> [EXTERNAL EMAIL]
>
> On 4/20/21 11:46, Engel, Amit wrote:
> > Hello,
> >
> > We hit a kernel panic as a result of the below sequence:
> > In the current nvmet implementation, as part of 'nvmet_start_keep_alive_timer'
> > nvmet_keep_alive_timer work will be initialized only if kato != 0
> >
> > when nvme connect cmd is being executed with a zero kato value
> > 'INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer)' will not
> > be called
> >
> > once keep alive cmd arrives, we call 'mod_delayed_work' for a work
> > that has not been initialized this will lead to kernel WARNING:
> > Apr 20 10:32:59 FNM00190700796-A kernel: WARNING: CPU: 11 PID: 75133
> > at kernel/workqueue.c:1447 __queue_work.cold.55+0xc/0x3c And
> > eventually to soft lockup
>
> Hello Engel,
>
> Could you verify this with latest nvme-5.13 branch? I think this might be the same problem as commit 7b96918a173 (nvmet: avoid queuing keep-alive timer if it is disabled) fixed.
>
> Thanks,
> Hou
>
> >
> > A simple fix for this issue (I will post a patch soon) is to
> > initialize the work (as part of 'nvmet_start_keep_alive_timer') even
> > if kato == 0
> >
> > Thanks
> > Amit E

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

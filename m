Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51E0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 17:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MinVzKc9X4ShvQYMeWE2sO2uEBuuIlP4iQUd2Mhqc5c=; b=baJ63yX3lVXKRtdyEop/Tacu9M
	w+jgOQS5h8BnOdAAbpl6WP1bCyPcAF6yg3PH0hTHQXCGCiMDwDIKUNFjyW8M8yeStSi1f2uAAkOBi
	5KK8pfWvk2mKalWMDhj6y4MQWvHt11sMlNf0cnG4ftTkTe/vaCXgo/GC8RC5aH4WqMBRrPogRJe4N
	e89OuHxFVKhmuYaQ3rG4XsUvyqydUK/7w5YX8YomHEB5756f9FdNVe07ZE1ZLidSHWlzKiX3a7mB1
	i8DXthVeOVrROCdMIT2TqC7GzfsKZ3H1YJD7wwVlphRwlAihqP2Kn/7nI0FDobchbY3CFhWKrEmee
	8ZNPCfrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbmwG-0025Ju-9b; Tue, 05 Apr 2022 17:25:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbmwD-0025IN-Lk
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 17:25:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649179547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MinVzKc9X4ShvQYMeWE2sO2uEBuuIlP4iQUd2Mhqc5c=;
 b=BX4eo5krbw3s1qfIZBdrkudlisZ7vzsYjXl0tBMxix04Bb+ktKinJqMoGe4b3/ZGqFj5Ld
 BKJeBJJ1VMHU61RpVcN2iFdxy51LlCzuu5yNxrh8vaW+mqqOTCn1ewxGZNbdPzTkvauuP4
 h6JO0TmjFH7dM6TOqtZvDqmvCoHuLD8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-t85KCOezN2SnnBJm4YJU1Q-1; Tue, 05 Apr 2022 13:25:46 -0400
X-MC-Unique: t85KCOezN2SnnBJm4YJU1Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 n21-20020a05600c4f9500b0038e3b0aa367so1207053wmq.1
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 10:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MinVzKc9X4ShvQYMeWE2sO2uEBuuIlP4iQUd2Mhqc5c=;
 b=grKdPsiNgnLx+VYGtRlEKM7PvDmkaov7IKNIlY9mLN7TwpvymhZtudYXlioECbwqqA
 yEhtYngkvJQM4QeG/f9sbYWGkftxE37ZZuMljcL9KAIrT/fKotN3x9BVc29jBNFsqcGe
 M25/NCiGvYXqLsqMbcvVcSnZiPHPzQMmsJqE2ZqXUflMfMzHzf2c+6AvPNKrsfBnll0M
 3+Z4GVViGMhXxKSYf/8z1aZrlQbXEe/sETJSfX6cqSXPe0IixjDwtSUKRedaS3ceXcfX
 kmxmiej8Rv+b9gbWDlaF4y0EUDrPL1RjfumuakgnHxnok6vL9D8Nqa3nxQDM9tYOV8/i
 /nlw==
X-Gm-Message-State: AOAM531hmv1fj8SNshcVTt8ecUluXlkeahNFZEfWOwv9xnh/wO3fDruJ
 9DILI3pzNmKOpse0Bum+kek58v2kbcvev8hd/MLAML876ejprhkKBPodZkpvlSz7o4tIRioLHMZ
 mwbrSEsT5IzEs0ypRMEdFSVAu3xSuXauWrZNay9CsuvY=
X-Received: by 2002:a7b:cf12:0:b0:38e:6b0e:a41d with SMTP id
 l18-20020a7bcf12000000b0038e6b0ea41dmr4104320wmg.8.1649179545315; 
 Tue, 05 Apr 2022 10:25:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3ymfUP4TvGuDbu0TXik+lA/aTuPc3CUPmJTc+fXUc9F2SckZL4ButwkSfYZ4RagFRjPEE29gqZ+0txu4oAMo=
X-Received: by 2002:a7b:cf12:0:b0:38e:6b0e:a41d with SMTP id
 l18-20020a7bcf12000000b0038e6b0ea41dmr4104300wmg.8.1649179545041; Tue, 05 Apr
 2022 10:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-4-cleech@redhat.com>
 <28946544-111c-63eb-3b13-ad48113df4ec@grimberg.me>
In-Reply-To: <28946544-111c-63eb-3b13-ad48113df4ec@grimberg.me>
From: Chris Leech <cleech@redhat.com>
Date: Tue, 5 Apr 2022 10:25:33 -0700
Message-ID: <CAPnfmXJSyNUmsTLv7fNL3M3SobfC_zw38Dvjh8-0QmKhr86s_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme: fix RCU hole that allowed for endless looping
 in multipath round robin
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, lengchao@huawei.com, 
 dwagner@suse.de, hare@suse.de, mlombard@redhat.com, jmeneghi@redhat.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_102553_823860_AC301E0F 
X-CRM114-Status: GOOD (  22.93  )
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

On Fri, Mar 25, 2022 at 5:42 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> On 3/22/22 00:43, Chris Leech wrote:
> > Make nvme_ns_remove match the assumptions elsewhere.
> >
> > 1) !NVME_NS_READY needs to be srcu synchronized to make sure nothing is
> >     running in __nvme_find_path or nvme_round_robin_path that will
> >     re-assign this ns to current_path.
> >
> > 2) Any matching current_path entries need to be cleared before removing
> >     from the siblings list, to prevent calling nvme_round_robin_path with
> >     an "old" ns that's off list.
> >
> > 3) Finally the list_del_rcu can happen, and then synchronize again
> >     before releasing any reference counts.
> > ---
> >   drivers/nvme/host/core.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index fd4720d37cc0..20778dc9224c 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3917,6 +3917,15 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> >       set_capacity(ns->disk, 0);
> >       nvme_fault_inject_fini(&ns->fault_inject);
> >
> > +     /* ensure that !NVME_NS_READY is seen
> > +      * to prevent this ns going back in current_path
> > +      */
> > +     synchronize_srcu(&ns->head->srcu);
> > +
> > +     /* wait for concurrent submissions */
> > +     if (nvme_mpath_clear_current_path(ns))
> > +             synchronize_srcu(&ns->head->srcu);
>
> Can you describe how the unconditional srcu is protecting
> something that is not protected with the one under clearing
> the current_path?

My concern there was if nvme_mpath_clear_current_path was run while a
different CPU was in __nvme_find_path or nvme_round_robin_path, beyond
an nvme_path_is_disabled check but before rcu_assign_pointer, then the
ns being removed could be re-assigned to current_path.

Apologies for not noticing this question before now.

- Chris



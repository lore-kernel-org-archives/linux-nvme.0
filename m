Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7300BC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 23:52:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71E964E90
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 23:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71E964E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HibOIsnHs3GkO2TLFytSg5esx18kivi6wMPNm2OLNSA=; b=iIPWXmkRUS0D5iHH4tPmq9TWG
	SR6fvUOn9fLntvA1iQUr92AGegWRPOjf6vW7AbksxUrEziInVXhyJdR02wD6o9f+/mIEBKCh/JiLS
	1uuNRAq6nQy8XAAuNLtU3eWf7QBuIVy9cL32bmIyOWv6BVa/y8AN9r2E/5XaOhUEPNWiwr7vMr3mS
	+CilzEhiPwcKn61cMh6ERFIKTyaX6YDYJH/JyWcSY3nZVeMi3lPbOAqbV7jE8ADnuoKJo0H6I2idR
	C7biV9qde0ns6fZNkKAF3Z5NRIaJRD7jWmIS38dbZCtQQbudU88LTM9dNNc1i4/IT2iFc5yTxEtOo
	koUv/1moQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHxl5-00ApK4-Sr; Thu, 04 Mar 2021 23:51:57 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHxl0-00ApIK-Vr
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 23:51:52 +0000
Received: by mail-pl1-x631.google.com with SMTP id u11so328065plg.13
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 15:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OXSfr2dabCSvdFRUAzNzC8wQejac0UjQtMYaN+FXYKk=;
 b=stE3m++/iGDyiGc9o3fu84MVOWZUsRRvCJGX4SHMhA0uTiAYXG2r+2IjLFpDbM7Ic5
 wdSB54z0J+GYobdHMBWLaiF83w9GCZKcRVAFJogRlq0Lkd5WbV1Ps1GSCuWZKWhYIH/b
 HGD9Itn8q7SciMCBbnfm6HQ4zzFq7lDY4tsF1gNaSmEHaxrVMp3kU9PYVMtzlg8tg4gn
 WzZbNOCe/4RpmkVLfQkCT6wdya/ca+XMiZrYoEmL6omTyg1nZ3sDxpjwnie/YeBuqt4V
 p0GktkGr+Mm4hR0FpiK8ctZsDqO5pstn2Cooo15/nJCBKQqogdCm1N7rB83MdaLpbrVn
 nKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OXSfr2dabCSvdFRUAzNzC8wQejac0UjQtMYaN+FXYKk=;
 b=F7BEKuIGwuZins8VR4XSNAjx9fUwSYM2208pesD29mfrywT0kUgMSSdVfMFtvVfGD3
 I01q/jO3vDNDUELSiCRkyBQgOBeasHMKCYfmMupUh/6QXrJsg3eghiS5Ze9vQrWbrFVE
 DL0ntgfI2TV5AxjqJutXd3ukLVn4bTRB2ooK3KPM/LmGy5F9OyiBORKLTZPQCzm/6KIV
 IfJCXjYYA5YZvnhP+k6hZNzS0e8mx/DLQiNq/cF5yxbf6VqAKhk9Mj16GtIXjmOWruS4
 /ikoLBSThMFycLlez4Ot0dIXn2KVuUSV/6AjvJkY5n0GhMvY7eOFbjpS6pWN88bIt2GA
 LauQ==
X-Gm-Message-State: AOAM531AP0ukyyZ8vmW4a25y/qPi4PLwrrEUK9/VwZuToLHOYBBumqUN
 cSB0xToUspJDL5IVOFRziSi5hw==
X-Google-Smtp-Source: ABdhPJztBXto5m76DGiuLZ+N4lYSCUxyX25pHdM3nm5pZ4z/p6uNUFKDRA822D5mSyPjIqaXGmEXag==
X-Received: by 2002:a17:90a:b63:: with SMTP id
 90mr7194261pjq.124.1614901909348; 
 Thu, 04 Mar 2021 15:51:49 -0800 (PST)
Received: from google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
 by smtp.gmail.com with ESMTPSA id y202sm424952pfb.153.2021.03.04.15.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Mar 2021 15:51:48 -0800 (PST)
Date: Thu, 4 Mar 2021 15:51:42 -0800
From: Sean Christopherson <seanjc@google.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Dave Chinner <david@fromorbit.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Problem With XFS + KVM
Message-ID: <YEFyjtsftfU2WRPg@google.com>
References: <BYAPR04MB4965AAAB580D73E3B03E7E7886979@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210304231359.GT4662@dread.disaster.area>
 <BYAPR04MB49657CB2E5F0C2F2FC4F24E686979@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49657CB2E5F0C2F2FC4F24E686979@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210304_235151_147183_D68808ED 
X-CRM114-Status: GOOD (  19.80  )
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

On Thu, Mar 04, 2021, Chaitanya Kulkarni wrote:
> On 3/4/21 15:14, Dave Chinner wrote:
> >> 00000000003506e0
> >> [  587.766864] Call Trace:
> >> [  587.766867]  kvm_wait+0x8c/0x90
> >> [  587.766876]  __pv_queued_spin_lock_slowpath+0x265/0x2a0
> >> [  587.766893]  do_raw_spin_lock+0xb1/0xc0
> >> [  587.766898]  _raw_spin_lock+0x61/0x70
> >> [  587.766904]  xfs_extent_busy_trim+0x2f/0x200 [xfs]
> > That looks like a KVM or local_irq_save()/local_irq_restore problem.
> > kvm_wait() does:
> >
> > static void kvm_wait(u8 *ptr, u8 val)
> > {
> >         unsigned long flags;
> >
> >         if (in_nmi())
> >                 return;
> >
> >         local_irq_save(flags);
> >
> >         if (READ_ONCE(*ptr) != val)
> >                 goto out;
> >
> >         /*
> >          * halt until it's our turn and kicked. Note that we do safe halt
> >          * for irq enabled case to avoid hang when lock info is overwritten
> >          * in irq spinlock slowpath and no spurious interrupt occur to save us.
> >          */
> >         if (arch_irqs_disabled_flags(flags))
> >                 halt();
> >         else
> >                 safe_halt();
> >
> > out:
> >         local_irq_restore(flags);
> > }
> >
> > And the warning is coming from the local_irq_restore() call
> > indicating that interrupts are not disabled when they should be.
> > The interrupt state is being modified entirely within the kvm_wait()
> > code here, so none of the high level XFS code has any influence on
> > behaviour here.
> >
> > Cheers,
> >
> > Dave.
> > -- Dave Chinner david@fromorbit.com
> 
> Thanks a lot for the response Dave, that is what I thought, just wasn't
> sure.

Yep, Wanpeng posted a patch for this.

https://lkml.kernel.org/r/1614057902-23774-1-git-send-email-wanpengli@tencent.com

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

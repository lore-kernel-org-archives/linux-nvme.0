Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2742BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 21:50:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA14E64F84
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 21:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA14E64F84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sEVNyIRPnVDEXlbk0qmd8qolfgBsTXNTcGX/3AFzAP8=; b=PmwacOyzbenPLL7jvkZVjLUEu
	Vti+6M3bZpI21V/f+uVSvQvzDP/hej01UdURf0RCV4oJekrC/HUNMXResF6SqeLKPGQbYza7iXcOT
	oiolA/OOxGismfVekSubIKO33I1qsQEfiwzpNJ2luKj0aHh+dsk8jj2scRp8s0r1N+DRcvGrzDA4q
	A5Jb7rw+qSiFn2EZU5EfqjxC7m4jqAWCobgZSYZwDecqRexwJe15KfEfbi/oJt/sX309d6c7Zri1l
	4RF55h7Il4FGEsjBJ54BhHdiqDnQ6nXUNJrRDdzuGUDDtGII0KpJlQDf3eW2FVkJ6bgIF2R0yX+GO
	/kO26iFwA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHvqq-00AIXL-KO; Thu, 04 Mar 2021 21:49:44 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHvl8-00AFVh-Sc
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 21:43:54 +0000
Received: by mail-ot1-x32b.google.com with SMTP id h10so18147096otm.1
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 13:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q7tBXV4lZRcDzR1WeLqLPxHv84GSFkk+SyKZ277C1YA=;
 b=BBwDnQyKyqeYcC+rrb3errHEavPdPrQzuH20BcbkwwSkN4sOmjPaHs3qZkHfw3LPxf
 AXPK4CFmZ17nm3gnZoT2Brknojh08y/pQegZL+u4+6Cmz3jRrAkZQwCEfq/THW2YxdtB
 D1JWY8tKCCWgDZsRdnWTJmWGyMCdbLNa6XsceoabVl1IrwZku+HFIV8lnJ9b2gtExOat
 2wQweKIDkUDK7iiTX02F1M8X/ggX0ur2426JxvUK82PsmLZRENvpvb35XC5p9FV5cPhU
 85ROecKQqDuatcFd0RbMUbPspXl0d1zSKXOId8XTESy039ZfA32fP5fbWSzXPc60ry1k
 g8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q7tBXV4lZRcDzR1WeLqLPxHv84GSFkk+SyKZ277C1YA=;
 b=LQTp2KxIuIOTHLPtY5mJ/mHnB+ZgfjkuMP925TxLxtBeG/xv9TXJQLB7H+K6LoL7k2
 dd5ivIrw3+mwfvG/m1eH2jhIlVL8DTduyqUs4/sv0eT2fxEr0jeryhlOhNElSAi4YO1B
 JU9fgoF8doFOco29sGbukQcjZo8NhKykZBqVM/5viy2+TYGPJ6qSif1zE/y/Qr3vgQZu
 31zQFR5xizoWYeciUx2nAbyFFQV3ugiGPkMlQi+WKgWUy/kYeWahSBCvQmyz4/CZS2sQ
 tsvQ9TBEBu953M+6bWZo0pRDtvMRki0sT3f17LF85iBN/+AwAzI/LagztLKF1+7AshHn
 mBbQ==
X-Gm-Message-State: AOAM5311QJn3d/w9su75iKDy1UKVPVvKj5a0konqZsLvVAfhqgvWVJoO
 5SddiKmE3XAd3bHxAuk8PbiSor7A3i9bH6SgwcE=
X-Google-Smtp-Source: ABdhPJwimeJ4h5jpmQ7KLAouR5p8gllE77YCYgISzdbK9ewWwDvbV6lLJAA/SAlqY4E1J5Cw9wp51w==
X-Received: by 2002:a05:6830:3108:: with SMTP id
 b8mr5074438ots.174.1614894227976; 
 Thu, 04 Mar 2021 13:43:47 -0800 (PST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com.
 [209.85.167.174])
 by smtp.gmail.com with ESMTPSA id t2sm173870otq.45.2021.03.04.13.43.47
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Mar 2021 13:43:47 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id i21so122195oii.2
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 13:43:47 -0800 (PST)
X-Received: by 2002:aca:5e85:: with SMTP id s127mr4293199oib.67.1614894226912; 
 Thu, 04 Mar 2021 13:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-3-alex.bennee@linaro.org>
 <ff78164cc13b4855911116c2d48929a2@intel.com>
 <87eegvgr0w.fsf@linaro.org> <590e0157d6c44d55aa166ccad6355db5@intel.com>
 <87wnumg5oe.fsf@linaro.org> <baa46857daba4bb685491ea9323fe45f@intel.com>
In-Reply-To: <baa46857daba4bb685491ea9323fe45f@intel.com>
From: Arnd Bergmann <arnd@linaro.org>
Date: Thu, 4 Mar 2021 22:43:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ATHxzS02_5kypbGwHYLaWZmEPG8xtZchWuuM-93o8CA@mail.gmail.com>
Message-ID: <CAK8P3a0ATHxzS02_5kypbGwHYLaWZmEPG8xtZchWuuM-93o8CA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] char: rpmb: provide a user space interface
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "maxim.uvarov@linaro.org" <maxim.uvarov@linaro.org>,
 "joakim.bech@linaro.org" <joakim.bech@linaro.org>, 
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, 
 "ruchika.gupta@linaro.org" <ruchika.gupta@linaro.org>, "Huang,
 Yang" <yang.huang@intel.com>, "Zhu, Bing" <bing.zhu@intel.com>, 
 "Matti.Moell@opensynergy.com" <Matti.Moell@opensynergy.com>,
 "hmo@opensynergy.com" <hmo@opensynergy.com>, 
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>,
 Arnd Bergmann <arnd.bergmann@linaro.org>, 
 "Usyskin, Alexander" <alexander.usyskin@intel.com>,
 Avri Altman <avri.altman@sandisk.com>
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

On Thu, Mar 4, 2021 at 8:54 PM Winkler, Tomas <tomas.winkler@intel.com> wrote:
> > Winkler, Tomas <tomas.winkler@intel.com> writes:
> > >> "Winkler, Tomas" <tomas.winkler@intel.com> writes:
> > >>
> > >> >> The user space API is achieved via a number of synchronous IOCTLs.
> > >> >>
> > >> >>   * RPMB_IOC_VER_CMD - simple versioning API
> > >> >>   * RPMB_IOC_CAP_CMD - query of underlying capabilities
> > >> >>   * RPMB_IOC_PKEY_CMD - one time programming of access key
> > >> >>   * RPMB_IOC_COUNTER_CMD - query the write counter
> > >> >>   * RPMB_IOC_WBLOCKS_CMD - write blocks to device
> > >> >>   * RPMB_IOC_RBLOCKS_CMD - read blocks from device
> > >> >>
> > >> >> The keys used for programming and writing blocks to the device are
> > >> >> key_serial_t handles as provided by the keyctl() interface.
> > >> >>
> > >> >> [AJB: here there are two key differences between this and the
> > >> >> original proposal. The first is the dropping of the sequence of
> > >> >> preformated frames in favour of explicit actions. The second is
> > >> >> the introduction of key_serial_t and the keyring API for
> > >> >> referencing the key to use]
> > >> >
> > >> > Putting it gently I'm not sure this is good idea, from the security
> > >> > point of
> > >> view.
> > >> > The key has to be possession of the one that signs the frames as
> > >> > they are,
> > >> it doesn't mean it is linux kernel keyring, it can be other party on
> > >> different system.
> > >> > With this approach you will make the other usecases not applicable.
> > >> > It is less then trivial to move key securely from one system to another.
> > >>
> > >> OK I can understand the desire for such a use-case but it does
> > >> constrain the interface on the kernel with access to the hardware to
> > >> purely providing a pipe to the raw hardware while also having to
> > >> expose the details of the HW to userspace.
> > > This is the use case in Android. The key is in the "trusty" which
> > > different os running in a virtual environment. The file storage
> > > abstraction is implemented there. I'm not sure the point of
> > > constraining the kernel, can you please elaborate on that.
> >
> > Well the kernel is all about abstracting differences not baking in assumptions.
> > However can I ask a bit more about this security model?
> > Is the secure enclave just a separate userspace process or is it in a separate
> > virtual machine? Is it accessible at all by the kernel running the driver?
>
> It's not an assumption this is working for few years already (https://source.android.com/security/trusty#application_services)
> The model is that you have a trusted environment (TEE)  in which can be in any of the form you described above.
> And there is established agreement via the RPMB key that TEE is only entity that can produce content to be stored on RPBM,
> The RPMB hardware also ensure that nobody can catch it in the middle and replay that storage event.
>
> My point is that interface you are suggesting is not covering all possible usages of RPMB, actually usages that are already in place.

It turned out that the application that we (Linaro) need does have the
same requirements and needs to store the key in a TEE, transferring
the message with the MAC into the kernel, rather than keeping the
key stored in user space or kernel.

However, after I had a look at the nvme-rpmb user space implementation,
I found that this is different, and always expects the key to be stored
in a local file:
https://github.com/linux-nvme/nvme-cli/blob/master/nvme-rpmb.c#L878

This both works with the same kernel interface though, as the kernel
would still get the data along with the HMAC, rather than having the key
stored in the kernel, but it does mean that the frame gets passed to
the kernel in a device specific layout, with at least nvme using an incompatible
layout from everything else.

        Arnd

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

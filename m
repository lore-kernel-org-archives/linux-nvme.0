Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF96C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Feb 2022 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yq/VFWoQHCTmo0AS/1tH7bEiaRHml5LeaqXeugP1G5A=; b=lwaaD3o6/ikbNIxiDgknivmH3I
	SkoNRFTB0jtWREv2RYa6Zfdodg/bcXzSayJJqlSfRrgzEpfIszhPTB8jScv8CJyJyd0+//3UubgWY
	kf1msD8EoMGAA3fhWLEKvToLL+B07jnToRsfiVPOZbhICbvMoFfJHZmtm2/au0BOk+h9m04p2aZGq
	wSTY2juCk0Ca7MoULFDxI4P1GC3jFLf+9+fS2CiMo/93oT+C/9ux6189ZnIoCpnDyOQ4jN5JdMNyh
	9x+PWobBMHQjRBXXvYFgsSsZ4BInkWfQw3qjjy94kYetO7BhL2Hk1boEd9T6usO56ZoqUrWY+mgrC
	CGPKw65w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nM69q-0053Cl-TK; Mon, 21 Feb 2022 10:43:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nM5V3-004jp0-Mi
 for linux-nvme@lists.infradead.org; Mon, 21 Feb 2022 10:00:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645437653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yq/VFWoQHCTmo0AS/1tH7bEiaRHml5LeaqXeugP1G5A=;
 b=DSg51hvF1ZMw5zXtHY0wnSpv5kePcFKpFY4ibU3YF4vV2iZ2MthXGDvbToNcRj3k+kts13
 UkApBRlrzCuIEyDGxEe2cyXFNviipyeB05LsmmzNNfKQ83dZM1cfBbYMOqyQG/4SDdTAQn
 GeLCTajnkHJsflNzytr9urcq0941kY8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-Qpyu-VXiPWSb-cUnUiv9Tg-1; Mon, 21 Feb 2022 05:00:51 -0500
X-MC-Unique: Qpyu-VXiPWSb-cUnUiv9Tg-1
Received: by mail-pf1-f200.google.com with SMTP id
 62-20020a621541000000b004f110fdb1aeso1860468pfv.13
 for <linux-nvme@lists.infradead.org>; Mon, 21 Feb 2022 02:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yq/VFWoQHCTmo0AS/1tH7bEiaRHml5LeaqXeugP1G5A=;
 b=R76QLj0uYJT8BqUhSARjemYB5acarRRr1WrgtzKVM1HHKoOWg7cOSq2r4n/huO6Gru
 ujuE6vlXCzGgDU7vm01A+YalQgo3QfF1ioyorHuP9gU0oTbz9upIPKMHj69bXKksxWje
 /stY7+TvSlDm81pQyAkrBTVT2A/6fuJC4hfXM/FlDwwvKasGqqwhHsypla1K1TV6IHeb
 z0krh4hPq8UwszBjUsN93tcKs6HpTWc6v2KASwNcLt4T7pkOkAKQq7b6/D4q7MODEYbm
 WPzyrS/hYc3/eO5wcC9fvmjSUVZgQ9KHrwGVbGaOToBeGNWOx1xQGYMNKwM4tHH1Pewq
 syOg==
X-Gm-Message-State: AOAM531DYkPsJJ97DGwhgaIwaQtjwZW3iY/YikQMcHi9b/8/c5oMhOoe
 LVIG6yBLXgMxYEcBVirajjyzsc2gcjkMzoURoShpql0h94ER/kugnrMrdavltgTbaY5W1icjIXM
 hqEb2vVsQZjWjPumOrgr99uvZYC8MjFhmawMOP0dBwLA=
X-Received: by 2002:a65:6246:0:b0:363:396a:a00f with SMTP id
 q6-20020a656246000000b00363396aa00fmr15347275pgv.28.1645437650678; 
 Mon, 21 Feb 2022 02:00:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkLo4UfMKQcebDvyXtITkMIXLAOXsJukx4NbH4EG7ATLniHaXkyNwNpk8T/dZ0Cl7DPZezmLWlUFUMY2CxX14=
X-Received: by 2002:a65:6246:0:b0:363:396a:a00f with SMTP id
 q6-20020a656246000000b00363396aa00fmr15347259pgv.28.1645437650403; Mon, 21
 Feb 2022 02:00:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
In-Reply-To: <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 21 Feb 2022 18:00:38 +0800
Message-ID: <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Haakon Bugge <haakon.bugge@oracle.com>, 
 Max Gurtovoy <maxg@mellanox.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 OFED mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220221_020057_879764_CF2D524F 
X-CRM114-Status: GOOD (  32.63  )
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

Hi Max

The patch fixed the timeout issue when I use one non-debug kernel,
but when I tested on debug kernel with your patches, the timeout still
can be triggered with "nvme reset/nvme disconnect-all" operations.

On Tue, Feb 15, 2022 at 10:31 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
> Thanks Yi Zhang.
>
> Few years ago I've sent some patches that were supposed to fix the KA
> mechanism but eventually they weren't accepted.
>
> I haven't tested it since but maybe you can run some tests with it.
>
> The attached patches are partial and include only rdma transport for
> your testing.
>
> If it work for you we can work on it again and argue for correctness.
>
> Please don't use the workaround we suggested earlier with these patches.
>
> -Max.
>
> On 2/15/2022 3:52 PM, Yi Zhang wrote:
> > Hi Sagi/Max
> >
> > Changing the value to 10 or 15 fixed the timeout issue.
> > And the reset operation still needs more than 12s on my environment, I
> > also tried disabling the pi_enable, the reset operation will be back
> > to 3s, so seems the added 9s was due to the PI enabled code path.
> >
> > On Mon, Feb 14, 2022 at 8:12 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 2/14/2022 1:32 PM, Sagi Grimberg wrote:
> >>>> Hi Sagi/Max
> >>>> Here are more findings with the bisect:
> >>>>
> >>>> The time for reset operation changed from 3s[1] to 12s[2] after
> >>>> commit[3], and after commit[4], the reset operation timeout at the
> >>>> second reset[5], let me know if you need any testing for it, thanks.
> >>> Does this at least eliminate the timeout?
> >>> --
> >>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> >>> index a162f6c6da6e..60e415078893 100644
> >>> --- a/drivers/nvme/host/nvme.h
> >>> +++ b/drivers/nvme/host/nvme.h
> >>> @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
> >>>   extern unsigned int admin_timeout;
> >>>   #define NVME_ADMIN_TIMEOUT     (admin_timeout * HZ)
> >>>
> >>> -#define NVME_DEFAULT_KATO      5
> >>> +#define NVME_DEFAULT_KATO      10
> >>>
> >>>   #ifdef CONFIG_ARCH_NO_SG_CHAIN
> >>>   #define  NVME_INLINE_SG_CNT  0
> >>> --
> >>>
> >> or for the initial test you can use --keep-alive-tmo=<10 or 15> flag in
> >> the connect command
> >>
> >>>> [1]
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 0m3.049s
> >>>> user 0m0.000s
> >>>> sys 0m0.006s
> >>>> [2]
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 0m12.498s
> >>>> user 0m0.000s
> >>>> sys 0m0.006s
> >>>> [3]
> >>>> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
> >>>> Author: Max Gurtovoy <maxg@mellanox.com>
> >>>> Date:   Tue May 19 17:05:56 2020 +0300
> >>>>
> >>>>       nvme-rdma: add metadata/T10-PI support
> >>>>
> >>>> [4]
> >>>> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
> >>>> Author: Hannes Reinecke <hare@suse.de>
> >>>> Date:   Fri Apr 16 13:46:20 2021 +0200
> >>>>
> >>>>       nvme: sanitize KATO setting-
> >>> This change effectively changed the keep-alive timeout
> >>> from 15 to 5 and modified the host to send keepalives every
> >>> 2.5 seconds instead of 5.
> >>>
> >>> I guess that in combination that now it takes longer to
> >>> create and delete rdma resources (either qps or mrs)
> >>> it starts to timeout in setups where there are a lot of
> >>> queues.
> >



-- 
Best Regards,
  Yi Zhang



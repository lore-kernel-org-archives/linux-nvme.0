Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8FCC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 17:39:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EEB613D8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 17:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EEB613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=brlWXU2YY+nxhoFb9ZlrL3+HgAxbiKs+B0rGKF7bydE=; b=g0QD/5RdsEvfSHLGwSp07kBkR
	b6MjKeK4iItFJHs3HN8pQ+NhRP0487xkaK4sbqUt3zd4Ngv4q6S8WVJs+WHa/R7GjjcCAlf6EvPNS
	Sqv3NnBxhovucSJnrrcZrlExE6zsRrlQcrAvKZvFGdTBCekU1RxiasSwzcgmJ77Cf4+67DFmW8tey
	wkt6RTGuRhkM3ieymAaOIPNs7GQq1sbiZQpYiqZUR1snYJjfLGIqXH8L+3E4XUcdUr9EzA1MAlrx+
	2menaZqqlYmA4EoRWI2nr5RjGTAcdclVnZz8WWEnOjgDITlwAzWDh3mi45SA1oO/fo89WnULWaGqe
	LkFMwzN5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZGoN-00EtNI-NN; Wed, 21 Apr 2021 17:38:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZGoK-00EtN4-OX
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 17:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=I9+aIwz9Vql5/6wSQl+X+pueE49imN5o1e/PPElxYzU=; b=uaNoiX+wXBQ4z9j5IpxAX36uOr
 uNPr/7+/ZOPqP63SRrctN6CARKOVhTNMpUhChoyxstQl8ktMbb77bYWe7y8RtGM6YboH/MnmZTltZ
 0ZS++6iRJxm1ysVl6z8WTw9gnFIBGjU/x7Qvbgkrh2ZXvFhS6YB2MqqMt39OzMWC35vGeK4F60six
 8KEbUXvt9qSgqGvZ1W8egoql3NucQ2VVuVIrZLlklnFIyt7EsqyyVFXb/miA3kumg25CaEiYr5lbf
 +vayvZYnyPD/CEgVoLxt5TzscC3WOr+ONgPWags6/mhIuEzKc1RW1FpqLtsB7Q7pN1VYbALNT0WiE
 LTuWsT0w==;
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZGoH-00D4Ir-UY
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 17:38:47 +0000
Received: from mail-lf1-f71.google.com ([209.85.167.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1lZGoC-0007IG-99
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 17:38:40 +0000
Received: by mail-lf1-f71.google.com with SMTP id
 h22-20020a0565120556b02901ae3909916eso8051527lfl.17
 for <linux-nvme@lists.infradead.org>; Wed, 21 Apr 2021 10:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I9+aIwz9Vql5/6wSQl+X+pueE49imN5o1e/PPElxYzU=;
 b=giIvHQ9llG7zhKWGbIrZYvZ8PDSBroixJwanqoaC1l03JQlB16pqaRJWLoxS1y1HJV
 fy3H3JSfX8S7LP4pG6G1I1dzEzXtNslMCS2TyxvFefdWy/8+lKbDPSn5Jrq7SAc3u2+m
 KzAJT5YtkVkQntAvVraVgqIqmpLDmnwyYInqXoCpFeELK60EO+G6jv25GYnitzW737Hg
 DsqSGEVLuf9oBxirOqUMgkP3go4gbOv9fQypfDFcBm2m6OyAX/m3v2r7L0emNBqE79b0
 Wi1vckcIwl6IrOrLT8F/B3kINZhBtvqMMtfm/m0gXqQVm1+v8/ZtMcQwn/OFDdiqncce
 YEpQ==
X-Gm-Message-State: AOAM533zaprZDGArCHbHhn+6EVV0UY0KwVKBnlOOE3yphMuYRmWbW+YN
 6KHDqYpoEmiLYPgb5rBolasaIojuV/l/JV8j9xFoqTuOoMw8vKgORsdaRwsCkHfDbgz20Gr6f8K
 d80xhP6P4MgFycdAHyE2qBJS5cE02cMOjcKtbMynX/CDX6O+OyJCiMfcatQRS
X-Received: by 2002:a05:6512:3f8c:: with SMTP id
 x12mr19950138lfa.622.1619026719734; 
 Wed, 21 Apr 2021 10:38:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzItHMeXRB2TVHPu5Htg1i1sRwwHWMfKEkn/SOqau90eZrlMpzeKkrk6JIgPMVOa4v50O5FId3GHVMezAV3Sbg=
X-Received: by 2002:a05:6512:3f8c:: with SMTP id
 x12mr19950124lfa.622.1619026719493; 
 Wed, 21 Apr 2021 10:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210416091344.1210803-1-kai.heng.feng@canonical.com>
 <20210419065027.GA19201@lst.de>
 <CAAd53p4r45fZ4ewCko_Q-mO92omBZkEiPpyyc2SYRXH+6WpEKg@mail.gmail.com>
 <BYAPR12MB3238A5758B18B061204F264EFB479@BYAPR12MB3238.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3238A5758B18B061204F264EFB479@BYAPR12MB3238.namprd12.prod.outlook.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 22 Apr 2021 01:38:27 +0800
Message-ID: <CAAd53p6f14W3RtbhpszzdRp56bh5y3ciezNq2WgsA9FwmREdSw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device supports
 it
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_103846_142388_C58E07E4 
X-CRM114-Status: GOOD (  24.51  )
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

On Wed, Apr 21, 2021 at 4:42 PM Liang, Prike <Prike.Liang@amd.com> wrote:
>
> [AMD Public Use]
>
> According to BIOS guys the _PR3 should be always implemented for NVMe device on the onwards ASIC. This solution seems more simple and looks good to me.

Turns out ASUS laptops don't have _PR3 implement in ACPI, so this
patch doesn't work on them.
For now, please use the patch from AMD instead, thanks!

Kai-Heng

>
> Reviewed-by: Prike Liang <Prike.Liang@amd.com>
>
> Thanks,
> Prike
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Monday, April 19, 2021 2:58 PM
> > To: Christoph Hellwig <hch@lst.de>
> > Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Sagi
> > Grimberg <sagi@grimberg.me>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Liang@amd.com>; S-k,
> > Shyam-sundar <Shyam-sundar.S-k@amd.com>; open list:NVM EXPRESS
> > DRIVER <linux-nvme@lists.infradead.org>; open list <linux-
> > kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device
> > supports it
> >
> > On Mon, Apr 19, 2021 at 2:50 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Fri, Apr 16, 2021 at 05:13:44PM +0800, Kai-Heng Feng wrote:
> > > > On AMD platforms that use s2idle, NVMe timeouts on s2idle resume,
> > > > because their SMU FW may cut off NVMe power during sleep.
> > >
> > > We're already have a discussion on a proper quirk for thse broken
> > > platforms on the linux-nvme list, please take part in that discussion.
> >
> > Thanks. I didn't notice v5 was sent the to mailing list.
> > As of now, AMD folks are also reviewing this, and I believe this approach is
> > less quirky.
> >
> > Kai-Heng

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

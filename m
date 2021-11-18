Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C3C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 00:05:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EE361B73
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 00:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5EE361B73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rE06j6Gm812CNNg+JzoY4Kvbmh0B4iBlDwTGhqLXqbs=; b=HF7tWZCyZdVsJHr47HkwZFdgcs
	jrIQwaZwF9EwBTBXvzmXLCNDu30BQRg9X2OuajmoLEbf/Yx6jWJSzfaiszPfVGAzQrgsIJbtAkK2z
	wJKvJOizv1hzD3drfJQFiSIS5LBkvWcD8+hV9UNOs9zH1gk8zFAT/gJyO2uhEk0p9mJFL1T+BgdQG
	MgBw5NSzNxaIkkRvzR7ztKPlvBLSzUS9tY6n19ql2mMI3XwU+Qog/KKNOsMbLlmbzVnvpHpHePRKr
	nWMJfjVeMIpd63Bg18Be/67JMiQghj4LABBYFhpEpb/yG07FSbHoxOCl9UWM52TS84axOwOmcXfOB
	gu9w9uQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnUw2-006cxX-3o; Thu, 18 Nov 2021 00:05:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnUvy-006cx0-TG
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 00:05:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637193946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rE06j6Gm812CNNg+JzoY4Kvbmh0B4iBlDwTGhqLXqbs=;
 b=G3smsVpOMIWBXoiFcTT0mqKLf4vP4Zs5yrY0NloD3lOSKBYa/tjWmN1uQKsJxDaaOZgHG5
 uZusQkUvmiwb2EBhBaHolJxZj1bf6bQ6goXGcq/rIPkjiyt3uG1J4S6nPtzIhkZ0AMiqio
 RlGF7tvgZyiZegg1Lh8nRE1taSYBYVI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-Qr9N-0S3NF6nuiC3Gx9lgQ-1; Wed, 17 Nov 2021 19:05:44 -0500
X-MC-Unique: Qr9N-0S3NF6nuiC3Gx9lgQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 s189-20020a252cc6000000b005c1f206d91eso6807174ybs.14
 for <linux-nvme@lists.infradead.org>; Wed, 17 Nov 2021 16:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rE06j6Gm812CNNg+JzoY4Kvbmh0B4iBlDwTGhqLXqbs=;
 b=d4QlyFSdzXKhV+3mRXTPN895wYkELF8WkzFd+HVTZ89W8lg/j/6X8j6OXe88fhPjKB
 I4TPamVmsDvtBm4VAlINq05Ul6HAO6tG0vKCqcwEfcSGbOHxFov9VJq4k9jHWbBwp3NI
 KXuSarZ0IXFzfL+m4oEQn8OfDHLeM4fx9NiFrvBdQAMRStOa/L+GDEWb9Rhl8okr/ggj
 GgshXvJHYGsihISE2hQbemd1dy/POR/3N4rovmASFVCLWxFlNHPShdLBeHG5sOAd6a1D
 U8uIGBBMH++08moBzXJGccFzf5SALKEp9VAoXb/pB9TBxU0QPE5+YVzURFFC+kBOx2da
 BBFQ==
X-Gm-Message-State: AOAM531pIBm9QJ8tm3iRHT5QLlS4ri9JDdKEpniQgy+oG43+Rv9C32uu
 SxNeUixI88yg0iRbJqR2oKmhd/xc2b/zMq4IYe2YSWguNRffk8LYTRpzrIdR9h5wCvKBSjYiqi1
 qF/I361n/grtulQlG9XZ2UTfmAYmSY5VdN4Cfh5AKHZo=
X-Received: by 2002:a25:aaef:: with SMTP id
 t102mr22873448ybi.512.1637193944175; 
 Wed, 17 Nov 2021 16:05:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLFlzBIb+EHRbG8grWk1hulciwp0L6hmvfkW4FKX0XHzdkvvxveQ2l6o6CLYqfMO9OY+bgGD/hNPhWtpTRVCY=
X-Received: by 2002:a25:aaef:: with SMTP id
 t102mr22873418ybi.512.1637193943977; 
 Wed, 17 Nov 2021 16:05:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs97spcWGFjz4JPzaRuzHnRGZkKP6HWMSPkbKLS9EmWMJA@mail.gmail.com>
 <9095c05e-659f-dd4c-95f9-617026216550@kernel.dk>
In-Reply-To: <9095c05e-659f-dd4c-95f9-617026216550@kernel.dk>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 18 Nov 2021 08:05:33 +0800
Message-ID: <CAHj4cs9uT6discm7iGei+__KnA2SzA49e77nvW_B-RcKPFFGjA@mail.gmail.com>
Subject: Re: [regression] nvme pci sysfs remove operation hang during fio test
 observed on 5.16.0-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_160547_063732_24F794BF 
X-CRM114-Status: GOOD (  11.78  )
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

On Wed, Nov 17, 2021 at 11:58 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/17/21 8:57 AM, Yi Zhang wrote:
> > Hello
> >
> > I found this regression issue on 5.16.0-rc1, pls check it and let me
> > know if you need any test/debug info for it, thanks.
>
> Pull in block-5.16 and it should be fixed.

Yeah, it was fixed, thanks.

>
> --
> Jens Axboe
>


-- 
Best Regards,
  Yi Zhang



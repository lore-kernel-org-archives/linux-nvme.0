Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D9C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 11:14:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7368A60F9C
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 11:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7368A60F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SDiDX50JHTaqaBIX81wtGBDpxUj6PiDBGLng1wyhgiw=; b=oMmysljhB4130i
	tDhkFgZNREpz2EvclMhryUOlEv9WjYBnsY7hVidf19FbC1iTeJuvjtdrzN7uFF0H+gHtZ0rWW7xs9
	lrpShaSnCmLnMEqzoYUIleuwKbRGaAfCm+ZW2GjrBqdX2zDX2cYXwj0FTj+8d2V6P+w+sZ95wqnp6
	LwoFy0caQg2N36k3lDD+ynxa7u4CPDH6dgXOB0ncTDQXLdeiwoOxdiiFjT5hpWL02Mx9XaQc9CMDX
	L7Yr5FOMh2Gb4aPZR5dTrFHL2USaS9MwScHX45oA146D1GDaOmn/TyFyo8N9+G+/m4d53uYDy8qvb
	3mYSaAwH4oZQG/l8ROYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUS6x-000Qh4-3u; Sun, 26 Sep 2021 11:14:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUS6u-000Qgl-Lp
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 11:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632654857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GKdyPjsJrfr4mvWKxEFZb/NowWLkm2U1gIFbKixV+DI=;
 b=dNjFk9tB0WIjFXAo8tSM6erRiny2x9M2FhGHQ/xqruk7FyMaxN/ukHhMkDo0TyTrHFQoc5
 p8r1e+LRwRlWmmLHkHYTVq6+Nj6VFaChdihIqaG3uHwQndxtwepc7tCj6zTEkE4KbyPy4j
 QHcSCBxECWUHt86VpSXjUYN9T62W+SY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-PUn1LR1mPjeL8xl8oc8ThQ-1; Sun, 26 Sep 2021 07:14:13 -0400
X-MC-Unique: PUn1LR1mPjeL8xl8oc8ThQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 v66-20020a25abc8000000b0059ef57c3386so10543553ybi.1
 for <linux-nvme@lists.infradead.org>; Sun, 26 Sep 2021 04:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GKdyPjsJrfr4mvWKxEFZb/NowWLkm2U1gIFbKixV+DI=;
 b=fYEykKEnlpVsQ8EYGxG9Y5DDYmnbO6BZHaQ7D2RFwfL9povm1R7JMInYclu+EZ5lBM
 bwp7U6kaCdpC49Tmi762pdSRYnDowLFfb1Q+GCJDxK/YpPB7wBCfVby9IMwNlojETXQ5
 XA7uOF2CC4taAV+CDf6i2bfjNhaNg37OJBe4Qt3Za4X+jTvBBxuoN5R3AwTees46HlwV
 Ek+HGN93s6TiaB9CG8eJKIo03JYsZdN+w2IYPZbJqLDw7bg/eEqEFx9s+0UJVha6Zqlv
 26aXJgYzcfPUeLVqGENIJNefoaKSRgJqlnd+Bx9grNULZrMiLUFGyVj1Ji3oWCsbmpVs
 rjsw==
X-Gm-Message-State: AOAM532xKD8cBIyHTpjyaPsA+TF20d2N8V8LUYRcymay0HrzvQIIfltQ
 cRtmU9+4FcCnAkm1QnIK3OeCyrcY2Ottq+ONSjm54Cyuw9MXGFZFZpV/h8AnEUGysBhS4FzbFU1
 sb2rXciRRUR3ASODNXJPrB86bekqjGtaBAZ+CNsNvwvo=
X-Received: by 2002:a25:5e42:: with SMTP id s63mr2492659ybb.308.1632654852737; 
 Sun, 26 Sep 2021 04:14:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV8BId1p0BjbKcdpJqmA3dGb1IA/5um0z6RhcFAg7TrxkCwBwVnjYGrGrm8qSXq0QCjFGhbcYrLdKXduttQ7I=
X-Received: by 2002:a25:5e42:: with SMTP id s63mr2492648ybb.308.1632654852499; 
 Sun, 26 Sep 2021 04:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
 <20210924031315.GA14438@C02WT3WMHTD6>
In-Reply-To: <20210924031315.GA14438@C02WT3WMHTD6>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 26 Sep 2021 19:14:01 +0800
Message-ID: <CAHj4cs9B4rNRhM2DEjtRWMSJXie2xUFToB7HQq4wd1TiXc-WWA@mail.gmail.com>
Subject: Re: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_041420_832033_3FE81420 
X-CRM114-Status: GOOD (  11.37  )
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

On Fri, Sep 24, 2021 at 11:13 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Sep 22, 2021 at 09:56:47AM +0800, Yi Zhang wrote:
> > # echo 1 >/sys/bus/pci/devices/0000\:87\:00.0/remove
> > # echo 1 >/sys/bus/pci/rescan
> > # dmesg
> > [  251.864254] pci 0000:87:00.0: [144d:a808] type 00 class 0x010802
> > [  251.864286] pci 0000:87:00.0: reg 0x10: [mem 0xc8600000-0xc8603fff 64bit]
> > [  251.864337] pci 0000:87:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
> > [  251.889196] pci 0000:87:00.0: BAR 6: assigned [mem 0xc8600000-0xc860ffff pref]
> > [  251.889206] pci 0000:87:00.0: BAR 0: assigned [mem 0xc8610000-0xc8613fff 64bit]
> > [  251.889777] nvme nvme0: pci function 0000:87:00.0
> > [  251.889888] nvme nvme0: readl(dev->bar + NVME_REG_CSTS) == -1,
> > return - ENODEV
>
> An all 1's return almost certainly means the memory read request failed. The
> test your described usually means the target did not properly configure the
> memory range it was assigned. Is this directly attached to a root port?
>
Hi Keith
It was connected to the PCIe slot through a PCIe extender card, I
added the full dmesg here, not sure if it helps.

https://pastebin.com/QUP0Y4sT


--
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

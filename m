Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96BC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 22:46:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723DF20721
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 22:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fxMyPYjS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFBif/W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723DF20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4rvQ+dpD3Zka69140PBsZVmeQCXoNivRRtg0tca/mUY=; b=fxMyPYjSWpShd7
	ihpdCMsjsh8Xs9DsKcKsCHaurIh/J8cHhqimKvGl4cCYlcX1HPnDhibzvmUiPOoPXmspaG3APeiS9
	gY9jacN5l5bzVZR1rbK9zeHysVfvVeAgNiJ6kt+D9NF4F3WXvZaOyshZpqg1qadA3mZZOw3YqkLbG
	c0bag6nDH9vODsLoWn4ltKd8aBhI8gTPimWE+RUROgJerMoDvCkgj27rNGVa1THOnJK7rCG7d5RUa
	ty03l9LqMIMfCfAuyRIzI8WduXPgdsEaw+8OfeJ+o6kVarljy0df5Y2frU9QgYDZhXCOLmIT8PCQy
	2Hcfm7yRth+SPdgBS5cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jenlw-0004mc-Hz; Fri, 29 May 2020 22:46:40 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jenlu-0004m2-EH
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 22:46:39 +0000
Received: by mail-wm1-x336.google.com with SMTP id v19so5402699wmj.0
 for <linux-nvme@lists.infradead.org>; Fri, 29 May 2020 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VVXUitJITFccJCM10GuKFypOdjqH8aeTMtgcNm00y3o=;
 b=HFBif/W8QyHkVLj2V1yHKV5ap3qTym0gJBcRJ9kNUjHKGNefzXkxHkWkOU9eMojCVM
 yzqfQS8b5zmxr8e2U6fhswwCgz06LAbc6GrGNoWJbwG5rXXsXV8GalydGjFwBxfkuTot
 282rsZnFffVzWfT1xih7nBTQ0Pv9Pl9L+pUa77mVaD6aHl0+cTuvHGO75OQzlyImxWjF
 dmJPuFLErxVdIP7BL5lttrmD+vgw1ta0gfIElkBFRRmmXJmEc/s+DIbt0SOrhhUF01b+
 6FI0pEphMQoQ3KvYk8idr4/PBEVUX8nOkllQOhlyNTffDI8xscRD8OuHLSjWaMXMY8m9
 akUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VVXUitJITFccJCM10GuKFypOdjqH8aeTMtgcNm00y3o=;
 b=HsLKru2SsHC3zERtgkZtyyX51JZEDOBWvKnYH0w1mCFdjQ7Crlxp/3184KHBP2cRN8
 R7sppT9W3MspsNI0MkMzKNC34MdilkiSR4618X1mufYv4R8Gte9tCTj8QHxjEGwnbB6W
 UCuyx2yicMnTPx0IDVM6ontP2/RSRrfyrKjxOxGaUbyo6UFw0iYMAKKxVHSrs7DCxt3h
 2nutYeKkWgNAl2RIG/+Q83opxdC1Hd4Y7M+KChEyEN5HuCiJ4qL5wmBKLqcRo/ymM9ty
 v3nAiKsS1Vr4yiqLR6C3+M8/owuWxKKfBQiFPwsV4iOcCQLv0kwY+OVDfXfQlT22aR6o
 E6Rg==
X-Gm-Message-State: AOAM530TTV/od+8kf6xYmxo4M2zflZCBw5HAmYTwT470R0VyKPXvdYoS
 s+EUor9528DtGmj9aStW5Hi4KjjitMRHT265yCs=
X-Google-Smtp-Source: ABdhPJxQCftEUyIIBWUVszZjLIxqhPYhFPMu+HZntrN9eDF8czsGxdYWW6epWn6zjAKfJvLQL9c+EptPM1OykUalLlk=
X-Received: by 2002:a1c:ddc1:: with SMTP id
 u184mr10044827wmg.115.1590792396852; 
 Fri, 29 May 2020 15:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
 <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
 <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
 <f9cbedc9-88b2-acc8-5b95-f1c247ab1525@oracle.com>
 <CACVXFVOTQ7HLV5DCP1XezPqha13LfUrj-fZE8++_BAoTvtPWMA@mail.gmail.com>
 <20200529132217.GB3506625@dhcp-10-100-145-180.wdl.wdc.com>
 <CACVXFVMithaukPF45qFzTgzqQ2g2mhLbUD+-AyaNwVwZo7+CyA@mail.gmail.com>
 <20200529223256.GA3564047@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200529223256.GA3564047@dhcp-10-100-145-180.wdl.wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 30 May 2020 06:46:25 +0800
Message-ID: <CACVXFVOxoO8HAsVK=PkKW6hTFaNTzukuYKhfqoGR2q9SFjn6ug@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200529_154638_495060_61589ABE 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>,
 Alan Adamson <alan.adamson@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, May 30, 2020 at 6:32 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Sat, May 30, 2020 at 06:23:08AM +0800, Ming Lei wrote:
> > On Fri, May 29, 2020 at 9:22 PM Keith Busch <kbusch@kernel.org> wrote:
> > > seconds. Your series will reset that broken controller indefinitely.
> > > Which of those options is better?
> >
> > Removing controller is very horrible, because it becomes a brick
> > basically, together
> > with data loss. And we should retry enough before killing the controller.
> >
> > Mys series doesn't reset indefinitely since every request is just
> > retried limited
> > times(default is 5), at least chance should be provided to retry
> > claimed times for IO
> > requests.
>
> Once the 5th retry is abandoned for all IO in the scheduled scan_work,
> the reset will succeed and schedule scan_work, which will revalidate
> disks, which will send new IO, which will timeout, then reset and
> repeat...

Firstly, we can recoganize this situation easily during reset, and give up
after we have retried claimed times, will do that in V2.

Secondly, not sure revalidate will send new IO since all previous IOs have
been failed.

Thanks,
Ming Lei

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

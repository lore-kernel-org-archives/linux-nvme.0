Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5990AC77B7E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=culyxuvbMl/9FjeP2vWgyu69zR3wMJnuy9/iZO/giwg=; b=wZaOaOm+5RwNXmcS9JIdDIHeX0
	EiiVgzbP/FoatUTt905GbV90kszB3gVYN72qXnesnid3cDWZGrLvSRqCx1GWhgA2qhFZU216v/e6U
	7BTG1L70Zwez29RMi01ywQttG8Q9qAFc90oLr5UJio+IVng61mmp1yEcAWyk7qZkugNjcpPkNQ+4A
	+tNRmvRcTlbXgl0gwe424Siwugn2mnt34hq3r5zhKdy5Lx9XnNv9wnw9PD4FBfrv6uEiynQJhOOeC
	0Tst5Njl3lmtPSbOl30p2cY2iazuz5H9xEcC1UIUOu67IN47VTur/KLCgNsfEmyXo73iT9e4HNyYm
	nRiCJOjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2DJL-00H1Yy-1k;
	Thu, 25 May 2023 15:55:31 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2DJG-00H1Y0-1Q
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 15:55:27 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-530638a60e1so1575794a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 25 May 2023 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030121; x=1687622121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=culyxuvbMl/9FjeP2vWgyu69zR3wMJnuy9/iZO/giwg=;
        b=jF8loeYxCDwaLcO45swiSTaoAJsIbybpVhV1wS17MdHURGaJ9sODwfYzf/OSwXipNP
         MSksEAhWp2JlRBcedGkiynAmzJWsSXHtVlYeY0cSlwJbSlMJcPuKG2rN3sfLGamdMqBv
         /5U5n49tP0afjf7Y27Uk34sNaQerjkqlV+YYTG3ZFBoIyEC/u1F/ylyjfwSZb+vp+ocT
         FX+sSAZhW0OfikTA9McGYiLfYi1lWLWhh2X9ZCR5u9Ekq7ENY41GUCULlg6REGA1xzL7
         s80stAkluiwpfKdRNsYoEENpSDyDEkKCkduCVSaOdiAPF2GB48X7/d+6qRjlkyXlFUBl
         gBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030121; x=1687622121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=culyxuvbMl/9FjeP2vWgyu69zR3wMJnuy9/iZO/giwg=;
        b=DmuI53DLWPowhuRWDZ7hn5t9OQkscCKtD7uWvETn6L8mimZcoIcndaBKkJyWnKbsGt
         CBX3KupClR1gVkx5W48bjXpF3+OUxR/Tp+QCId1H52V3njyXSPLcGwScKIRaGn9iOEg6
         g4KDtRc+5Yk20bSlB+LP2ZGs7U9gGYKsPB4uVnN5rBYUQ5smj59BMNqmsWuhAHlYxE5R
         wWDR9zhACoX7k8sg/X3B1sD17uPfpHYaiFIXdDBgDOKvK8qDGntPt2U0QcZdfXj5ApLi
         Q/BYqVOeL5etTKpAkGpI06f+ln/KHRM/7ywKF5V28NFNT5eoa/rSWMXx2b6UvGWGYaDh
         Xt6w==
X-Gm-Message-State: AC+VfDy53cTOBYtoLFd4xA91eQNJvttBnXCvWAxS8Llxcz4Mt3+PcEwJ
	9KuUKlWZE3gKed5PEvY4shReGaAZI4bJtTFzzOsjr3P6po9Zmw==
X-Google-Smtp-Source: ACHHUZ5IKxMhvCeaDkNI2/kPUHUfeJSEXj9pxWc5jxdKw6hsXhDoC5mjUY+jWNXGMxIrfwgcBq0vG76x2ZkjCNSmJdc=
X-Received: by 2002:a17:903:32c6:b0:1af:cbb1:845 with SMTP id
 i6-20020a17090332c600b001afcbb10845mr2517506plr.16.1685030120836; Thu, 25 May
 2023 08:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230521024618.103138-1-irvincoteg@gmail.com> <CALL+9ehvM3GxGS9Y-KVyyK+HyO14yRmGZFEPjD6pmEUMX3VNzw@mail.gmail.com>
 <ZG+AY7/lheC7Hsbn@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZG+AY7/lheC7Hsbn@kbusch-mbp.dhcp.thefacebook.com>
From: irvin cote <irvincoteg@gmail.com>
Date: Thu, 25 May 2023 12:55:09 -0300
Message-ID: <CALL+9ehUZx8ae0ZD2EUZNB8ru-XHU1Lkb_miKO+_0j4HvDUFsQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci : redundancies in nvme_alloc_queue and nvme_init_queue
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_085526_482300_CEA84A89 
X-CRM114-Status: GOOD (  13.10  )
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

I was just re-executing the same initial git send-mail command.
In the end I just changed the subject and it worked, maybe the subject
was used as a reply identifier

On Thu, 25 May 2023 at 12:36, Keith Busch <kbusch@kernel.org> wrote:
>
> On Sat, May 20, 2023 at 11:47:37PM -0300, irvin cote wrote:
> > I'm trying to resend the patch but somehow all the new attempts seem
> > to bind to this thread...
>
> It's not really a big deal to me that it's continuing the previous
> thread, but how are you sending your patches? If you just use 'git
> send-email' without specifying any reply identifier, that should start a
> new thread.


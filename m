Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1FBECAAD1
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 17:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kHk0KTOQ4HP3S4s96ccv8q2JAp+qdmzPfUbZaSq+Nlg=; b=V64FKITav87Oerzy+9ZXrikMX3
	YjRGpXJIw9hhpxzWEXZBbEMYt5fmMroPNssgVkXliNYwCel1JTsl5axc1I8j2UhuwyPpKgvyllbAY
	13qsZ6lrXXB+VvlPKYRAjmdB3timI2wNMSSDOkbYYIO6zrzZKDo02BaWYe+EaY8oY59teYD4/D17T
	b6eJzO0NZJTsDg1DGWsDCTf17l1ykhyV87GOQksxIyRpm/+KcfyS+L8EFSl8LVf4UHaAro4bzYoy9
	BEyh2HagxzFCFyRpdeRWSVkbU+FXwMq0iov+lg8LZ8TTje5cTHlw7G/r4XWs0VsHmrLLZHxoULArA
	U3hFZ7Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oToHG-00DgwR-9L; Thu, 01 Sep 2022 17:46:54 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oToHC-00DgsI-V0
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 17:46:52 +0000
Received: by mail-yb1-xb29.google.com with SMTP id j204so9647725ybj.2
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kHk0KTOQ4HP3S4s96ccv8q2JAp+qdmzPfUbZaSq+Nlg=;
        b=2uhyjh69KJzjsjOCPYGLcO7MHi9Vysq3D8xDx0m0xCkun3rJAALgJ1dSF4fZPKYGHi
         7ZU+rrikeovOXsJ8vq5NnNSDQVVc3NM2AWyM8fCct6CLjHK2Lu5t4pEH9MVyLQ32tBKJ
         pESAzmj2PLkzTOuotl7DyOZK+s+SFRE/sBFU/cR3h88WJzhbpkI2WSNAC2AkPzUX1+n1
         qHTXVpQogJ/Hhb+AIh5YDosbOlO+4qzKGiSF01cE7f3C/y0yxvDl+ZvVc2aYYL9Mvl8m
         2MJChBuPDACG+HLX38MpKYjRaA6fFGLMyabIOSMV3Mo5asS0SR9OIFfSmp71guMtqtF8
         gGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kHk0KTOQ4HP3S4s96ccv8q2JAp+qdmzPfUbZaSq+Nlg=;
        b=o7z3GEGQMUzgytmYdBr3ZeUxTDEWZnoaruZdZ39HkQTN0AexvzF/kUH5WW+avZeLHl
         Zjfxjph2/pQH0Tj2D+G9VZhZtcxLRjkRXmB+t2tq0reWBrwuwL/CPjVHiqFBWyr74BJh
         1f4OHgLYToEivObEor1MlXq+hYQCBFgUzBpACOHciJvds3ELS6CrpDyjggwu3MCLWBm1
         7xa5DEqvWk4MVD7oytR5M/V6qrniHtSakTgSSLN05nAYZn8pM7Cyi5FUz3PV9FFXJX3N
         5dJ7C6rYH6m/7Pxwl9VzJz/dMeokOjcZk/g4IaWprWh5YM6SZXeyRc2Ke6iXg7p6C8OW
         j9GA==
X-Gm-Message-State: ACgBeo29SXKnCCF4FGjMDaa4jZL1VR61RhcrPLy34Xe5vGMDj85zYtHH
	FE0cDx1x1gp7yJ5UbbyKVKF5aJqO+MZWXNvVbvwHJ9eDrzZoaQtG
X-Google-Smtp-Source: AA6agR4fTcRQDPDv6imyiCp8URbWcDsZ9yIyildc20feNwg736wvVOkzSks6XO3oLRTIaISGckBnmoBHQ89W3wNL/q4=
X-Received: by 2002:a05:6902:1022:b0:695:c571:7da9 with SMTP id
 x2-20020a056902102200b00695c5717da9mr21582263ybt.72.1662054406804; Thu, 01
 Sep 2022 10:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me> <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me> <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
 <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me> <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
 <CAHex0co9JNwFkDpNvPitESYX6-2F8_n8phxzVsZFq2kieYLGJQ@mail.gmail.com>
 <CAHex0cr80EyJXN1gOgEXF9r=_Y8Z5N6=jxw=je_8Px3vab+qtg@mail.gmail.com> <376e2073-439b-7113-48f4-862d3404c328@grimberg.me>
In-Reply-To: <376e2073-439b-7113-48f4-862d3404c328@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Thu, 1 Sep 2022 13:46:11 -0400
Message-ID: <CAHex0cq-YzgKVH6RazgPRFi0mJ7n+CsS+Cr-NqLEszZGen8dKg@mail.gmail.com>
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_104651_057324_DBEAA7AD 
X-CRM114-Status: GOOD (  13.49  )
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

nvme_tcp_queue_more() reads queue->mode_requests. So, I supposed
nvme_tcp_queue_request() is an example where queue->more_requests gets
read without the send_mutex? queue_work_on() is conditionalized on this.

Apologies in advance if I'm misunderstanding the code.

On Thu, Sep 1, 2022 at 1:02 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Question: queue->more_requests is updated under a lock. However, not
> > all readers of queue->more_requests acquire the lock. The smp_id/smp_id2
> > values seem to show that the same queue was being processed on
> > different CPUs. Is this a race between the kworker and inline
> > submission?
>
> The entire send path in io_work is wrapped with the send_mutex. Which
> part is not protected with the lock?


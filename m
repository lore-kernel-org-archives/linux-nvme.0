Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EBEC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tW2hWdc8eYPD55d3FIpQcflfooHsKHWr99qXnqLU/t8=; b=0kn4KzZAZMlwtnHZOctDGU8o9B
	MPcclL3QbuMKR2aE96a4vUj6oSxdyTbHQ3qM1Zflwx39jdjuswx6bqGSpAOd7EllzBfLJslF9D2Fj
	kGNzGrYq2HFARL4RVBv3SdZeA8jgs+VUXGzBdRD53+Odx5jWXZ9BSqeBJm/uQuzsFZclnRSFmlFS3
	7+C/4JzdlMRr1mhUNrFE5/MXRQ6svxSQeN5r682RB236fyWEuIGBd5iSmJoIKwiue5FHiYqJkWm2P
	Zd8+TXqhm5+w86ArfATorZXDcvLHQMn9LTwaE9856+VzpYU+V3qF3VI3vpSXwmtGlh6XArLcPy+g2
	uPDHwhkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naiWw-009n1x-0q; Sat, 02 Apr 2022 18:31:22 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naiWt-009mzW-GC; Sat, 02 Apr 2022 18:31:21 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0qmr-1ny0Ae0OtZ-00wjdj; Sat, 02 Apr 2022 20:31:13 +0200
Received: by mail-wr1-f54.google.com with SMTP id d29so2523203wra.10;
 Sat, 02 Apr 2022 11:31:12 -0700 (PDT)
X-Gm-Message-State: AOAM533QIkL+3CaEQzIa53CNzA/5aGx/TI2xxb+5hbDIDY7M2U3UOUI2
 Rd+9CeJGIyxsU0vo+gOLKxB9oJ0Psbw2rP8zkTQ=
X-Google-Smtp-Source: ABdhPJxXeRBLN1ONxP6bjTAJFl4VK2LisOlNtuuiDZwD1HmyapvUcRapW/HdMhWyARa4Q7Topnt9ATX3Riix9x+xc68=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr11517977wrw.12.1648924272343; Sat, 02
 Apr 2022 11:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
 <3166b80d-d8a6-45d5-9e3b-2f9998aca0d3@www.fastmail.com>
In-Reply-To: <3166b80d-d8a6-45d5-9e3b-2f9998aca0d3@www.fastmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 2 Apr 2022 20:30:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=Q7JSBLOmxZxGArUx+3Ex8SjDx7Z5csms5k+_yES9zA@mail.gmail.com>
Message-ID: <CAK8P3a1=Q7JSBLOmxZxGArUx+3Ex8SjDx7Z5csms5k+_yES9zA@mail.gmail.com>
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
To: Sven Peter <sven@svenpeter.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>, 
 Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, 
 "sagi@grimberg.me" <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1Qo9pSaYUfD1P/OrQ76lQEFBU7th0d11apRn+HVUC7yFh/eAUY9
 9w0+W5TqyXJrHjm9w9oso7h6rXvIu9dO8HNjnyAWHydmHvsV26BDIGngaTUaukDNNdcTA9h
 QWTjSF2uSLIkYAAThXzvEL1aAIkgJk5bSUajsLfqU5c3HwajYBtmJ8Jp10AaK92WfJQGfRl
 oB8huaVej9ZNNpNdY9Fiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RGXVQXWBbnQ=:VY8c8fzahoH6T7q9U9keG2
 IX75UtNsacGiIYKzptpHwQFlqhWB+wtGBuzsHNWglkHutsFfFO8Yd8Vc388/QygMs+Ct9Rmp8
 euOldxwUDaKKk7Fha5zTvfTi4DYWJFLe9bm1QOchz8IqMnzYr00JEWk835b6YNfEAzYMr1T40
 GQAv96cK2HxPwDp4iyA9u0Pp7SYytwnHkZ7nzwgTtuX3Muqtzy0MZopx8ASoDKhip27+QbTzb
 plMqMy1BLb9FkozmLKdmUq38HiZaVwckBpDjIrXZ6CqmAgVlLyMVyfj0DHSGjODO5LsJQ9eqB
 CDGFLdlumVhxvOpCdRmKU1rtBm5N3KRqqn0N4HbFLe9S20oehzPF8c7dRycS2AMKsiVKOQuvQ
 /a/uVNtm5bg3iEPJfKPBgCZPTnwcWAdcgxvRr7Vm0vUD0inTGoCKMaE9TbXhmcfixmurSsfc7
 UOI6smSKVLLKD07J7PrROB2aIcLM8oq6HrcBuyb2aXqtRqK5QZi6uSj211UEIojHp0DxoUQqM
 jqTAQ65Jtz77reqWy+ywKFcxZ8lzo6h/qu9hReBspSAdtkPibzSW8E7C8jFA+Zau2iYj2RGW2
 7jP+VcBZiulpbsj4sntcpoAIaOAdDExKmzpn2swAUYYyjU/mTpQLB094XS7RVI2b6FaXkrz29
 cq/YCbZSOZhjl8DuLzsXbvjSCkafo6TIc56P/7PktuTiokZpZSHqUSaCOBtNmZGF+o4U=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_113119_861921_95C9DB19 
X-CRM114-Status: GOOD (  23.21  )
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

On Sat, Apr 2, 2022 at 2:56 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Mar 22, 2022, at 14:13, Arnd Bergmann wrote:
> >> +static int apple_rtkit_worker(void *data)
> >> +{
> >> +       struct apple_rtkit *rtk = data;
> >> +       struct apple_rtkit_work work;
> >> +
> >> +       while (!kthread_should_stop()) {
> >> +               wait_event_interruptible(rtk->wq,
> >> +                                        kfifo_len(&rtk->work_fifo) > 0 ||
> >> +                                                kthread_should_stop());
> >> +
> >> +               if (kthread_should_stop())
> >> +                       break;
> >> +
> >> +               while (kfifo_out_spinlocked(&rtk->work_fifo, &work, 1,
> >> +                                           &rtk->work_lock) == 1) {
> >> +                       switch (work.type) {
> >> +                       case APPLE_RTKIT_WORK_MSG:
> >> +                               apple_rtkit_rx(rtk, &work.msg);
> >> +                               break;
> >> +                       case APPLE_RTKIT_WORK_REINIT:
> >> +                               apple_rtkit_do_reinit(rtk);
> >> +                               break;
> >> +                       }
> >> +               }
> >
> > It looks like you add quite a bit of complexity by using a custom
> > worker thread implementation. Can you explain what this is
> > needed for? Isn't this roughly the same thing that one would
> > get more easily with create_singlethread_workqueue()?
>
> I originally had just a workqueue here but I can only put
> one instance of e.g. APPLE_RTKIT_WORK_MSG onto these.
> There could however be a new incoming message while the previous
> one is still being handled and I couldn't figure out a way
> to handle that with workqueues without introducing a race.

Are you trying to avoid dynamic allocation of the messages then
and have no other place that you can embed it in?

If you kmalloc() a messages that embeds a work_struct, you can
enqueue as many of those as you want, but the allocation adds
complexity through the need for error handling etc.

I wonder if you can change the mailbox driver to use a threaded
irq handler, which I think should ensure that the callback here
is run in process context, avoiding the need to defer execution
within the rtkit driver.

         Arnd


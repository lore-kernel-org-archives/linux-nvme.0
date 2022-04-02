Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5285AC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q4l7MV2jndY75H8FnHCUzpg4YcczCiys3j+UuAaOpCo=; b=gQYeeHxCiixgHwa4HTdScFn44w
	WE0T23fJKLIewiQMwKL7iTMr6X6v3WaoyFjUERp8HTdqj9sE2XBYJQ9CbMS5xiZrgoKv7hg34vQtH
	PIrKuL8xiApMHoadbpgnrVISt/MAlHky3hGQax7XAK1Uf0HJCVPlDB99kXyp467SlqJ114EEfM4ZO
	Thbs/3yma03jms3D3gv4+DBgqljNJGQ+Rz5SxtDAKHBnnTRgskwvtgQrS4LVfVsksffD2ff+bbW2o
	HDZvD3W55syx13fE5AmErRoqyUzikrgLbtlxN4K7WvYUZMhjPkCxqMGkEk2JPX+nuuwr5ofqdsmxV
	CLtWx3JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nadJT-008n5s-5F; Sat, 02 Apr 2022 12:57:07 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nadJH-008n39-Jl; Sat, 02 Apr 2022 12:56:57 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 99E4F5C010E;
 Sat,  2 Apr 2022 08:56:54 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=q4l7MV2jndY75H8FnHCUzpg4YcczCi
 ys3j+UuAaOpCo=; b=pWDeCzLez7yRSldMPnQR+hjB7saJX3xzCUbvh4PVmiREX9
 HkmTBtgkcDZ4sJKK872C7AMconKDdX3R2XviAELGe1jvfFL61SiagHDRLK8r+wzu
 xxCCYdapE9sOS3qAxJEzM1MW1KYUX3DWAGg0CZg2ZD3pJ8BS9YCwgf6ajH6bb8RL
 OCIjz3AxNqRprgRkrESriD64ZfNyz021iMaaqjuXZWbKhdH/LwcAvnb3tqERRpTo
 qheocBcahVLMiCfb3gAckq+JqO2AZ4uxSm4tdEJ5x7MssmkIto5vpxgaJrJJ2FFk
 KlnBElOAnDw3O3AqjfBTlmkDpLY9yL/qOC/ZSdnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=q4l7MV2jndY75H8Fn
 HCUzpg4YcczCiys3j+UuAaOpCo=; b=Sv4+nDrezxHf6UxpuFCp534+ptYEOnbto
 Kb5wPekK9iJEytE3YcAgy5zMO4XOxb2tRxrJT7GqEuCyVKk+tVwuJS/THyd94o9G
 pSC4uZHwwNq6bkHpFq81vTBPxdEk0RTjFtvdpC+Qpb3fRnsNSwsjylAbovx7UXBg
 7ekN6yoSwXxW6BLJG+h+6dc7tWBCOTH5KillIZLReeWu9jBEY6xjmeHFlpyVQztc
 M74QA4oLGNSbHUN1XVa+Rhxj4U7HiwXPvD8H8NimO9j310DVFg/zFzWA4yTYXxuY
 /6mPWi61DY4mmNUjDg8Axb92pQuAt9oW+L6jzqgkZIJax/xNi+nAA==
X-ME-Sender: <xms:FkhIYhR42kiK1FqHXRbwcpRhLEyp4c0o2SnWS8E7vQBTiOW99kxpFg>
 <xme:FkhIYqw0TZ-9IsJIwAQScShpMxOL00j3WYV4uyJiF6evc4fILw6oYguD5-s--DqiE
 QIZy9G8juUeUtxhyQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:FkhIYm1NIt_VAA7H9sjXR0BWW-OwbyMdJW6hsxPB60SrumlA5YpShw>
 <xmx:FkhIYpBRiv7pfe-37u_9jFsSclDR-b-8hCPMCJtEUE1DVNiKvc93Bw>
 <xmx:FkhIYqjeL_O-acQxdQXBWP6jPy7wyjd0aZb5DVzk4N-kG57Ie229FA>
 <xmx:FkhIYvZqa5Md2ZEEBpOw8Uw73yBY-BIPD9dip8eseRSBsZ9oV45_Ig>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 2F0E727402C7; Sat,  2 Apr 2022 08:56:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <3166b80d-d8a6-45d5-9e3b-2f9998aca0d3@www.fastmail.com>
In-Reply-To: <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
Date: Sat, 02 Apr 2022 14:56:32 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Rob Herring" <robh+dt@kernel.org>, "Keith Busch" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "Marc Zyngier" <maz@kernel.org>,
 DTML <devicetree@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_055655_772524_EA239566 
X-CRM114-Status: GOOD (  29.70  )
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

On Tue, Mar 22, 2022, at 14:13, Arnd Bergmann wrote:
> On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>>
>> Apple SoCs such as the M1 come with multiple embedded co-processors
>> running proprietary firmware. Communication with those is established
>> over a simple mailbox using the RTKit IPC protocol.
>>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>
>> +
>> +#define rtk_err(format, arg...) dev_err(rtk->dev, "RTKit: " format, ##arg)
>> +#define rtk_warn(format, arg...) dev_warn(rtk->dev, "RTKit: " format, ##arg)
>> +#define rtk_info(format, arg...) dev_info(rtk->dev, "RTKit: " format, ##arg)
>> +#define rtk_dbg(format, arg...) dev_dbg(rtk->dev, "RTKit: " format, ##arg)
>
> I generally don't like the custom printing macros, please just open-code
> the prints where they are used, that makes it easier for other kernel
> developers to see exactly what is being printed.
>

Sure, I'll remove them.

>> +enum { APPLE_RTKIT_WORK_MSG,
>> +       APPLE_RTKIT_WORK_REINIT,
>> +};
>> +
>> +enum { APPLE_RTKIT_PWR_STATE_OFF = 0x00,
>> +       APPLE_RTKIT_PWR_STATE_SLEEP = 0x01,
>> +       APPLE_RTKIT_PWR_STATE_GATED = 0x02,
>> +       APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10,
>> +       APPLE_RTKIT_PWR_STATE_ON = 0x20,
>> +};
>
> This is an odd indentation style, I would insert a newline after the 'enum {'

Yeah, I blame clang-format and me not double-checking the result for that one.
I'll add the newline.

>
>> +static int apple_rtkit_worker(void *data)
>> +{
>> +       struct apple_rtkit *rtk = data;
>> +       struct apple_rtkit_work work;
>> +
>> +       while (!kthread_should_stop()) {
>> +               wait_event_interruptible(rtk->wq,
>> +                                        kfifo_len(&rtk->work_fifo) > 0 ||
>> +                                                kthread_should_stop());
>> +
>> +               if (kthread_should_stop())
>> +                       break;
>> +
>> +               while (kfifo_out_spinlocked(&rtk->work_fifo, &work, 1,
>> +                                           &rtk->work_lock) == 1) {
>> +                       switch (work.type) {
>> +                       case APPLE_RTKIT_WORK_MSG:
>> +                               apple_rtkit_rx(rtk, &work.msg);
>> +                               break;
>> +                       case APPLE_RTKIT_WORK_REINIT:
>> +                               apple_rtkit_do_reinit(rtk);
>> +                               break;
>> +                       }
>> +               }
>
> It looks like you add quite a bit of complexity by using a custom
> worker thread implementation. Can you explain what this is
> needed for? Isn't this roughly the same thing that one would
> get more easily with create_singlethread_workqueue()?

I originally had just a workqueue here but I can only put
one instance of e.g. APPLE_RTKIT_WORK_MSG onto these.
There could however be a new incoming message while the previous
one is still being handled and I couldn't figure out a way
to handle that with workqueues without introducing a race.


>
>> +#if IS_ENABLED(CONFIG_APPLE_RTKIT)
>
> Instead of allowing the interface to be used without CONFIG_APPLE_RTKIT,
> I think it is sufficient to allow the driver itself to be built with
> CONFIG_COMPILE_TEST (as you already do), and then have
> drivers using it marked as 'depends on APPLE_RTKIT'
> unconditionally.

That's indeed much simpler and what I wanted to achieve. I just couldn't
figure out how to do it. I'll use your approach! 

>
>> +/*
>> + * Initializes the internal state required to handle RTKit. This
>> + * should usually be called within _probe.
>> + *
>> + * @dev: Pointer to the device node this coprocessor is assocated with
>> + * @cookie: opaque cookie passed to all functions defined in rtkit_ops
>> + * @mbox_name: mailbox name used to communicate with the co-processor
>> + * @mbox_idx: mailbox index to be used if mbox_name is NULL
>> + * @ops: pointer to rtkit_ops to be used for this co-processor
>> + */
>> +struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
>> +                                    const char *mbox_name, int mbox_idx,
>> +                                    const struct apple_rtkit_ops *ops);
>> +
>> +/*
>> + * Dev-res managed version of apple_rtkit_init.
>> + */
>> +struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
>> +                                         const char *mbox_name, int mbox_idx,
>> +                                         const struct apple_rtkit_ops *ops);
>
> Do we need to export both of these?

No, only devm_apple_rtkit_init needs to be exported.


Thanks,


Sven


Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF722C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 15:54:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7279D20786
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 15:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tJIa7xg2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="nQl3xTsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7279D20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S05gsYbI5vMzGZHvwPOZQiHF9AkQp33xfn8TVjZCiz8=; b=tJIa7xg2HwwvoIUOavKLbMyY5
	rZe2afWHLbf8bF7y8J8Dlv43egJeJj+oKXuVZzWjgmP7KCK88QW5Wy/u2p/rpfaotOLkUWnyQXT9t
	DUZRrWpo2s81A0xVWy8tn4qlj4yY9siF8bdPCUHKt1UTHoSeOh9lBpIvidLMRmzFwhLS3Drf28oz4
	46KabbbJZ2mwEzBKS84O0QHftuf/+AWGXFnIKeXp1gJQQmcn5a2ZMEhfKEZXrR4t1pYRqBRhzLGIN
	d3/Zi/pctqxPFJUlDi6dklkPRPY3YGDGLtoyb67PjLJCVv9AlIHutmN9jMns/pzJRqpZ1Q2+p5iAE
	nd98hmPcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZydh-0002Tt-R0; Tue, 03 Nov 2020 15:54:29 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZyde-0002Sy-HE
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 15:54:27 +0000
Received: by mail-ej1-x631.google.com with SMTP id cw8so11271142ejb.8
 for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2020 07:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GKkCAwgf84ufWl+/PdshXLTU/tRGU7u3qAN89WeITQ4=;
 b=nQl3xTsa5vtJQjG4KYbo4x6TiBF19hSWOhPinkbd4ngLeDqxIvyrZlIky2gBQij/B+
 86fFPDQU6yhtiSW5yCiun7WIjBXS2QulI4gqVpuqLSPpG/REKrE5gFHwCxMItBsoLNdn
 86ZK0mXhTcjXk5jtGlSRipii8IClrNlP/hNCq3W/qXLkK2MAZ5YNoanmcH1+yzbU1axc
 wu5CcbWz9StAFHMr9nHJnIfjmrVNl7o4vILAZdLc2I0QKQBYMZlCZwBpY7uUDEzecVUB
 9ZuoLUoWmG5IMFWwqwa5CJewNL4IF2YS2RgRI/ZzwW2Zu1ocdLmM+vdrVGnvw6RBBeRs
 V1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GKkCAwgf84ufWl+/PdshXLTU/tRGU7u3qAN89WeITQ4=;
 b=Mq9uqbnKUv7VWQwRkzKXjATmt2hpLCttnUyrxwBe0YkYCLUiNtvAXcQ0mbNNzdOS+u
 +suF1bvqt2KpleE+PPtPgZJXWgUkIdMWN3sM4xf8ialLzgEbZ9A+xDwu3JHEBouaLGaz
 ZevmWmL0qFRdG8avuiL4hSTma0VZdZKozYwUrf9Swb+KiLrQpsTXnFLH+TXG+WG5STMR
 bepy5pHLEZzpcJtSGii0WbE/V8W7S9BbCRWfiXebQ1V43sf3rrtcbU82mT1cPMNnUzjJ
 NlzXMYtbylh2dTmf9ejO2SX1bgQOXN2CdYl41BjXIdvtoT7cT5HfcfGKUYD2/ZEGw6az
 3Lzw==
X-Gm-Message-State: AOAM53128BjAMmbFm6GQGwloct662vXS0IMZOfR8Ew0CXNIYYLgRlzMe
 7adNKJOTb9XHtHBuzHfK524CWg==
X-Google-Smtp-Source: ABdhPJzXawt82+9ygKeGcsIucHItooLGUZLhbu6fkX9FwzaMORFdls64C3yEYstxDfmZvWnDJwIBNA==
X-Received: by 2002:a17:906:b294:: with SMTP id
 q20mr3755330ejz.234.1604418864925; 
 Tue, 03 Nov 2020 07:54:24 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
 by smtp.gmail.com with ESMTPSA id t8sm11097412ejc.45.2020.11.03.07.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 07:54:23 -0800 (PST)
Date: Tue, 3 Nov 2020 16:54:22 +0100
From: Javier Gonzalez <javier@javigon.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201103155422.uwoigzmrgks27rtw@MacBook-Pro.localdomain>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
 <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
 <20201103090628.GA15656@lst.de>
 <20201103141019.5eomaxs4qn4ezaeh@MacBook-Pro.localdomain>
 <20201103152609.GA10928@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103152609.GA10928@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_105426_731526_B2485684 
X-CRM114-Status: GOOD (  18.32  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03.11.2020 16:26, hch@lst.de wrote:
>On Tue, Nov 03, 2020 at 03:10:19PM +0100, Javier Gonzalez wrote:
>> One question here is that we are preparing a RFC for a io_uring passthru
>> using the block device. Based on this discussion, it seems to me that
>> you see this more suitable through the char device.
>>
>> Does it make sense that we post this RFC using the block device? It
>> would be helpful to get early feedback before starting the char device.
>
>If you wan to send the RFC with the block device that is ok.  But I
>think the separate character device is pretty trivial, at least for
>NVM command set derived command sets like ZNS (for others we'll need
>to finish the Command Set Independent Identify Namespace TP first).

Ok. Good to hear that we can do this in steps - I was worried that we
would need to cover this use case too in the beginning, which would
delay this work significantly.

>
>> I see that this does not make much sense for the other non-supported
>> features in this patch (i.e., !po2 zone size and zoc). Since this is
>> very much like PI today, is it OK we add these the same way (capacity 0)
>> and then move to the char device when ready?
>
>I'd rath avoid adding more of that capacity 0 mess if we can.  Especially
>as the character device should be really easy to do.

Ok. We will move ahead with the char device and port current capacity 0
there in the series.

Thanks for the guidance Christoph!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

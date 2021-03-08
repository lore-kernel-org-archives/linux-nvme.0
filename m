Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA8C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 18:59:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F86C65267
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 18:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F86C65267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e79IR893U7+gEXNeAQyk12HUJXeDeeTpM9YUl6qqDsQ=; b=Wg1SFq7Do096LxcE4+cq880sU
	NW72TxzQgq60oe7jiX926kooYA+PfCsZVyXpUbv1AN4TKUdeqwYqTkSPV+wb7luICT/8YiOEscaBn
	TGDEGpVIF832v7o6Uw68QAFH7UzalYweahMzFzK4omqM1kM5HruROVKHq8l8Ito8ya+J1RMKhOa0T
	r7ULr4LRIFbaSKv43DK3eSgeSIzlbN50CV1kGsnVvlOWrsfex1BJNZtb/Of3HHRynJrNIbdQs92zI
	E/tyzGEnVA2P1MXFB0zMlkuO6kVpPsFidbfHr1UbRbePV80I4k87SFvRaySReofiN+HLh9D1Tdoii
	JAYJdPKQQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJL6N-001uKr-9D; Mon, 08 Mar 2021 18:59:35 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJL6J-001uJf-0o
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 18:59:32 +0000
Received: by mail-wm1-x334.google.com with SMTP id
 m20-20020a7bcb940000b029010cab7e5a9fso4449213wmi.3
 for <linux-nvme@lists.infradead.org>; Mon, 08 Mar 2021 10:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B51YXtZ7f3QnIGLgJ2UjjveLvus1J0aaMNnETZklxLQ=;
 b=aoTMd8pz4Nuz1lt9PTpRB3fN+zvQ5bZ9WNvER9e9Eb81RaQhJDzj5CuPU6THhhtyok
 IBe9b7oy78yNyD/RAxwkSrRRbYPhXaKnByaxFbT4iYM411ysu0ClTBRdXMUwU9wLlVh7
 z5jKoSM00EFjaQAOv5SZt41W541mB9JeHnH6ibXaEehpaES4iPtxQTU6Vb93Gotkpyea
 Zxm9hYE/VYELNopk7hx/ABymkTb5iCc+L808Ujo2UpIk3rmhe3pKPSLOAfYgBgtNL7Dx
 kYPxGpNEO+/0nlXLa7gVJR9sweoLHvdE4XM7kQPsHDFNeoNBEoYcodJhylZzVGlAhhKU
 satA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B51YXtZ7f3QnIGLgJ2UjjveLvus1J0aaMNnETZklxLQ=;
 b=TBEpTXKgQ3fxeBIFTNrbF5iY5/g9E0g9hzpReUS+r92n3hIgLt2832cVOtfcJN9Gje
 jthOEBlMAgCURepAyZ4WDNi2chMYc+BUpS5NNAKiBWdM2uusSZn7iIGkOt3kYnXHLyA/
 zCa0ZzwuePEuKYysQPTYATo5D3KSAGpDIHdklplgtEJWhAQEuNSMI1j73QAS2hKfOtQT
 z6g2FacfaJqJ3O2MFKzLQyS7W88jlfIQGkAkDSZmCBdl36Z1SBD15lqWWYmh7nEEc2Mw
 IwXHozyOZ9cBQK5PNOTh6xyZjeeksgAeqnI9M3eM7j3G+GdwXG6ley+uTkg1mhrjp0Yg
 Xaow==
X-Gm-Message-State: AOAM532Ei1m4IT3vKk3JD56KERZnkaJilUVQiSULYFnxJ0MLI0La0gEt
 Cv6M2MOoKpUzgxNXT/8LwI1O+ZBijsmcN2zrZ9I=
X-Google-Smtp-Source: ABdhPJxo1HgPt2bnyyQKsPjkruL+6bZcuE9DPkkJ/m2tQXjJ9/cN5Zb3Nn0Pv6LqpEG3/rkPkEkuYulKmLXpSFwo+tg=
X-Received: by 2002:a1c:f708:: with SMTP id v8mr215585wmh.25.1615229970349;
 Mon, 08 Mar 2021 10:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20210303224717.51633-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210303224717.51633-1-chaitanya.kulkarni@wdc.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 9 Mar 2021 00:29:03 +0530
Message-ID: <CA+1E3r+h_N4x129mtB2b4cs45XCxK26P0K-d8NAxQ9whvHx_1w@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix warning in nvme_update_zone_info()
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_185931_238842_12F905EB 
X-CRM114-Status: UNSURE (   8.88  )
X-CRM114-Notice: Please train this message.
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

On Thu, Mar 4, 2021 at 7:59 AM Chaitanya Kulkarni
<chaitanya.kulkarni@wdc.com> wrote:
>
> This fixes the issue related to the chunk size sector settings that
> indirectly affects the zone append max sectors settings.
>
> Move setting up the max zone append sectors into nvme_revalidate_zones()
> that removes the following warning:-

Faced the same. Looks good.

Tested-by: Kanchan Joshi <joshi.k@samsung.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

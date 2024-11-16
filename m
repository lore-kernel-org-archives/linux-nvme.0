Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D409D68BDA
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2024 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+xwxoFfvf68t2c05O8hFSikNCB40lKremk6L5/gXfII=; b=IYIKKpPjGfRIM5+D1DfglpXkwX
	CNBjy2+D/A1VXNhIZItm3CmTpmHPmqTt3BI4tH3op4sbwcXdKaeEa+Fx9jGRoPNIQZTGyddJLu/SK
	3Mz+DuYsF7lhhDWLkj96ICIHZi7YrDqLwajjx1QJaaOwT9iBErxQE58HFzHBflbqZlC+1pD2nP3fu
	1IKHKYpscRo9n+7ehXJuTk0KcQ/iPXr+wDPSrPizS/DxADF2iL2+EbV3mCYMIf8xS84XoV6Uoy2QN
	qfEkHQmdtPeQE5+My01CFb1zXjqnVNC/7+9EuyqewB/kst148r+jYYWYDn0hLq+C/dxWO5PCvlaPe
	e0BvtBjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tC70C-00000004g0h-2i3b;
	Sat, 16 Nov 2024 00:49:28 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tC70A-00000004fzy-2shn
	for linux-nvme@lists.infradead.org;
	Sat, 16 Nov 2024 00:49:27 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-aa1f73966a5so37418166b.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 16:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731718165; x=1732322965; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xwxoFfvf68t2c05O8hFSikNCB40lKremk6L5/gXfII=;
        b=gesC6d56Kl3SQZLv1cnpg+qqYY6ioVg9Ekcynp2x3DEGDSMleRSPZSYmPEE21pi4bd
         RE7zfrGlnn0T41AZ9294lDt6UieTMioVOPfl9U9yZUgMm2QPO5/fXD7lwHPuD6nE5fC1
         UsH+3BDwhAW8gmYKCyMe9aMyQA9PcFdVvX/AgNVVCL1xwPx1m8Qkhl7Xa12MBprJGlhW
         SzKIDdDfpNQywvPli4CO24evdw9vaw0LtZEIUMayUgNYpM9wVuwWekVclGTFmBBlzIVl
         sP3xIWLG9y74v0ip3ZCUSzf1+XLFcplzHdyAS1vAlNzU5izhdeUCsiGQrwPZjQ5T+w1k
         S7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731718165; x=1732322965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xwxoFfvf68t2c05O8hFSikNCB40lKremk6L5/gXfII=;
        b=n1HExjDAukvv3YqHHEWX75VKeXjRHqOOHUYM22owTMLUbhEd8PFThaoEYVxOekwal3
         FL/fgSKVXUEoQ4xNIclPlsvAVzSf3LJh3GsDEzYfDee6UasP/Lknq16lGHHP3O3B0SLo
         LRNicA6yUP0NeOLbrGv7Z/9gIS6tAhPP96pHRtZ9OHKhEmMoG1/azWhLuafw+YbD6oRT
         l/W41JDfkccQRcYTxlQoCWDNiRLySevkndoQHn/kXas5tfJ696lM7ppeBLRexL7Ufj/H
         HN3ahSwRgERRYFKCO/HyZRdYujDXDhxVZo3Stt0EAcw4Wyq1L7KaXaobuzXN6K5Yf357
         akMg==
X-Forwarded-Encrypted: i=1; AJvYcCVdWp+JGQI/dL7bI75S1dhyWNRI1CVwyPs8esAqQ0UV1aMv6DsT4f0zOz4NM/yiVPnRS5ELVZGvyMZ6@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7wWWUbSpivVvOXp7Gf2jIfxOnxWEUNU/aJD7b5H8LhEk11Wa5
	jTr+MPtJpSCyX3dw13PUEYXgbkcC7RUxULbBeCr7uH/LUbO0+WJAa3dWmh6ME8RP4KkpebK8Py0
	CVsp+JV3x4ov6OipVLlP8hJGSsFc=
X-Google-Smtp-Source: AGHT+IGJhrCM+OKJAlm6GHOVvnO748E+3lOceZsjr9NF3aDCAblWF1jPWsXgrJZf7IqJ02WctNO7J/Yo6xUcWus0bp0=
X-Received: by 2002:a17:906:c112:b0:aa4:7905:b823 with SMTP id
 a640c23a62f3a-aa48347cb36mr374323566b.32.1731718164714; Fri, 15 Nov 2024
 16:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20241115083727.30005-1-brookxu.cn@gmail.com> <20241115170411.GA23437@lst.de>
In-Reply-To: <20241115170411.GA23437@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 16 Nov 2024 08:49:12 +0800
Message-ID: <CADtkEec84+ECj_s4Seue5uC+xv3dBu6T4kaqeHMe9PLiLV6tUw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-core: auto add the new ns while UUID changed
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_164926_726528_9F60D939 
X-CRM114-Status: GOOD (  14.20  )
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

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B411=E6=9C=8816=E6=97=A5=
=E5=91=A8=E5=85=AD 01:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 15, 2024 at 04:37:27PM +0800, brookxu.cn wrote:
> > From: "Chunguang.xu" <chunguang.xu@shopee.com>
> >
> > Now spdk will change UUID of ns while restarted if we have not
> > specified one. At this time, while host try to reconnected to target,
> > as UUID have changed, we will remove the old ns, but not add the ns
> > with the new UUID.
>
> And that is broken behavior.  The host must assume the namespace has
> been deleted and recreated when the eui/nguid/uuid change, and we need
> to catch this.
Yes, now we have remove the old ns and log the change to dmesg,  but I am
confused why not auto add the ns with new UUID, we should treat it as a new
ns? so that we can avoid an active controller with no ns, but actually it h=
ave
one.

>Fix your broken target code instead.
>


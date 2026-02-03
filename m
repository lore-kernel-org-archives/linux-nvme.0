Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88A7E87821
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qZc/uqnnF5pM3LFdWx3+0pHL2/EUhPi22QlZQWxaqa0=; b=2DBTQFjg0Wg2qJr98DwTx+eG1f
	ND98iqC/SpumInbvRIdkaDEFC1uU1xcxP0jFutRjn+OJsFsMmJsZT0cK3OpbI9CORpMVm/NCgg212
	y608ORo9wt5AeCJOd7p5lJldQd7M1uuxZa8IFKpxDeZBhYNMDBA5x/3C4vgPXIzAXvBUw4hUvPhyz
	+FoR55lIlIQcqCwTVQrq8rjTL+KL9dyXtQBaFWooYSrrz0kzAsRjnAyxRDLm1CVT7NWqy4YljU3pG
	06TEkmbeu9WJEFjXzQrU5ZfkuEVqBnEouXTTtg5UFQv24uPlNweBFbbcNVIBXz1qIiTz1fmdYD5Fq
	LY5X/D5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnFVm-00000006b2P-1Hn4;
	Tue, 03 Feb 2026 12:28:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnFVj-00000006b1q-13Sn
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 12:28:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770121681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZc/uqnnF5pM3LFdWx3+0pHL2/EUhPi22QlZQWxaqa0=;
	b=GtnjeCXpfU8pCnU183F2AU2zDGyZAh/BYx80LtNicknra4aaWe2ZWko3xCui0wolVzQrRk
	lljoDhEe5Do7fzkmiSYJPH7DtsB2WpKCg+CTuO8tNMhyz9xevBsEACcia7uqJ9uuYQr8iU
	k44B21h8kDppeBKrX6HsX2eeVRDALpo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-AqOnY5_kPIeeyQyB6S2F7g-1; Tue, 03 Feb 2026 07:26:13 -0500
X-MC-Unique: AqOnY5_kPIeeyQyB6S2F7g-1
X-Mimecast-MFC-AGG-ID: AqOnY5_kPIeeyQyB6S2F7g_1770121572
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9483e4a8662so8878273241.3
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 04:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121572; x=1770726372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZc/uqnnF5pM3LFdWx3+0pHL2/EUhPi22QlZQWxaqa0=;
        b=AQDteqjzBBepuEEdEqMR4McYhRpTZolHql3BP/UPzouL8/UcTVfJh8InSiO+ICpZTP
         ovb43/MM/xLCpctzLGo32K9D26hnl/FM+GMcZewm1zCQ1st44mEp/2FpXD85JNEpCYW3
         B3ZLzvcpV1wOX5eJBxQI60du0bz6tg3ehAzzPV8vFQnSZhdyOH/sPWjUgtmTQjCSBw5T
         9SN1bxmz1JxFOSCZZ9iiiLQrgTvtRGzd4+SWTpEmMVlHQhb7z4WqThhU1eLyQ2f8tX1g
         lroiBjoEHZ1GqMQ4sSE/jXKvQRF1JWy8PLCn798Pf72y/MH5jyswUvf1XkfqVTdKBE3g
         rSgQ==
X-Gm-Message-State: AOJu0YwA1voyRBU4qZQwUzSRrqECaL8BqTwmEkNC0axTWhP5lsGEErfJ
	HOezxMQmNgO6rr1uuKORcaQ1t1EW3zj/Ek35y1vO991JNmqSh39v4UkszGtseqfHE8Gw0O0dFmq
	2ZP/fqh7Xa48ZcUzNNtO4DRiHTjlrNNPMlXl94sJjtVS5tDpBJPNpeTziHYYqtKtWFcHjAHEfE4
	VC1adS7/+GTyzSkG7RRI69yMp6mgjYGZj3vdLcfHC2T80=
X-Gm-Gg: AZuq6aJPW4a213zVeYePxIHO3YMH/4PrFbRM1rUyouXL5NS4PgYTYtX3iVybmOZoJKo
	v5Qk6xQ1OGRisyU/v1qYjvBZdjtk412Btl9hk43EsnPWx4NCzzOsb6CvV6eOthrdRZ+ozsDhXSW
	Wqq5733v5yfiWXga38gsULt4reMQWGceSiEQ+/NVu1dp+f/Ab5HKDJZ2MV46rjlrFZBx0=
X-Received: by 2002:a05:6102:c0d:b0:5f5:773f:b1e3 with SMTP id ada2fe7eead31-5f8e24832fcmr5402891137.11.1770121572394;
        Tue, 03 Feb 2026 04:26:12 -0800 (PST)
X-Received: by 2002:a05:6102:c0d:b0:5f5:773f:b1e3 with SMTP id
 ada2fe7eead31-5f8e24832fcmr5402879137.11.1770121572010; Tue, 03 Feb 2026
 04:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20260130182028.885089-1-nilay@linux.ibm.com>
In-Reply-To: <20260130182028.885089-1-nilay@linux.ibm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 3 Feb 2026 20:26:00 +0800
X-Gm-Features: AZwV_Qj1zwbbDYDJ6B8oMnRNBruRoWuGSm8JmWsOCObXKGsPqBegx1VsaZcc-1Q
Message-ID: <CAFj5m9KuHZKoqRMeyM6UpoZsVrhg32stx5piEY4BBA-+xkiJPA@mail.gmail.com>
Subject: Re: [PATCH 0/7] nvme: export additional diagnostic counters via sysfs
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk, 
	hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de, 
	wenxiong@linux.ibm.com, gjoyce@ibm.com, Ming Lei <ming.lei@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TplkPDxz8RgcLu6ZX6B99ZaeKlbisNUlQvs6APPEpAo_1770121572
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_042803_381004_D75DD4C5 
X-CRM114-Status: GOOD (  10.10  )
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

On Sat, Jan 31, 2026 at 2:22=E2=80=AFAM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> Hi,
>
> The NVMe driver encounters various events and conditions during normal
> operation that are either not tracked today or not exposed to userspace
> via sysfs. Lack of visibility into these events can make it difficult to

Not sure if it is true, you may get tons of results by googling `linux
bpf observe`.

Thanks,



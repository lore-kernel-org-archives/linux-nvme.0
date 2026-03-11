Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE0D103E2E6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 20:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vtFyYHsYWGPuT+NouTUSHEKBhPn+1qS24w699pOc74=; b=Y8i7w2las5KVUTEhfKLlkivHA2
	Ckl0K6qkboR9fmnofhZSLwvn7Bg2H8w9RB7M+zZMmbxF836oQV1nH8ODUIudqB3L6XSmpj7RjPk8T
	FH4/Uz9Izea9O0i173cQeLJjaCrUPHEXAANXw/3UNMR58r+GYfxp/ZYnUCiJ7orq9jkXYR9gwhKg1
	R+1UEVHb+j4gZyzft+s7jaVXEP5yN2k6qY4oUgv+nLAPIHeMbESUoKpCmntfwaM/Z1RikaEAx7yrp
	Yj4gpGF5JdI0DJrOyfxGk8QB2gSaphJ1+Lh2ARV2DUW6jkYYLAlHKVfRwMp4pUnZ/JmKgmPqJsIOo
	tHianwXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0QRa-0000000CWJd-3nin;
	Wed, 11 Mar 2026 20:46:14 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0QRY-0000000CWIv-0Xb6
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 20:46:13 +0000
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-662c6aca253so319121a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 11 Mar 2026 13:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261969; x=1773866769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vtFyYHsYWGPuT+NouTUSHEKBhPn+1qS24w699pOc74=;
        b=YU+4EBRac5xh5wIl/Aqf5PSjh5eAkaK3m8BSnh6GjsKsxmp7Lfg0B67Lqrsvh6CLJ+
         GTCDwuW5R9EsjUxhswLXq/qOOqtT1utztDF96fyNVLns/eHXXakmNOyNxnXALqj+z++T
         zmxqNwvETYyv8lfIukdLtVSUnv5z2h4N7yMIQTrcbLClI8MOWr/wLV75woxjwfbNEFKZ
         v92iGuk1txw0MfS3flN9/1thkvb73JHyDRdxmOg5A5VOkSmTr6QMtBP+XrLPURgHHAzd
         uKufrRX8rSDPd6wg+jyWsiwmu+Hzjsv64SEuYuNJj/QnaySGTDL+hZ08L+c62kSe8H/R
         vZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdpJkfY8PKnDlR+fr5AG9QClibzK3AeqMWPHTVJexJ/jO1Ye0ctYr46KgT7DzG8sFvlZ19QHPK8gNo@lists.infradead.org
X-Gm-Message-State: AOJu0YwbRDPR54ZnhK5AknGUIwIJ8vkD+Qyn36IKazZizD4AkqaFthym
	AeYd89XP1XmERElj2Pg35YYFgu3K00z6q0fu7sUbl62o+yJJu10poEZ2FQdBsGdwC6XETg==
X-Gm-Gg: ATEYQzzD0cmXVcRC3MGuPxbMcgw0RUAHNNhZVvNDT/NG1TAe2bhRYexIm8VtjeoybOy
	4bYTDaaWuD0c+p9fWWQsu0IAnlQ2VKUOdHsJ28NPguuk+IvBeFYrISLrHzyc0P74CVVa2Bb6aCj
	a2jHFYfKLo4gXQ+uWAWo3wTGszH0mw31sB29WexJR/Cq6gGutQ2eUTg7QhxZs0Yry8VYu7iN+ZL
	bTjKVlK0gE33xfAbdB0pG90bDSlK6gcrShQg89tprVmt+7KN0yaImPbqV6vMsgqmce1XVcSALuw
	gUIuBL0NT408SRAF9UVMInkmG0plcxiaUVdkaRnq8PL4dkMHeaq82Aqn/v9awhRS1Xpe71tzbEg
	K+qD2tkAfolZI+4ehqPyApmTI9Tw6AXR9iF/fQ1ePdaoGGTJ0aVcazNNN6ZI2JvNxnTvxsG8hT0
	NfOCLrhJPKTSG0SL2Ud4ffk/GYe2RT4pDi2y6xYcWjRA1cQfvcHWQpVnY=
X-Received: by 2002:a17:907:9594:b0:b8e:d1f3:4744 with SMTP id a640c23a62f3a-b972e6cf023mr215052866b.55.1773261969466;
        Wed, 11 Mar 2026 13:46:09 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de092b0sm83451666b.3.2026.03.11.13.46.09
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 13:46:09 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so2289115e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 11 Mar 2026 13:46:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqFXRjdmZENVgEGktdgTLpcJaDEVggjKW//xwkaIM3Td9T3861SNEVh0Dn2ivz1tYBeURcCDQl/RKw@lists.infradead.org
X-Received: by 2002:a05:600c:8b45:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-4854b1008famr57069685e9.16.1773261968422; Wed, 11 Mar 2026
 13:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260307194636.2755443-2-iam@sung-woo.kim> <abAp3s7aDyKDIHdk@kbusch-mbp>
In-Reply-To: <abAp3s7aDyKDIHdk@kbusch-mbp>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 11 Mar 2026 16:45:52 -0400
X-Gmail-Original-Message-ID: <CAJNyHpJ+jeqag6Dp2kA0ZxjsPOqQwafQu0uZ58yuTV5vc3z=EQ@mail.gmail.com>
X-Gm-Features: AaiRm51VPOw2wzTL-9dLMOCYe6n_DGypl00QdNvpnW5-DFeXukTAkQvRnMgnE_0
Message-ID: <CAJNyHpJ+jeqag6Dp2kA0ZxjsPOqQwafQu0uZ58yuTV5vc3z=EQ@mail.gmail.com>
Subject: Re: [PATCH] Fix race bug in nvme_poll_irqdisable()
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_134612_176003_09A3BE9E 
X-CRM114-Status: GOOD (  13.62  )
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

On Tue, Mar 10, 2026 at 10:25=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Sat, Mar 07, 2026 at 02:46:36PM -0500, Sungwoo Kim wrote:
> > In the following scenario, pdev can be disabled between (1) and (3) by
> > (2). This sets pdev->msix_enabled =3D 0. Then, pci_irq_vector() will
> > return MSI-X IRQ(>15) for (1) whereas return INTx IRQ(<=3D15) for (2).
> > This causes IRQ warning because it tries to enable INTx IRQ that has
> > never been disabled before.
>
> Thanks, applied to nvme-7.0 with updated commit subject.
>

Thank you for updating the subject. I missed it :)
Sungwoo.


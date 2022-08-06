Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED2DC25B06
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Aug 2022 08:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7CDG06zN618piD7I8XW6HV54roMQW74LZKrYlU2KVo=; b=Mu6MwbRHJVtxO0yEhBSSgONiFI
	K/9bfZO9q/eo/PpYHyZZTYQD8FJ+KNUgpMHUJuS1pbQgKsreoOJjv60+UdRQlGx637q8ZVeG8XFGQ
	eL6P7oeEGi7w+n04AEjLVdMB8W6xukU1g1SfRV33NYnftcJurws0YVBKSErVQY/QMwVaFOMU6oSYo
	GMYM4/DyKONEYK6AT1ePLTxQejxiw0Od1UJsCUbA6yz3tFXQ0oe4qgIQFbeNmUR9JEud1CzS9W7LP
	ZMSbg39aWIOmj5NhxiU+uhYBmrBb6PYsWOdK6Tc3NplC3hAmaeBDHHWZhN1lQNNdKAAUCKTo839yQ
	5C0r9XHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKFDO-006XMu-6y; Sat, 06 Aug 2022 08:31:22 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKFDL-006XKL-9F
	for linux-nvme@lists.infradead.org; Sat, 06 Aug 2022 08:31:20 +0000
Received: by mail-pj1-x1034.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so4918116pjk.1
        for <linux-nvme@lists.infradead.org>; Sat, 06 Aug 2022 01:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=U7CDG06zN618piD7I8XW6HV54roMQW74LZKrYlU2KVo=;
        b=UUDrbZWgRpqXR+CLnt9LoEmxXY/Pc1aJUccgrdGqu0YsA14a5lPzygPODth/CocKki
         mBnHNTPQNp13GdwKQyJ+gfic8P+lOyk9RUas3tGEfeDCoSD2IHgTaQtrCMDx65ReUT1A
         aj+r6GIACNOhLprALVV8/NmcGux+c+4X2P7+EdC+lB5gMDteQsV/hkbaIm+KYxqeFhHb
         ybZHq78rtQU3Hc7PzbwhkeUmXXegrlIaztG/ANsRILPjoavi8nJaZjNGZDoM3zRyPdXV
         qgnEIBZKSyPCeEK93nNornMF5nyvNWytnRcBDPh74Z58OhJ9qTkIYXJuuRzgBfMprKrS
         TONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=U7CDG06zN618piD7I8XW6HV54roMQW74LZKrYlU2KVo=;
        b=KsISF35C1G5yBO+6KQULESR8jU8J0hV5aMDg0iDkvHa0wSZ+aEkaFy+UvpC+xZ4Qii
         b672tE4AtRBJv8FdPss8b91zY0kyddu7ILRYK8qGFU9rPKvELhy9t9kj/106bgD9oujl
         IY3cepKzsmGo4BTF8eiA54En/SMoAhNOXMsqGW3eeUVNr4MRoVyxEFvEPMsL4q7TlJqe
         CRcqxthvJwYSq0wUyL0lakzgk5/+pAqq4QaTA3udi6Kp5JJSHLPbcSWLowsSFBajToUl
         0MRxcqZgW56M4r/kYoZdLR/Y6b0X3IqZ5qy0hCHjAhiq2vzoH72YHDdU6lYk+AzaeF/y
         Bv+w==
X-Gm-Message-State: ACgBeo1w9CXf/ufZUH7z2uHrIn8tKCHmoX/L/mx0BjYJhoEk1NOK6QXt
	kzSKxExCrHlIzUgBntTvQj4E39fNowg=
X-Google-Smtp-Source: AA6agR7AaJLrj3eI6R/M9IZho/wQiYkk1PJuKqZdIh+hiPUD1ZIXBfdEjxqrsFzHzO/bUHfxaLnwcQ==
X-Received: by 2002:a17:90a:bb18:b0:1f2:f715:60bc with SMTP id u24-20020a17090abb1800b001f2f71560bcmr20084236pjr.215.1659774677166;
        Sat, 06 Aug 2022 01:31:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902f64b00b0016c0c82e85csm4382429plg.75.2022.08.06.01.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 01:31:15 -0700 (PDT)
Date: Sat, 6 Aug 2022 01:31:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] nvme: hwmon: Add support for throttling temperature
 feature
Message-ID: <20220806083113.GA3986075@roeck-us.net>
References: <20220806054606.7280-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806054606.7280-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220806_013119_364210_5AA793B4 
X-CRM114-Status: GOOD (  10.86  )
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

On Sat, Aug 06, 2022 at 02:46:06PM +0900, Tokunori Ikegami wrote:
> NVMe drives support host controlled thermal management feature as optional.
> The thermal management temperature are different from the temperature threshold.
> So add functionality to set the throttling temperature values.
> 
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>

NACK. There are several existing limit attributes which can be used
for this purpose. I would suggest to use EMERGENCY and LCRIT attributes.

Furthermore, one can not just extend the hwmon ABI without discussion,
much less as part of a patch introducing its use. Any attribute introduced
into the ABI must benefit more than one device, and a matching
implementation in the sensors command and the lm-sensors library is
expected.

Guenter


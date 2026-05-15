Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6463CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 02:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jBq+3MELdGprhjI8CVUP/GgT+nuKS2rksIc27/M8UEM=; b=pIp+5aXdg/abpI2X/z4gc7haWu
	Z6pSVy2xs1YwCgB3xAbQz8bgDvLmbL0hdIzEosq59ivhJV56AskHzVvbXtYTjXIGdaexHKEzedD8y
	8CUNQQpd3qJ0CZkKe4ewWvk3UYLbGj/JO7DSyKVLRXbL6ejraEl3Wty1phiTaimpKIL8nP7Ki1+T5
	we1ig520wBEbQoIeuEloeiTIkqGMZ1XjFQq4rVLaEJAK7KAqKu/7iLrTWMU/ZzMXT/VKOd72ZjkVR
	GljnO1GjahG1UCnfLPwP8X8gAXsST6USh682nt9K0mg5u2xp1/p0pozZBqov3QZkkC1gVELUD9NaR
	Rj/iUSUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNhu0-000000074ko-3fOY;
	Fri, 15 May 2026 02:03:48 +0000
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNhty-000000074kT-0PLJ
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 02:03:47 +0000
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-9568bae58f7so5438686241.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 19:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778810624; cv=none;
        d=google.com; s=arc-20240605;
        b=g7YPaCTpZoPWGTcgv7iWZdx9IiYfICdB1cXLnvRKupKeREgrp+QT5pk/6vOC4pupLQ
         O1VSb5+RSiCALidXmShiEdu+jFg8rw6la3y1KVfkhnvczB7gKTqitZerfTLMCgCuqlmY
         NHGGmRpKA9I97np39FcQjXw441U313asiOoASY4Z7fTnKHi7CRzu3YfcYU9km8k6Ja1P
         DiJJj1ho7k8u5Ku4LrBRlGAUuok23x41M4Vd/hWF/xsk4C0Djj4ZLFaw8Ix6+biLeEIw
         iZcPHBbojxaikcWcWllYqMDeSrgvSwupCkj2hPPioSAp8GXyM15oVk7TJuyR/hP7qR0q
         ct5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jBq+3MELdGprhjI8CVUP/GgT+nuKS2rksIc27/M8UEM=;
        fh=Rzk00BQfdcXifSrFekHLZPi+P81ftOOO1TfNCDU/FEc=;
        b=BNXbHE6Ez96cTYD4KxsfPgqVM/LovUIOPewizBKNFerpajf9duQX9AFbvB3I2wIKpH
         diPqbgEH6rt4GMmonKOMA9GkWPoxp4ASBEoHaaYe6kT1KKRWYnTv+px0tFQacxxXFH3U
         W4vkiaAQAotuInY7SKM/pKj+4eHXGLakhjMe6EBDB6GoM9EZM8mKW19wTJJb3ywNiVgN
         g2kAvhfhHXfXt3HllnATu7gJ0lge1B1TA3vpZAFRMWsFxZhEaK1xNUX2dJVg5iEuRuS+
         /gnKtudDTD3BZcRLlgs8h6u5m45Mjj4GWrvJW71K7R4pMgWJKxWo3K+nT9OzCnz5Ojyv
         ux8g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778810624; x=1779415424; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBq+3MELdGprhjI8CVUP/GgT+nuKS2rksIc27/M8UEM=;
        b=Inew/6vJjs0uKgx1bfJz4vGPK5W4hG0AGCkRYe7f9J0g9UpTLLTvOOR+zlEcGmnlq5
         12mPgAxYUZg/Tq0BSTkKuo1oQYJVgHSIknGlJIUt6t4SjTwowNKSNRCsMEbf8hld7N5W
         jZTt9jbM9T8BSAag3XHr5k16nlkOrv0w3NT8nZWETtTpClUWBHQhXFXcB+UaWOPmOFI2
         z0dB+2eQZzeuJ3Lw8cUZYI+80k5twn+tYiL56CJU5QN3koQimR9+k32GYUxzQLG6UeK9
         5w3yWKIHeNBNmf6Xpn03gWYznjYtPkC3jp7tvljAuWnDAkCdAehE/TY48y1OYf2VX8n6
         OUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778810624; x=1779415424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jBq+3MELdGprhjI8CVUP/GgT+nuKS2rksIc27/M8UEM=;
        b=VXMlZZh/F5kjy4LDGHUoKloVMXHw1RZG6rq5xkrih6PKPLUeEmANFUzX8PLrxLHFs1
         /c1hREB8wpMhWVmATDuwEHQEgh9oOJikq8Q03+APCG4bZQqER7gcD0Pmyn5iHV+fA6Gz
         1CUMBd15sqJvril2DAhdnGN+j6HL9O/2l1mwG9XsEltHHPQx3hDxqBf6ut3+k71OFnzw
         tCBk0tYl6AkgpuWp8JlRj+NTcXt61kYi2KCchimcUa/P8qzhkFnt+T/VAHdPNcHs0cTP
         EY2nRNrX3rxL1HW6/wvJG7zE85UPv4Rx8b6dDrOzpSYgy+exN4fyAn/1O2CzHTfsTknN
         tGIA==
X-Forwarded-Encrypted: i=1; AFNElJ/wnNJ8nLOohe2licVUlp7IFJMY213AsbgXJznzFKWe8kqzBZY2fkXCVTXX1du64gXbbKLquCQlVQoI@lists.infradead.org
X-Gm-Message-State: AOJu0YwqBuXQs/biLp5iKe4YspnRTEhJF2v42dV7dmGxHw5KABOpeRmp
	8hq9dUe4W5TOVPgmoD07jumQF8to4/rrPpavxKzAbO+mnKrL+A96HOjUCg0tWyE2TYYSuGZ319w
	gBSzX+F39CcVCdK5bAO5+qXKfUS+EDCBcHNo0SKrjpQ==
X-Gm-Gg: Acq92OEPCJvwn0lzwkZHXekjWUSn4HjAzrFQ+bpCt1HyxyvxLV3agLrPZP9h/LdfTYy
	0sheJ/NPV/teg8D7QxW4GRDM926aAbeYWfrUS6v9a4YuNdOJRmH/kgOG+3ZEHsaZLDZegn9ID8N
	Fe7jtCT7O40ZwDmxYDlm0Qcbkhvl4yhfbJh+JAPjQzF8M1jluGk6CzE6nmfBO6HUCtMXcOsjBQt
	9a6uw7mlt10QLOiJ1mbaPDs/r+7nXaIZbLLfuCPwquBN++tEbAB+FprsHanJe2YVgzQ7SffsLP2
	C/1/U95VFqDzJ5YNRb7edhWN7tjxCT5SA2FJoj+k3JJGXfxlwzVmgQIVWP+YyYHJVmmmi3+AamA
	Vg4Fd
X-Received: by 2002:a05:6102:3f42:b0:631:4e25:5e4d with SMTP id
 ada2fe7eead31-63a3d42a50amr1102601137.7.1778810624578; Thu, 14 May 2026
 19:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-7-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-7-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 19:03:33 -0700
X-Gm-Features: AVHnY4LOnPpQsVbeA7i_UaPfMdPsbeqJEuQMcWZQytIkz8kxArwswLAiNsr326o
Message-ID: <CAPpK+O2GEqqH_8+Gopvzbi=9eNz096yacj1sueOX3wYYye30Ug@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] nvme: Rapid Path Failure Recovery read
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_190346_190133_9F3B8C67 
X-CRM114-Status: UNSURE (   9.00  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 27, 2026 at 5:45=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> TP8028 Rapid path failure added new fileds to controller identify
> response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
> Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
> controller identify response. Expose CIU and CIRN as sysfs attributes
> so the values can be used directrly by user if needed.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Reviewed-by: Randy Jennings <randyj@purestorage.com>


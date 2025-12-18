Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4F3D6E2BD
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Dec 2025 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Km2T1I5YBUewLvu5wzssTsrcMP7r1tKGG8gU9jwLlQI=; b=JAX62nzAEa0NjcLAPJUEzLl9WE
	s1P8JogMgBbPaHWsEoUgOKBFwFp80S5lL5KT3KpFEf+6gRU10QJHogLBNcUZFqHZe498AoYu2eJjA
	yINt/JUuqR53yLT3fGOyjmgkxeAIN5kh3DR1JVQRqtWyhtea6tENVytaYCena+3MMgC4wJS6cEBmZ
	h813FrapimKaMTusagrdQNQSeSokhRHGqMwLXWXUzL2E3N2f+AdMqR+YmCLmYowt6IqH8mIy4e5Im
	lqdV4k96d4hBxVmcMwmKMEp6SPWMn71E2AvAjE03hYJSnmgdlZXcDCGOw429jdHZO9QLXfJYBvwrC
	LqP27pJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWHv0-00000008vol-0qjt;
	Thu, 18 Dec 2025 17:36:02 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWHux-00000008vo4-1gMr
	for linux-nvme@lists.infradead.org;
	Thu, 18 Dec 2025 17:36:00 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-88a367a1db0so14062446d6.3
        for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766079358; x=1766684158; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Km2T1I5YBUewLvu5wzssTsrcMP7r1tKGG8gU9jwLlQI=;
        b=VZAy66Md1iNTg4ah+frwCyYoH2LfdRvq5mOVI2lH2jOK74wmSl/6chHzBlYS8xP1nI
         ElhQJrTs2DaQwCFlxYh/KjxTHBR/+sTk5pLfjv3ArHY1qgK3/ed1St6Urk2uG+i8BCGx
         LOWxTtVM8VEQ9HWwwVeIeS5k1yIWlQJvGRl41czOQ+LOp0+VxWD5nkAPE5qZnVL5Ldqt
         d/UhvYTVS+irA0xJbupxiCP1eCCo1N3D6CBZDvn+cjd2dUNpT7q91Zm82fN+WeqdwBpR
         LiMuMMfMOBJYQ+Zhs6Ts9uJy3nb7pP+7wxGdJt4GonzkjrGAXV2LiKbjByFiC9qGha9c
         CraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766079358; x=1766684158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km2T1I5YBUewLvu5wzssTsrcMP7r1tKGG8gU9jwLlQI=;
        b=uBaP49XYHoKTZEeu+VVPen1ZVZUbyo3XmNc4wG3QaR621P0lwYem9oIgKSlirCS9Yk
         HQ3JtXFfan77GncPWTaY/cC9x9CEAgYsHBjlIAPkx7SdgbUXifm5zGb3S9H8ZWF+MpT6
         VjL5yh6J1clNg90l6rrzDADyXaw7xEK71qGHc0OHFD7OQjEPMegsEtp29Mu2UZbyV0jg
         hizCbh97oZEQgJANDDM7ucLjlLs9Q+mZQsC88UMjh0ycT02M+E1/TbVBInrLFao5rX/m
         opunmHNlNz+VHEjfJoULEdjWU66SEgCljktMthA1h8MOFB/BhCcWE7fYCbDQMp2odocc
         iNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfkVpyAGROhxXQxhGsm6H7hr5RXpAkwu7ysZw0rMC7+KqSnCMvMH56FSC46pThHc8d9ANfLek8jZnE@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9KSwDTQweKM9hQAwnYmA1nhi0ZNJew9jpwiGBlBEgSJteGflK
	GC/BJ+oiXBreOPAGPiz1XmYbiQU3tchplsDkgWVIuwpvWp9ABbG91OP6dsBEFHVG6BjSHP7fSVS
	I+iiMso2oFRvub9dVy1PeoIlJRpWiYRcZg75Kztc=
X-Gm-Gg: AY/fxX5eHeSds6iLKcaUKlNTRA3X4Zj+yN8sz4BiKddjdXJwcff0xnRAqcP91/1TSYJ
	kvKqvqUzqOU0GlSoGSKQtR3XhvhDVYfBVgK6BmKEoAjb4v4qh94IIIz2+SCHFs6B1inGf2Z1g9/
	2SjNSAmGIFF+0jX52ReFc2RxtTxboLU9uN93NSA7TEGFIAHQfQLV79lLb3tgocsq6bDvO77IPDN
	40LXgyz8QoD8/Y4DGbjOsTvNkCVao40+1GxRLjFoxc/7VzQNM99zFD1/cczDM5BvWMOExQU3vj7
	9EUoUYA=
X-Google-Smtp-Source: AGHT+IHWmp4l+iwvvk4UGfOw4WyIVuDTX+WygPNaY3MwlLjW0z28sFuGsm38Zc7fjoo+CRsLN7xb1TW05w1c4WM+paQ=
X-Received: by 2002:a05:6214:5789:b0:880:3e92:3d33 with SMTP id
 6a1803df08f44-88d8369e698mr6123316d6.34.1766079357608; Thu, 18 Dec 2025
 09:35:57 -0800 (PST)
MIME-Version: 1.0
References: <5b023828-b03d-4351-b6f0-e13d0df8c446@wdc.com>
In-Reply-To: <5b023828-b03d-4351-b6f0-e13d0df8c446@wdc.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 18 Dec 2025 09:34:45 -0800
X-Gm-Features: AQt7F2oCL92KL5RlafjzhPSPhxdJJT7DMmF2OqVJY7G1K2GtyDi2MGUAHicBT6Q
Message-ID: <CABPRKS-2zsAEjhsJX8aPjzud9LeOTCsF8WN=amSKpBzxxzJ-iQ@mail.gmail.com>
Subject: Re: blktests failures with v6.18 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_093559_442469_9DAFA092 
X-CRM114-Status: UNSURE (   7.20  )
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

Hi Shinichiro,

> List of failures
> ================
> #2: nvme/041 (fc transport)
>
>      The test case nvme/041 fails for fc transport. Refer to the report for the
>      v6.12 kernel [3]. Daniel posted the fix patch series [4].
>
>      [3] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4/
>      [4] https://lore.kernel.org/linux-nvme/20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org/

This has been fixed in 6.19
https://lore.kernel.org/linux-nvme/20251117184343.97605-1-justintee8345@gmail.com/

commit 13989207ee29 (tag: nvme-6.19-2025-12-04) nvme-fabrics: add
ENOKEY to no retry criteria for authentication failures

Regards,
Justin


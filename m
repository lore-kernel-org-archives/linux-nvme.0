Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3B2CEBF61
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Nov 2025 23:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yTdu7QeUcr1tMJdTKEsVn5RdrOfsTZIYJgZ82QIvZm4=; b=ClNSNwrCvGyORxBYHs4C/TX15s
	O9vLno+DK+DHbOUXhiKAUo3f53rsl/jxZT7l8TNHzDK9XakR1PMppsbn6z3HsN2lWQkN0LO+Wd25E
	MEfW7j0OZdsaOH9SwF4KF0T0AceeWkNBj9+xlGDq+BGLjItFMqLY8MCJR1bqlAocd25JIe05u8qHp
	/yMYj6FEQQXB6xGCDS0sksZTiRFqYYjrXjvXvHLMrG4AkRqdfYCAF40boKc8mWP+AEWloGkgTKyuT
	ICafmC8mTUITZC+LuispX0ogQvRHf3BeLFFxpbH5iJ1ltrNnPVa5nIgyAUVutKj0U67rHxg2XxKlu
	JNECgLwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKlyX-0000000FBfv-37uS;
	Sun, 16 Nov 2025 23:16:05 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKlyQ-0000000FBf3-2jFO
	for linux-nvme@lists.infradead.org;
	Sun, 16 Nov 2025 23:16:03 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so554946866b.3
        for <linux-nvme@lists.infradead.org>; Sun, 16 Nov 2025 15:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763334955; x=1763939755; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTdu7QeUcr1tMJdTKEsVn5RdrOfsTZIYJgZ82QIvZm4=;
        b=JoF3rqKDnBF1Us97mpHPY1TOTEscpMXs8Y6VA3o4thLfgs7N88k2fuTYW4enGeiJ7t
         2j6alb5dbI4Fbm8dYhqHlNmw4xpwcSn7a0uEb0wIOByjOlLd4e3Gg7G07Rbopokk8rse
         VQLs2HjDMAMfh/w7Swmj0IKyPeojW4pMaB3ncolvz7DnxJ8UcVwdeLObCMEUPB7Xwc8H
         MhQ/YZRGNnqVpnmW2iEV9mSbyKmigdVaX/dHVKn0THRUzGr3h0Zy/2zxCwwu5rNflw8c
         TQJ2mKpydi/249+2ryDcavVkMY+gtfotgn7O9NSMUJ5+Ghy9uVBRqAC0mhLmiBhlwa7X
         DOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763334955; x=1763939755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTdu7QeUcr1tMJdTKEsVn5RdrOfsTZIYJgZ82QIvZm4=;
        b=wfarYj/4HKNvb9iuMW1MGFhR05NAr994t3BEuVdgOL7sMQKKyE2ZJA/6fhK5ktr9D7
         XETnM2uV7+W0syi2hXONCN5Crkchx/zbkfIPW4O+Ec5YczBOFWvngvgeEx+OkoIysDzx
         LacVdexS7CTWY2hBq5aFdJxBYmJLH5GuwkpyaDrpEGPcx0JcTv+/J4Oz7AQSprEplQjj
         D4QYXuMEbM3Hz404O3+xS8Iy3d8ccrPQCDv72dl4G4P+15uA4YtpZf3pceSZNZaV/YEo
         kKzANslTWBQCdGq+0638ZacGlYav5o0NADF7ud6YMobd9p/nCMUranXkzY59ThKKNIsG
         uzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsisDUSJ2uDiwYpJHOv0+Q6OfWv+McdoeLI89pzJ3RbJD4RoWPxHirqtDoArmJMh1b/UdJ5V9LLEuc@lists.infradead.org
X-Gm-Message-State: AOJu0YzfXS16VDQZHnD9QDpV5L8/FWP6aIp8HCCoz9+bjQw0Jrk+dtV0
	W/KVvNRSEtTjr7/1ADs2097uydV+QujHEdjTEt0f/h6Ob9Df2w472myvEGzqgLDnHguzeocMiq5
	LX30eIVtt3H4M9mtk8siOYv8uvoltwCQ=
X-Gm-Gg: ASbGnctXid3bpSMoqkuYCyCOVhqKQX0VgYtqiqvkW8XtrkNGYpCNWJh1Jugn3peoI9q
	5J304HYDKSgwW9svrzrCfzvUVbQOnPUe9bqgeBFuFFJIf1tjcKUOpROJCWWlb1ZSDjcqIDUglMG
	AVKDxO9l9uO0t3bruD1gVg14M8UjiuIqN1Zx3IIRtXxBkh/+PBrQOW3iuljNTz5ZIg0VCM04aGa
	lmEdKt7mSIL16usA3GUycrj70/tEKoN6/Bv9bPDbehVDTmWgNtlQBpxNwBxAdsSwBj1SFwbJn2u
	M0Up0cX8u6aQLwXlceRl+Z3w0A==
X-Google-Smtp-Source: AGHT+IFmKMCiIz4y7KsoyjbpC47xJpQ4szQubbfI40eqStPKIzOW2tVhBhSTnBP3Muhhjj4L/9bhTAuYwqGWI5t9QpU=
X-Received: by 2002:a17:907:7fa9:b0:b73:5acd:465e with SMTP id
 a640c23a62f3a-b736789ce10mr922702666b.11.1763334955063; Sun, 16 Nov 2025
 15:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20251106231711.3189836-1-alistair.francis@wdc.com>
In-Reply-To: <20251106231711.3189836-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Nov 2025 09:15:28 +1000
X-Gm-Features: AWmQ_bmS7A-OCy8gUz-yrZR-bj7ILn37_uHf7sUKq9CYyNQ_txpAfQF0KbaQ5kk
Message-ID: <CAKmqyKOr+75TNSaQU-eUoEF2Aw_KxbMA-z4s_OkOgnsrbu=EeA@mail.gmail.com>
Subject: Re: [PATCH v3] nvmet-auth: update sc_c in target host hash calculation
To: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_151600_940895_FEEA45BD 
X-CRM114-Status: GOOD (  11.35  )
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

On Fri, Nov 7, 2025 at 9:17=E2=80=AFAM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> the sc_c variable to the dhchap queue context structure which is
> appropriately set during negotiate and then used in the host response.
>
> This breaks secure concat connections with a Linux target as the target
> code wasn't updated at the same time. This patch fixes this by adding a
> new sc_c variable to the host hash calculations.
>
> Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Gentle reminder that this is needed in 6.18

Alistair


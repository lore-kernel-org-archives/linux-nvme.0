Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC41CC3ABDD
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 07:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ifjz5GrfGnsIJd6UPXVj+WXIBaf2AkE/6Ipgjj2efgM=; b=gSmEAbe4t8K7NEeVtXVljhedwp
	swiKMQar5kN5cY33J+rkA/rHaMGbD9PN0zji4tRaYUoC/eTSGwlyjG+9UhWZ0kON8FTPnj6QPDH+U
	6DK6p/ELR41F2Jn36EmkAS+a/MDzzJeqL8M0L84TO6o1Xhk3/+0S/pN8g6Jlj8M7q1XiM4De4hWi6
	2M3pbW5OZG4iEbtfPoun4v2K6hx15zBZb5ZYmAkubhoa0B78qDHfKCYCmh5Q+FYDYqHTDNoUoWjrv
	DxiWzRMmVZXmuSOvXUWMWwvtAHOvrAYcuQrMQ1wHWokv25+gV/FzSkNZZMBmuJpfZux8pmdt17/wA
	KXrb3vxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF6Vb-0000000EJFs-3HyO;
	Wed, 14 May 2025 07:26:31 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF6KG-0000000EGhW-3Exd
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 07:14:50 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-30dfd9e7fa8so3141087a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 14 May 2025 00:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747206887; x=1747811687; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ifjz5GrfGnsIJd6UPXVj+WXIBaf2AkE/6Ipgjj2efgM=;
        b=ZuiLavqDhPA+/UG+Z+aZw+3V9s4nnvgywbH/KU2a4Wq3CCM+91PyF9VkggsWS1CW6Q
         Y2ZO8Ec2etwrT7I5k2HwAkB6J1+hDnCDk6IzLjXkZ9fM++Zmem1msOfB5lp7KjcQ3mmP
         +wBd7yPCEw+OzyIuLY2UpL2W/aikWVjMDgG8UnYJVbSk5Q+CQBWh8Uu1F6nkGK0x5Gzl
         O41BMpTNAAFPaxUbsJMEklyPA39L+A5KFHpSkN8gQScB7mTC1h0QEv5gaO0ats2v5lTS
         dvoPNYYeuzNZGKxIF7li7Iz0RfKfkO0GzmmwHCps9weSjz5+1c4EXOoyY5uLBMaxURlw
         eD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747206887; x=1747811687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ifjz5GrfGnsIJd6UPXVj+WXIBaf2AkE/6Ipgjj2efgM=;
        b=kj/244fylRaOhFiAFXvh0DiL6VL0al+3C1q9kdndwiwiBNHMCGjKF5uuJeWHKOb2N1
         zkfmMAhWRZsi834a2HnNYNpzbetAs/k9n5fwM6ReFXJnbr1SXs+BwG90PwP68xrEjQ+4
         mMDQjbAk03cw0fF4Cp0WvoHfhQU01n27VMgp9t0j/6dKdv9Z93Ynlsk5i8Y3sExbN1Wt
         07aVJ5rr5A83/l+9fgG3l4PqQsBak8J7/FU0AX7o4ygjGzNW2L5uGvdwYivRf6Q8QLKi
         zh06XpPpZWt0A9PuwVIqVBSMKWzUoPjJurP6O47CT2hb5jgC/swK+mHhdw0EyY3BF/tS
         aA8A==
X-Forwarded-Encrypted: i=1; AJvYcCWFeFgHGeod+X5iA23Uc6yIYjirGYkd1o/Ue2jgb6xjRwMxQ36DNECAp5oToh3QXVwht8a9TlLXlr7U@lists.infradead.org
X-Gm-Message-State: AOJu0Yysys3Obotl39qYSpRmmqgNazOTEXGr57vHkSdWqsna46aDDfTY
	2BO7fnvNO8MeayVI37jqPWZwWCCQxQS+44dxVeynZSXHXaQyaNPhanhhH/HCCcRSA4U1unWZaVe
	H3gZazeIcfX8RlfZeeGD18N0F2S0=
X-Gm-Gg: ASbGnctCkl6YGqhaRfH+xQDSHqR+I7cT1hMarPitjVA/v3B3Rb6SEgPnkJFJjYE2SEs
	VSafJ0gAWAwiMvqKJUVmGhig9Ps6gCXLCNrJ/0Mxi4w5T9lCp8cw9S9RNVp7TLuV6uiZUebNwbB
	+ls3Xl3gK7WLp1E4KJ/FsZSaZjM4sY2XG2+2I=
X-Google-Smtp-Source: AGHT+IHbxCATZM3WCqYmFO+OaM2v7VVUiLMbgTEeosU1KJCc3Dkfxu5HKL7CSk/AX6LPSu5VocV7mF0Hy//xy2+PjFU=
X-Received: by 2002:a17:90b:58c5:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-30e2e42c9d3mr5097691a91.0.1747206887380; Wed, 14 May 2025
 00:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250510102130.14710-1-amfernusus@gmail.com> <20250514053802.GA24939@lst.de>
In-Reply-To: <20250514053802.GA24939@lst.de>
From: Ilya Guterman <iliyagutermann@gmail.com>
Date: Wed, 14 May 2025 16:14:11 +0900
X-Gm-Features: AX0GCFs5X8zlzE4MagQ5ZIWTGUZQkvO8YqfbrIOXQ6gVGXtRZyvEcKJqaQY88co
Message-ID: <CAMraO6-rQsf8T_ocOKbe3yMP+91W=AF6WtRUYVPtNuq43H8qXA@mail.gmail.com>
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 025e:f1ac
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_001448_807327_5257D010 
X-CRM114-Status: GOOD (  11.72  )
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

I've only been able to test on my own host system, but I found similar
reports from others online.

Let me quote from the reddit conversation
https://www.reddit.com/r/buildapcsales/comments/1e4tgge/comment/ldha0ye/

> If it=E2=80=99s the same issues as the Solidigm P44 Pro, don=E2=80=99t re=
commend. Has a couple issues:
> 2. There also appears to be a NVME controller issue where it disconnects =
or something. Results in a full system crash and the drive unable to be fou=
nd upon reboot  attempts. Requires full power cycle. Unsure if this affects=
 the P41 Platinum
> > I experienced #2, it's something relating to the power saving state and=
 it being unable to wake up in time. The fix on Linux is to add the boot pa=
rameter nvme_core.default_ps_max_latency_us=3D0. There exists no fix for Wi=
ndows.

Here=E2=80=99s a report about the drive disconnecting randomly, although it=
=E2=80=99s
unclear whether it=E2=80=99s related to waking up from sleep.
https://community.solidigm.com/t5/solid-state-drives-nand/p44-pro-nvme-cont=
roller-is-down-will-reset/m-p/24348


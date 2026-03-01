Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1ADFD0060
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2026 11:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EoNhvs8U/ojW8ZJkNQTxI87TlxDPccTlNu+mF+xaKNE=; b=ETRIwT1aigi77E53CwLB6nF3nd
	j4lXODsQ8EJmvlvf183Op31gj1/ik1u/Cv6t5RXZgJj2gynunC2N9OeDlRry9QNAPP4LKdsgmt0QO
	ZF696yE8PUJ6gPcK2Kr67TyQbzgswIsffAVNA5cQgML0XZjMtZg9b45IuKH6RalrclnU9L8aZ7bnA
	WpI6lNHT9dq7WALpr1Ir9tUIE4eFq0tyIpIRVwu/ZREgKcKZObcXuTF56lyGz3cOS0eZbB1hy9vff
	FvkQRhsBgx3Qp3SCO+mw1tvss2t+X+Ol+McXh0jshZ0Y3vf637TN77VjvkAbDIloY1zQcQcCX7Qzl
	ecpqelbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwf9F-0000000B4M8-1STe;
	Sun, 01 Mar 2026 11:39:45 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwf9C-0000000B4Lp-26DN
	for linux-nvme@lists.infradead.org;
	Sun, 01 Mar 2026 11:39:43 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-50697d6a69cso17983871cf.2
        for <linux-nvme@lists.infradead.org>; Sun, 01 Mar 2026 03:39:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772365181; cv=none;
        d=google.com; s=arc-20240605;
        b=Z5QnVfRUTOe6LE73exd94xYUkbKonYuKUthi+oUUIlwAHbMwm1r9MQsOhKrRWWyZtu
         13yfS6aYJ5arXAiRn0I0LhmoURqTHMu7kHEdcVlYVJG2Xt1oXoY0co3M69279umA0TcN
         oLpElworCBWeR8awaGTBWo4656dk/+KhTRVnrIAtUr7DF121/mjug3SRHE8OExEoyiCL
         H7HBwjdZvrpIFXkJYqXAsC9jZ6aH/M6JmqCm+2gEo0oPn8bFnGNfD8pRw4b4cY93Ehxq
         87byfhsNUFc8xV7fkx2Kn+QbiBZDvLz7zxA/52KA/nQ1uesIEdKrVQVmuGpH56+lJpXR
         xP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=EoNhvs8U/ojW8ZJkNQTxI87TlxDPccTlNu+mF+xaKNE=;
        fh=3Ig9Knn7w+fy/GlpSy3AuLjcp+9rTqrKTwDpEUJi8iU=;
        b=gJ1kyIgTFXzwajplBIMoKa21rxNqOKLpAdIqmMKeYqkZfw5g5p84SrRVah2667ZfyQ
         +qGKWWVzAxMKZqsFFcCdOZZ8sjsMhbfhVKbLktQPVttBgL4MX6hcrXFEWlZqQh47kGZt
         9HfkUxiOW9BJZEQyEj6ULlc83dmufETOmBEZtWiV7FvhMl5cwTHQ3sMEYDz7U87YRLNT
         OYgASqj5yrQLid4rAt7IAKzlWxN+ShgWdJmCVEz/eHgginMkWDVysqYO+U+mtGkYsd6Q
         tzHHescOfaRUD4R6afsLnaFSiiti+qbiMcMbhRXPCMPkirT5JsjcSP4vy5+2aQ7JUeFG
         OCKw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1772365181; x=1772969981; darn=lists.infradead.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EoNhvs8U/ojW8ZJkNQTxI87TlxDPccTlNu+mF+xaKNE=;
        b=ews5D8d+canANDgSW73A3Q9syQj6HCmx41ywNW8fzC+k4sphKqBnlQ44YsHfCOD0ih
         DFy8nZEat6M8HAXHr21JL3qwVdbJSTRuP+533x3j8QVOQ1BMzJUszna5vUANZ7wDydmp
         akU4JcAEvHssHBKkcyJ6zIytptFmbdDanTwlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772365181; x=1772969981;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoNhvs8U/ojW8ZJkNQTxI87TlxDPccTlNu+mF+xaKNE=;
        b=uHs4+lXFMqS3RMUdxFDbRqlrljN9cG8kuJswbzB7LagGgUCqMJZ4n9t7or/2NV6sCo
         hh3L25ZkTPR5Tmcn4I21UFzIDfAHpGi4gDZHwqjDPVzo4fAYrsY6jtHm+bOtOWu0ReZR
         VSb1rYwRSzQnhdRpHJdLJbS93r/yJODFIOHQME35rwVY6axjEP0LBvHVBbt+UvPa2UCW
         QS0pr3H/6E0gRM+hAr4BIVmfaR1ZVLelSf09mW9iIGJ72v460mz3jC/eWTtAJFlGyVPg
         WY6Sc4Xv9r2KzTwcs4+pFAmFVS9+OTX8dBtkBDf5U07Dx/i98z+fUSNztyY6fhE69Sjg
         XuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWXTdk8YErZSWjhrMAyttdmFRCgtAPyTZsOBPhcTBJvMDTem77iLlYyCYDfIL5wTX4EIsfpwNP5nGu@lists.infradead.org
X-Gm-Message-State: AOJu0YwL0el7Is6bbggmDI2R9SozlIHE1o0PEl2PW9VrWsKSJ+90bPZo
	i6KJFBl+WxBceWxWc3hDOSiyW/aMszWTWZGKfMxFbK4ehttelviiHBHLpiTxhx/eh1kdhsXjomC
	DQ6DAYSk3Te5aHaQX6U0x/RsI9RpEQUqeU9x0Nntg1w==
X-Gm-Gg: ATEYQzy88Dy+mWkCqAOzDS3xcO6h1gvTv3RLiE6/CJptYH3+dzGC7XxZELGOfRvnP/q
	9vRpVV0h4tBTl7C06Tl+gE8zjTHcDOaBSPKGj2E9SJ9blL/BB4B6xDmsAamTqd+CBGl+/TjrGEz
	OPNyxw7qGiBpwgu8kiZBP/vdNWvo4LbWcSUd1vII2bwUyGVpqg6PCpInzW+Y0fhnsyZypzT69T0
	6+5CnScQOiFmJacJu8gHq2unEnULsyjpdXJ5HF22b4gAVu5MrMpY4lkkhTTPdcgTJVFuBeZzjAJ
	EQgxKuOs1Xd2VsAT3aMr2oG8i8gchHYX+VY7LZBWBf6/thaBol6z2sMbrJGQiV2GjQhEhc/jjtT
	yRM/7K7IgfQ==
X-Received: by 2002:ac8:5806:0:b0:501:13ce:4e0a with SMTP id
 d75a77b69052e-50752840802mr114996361cf.10.1772365181076; Sun, 01 Mar 2026
 03:39:41 -0800 (PST)
MIME-Version: 1.0
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Sun, 1 Mar 2026 01:39:29 -1000
X-Gm-Features: AaiRm51MwT5pQCYhssaqR0QnLqOv4NsckjM8W0_zZRRcQsA3A0fjKitkD8mG5ew
Message-ID: <CAO9zADxDnb5OVVVZWj64ac70SACH=-G5TC+2F+vfuDmLbZECQA@mail.gmail.com>
Subject: 4 TiB WD SN700 drives drop off of Sonnet Card
To: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_033942_571327_5E959B2A 
X-CRM114-Status: UNSURE (   7.18  )
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

Hello,

Kernel: 6.12.73
Distribution: Debian Stable Trixie

There are long outstanding issues with these WD Red SN700 4TiB drives
with an ASUS FlahsStor Gen1.

I have 16 drives on two x8 Sonnet boards and the same issue is
occurring across two different platforms.  Are these drives completely
defective when used in a software raid configuration?

Does anyone have a specific kernel parameter to make these drives work
without dropping off the bus=E2=80=94 or is it time to retire/replace these
drives?  On various forums the below parameters had been tested
previously and did not help.

[Sun Mar 1 00:30:58 2026] nvme nvme0: controller is down; will reset:
CSTS=3D0xffffffff, PCI_STATUS=3D0xffff
[Sun Mar 1 00:30:58 2026] nvme nvme0: Does your device have a faulty
power saving mode enabled?
[Sun Mar 1 00:30:58 2026] nvme nvme0: Try
"nvme_core.default_ps_max_latency_us=3D0 pcie_aspm=3Doff pcie_port_pm=3Doff=
"
and report a bug
[Sun Mar 1 00:31:03 2026] nvme 0000:03:00.0: Unable to change power
state from D3cold to D0, device inaccessible
[Sun Mar 1 00:31:03 2026] nvme nvme0: Disabling device after reset failure:=
 -19
[Sun Mar 1 00:31:03 2026] md/raid:md0: Disk failure on nvme0n1p1,
disabling device.

Justin


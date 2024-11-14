Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101EED68B26
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MAvre8wflvGFv4t6W/7XPF9jC0eZIV1+2ZaBm053M0Q=; b=ZazjArZa4vn2C/JeBtVt2JzBoO
	zu23SCJVyBG5fy4IiK8jijOh1vY9VkNpthFUJV871J81faljJB5Yi9J7eJIg8Km3ORnXw9QXlQ4p7
	cyPsrV58dbiwyJ0+Rxdp/YBItr8maes1SN7zWWiEL31MhNyOHkomkL+Dpj8FvfoAW4fGRFeYsApbu
	G1HTwGWkOTPPrLgJsmRmFOYCjocgYVGBoa/Oh6PkRI5yf79swl6wsBFxx+XBwA1/Nk6Lg79zXmwTm
	cxABtM1KW6rYJOzSzVRHArnVXw80X1SXnbu8yY666WsqGDPGPydpO2RPMdAo8RvnVrbSZUO7xkycA
	Bk5TrHZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBajP-0000000ABfx-2zu5;
	Thu, 14 Nov 2024 14:21:59 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBabm-0000000AALG-1Sx1
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 14:14:07 +0000
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-83e5ae95815so22933039f.2
        for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 06:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731593644; x=1732198444; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAvre8wflvGFv4t6W/7XPF9jC0eZIV1+2ZaBm053M0Q=;
        b=qKuYUyvNERqdZYta6PlsakXgV0f0xWr8MuYm/M4e9kLgHP6ZBqcmmNg6pq4AaJcGdy
         vfX640afsRBHwn6BRmqtV35k+Bvk36YqonO7wx4BA2p053bFKR4hu1MLZc1SKDjzAlfa
         8mPcz67ezizY6BuzYXvoQ3GNfD8EsIooKyT2DDVLTart+cGf3d7iKbQsYcsaYDgFM92i
         HGDK5b4RQvRBRScFadzBnSTbC9bXksUYF5sWcwxeFXuGQxSoY70j2DUhurS6/CM6AFR3
         kTXORcE0Him0JdiyjN+P0ox+Nubp0CjnoP3Wf9vszEki6HKJYYGgHmlJ2OH6j6fqzYE7
         HISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731593644; x=1732198444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAvre8wflvGFv4t6W/7XPF9jC0eZIV1+2ZaBm053M0Q=;
        b=OO0+I/Q/7g1ZIKUJNcF8p92k917ZJMDBcUpZk7Yi/D35baAwDnKyvhAakih2ZbNu1p
         uP4AHUVoXk0vvWSObIio6Rxw2V9516q12k+H4/e9Z50Xe5pzao5b7JcbKQADcyVPEDhY
         YbM/e5Viq+lvEjiMrcMVa7VlvVCPUofSDs87XdMk6hGjy1J9GkLGDI/6dnrHOp60zuZu
         ew9i+cKS9FelHU1NOP9m8Icb02ZYEAqVegJqH3pytBx8DP7xNZHCtaCSHG6OFRIuBZ5F
         +ZA7ZBlXjaAV47eLliZw9FvBQmzrFWLxCCUrauGkFKOqQR0mDrQAKF8hMmQA99O+O/YF
         apcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5ogwikS18Tm5rO0VmiIeVMZTzDGVDX++EsE0RvzmseRawkm0QnfkkuhoMggYZ9x+NBP7BH+U/qQT@lists.infradead.org
X-Gm-Message-State: AOJu0YwwBNiVQjhHWKTugd+K/cTk86EwVBwEEFFefh3PSpnQ9OvKy/iO
	nHPG+y+v7IYSE18LNW7ekm4w+bQatMJ4C5/P6xsJPItv5CufzQE0+9IVQ02f2AE5TUpW5IGTN6n
	S4qyHbvoLUCN4DMHtiNQYIqn90llvAjC+wF8N
X-Google-Smtp-Source: AGHT+IF0O/N9QpWE+CuK8f7Y9RC8pylKpuXYuJyNPX6KXWbRNIdMzwXXofYiavpCsbDSHWWB6PWtZqFGfOB04vcJU08=
X-Received: by 2002:a05:6602:2d8a:b0:83a:95fc:b242 with SMTP id
 ca18e2360f4ac-83e4faa2688mr783656539f.7.1731593643838; Thu, 14 Nov 2024
 06:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com> <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
In-Reply-To: <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Thu, 14 Nov 2024 15:13:52 +0100
Message-ID: <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
To: Robert Beckett <bob.beckett@collabora.com>
Cc: axboe <axboe@kernel.dk>, hch <hch@lst.de>, kbusch <kbusch@kernel.org>, 
	kernel <kernel@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, sagi <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_061406_450360_49795CAA 
X-CRM114-Status: GOOD (  16.37  )
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

On Thu, Nov 14, 2024 at 2:24=E2=80=AFPM Robert Beckett
<bob.beckett@collabora.com> wrote:
> This is interesting.
> I had the same idea previously. I initially just changed the hard coded 2=
56 / 8 to use 31 instead, which should have ensured the last entry of each =
segment never gets used.
> When I tested that, it not longer failed, which was a good sign. So then =
I modified it to only do that on the last 256 byte segment of a page, but t=
hen is started failing again.

Could you elaborate the "only do that on the last 256 byte segment of
a page" part? How did you check which chunk of the page would be
allocated before choosing the dma pool?

> I never saw any bus error during my testing, just wrong data read, which =
then fails image verification. I was expecting iommu error logs if it was t=
rying to access a chain in to nowhere if it always interpreted last entry i=
n page as a link. I never saw any iommu errors.

Maybe I misspoke, the "bus error" part was just my speculation, I
didn't look at the IOMMU logs or anything like that.

> I'd be glad to if you could share your testing method.

I dumped all the nvme transfers before the crash happened (using
tracefs), and I saw a read of size 264 =3D 8 + 256, which led me to the
chaining theory. To test this claim, I wrote a simple pci device
driver which creates one IO queue and submits a read command where the
PRP list is set up in a way that tests if the controller treats it as
a chained list or not. I ran it, and it indeed treated the last PRP
entry as a chained pointer.

It is possible that this is not the only thing that's wrong. Could you
share your patch that checks your "only do that on the last 256 byte
segment of a page" idea?


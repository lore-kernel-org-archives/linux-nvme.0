Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24888D0E6F1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KaxA4URZMnkQPOL5VrfQqCvsZMWSgJ6OMNVogesAF0M=; b=jnQz+xI+ikifBi3/BEI01lCVDo
	cWf0CMZpLJbciQiI7P9LlmH7eH9s4sk5wva1TRU1gDyfrJuAogbDtFs7CUBL3qIhhzLZwofcVUft7
	dPoHb8t84Y0LFuqG7QGPax0DdanD0rim6HnYZOuzhi9ZrmZ+gU/odWXYpF0AJK1WcofTZ3RU8pPu/
	VupZ4OQxEcdXvrT1P0TgDK0Tew5YT5KZqJsbw9/g5+EoTxOM2LWa3NIkE1P8tcgEfCT7vym7QYek/
	zCz6qnVUNvNsg/4deEvjhyW3r7TNezG4imLtUgeYp4PI64+yxNuRnNczxdVXAi6qTfE3mtsixYlul
	xaTWEfUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNuFS-0000000DS8m-1RjX;
	Tue, 25 Nov 2025 14:42:30 +0000
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNuFP-0000000DS7j-0DXn
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 14:42:28 +0000
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-7c6e9538945so3306319a34.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1764081745; x=1764686545; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KaxA4URZMnkQPOL5VrfQqCvsZMWSgJ6OMNVogesAF0M=;
        b=eho7wmR19sUlL8b8yT4tps2KHuqolp10QCW1ZBupm9mEgjotaDipesL7SldEUhscE3
         eps+AyMj4fmkmQWZM6HEkFFAI16lvD27vtHLXgcWEIe36aQi28RCWPv7Xfi6SYT+EgMg
         R/eFU937jFHYLOKwohh8+gk2a+St3e8WLOwUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764081745; x=1764686545;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaxA4URZMnkQPOL5VrfQqCvsZMWSgJ6OMNVogesAF0M=;
        b=cIlyldGpC+N9RcgNKO8s3p4ewPQDZmL/EIw2ZAW61eKhe4tlGOavLfRpzE2DaPqOgQ
         ujyPkJUu3QTlIWfHvB6r7U4QPJHV1X3oAgBZs6XvW1wstWiabE11THrn8/c096pGKbtt
         m0lkNOjhmhv07nf/gurCyUaXNwHPwUMSwQfNirQhsbyJB6BeA6yBav9BOSckAoeuI4BD
         g+i7dY+Wuqr+yDDJekGgJJiAKD5NeL2Vx71Z6+3yAX9WcPsPyZWONeA55+pfEWk7fT+U
         YOatWeVGpdiZGBeF4iE3h5iOmSx0kj/Gr8Dv5HDqqXKs2eqAhQpde0YInkPR6UqiXDBc
         jxSA==
X-Forwarded-Encrypted: i=1; AJvYcCVaEHm6wtZyyOp3dzWSH8S5ctGvgHBvMXgAHupRqnEcxdOWNXnk/ubE4TlQGqOBtkEkisKVCzFzlTSW@lists.infradead.org
X-Gm-Message-State: AOJu0YzoTn/72+iJu40BUKjQDH305H0YtTyG15q2xTT3FLxu9MJLU9qN
	rQOcjzUlQnM7/gZ77X4rE3Iznd9rqbi69OXeXlHg4w01fU3UNu86B4yYygvlB8XMTs5T/LqOA2V
	6uRGNAf9KmhiC71enpTJ6ljAFGjCMSqyPmWLHU9jGmQ==
X-Gm-Gg: ASbGnctHWOE9oVg5M3aSek8D2JImQw1sB740jWigKoeB37dp+i7A24BhfUT5NHdD5Wt
	0aCsC7Ox0H9pocYmwcZ19zqyx97rKVMqjzpH//28TfYN0illIOtlVyXdMZjf12K22d4IoEqjhWs
	0GnE73wLzZD+uVVB/Odd8WTFHFKmRQqB+TtVkeRLqM0HlnirXE7XSQQ/Vk6SFOPvQanh+3bTzVE
	KZbIGmDlLiMazmTolo/0kzrY8rdUgtVq8L8NUWsTomt9Y3Mi/5GyVATHMqT3CFThRu2UC36CYFt
	dVqVmvkG9PYN2YXZpsrwv5I1eHIlmyShoSvYspOCxR0qYWTAoeE8m5Ur3eN9IcA=
X-Google-Smtp-Source: AGHT+IF6nb0XFEY4hvcPmD684X1LLVnE8WIkq4uAC1EOIPxVrPDPf3pSobV7ttGqY8U/2wHv22LJA0oZ+NuEWodb+x4=
X-Received: by 2002:a05:6830:252:b0:7c7:1a6:6a09 with SMTP id
 46e09a7af769-7c798bf2716mr5653494a34.17.1764081745530; Tue, 25 Nov 2025
 06:42:25 -0800 (PST)
MIME-Version: 1.0
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Tue, 25 Nov 2025 09:42:11 -0500
X-Gm-Features: AWmQ_bk5BLfGjtbuPG45HuYMv-wNYW6cT8NjghdCxB7iHGsDTxTzucuMonB00cg
Message-ID: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
Subject: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting reset, CSTS=0x1)
To: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_064227_109235_AA22A66A 
X-CRM114-Status: GOOD (  12.98  )
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

Issue/Summary:
1. Usually once a month, a random WD Red SN700 4TB NVME drive will
drop out of a NAS array, after power cycling the device, it rebuilds
successfully.

Details:
0. I use an NVME NAS (FS6712X) with WD Red SN700 4TB drives (WDS400T1R0C):
1. Ever since I installed the drives, there will be a random drive
that drops offline every month or so, almost always when the system is
idle.
2. I have troubleshot this with Asustor and WD/SanDisk.
3. Asustor noted that they did have other users with the same
configuration running into this problem.
4. When troubleshooting with WD/SanDisk's it was noted my main option
is to replace the drive, even though the issue occurs across nearly
all of the drives.
5. The drives are up to date currently according to the WD Dashboard
(when removing them and checking them on another system).
6. As for the device/filesystem, the FS6712X's configuration is
MD-RAID6 device with BTRFS on-top of it.
7. The "workaround" is to power cycle the FS6712X and when it boots up
the MD-RAID6 re-syncs back to a healthy state.

I am using the latest Asus ADM/OS which uses the 6.6.x kernel:
1. Linux FS6712X-EB92 6.6.x #1 SMP PREEMPT_DYNAMIC Tue Nov  4 00:53:39
CST 2025 x86_64 GNU/Linux

Questions:
1. Have others experienced this failure scenario?
2. Are there identified workarounds for this issue outside of power
cycling the device when this happens?
3. Are there any debug options that can be enabled that could help to
pinpoint the root cause?
4. Within the BIOS settings, which starts 2:18 below there are some
advanced settings that are shown, could there be a power saving
feature or other setting that can be modified to address this issue?
4a. https://www.youtube.com/watch?v=YytWFtgqVy0

[1] The last failures have been at random times on the following days:
1. August 27, 2025
2. September 19th, 2025
3. September 29th, 2025
4. October 28th, 2025
5. November 24, 2025

Chipset being used:
1. ASMedia Technology Inc.:ASM2806 4-Port PCIe x2 Gen3 Packet Switch

Details:

1. August 27, 2025
[1156824.598513] nvme nvme2: I/O 5 QID 0 timeout, reset controller
[1156896.035355] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
[1156906.057936] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
[1158185.737571] md/raid:md1: Disk failure on nvme2n1p4, disabling device.
[1158185.744188] md/raid:md1: Operation continuing on 11 devices.

2. September 19th, 2025
[2001664.727044] nvme nvme9: I/O 26 QID 0 timeout, reset controller
[2001736.159123] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[2001746.180813] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[2002368.631788] md/raid:md1: Disk failure on nvme9n1p4, disabling device.
[2002368.638414] md/raid:md1: Operation continuing on 11 devices.
[2003213.517965] md/raid1:md0: Disk failure on nvme9n1p2, disabling device.
[2003213.517965] md/raid1:md0: Operation continuing on 11 devices.

3.  September 29th, 2025
[858305.408049] nvme nvme3: I/O 8 QID 0 timeout, reset controller
[858376.843140] nvme nvme3: Device not ready; aborting reset, CSTS=0x1
[858386.865240] nvme nvme3: Device not ready; aborting reset, CSTS=0x1
[858386.883053] md/raid:md1: Disk failure on nvme3n1p4, disabling device.
[858386.889586] md/raid:md1: Operation continuing on 11 devices.

4. October 28th, 2025
[502963.821407] nvme nvme4: I/O 0 QID 0 timeout, reset controller
[503035.257391] nvme nvme4: Device not ready; aborting reset, CSTS=0x1
[503045.282923] nvme nvme4: Device not ready; aborting reset, CSTS=0x1
[503142.226962] md/raid:md1: Disk failure on nvme4n1p4, disabling device.
[503142.233496] md/raid:md1: Operation continuing on 11 devices.

5. November 24th, 2025
[1658454.034633] nvme nvme2: I/O 24 QID 0 timeout, reset controller
[1658525.470287] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
[1658535.491803] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
[1658535.517638] md/raid1:md0: Disk failure on nvme2n1p2, disabling device.
[1658535.517638] md/raid1:md0: Operation continuing on 11 devices.
[1659258.368386] md/raid:md1: Disk failure on nvme2n1p4, disabling device.
[1659258.375012] md/raid:md1: Operation continuing on 11 devices.


Justin


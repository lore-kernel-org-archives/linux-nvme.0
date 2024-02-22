Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA9BC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 01:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3tTh4xEl98wO/N0x+Ct1uGh1FMyzpq8Zp0f0A0JNJYk=; b=XAiWMAZaTXwx46HozERQOKqlwp
	u/m7FDs3H808xw+2nCwZGTYmAngGxBz0MkzwpQKTycWglHqihSryToDk6g07j1do4tXUc5bhRi288
	KwGFFVeOMlB93fhPQy0RVieL6RFee5g9FykG6h0agjVbZAe9atftqO0y/Z3EjmwRgzaPGPnJaNgaT
	hb7AaHXEF6zZ2FYayWmoB58efj0rB/rouwAq+3FZIPs8whKw0VlCmTvaSteVHylq0kFuXepn8WH4Y
	R2qNviP9L+rbNMl2me6t+BC2yE6glv/YYHhyxHon5Y2FWJW0GIvftkZZ6tmvck/iR1r8RNKxLPj34
	9kOaWj+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcy2W-00000003Aws-2Lfz;
	Thu, 22 Feb 2024 01:38:20 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcy2T-00000003AwW-1SdA
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 01:38:19 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2d25a7b02d6so13128821fa.2
        for <linux-nvme@lists.infradead.org>; Wed, 21 Feb 2024 17:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708565895; x=1709170695; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3tTh4xEl98wO/N0x+Ct1uGh1FMyzpq8Zp0f0A0JNJYk=;
        b=UaPsSjEmE5IEBRKuH9Ch/hvQ1z/XZjHGu5wYrEO4fZj+s45oatW3DavFwVYL5BMF06
         SbaKsJNElRsrkMfd2iTWBsKVzZmIxqV1m8dIZRdSfKDy9awDwQ0MPtE5ssHryQPcEmL0
         q13IrmWpZfbnHRHebTO5NKrTS0QT5p+EZmceTxOHA2kT/URyk8E3QJ5hnVUEMDKnTF/C
         +dLASGyQi2EX39M5tq5NIugUOGC678Zi8AOvJYEfhfLpek26UVfLFh7MbBc0n+XT5TcX
         vZhuCcWBm3kJhnbDrBHezVtNG6rJaL/VLi2K2M9b9Oo4sUaivFado5JUWQSPCuITPoxk
         Ie0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708565895; x=1709170695;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tTh4xEl98wO/N0x+Ct1uGh1FMyzpq8Zp0f0A0JNJYk=;
        b=C0EkcyYaCy8GsiB8rQZtp7J9LZ4sSkIGGycVDP29frfhiYLXnsXu4fdGjxzzDUnYp8
         xjhBcVAMEvdO09FSx9ZHSWCaiXn2jerz2U+w3BsoGugypjYpNoK8lNhcK66iLYvIklEW
         ASjvtwc7L36YnsIvEqc0SExUgGsD19MVVDiUqNTZ79h+OViSYj4Y76vi3U0sob2/uwft
         oOWmMHLBUH1PV0i5YLG6KEjZfSxbbh9uMS9qGUfKs0bdiKDVoYLOaSIEQ2pUZIIckP6A
         3i5ENz6bnTv09jOHXv0YnrwW+6M3NDD5fXRfNckbxHe0Umzd+xwyCV8VCrFJ6CFgsw0e
         bJiw==
X-Gm-Message-State: AOJu0Yw9+qKuZsidXCpgUwcDy8CVRfdJjOwz9IKOTWPetvzJiG3AU7Gk
	BcYK2ezLM9t4JQaZYC1m1vJus86nfOcxMUvNkZ9OcNZw9vjLRMyo7dXsV2kkKNrvHpsNfBavYEI
	/fS7fVxEifBtv9dMRVUOZe3hFQPl9rZasqtY=
X-Google-Smtp-Source: AGHT+IGTpEsbmpj2GGN3EQ7zd7NFA81oz1TUDZGiMRhzjNvwsS7yOYkXVr52mUSGImWKH7ckpDfNOEAZXpznqzi5YCA=
X-Received: by 2002:a05:6512:2152:b0:512:d6c3:9a72 with SMTP id
 s18-20020a056512215200b00512d6c39a72mr1503345lfr.52.1708565894517; Wed, 21
 Feb 2024 17:38:14 -0800 (PST)
MIME-Version: 1.0
From: Jaehoon Shim <jmattshim@gmail.com>
Date: Thu, 22 Feb 2024 10:38:03 +0900
Message-ID: <CABj8AyhLjBkQUhp4CFY+xV4_GwDAyzU251St+BMoYUKCjj7M9Q@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Adding NVMeVirt to Kernel mainline
To: lsf-pc@lists.linux-foundation.org
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_173817_407877_C364F563 
X-CRM114-Status: UNSURE (   8.26  )
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

Hi all,

My research group has recently introduced NVMeVirt, a software-defined
virtual NVMe device implemented as a Linux kernel module. Upon
loading, NVMeVirt emulates an NVMe device that is recognized by the
host as a native PCIe device.
- https://github.com/snu-csl/nvmevirt
- https://www.usenix.org/system/files/fast23-kim.pdf

Advantages of NVMeVirt are:
- Deployable in real environments (not virtual)
- PCI peer-to-peer DMA support
- Low-latency device support
- Multiple namespace support (each namespace can support different command sets)
- Multiple device support
- Various command set support (currently supporting ZNS and KV)
- Accurate performance emulation

What if we can simplify NVMeVirt and add it to the Kernel mainline
just like the scsi_debug in the SCSI driver? This would offer an
accessible tool for developers, especially when NVMe devices with
specific spec are unavailable, to develop and debug the NVMe driver
functionalities.

Best regards,
Jaehoon


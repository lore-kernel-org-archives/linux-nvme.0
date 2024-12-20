Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1B9E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 12:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d34YpD18XPJbPPq+gzX4Ba4pRSVyQOB2rh5MKz2PYrM=; b=K1jr0jOhGmqgB+eaVCUnIdy8nD
	Q1rMGjVqxl84Uzj1jbPqcCrY/VYWf/ikAcMNCZ/1hCP7H66CbBqg+1wkb9GsIq4hce1s2A1YFpsMD
	lRdKt5NKZsMfe6Ca4YxO8l+1WwP5/5GuSj7LGdsNummqnjYFI+qASmaeXQK04Zyhl5/nxDDGQ9FOr
	rZQzcTOIVJguUa2XQJ9yQnx44P5GrJCIdv9foOXJOS+qHd3EPXjzp43/VP05BVzOyZCkedVDnAyJC
	Ftd1n6p3oQSsScbFb7jgx9d33BUvUdd+dCKxzr1Wtz2AhAusw+b/e07Q76B1QWytz8JcoJPgsEq8R
	16NylEpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOc5z-00000004t5k-0a3x;
	Fri, 20 Dec 2024 12:27:07 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOc5w-00000004t5F-3Vlc
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 12:27:05 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-72739105e02so1972068b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 04:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734697624; x=1735302424; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d34YpD18XPJbPPq+gzX4Ba4pRSVyQOB2rh5MKz2PYrM=;
        b=JnHO9nTFO1MWVl903iN+MCi/PuZZqFVGZ+8NBiJaHAY6IbZGipALgV9HA+8xiWyROG
         i6N/64vSwHpeXvJ8xg8E3Y/gx+Caar8UyW4nY6gU4ghqcOy+retWkJh2BfBzfjqC8EtM
         57QWjOpPGyyixx1t/t8g234+mi4qq2BNbKYHIznX8sWbmXnijJboZMoO6voRonQoMwJy
         xWvclKTJ5vWC5nNaNPYm5D+HiFFlksdXCMsTiwihlXeZExXY1j37GAIWpGD+JbklSt2/
         jOR0vWVTw5vNv76BUyearnn3gXdx3YVIbdknB/N+ZaYKSzVU/Y13bklxPc1f2Rs1QZ73
         /sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697624; x=1735302424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d34YpD18XPJbPPq+gzX4Ba4pRSVyQOB2rh5MKz2PYrM=;
        b=hgJmFbqr4GIOyqD1pzQGjUlnZGjdoeVDeac7EsWAD06RExetDKWe58ieV4ES3XE57S
         rC9hyEBjdaI205hAQP2eEFQvfWrM5M5GizN1c3POlU1lcd9vZnqwylXS39WZ7MNWxa5p
         l9X4cHB8/83hzfY8fS+8RPC/Tea17x9G6QygJOPI24Ze83AcE/4H8oCNCUtsCDYjjPaE
         gvE1ftdG2F9raAatv+GLt91no81RSbE/z552J5WkDi2pm36aIaxsLsW6RznuZlYQRWPy
         FZLhgr4xdlCxtRvGRqxJ7HBeZONxVSUvi/LFkztklEvvQlrTy40ArlS+9+4SoSadxGXb
         Qfkg==
X-Gm-Message-State: AOJu0YyzYSKnb1E7di96YEc3ViPSZbX941T7+bdAw6yGLO99qs0DhVQC
	ZWWrXADebdBCKz4RjfcyijKtbCuZn6IQYo1z2YWRO3bqWDd1CtoNpF93tfamnA==
X-Gm-Gg: ASbGncvX2XCONQvRmVa9mCGAiMoiycmIcJhNHtt/AQ83a8oSgqhRoD+LkV/CW8RQrgp
	j6AB+CZlGaqLeKT2IxpVZH9h6klE8FbJF9pMhfqV9Ofangedy9Jj4G0KUQyTTR36YlDcE1c63BD
	vVT2PvTfY41fuwgU6shuYm9s7UFYQRFtZb6YfsstRaLMZgaV5giJt/8FVh97kLa4mydUNGkIJ36
	0W+cGa4AV5dihKZAUA8M3nOKxVq0NY2cmVGFvpmxiYv36IR23c+NXRvNwI66Y/iguq2RQ==
X-Google-Smtp-Source: AGHT+IFrG9eb4Q5oiwTAQ33mdTfGdeqS6zs2mHn0GS/AJHJxe5SNvbyKKhrl2al1o1wJ0gQ5KPwUgQ==
X-Received: by 2002:a05:6a20:158c:b0:1e0:d6ef:521a with SMTP id adf61e73a8af0-1e5e043f6c0mr4790958637.1.1734697623521;
        Fri, 20 Dec 2024 04:27:03 -0800 (PST)
Received: from thinkpad ([117.213.102.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8164c7sm2981317b3a.4.2024.12.20.04.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:27:03 -0800 (PST)
Date: Fri, 20 Dec 2024 17:56:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v7 00/18] NVMe PCI endpoint target driver
Message-ID: <20241220122656.mb7bs47pfw2xbadr@thinkpad>
References: <20241220095108.601914-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_042704_893137_610A844A 
X-CRM114-Status: GOOD (  25.41  )
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

On Fri, Dec 20, 2024 at 06:50:50PM +0900, Damien Le Moal wrote:
> This patch series implements an NVMe target driver for the PCI transport
> using the PCI endpoint framework.
> 
> The first 5 patches of this series move and cleanup some nvme code that
> will be reused in following patches.
> 
> Patch 6 introduces the PCI transport type to allow setting up ports for
> the new PCI target controller driver. Patch 7 to 10 are improvements of
> the target core code to allow creating the PCI controller and processing
> its nvme commands without the need to rely on fabrics commands like the
> connect command to create the admin and I/O queues.
> 
> Patch 11 relaxes the SGL check in nvmet_req_init() to allow for PCI
> admin commands (which must use PRPs).
> 
> Patches 12 to 16 improve the set/get feature support of the target code
> to get closer to achieving NVMe specification compliance. These patches
> though do not implement support for some mandatory features.
> 
> Patch 17 is the main patch which introduces the NVMe PCI endpoint target
> driver. This patch commit message provides and overview of the driver
> design and operation.
> 
> Finally, patch 18 documents the NVMe PCI endpoint target driver and
> provides a user guide explaning how to setup an NVMe PCI endpoint
> device.
> 
> The patches are base on Linus 6.13-rc3 tree.
> 
> This driver has been extensively tested using a Radxa Rock5B board
> (RK3588 Arm SoC). Some tests have also been done using a Pine Rockpro64
> board. However, this board does not support DMA channels for the PCI
> endpoint controller, leading to very poor performance.
> 
> Using the Radxa Rock5b board and setting up a 4 queue-pairs controller
> with a null-blk block device loop target, performance was measured using
> fio as follows:
> 
>  +----------------------------------+------------------------+
>  | Workload                         | IOPS (BW)              |
>  +----------------------------------+------------------------+
>  | Rand read, 4KB, QD=1, 1 job      | 14.3k IOPS             |
>  | Rand read, 4KB, QD=32, 1 job     | 80.8k IOPS             |
>  | Rand read, 4KB, QD=32, 4 jobs    | 131k IOPS              |
>  | Rand read, 128KB, QD=32, 1 job   | 16.7k IOPS (2.18 GB/s) |
>  | Rand read, 128KB, QD=32, 4 jobs  | 17.4k IOPS (2.27 GB/s) |
>  | Rand read, 512KB, QD=32, 1 job   | 5380 IOPS (2.82 GB/s)  |
>  | Rand read, 512KB, QD=32, 4 jobs  | 5206 IOPS (2.27 GB/s)  |
>  | Rand write, 128KB, QD=32, 1 job  | 9617 IOPS (1.26 GB/s)  |
>  | Rand write, 128KB, QD=32, 4 jobs | 8405 IOPS (1.10 GB/s)  |
>  +----------------------------------+------------------------+
> 
> These results use the default MDTS of the NVMe enpoint driver of 512 KB.
> 
> This driver is not intended for production use but rather to be a
> playground for learning NVMe and exploring/testing new NVMe features
> while providing reasonably good performance.
> 

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்


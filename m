Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B1AE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 12:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oWMz4Or7oMQmuw8gXtGP6co0bEIH20jpOM6bqYupeRQ=; b=emEvCjg0yUsF0xiKNBnOU9l7aH
	Qpo81xOvZSe9ZCXyu2ooieebscmiE8aC/8MZuauR5r/hWJUexHU/nH/q+STV+sERay5wpKpb4TM81
	Q6srG74x1how9CSE02PCQg695of92+S4c3ddy4cpkun1AiL3XGLM781J8RnsZnbXYtyFbuXKpIkZB
	5OHpr1bN4MQCQb7a2XUWFP67YHgTN5wqLbb+IisaTF5YpEtwDU5TCZgTZOQSItzmMzZD8aPM/tbq7
	neY1mKsfytOU/erVMXgffzsEfwORElHZA8mFP4s8QNn+hfi7Dptk0SuxKhHZsujF+Ja6VIcNW4hy7
	pKZPuwfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOc1c-00000004sPI-16z5;
	Fri, 20 Dec 2024 12:22:36 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOc1Z-00000004sOZ-1aFw
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 12:22:34 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-725c86bbae7so1630676b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 04:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734697352; x=1735302152; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oWMz4Or7oMQmuw8gXtGP6co0bEIH20jpOM6bqYupeRQ=;
        b=mI47O4SMxeQaLfr8TgMsferzzkC2jiIzZ0j3XCE/HfI88E39NX3TlAOSLOHPp3YMRU
         e5k6q7pfko9xcv0pUWKYnZz1L6wsyL2E3hvN/UBpogOAc2Zb+PKfhPCMFXv/dwf0LMc2
         27lonMmM/nP7TBf7B+6N/Xveh3kwVULmrLjXkIen6IQwW4jrvxXv25+rjSj+hJVStjsv
         +KavsaR2Hi8VkEVTUD4co5Dno6HFqgaX0ls6NSgojiGwBr0LaJkkrSu3m9FvHze/40FM
         6CH9QwE4Q0IdEhFjONps5nbreiVOcwOcnaytNmjNddf3Hj2CuSSuV5ir5hnh3ckMIbwJ
         bHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697352; x=1735302152;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWMz4Or7oMQmuw8gXtGP6co0bEIH20jpOM6bqYupeRQ=;
        b=Dp6eVG3gWMuPpQIeuZkV71Nqs5U/S5WPwjP1I1Kq1CxQBcXDRB57dxI4Gr101Dl5T4
         51FRQWghf5d/UX7A+pfICEZGrVeonxmxEeDrBTDxy0k8JHtHuBxTMZtAPt7dpnGk39TW
         kDSEWBZj27mDUijI9+qrOMpLdAx5UIFEk12ExBvD6uAtVM+MDIZaaYsn2N8kq+Tc/0LW
         zyj6xe/kepRNSRyZMiZmBgQK9coKavVH9B7yWScOYpsoYiJCpV9uCfLpa1nUgnbyLeig
         WVoZ3/EnUOx74nZK9xboz1m2wTkeopeTKm8SRSFht9Q8+ShM3x7hVtktsuZzOtp3GXbD
         4xTQ==
X-Gm-Message-State: AOJu0Yy4V/ITnS4EZT3ljE0S2Xro75ro3pEyuLd39Sv+4FIu2UkpFLfr
	Z8G9B3TJ3K3Vxnl8kfp40dQkCW5rZqAUd+cXx0RAuEoRxWAK8okIsRiU/MLOvw==
X-Gm-Gg: ASbGncu8+3N01jsI46/pHuvcjzAIdVp5kJOB9oWHH4OWDG1XT6a4oPtSmPZoPJHGAFt
	5DAFvyMEmGB6tJoY8aSZ+IKl/3RuVl65JHqixldtce8+KkO5YyfV+EDKFnVs+kJCOi79tR+lEhN
	OaVtczSaU5fqTKdgISwpfPFelRorxVSSBcD1zU7uo3DdBXvwCCQAUy3AZhLxuIYfyt6SkCx3Q+S
	ZWSt+ow4TBZqMjnJ2epTmBXqglDSfNCOtT0p1P3J2/jIOmrYRs/k425uR0sGyC7Ja0O7g==
X-Google-Smtp-Source: AGHT+IFBE2ysCt3TYqJyyCcgYPYBsX3e7fiMItcbT+QolwPmsg4IHUeRQxoA27xY/70Fm+2n4WAWrg==
X-Received: by 2002:a05:6a20:728f:b0:1e1:aef4:9cdd with SMTP id adf61e73a8af0-1e5e0450013mr5074508637.1.1734697352265;
        Fri, 20 Dec 2024 04:22:32 -0800 (PST)
Received: from thinkpad ([117.213.102.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dba99sm2948660b3a.92.2024.12.20.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:22:31 -0800 (PST)
Date: Fri, 20 Dec 2024 17:52:25 +0530
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
Message-ID: <20241220122225.lw6mpv7gx77igzgl@thinkpad>
References: <20241220095108.601914-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_042233_426655_F9D0B649 
X-CRM114-Status: GOOD (  26.80  )
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

Series looks good from PCI endpoint perspective and I've given my R-b tags. I
hope this gets merged through the nvme tree.

Thanks a lot for the work, Damien and Rick!

- Mani

-- 
மணிவண்ணன் சதாசிவம்


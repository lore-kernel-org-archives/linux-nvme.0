Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDD3E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 06:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pIvW1ykJTcaYnpCPQyrHZU54o0w1qCWSM5T8sY84ePU=; b=3mrHBXabZINdHAk10/UBRs4H+S
	LqIZbBt0a++xYCjdT+c0OZ7oUC5LK8Heq7vrbRSINwqjBGhFsZUJwlhiKu6xJMtXhz+olFJwuyD9D
	1f0nMlBoj5ISfc8ADkjX0N9gF5VvmpoRAqXNpKyETcHrasSSAuqS1MQ5XKwlSrE6s4jxNSj/xa/ub
	lPtDW5JA54xbu/wwymdSVSS1FMmsC9eg01QnpmoE7tW7UybgC5J/XPiTdbtl8lMS9eQ9BxTZRw7v9
	8WpQhFjySMpk+b5taHsBL+UctHm5B4Y9w6ILWcAjFAsiCvMYhmwf2wK19uJfRJCeJCz7SCyaXrv4i
	rWM3vmOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tN4Gk-000000099wk-1PET;
	Mon, 16 Dec 2024 06:07:50 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tN4Gh-000000099wD-3365
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 06:07:49 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-725dbdf380aso2829906b3a.3
        for <linux-nvme@lists.infradead.org>; Sun, 15 Dec 2024 22:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734329267; x=1734934067; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pIvW1ykJTcaYnpCPQyrHZU54o0w1qCWSM5T8sY84ePU=;
        b=MsIOx47f75bi3dSiVu6RtCVqdjwnXLsL5D/VfxTsunvJ1Jo9TGZ8NHhSEDpJgQzk+Z
         BEaepiSVMhupJcVi/BzjugIzSDprOhjOFFZXWwwbF6inoMq4rl+5WGWJtiWTV73hkDYP
         tB5MFvj5CH3ttJk3hHU9MhNGZ+MaR331W2yOcB7Ah66pY1Q5xmQl+hhbxl8KC7DlGPhL
         SsLlvxTrWd9yftCuj5wvYGIFycLIkrv1ltf9iKAFmceQkBRQ7jazu9S1xsdxI/l2Lilh
         LWragLlsppxntnsYVHh2wwQEr2feXB8U/rfQpsOd/o+vi48L7GXrTWC7XZI3dG7TPg+0
         o3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734329267; x=1734934067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIvW1ykJTcaYnpCPQyrHZU54o0w1qCWSM5T8sY84ePU=;
        b=BKG/O7ajwAPdsg0zDLfftUFsWX2xx9a22jtPOAh36ZcvLH1htxXQFmKSNaJ/g3PKe2
         S1XNETJUaAUhrAQbmWfpX6yaf46odpcxM3AIg+1/1OWCOEYoz6daDzyIBe+1RTUGsLG7
         /2abQVP2C6RmAjyPhBVJt4duB05Pvh9J1idMSVAaMx9UUJvo6Q0cp7VBGHjr9i52KvHE
         yJT2TPpdMnyR5ZPpOhnWEKa33QE/yXyFqsu5wU0QF6Llg8n4tDbWs7z6qY4GGoFIC+tp
         k7Y4QmyLo8don7p4qNeFmTt8wU3KNonfZlu3e9Epgu6HfzuBOMOuDLmwiW3fDhifjuIw
         R4Kg==
X-Gm-Message-State: AOJu0Yw+lmtUAC9QaHjtblqUC+EBfSBqdzC5DdV4s78MeTkXQwEKsf87
	VAvFeVne3kJp4YpBB6K0DWOWsoPsi+s/qZk5Zdtok2TJn9G0uba3ou7DzFJyHA==
X-Gm-Gg: ASbGncsHHtMA5KNkflXxMy5cMtfeIaSEY6cCMaWyAIteQQ57+TT4nuPGoN7CDnG1Fwh
	lTj9BspiJUnrGJdlnSFazSSm/dzwVYj+Yea0fKc1xlC3N41rBh5RjCSenc4V3N5HncL7SFmj/Vf
	StBJjPBnQxLNZiyh84c1RlFQM+8x8uy3i5+rpJ4ALd++yPuv59M9jbB2fbN04o196UGo2rmCRtT
	PwQcBiFZNE97F+riWL4+9AOGFPLvbz4QvdHi1kNLh7if+ga6Y55lrAp1PEwaidYhIc=
X-Google-Smtp-Source: AGHT+IEjmzOBuhULciZZypBNXLa+4xbf0eH7uAdC5EchG0aKhsBzJYAEf4T7Tg8zJxUpyKp2a5+GfQ==
X-Received: by 2002:a05:6a00:b46:b0:71e:4786:98ee with SMTP id d2e1a72fcca58-7290c2702e3mr17481504b3a.21.1734329266704;
        Sun, 15 Dec 2024 22:07:46 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad7845sm4040968b3a.68.2024.12.15.22.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 22:07:46 -0800 (PST)
Date: Mon, 16 Dec 2024 11:37:41 +0530
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
Subject: Re: [PATCH v4 00/18] NVMe PCI endpoint target driver
Message-ID: <20241216060741.q66ivjcbnmgiffat@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212113440.352958-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241215_220747_770632_5D6C081B 
X-CRM114-Status: GOOD (  36.30  )
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

On Thu, Dec 12, 2024 at 08:34:22PM +0900, Damien Le Moal wrote:
> This patch series implements an NVMe target driver for the PCI transport
> using the PCI endpoint framework.
> 
> The first 4 patches of this series move and cleanup some nvme code that
> will be reused in following patches.
> 
> Patch 5 introduces the PCI transport type to allow setting up ports for
> the new PCI target controller driver. Patch 6 to 9 are improvements of
> the target core code to allow creating the PCI controller and processing
> its nvme commands without the need to rely on fabrics commands like the
> connect command to create the admin and I/O queues.
> 
> Patch 10 relaxes the SGL check in nvmet_req_init() to allow for PCI
> admin commands (which must use PRPs).
> 
> Patches 11 to 15 improve the set/get feature support of the target code
> to get closer to achieving NVMe specification compliance. These patches
> though do not implement support for some mandatory features.
> 
> Patch 16 is the main patch which introduces the NVMe PCI endpoint target
> driver. This patch commit message provides and overview of the driver
> design and operation.
> 
> Finally, patch 17 documents the NVMe PCI endpoint target driver and
> provides a user guide explaning how to setup an NVMe PCI endpoint
> device.
> 
> The patches are base on Linus 6.13-rc2 tree.
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

Damien, thanks for the work! Please wait for my review comments before posting
next version. And sorry about the delay.

- Mani

> Changes from v3:
>  - Added patch 1 which was missing from v3 and caused the 0day build
>    failure
>  - Corrected a few typos in the documentation (patch 18)
>  - Added Christoph's review tag and Rick's tested tag
> 
> Changes from v2:
>  - Changed all preparatory patches before patch 16 to move more NVMe
>    generic code out of the PCI endpoint target driver and into the
>    target core.
>  - Changed patch 16 to use directly a target controller instead of a
>    host controller. Many aspects of the command management and DMA
>    transfer management have also been simplified, leading to higher
>    performance.
>  - Change the documentation patch to match the above changes
> 
> Changes from v1:
>  - Added review tag to patch 1
>  - Modified patch 4 to:
>    - Add Rick's copyright notice
>    - Improve admin command handling (set_features command) to handle the
>      number of queues feature (among others) to enable Windows host
>    - Improved SQ and CQ work items handling
> 
> Damien Le Moal (18):
>   nvme: Move opcode string helper functions declarations
>   nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
>   nvmet: Export nvmet_update_cc() and nvmet_cc_xxx() helpers
>   nvmet: Introduce nvmet_get_cmd_effects_admin()
>   nvmet: Add drvdata field to struct nvmet_ctrl
>   nvme: Add PCI transport type
>   nvmet: Improve nvmet_alloc_ctrl() interface and implementation
>   nvmet: Introduce nvmet_req_transfer_len()
>   nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
>   nvmet: Add support for I/O queue management admin commands
>   nvmet: Do not require SGL for PCI target controller commands
>   nvmet: Introduce get/set_feature controller operations
>   nvmet: Implement host identifier set feature support
>   nvmet: Implement interrupt coalescing feature support
>   nvmet: Implement interrupt config feature support
>   nvmet: Implement arbitration feature support
>   nvmet: New NVMe PCI endpoint target driver
>   Documentation: Document the NVMe PCI endpoint target driver
> 
>  Documentation/PCI/endpoint/index.rst          |    1 +
>  .../PCI/endpoint/pci-nvme-function.rst        |   14 +
>  Documentation/nvme/index.rst                  |   12 +
>  .../nvme/nvme-pci-endpoint-target.rst         |  365 +++
>  Documentation/subsystem-apis.rst              |    1 +
>  drivers/nvme/host/nvme.h                      |   39 -
>  drivers/nvme/target/Kconfig                   |   10 +
>  drivers/nvme/target/Makefile                  |    2 +
>  drivers/nvme/target/admin-cmd.c               |  388 ++-
>  drivers/nvme/target/configfs.c                |   49 +
>  drivers/nvme/target/core.c                    |  266 +-
>  drivers/nvme/target/discovery.c               |   17 +
>  drivers/nvme/target/fabrics-cmd-auth.c        |   14 +-
>  drivers/nvme/target/fabrics-cmd.c             |  101 +-
>  drivers/nvme/target/nvmet.h                   |  110 +-
>  drivers/nvme/target/pci-ep.c                  | 2626 +++++++++++++++++
>  include/linux/nvme.h                          |   42 +
>  17 files changed, 3897 insertions(+), 160 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
>  create mode 100644 Documentation/nvme/index.rst
>  create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
>  create mode 100644 drivers/nvme/target/pci-ep.c
> 
> 
> base-commit: 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்


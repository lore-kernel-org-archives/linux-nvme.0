Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCC7C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 05:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mwqJGLXa3EAidTG/liVU6a4cnyQu2reXyeYpfOL0Vno=; b=KaYgClqWAZUz101T6c1RIWcVUd
	L+nZVxfGzHt7G/QbyDNYb/N+BvE5oGmqhGkg4eDjikDs5zmg4lr0iLNVVmn5vSRPR5yNhFNmYC8Wy
	BmQ8igA0Z8I90EUSOBsLVDq/SNy4EipLBSpogzesh/UGdRg82zH45Hqz+RWwnv6PloX5lHC4Xzp3z
	iUNZUx8Tu+kknpHSbWtEcNfG0otlzo4f/woq6RRFu+o0lWAsG24Cki5CTcceYnFQ72nNj1zoZZlG/
	4p90Du5T7LixlZWaT04Ty5tRRGGRz9Kii9C3OD84CrTGPhHvzsSS2YA1AAmTQXlknjXzO3pDFwtgl
	CRoWdcaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ouo-0000000CrLe-2c2Q;
	Thu, 24 Apr 2025 05:14:26 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7oul-0000000CrKl-2FUg
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 05:14:24 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3035858c687so490394a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 22:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745471662; x=1746076462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwqJGLXa3EAidTG/liVU6a4cnyQu2reXyeYpfOL0Vno=;
        b=W58Ft8+oTaoJsrDbofOGLKhbkLpZmSmZ7kQjTDfLk52x55efEzh/PAgi74UQ+Lx10Y
         aFSLejnCcdG4NOB+cmx7IzwYPsi27MnAtaI+x/qaw7SNw0KVDbvOV5SmXhr32J3zDk/l
         vAJ1erZcRE9HtqeC0HsnHWkQZb1jG56FD4mBniC5lil5gSGApSMvMLg34VFmcsknZcVJ
         cPrsROpOoEPdctV/QfJAojV0z1Xgnn5FRB9UcluDGGjFxkF3BG/T9ZRX30TQ9ljrmJEx
         KoNu7NlnTUqnNFcKl1EZohVT81HXWR2PSA2IK6WjDL3TDbIc38eDRsWDayxBUFs6esA1
         QVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745471662; x=1746076462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwqJGLXa3EAidTG/liVU6a4cnyQu2reXyeYpfOL0Vno=;
        b=heSKZzZwraYX8bM8igFaQvwaMJI8HQxtDHW6v+1AWwe0b9OaYpN9zDPsbBYtswq9Rl
         s1WuH1yFgwgEdMk67I2h9p5wto74CSRRzrHqxjSczVH1TaTkwfTK7+ZTSL0KDPtn8Kpc
         O3jLURm/9skf2G8LPQmwUedC1X9JTJi5cN3F/lf3SDrvLUOHOEdy14gUBjuFVxHn7R0L
         nLOvT+27DjbBuC5HyNP4keRbryNt8FyMpvaMV3gJpe2akh0oHOFnW2zcxqoUY6Mdiszb
         quPiL4OLJC2e29mLnwA/7nXNZpLf2fQYubs6cEbPrmyNyMKmjCPPDcWbG4Siew4QeljE
         1ZTQ==
X-Gm-Message-State: AOJu0Yx5uiy5Q24h9pIDTyNuGXKoESbBJbVx1rsuBv01cbTGYs+rz4LT
	+LX0k7mNQgcf00Y1HsVJiZO68ayIy5z+FCk68MbBelwTVVfBzPPiYNhZPiSW
X-Gm-Gg: ASbGncvNQSOQ98Wb/qm6CBIHFOZjMgnTqn5yVrW3KnwT93CWxiIK9NGeRMa3ArDykng
	p0ZDkkHbir1K5/gKnAzorNaQU4A2/j3wqN2NNIy1L0e4LzpaX7AhaHZxAeQCdEgzyRcZAqh4wAY
	2FV/Xvn00BCeTdXCmzezPOpFpuRzCqciSQqu8BpoE41C7UeEML52+lHlJU9gByiPkpQTB1bESgV
	P70fn+3AHpchuSxWfe5SaaCsP4wNE7w9/saZfHTakfE9CyC5uPYVJeARMm8jKoLZEQAcew1MJox
	9kaS1cpdzl0nlRH3h69X0Dps5bRqQ3tOvprmfQOkFbfUY+UDYWJwTCM5Tg==
X-Google-Smtp-Source: AGHT+IFgIjLLbeuYrJwVRgnRqVTLrO/XwctsTrJC0RhcKGwb9mA20Uef0cvGRhlmhfVk5XXwaXvWGQ==
X-Received: by 2002:a17:90a:e7c5:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-309ed3425ebmr1975587a91.30.1745471661696;
        Wed, 23 Apr 2025 22:14:21 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097bdbsm324771a91.26.2025.04.23.22.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 22:14:21 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: dlemoal@kernel.org,
	alistair.francis@wdc.com,
	cassel@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 0/5] pci: nvmet: support completion queue sharing by multiple submission queues
Date: Thu, 24 Apr 2025 15:13:48 +1000
Message-ID: <20250424051352.7980-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_221423_586502_71DBAB98 
X-CRM114-Status: GOOD (  12.80  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Hi all,

For the NVMe PCI transport, the NVMe specification allows different
submission queues (SQs) to share completion queues (CQs), however,
this is not supported in the current NVMe target implementation.
Until now, the nvmet target implementation enforced a 1:1 relationship
between SQs and CQs, which is not specification compliant for the NVMe
PCI transport.

This patch series adds support for CQ sharing between multiple SQs in the
NVMe target driver, in line with the NVMe PCI transport specification.
This series implements reference counting for completion queues to ensure
proper lifecycle management when shared across multiple submission queues.
This ensures that we retain CQs until all referencing SQs are deleted
first, thereby avoiding premature CQ deletions.

Sample callchain with CQ refcounting for the PCI endpoint target
(pci-epf)
=================================================================

i.   nvmet_execute_create_cq -> nvmet_pci_epf_create_cq -> nvmet_cq_create
     -> nvmet_cq_init			[cq refcount = 1]

ii.  nvmet_execute_create_sq -> nvmet_pci_epf_create_sq -> nvmet_sq_create
     -> nvmet_sq_init -> nvmet_cq_get	[cq refcount = 2]

iii. nvmet_execute_delete_sq -> nvmet_pci_epf_delete_sq ->
     nvmet_sq_destroy -> nvmet_cq_put	[cq refcount = 1]

iv.  nvmet_execute_delete_cq -> nvmet_pci_epf_delete_cq -> nvmet_cq_put
					[cq refcount = 0]

For NVMe over fabrics, CQ sharing is not supported per specification,
however, the fabrics drivers are updated to integrate the new
API changes. No functional change is intended here.

Testing
=======

Core functionality changes were tested with a Rockchip-based Rock5B PCIe
endpoint setup using the pci-epf driver. The host kernel was modified to
support queue sharing. In the test setup, this resulted in IO SQs 1 & 2
using IO CQ 1 and IO SQ 3 & 4 using IO CQ 2.

Testing methodology includes:

For PCI:

1. Boot up host
2. Assert that the endpoint device is detected as an NVMe drive
   (IO CQs/SQs are created)
3. Run FIOs
4. Unbind NVMe driver (IO SQs then CQs are deleted)
5. Rebind NVMe driver (IO SQs then CQs are created)
6. Run FIOs

For NVMe over fabrics: Using NVMe loop driver:

Note that there is no queue sharing supported for fabrics.

1. Connect command (IO queues are created)
2. Run FIOs
3. Disconnect command (IO queues are deleted)

Thanks!

Wilfred Mallawa (5):
  nvmet: add a helper function for cqid checking
  nvmet: cq: prepare for completion queue sharing
  nvmet: fabrics: add CQ init and destroy
  nvmet: support completion queue sharing
  nvmet: Simplify nvmet_req_init() interface

 drivers/nvme/target/admin-cmd.c   | 31 ++++------
 drivers/nvme/target/core.c        | 94 ++++++++++++++++++++++++-------
 drivers/nvme/target/fabrics-cmd.c |  8 +++
 drivers/nvme/target/fc.c          | 10 ++--
 drivers/nvme/target/loop.c        | 23 +++++---
 drivers/nvme/target/nvmet.h       | 24 +++++---
 drivers/nvme/target/pci-epf.c     | 11 ++--
 drivers/nvme/target/rdma.c        |  8 ++-
 drivers/nvme/target/tcp.c         |  8 ++-
 9 files changed, 147 insertions(+), 70 deletions(-)

-- 
2.49.0



Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8FC38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:52:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E68212CC
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qsdW4Dxa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pUadYOcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E68212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Qh1xMEPTMmjZafljiSEi4VPoxBmeSi8wyzRfsSYfTFA=; b=qsd
	W4Dxa44L62Sn1jZnOb+fjtT8qp6OKb0XiJG3DgTuvbIYyMY14sHD2vIn1/UVtoaCvX9pvf+lra51o
	XHfqVJYOWA6g0hG/GMsFFc8ZTyGt5SJmG5Q/s7dYRoCXGzJ/KveW1w9yufMVrwLB9DY8rIuLEbp1j
	vh0Q8ObP8Vxz92MBaftrd8xRzqhTGhhUNZzemBaadgEF+SvEIfOaQQz9z8v6RHRSN7wVfV0XEreYF
	ykdFlkPM7Ogkw8G8mHE5IjILHjaO2onwyT7Fe1tzuemjBZlu3kwicvkXbu044NlQQoT10YMlavMNt
	a2SBMOpoh9Z7ZRNQKqKp0JYAe50+i0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJk2-0000eB-3z; Sun, 19 Apr 2020 23:52:50 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJjz-0000dk-O0
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:52:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340367; x=1618876367;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WfG6PFcgqr9nwXIGMIW8I2KbUEIxa50Zwbx/qk0V8S0=;
 b=pUadYOcLGYyaCo6Iec7RgAnbw2wZhVIvH0nLGTsX3SBfccT235TN2tzY
 r5b94fZAvla2mx3CAWBmsFt1xAcsuOWBxV08c5rWk8N9egsqNtlIX8V2L
 o4fs+u5PZ4fg5XTuaey56PwIbrdTAZSO4PjU1DeZXUbanDFWhwPnp20q4
 0TdHbV7ZijM57BzNFsNC9gZFT6xvnujvncLTwAGVqJnCLmUpkN37FPnm3
 ZcH5itk8jqtzvkuorbNeJHiPFPgVKkoEOoRbw6HZ9i0QEqlCKLQKP4VYG
 +gUFvBhLpVUql/whbIXHUN/crtPfb53tl0K6pZpDaBIadZJQv3GgSK0fC w==;
IronPort-SDR: WQcWRrxITPGUFlNgWwC2Mioql00pwM490bJ7xYu8ZqOMYmTi00KKtLTeLUqt7DG6R0ngbVDAXT
 i7vvn2qudb0NZE/7uVdwUhEbbYNl1v969HNQ0Va8PYQ9dofXlTC5QZvxZ96L7q8rJkN/HRwMmf
 s6LZn1wXkipuS4X+YnEx5AiPWqg1oidxqssVBZb9nKiCLv4RWmzHawzoSbswfCfnZIC2kS16s5
 i2NeGVOBgrdyP7g/eXfLJctoWxImSvF8kedIypnYUfAOHuQNs+beQdYy4XjPxBISxf927dRm8w
 iow=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="137096982"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:52:47 +0800
IronPort-SDR: e8IuPvLThwR9Xf95KUOv054aPcsJzy9NcbgJJmOoB3cq6MxH0u8vchICQP/RoRtB2T8FI9fh8v
 H3BwwItZvsUBjnsyQmVJxAnB+2fd6h/6c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:43:08 -0700
IronPort-SDR: MbyVRF6FgYhF2ZiecFVtJPk+pkEwz5Ob2DVnaNIfO5kqN0C5K6Hvx0c1BE/Mwsw2tQcm+sNxaU
 aB8dOZn2dGjg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:52:47 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/6] nvmet: configfs code clenaup and fix
Date: Sun, 19 Apr 2020 16:52:36 -0700
Message-Id: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_165247_832813_015E3BB9 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: multipart/mixed; boundary="===============0904091409688873905=="
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============0904091409688873905==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi,

Over a period of time, configfs added different attributes and groups.
These groups and attributes have common type to name mapping
functionality with code and identical structures (see [1], [2] & [3]).
Where [1] and [2] adds a different structure which can be made generic
and can be resued by [3].

This patch-series adds a new generic structure for type to name mapping
which then used in the [1], [2] and [3] to align the code for 
consistency with removing the code duplication of
struct nvmet_transport name and struct nvmet_ana_state_names.
We also introduce a pattern with for-loop-compare-success-return with
type name map.

In short we address following points :-

1. Introducing generic type (identifier) to name (string) structure
   nvmet_type_name_map, by removing the private per attribute
   specific structures (nvmet_transport_name & nvmet_ana_state_names)
   for defining the type to name mapping.
2. Keeping the code consistent with the use of for loop and type-name
   struct array iteration instead of the duplicating strings in if/else
   latter and switch.
3. Having consistent coding pattern for type-name
   for-loop-check-success-return so that future introduction(s) of per
   attribute type-name will not add inconsistencies.

Regards,
Chaitanya

[1] struct nvmet_transport_name :- 
commit <a5d18612295a0>("nvmet: refactor configfs transport type handling")
[2] struct nvmet_ana_state_names :- 
commit <62ac0d32f74ea>("nvmet: support configuring ANA groups")
[3] nvmet_addr_adrfam_[store|show] :-
commit <a07b4970f464f>(" nvmet: add a generic NVMe target")

Chaitanya Kulkarni (6):
  nvmet: add generic type-name mapping
  nvmet: use type-name map for address family
  nvmet: use type-name map for ana states
  nvmet: use type-name map for address treq
  nvmet: centralize port enable access for configfs
  nvmet: align addrfam list to spec

 drivers/nvme/target/configfs.c | 225 +++++++++++++++++----------------
 include/linux/nvme.h           |   2 +
 2 files changed, 116 insertions(+), 111 deletions(-)

-- 
2.22.1



--===============0904091409688873905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============0904091409688873905==--

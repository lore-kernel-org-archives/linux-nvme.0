Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2E9C48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 16:59:37 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A864761626
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 16:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A864761626
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+wbxlUEPnnXEbMv/ba9RRtWPEgQtTjMj8KcTNVlCn/Q=; b=LYQilkCRXY/bGm
	9QAA0it+l1Vb4k5UET9ZrSYuX2PSzyXyUOxR3+3jmrAglqwgSvSFjASWiyMFfkYRNDmdW67ML+DPY
	VDs3wn/j07kS+TXSArp8xJKGlulK5WvIy3UOTEkXZmGzdXoJm3dICEqpi6cKdirIKwp8MvPHzKUgA
	dNrY/iRO6sb9BstZxamQ9x59n0zR5aYh+B5Mdgvdd0yg4okd06gU/N1vzxMpavvWM7vkhQWFTcorI
	d28ePTN4Y2+xm0v52q4XhVr44peLUGUnylTYQZdy4ESfwVVPsl/Pf2f6c9pJdDNgeDHgpCOJAAF+N
	RD5d4P+4y3v3mzJ7Pdeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltCOp-001Y4C-4S; Tue, 15 Jun 2021 16:58:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9PW-000E8e-Mr
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:47:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=MLp9ZNydUHsD76zgb4T7tfIURaNk1A0k1DUI2a0h318=; b=Ck029nOU3YdgfUgcb5BqBXcikR
 w41dAx1QQXjnWzu/APbmN4BhXgrp5VZf8BjRn+7E/+SXjKp0+RYw+hN/4IoVzUhaz8uWbvGdodSHX
 /i+xJSRCqLYRWjnez1N1/vvyBYadgal97Z0e+Hqr86nc52pytrVWMbm4Q+KSGRNgx6eBql7aOIQ/A
 kkO1LMQSb6l5tQVNhtORKT9183lTz9Khk7aylmXmaT9vz/3lz83B/x/JBt12+2vcj77iZRZOa7Sir
 mRt6fK8WZCKhl8iP5Kwgkt2t8mIXC/ABbugRtZYsmZ3hpYVEBokQNn1fbqSuAFXVLh09QUMsE9Fon
 ZWOmhFDQ==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsz5O-007H7M-DX
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 02:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623725161; x=1655261161;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fmszEABEUjW0hT5ujTyJJ1dAhhtYhxvwsVzXIYmkCfg=;
 b=ag8t4kvj0XQ/yrZmvQuYEUrGqqNfVzbph2sUTDQmzQr7W3xJIps9uc+q
 j7gHmUP0Qcz9PiyIZ6jb+ulEsCHzBSh/CfHSDxvmEvvRYYrHYnXmwKHW5
 5kG8wxVVCNFzVOEo8vGGeHJoWjnfU9SbGs9u4Rw2pMwdglbgReU6jNqIe
 xIYjQCxXxsj5VyN54me0w7ropi+LWix50/DYpi0TUFIcqWGgxrv3CC9qj
 ECXDVaHr4v5QoWDFnwGXF8fqs6NrHk8r4d/FV4vSb94Fn287IsMJ8Htaj
 X6lBYxAVe9mufCOWKj49J0NBqMLhDjuk2sWTYrP3ulhnU7dtVPed8zFLn A==;
IronPort-SDR: 3rmSIx/CVdBXnbLWi38i/AuvaLMkr7dzS3UsCVh4O2cM/PAr5EkEXeS/D9vnGanAPJIwtqZMWK
 uwZXp2C9+KrsJILf6hvMDYUAU4Zcssfyn5tKTDESpjyoslSGueJzkY7FOW9pjO7pGOcQALKSXD
 cMZjbGO+nRc1hS6Tg2jzhA8QTteqATa4V49aBVNOQeEM+OnX2WS3TbITK4CV2VMJS3MXRGTLLy
 V5yDJPW+7CbI6aji1eciCpUlEIa+0r6nDdrNVVrubEod3JPaOUSk5oI8ov+8Wg9sTn4Gqfn0Hw
 BQs=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; d="scan'208";a="171171839"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 10:45:54 +0800
IronPort-SDR: SlLmtflMbBOoJv2rd857MGWqvBX7S57R/PSTiMdUeX+DtKOy6rQMxPLlxoiBILi26IR4k8yKxS
 8U5opwreRk/lwvufw51iCRsgWahdpUHI6GY4aP4acJL4fTY/RhTtnZP3KiMovPFMgbmvDaC8OD
 snMfEhVbw4i/yptMbaDxgan6C0pu34YqTGt7sZpOAu61yhNewYnDhKAjpRaL9eeZ94YfcAvT+9
 P1u6XK4FHYzcFh1ib4z+rbZJr9t7EDmsqdiw/YpS2TXIBQVa0s4Yp0xBvrTkyIHdVLfUt4bf2R
 8TcwT+uQCP9QomcGqi57cChB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2021 19:23:24 -0700
IronPort-SDR: C4OG5pg2rkkZvfT/rhHLC/1ZzfEuZqOlppQszhUIkH+0bn46zct2Daf4BKUXyoufg4XxxeexRA
 Zsi9rbyXAk5hFBE28rWl+8XV0ZVWqRMtplOQUXD1r8934i2JE1fOwOu6aqY/ge3nDp3DYn14+B
 qjiW0WuT5/rTSlW4d1+i9frZrgAzMLvp5V/EoYtk6rx2bhvn//V0oIFr23KaSFXiGPL7p0xhL/
 iVTSgcax2yI9OmDqqEbRJAQ/wUTh2E2LQQsNuxtfa5mxyZaM4PkZipcq9rDpuW/mDSdDvjhVjA
 CSE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jun 2021 19:45:55 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/4] nvme-fabrics: remove struct zeroout memset calls
Date: Mon, 14 Jun 2021 19:45:50 -0700
Message-Id: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_034602_554796_5157E526 
X-CRM114-Status: GOOD (  11.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

While reviewing the code I did removed the calls to zero out structures
using memset() for the lio target, which are reviewed and accepted in
the linux kernel tree. (see [1])

This patch series is based on the same cleanup pattern for NVMe host.
This will allow us to have uniform pattern in the future code review to
avoid similar calls which seems unnecessary.

If this is accepted I'll gradually convert the rest of the host code
mainly core and pci.

-ck

Chaitanya Kulkarni (4):
  nvme-fabrics: remove memset in nvmf_reg_read64()
  nvme-fabrics: remove memset in nvmf_reg_write32()
  nvme-fabrics: remove memset in connect admin q
  nvme-fabrics: remove memset in connect io q

 drivers/nvme/host/fabrics.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

[1] https://lore.kernel.org/linux-scsi/20210228055645.22253-1-chaitanya.kulkarni@wdc.com/
https://lore.kernel.org/linux-scsi/20210228055645.22253-13-chaitanya.kulkarni@wdc.com/
https://lore.kernel.org/linux-scsi/20210228055645.22253-14-chaitanya.kulkarni@wdc.com/
https://lore.kernel.org/linux-scsi/20210228055645.22253-15-chaitanya.kulkarni@wdc.com/
https://lore.kernel.org/linux-scsi/20210228055645.22253-16-chaitanya.kulkarni@wdc.com/
https://lore.kernel.org/linux-scsi/20210228055645.22253-17-chaitanya.kulkarni@wdc.com/
https://lore.kernel.org/linux-scsi/20210228055645.22253-18-chaitanya.kulkarni@wdc.com/
https://lore.kernel.org/linux-scsi/20210228055645.22253-19-chaitanya.kulkarni@wdc.com/

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

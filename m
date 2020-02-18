Return-Path: <SRS0=tyJo=4G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EBAC34031
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 21:43:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5360F206E2
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 21:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VIH7vA4C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SABLYKwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5360F206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+U+qjEZNoTQin4RDxztqjY0eW2YJnhDeEfcI90oi9A4=; b=VIH7vA4CHpdvpa
	ukr7LR99Piirld8ykvK1OiFKHIDb7llHekejBYlcm142CCL4LCP9iUwJsWFobOi0FcpoH2D1ITH+5
	yDd9UpSdAryOO1TYKfGW0Ak66XWswxIzf1GAwO4wqxeCTjYMvz2RPUc+LYUdUe3SGacJLG/nZDiTS
	A2HZmiDm9DBLt6c3Rw7GDppcw6VFH8leEHOq4bXISCFCPdCK/bHDOgTsEkC/JAs+lQagqrO0tyMVB
	OmZhgR8uGQla8dt+aywDr1DO2WX/qNYNjjK8p3eGuNEEVzqD7OEGYE8ckZaaY1WLkyjR7RjkZDMJF
	sfKe+sIqnF8TPA21MxUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4Aeh-0004zk-5r; Tue, 18 Feb 2020 21:43:47 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4Aed-0004zF-Er
 for linux-nvme@lists.infradead.org; Tue, 18 Feb 2020 21:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582062234; x=1613598234;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=50a2gK2K6rtmg3STj0b45MeDZ1MVKGoBS08WyBeXgI8=;
 b=SABLYKwvXe8aeidyn2TT6S0cvcoxMLdN0lVJN5wmDnecOy80hTIUH6hS
 UqBMApefMDGst1Ym3lsy1T9AiHiOba/eLf9qA9MqWcAFL5SAPrGfEwbtD
 4Q8h1TxMnMxVzwEnFoWJaNnzHdzMsi4IzC9hsHKDOXxfBZCcTOTEZV6wr
 D5JDt2ezxnnMs8QUt8hXlpnpsm0707sZCOXWHmepLrnp/Y0tcAVqffTK7
 lR2OO2XqS5UlDoYgc/9SMPrFvIt+CYjCi0QLEjaDk5mE1mqqTMkcISitM
 Cd8bjOvyFRteLYJGRce/C9tam+d6Pk0oiZ45TNLGVgqlnaisvmniCm0wf g==;
IronPort-SDR: 07DEOzq83B68XH7ZR9AAdKvwK2PLYYMw9isHRBGanKTyQ9KmSy1QlDE9KAr2c4XrYg2yKH2dBs
 ZBMibL6ipZWR/XcHtCoC4uw/a/MWW7t2Gn6J1PtMDLPNys1Yacbgz0jTWHrvL9np/02vLezY6X
 /p3loUXaeRygc4z5RY6TsWDPfNKdpg3Duj5zR/f07KPkwZXeJnHFLyI7sQZNtjm7+QLlAHQvuS
 Ylf9l6DDspShD+cj5clPJyOXdaY018k+0hVLlCqajrKe06pQILIBFTZud0PrBM7dnQDvQNgvsB
 Mw8=
X-IronPort-AV: E=Sophos;i="5.70,458,1574092800"; d="scan'208";a="232000790"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 05:43:51 +0800
IronPort-SDR: Vi8Syikfm5IN7iNvuAeV1CnlAKB7eIceuVLPOAii3PXYvibz3dx3DgXIa61T8c8nU0tnYutK4u
 qu55RXI+J04W6b2DRWhnOsLDBjKFNuba9gpI0fYBCERAOkJq2nUpg2HL9NFVa7GUg6p29D2nsO
 Y1x9A9dqTM9cInrhEJ1DyT/OWa/k3BHEpn0xcoqfjYWMGsaWlQaeoYMZyi1I/w60bAGML2uEZj
 0a7D98Yxdi0DlbFUkK7Fcaq+cDh9aRWQMAzuxlRmmpOdMhCmjQ44CBa27Ie/VYfudJSLrCWV2S
 fqXONTWhR1tEkI7I43KXWK6I
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 13:36:19 -0800
IronPort-SDR: s8Ru7qT4xPmqQz8QtsQZhnMnNJ+cyAR1KRPPqKlmmEgKaWiyA5kP3/G3CT0BalXeZnRFH0xk8V
 EjkHXprqBnCnmm1NBvgP3WPIqsEwYNyOytcwx02MkTEaHqZHEGm5eu+2aDXXKLs2/tXBPgiCzX
 HI72Zrs1ZGilEH2u8PF+Ymf8To/3AHIdoRGQvwvhO6veCZayCPWwexoC4/dJfxP/CtPa85f0o/
 wLT41VqmZVo9RvDHxbW+ImQvVYZzz644fYp7wgMdVIaHwmih4RXFR2tI1LJI3YRJHnrYUs/iPv
 JtM=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2020 13:43:40 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/4] nvmet: add set feature based timestamp support
Date: Tue, 18 Feb 2020 13:43:34 -0800
Message-Id: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200218_134343_628215_972A22E2 
X-CRM114-Status: UNSURE (   8.34  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a small patch-series which implements set-feature based
controller timestamp feature support for NVMeOF Target controller.
This allows host to set the timestamp using set feature and read it
with get feature commands when controllers are distributed across
 different systems. We return the value set with a Set Features
command for the current value plus the elapsed time since being set.
NVMe [1].

Regards,
Chaitanya

[1] NVMExpress Revision 1.4 (Page 220) Set Timestamp Origin -> 001b.

Chaitanya Kulkarni (4):
  nvmet: use nvmet_feat_data_len consistently
  nvmet: add support for set-feat-timestamp cmd
  nvmet: add support for get-feat-timestamp cmd
  nvmet: update ctrl oncs values for timestamp

 drivers/nvme/target/admin-cmd.c | 47 +++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h     |  3 +++
 2 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

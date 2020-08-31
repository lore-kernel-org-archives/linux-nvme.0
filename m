Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E55C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E198C207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GmSihtRA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hmgKfND+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E198C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nDSUeZV4e2oG258hw3/LHqrS4yxIhZmOhdIyqa7a+/4=; b=GmSihtRANaljcnZZe71RT9oc/
	AHkmck13ybhwOIqEWfhyT/3un6Ptla26yafSXX+K2AxRS7jU3fbmHPpdpRPwxxBziD0xA/tjOvf/j
	Nz0kUOGWvsy+0SnhWji+UwC8MUAjj28fWCnzeYtYlivjpw4lncBcyyPt2j2kiWWmqIQfk/tVf622W
	+38GoSuaLPAN2ktCHLVnCdJYAb7PPArJXj8jAhhwHjzTYDs5uKno+UhjgOoIeRz+KkYJvruvEn6yU
	zKtOSunM5QrS2jJ4de7Gbqrk8cHtFXBID/ppTSDbmkCGyRPwfG6O04OscW3N03FBCIEk7M8ehoBrs
	KLB2MIOrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsGq-0005Qu-QZ; Mon, 31 Aug 2020 22:27:24 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsGm-0005PX-MU
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912841; x=1630448841;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fCZuKx8UPAzskCLMNjZMoXs+BFoKvbBq7cGKeaHpcIw=;
 b=hmgKfND+DWJgSyznhyLnh+QerxjXo6Qf7/pLb4ZFwaddcFsbplpqv65k
 B3YZbJPt3xVKc9zLe69Nk+Ub+Yy2KKmrYGwRq7HXzbppHjnlZaKq/Ntnp
 OD66V6iQ3AMFxzf4Gw4mwEkIc2RPLe4YfCww1bb7LRmBA9AX9V2UOLV8h
 J+kLatUoj30kJ0x30tOBHaj3MU+NTaNdWWeCPi9myzp8HdvIYUG2Jgr2h
 yILJLmroJBw5M7qcFjxeEmeUCmh1OZnB1LMN4qD2hIcQaOfEB8zREcDTc
 YneV/OwP5XdbkAbsDKRytx80sfkIuGm21zEOnmz6v1e7lmFqVxtBIuko/ Q==;
IronPort-SDR: B9rsdn4F9sNbmN82Bsh3sxA6dw02B6qRgLXsMR8zTnPSYNVJkX3MSSbwRk/N4j+hRZZD67zydP
 AuNxwGmHFW/LtYhnGzn5z4tIS6aNNKwlkYLRYbSsQQlUxD8rxfSRCtpf9L+Hs8deXc9Xg60xvE
 HnbEqZe9rvgdSZvhvgW0yZIyf71yoQTI4En/s5i1/vvfsaZs45Ij8lOZa7zL5bAPYyflX//43T
 5qG11XsjSte0xX8yGGFnTcnos8cVIvtSLqV6fa/Zjf7OeWy6hayFqupOQX4ULvz1RwIby5YHYH
 cOc=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="150600851"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:20 +0800
IronPort-SDR: rkpSo7+iTRnUhGOOp0iab3S6eOWa3abwXdKp3yla9mNTiOSVB3O+FMKFsMMSLIFEV5gmZlGFBj
 AiiyMlXPDG7Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:14:48 -0700
IronPort-SDR: V01dtw4JQ4a64OFd2JFolh7uTnEvlrEgQVwrc7693BxvKLIwt9oD+ZstcTu8p5kpYC3b8D3z/B
 ZpJ6hfwYB34A==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:19 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Date: Mon, 31 Aug 2020 15:26:56 -0700
Message-Id: <20200831222707.35611-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182720_923583_8B2B419E 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvme_alloc_request() is called from different context, The
only place where it uses non NVME_QID_ANY value is for fabrics connect
commands :-

nvme_submit_sync_cmd()		NVME_QID_ANY
nvme_features()			NVME_QID_ANY
nvme_sec_submit()		NVME_QID_ANY
nvmf_reg_read32()		NVME_QID_ANY
nvmf_reg_read64()		NVME_QID_ANY
nvmf_reg_write32()		NVME_QID_ANY
nvmf_connect_admin_queue()	NVME_QID_ANY
nvmf_connect_io_queue() 	QID
	__nvme_submit_sync_cmd()
		nvme_alloc_request()

nvme_submit_user_cmd()		NVME_QID_ANY
	nvme_alloc_request()
nvme_keep_alive()		NVME_QID_ANY
	nvme_alloc_request()
nvme_timeout()			NVME_QID_ANY
	nvme_alloc_request()
nvme_delete_queue()		NVME_QID_ANY
	nvme_alloc_request()
nvmet_passthru_execute_cmd()	NVME_QID_ANY
	nvme_alloc_request()

With passthru nvme_alloc_request now falls into the I/O fast path.
Annotate the case for block layer request allocation with likely and
error condition with unlikely.

The only case this annotation will break for fabrics connect commands
which are low frequency commands anyway.

This leads to following performance change in the passthru code :-

Bandwidth up (better) by 1.7 MB/s :-
-----------------------------------------------------------------------
* Average Bandwidth nvme-alloc-default: 272.10000 MB
* Average Bandwidth nvme-alloc-likely:  273.80000 MB

Latency down (better) by ~5 usec :-
-----------------------------------------------------------------------
* Average Latency util nvme-alloc-default: 917.90300 (usec)
* Average Latency util nvme-alloc-likely:  912.57100 (usec)

nvme-alloc-default.fio.10.log:read: IOPS=69.2k, BW=270MiB/s
nvme-alloc-default.fio.1.log: read: IOPS=69.6k, BW=272MiB/s
nvme-alloc-default.fio.2.log: read: IOPS=71.1k, BW=278MiB/s
nvme-alloc-default.fio.3.log: read: IOPS=70.8k, BW=276MiB/s
nvme-alloc-default.fio.4.log: read: IOPS=70.3k, BW=275MiB/s
nvme-alloc-default.fio.5.log: read: IOPS=69.8k, BW=273MiB/s
nvme-alloc-default.fio.6.log: read: IOPS=67.5k, BW=264MiB/s
nvme-alloc-default.fio.7.log: read: IOPS=67.0k, BW=266MiB/s
nvme-alloc-default.fio.8.log: read: IOPS=69.5k, BW=271MiB/s
nvme-alloc-default.fio.9.log: read: IOPS=70.7k, BW=276MiB/s

nvme-alloc-likely.fio.10.log: read: IOPS=69.5k, BW=272MiB/s
nvme-alloc-likely.fio.1.log:  read: IOPS=70.1k, BW=274MiB/s
nvme-alloc-likely.fio.2.log:  read: IOPS=68.4k, BW=267MiB/s
nvme-alloc-likely.fio.3.log:  read: IOPS=69.3k, BW=271MiB/s
nvme-alloc-likely.fio.4.log:  read: IOPS=69.9k, BW=273MiB/s
nvme-alloc-likely.fio.5.log:  read: IOPS=70.2k, BW=274MiB/s
nvme-alloc-likely.fio.6.log:  read: IOPS=71.6k, BW=280MiB/s
nvme-alloc-likely.fio.7.log:  read: IOPS=70.5k, BW=276MiB/s
nvme-alloc-likely.fio.8.log:  read: IOPS=70.6k, BW=276MiB/s
nvme-alloc-likely.fio.9.log:  read: IOPS=70.3k, BW=275MiB/s

nvme-alloc-default.fio.10.log:lat (usec): avg=924.12
nvme-alloc-default.fio.1.log: lat (usec): avg=917.80
nvme-alloc-default.fio.2.log: lat (usec): avg=898.58
nvme-alloc-default.fio.3.log: lat (usec): avg=903.38
nvme-alloc-default.fio.4.log: lat (usec): avg=908.74
nvme-alloc-default.fio.5.log: lat (usec): avg=915.63
nvme-alloc-default.fio.6.log: lat (usec): avg=946.41
nvme-alloc-default.fio.7.log: lat (usec): avg=940.14
nvme-alloc-default.fio.8.log: lat (usec): avg=920.30
nvme-alloc-default.fio.9.log: lat (usec): avg=903.93

nvme-alloc-likely.fio.10.log: lat (usec): avg=919.55
nvme-alloc-likely.fio.1.log:  lat (usec): avg=912.23
nvme-alloc-likely.fio.2.log:  lat (usec): avg=934.59
nvme-alloc-likely.fio.3.log:  lat (usec): avg=921.68
nvme-alloc-likely.fio.4.log:  lat (usec): avg=914.25
nvme-alloc-likely.fio.5.log:  lat (usec): avg=910.31
nvme-alloc-likely.fio.6.log:  lat (usec): avg=892.22
nvme-alloc-likely.fio.7.log:  lat (usec): avg=906.25
nvme-alloc-likely.fio.8.log:  lat (usec): avg=905.41
nvme-alloc-likely.fio.9.log:  lat (usec): avg=909.22

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5702a3843746..a62fdcbfd1cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -508,7 +508,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 	struct request *req;
 
-	if (qid == NVME_QID_ANY) {
+	if (unlikely(qid == NVME_QID_ANY)) {
 		req = blk_mq_alloc_request(q, op, flags);
 	} else {
 		req = blk_mq_alloc_request_hctx(q, op, flags,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

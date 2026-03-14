Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2044FD88ED
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Mar 2026 04:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6KMQ9q8x0tGp2S5SpTMXgzntnVmzvVzj4wESaVFZnqs=; b=BUquk3yAKooISUsK8p1NiZ5Gtl
	CuimUXnPoaKXlqTocGmRIh6dR8gwfACs1xzML8+FPiOn8a2XLi6RCNHmOD8ZwGfZ1ueD9bGkl4Xse
	WX3uDGkJqZkIiN+4A4qEPlaHJGzibe9zNaY2RgOG+NbIHJ9LNEE52vY7mfTeYenhqALwrilERj8If
	Gq2Nh2lSBOjXzBuSFLfWAWbLkMg8O/gpNTyQO2btDXE5OHoxf8p87SGWQcaSp0V9OH0CPH6ha8sII
	l+uS8yWYBq8giDDFthfw58gR+tGwafuN49qDfhnYZzVqT3hdowvVnri4B9L/AC3V7P/Z9oawtjXby
	Isc32okQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1GEj-00000001T0R-08Am;
	Sat, 14 Mar 2026 04:04:25 +0000
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1GEg-00000001T0D-2ygR;
	Sat, 14 Mar 2026 04:04:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp.h: drop kernel-doc comments, fix a few descriptions
Date: Fri, 13 Mar 2026 21:04:21 -0700
Message-ID: <20260314040421.1499586-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Expand @fei into @feil and @feih because the field was split due to it
not being 32-bit aligned.

Struct member @hdr was described twice in struct nvme_tcp_rsp_pdu, so
drop one of them.

These structs are defined in a spec outside of the kernel, so kernel-doc
comments for them aren't needed here as well.

This avoids kernel-doc warnings:

Warning: include/linux/nvme-tcp.h:95 struct member 'rsvd2' not described in 'nvme_tcp_icreq_pdu'
Warning: include/linux/nvme-tcp.h:113 struct member 'rsvd' not described in 'nvme_tcp_icresp_pdu'
Warning: include/linux/nvme-tcp.h:128 struct member 'feil' not described in 'nvme_tcp_term_pdu'
Warning: include/linux/nvme-tcp.h:128 struct member 'feiu' not described in 'nvme_tcp_term_pdu'
Warning: include/linux/nvme-tcp.h:128 struct member 'rsvd' not described in 'nvme_tcp_term_pdu'
Warning: include/linux/nvme-tcp.h:169 struct member 'rsvd' not described in 'nvme_tcp_r2t_pdu'
Warning: include/linux/nvme-tcp.h:187 struct member 'rsvd' not described in 'nvme_tcp_data_pdu'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: drop kernel-doc notation instead of making corrections since the
    format is defined external to the kernel

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org

 include/linux/nvme-tcp.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-next-20260313.orig/include/linux/nvme-tcp.h
+++ linux-next-20260313/include/linux/nvme-tcp.h
@@ -77,7 +77,7 @@ struct nvme_tcp_hdr {
 	__le32	plen;
 };
 
-/**
+/*
  * struct nvme_tcp_icreq_pdu - nvme tcp initialize connection request pdu
  *
  * @hdr:           pdu generic header
@@ -95,7 +95,7 @@ struct nvme_tcp_icreq_pdu {
 	__u8			rsvd2[112];
 };
 
-/**
+/*
  * struct nvme_tcp_icresp_pdu - nvme tcp initialize connection response pdu
  *
  * @hdr:           pdu common header
@@ -113,12 +113,13 @@ struct nvme_tcp_icresp_pdu {
 	__u8			rsvd[112];
 };
 
-/**
+/*
  * struct nvme_tcp_term_pdu - nvme tcp terminate connection pdu
  *
  * @hdr:           pdu common header
  * @fes:           fatal error status
- * @fei:           fatal error information
+ * @feil:          fatal error information (low 16 bits)
+ * @feih:          fatal error information (high 16 bits)
  */
 struct nvme_tcp_term_pdu {
 	struct nvme_tcp_hdr	hdr;
@@ -128,7 +129,7 @@ struct nvme_tcp_term_pdu {
 	__u8			rsvd[10];
 };
 
-/**
+/*
  * struct nvme_tcp_cmd_pdu - nvme tcp command capsule pdu
  *
  * @hdr:           pdu common header
@@ -139,10 +140,9 @@ struct nvme_tcp_cmd_pdu {
 	struct nvme_command	cmd;
 };
 
-/**
+/*
  * struct nvme_tcp_rsp_pdu - nvme tcp response capsule pdu
  *
- * @hdr:           pdu common header
  * @hdr:           nvme-tcp generic header
  * @cqe:           nvme completion queue entry
  */
@@ -151,7 +151,7 @@ struct nvme_tcp_rsp_pdu {
 	struct nvme_completion	cqe;
 };
 
-/**
+/*
  * struct nvme_tcp_r2t_pdu - nvme tcp ready-to-transfer pdu
  *
  * @hdr:           pdu common header
@@ -169,7 +169,7 @@ struct nvme_tcp_r2t_pdu {
 	__u8			rsvd[4];
 };
 
-/**
+/*
  * struct nvme_tcp_data_pdu - nvme tcp data pdu
  *
  * @hdr:           pdu common header


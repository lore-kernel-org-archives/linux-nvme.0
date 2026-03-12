Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4F4FED2D3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 05:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=41hpuznrs2nh1q8BDTALn/jjQSnWnP3ntxqZluz2tSg=; b=2F35Vsgd/n9SOsFupUKEJBE9IF
	3gO1Qvdqn7GeHygiO2/5WtPmFu6t10ntrN7cIEbe/m3jgWVXi10R0wMHHt7MV2ETk7jwBzsNH4Nh5
	BxUqmsiBYwTNgoxw0f9E2uarlRFyYwVCGeUCKgEob9PPX5irmR7jqt89lkcYATqfDHdNxgjTN95H/
	eHC3TOVFLQ2Hd9EX8RCJ8VsDiF4wTTrIZ/dMPr4R0kiFe4fKIqjrN38G/gBJaPIwKyPWkSgsIzF+9
	aaOmnEO9i7bTmCoHbmkMey0B1D4OfGeDXUoe1tMSEXrpcIFnXoo5S2Lv15Mx5HJvL9KMZvE/ggDW/
	kXniDwQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0YNV-0000000DLCm-2YpJ;
	Thu, 12 Mar 2026 05:14:33 +0000
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0YNT-0000000DLCM-3GNm;
	Thu, 12 Mar 2026 05:14:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp.h: correct kernel-doc comments
Date: Wed, 11 Mar 2026 22:14:31 -0700
Message-ID: <20260312051431.684352-1-rdunlap@infradead.org>
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

Mark reserved fields as "private:" so that kernel-doc comments are
not required for them.
Add comments for @feil and @feih since @fei was split into 2 fields
because @fei is not 4-byte aligned.
These changes eliminate all kernel-doc warnings in nvme-tcp.h.

Warning: include/linux/nvme-tcp.h:95 struct member 'rsvd2' not described
 in 'nvme_tcp_icreq_pdu'
Warning: include/linux/nvme-tcp.h:113 struct member 'rsvd' not described
 in 'nvme_tcp_icresp_pdu'
Warning: include/linux/nvme-tcp.h:128 struct member 'feil' not described
 in 'nvme_tcp_term_pdu'
Warning: include/linux/nvme-tcp.h:128 struct member 'feiu' not described
 in 'nvme_tcp_term_pdu'
Warning: include/linux/nvme-tcp.h:128 struct member 'rsvd' not described
 in 'nvme_tcp_term_pdu'
Warning: include/linux/nvme-tcp.h:131 struct member 'rsvd' not described
 in 'nvme_tcp_term_pdu'
Warning: include/linux/nvme-tcp.h:169 struct member 'rsvd' not described
 in 'nvme_tcp_r2t_pdu'
Warning: include/linux/nvme-tcp.h:187 struct member 'rsvd' not described
 in 'nvme_tcp_data_pdu'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org

 include/linux/nvme-tcp.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-next-20260311.orig/include/linux/nvme-tcp.h
+++ linux-next-20260311/include/linux/nvme-tcp.h
@@ -92,6 +92,7 @@ struct nvme_tcp_icreq_pdu {
 	__u8			hpda;
 	__u8			digest;
 	__le32			maxr2t;
+	/* private: */
 	__u8			rsvd2[112];
 };
 
@@ -110,6 +111,7 @@ struct nvme_tcp_icresp_pdu {
 	__u8			cpda;
 	__u8			digest;
 	__le32			maxdata;
+	/* private: */
 	__u8			rsvd[112];
 };
 
@@ -118,13 +120,15 @@ struct nvme_tcp_icresp_pdu {
  *
  * @hdr:           pdu common header
  * @fes:           fatal error status
- * @fei:           fatal error information
+ * @feil:          fatal error information (low 16 bits)
+ * @feiu:          fatal error information (high 16 bits)
  */
 struct nvme_tcp_term_pdu {
 	struct nvme_tcp_hdr	hdr;
 	__le16			fes;
 	__le16			feil;
 	__le16			feiu;
+	/* private: */
 	__u8			rsvd[10];
 };
 
@@ -166,6 +170,7 @@ struct nvme_tcp_r2t_pdu {
 	__u16			ttag;
 	__le32			r2t_offset;
 	__le32			r2t_length;
+	/* private: */
 	__u8			rsvd[4];
 };
 
@@ -184,6 +189,7 @@ struct nvme_tcp_data_pdu {
 	__u16			ttag;
 	__le32			data_offset;
 	__le32			data_length;
+	/* private: */
 	__u8			rsvd[4];
 };
 


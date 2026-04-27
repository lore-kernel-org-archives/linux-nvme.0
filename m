Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D41FF8850
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 00:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PEdEmw8SnfABd/rWzOBxUWDYykAsxQoh07nG6sNahOQ=; b=ERNO5RqmN156xl4x1qKNWdV5M0
	EjPYJq3u2g5RPWNUwQIh09nKLD/WTG7nMUL4DxWnTiYzcb3okHbrlOPaB/Vh1e8q/9fwfSCEjfuFJ
	e5PxrieM9jX9QRCl/5SEaj1eqpPbXesZHNF1lkYYppMY0GXGPhQZJbNi+4RG8DNPcIzQsLgj0TWr9
	YRIuY0Hv9XUJoUVYDpAWFTb8zkg+dPdnAG3auUA02QA9EOz3R6nxJEBHeeT5sG+OLw463905+Uhsj
	HMTePwpB+sW9L+xfir73NO7CBAmngwNLTSs3sARqy9sQpoWxuKyCy5iFKwP8wr1i/4ESgyIjN+mPx
	PnuHzH/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHA5O-0000000Fyp9-1JwB;
	Mon, 27 Apr 2026 00:44:30 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHA5M-0000000Fyon-3Rmb
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 00:44:29 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-8ef5776530bso584016185a.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Apr 2026 17:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777250667; x=1777855467; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEdEmw8SnfABd/rWzOBxUWDYykAsxQoh07nG6sNahOQ=;
        b=Z8+n6/kcmmCCGMtUSCGCTkbK0trJR9hXI3CInZtZkuUg67omUaNMiS69mK2ez9fEZr
         y3Dk+Qy+Ua7WtaX3zg8JBG21BbE7tvHEiBH7aZetDajawNFyJutII1JX2wFsQC0vkcIt
         f6AaZFRA2X4uTecVCAhh9Zia/3H06g9xJNb5TiT/qtKf7b0f2F7MlMAWZIBy8x4pvUDQ
         ka9UG9UPsMAWwimgMnZKD1ooZs5hqFGXsZRzxI2VvObTY3XKfd3Cp1Q+X305PoilPD5P
         rE55e7GaijLYocRhs5DBTtPctd5wRwzWB4mwc+stVOUQ605Bu/eaDO38rCgPwbIQOMI8
         Q+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777250667; x=1777855467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEdEmw8SnfABd/rWzOBxUWDYykAsxQoh07nG6sNahOQ=;
        b=TH6GF+x/etmo2TNqsSnHeaN19V91V+jFezIRXl3sy2pRP25DWc67Kki0LeMgawXDIq
         jvXSnNmST6Ea+591kH604PGum+dg8Niap0LonC1WZKIhLGbJifXSCQwPR5Xw7eDXMMj9
         IYrdsRKs3W/XmuHCQTu+s3PTWloXBMNjJvtc7U8u+6im989/mCY9p8YEwFOXawPC8G3v
         QgDi9o90XPwKxr3nAJ4A6lqvzGUltPTX3k9c51IXUI+5thfvpZ3Unam2zcyqzCkCdpi7
         9nnJUwn0q7CPM8oltxXIwqSFQlferaE5F3BxBlDo03XPIn2g+QoctGRq8hK15NdH2aU1
         R5vg==
X-Forwarded-Encrypted: i=1; AFNElJ9J1rGfauWjB4DNaUJZbEsYGhb4wztmkY4LoXmFbEC8uUVHFn+UwFHxpjbhRFjocsnliyeCaSKvOsmK@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6Pipf2jYMYuuzv20sd292EZXotsT49xZ6CtoJvnUr4ZRbqDJi
	1R30jxtSl0lMXAbuygMpCo09PrT7HzLQslmlRvDPBHrskrkG4iZh9XM1
X-Gm-Gg: AeBDiesIASHMcyyL1Nl8md9vLrdLDx9Qy7vljBjkpi2IAY9OdXU1ZhfvWiIMPKfISIq
	EhkPeOCd1Ro+GecgUc/ovsQkHrXE2UUY9xeu1rZwE01fLjGCuL73Wi5Qr/Gbp8phYUUmTKHvzdl
	MpnNUP/1mVfGEhQn19FTeNCcxzWPdbnIohK5YFFqeUgffkytOvTkPBOaFPvMhGS6mP7tKnUH823
	E5AOGL5TgHu8tf9tzlPAjl02nk5p3Uqv6PxLHTfDY8pf3p6NA73V+JrMRfhE9S6eWAcmkZM6xSv
	qeO3fjb9DW0Dr0vRfJskMwdDMKFdOShGE3ufK6Idw+WKSw/BynW/BURDM23RIn23xux2IBrT0xr
	DOkIVBFO99zWfzrqAx6AmSOMEZDU5Yva9TKRcC5arkP/9LW+puudtaExmdP7wWwh+i3zTfsz3Ul
	lMXELce+YS3+palJHGcGn9FIsZEevB2/6J3WbEve/xfryf8u9flSl2p9eU6PH2QBWphEXyEzr80
	Hg4RnZnBlvJipDfmaYD
X-Received: by 2002:a05:620a:17a2:b0:8ee:bae8:2bb9 with SMTP id af79cd13be357-8eebae830f2mr3334969785a.30.1777250667288;
        Sun, 26 Apr 2026 17:44:27 -0700 (PDT)
Received: from rc-szhan197-01.ad.syr.edu (its-crushnat.syr.edu. [128.230.103.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef47be2d91sm1533111385a.12.2026.04.26.17.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:44:26 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: hch@lst.de
Cc: mlombard@arkamax.eu,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	gregkh@linuxfoundation.org,
	security@kernel.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>
Subject: [PATCH v2] nvmet-tcp: set a default MDTS of 2 MiB for TCP transport
Date: Sun, 26 Apr 2026 20:44:06 -0400
Message-Id: <20260427004406.2971227-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409060835.GA6389@lst.de>
References: <20260409060835.GA6389@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260426_174428_870629_4CC58DA2 
X-CRM114-Status: GOOD (  11.52  )
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

Unlike other fabrics transports, the TCP target does not set a default
Maximum Data Transfer Size. With the configfs MDTS entry defaulting to 0
(no limit), a remote attacker can send a CapsuleCmd with an arbitrarily
large SGL length, causing sgl_alloc() in nvmet_tcp_map_data() to attempt
an excessive kernel allocation that triggers the OOM killer.

Set a default MDTS of 9 (2 MiB) for TCP. Admins can still adjust via
the configfs mdts attribute if needed.

Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a456dd2fd8bd..d09c81d07a1d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -25,6 +25,7 @@
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
 #define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
 #define NVMET_TCP_BACKLOG 128
+#define NVMET_TCP_DEF_MDTS		9 /* 2 MiB (2^(12+9)) */
 
 static int param_store_val(const char *str, int *val, int min, int max)
 {
@@ -2067,6 +2068,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	INIT_WORK(&port->accept_work, nvmet_tcp_accept_work);
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
+	if (nport->mdts < 0)
+		nport->mdts = NVMET_TCP_DEF_MDTS;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
 				IPPROTO_TCP, &port->sock);
-- 
2.34.1



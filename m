Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F831039895
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 20:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=; b=bfnyQ63LxXgPocq6QWcdC9MoTs
	TnCvZLadXjEbiDlCkiYngxYJH+Ruz4IlZfQhc6/A2aYFwBJiKqiaHLHIEh7Y4hInQVAPqXTu8nH3l
	7VDpMKu0VoJhTgd4MYRvtoyPXqsJbnWKSA0uQ7UDp5Vb+Bx+KRuNWOrhvPkJRSwIDB672jwqjaExI
	5dUTy9huz3PBsTJpHBZ6qPQJYRJYfdhLc5Tk1NZDUPLhxwkLNTxV8V4wnMNDGS+seFD0lUBzDN4j7
	cKG4FrOEqZlYEYL8iMSr1dS6ciGq9gzFK51RULD5jaZqUMl179JifhlA7lSyB2DR0soJvM6pOlLKo
	xrGWUvHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Na-000000096Q0-3gG7;
	Fri, 27 Feb 2026 20:24:06 +0000
Received: from mail-yx1-xb164.google.com ([2607:f8b0:4864:20::b164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4NX-000000096O8-05nj
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 20:24:04 +0000
Received: by mail-yx1-xb164.google.com with SMTP id 956f58d0204a3-64c7ec7e769so304983d50.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772223841; x=1772828641; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=;
        b=FsI/l6NJVMU08BrqKkrumRp1o57q8dkZImWiyfpPHmghTv2yjkw+KIDC2DMJmjXmYr
         wKXOMcEut3Xb3iBsnceUfNbjmV4umYFiSllJcX0OFE47O/5mn6xvZOY8/kpvHA6zfuVr
         KD+/Eeu+AjruyOr1/GoXvYw8rM3upwHipQFkoXNbrK/6iVWVb20ptRDw9Ve8+cYovG/d
         Anobbfdc+0yeCyUX+oHxegwctcIZhTQKfyg8hli+VrJHt52pw+sSazgSzY0oPrrEoCih
         Q9SHJcytI6x7u222WziGNT6pzG9cEzvm6hV40uiWvsIOQC/4GkyaUxszlKJRq2RGNEBi
         2G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223841; x=1772828641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=;
        b=mGQcUDe6/Jhxn9ym4ShHQ4WjlUaRLNCW9RSI4uuzZjZruo2xfP0pzRQlhuMXbtkg9c
         DN5RFVmQjo9vER6EN6NEsYNlz1esP5kCIMaqcGnrLIbVlxBJOtwlqTOSTEqsMSUCtDpg
         v0AhOsYrlkBeZKbM23b08+Ig8KdFocScn+TIjyvc2a5FPaLd1NIiJXIYdxIBISL5oEbR
         SPfiUjD9LUzdRctOF8qxmVM3XbELQPxBupfjEFpYCNQlplHar7JFU5QCtFCuN4sy0K8F
         YSqaS9WkzB5ASqXdrNzjoHSr61QF31Z58wleM33f9lc0S/7VB0KMkoeGQ6Ioj6LQaSWj
         7udw==
X-Gm-Message-State: AOJu0YxWCPrVcMf/JE0lO8acx0AnHBrT4Slbn4VEE1Gdzr3B+G5SF7Ih
	YKLLjj1A1YcD5AgT46h1wBxmzYoLAK+FInaGLh/kY7cb67B3ZQpCxya7+DO6CxVBSDYnU0mJnXA
	kF+9Zqo2ajxVuUqOfHIFPlltCzRCgYtLy15PVfCXfLaJd7O3FGN2X
X-Gm-Gg: ATEYQzzNNeAk25Y4khog03IwX4Ev6BzZSYvL9lL+Y4Ti1O9uF3WpknjrWJpF5e2qb+z
	+xIbRJ06q/HaqSvjXlYNVP+E6Klxed+CgVcZQH1q51JdGfnAf77t1AREoJUuIa3bBHksRUPgzgh
	2/1/iDC7abXpZwCGLmGz0l1PFvpTfKOB2D17SlHTaJcMn94p+0LNWMbpL9ZN4S0ygBfX3SScobC
	cUfKZVOkNW/IwkX0UoQzoxb5fdcpwpc8r7xsxOsgfO9TZKJKdEUNFus3uqDBLdB1EBv+JFPIHwr
	jaq1zErMOIyxUmu6KS5DG3DgMl131VuQ5rwDSJb2UjB4Qznz4XPXJXeVtThL5Io1Mp7v+11PMB3
	2Gdzern65t6IbWHCkl6pINLE2qx7YlIIACjJEbt8=
X-Received: by 2002:a53:ac9c:0:b0:649:bf2a:71d with SMTP id 956f58d0204a3-64cc22be974mr3069800d50.4.1772223841189;
        Fri, 27 Feb 2026 12:24:01 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64cb7590dccsm555012d50.5.2026.02.27.12.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:24:01 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 675413404A1;
	Fri, 27 Feb 2026 13:24:00 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 62661E420D8; Fri, 27 Feb 2026 13:24:00 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 1/8] nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
Date: Fri, 27 Feb 2026 13:23:46 -0700
Message-ID: <20260227202354.1012322-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227202354.1012322-1-csander@purestorage.com>
References: <20260227202354.1012322-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_122403_136681_1CC0D095 
X-CRM114-Status: GOOD (  12.70  )
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

A subsequent change will use the NPDGL and NPDAL fields of the NVM
Command Set Specific Identify Namespace structure, so add them (and the
handful of intervening fields) to struct nvme_id_ns_nvm. Add an
assertion that the size is still 4 KB.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..1134e6bf2d5c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -511,13 +511,20 @@ struct nvme_id_ctrl_zns {
 struct nvme_id_ns_nvm {
 	__le64	lbstm;
 	__u8	pic;
 	__u8	rsvd9[3];
 	__le32	elbaf[64];
-	__u8	rsvd268[3828];
+	__le32	npdgl;
+	__le32	nprg;
+	__le32	npra;
+	__le32	nors;
+	__le32	npdal;
+	__u8	rsvd288[3808];
 };
 
+static_assert(sizeof(struct nvme_id_ns_nvm) == 4096);
+
 enum {
 	NVME_ID_NS_NVM_STS_MASK		= 0x7f,
 	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
 	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
 	NVME_ID_NS_NVM_QPIF_SHIFT	= 9,
-- 
2.45.2



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F24C3600E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 20:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hLYdLYi0Kpc4+Nk8DSJMTWzWqA+/v9byHziOX03/Z28=; b=fNyolRAp30CR5FY6D1fA6IvtZF
	Zjs3bUWoaJtpU3hcZeqnCIwRdRo7LZiNfoAXWGXuO3RK6eJHWhYSGYv6pubM1dIqNncxYt5ernQJj
	hL5NFgl/T5jkP9MGcL92TdpXsV2j4bZe0HlVpsNhIlq3QK4p3pHkCbnV9Hux77uPbSyEt+fbMdv7v
	OQfGSdf4DzTUCVOm7KkdLXze5IE6EXZ3thHRKHx+yjIIVbCVrFNDhfSA+vbZPasLr1+b6qMUN71dj
	dIeqD8lI0t7Vqzdobr0eNdaIkmH5nkgfR7lSefz4pDuIQUXvWd21SqtzMF8l/gwj56fTJeQ4yhaob
	xHp6xNlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1two44-000000048tA-1Wja;
	Mon, 24 Mar 2025 20:06:28 +0000
Received: from mail-io1-xd62.google.com ([2607:f8b0:4864:20::d62])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1two3V-000000048mN-2tZL
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 20:05:54 +0000
Received: by mail-io1-xd62.google.com with SMTP id ca18e2360f4ac-85e4f91e3a7so4419539f.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742846752; x=1743451552; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLYdLYi0Kpc4+Nk8DSJMTWzWqA+/v9byHziOX03/Z28=;
        b=aTcRBfnyU36y+z7bY0L58mKlfvV44f4uyhjJxoowLnbtPpJOhiSpTLWAPCDYhHF0jE
         fIbwe4sN5Dgba4ipX0iD0fVm1eTCxhhjR0z6Ejf2pEZHfrN0lYneFevMXpGqG51OPog9
         LGGQx9cLY5fR4tu3vC6U+GhAp8DI0dih43GQSEYDPu3M30j55/76UqHAQamWCTXby+Oy
         s6/p4bVrVOAiiA+wZJIXr0ItzsNNV9FqoYJwxQyGkUtSpjdztNsLO7NFpvMNK4VhAIAU
         Z3OHmXUwkUM+qi1LyPTkl8MfayDaEOqZpx2jFs0wMPMpP9PD5xx2UDaPNH+9CG1SvsL1
         nGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846752; x=1743451552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLYdLYi0Kpc4+Nk8DSJMTWzWqA+/v9byHziOX03/Z28=;
        b=GyM/gAKhWQOgDoJcy2qEGs+g51Ldobhg/MY1QpXVvzcw69TAtd5rsjp6NyGtSdJW+k
         mQ4chWxngA/QSyA5lBXqNo2NI+ROPnd167h/16z0y01eQiyofMBYXKxwrpGLcvclylvJ
         vvJUO0PGlzB67k9uQvSiYjkkPRjS9dXwKs2hQrUp42I407EwfeRbUMy5yq6RKXZ1miJ6
         yYJ1jS6rDkMtdrKBfsggOLKsylNgCdM0mP4RPFAS/zD6mpk/OpFZOsWCUp+ewF5GI3H9
         qrhvkAV3TFY1QULuN5fkTBIzFeWuqWXukUF60v+cgsoebIjqqo+1OHfW5xDcImmFR2oa
         tX7g==
X-Forwarded-Encrypted: i=1; AJvYcCVQsQ5eEoHDOZktfQ4sODbvIVFAobpRmSCGw9+RLzxFmeqKFqyx4jbv/CjZcUFxr+iWGhH4dZVQqKlY@lists.infradead.org
X-Gm-Message-State: AOJu0YyTzotUWItkI+zg2LG48sZZqvkzO0bYt4laFfIg53rncqtVoYmw
	Fi1z8E/8l2fOTs/bwzeJMxFNvJrqWJJDU9VZZlOfj9iB9q+vUmGpvfyEQW7vosiOoDxRbMaCxdT
	nuPA2RmHHT/vC/27Lfxd+f4Dzh+hqaIpb
X-Gm-Gg: ASbGncszlq0/m2QjnzSdfD10NGIaYD96nmxc3mxUDMSfoBcefy9YfpGE1y3e8OGybgc
	pZpwjw/g35b5yHq+M3cVKlsN+74dPmZleScwlQk7wXYmXt0/NrZbhR4eXpFgVmuzSHU8f+12k7R
	xQ9Nbm/MndNIOXSHXn39BR0k5rt+V0R1ILRKoymWR9SYlouE6KI0LH4jjfiM5aI7iiSrpZA3xka
	6KBKI6YRNNfoc4EUxawOiMYcCdVLgfHLrF7tOLmQLJQ6m5nt5PdQXyf6lw1yfWDjncEK+NrfnJd
	/wE62kCTl1QpAxADcDXfptEE8RobYaLPXhdz9yy2aVIsMi1E
X-Google-Smtp-Source: AGHT+IG7NfVe7U+p88IpRxBam/nm1KKUWSAXa7Zk+pdMgEJimwgpeukdWWuZoB24s3/zM5KbGcgbaUc9bdSA
X-Received: by 2002:a05:6602:6926:b0:856:2a52:ea02 with SMTP id ca18e2360f4ac-85e2cd45a5amr332775139f.5.1742846751879;
        Mon, 24 Mar 2025 13:05:51 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f2cbe4032dsm371909173.27.2025.03.24.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:05:51 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 411AB340363;
	Mon, 24 Mar 2025 14:05:51 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3C6DBE40ADF; Mon, 24 Mar 2025 14:05:51 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 1/3] nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
Date: Mon, 24 Mar 2025 14:05:38 -0600
Message-ID: <20250324200540.910962-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250324200540.910962-1-csander@purestorage.com>
References: <20250324200540.910962-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_130553_775452_BCB55270 
X-CRM114-Status: GOOD (  13.82  )
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

The vectorized io_uring NVMe passthru opcodes don't yet support fixed
buffers. But since userspace can trigger this condition based on the
io_uring SQE parameters, it shouldn't cause a kernel warning.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 23fd22e55b76 ("nvme: wire up fixed buffer support for nvme passthrough")
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a35ff018da74..0634e24eac97 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -140,11 +140,11 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+		if (flags & NVME_IOCTL_VEC) {
 			ret = -EINVAL;
 			goto out;
 		}
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd,
-- 
2.45.2



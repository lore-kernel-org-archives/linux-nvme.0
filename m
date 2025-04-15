Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A76C369B2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 00:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FObC1FQoX7wcUW8DIX5C+4G4/pYkkiqq1+xi8wpD7gk=; b=JI/urS6KKnE+ICWib9kTje3AQX
	90KEU/apj9e7Bzv9EOkPLHT2EYRob9OdsyamQHJAeO4Y/eee7pZAim3f0zX3kazGZoOCEOJBQEDHr
	YxLf+/kjNWBfnJR4MXPy3n+lyGa9RNgfR1X7NgvJY8Z78/SmNU/1TLwW2l/OKxJfJAY3SmRQtTZFu
	Ir2vLhVnKRn/R3lhlnDyFkbk2xGCcDU0EPrWMCC5CMuPz4zchKecWJWTNMsPrSi0RL8ezzsPPVja/
	TII1VZFx/brkYX+exLOxpSOKDLoqwVhcekZy/eNYklRhP9xmuvX0637Nmno3Ldd7ABRXnJ+QWHWI7
	Wu/sLSFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4UHf-000000041jj-2Nap;
	Tue, 15 Apr 2025 00:36:15 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4UHd-000000041jO-1bpu
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 00:36:14 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-227aaa82fafso38939325ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 17:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744677372; x=1745282172; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FObC1FQoX7wcUW8DIX5C+4G4/pYkkiqq1+xi8wpD7gk=;
        b=PORbDTNCCEoBhL3f8ABLCCSJKTWoByGQ6NzyZBtZLn+OdbaHskX/UvJgj2fzRJH5kl
         MGFeAqnfhFTs2SUrf38Irb7V2Rge2RPtK9G7sOSZn0L0N3ANxbHGJ3EZDAm1IbZr80oe
         nXTgZxa5DEc4pVaJUc0pJoBrAWQCd4qYa1TMUFv0IHDfBu7YUuAuvOjgGFMlnfkmxYkr
         KVb3GsYDsQAUXUnNLUK5aDKg7NIjsza15oq1MIqP1SPhSfath18qdY9YQoZPZCBQYyQe
         9qIeVDVcACkJNwB8t91bg/H04OJDXVq21tgBDHEYm1dh0qvmuv060bStR3AicElrdaG/
         Exxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744677372; x=1745282172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FObC1FQoX7wcUW8DIX5C+4G4/pYkkiqq1+xi8wpD7gk=;
        b=A5M7ZjturkmlxhVI7T2Qo9v5G3AZf2IaVRM+H2TOkynt3AiqO20Fkeq7PJpTdL5HKZ
         sorPVTbQgbEm7/j+kxNkaxTCsTB+GKR/7GFfWE7Wd58dm7plLNN3j2DfdZSdZpfVexUH
         QHWMul4n/9dNX2qYBJ/fR4SVGmizh4r+b+jX4B6AdPM873d1vKZUTBCR/Qc+Lsaq4uMg
         aA597p43KOg2YCy82R/rsUpj01H9tj4MBqJ/iFcbcjHLVPnM8SzDQskvQKaDZG/a2TcM
         g8t2Yd44FUEAIJ/PbgvtD7l5TsOGoepECfTBMNKdfAxXRZ0NBnTzwk6iOynMeubdct/Z
         5AKA==
X-Gm-Message-State: AOJu0YwiVArSoFlRiACgCZh4RlxT2U2aohit1O4Ro2SmKXxa869zgMax
	Tl3ADcysvBuT6X9OGd2qdloM6QhInPA0VVEWAgH5FBDdZSxr6OqV
X-Gm-Gg: ASbGncs/hkaLD62c9GvK2ww52IE7tOpUr+DxpYkfKtNug9UApYH92whZiFkc2U2yg7S
	OreJyjMGlpuf+HRPVR6rLHALCdBDDX10ajAwWShtxUXaL66mweBfq2SqWQmgyBPYG46u6jnOPzW
	+ajcfMgQsj/N0yAu69gayJMmVXQ75yFAvlaaUiqMe3DLZBB37qyiBMXaXXoD+rhgB5VdjkF5Ehd
	/FHRvamY4gcKxOOieetmgs9sUdURLcLvecbBK2LUhz/bFsJytNU/ea1sLYPR2/RL+VGKkJ73TkT
	YMAppNN7PbUB8Iz2EVCZcEkTEEexpgQjkFoO0pJ/Rm1HRO7rbkjc/aS17ZrNYA==
X-Google-Smtp-Source: AGHT+IHo9LqK4Na+HLPhDXqQiD/oIy0QbEs94gYSuUXhtOzqo9jzw1vy7QEfFLmVyrvmb9ocol3/2Q==
X-Received: by 2002:a17:902:db0b:b0:224:1eab:97b2 with SMTP id d9443c01a7336-22bea4fe110mr196569255ad.53.1744677371792;
        Mon, 14 Apr 2025 17:36:11 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:6591:e5b9:9bcc:87c7:66b0:4484])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c97233sm105464445ad.109.2025.04.14.17.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 17:36:11 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kevinpaul468@gmail.com
Subject: [PATCH] nvme: Removing deprecated strncpy()
Date: Tue, 15 Apr 2025 06:05:51 +0530
Message-Id: <20250415003551.22949-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_173613_423408_7552E49E 
X-CRM114-Status: GOOD (  11.70  )
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

This patch suggests the replacement of strncpy with strscpy
as per Documentation/process/deprecated.
The strncpy() fails to guarantee NULL termination,
The function adds zero pads which isn't really convenient for short strings
as it may cause performance issues.

strscpy() is a preferred replacement because
it overcomes the limitations of strncpy mentioned above.

Compile Tested

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 drivers/nvme/target/discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index df7207640506..c06f3e04296c 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -119,7 +119,7 @@ static void nvmet_format_discovery_entry(struct nvmf_disc_rsp_page_hdr *hdr,
 	memcpy(e->trsvcid, port->disc_addr.trsvcid, NVMF_TRSVCID_SIZE);
 	memcpy(e->traddr, traddr, NVMF_TRADDR_SIZE);
 	memcpy(e->tsas.common, port->disc_addr.tsas.common, NVMF_TSAS_SIZE);
-	strncpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
+	strscpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
 }
 
 /*
-- 
2.39.5



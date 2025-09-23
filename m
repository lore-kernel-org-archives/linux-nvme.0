Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954D5CAC5AC
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3IKH7wDqw/hTFy7W7zq+0djPj1ZwecQEHG9Vmaw8v48=; b=e1WvE+5kcjIDUihAHNgV0O3rsz
	keJI7qBDgBzO78+tOs739z/F8zGQKLFB+h+pK7saBjzLklPEU7aESR3P2emO7DYtZEgDAqQifYTKq
	hpFoba/Ka5NsKzUnrqSOn3UZi+RflEyDs9o2gNUQSPbWY3wO6LhAgoE3GwiF9ep7ctzKOuBh3QpIc
	t8qL0zKKilwt/80yWqw7ZkghL9PExL1iqdc5DVBuRiBYOrKagk2f4eV8XiRLR1GtX4nsGU7eoKHYN
	uDQkt1YfxbHmNimnXDztwoHeobCiwt7CAEzUrd4IUZ0pyOyX54pMG5rY4OANnlIkUsOrhsojkLuyS
	pe85+04g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v156n-0000000E6Ef-18N1;
	Tue, 23 Sep 2025 15:39:13 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v156l-0000000E6Dp-16RR
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 15:39:12 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-77f35113821so2134517b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 23 Sep 2025 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758641950; x=1759246750; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IKH7wDqw/hTFy7W7zq+0djPj1ZwecQEHG9Vmaw8v48=;
        b=e1Mp8yCzFz/im7VNBzVjcUDvtpX15clVMnQVdcL/YUSzPxuoxsbxtAbdFyohtnmxxY
         VeMTbmwUUMhNj8XPcnoy2PbtRQajxDUomEIxo1y0CUgTJr8JbXETTtcVZ+dZGxSzPTgJ
         +cUZxHDO3AWpkkJnAu1ADyLXJoIXAQoaO+X0JdDQxG/V39ZcmmuuIWmVUzf2iynRQo9J
         V+KiSp8URbni7ePGl1MkwFZ8+Qe95LrYKLaA3Xlf/5LeRglYc533u8LYWCE+OOW29YjL
         iZkr70gHNwfD3H1JPhmtni90//LswZIWeWgYU4IYYZqSqPo4dPGzvC/rjvtKkkEoIQK/
         k63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641950; x=1759246750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IKH7wDqw/hTFy7W7zq+0djPj1ZwecQEHG9Vmaw8v48=;
        b=bteAeanxMjdMhkRQ5G3+TDikx1BGQzcUdKrfsfFhAHHl9DxqOX8bGQBW2xRd/ZIiNe
         cmGreT6yeHJLXIvoMg23IjSpDHl8vMvOfdapQf+qAJQ1z4xw7hPqtAWmtCBoH9NFTsnG
         5mBGcfpTdy6ypjuUHUR1BGKiTx4Sb9dZzF5735po/E9tJDT5BGRm6b9Ypr9JdkIjRkAP
         Er0WjnYRPRln4YkkJFiacz8N6J7cvj+pfBlXZcFVRDOODwsH88s5lDLU0P+7jmGs11UR
         Vi2JJds3GfAuIt2Q0Prinjvhs7flD4IpkK+sMu+qaA4lDT6faxgNaAptGqp4fTvC79HQ
         13vg==
X-Forwarded-Encrypted: i=1; AJvYcCWg336nQkpv858Vii9eyxVpAWgUPeMHpQH02tZIA7SVysVektcahKK290aBovA/pAhqcPWBHEizYcwH@lists.infradead.org
X-Gm-Message-State: AOJu0YxCKpHOlT78UaF6KU4AG1QaSkwvlgaY2Lxrm7/VNkpOwo0xeM3C
	X/RfCKbnDWUfnrF6GBrTpR/jwhJyvYnhDcXcnDQpaHNL7TDmykIbND5p
X-Gm-Gg: ASbGncvrcKaWzgcEl3PJabDYTbXSkm09cZ/yyIbDNZKXqbQvsyaF9KjtyJS85wiw28A
	nBtT08Jv6B+vMqKKuT296uAuqlHt9GSB41bqJdXCQ5+Q5TVNB274DuY7+QUO2hHzlDZGe3bsKiP
	Q3Q4ZcuOn9f3YxYizdKkbOHpNc/1Rb/57o6spJcuUfULIk1m6j8//3+Rbb/vPi5UPYuU8oieEjO
	mHAjQ9xmysaQT73MtB7sdHfriMLDiZyQXpGh70LycIIbytzvaIRjOk86wNUF4F6R3gXi7ToJQeW
	kSTfOwFs+aqs6AEu3uIFzdt56EImYWKmtWnLGFDq7lxpzdgTjjXVPSOb8ZHqk80r5o+Cm4kF8u0
	1hID6PHKb6X7JgOpN5j6vV4mKjolx9oRZO76agzYIMiwk/+jsk7iXaCVXjF0/
X-Google-Smtp-Source: AGHT+IEZo9qSBbfn/Xml4KJtCvUFlULxBDpKYDPazomaYoVMFRKhE6qkj0BzJtkmIiVQastE6+DAtQ==
X-Received: by 2002:a05:6a20:a11a:b0:24d:598d:2171 with SMTP id adf61e73a8af0-2cfefac3edbmr4798271637.51.1758641949959;
        Tue, 23 Sep 2025 08:39:09 -0700 (PDT)
Received: from localhost.localdomain ([23.164.40.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2f02c0d7sm7536909b3a.93.2025.09.23.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:39:09 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: James Smart <jsmart2021@gmail.com>
Subject: [PATCH] MAINTAINERS: update FC element owners
Date: Tue, 23 Sep 2025 08:38:57 -0700
Message-Id: <20250923153857.100616-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_083911_301148_ACEC2A96 
X-CRM114-Status: GOOD (  10.53  )
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

I'm relinquishing my maintainer position on the different FC elements.
I am updating them to the Emulex folk that have been watching over them
for a while.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 MAINTAINERS | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..a20ec47e42ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8977,7 +8977,6 @@ F:	drivers/infiniband/hw/ocrdma/
 F:	include/uapi/rdma/ocrdma-abi.h
 
 EMULEX/BROADCOM EFCT FC/FCOE SCSI TARGET DRIVER
-M:	James Smart <james.smart@broadcom.com>
 M:	Ram Vegesna <ram.vegesna@broadcom.com>
 L:	linux-scsi@vger.kernel.org
 L:	target-devel@vger.kernel.org
@@ -8986,8 +8985,8 @@ W:	http://www.broadcom.com
 F:	drivers/scsi/elx/
 
 EMULEX/BROADCOM LPFC FC/FCOE SCSI DRIVER
-M:	James Smart <james.smart@broadcom.com>
-M:	Dick Kennedy <dick.kennedy@broadcom.com>
+M:	Justin Tee <justin.tee@broadcom.com>
+M:	Paul Ely <paul.ely@broadcom.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 W:	http://www.broadcom.com
@@ -18129,7 +18128,9 @@ F:	drivers/nvme/target/fabrics-cmd-auth.c
 F:	include/linux/nvme-auth.h
 
 NVM EXPRESS FC TRANSPORT DRIVERS
-M:	James Smart <james.smart@broadcom.com>
+M:	Justin Tee <justin.tee@broadcom.com>
+M:	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>
+M:	Paul Ely <paul.ely@broadcom.com>
 L:	linux-nvme@lists.infradead.org
 S:	Supported
 F:	drivers/nvme/host/fc.c
-- 
2.35.3



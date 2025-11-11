Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCE7CCFA1E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 23:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2p/KFseTdJU5ECuFMZAqhWIeUsRS2HXtdTI456/K37s=; b=qVTc5A3+ruidVEnr4B6BdBtP3r
	tvh/4lX1PCJFlIcEvktS1DZbEMtb85PAUFXPnUj9N7MK9MfT2VGL0W4u3PLbJP0K1IIRn/mcYtOpv
	y+AhXe6DcEd9sKwKLdzSTDawmuerg3aoyhU/QkOAvr98PNgDipY+Z2Bng3e2jJ0BTUtdzsBhD4S4X
	Budvg8n2HIFzQcKqJpvroPIdUXv3JNvnhF+N4X0r2gIWxTSpAy61ZLmZ/WTr94S3CsRhRlYzwt6Yb
	37ywSJ0q2DCKGJctgf19E9gLbCRNNq+lGuj6wesnaORttjBPXflIYPrcNH/zhhpIcgDK4/Xgh9gUy
	ubL2S01w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3c-00000007tT9-0PuU;
	Tue, 11 Nov 2025 23:45:52 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3Y-00000007tRO-0toj
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 23:45:50 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso188643b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 15:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904747; x=1763509547; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p/KFseTdJU5ECuFMZAqhWIeUsRS2HXtdTI456/K37s=;
        b=EvKXF5yeKS68vhC3asvGLuy7fLpwbWARpDkTXnxvqmY2wT+A6HTE1HmPYFiX0stXYJ
         ozmTef31lWIHXhjdewNDj7JnkncncHvvGmELr3ExYEs4ZLZbOPkDF7oQ7NDmwSMNfl6p
         h7bs7vXo2pxDDLkMc6iiZQGUXJEfW150FhDoR4dzsMSZszXIgtmBmE/cSr8+k9oqghn1
         VhpcfHETkRAGKxhzLq4hXOkfVHUa+suErTZUD4JTOGUrYizXqf9xOVtTuVm3K/gD84mY
         wRwNMH2ulO+UMh4nWXintTem55xuhyVr5XHYy4G39Z/Bz/ozoUeE9FlTawfucg0Typny
         eRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904747; x=1763509547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2p/KFseTdJU5ECuFMZAqhWIeUsRS2HXtdTI456/K37s=;
        b=gqKIHllpQbL/9YPmO1QU7Jrzu8yAMQ87kJ8ff2rADl291WWgP7BR/BfX3vYqtuhSKA
         dPYo7ctylgFca/2HhFGzFMkTG4wuUcNSb5q23up+70UcL0OU489pcQtTufGUxZogP+cJ
         RzZkvGXMWMds88wMTLdbbRQOnKHJ9oWbIvGRIdDs0SlwRlzYs/yjsh2RuoItHTnDuhqi
         kjhI60QXfVQK5ZHigSvGs8zgkmRmuIkw9bMYSoJjRAuEp6NjHfmxjkynkzilpZu2RP7N
         m6YfouA6SGnCp9Mf1i3A3dadgPOT9nO5/Ehy01EhldBosSvHAr/gSrkJ9clzjiDxeS9g
         PVxA==
X-Forwarded-Encrypted: i=1; AJvYcCWlxfmCcAvPkot31bSR4PtWImvYSHR5GGg1TxyLh/sXwa+lJhgGSozxz0UdOntRXJAHR3V9a9Z1l3zI@lists.infradead.org
X-Gm-Message-State: AOJu0YxC17kVmDQA5EpIbEw8+s3tXEoizmY9dsA72j75d6n6AtqUOtJz
	NfcwyT6Sy9xlzpBmDRVPOzq1SJXJINyQOu3+G8le6kNGJzuNkVtQpcsE
X-Gm-Gg: ASbGncujnwbfWqjaNrVBa4pR1qef1n4zIZyDYYmBqoCkIXwuKlWGnE+ggg2QeDrku7I
	mJMnUmakrgeYg6m/Wx44kPVikEz67bH1vv+YJ/qgnuAR4/ymGezjqhjp0CJFQeXcNGrlc/jn5+Z
	6NE7sSDP/NST2XUG8c5g5vMh83mKLPtUqxddTbh6xBF79TO2DLPMKWla98S6aZZ8O3WFCquJLWc
	dznyNxqgw9i3KdXX4psgNXEmZAVpznkJY5HeFCVUSVXS2leFxjYFYQxZYFntupaQSnc1OhYL9qd
	S+yFksivFmeycXmrgqNuGwUmG7BHfTJACL2OnGI4gPKGbUJW9O4HZf3WHDfZH5jlkQVn2zbrPoB
	rsy/CiapgqFF2OCZ8FQYNvzm5mmcUrkrR9+D6E6b74JU5VIsm1w0bp/et+oA0HkVUO0YNuJWprm
	NVGM7I4BDhw0f6ck7IQ+iWn9nbX+epBHV7VqHq9D4m19qNENYGSYjdmWYCdbUt+Byj8Gj+BLBAS
	G3QYh4pFQ==
X-Google-Smtp-Source: AGHT+IGide8hXCD+w4MdYBu886ZJbHoVxf5DzgOfAgFI6oOpn42bAU+zf1YX89Y9X9vGZEY4lGi5DA==
X-Received: by 2002:a05:6a20:7343:b0:33e:84f7:94f9 with SMTP id adf61e73a8af0-359090964cemr920215637.9.1762904747615;
        Tue, 11 Nov 2025 15:45:47 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:47 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for secure concat connections
Date: Wed, 12 Nov 2025 09:45:17 +1000
Message-ID: <20251111234519.3467440-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111234519.3467440-1-alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_154548_254676_CAB1442C 
X-CRM114-Status: GOOD (  11.08  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - New patch

 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..6d10e12136d0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
 	    !ctrl->opts->tls && !ctrl->opts->concat)
 		return 0;
 	if (a == &dev_attr_tls_configured_key.attr &&
-	    (!ctrl->opts->tls_key || ctrl->opts->concat))
+	    !ctrl->opts->concat)
 		return 0;
 	if (a == &dev_attr_tls_keyring.attr &&
 	    !ctrl->opts->keyring)
-- 
2.51.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63FCCE8D6B
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZfcsfKcv/BP7tqClGVimV0mOVKurM0RlBCGupkv+8Gk=; b=oV4vgml8mgCKGhDQaiK6TpeAvv
	s4oAYhc8hkPQDRRs/QexxbCaqs9wtcyBDhxgjrnUX95JBND1zsrVIt4hHFQyw9/BqYOtRFQlg7xxc
	87cTXh2RK2yhkYaxr4QqwhCWoZVEbUhD+x//uz4SyMukxMjkvdGFQBPquJb/aO4rQhUffhQoPT05x
	tza7ww5QIQXGY5v02b9MgyflbZZ/CYO/JULBzcFHLjWRV/YyOOdaTIHEuL24jgiq+foseOen4jABx
	Ij1KED0OYU/+75xLiFB+hV0J7fcZEleERaV1B8YRhRTAfxLv4XnsxqFRNZXOmvBVmpfhcM2qJGKop
	MHejOdoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL3iG-0000000GbUw-1cep;
	Mon, 17 Nov 2025 18:12:28 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL3iD-0000000GbUV-40pZ
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 18:12:27 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so5614574b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403145; x=1764007945; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfcsfKcv/BP7tqClGVimV0mOVKurM0RlBCGupkv+8Gk=;
        b=NglCBhs+x0MYJQILM395S9ht/x4cm1+Vjh3LFEEdDWdhf1m8wnt+nDlh4gops5afnV
         Oieq5aVXI7KA0vEU+qwm5YmFABU2hmW0RFytsdzMYTFApGOEhouKOFvbmeSf6i22poDO
         jdujM0OAJRNZg1tTXB2A+0aCtPIsnJjnl+HERimU6B1xVw5oqYjh2CpVrmZerqA7oa/U
         /x0sBv70zcuSSIQMiH7ck1nph+l/BfiZ7kHYVVW01ywLo8ZgVrrf328oQLE3lT4TPg99
         1DN5Uh0g46ImXlDwrAl7gfqR8IAMv2g/lwj/rHuBuMTt6OJxUOEFRiItCdaM1SYcYT++
         9Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403145; x=1764007945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfcsfKcv/BP7tqClGVimV0mOVKurM0RlBCGupkv+8Gk=;
        b=wJpnaezj0eeyXeo0DpJS05N8CnvVNP+s59St9XtPq17n6v3B9Rq+LRnqe6Ctn6LJMB
         8utM33JQC8WIDtvGh2q3u/SlpFlDVNJlTZDfqdYSXH7EQlFrHZxveRZm11WL+aVhBuly
         tOC7ci6nf1BokZQZXxmvqBTs5yRpy0YLlkVp1fGy2+uBRltvmoEf3HyomAkf89HYkDof
         gS6/eMaUqym1KhbUqi0WFELAuzRciyADaQSmRaWzY7xtgVR45mCWpuaSKBQElCh1V8Uv
         PlXFbnS0MR1RXCQc3PFTGWLyO9Y22rT9SXl18DhmHuzB2IHaSSUBU9uW7PeMTJ+H3ehL
         xWgA==
X-Gm-Message-State: AOJu0YwluI/p31sOOvvbJaw4MP/CZWeXdkZW4/sn7dvF0Fb7BbzKV4WO
	9HNleqJ10VBCiW/mFH9tZyLdRk8RfT8OGW4uUifBdu7x3Ce8Gbi0ABv6c26dT13C
X-Gm-Gg: ASbGncsZjaq7JXKVv+lSVf0X0jy7n8yCC6HwNa+RU0nILIIw3CAwbjjqLMn7PsroyOr
	ZlvW3fnQyubK1Z/hQVepSvxe72xah5dl1tvPiMBIF/RIg2SUlK8PmVp9OQfZJ1TkEqW98FWCjoQ
	oLb8as2es3lAk+Pc5VhIvkfIzA3zjGmnxALVnnycbdnij5Exds1hscb4/SqFyp0gJS4iPklbisK
	zJHPhH7zx9z4FyDuwsdy9HO4foXz8hCS/O2C5JCqhsHMLT04Mmckw+eayCbDXnrkM9/Y+Q2/NBW
	oaJt4Q7NHvBmwjnHHkIsjjUZQsWx60o7hhJ5clqLoxN+cjriw/ZBh6VtZZgIXEyYd1owCETwEuO
	x6owDjlJJ9NJytcjIJCuqZ37hCRL9SRLz6PLpCq6sCLHX8ZdjobLsLM2xWpR3dCmxSfPg6gulJM
	CwIl8Z3BEv/nAZOTgJV05Jk6H3TYEBiOMi3VgqvIDa0iOmOlm/CwFYR5qhcXK020RJeCd8AMxHU
	rQXPS8X1JatkRD0vs5q
X-Google-Smtp-Source: AGHT+IHpTuvGJYLOUO2ZWin4A8dTZjs9rm9P6OGmQeUB7EQVJ3WpuDHrUNwlJ555cdwI1pdBEVozWw==
X-Received: by 2002:a05:7022:6990:b0:11b:78e6:8323 with SMTP id a92af1059eb24-11b78e684admr5002172c88.37.1763403144217;
        Mon, 17 Nov 2025 10:12:24 -0800 (PST)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885e3sm49942351c88.0.2025.11.17.10.12.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 10:12:23 -0800 (PST)
From: Justin Tee <justintee8345@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jsmart2021@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>,
	Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/1] nvme-fabrics: add ENOKEY to no retry criteria for authentication failures
Date: Mon, 17 Nov 2025 10:43:43 -0800
Message-Id: <20251117184343.97605-1-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_101225_995695_B20F4016 
X-CRM114-Status: GOOD (  12.99  )
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

With authentication, in addition to EKEYREJECTED there is also no point in
retrying reconnects when status is ENOKEY.  Thus, add -ENOKEY as another
criteria to determine when to stop retries.

Cc: Daniel Wagner <wagi@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Closes: https://lore.kernel.org/linux-nvme/20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org/
Signed-off-by: Justin Tee <justintee8345@gmail.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3d4d6d8e88c4..fb7765bf0cdf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -594,7 +594,7 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl, int status)
 	if (status > 0 && (status & NVME_STATUS_DNR))
 		return false;
 
-	if (status == -EKEYREJECTED)
+	if (status == -EKEYREJECTED || status == -ENOKEY)
 		return false;
 
 	if (ctrl->opts->max_reconnects == -1 ||
-- 
2.38.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE18CFD376
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=; b=n7pT6XGgO0HFm/6YSTuVaOwL9B
	OOWAGjq478zqzJgzppuv+XU2pHX/MWualDmDV5jTFaMwG93+2AZ8D6ECxvNlp1kl7C6X2YjIB1i6n
	XQFbY+4YJ1ckljN71z6apBVdX1pXg2IP5OmDruiiX9g2x0hDSgvG8PJDRptMVOFIpxr8JP6gIFcLZ
	JRVb1dWm/FzE7pVk4TFB+JnMhyy3fDectrkmtuHQRfAgtxjv50L+IB2HRq28/x2P+4m+A0t1c+KHl
	H5h+KVgAX4jon85m9GH1WmV5ahrtDkLgMrCMo+NxiY9wuIDw9TQhbPsHg0U6gQTbWP64UIc+ATqcI
	ECJfeoeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtut-000000009d7-0Ppj;
	Fri, 28 Nov 2025 08:33:23 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtup-000000009aj-2Kkh
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:33:22 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1389488b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318799; x=1764923599; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=hNQaz97G+JazNYeVm3ly+iGjDR6+BA4SUZINuWYf/ZxUS2X7O1amNw4jBgakEJgTN7
         MclwUyHYC3V9Bw0/pcZexrEquieeCNmtMlztcko1WgrfPkuBaJzP/8tk5WamxmyH7iEV
         wJ4skK3ryViCKadgFXTMe5YKHDqOO2p/N1Usz9Tk6CcoMnOfRZStr1XNmORZfr5CRqgW
         pN+UNNEjGhx8iDBZ5mprecOo7ZPXgLVvlWuAPKYTkBCAf+6K1KkSR0wYkK71Olq5W1ra
         6NPDfNZmzHZbdN6d5aIlFnuoHZyiW8OIAHsydVf5OfaSyiw26KGuEo/edcF/iIYoFcZR
         2MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318799; x=1764923599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=lYDzJtkQ8R0qbC3DqVTxzlavH577M4RcB+5R5Cxk6fGSRPPeVF6sjv76lvc7teg6Q1
         WMuV/6qSLLSuuGYaCuNUFPy7juKZo6H5aHEluGImrLyiwiNiKGDHhk6hXMLeCUQ4WyMM
         h+gFZakQEE58uMOIR6Z98p4g7gk6rJjb8WV3axbFr/6ewx928xsffeqZc7Nru3ru4dB4
         952kxpcG+DG+0Llrwzljf3ffmoLCpDeeXlH7fU8Twmk4duy0qyytxD6uDyZuVEE3bV4q
         BXIZci2s6nTW7Eheiyoih+RPU7p6PHfS6kvp4CRjxfwn9lTJA/qGvGtE+M7nEMJzmrhQ
         D59g==
X-Forwarded-Encrypted: i=1; AJvYcCUbPiA+v15gf/45fkIM3TuKnxJboHTN9Hz1YxBkkjKMce3o+g0+mJJV0FDxv3/MufOmOSMgY5Uhwx+j@lists.infradead.org
X-Gm-Message-State: AOJu0Yzce2XSaXyzl3m0sFvjK65gHCNhxe+lLkrrgb444O7wntq4oxEW
	2MN8GI010YvfF1pKYsZHAv1fSQjluLEzk+nk7DGr4y9Tre1d1K7RlKxJ
X-Gm-Gg: ASbGncv981ejZEequXJW8oKLvIepl5DzcvDUuK8mvvm+693bGQIvuQnTooChbcg39mn
	wnWhJVZqK2K4XUf8tpt6iw0g78EVLUHqgJPzk7S4ZljRxpW+sOxIFNPWPHVtm/5TXbdGz1F1oWt
	Z4+exHMkNgGmQOoACwXlxPrEzCUPRITWNxXGNsZnXUkScH41lYGNXVmSkXA4OAfPJuO+E2rIr9o
	8ZDKR/t5NTiW75aSY6AXo4ujZPf3lIWqGXBVwggcdbq1wMKsQYdqltORfXcX7RSU/gnbE3anXY+
	UgSGkrIFh8ANCEX607L+5y/032Rrafzzv/v7178kpO5f3+iGjLaweb3m/sXWsGXlzqmieuUxki/
	ZpJs7AEzfA8xirDwmyWbb7jFfE7CGMhJdf2TowefjatVF/iHPYhPTewM2AvOafBwyqskPT6DD4Y
	v7el9odsJc6AOjFIovnCj2X7arLg==
X-Google-Smtp-Source: AGHT+IHKXq8x9elSCjEHks4N7hQUevj8WxDVP5HKi9llAEtlIQFfHNb05BLq+B1Nz6uA8fi9DHZiww==
X-Received: by 2002:a05:7022:671f:b0:119:e56b:91f2 with SMTP id a92af1059eb24-11c9d870411mr17436186c88.35.1764318798796;
        Fri, 28 Nov 2025 00:33:18 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:18 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 08/12] block: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:15 +0800
Message-Id: <20251128083219.2332407-9-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003319_605021_AAFDAF1C 
X-CRM114-Status: UNSURE (   9.52  )
X-CRM114-Notice: Please train this message.
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

From: Shida Zhang <zhangshida@kylinos.cn>

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/squashfs/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index a05e3793f93..5818e473255 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -126,8 +126,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 			if (bio) {
 				bio_trim(bio, start_idx * PAGE_SECTORS,
 					 (end_idx - start_idx) * PAGE_SECTORS);
-				bio_chain(bio, new);
-				submit_bio(bio);
+				bio_chain_and_submit(bio, new);
 			}
 
 			bio = new;
-- 
2.34.1



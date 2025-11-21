Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50036CFA747
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXggH0+b8/rP3aYBPWiHo2+gkYlGyUfzMd+zPzEVv4o=; b=gStTDK3wlBAR109aX2AdVLr1xE
	CZzA5vJNlZ2GTy33jOHAfO2mmVMuErhCCJ44x/ZHpdCfODC9j6sgyjhVLnAtpRh6/Lx7mhln4E4A4
	5gHJOr1/3VxuiCSe0kmlqbZpYNHbK+LuFdP9G3Hjtuh7YxNNscqOx8m05fMCOSScDyE2z0a91bv63
	ixe5vnbQNd68KPaIFuCHTeRicNSB9uNWLfygU1H+xVdZD0IM8kgyCSNTOFnA491m+7ZjQ0WADjoc/
	cENLsc9CvEw9KeaATGGsfKaFoAlOBNTe+CzMMYfUEZ6jDi2hJo3ShSvszo3xU4IWCr0YhUOg1Bgee
	PHTCP8IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLX-000000082Du-3782;
	Fri, 21 Nov 2025 08:18:23 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLW-000000082Cc-1ZpO
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:23 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-11beb0a7bd6so2461978c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713101; x=1764317901; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXggH0+b8/rP3aYBPWiHo2+gkYlGyUfzMd+zPzEVv4o=;
        b=lJ885YUJbGeacpJ3yW6ePWgFOCbz09XwYvQxdrW9xIB8ibxZN9IPvRKGxhCdH46Krc
         Tn2zlRYA1rX0ADxxYW0u9To6Sk9bzCHJ0elcnOEUq9SSO3vUkAydFHIRnxmQe/ktwuZ6
         E8EcMoDLv5jSemo0+CLHyHaw196rkCKB86YFoUiauhUbzqR91+reVo257vsIpDlT9hPC
         qJ27FJlPA/5R9HvnHNLQXJKNfemXAHKdeZf0iNRa3Ylqjn0Tv8pEPiDgD13nww5bK7Fa
         YdziatD69uZtxWCRI6pd53QhM2tPJeeuHhFPNEe9bm6QashCmPiIJVOETqvnMsXwPIGH
         +qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713101; x=1764317901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXggH0+b8/rP3aYBPWiHo2+gkYlGyUfzMd+zPzEVv4o=;
        b=RR5KmYqVMHl4I4MWZebezNZBiyLZ9FdqEW1jkiK10P+Huj2a52pH6gmRL+PaEOTc7H
         GpnCWaJk4DF7ADe3i/g1+SbzfXDhMyzm8n7oF+eCwQ+3LIb9Tf0R7nRBn9dKAjsmQzQP
         RwrRrXtVbO9eYNWY1STCpJhi4jWDGSEjIZkYCr1a3VKaiXy7AmRfITAsuQXc0xgP2Z5t
         kBdBN5hQnZsKbKreOc/BJ0DWffkvCwW08oDG1hTVXzEuDVPpwK3i6R3YY+bxkBFDQeL2
         RxbQFIg39IPJEdy8IZrLuumvD1kvSarJgz5oAcswzLZBH6uJVD3z49H5c7oOCtY4dZXw
         dDnw==
X-Forwarded-Encrypted: i=1; AJvYcCWoUZnbhCTpod9mTS0UG0pHJlhqiqdOjj8QoTCyhrhcRJoYXRV+j8xPUgSQnQ1QL8QnHC0ts4cZeU3/@lists.infradead.org
X-Gm-Message-State: AOJu0YyRNzUyYAygeMeqJnMCpAatNrWacMNFSKOYHB2CwHp+Om2M1+09
	izE+GqoTG440Rkztd744Lx2Ujg1NMFzRMNw0OhSxQqD70hnC4wc/1hTsvS6mA4uG6aI=
X-Gm-Gg: ASbGncuw7YDNTRYLFGJ/YyYOJjV7mqTUrp2NyFE4iizZzmz3bF7gtjlWCQx7AdBkLsi
	kvCmxBYcq9f+U/t59tBwNF5yHESy8O56L9IPqUxbPgchBiwYv27mZNlMTf2hDPmApM3DWbgyIi5
	C+LZOc6GAKr1//aY1B0BgyKf61NazT3GJlXYFH4bPiUFwRp1ke5sb3UN3dXT17gHpk75vr5t7d+
	8MSklKTv4+cxP2StHT835Ram4E2UbZ25aNEvVeT0wKy2Hy7oHU7e6/4y/RB33Dd4zG/jPgJojmH
	UtjMy1dIqg2ytwxg+fVv76AauW1k7Z1wdXeiHxb7kZXzc/SUq1RAGg/BVb3PIzLwvH1wmaNvOtk
	0t2oEo1qYaLKVyjssX21Pln8r8LfuwgE/MjyDaU4CfWpoTEJ1p0dGDP9eAPgpYgwxKFoxQJJNrS
	LgEG6FnzwHyfOKFAquQjUWklzqJWrO1l6t5+Sz
X-Google-Smtp-Source: AGHT+IEZ79TJZoTtjlwZLisOIZ0dGAr2lEGHTXQQoCt+6eH8PV20aIRNYUKQ7CDTkbiFuInj7IJvjw==
X-Received: by 2002:a05:7022:1e14:b0:119:e569:f86d with SMTP id a92af1059eb24-11c9ca96a9cmr324319c88.10.1763713101474;
        Fri, 21 Nov 2025 00:18:21 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:21 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 5/9] block: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:44 +0800
Message-Id: <20251121081748.1443507-6-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001822_420852_7193633F 
X-CRM114-Status: GOOD (  10.16  )
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



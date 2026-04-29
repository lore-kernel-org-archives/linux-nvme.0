Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAD9CD13D2
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bz5U140iikgjy9qkhQv9ANNAasoYi2fY/CedhAQlGZc=; b=4nqt+VYQOqpkwTamxkxw0Yw66V
	P5d8W/qkKN8Erz/CmszzG6i7yWDwtPf/c8pg1y9O/oZGRaUDwcNDJT9DGmrXk3OLD4Wxe6BDABNoY
	PhPPrHuJGi0k2N4wegk/5wQwt3VVGezx1YVMwoV1Ot2HgYQI8FhWZQeHERMmbESgYXBv3T+HyRavb
	CziIPsYhAcciGhxm4ZZ4H8Iz5jfLx5LrFh97V5WSij+nWJ8H6TXZSMpL3Qfh+ghO1VDJGouuv/24Y
	tqhcubWMGVDhi+Y9RkAZpx+tjUhkphfav6MELpOhLwvGqy4ybfZcQdT+y0FLAyV5JWfeH2Qdx6Px7
	p/HqBNsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6ny-00000003q43-3Hb9;
	Wed, 29 Apr 2026 15:26:26 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6nw-00000003q2x-34uL
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 15:26:26 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-48374014a77so162933585e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476383; x=1778081183; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz5U140iikgjy9qkhQv9ANNAasoYi2fY/CedhAQlGZc=;
        b=ja8olaKrddQi+2Kqu7eyYzJpLvD9Nckh2WXj7CIQeKc+mRTaC8HHYEu5LSF/CZrykX
         p4LTwvVq18ieVZBov6IIMF7+M+LJ4dKcFjuRraZord9Y+cwvZVUDYB+/TM1Upf0L9G+e
         7EO3kZ9sl+7t0WUf1Pt1vXYg2JKe8t8WMOjIi81dI58tDldOOz9OGvGIQpdKh9u3zn6h
         FhP9w+cUxrg1mqZkBqizz1J5M7YKKf8QuIy/vnPpI+NHIaH9Z4W3yE9QJkn7dXKvieZE
         iISmy/iq9FBvZoWSFJnMaE0WNUK8V3m0PjBGz7gAYYY6S1A+cNuTA00iy0UygT8tFPAd
         821g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476383; x=1778081183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bz5U140iikgjy9qkhQv9ANNAasoYi2fY/CedhAQlGZc=;
        b=oo+9TQP99VOwmexggo/noKPf2OonNEmXjzBKnS/RRlf1BuyJEnzcyQFHoZYjpZotEZ
         oCDtTvecYcpCHVtL3BdrgA49X2pusf5k9DRAEFLKHvDzWXtvMzYw6JFSDrzMu6+ItzZj
         ALhgMUYA3fY7MzjOYMFzZw7l5kQ4YGp4k7VQbcLzwebuZNCfgNSj99lrbPzA9MStsUbb
         KOKv63nCT8NYCdHAFRX3IBO7hCi7bmVF1xM9/4QO6ETsJydX4eVfpeXf2/SWnAMbtDdd
         /U113x7gR5SxxJKGWfH7Y1YymihZlB7tcAOetgkHuyCYBtzKquJVZuTQ4RKzYUvrqkrB
         uDwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/y8uoCf6awx/lulP9A9NYWaYPhbfTUvkc4YbSGWGmsLV/dahXjLeUjqJg5wGXf7Q432mJK5KAHlwcI@lists.infradead.org
X-Gm-Message-State: AOJu0YyMoR68zDeBY2/gKHqC3GdOKWCIbFS1/l0wbywZkl6lxc+r9xBJ
	Amh4ygBnBJRwnaVtwJ3OyNHldGnsGbJVj3idbCJHRX4BBdgsiKlZfd55
X-Gm-Gg: AeBDievk+zTYskOAfaHMyHdeOJlWc47TxLZNG2wxmkCRiGg1r83HddYFLnPcVAaeUBh
	o1ifo9kLk0MtgjhhtxB8+j7wsECOxhf6gbAOxdWdiVYq7RJqwzNjIsgXt6MrMLlPR4L2iwWgGr1
	Dlsbzwo830VxlsOM+5NKy3ZD86MjsvrJVpHOMjWgBSBbwYNbsXoGBWBEQgWHK/i/mRqf+ehNGJ7
	LRcBFddkCOls2xZyU7P3EE+1+7TmYsapy9Re3jOvpHxMH8rSM6C3bBkbo1GjngcxunPlzAXLVwa
	RFCT9ce/Du0Mxx73/NZzBX8CxObmrNFgk3D3gOhaOaGnPJItpsflxgqyNL8hxb9raM4GkR+qj9R
	0ttc5Jzu/AaWP6Bvjp49RfFklR7o6XFhbjhoAz9O9Lr96pKSjvZmWeQVm6phahMZ4L4437LpLi5
	Gbwc7h8ivQ8O3qHhTvloQdHSbKDDp7W8idxe9LAarUvvpcnisU68Xv4OvhvIPdxwqhRWXlRHhyh
	VVpEOl1YS2Y+XFgU2bMVjxEMzr1A2eE1kfsC51foBAI
X-Received: by 2002:a05:600c:3b13:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48a77ae049fmr129049305e9.11.1777476382406;
        Wed, 29 Apr 2026 08:26:22 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:21 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 01/10] file: add callback for creating long-term dmabuf maps
Date: Wed, 29 Apr 2026 16:25:47 +0100
Message-ID: <ae941457cf6cacb9d4c16b6ec904da9ef7fed97f.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_082625_053554_81CB189C 
X-CRM114-Status: GOOD (  12.77  )
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

Introduce a new file callback that allows creating long-term dma
mapping. All necessary information together with a dmabuf will be passed
in the second argument of type struct io_dmabuf_token, which will be
defined in following patches.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b5b01bb22d12..c5558aab4628 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1920,6 +1920,7 @@ struct dir_context {
 
 struct io_uring_cmd;
 struct offset_ctx;
+struct io_dmabuf_token;
 
 typedef unsigned int __bitwise fop_flags_t;
 
@@ -1967,6 +1968,7 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	int (*create_dmabuf_token)(struct file *, struct io_dmabuf_token *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.53.0



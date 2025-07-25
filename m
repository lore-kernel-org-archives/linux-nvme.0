Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF684C87FD1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jul 2025 23:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Enc9BeBbBRQ4mYj3iJUiJbnavkWYlwvRk90VdauwkTI=; b=C933XuPL6lQZH+rvFwLPwUqNUx
	aVF98z7r4kD4AGhySZRcb7nVi4uUhHCU45C63nSy5T85E3JOTvnQi8GzYQ8dOXuIZ17smyYkWMAO7
	RSfDQZ3hC+Lmd03jCAxZnwSdYNPCJrdzuzv4rpV3y6/sqN2CYe+AMhlYA+Mq+9MtWKBLjroDEGHmW
	+jBVWqhwcTiKtxhCfoHFoePeUvN56Bn0WEOch6rRIn6MDFUrtSP/1FlhIZUh2Ngno9zMX947F/fTr
	6O81W++U2L+q+a0VVwr8vxpq3bDHaZqgfQPy6AyQP3gOFOSSGdQF0frQqlbq0P09SV+TZGPTmebWt
	VgTtwBAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufRbv-0000000Aq7J-2guS;
	Fri, 25 Jul 2025 23:13:55 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufRVG-0000000ApUg-1oAI
	for linux-nvme@lists.infradead.org;
	Fri, 25 Jul 2025 23:07:03 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-236470b2dceso23178955ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Jul 2025 16:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1753484821; x=1754089621; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Enc9BeBbBRQ4mYj3iJUiJbnavkWYlwvRk90VdauwkTI=;
        b=bVCfUJfY0dmKj1ry0mtMdVpPGCXbu9ORjQqAMtHNcq7YOJMEGZE9wj19E98G1S5fqa
         8lHPKgeWhEzLNbg1lvVjE7WECXYgQwBRXiGMZ5O5rKBB4zHtGZEuFqhu7OphMEsw9yMy
         Xd2hFoZs4EjDjg0dzuFH39hHGqdUNEJqfJtxCNPi/TJ+wriZoDHZZhyn1FzPkCYaeBZ2
         gFQA6viUsRolkveZ0VE4KawQSU+osv9j6NX6uCjwMoDepfV2Fxj8GuYFGp0aNS1LKv+v
         Rm7v6uVFRXqwr7zy4pwt+wMo5AA0IPQRpIfJAFGCnDrgfpzq34RRp6NSKzueDT/tidR8
         IoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753484821; x=1754089621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Enc9BeBbBRQ4mYj3iJUiJbnavkWYlwvRk90VdauwkTI=;
        b=iQrMC8FVohPdb49aoyYiGkmj/F6qxcQZ/rhfWjADVhwzM4nAsWEJKkWMsEY0VZ4gJU
         tQu2eL3IeynO98Wb0tijb55G2oJz1dA86pJ+S9rIcSAkoAsoqj8ArB6FbUzd4Bn4+kfx
         1sag1NUN3gs0ckuF+29K7A6hxhBLfvISRm0UjXDiGW6y6C75kgPFLPpWSFMHhhfzBiG9
         GxVi9fsASJH31Bm2rL25veH6nBJj4dulhbovQNfw8f5GTLZNtAEbI/pvNxlDwfz6WcHi
         43rwmVTReM3g/TK7Y3cD8udvnQixuFyG4VWql2KL4d09Rr0vpOcqxPHtwgObF0uAyFTJ
         Eucw==
X-Forwarded-Encrypted: i=1; AJvYcCVoBdM9NukWnvP5pMcYjOHuumUoEBSZGqOGIf1D1ha3TY4Ho1baYed/ufs3dGI2v5lmUl02JBZMwJ4p@lists.infradead.org
X-Gm-Message-State: AOJu0YxG5w0Gp8a6fWKndCL8veMbQXgfMusBP1/TIvbwjjn4cHWOGUpz
	s6ED02Le6GELG2wL0fOHVOkEi1UqBfeT0yC/bwMYicSzrGMjBbcsznHoKFzvKNt46V4=
X-Gm-Gg: ASbGncuM7CccWbGZPQstfX17IIJ6kXKRHuCmyGMwvV+OGQQ1hmY57YI082FhCYbrU5O
	fy2J5vDh03AeVKAGwFwKhRWmCVY2h9SvYtYEaZ6F12t8rpBz9QkrCwbPL/9bMKi2Cb50x7ob7j2
	KtkdUn3tU2AoYv7U0ssKLASq8bjxr29768ucTUzgLQDnp/tm62s4lEXGXVJvHrmX65KPlFevaH6
	u85A6q3KFuPt9Z85MibIalVMwRU0SWgC2ZtVGEQm1Loaf1ReTHQbBpi396s30P5APt5lT4SR1sC
	JRKqUt/7BamJhPZGN4wn23W/T2mOhLC14n1mOjAdB4LymtylsjXx91nb6WDYMFKjfWkte+nHt/D
	rbJ0Gy+a6XFAY0QCztiOLPMQg5SMGizj3qlbsHJdTIJss0w==
X-Google-Smtp-Source: AGHT+IGHYLzNYVGgKXl7e2IG/Y+aFt8LWqtYYVeMQAQH8l/BeKnXK8rfgk9IxeVQEjtzftDsgLeiMA==
X-Received: by 2002:a17:903:2409:b0:234:8a4a:adac with SMTP id d9443c01a7336-23fb30ab831mr55184355ad.20.1753484821544;
        Fri, 25 Jul 2025 16:07:01 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23fbe585538sm4991545ad.211.2025.07.25.16.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 16:07:01 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: Remove unnecessary assignment to ret in nvmet_ns_enable()
Date: Fri, 25 Jul 2025 16:06:39 -0700
Message-ID: <20250725230639.2017274-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_160702_501144_D8858EF2 
X-CRM114-Status: GOOD (  10.11  )
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

Commit 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
moved checking maximum number of namespaces in subsystem from
nvmet_ns_enable() to nvmet_ns_alloc(). The assignment to ret in
nvmet_ns_enable() is no longer needed, remove it.

Fixex: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b6247e4afc9c..83f3d2f8ef2d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -581,8 +581,6 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ret = -EMFILE;
-
 	ret = nvmet_bdev_ns_enable(ns);
 	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
-- 
2.49.1



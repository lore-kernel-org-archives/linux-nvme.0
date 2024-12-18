Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92456E77184
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wyNzNC0qUpinVJr0mql6moq+skFI0tUgODaQVETnoRU=; b=mZO+p+M4uPxQPNCEYb+d3hQUC8
	D41DtGjuUapuO2uhA+YjDccuZHjdDO2LTP1eYAnD8Oq1PdD4Ce3Jl8gkbySuq1w5Q27S543y4+nXW
	6BaTK2nIEIfRZWmMEDudTWCbcUuIllbxQjyKiqQ2O8eVWg1vbTbkQV7TvwH/2xDIyXfx9IGujptR1
	HrqPZzF8jvcJv6JaYXEpwwvm05BhwGhd3FO23wycwftHOHuj/jeXIUsXvtMzkEEIKSDnXEY5CjWuB
	BEoh9LSwIHuwhpw+Yt+u6pYR2op81mkRLu1Zw3ZJigeSZmh+GAlkpxjkRbUI0AZRSCn4lWk4RyX9m
	kum7ajVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNiPm-0000000FGGC-3HMN;
	Wed, 18 Dec 2024 00:59:50 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNiPk-0000000FGEu-0VPX
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 00:59:49 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-7f4325168c8so2658396a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 16:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734483587; x=1735088387; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyNzNC0qUpinVJr0mql6moq+skFI0tUgODaQVETnoRU=;
        b=KkctevQQVJAFSj1XMY+vbGVHXhvfF4sFhHZNEKTr6mbj8L0tIY4/YTnxB5U6C05wT/
         VHa1/1dUKfwYwEYCmFUnIfgzioVwOoSm1ZiRgpe0BlSzJeV4AmKWTkdfimnw4QmcZAY4
         koZNdojcdzF3ek1aPjETvFoj2bSSmmMHftdp3QP4IWh2X8QqNIfV/SsengRsSOrJggz7
         Vle2PWOa9iLq5CeDXXU/7bTHzZm8CnIlZixGYj+B94pVixq8AkjreDbQBa+IOQmwjnOO
         t+TylWAc/rbw28gZwc4cVqJc04/GyE/8KBVFQ3381DEPGPWntMsfRyWepv1h2npOisDK
         i+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734483587; x=1735088387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyNzNC0qUpinVJr0mql6moq+skFI0tUgODaQVETnoRU=;
        b=hBuG9+rMTl9l8JVHOptZwr+67hL/ovrXHOnM5JBe53GW+mYeJO6qDr2R2/HK81i/kI
         IcL4nUEyL091yqnZpGP49VRvsTswSZQA0ehvYo4fjOpfS7/zdLPgxgiRz5jfKpN/5q2P
         kLyFAgC58iJ47V7WcEIBn9vZu70Us2fyW+6xo7Z6PYvJLkrCkjm3mJqyCDvOK1a42VUw
         cmW2El35HKa2n2jq+3zRuN4BxDpzmfXG0Pt3fVxdBqxTRdUFZOWAtgrS8r14KYtdSJMo
         JaBwnqgTpYqrc3kyJ/VMtpRyXCMnZyFbr5c17ZkVf/rl6D5gyCEqnEyfna9f7deQxDwQ
         NcLg==
X-Forwarded-Encrypted: i=1; AJvYcCXmciY9cg8StGjdlosK451xeky1My73bRmktLdVgBvRSIwgJDJh0bJsfZIyESBQZ+E71Su/is/4QOlI@lists.infradead.org
X-Gm-Message-State: AOJu0YwuPPMiFwKMEvG2DAQZsWGwW0FPdQA2bAG53k9sueaqIKOA4Kct
	Zrs9Mw7bvgvOHvHCO6UDwOh6784Zx1+1As/YRyJ3XG8cpM/lDXVI
X-Gm-Gg: ASbGnctCracMbRIo3rAqkDXxTszCzVh2BBXZ0WRD40Sf4RHv51FAy5HePjbO9GDx9dx
	8aJUZ8+6EKqLOMBvo0FVZ/cF5Kx40B++Xcvw7Qg5GyErdkrIjL17upiW5kLiRORMZybfwh33h0A
	9/QpnqL2G3laZR8soMeM762HcVIVEedRLKJIEDA+jeqMx9pSr6R1dQutCcgME4j4y+wAGy8X7Q6
	QU0zXiJq820JTuYTzmhysIazPPLngRNynOWar0niG4n3os0hjbIEZTImR5wBXADIHURFAwY
X-Google-Smtp-Source: AGHT+IHyYIvDEU2mwF/4vZXZg+ysyyHMbcN+4K8Evw1EnFtDzMPyw2jnOAXYXvBbc50HbFE7aGtpJA==
X-Received: by 2002:a17:90b:1c04:b0:2ee:fc08:1bc1 with SMTP id 98e67ed59e1d1-2f2e93a6effmr1433692a91.37.1734483587169;
        Tue, 17 Dec 2024 16:59:47 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:8dfd:a38e:f80c:ebd2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2eda2dbe2sm152514a91.42.2024.12.17.16.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:59:46 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	linux-nvme@lists.infradead.org,
	Leo Stone <leocstone@gmail.com>
Subject: [PATCH] nvmet: Don't overflow subsysnqn
Date: Tue, 17 Dec 2024 16:59:10 -0800
Message-ID: <20241218005909.89092-2-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6761b929.050a0220.29fcd0.0070.GAE@google.com>
References: <6761b929.050a0220.29fcd0.0070.GAE@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_165948_156670_72DE6B80 
X-CRM114-Status: GOOD (  12.07  )
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

nvmet_root_discovery_nqn_store treats the subsysnqn string like a fixed
size buffer, even though it is dynamically allocated to the size of the
string.

Create a new string with kstrdup instead of using the old buffer.

Reported-by: syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff4aab278fa7e27e0f9e
Fixes: 95409e277d83 ("nvmet: implement unique discovery NQN")
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index eeee9e9b854c..3fa25f9f7d92 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2271,8 +2271,8 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 			return -EINVAL;
 		}
 	}
-	memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
-	memcpy(nvmet_disc_subsys->subsysnqn, page, len);
+	kfree(nvmet_disc_subsys->subsysnqn);
+	nvmet_disc_subsys->subsysnqn = kstrdup(page, GFP_KERNEL);
 	up_write(&nvmet_config_sem);
 
 	return len;
-- 
2.43.0



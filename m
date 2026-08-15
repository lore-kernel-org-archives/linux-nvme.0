Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A49DC5CFC1
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 00:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3FGO108lsW0Q2DmOOQyHg7JpVvYJd0aNzzzQnAbrcaw=; b=lhSINWIaK//EhA67k50A5Gqj4A
	F7OqA4lGo41P4h5bWU2HC+KSKk6VWefR0My2020m6wkavaOyZn9UCsgRhi9UX1SpoQfnnfarM9VYY
	X/MrK7F3clzqZxCYfRckpJHXU8lHpyFrBUlvCxCieBW9bAM2wcQfKMheKN7vy6uKYi7vrMZV5yinZ
	tXpwK+K+89ircckNHQa1pNqV2Gea00KoVTJCzWC4s99mhhsvURluLSxT17V2Ata9dQprZpJktFMvn
	95P/2WkF9jYjE/lIxacvKhOXTZzq6EMeHO41qrTKMa+L83ldOpO+EUfln8AZfDcYXHrmFKgm2rfzc
	CR9ZZLZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv22m-00000003KlV-1VRW;
	Sat, 15 Aug 2026 00:14:36 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv22j-00000003Kkl-2uKz
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 00:14:35 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-47f84023916so1430123f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2026 17:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786752871; x=1787357671; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3FGO108lsW0Q2DmOOQyHg7JpVvYJd0aNzzzQnAbrcaw=;
        b=IKPR1Qu6Ndtf8SOmVKmf/MGAG6DKYdfLF7O/rFRS045xof5Lk0Fm+u/JpIYbQ6NtGz
         TcqaYlRIfCWDfr1xzSAMbq6P40RbFoTghTcAfRIw1CDljselwdIjmCjbVEMDgs5wko3I
         S63QA74hnBBvGcl5EFJBwXDVV4qZigPtIfkqbSbpT3/AyqbBkmC/cguYmNucbY6Gl/aY
         w7R1hmSMpyBZJgs9WSkEwPjkAVucP2aYo1nrnyJg4/mKpaYPOpDrJj9vj+oxWB126ptF
         8zCcwfKGYZt1GM49P0fWDwS5YXzGcyG2zvh0RJPbNZaUlMleagk0z8dZqaENQPXDmqkg
         LNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786752871; x=1787357671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FGO108lsW0Q2DmOOQyHg7JpVvYJd0aNzzzQnAbrcaw=;
        b=q/UhXzD4j+cbhB/SZ+ITug9TU2aPmm2iNy7ECfO19vzpa4oU3Rfl/qoeYnaLNv75z3
         D52NjXX8AiyGxE8emQRJqBDDQTHsjjCRFQPYKpAcHTgtmR2HaJjNYa7g7Wf5VD7Xr02o
         gmQiShOSrol9XDxMrhNq8X/7V1GNKn2ZayQnPqyl5cdtz/4q8+dCa6z2PwzjJa0gIugG
         RpSS8x/E+T8oYW2IG4yDKI52AIm76w1gD3OXzG89ToTn8SG8jHp0R1VrFSxyQXTlQPqE
         /T89Uw3Ii7M1XwjBPIbx0/py6indLMlmtxT2SKpmgp+EZ9HSbevDni5TrzHZxfg+8j3C
         Plfw==
X-Forwarded-Encrypted: i=1; AHgh+RrXrEX9Y9C7VENtfzx20GAtuUCv3n9fUoZ1Mi3mKIH9o9y+AR6bCxxBj79Y2C+2g8qmK0Q7C0PaYLsK@lists.infradead.org
X-Gm-Message-State: AOJu0YzcGHVF7Xc2VPxgbIy1BYMTo3GyUGD8kiI/6ia0R2pZ2/mw9crL
	MOyxjlFDAYeva+xQQjvWUKcYcdU9z4ZF2V1jfu+KyLwVcGdYteVwAZw=
X-Gm-Gg: AR+sD13OV5mBznpb4Fdd1k/3rC6IwP6l5XER7sHVQYOo+K4kjYzBO3oBeA2M7h7yrS5
	L2e6eGJWUMMBboQcOti52nlPR4yRjMcLu1c923e/DE9WpVaBiTEKiTJPSBi0JcPBCjeXVXYPyni
	GoB9wELWqBI1zSxNeUW3Tz6wa4ofccHIczf2BaO/Qny0YLTvL2CNWc8LcZeXK4aj8y3lqkWEpDn
	+bNc+qTVED0B5JgYKx9zpE3yk7XudKBU5dDhO06OvJ+w28ip43vjYRSGh6hLcBnHftnCa8yOKhl
	jp63TVE9kt7Een+tNbjLy/eUqkuxHrLOT16P4J6AGeCQZQz1S6awYrvPR5xWcuko5IjWnjHck9N
	CGA1cXg65/0ei/NxQlXMYdgBPc6J6NbyhCgwOaaM3bGNqJ/HSjTifrH9FSwURdjEEJhARSiif+8
	bEWR4zYu9sYBT5nK70KuGBX/PjCoNWWAVl97EVj5kgvA==
X-Received: by 2002:a05:6000:4917:b0:47f:8f8f:db74 with SMTP id ffacd0b85a97d-48160714b64mr15386018f8f.12.1786752871267;
        Fri, 14 Aug 2026 17:14:31 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1a91sm11431444f8f.21.2026.08.14.17.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 17:14:28 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] nvme: add missing SRCU grace period in error path
Date: Sat, 15 Aug 2026 00:14:27 +0000
Message-ID: <20260815001427.3148050-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_171433_742568_D2FD5365 
X-CRM114-Status: GOOD (  11.33  )
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

From: Tristan Madani <tristan@talencesecurity.com>

nvme_alloc_ns() error path at out_unlink_ns removes ns from the
namespace head siblings list with list_del_rcu(&ns->siblings) but
does not wait for SRCU readers before freeing the namespace struct.
Multipath code iterates the head->list under srcu_read_lock() in
nvme_find_path() and nvme_mpath_revalidate_paths(), so a concurrent
reader can still hold a reference to ns when kfree(ns) runs.

The normal removal path in nvme_ns_remove() correctly calls
synchronize_srcu(&ns->head->srcu) after list_del_rcu() to wait for
in-progress readers. Add the same grace period in the error path.

Fixes: ed754e5deeb1 ("nvme: track shared namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd09..0f5f13ce0b438 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4295,6 +4295,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 			last_path = true;
 	}
 	mutex_unlock(&ctrl->subsys->lock);
+
+	/* guarantee not available in head->list */
+	synchronize_srcu(&ns->head->srcu);
 	if (last_path)
 		nvme_put_ns_head(ns->head);
 	nvme_put_ns_head(ns->head);
-- 
2.47.3



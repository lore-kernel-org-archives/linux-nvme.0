Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C797E6C5F8
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 03:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7u1S0eHhsN4mYxNA4iXN1JMBrK9KSvAJK6vFPRdxHE=; b=WRFczUS1SZ6a3aKe7mFrJxCBLt
	rQI1+0I4lf9Io9oZCEB4jh2aYRp4l7kd4DrPv5wkLsnX6iLVlyPp9v0zabK74VYybmm2KShMuhnm0
	40E7hA78i2d73UiCw849LGbMtrs3xnWdHDeUq9nQXt8siwLH3gNBQbAjJ/YXTcyASqFeyKLEs1rU+
	I5jGk/LzuMqOg0gly4QpbvHvIxLVNN3w0kt+MlN2SmFyWs5BYiYiZJ49mBxf1flVJhXq6yjka5anS
	Q3vcH2DCsyVDuLq9QIT8tzx+LZUNoLhOsywhrENz6qB1yJIKJbkHZTd4oWzVJTkTFR0vVMJKdqMXK
	Xk5jWjxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJgb-000000087Xm-3Rm7;
	Tue, 03 Dec 2024 03:34:53 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJgZ-000000087Wo-2Tq2
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 03:34:52 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-215909152c5so16969115ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2024 19:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196891; x=1733801691; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7u1S0eHhsN4mYxNA4iXN1JMBrK9KSvAJK6vFPRdxHE=;
        b=bpw3wdHh5UaHvBGhPR2M1pzF78d2QHP52zEGrqBQvGPovkUIJ/nYngbBFTRcJOo5OI
         /MUXvw7RsCfVY6kqUW+G3B7ZyomzL/nTcD82kzCcKN/WPwD9gqavb+Omd/jD7AAnjJaP
         Ae1IfU2aLK8emoyBm7afOtP85oLn8hOpExXSzeFUIcYP6PAFijGEe3ciKbb8vzxMk69R
         DD+aLHQ6mJUt6Bu5/P9P+oqe1H+DWfs9yipzp3I8DyL4OriL9MiLkRCdxo/dj+897cWw
         BriEC4T++H9Nlmm/WIkgg0hFEKKqr7eCxD90bIKstDKGgF/v7439FlDGiXLh5YZsAJWf
         AAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196891; x=1733801691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7u1S0eHhsN4mYxNA4iXN1JMBrK9KSvAJK6vFPRdxHE=;
        b=SBQteXCwP4XqSCY2KfRIL808PR+zbUqISB0Q4HQ8JaMm81KY3Mtg1krsRSXgUeKiKP
         KeOof45DVfOTbTjsgpVlO7QdJRIMSfDwMNpnsZOmkIoMu6NiYWVOUAFgFDHE/4w6f3xA
         nyn6NHBUWCr99drogLWd2RITVTQlSNsD2dtlfKiFFYcNLnp5D9ObSZQAAgIOzZLcoO4Y
         Ps/E0AzfVKFS4TmZ9AxeP6o21hKNXQKb4sFDjviQ9wO4O8cSFEKsAbdVKfxXpzHkQ13d
         iIDOl7LJTBhVfDZlUbpXHpW/c38aeR+mZvk8CUEfeS6wKOwvniClM4XglqrJ/hns9jvs
         Uv7w==
X-Forwarded-Encrypted: i=1; AJvYcCUp5vZQQ0y4iA0wPx9avesU4LuM4TboO8ST8IU8HQciTpEiWoAqMbbtnPsbMp0AbrEGGNOKdVSWooCe@lists.infradead.org
X-Gm-Message-State: AOJu0Yzoj+MsRlPcO1BgEVSpLqS7HwURDlRVTrTzDXh2sgseIDB49lRD
	d9/a1ZMRC8A418hHZD/o2iu82eGZK/w30QxSx3+51LOmI6ZtruhS
X-Gm-Gg: ASbGncvnGFyyNrJjswFqfZFYiPpLzfBco1RdKmpMXeEOhyKAUBKX/2DptUkNG0YYzDD
	5aLJefoPlzuzFTgfqOZS5Y2zwrl+Docn0sMjCVz5za8CKKZvayDPxew6NGUHHcxvOuj4uusbBkm
	gE+FBH6CGuKVbxG2nKi74Mxgns9Antnu8LOZFNKsp83r6RH+SpH1GPcXJVP3TTxMlmRLkIykUl0
	WwI8ph41IwI/GMhyEPP9eChiwUTHH8mQqo6fRvO3Pt4Jje7GNo/GsV7m185AA==
X-Google-Smtp-Source: AGHT+IEQVYb1UMuUdfZdRH588z4/zfIk7I6L4N+qQj1+gNpi0vAJ5WzL3BoXukZp5mc5P8q8Z5nYaQ==
X-Received: by 2002:a17:903:1c1:b0:215:6e28:8260 with SMTP id d9443c01a7336-215bd266031mr10635355ad.50.1733196890290;
        Mon, 02 Dec 2024 19:34:50 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:49 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 1/4] nvme-tcp: fix the memleak while create new ctrl failed
Date: Tue,  3 Dec 2024 11:34:40 +0800
Message-Id: <b4957fa602ebb3af58872042d8e3bf1adf3b386b.1733196360.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1733196360.git.chunguang.xu@shopee.com>
References: <cover.1733196360.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_193451_632391_7B74C0ED 
X-CRM114-Status: GOOD (  12.89  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now while we create new ctrl failed, we have not free the
tagset occupied by admin_q, here try to fix it.

Fixes: fd1418de10b9 ("nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()")
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e416af2659f..55abfe5e1d25 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2278,7 +2278,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
+	nvme_tcp_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.25.1



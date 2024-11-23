Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06B6E6ADFA
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Nov 2024 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0Wy8akKqdjTq0kGb7hjR97SIT8ZdC6Xj+nkupcGNJY=; b=mrv1Il9jXQIAjnYZhuch4nhl/e
	1bLWnhPyyCUXTs+U0DX1TDkfA3YGx6LG28nkejQ6bnwDFXL/TnIK7Xm7ir8rA0EyAuHdh0+pJ8fsB
	1kE9ztE8tORKX69iheTJFzWVL2JD/TPtzUqzpHpMH/WIY4KnymcsLUyYlSWvovEWvAPy176ryUkZ0
	D51Peup+C34/rmKIo637q+Iz8VM8UkhE5h4ECL4gVU6xqkoXeXc/dwJHAVtuqG8wfuqZ6Y+AQYjB3
	YLqbzDY68cDMvEjg7ELa/arGpkKwuFE1G15XjeQBq3uU6+17qm3xOJ7K1DHXFccf7DHDKy2RlI5In
	XlMUhmVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpmJ-00000004Lxp-16ue;
	Sat, 23 Nov 2024 13:02:23 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpmG-00000004Lvu-2zSP
	for linux-nvme@lists.infradead.org;
	Sat, 23 Nov 2024 13:02:21 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2ea49a1b4c8so2425721a91.2
        for <linux-nvme@lists.infradead.org>; Sat, 23 Nov 2024 05:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366939; x=1732971739; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0Wy8akKqdjTq0kGb7hjR97SIT8ZdC6Xj+nkupcGNJY=;
        b=Q47+XfxSHFVVvHMEC2YttLdBpwU8tJjKzZICSfjMo6oEWfLhq9LbwjYOCelCwPOgL8
         oexU4JAo96qHcrOfy2NAaaVt7lAIIfL+1AkJq+CBsXw5qkf/QwvpqCQSEhT4xCmGGATY
         X6FBhB4oKmBqU66Bu4Qx23KWwIwchtZZPJ+sRtq61U6656mG+J+VX6B0lXEHKUBaEAf8
         D87sF/t+Ne11MBADDxT0TFcUBXX8E2lfZni6Swdqj0aMGkfhIw5emL5qShGgUj3oMFeN
         gs5YpwkZks0vcqPZDeUMUb0eHar1L8l6dOMsTv1SLNu3+dA4Zte2SDP99ynihcYRxmDA
         WBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366939; x=1732971739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0Wy8akKqdjTq0kGb7hjR97SIT8ZdC6Xj+nkupcGNJY=;
        b=PgMtK186th9ySoM8CEcJqT0AsFH0/6bllrM7U2mizS71z876HENuKQSDNgYEK04IEk
         EiqDMCf5voISewsFbNCm1s7vwkFCWEDfLaGygRzmp7ih0Nj4m7TbNWQ+f+NmEGfAwMUx
         qwNY/Yir057nzkL3E4p8uwmvLd5iUrih4Hl9h4W+Xaqq36KpPbIFnbMG1/4xnz5cmziB
         q/fQZBmmJjHbvwuoYkBuICesrcSxsqTmts0f6pmEA1W1KyDtziBeg7ggYr6X05VSuY27
         dYj7OkwqNT1XLtTziEM4Jp2+tnlSk895VIFddM56J6Sm0vMi3BaUNNEZS9c+lAl+4gh8
         Kskw==
X-Gm-Message-State: AOJu0YzoSJ5lmJJYfO+SClxbqWJhCvDnKFz0yGuX1CjsQnu+IrOKGUuj
	xxsazN6PGHPiKwvgvhGK+KQO6f1KSc51aPIXVmg77s55yxs9Xotz8pBNhaV3
X-Gm-Gg: ASbGncto2XirIhK1qwT+GnOJymNYNoAakMAnbqj6J4/uEsmMPrtkftYxpMPF4KvG2ia
	6YZ1D2nSA1o7TLHa6iADCf7SoAD8pLZIE5fCKjmLOAG7J+zph4AV5KvnhthC4HmudYp3utgZMm0
	MJM1TfeM5XjzjbmaHyyJ8ICHPRemitJfeDxdKoJZJ3hG/ghq8Kmkh1Qmsf1eRU/D5UWeT1m6nnU
	SolfcE5sUUNaURJWVhAC1+jg0kOVxaZMXzl/AxS6zf0Ih63frB4PWPOOzewvg==
X-Google-Smtp-Source: AGHT+IEZbBIT2xSL8lKwxiK2DmFG5PNj1NHAzAd71DuVF5rYYhINvdRlBjQGjWEtHL15HTh9/7gSqQ==
X-Received: by 2002:a17:90b:33cb:b0:2ea:712d:9a7f with SMTP id 98e67ed59e1d1-2eb0e427ae7mr8022347a91.20.1732366939554;
        Sat, 23 Nov 2024 05:02:19 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:18 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] nvme-tcp: fix the memleak while create new ctrl failed
Date: Sat, 23 Nov 2024 21:37:41 +0800
Message-Id: <55fc0f971eccc72b7ff2b2ce176a7faa8828e487.1732368538.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732368538.git.chunguang.xu@shopee.com>
References: <cover.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241123_050220_748677_DC79786A 
X-CRM114-Status: GOOD (  11.50  )
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

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 57f0f0290cc8..36c7e49af38a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2267,7 +2267,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
+	nvme_tcp_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.25.1



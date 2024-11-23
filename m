Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8983CE6ADFA
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Nov 2024 13:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pYuajvX8br0TO/x0wPaBVGA/qUmBcUlg7gdRZJk7m70=; b=x1tygG2jSJOVK33t56hWKOaMEt
	C13dbAbHwRo3YiDI9LQmGOUfxF0eGYKsgHs3vecFxfzsFEN9a9UBM/4LqLJbwxEkrmtW3EPvjWYHz
	snWktgG8lgwfPK8WFJEa1wiKOK06b4aWi+IbybFTYD6QrnNv2MnnS3rh+KJZ9etS2bgkuyjtb9dhz
	72QoYszD8i5NpRnTN4JZ3pnFQFvsByym7m6yZRo73NKAShhRZpfFsoZYK24iK3hmqMYU/dsor65ef
	/veQXM4hdqOON4olbw7W1MzsPYrqesoJJUcNhYow1eMGPZ5GnQ5oeVmabbXXyjevE3jpKdGkxJXBk
	m87pBd3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpmB-00000004Lru-1Kb9;
	Sat, 23 Nov 2024 13:02:15 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpm5-00000004LrI-2O3t
	for linux-nvme@lists.infradead.org;
	Sat, 23 Nov 2024 13:02:10 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2ea37b44e81so2390015a91.2
        for <linux-nvme@lists.infradead.org>; Sat, 23 Nov 2024 05:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366928; x=1732971728; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYuajvX8br0TO/x0wPaBVGA/qUmBcUlg7gdRZJk7m70=;
        b=kurQ6A6+chbBMInyMjFyK5qLSiYZ+prHIrH67B0+nl2O+XS7PiBJQaYkPdIr6Eg4o4
         pnBgK1TnF9WTOCZgr4ruezSFjoUMumLm3ZWSUo1A+e0KXErkx9yPP6w7iGm8jfjBOVWX
         wk9rj77LUIGqQkO2T9AfvsUUnTkw7RVuDytQMcOKzy+htF3j7Qujx/4k/Pc/WlMRuAtK
         bPsonfPXcmQjzKCsorfxlIgTdOvzasef6YCuBhpwH9bpW35uCcgx1pnXE3XP6jXlarM2
         vYQGPBdFOULDcijzhjFAKsnQhj5ZY/FqeAUp9eLxUPP63NGM4pxZ2AWZS3LA9Xiihtq8
         1AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366928; x=1732971728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYuajvX8br0TO/x0wPaBVGA/qUmBcUlg7gdRZJk7m70=;
        b=YbKhnHfg8EIwn9XHqPsOKqUAJ22LrM5PqG0zkyWSFzS2VruO7h22Nv0IwU4MM/Y7GZ
         rsHcjhkHytKBslRFn9x/A4jpDc8orHpFXCbDc0yeJtp3UrWT83U7qd3T/Q1Kvd2oFJZp
         SjXjSPA7y12IZLfjmrXsIwKc2rIPq4vdNPGg31tiDPEurk5A13JCOlqHPksdbFmazxVe
         K4I9Wky6LhvtbEBWtkU6ipVjjzfzLkwn5937Rc/IQmrTbgr1pcNNSx3lQm09YgH4UcjT
         3Cg3A3TEmcHcB3kf1JYUC9l+XaCEIgduPXkmoV6koNIAR8roM9J30P/uLgF7kPLGCJeT
         4c9g==
X-Gm-Message-State: AOJu0YzNBj1b7ytbfamAOWXO5d+AX1UohXuA/wE5Cd6z9T+tBPwZA8zU
	lg2QRqOqsy2kA5FJsFbuwbhIaeSmAOojB9ARAcAAYcA4mYuZRYb6
X-Gm-Gg: ASbGncuVt0c/VrfU7eG/QuzUTW2SZOl9NO739Xd7STOQb8lTlmOtlE3rMWAQarxuhaE
	5FoSCIWGgUTw0MlMsyZtBRTMwWY8OjRvqDdp8/W3Daj9/X6zRwt4ZHwQTxnQsodvdS6ZtSmnOrZ
	PLPkcsyuSa3TT0pOhaRvjLa4VVEaSW3Dn1PoIcdqhNqkxjybXYj5RohGPovo6PD9bGwLcys0Fmz
	IgLR6nMHu/cjhX+W9reh8bS6VxkEg0fyqOW9zekP/ByVkrGeBGEZw1Rk0gFow==
X-Google-Smtp-Source: AGHT+IHt2MDQJm+iAyVcTt9gvAgFsMvRR2kYMlOJv5BLT0znuv3FN4ObplIU3QXQArnMTWRAJIvN0w==
X-Received: by 2002:a17:90b:4f45:b0:2ea:9309:7594 with SMTP id 98e67ed59e1d1-2eb0e1254dfmr7749077a91.4.1732366927810;
        Sat, 23 Nov 2024 05:02:07 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:07 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] nvme: various bugs fix & code simplify
Date: Sat, 23 Nov 2024 21:37:36 +0800
Message-Id: <cover.1732368343.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241123_050209_609230_A6D7A595 
X-CRM114-Status: UNSURE (   7.14  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Here try to fix the hang issue of nvme-rdma, memory leak issue of
nvme-tcp, simply the code of nvme-tcp.

Chunguang.xu (5):
  nvme-rdma: unquiesce admin_q before destroy it
  nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
  nvme-tcp: simplify nvme_tcp_configure_admin_queue()
  nvme-tcp: remove nvme_tcp_destroy_io_queues()
  nvme-tcp: fix the memleak while create new ctrl failed

 drivers/nvme/host/rdma.c |  8 +------
 drivers/nvme/host/tcp.c  | 49 ++++++++++++++++------------------------
 2 files changed, 20 insertions(+), 37 deletions(-)

-- 
2.25.1



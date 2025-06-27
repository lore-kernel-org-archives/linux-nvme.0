Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D4FC77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7wkcKconIajPlkNpXoc2+RGKTPswyf6ZT5ZP2qLcpYQ=; b=KbeL/C8KEeJN0PcsDbxk2koDvg
	6tEI2LMjhazC+WsO0uW7rYHdSCzLfpXpbPOlKHiKJebXl5IfdP1/J3vJFj6i9XGB1/BwIenFeK/Sv
	pcRkUow5zBe8gQ5A/gXmBwhaHlhUjwToXUxL7ztbdoSKWDOXuV5ZErp5adnOOoLnwc85hRPXrhF2A
	qKG66pRwKOEWCWyMW/hlnV1W4auhX//THKPU9mYinkLlh/ut7jzQvQsHXHJiyNj63YvYfZDUBHyBM
	d3uRa+rMncfvnFMm1enrrE0YVL84PDny2tjjNJcMIukCWEHpwD/AfEgKztqhaPIPEM2UMF9lbrfVW
	P5oXEIgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAvI-0000000F4Qy-35x1;
	Fri, 27 Jun 2025 15:23:28 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhv-0000000F1E4-2ocj
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:40 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so412528066b.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036978; x=1751641778; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wkcKconIajPlkNpXoc2+RGKTPswyf6ZT5ZP2qLcpYQ=;
        b=ahmV3lK9hjBPt6RBSoxx2HE7z2uSB1I9ZR8BanpP9egCas6QyyPc/T1xQh7HICC+ej
         bItcKcFdnM5ltWwuGQdkS97L4QK18dInpCWD6vtnGflyWkEEK4nOmBVPxR3qVFNzRzns
         /aK6qjjL1aG7OAZZ2UsOm87NcjyEia/ABRX3MT/hQjw3b7wLYDvlZ89W+g8rj/MaB10u
         XKutfeQcw6wrenYKERzbR0gIDUQjSRBuADJSh7osirFTSqK9nKy5dSHeLJMeS1YLYCmv
         nn0uKQLYpyR6oQdIGTvDYYUTBVn+ZEDkIZFS2Pu+3NMfr5yMDDKvJ3vtle8rxwZK1JaM
         1VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036978; x=1751641778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wkcKconIajPlkNpXoc2+RGKTPswyf6ZT5ZP2qLcpYQ=;
        b=sgVzInNq1FnCFVkzCfqqdqqB4ABE2SpVNgLR7Ihi03EaFxb+F7J6F1+inNM/i9jNl8
         0bzfpeVJngRc00q9ZOzOWP6TOFrvDvSG/TgGsJ+bzAoNqgU5Ih0b9LCP6KlHySc9Mw16
         9wC9x+F4fU6e89ZZsNlAanhhkSUzwmylj1keB7ZgDREQpFTIQ7EgYsCTolX+gqnQBUaD
         8J+aSj7/EfJQFNCHFEivpBUy59J3S4ZDTaHGl7w4U2X3uND51QtTXGrXyulzVDlfeYVw
         aK+Jz48ujxamSJlyvH6jyL0RFXdNqr6YgKATV+r7REnpwnCk1hGR36f+8l6NBPdRrmA9
         1QnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYyvc7ezyvLHeFf5tKukfzvsA0Gy0IrO2MXIkPa2m0kNVwRKQqO9wgu2mfDvrsO6AwdB+gvvUWKr7D@lists.infradead.org
X-Gm-Message-State: AOJu0Yxd8HwbOEboRwWKhkXPqKM/4Z9Cpi0P1DYb2U41msCOFzxTJo01
	kiRfCwKkjFOR2vxbYXbadwy3fk5tmn6WefhUWj96tnLyyDHmDxmxadpN
X-Gm-Gg: ASbGncvweM+uqoWJ/G0xfmkmrGjhQYz/kDidq1b5z4utF3se1BLbEFVSXipaaN5sQZS
	o31YDH095JDqTHuZFGyoK3BNCKKTuHQkPH6OF2Vg3LAfrDomSwYJ88vwQs2c/HNoHcQSDgl36n0
	xPRV8trncQ5tMf4fBWkXnpGqYfdFFx8TwQZ2N32QVGWw2v2aDP5a1v9IYpHjSbBPMigzMipF5RZ
	CwoBV2GO0dRj6oEpqIfCn6tCfJ2/oi62FcBbCNxA/netax2IAEco+iUpUtH+rt4FGtO6DqV/TIx
	v4myKGzjhtu92rnsb83PHG/QZjxuJMJ3WqkzYlGhSqBqOPe8Oe4Gc6QwIfitdhO/XqkJgXrqOPg
	w
X-Google-Smtp-Source: AGHT+IG9bytAnaxECDeI4HYr6CPYTTXP/6RfPwmtBJI0OPbHOa1VZ53IIjpM3ep6pvmZsW8jwWZQLw==
X-Received: by 2002:a17:906:dc8a:b0:adb:3345:7594 with SMTP id a640c23a62f3a-ae34fd463eemr295747166b.9.1751036977798;
        Fri, 27 Jun 2025 08:09:37 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:36 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 12/12] io_uring/rw: enable dma registered buffers
Date: Fri, 27 Jun 2025 16:10:39 +0100
Message-ID: <dcb53f0011913630e246b7e57ef6872f3716e762.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080939_714388_5C8BDC11 
X-CRM114-Status: GOOD (  11.23  )
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

Enable dmabuf registered buffer from the read-write path.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index cfcd7d26d8dc..78ac6a86521c 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -372,8 +372,8 @@ static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_flags,
 	if (io->bytes_done)
 		return 0;
 
-	ret = io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
-				issue_flags);
+	ret = __io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
+				  issue_flags, IO_REGBUF_IMPORT_ALLOW_DMA);
 	iov_iter_save_state(&io->iter, &io->iter_state);
 	return ret;
 }
-- 
2.49.0



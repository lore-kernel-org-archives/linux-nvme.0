Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC5AC02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hCOvtJzoO7kropyTdMTdsYuiW+lzVbYq0OeZfYvmpJc=; b=2XQ6HAmP0zLyp9
	K7gMWhF+ILUiokP5Hx0ySzE3D6a25bkXJgsYGBn2IuiTPN6ztdNM8imRWIbh5RLAe96BALBXaCMxN
	ZSjyN4PFEx3UVBkYdbadp7SyitjBJIZvOm+wArlYpI880gCMlILR1nGomrN7+bR/fsL+pGSjkHBOw
	ydaekUWXa1nVzQ8QM8m6YBd4NR/Txyl1X22LdVoXHjetXNML7aUKbERHT76V1H4mLdRnLISMXT22h
	cHf8pOwfgxTDG53uV9/nufjp46KOsiW9fuPcw2O9x/Y+i7nppeIsAvsun5txPQtfkUskj9Xvo3gwk
	qlVRAdn8RbuNoc+AHKfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHQW-0000000EWIh-1Rp1;
	Fri, 24 Jan 2025 11:00:40 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHQT-0000000EWHg-3THP
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 11:00:38 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43634b570c1so13805625e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 03:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737716436; x=1738321236;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCOvtJzoO7kropyTdMTdsYuiW+lzVbYq0OeZfYvmpJc=;
        b=hQxGytofqkTzHavlx5fm0Qnfjle9mdWHE5G43craF7Jc2S/xto2ZylPyjoNhXKVjYn
         e1ga+b6FUi+XXuxmIra6yOs/KbV3AmCbVCRv8htVlya3kks2fIH/eLqhlI9TVRsuBLqY
         I7JOS5FtLqmxZ6EkOZG/gHACzCg6RF8WlSBK2iDY/KqlBzt2+NqP+1F38trgT4AtRmFQ
         6YrUqPIIvina0YTlmOc0Q3qvt7+CEWBOSzC/inanjBK+YK9IV+kpWNLVbGjAa7hfUndh
         9F+usXT/FJ5VoByAhUpzbHC/PRqkf74PaiHr+xsNrEnJvf/qVVyyhUdSFsf2OEyz/w3H
         GmTA==
X-Gm-Message-State: AOJu0Yzqp6KM4j+EwYY6xEiit9yrD9N6DdtuTbKSsaa++shSeQQEH/74
	ynELCNLrHUB1XJYbZVNiLeawbs+uAtAimtJxhB12vc8ccxE0Qk5aksdmqg==
X-Gm-Gg: ASbGncslbvX9la9rbrO8wNTc71adTHkM1p7lB25tQNlbqVf3gyutPS50zgo/mHEQvx+
	eYkxYmg4jajUnybIeIBLrB7UO+eTXich/DCTNCINByjUyEiz7DZVQoWPn61cO3vSI8BMpQX84dR
	3orvwe1aJV4FXso7G/Li8oZn5UAdetcDul+PwXlogD/AYM81qeGM5iZUBSWI+aTIXPFPuztjSSF
	dFysVB7RQY18K4GWQtvh6ZL8u/Z4TVrdK02HUE4jgQoUF7AOaEEM8XWYdC1/UayLD7tkfa323Wu
	HzvRFcSMEEc+WRx6X33DIH/9FiHrgvfu2HBgulBfC8pJAYb2WA8eKXBBpY4=
X-Google-Smtp-Source: AGHT+IFDzaMM+cwCS9xuJ4BqOuWFqS8O4tVC6XahdJgcynqivaLZYbsBM7zjoBzXY7RcR/KxlIT/Xw==
X-Received: by 2002:a05:600c:6a93:b0:438:a913:a99 with SMTP id 5b1f17b1804b1-438a9130aa4mr203833005e9.31.1737716435575;
        Fri, 24 Jan 2025 03:00:35 -0800 (PST)
Received: from vastdata-ubuntu2.vastdata.com (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d6casm2408940f8f.30.2025.01.24.03.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:00:35 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet: fix a memory leak in controller identify
Date: Fri, 24 Jan 2025 13:00:33 +0200
Message-ID: <20250124110033.391731-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_030037_867075_61DC0234 
X-CRM114-Status: UNSURE (   9.95  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Simply free an allocated buffer once we copied its content
to the request sgl.

kmemleak complaint:
unreferenced object 0xffff8cd40c388000 (size 4096):
  comm "kworker/2:2H", pid 14739, jiffies 4401313113
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<ffffffff9e01087a>] kmemleak_alloc+0x4a/0x90
    [<ffffffff9d30324a>] __kmalloc_cache_noprof+0x35a/0x420
    [<ffffffffc180b0e2>] nvmet_execute_identify+0x912/0x9f0 [nvmet]
    [<ffffffffc181a72c>] nvmet_tcp_try_recv_pdu+0x84c/0xc90 [nvmet_tcp]
    [<ffffffffc181ac02>] nvmet_tcp_io_work+0x82/0x8b0 [nvmet_tcp]
    [<ffffffff9cfa7158>] process_one_work+0x178/0x3e0
    [<ffffffff9cfa8e9c>] worker_thread+0x2ec/0x420
    [<ffffffff9cfb2140>] kthread+0xf0/0x120
    [<ffffffff9cee36a4>] ret_from_fork+0x44/0x70
    [<ffffffff9ce7fdda>] ret_from_fork_asm+0x1a/0x30

Fixes: 84909f7decbd ("nvmet: use kzalloc instead of ZERO_PAGE in
nvme_execute_identify_ns_nvm()")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e670dc185a96..acc138bbf8f2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1068,6 +1068,7 @@ static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
 		goto out;
 	}
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	kfree(id);
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.43.0



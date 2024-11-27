Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E7D609B0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EjlAXoFz2XIqbM41yoAxAFwBhFgti6gR6NuKnlZ7RVo=; b=goPPRPQiNVdwKDLAv41LKfQEp3
	/J6UO+Udsv2DTSNyp/uFZGB9ANWjxeiZbZMOVmEKbG07dhf/XejYz6TO2HHykUfCjDJR5lZCrsAWu
	Zpijp/84aPWL5I4yTlg1tWtP8XCLZ7nbgPmZaQmraKZ0ouu/0/wXNLaG6bmrGBbukHKlj4ksIaPUq
	QI7s4wkW9wkWthdIBorWr8hPfIrW28eZkAvMsTbOYe/SF8GDjSn+B7lCd/z76WYi7OfffHqTjNUmo
	hRtk7TeSPRDHNsAjvh6FlV02ndXkZQOovUf01hlk2+thO7Oaa9/EZt2wNNPhWqmfdIgWjGN5GrVuQ
	ZnCtZsOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmZ-0000000CcNr-1sLs;
	Wed, 27 Nov 2024 08:52:23 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmW-0000000CcNE-3rBL
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 08:52:21 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2ea711a76a5so5628892a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 00:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697539; x=1733302339; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjlAXoFz2XIqbM41yoAxAFwBhFgti6gR6NuKnlZ7RVo=;
        b=Wl1Usia6L7bHCtjKIU6Qn+tSWJY5FnWdekHCspIDRXZSXnA8WCd82TozOAI4DzJSv4
         7Ckuhq0uuCeniXR0sf1iUr2TYDVq7t//i7969oDpbd8Bb9O/r/ETNmvA/ByJY7t78NrU
         csqtToDKF7qUXkoWvwvnLJoxFB/ZUjpe1phBW/LTSfH0DqW+iBcUCjVKibFR9CGvu+bI
         ptNLdFSapwSbJn/752K6v4p/TdyTyG5sfEzJV3JlXV8LtWU8SZRMuKXBI3g3KTJ5qcKn
         oIg+ykvAdHBjiiaTSSnZalo20HhiUbxAwTJkOGOIqrkflVTF2XFhih6aiqAF3tjWRNKd
         5gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697539; x=1733302339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjlAXoFz2XIqbM41yoAxAFwBhFgti6gR6NuKnlZ7RVo=;
        b=VAKg85f03gA82gikuwqhGmeT8ccZv8TQTdKl2wZaKrIUTtCzBj+oxhz+SeRVSDYs/w
         BNkDPUKhwF2+Zw63BBz34O0Y6WnQB/WkRH5V9IfLKPLDHgO8wlpFUlToXB8qF/Oi9/Y9
         qBVNnHAchNN1GEylaCs9bCRHY4TUG1atiBjyMMEj7SqQDUCZ8ZvwrVs5yKDBWI/Orvgw
         AxnBtAj8vbjkeCA08uTlIAt5M520ekoWDJL2EsMf72rPIMGoFCGumU5T9FoAigA0xJE1
         3Wcl3zzsjZf32ABFNiFzK6H3n1DUQdvYz0a1dBp1OZRxzTyhO0pG/Dk7XsDYM/qYszpJ
         oGhw==
X-Gm-Message-State: AOJu0YwT4rWoOoEDh5UnHoXqItHatGjfgoOiJRntOsfWBUz2IeV0VE+t
	G7Nu9Rh2XK+cGSF3wKiy1kEdE3/ZSst2rq8M3ZZMgagb1NoKshoU
X-Gm-Gg: ASbGnctzBr7LgXPc9ROXKx1OqeMK+zymowCSvhiabeF/iuuh5pY1ZU5YtAg4gpQ/AWt
	iVi50bm+Qqp04P/V7Q+75oa5P+gRCWaNMvRgKlvUaDmfpMPIRnJpH5xS4iV9spFicOi52PsDjcZ
	llAp1DVrLnMsM53I/lUEy8yhdzX1iHMEv/Qot4X00M4rhmpZwOqnoWhUYpvqTUgRzrnl8Ddf+9r
	tB/BMcbKRa/Jf1XfC3pF7jkvqNP95l1d1JPHmv2uKCWf4Si6V6cWpIO9FyAJg==
X-Google-Smtp-Source: AGHT+IGZOzHPfNQAD3KDCajmMQ+5AJWsprxedR2u/LUupJmxIGBxc5DBj64TblnUzXu/sLlbWzFr6Q==
X-Received: by 2002:a17:90b:4b87:b0:2ea:6551:da5d with SMTP id 98e67ed59e1d1-2ee08eb2b6emr2727673a91.13.1732697539243;
        Wed, 27 Nov 2024 00:52:19 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:18 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] nvme: various bugs fix & code cleanup
Date: Wed, 27 Nov 2024 17:27:46 +0800
Message-Id: <cover.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_005220_961650_472E6918 
X-CRM114-Status: UNSURE (   8.26  )
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
nvme-tcp, cleanup the code of nvme-tcp.

Chunguang.xu (5):
  nvme-tcp: fix the memleak while create new ctrl failed
  nvme-rdma: unquiesce admin_q before destroy it
  nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
  nvme-tcp: simplify nvme_tcp_configure_admin_queue()
  nvme-tcp: remove nvme_tcp_destroy_io_queues()

 drivers/nvme/host/rdma.c |  8 +------
 drivers/nvme/host/tcp.c  | 49 ++++++++++++++++------------------------
 2 files changed, 20 insertions(+), 37 deletions(-)

-- 
2.25.1



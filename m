Return-Path: <SRS0=EBwi=32=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585FDC33CAC
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Feb 2020 19:14:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFA221741
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Feb 2020 19:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="poHTeCL2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qinQF2ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFA221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5Ht118XYwcZGzpwLh5FZMIbMLSWlZ0vi2pzmsNwSBcM=; b=poH
	TeCL2KAri/LpuJxDBwNFo3y1LYykhLI3OKoBQBXjpDfRQnlydWLYUJqUn6I44Y4lK8uS7fP5wKw2s
	QYDzdlW8ARvYv5pTEJ8n0GfkUcVPJjIDfzB/7saSdDCr18oxOUrdG5VaVBCPNRCGZLmich0apc1KN
	RTcVD+oMAEBQUF4M99Kti7fntlrMsu40/8GQv2qB+gqURFc76NDAZmKrdefn9vHTzVXkE52GSR1Dj
	yJJMQaltnBHjOosb1AaSvModMQvA2mmdL2rQ8YRxZDZHktjH+zZXFVzWNuys3wVcUcxX+LM3WrqCB
	hGJkjcyx2hFb6gEeJFNsbD9ibiXwe4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izmbC-0005vr-Nt; Thu, 06 Feb 2020 19:14:02 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izmb4-0005uj-Ir
 for linux-nvme@lists.infradead.org; Thu, 06 Feb 2020 19:13:58 +0000
Received: by mail-pf1-x442.google.com with SMTP id 185so3604486pfv.3
 for <linux-nvme@lists.infradead.org>; Thu, 06 Feb 2020 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7hgYwJSR0jlwtHcS80/GYY3tfHcSWuAza9OmAz8dpx0=;
 b=qinQF2koQnuT7miNb3LR9QrbKaRYSnejBrSHN3/MLuup6iyQybK4pn88uCB2w/8rfh
 UZbYWZBY004uKpjy6NZyD+HB/oWEYpoVCHWOQuFISVeogxuHUk8nYaSuyD6VY9mblmG6
 gWiA91EhecPZFSSzLCuu0bZLJkE5uSdwwKtT7IVC1aTlR1EGHvnAK357ncNgkE88mayn
 S/LUT2A8iSBKiuqKpQcAL5OuxxWIA/huLA2tR4EY+UF1yEc1rzdv2ZHbQfg5u74IqrYj
 yCV6/QqhUi/gV9nMsHPtsG8wQDT51DCOPny1M+oeTOPSmZrTtbE/fVY1WAA5iaZ3qHGa
 iEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7hgYwJSR0jlwtHcS80/GYY3tfHcSWuAza9OmAz8dpx0=;
 b=dcHFWXl7vepy9Pyb+GLHvICNLXWYZV8BYf2cLdXd+noRF2EZjw/q1OuLbZtYZTF06x
 bu92wzLnydy+yGuOXJtBnJQ67SLPEhHJZJwkdD+n09IcjCYMnG3oZKr24zkmHIt2e1aq
 6IECoe5Y8ULJpUHxl0l6epLs2Wotz0xXoHVxNeDinmRJUt/P1tzYUybbVeXuMp3SJJ/5
 OXOnVse/0yW1QU8/PMC5kfusBpznbE1e26b8Z4D1k15FC2IX8CN4Q5umrS+X4M9/W6DO
 UtXNnd2OT8lGadiT9j/6h4LJUfISY5RF9sSXKHVXTvuABGRa3Q2HRjwkHdhKAelelYxU
 JJPg==
X-Gm-Message-State: APjAAAUhV7fIom2hBl55mPBIOxylwh7goTbg96fLpHO8bJcWmXgo8/Mw
 PNQmNBGgiO2EDmh7ciULGugK2CJC
X-Google-Smtp-Source: APXvYqwoNBmbgTNs10OAyTx9I7NFjyis3WIq96TLUWN0fs+5527s1vGoTJYQbVBX0HVYyL/brBSkXQ==
X-Received: by 2002:a62:1c95:: with SMTP id c143mr5299919pfc.219.1581016429762; 
 Thu, 06 Feb 2020 11:13:49 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id n15sm147297pfq.168.2020.02.06.11.13.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Feb 2020 11:13:49 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme: prevent warning triggered by nvme_stop_keep_alive
Date: Thu,  6 Feb 2020 11:13:40 -0800
Message-Id: <20200206191342.10190-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200206_111354_647089_A41A1BF9 
X-CRM114-Status: GOOD (  10.84  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: maxg@mellanox.com, James Smart <jsmart2021@gmail.com>,
 mark.wunderlich@intel.com, hch@lst.de, sagi@grimberg.me
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Delayed keep alive work is queued on system workqueue and may be cancelled 
via nvme_stop_keep_alive from nvme_reset_wq, nvme_fc_wq or nvme_wq.

Check_flush_dependency detects mismatched attributes between the work-queue
context used to cancel the keep alive work and system-wq. Specifically
system-wq does not have the WQ_MEM_RECLAIM flag, whereas the contexts used
to cancel keep alive work have WQ_MEM_RECLAIM flag.

Example warning:

  workqueue: WQ_MEM_RECLAIM nvme-reset-wq:nvme_fc_reset_ctrl_work [nvme_fc]
	is flushing !WQ_MEM_RECLAIM events:nvme_keep_alive_work [nvme_core]

To avoid the flags mismatch, delayed keep alive work is queued on nvme_wq. 

However this creates a secondary concern where work and a request to cancel
that work may be in the same work queue - namely err_work in the rdma and
tcp transports, which will want to flush/cancel the keep alive work which
will now be on nvme_wq.

After reviewing the transports, it looks like err_work can be moved to
nvme_reset_wq. In fact that aligns them better with transition into
RESETTING and performing related reset work in nvme_reset_wq.


James Smart (2):
  nvme: move keep alive processing to nvme-wq
  nvme-rdma/nvme-tcp: Move err_work to nvme_reset_wq

 drivers/nvme/host/core.c | 10 +++++-----
 drivers/nvme/host/rdma.c |  2 +-
 drivers/nvme/host/tcp.c  |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

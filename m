Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB27C4742C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FDA20720
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a/iMCD94";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qxeNFI4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FDA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UJgnWqQUNI+FC3C/otn1S0FXXWKgfQWZZeIgnVhCmWI=; b=a/iMCD94KXgHSrOCl6C5EXlf4
	J+8MEhtLJG8O8h0zmxOKDku4Wn8WDfZsMkOBrhZLQMDikd+3+XV3z9wPx3bzK61bxDa5jcIaeNVfA
	LV5WTinZRcnV4RpWiMLx76MOh7nKYebtTbsWFm8BEu0CcpHhBHmq0vFkCAln1Wna8PiVqIg32sr1M
	9IDq4YoU5URQKe8mMoNMPfq/HVzfwSk6XvI9ZIP7rkqa3RFOCbbUkBsWFFzd1G6hhYTcKQia76mmq
	KmIhAMVZ4RCFFsz96XRseVTIu6893cxDIIfmzQw+QLIgq2am9eLmfe5oGupgdgzizameLp6nScnlL
	czFOHJLeg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYHeE-0000CK-Pg; Thu, 29 Oct 2020 23:48:02 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYHeC-0000Bj-FY
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 23:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604015280; x=1635551280;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ih5+nJdCXN7g9+BT5kpxUFZgmioHZojYOLccEWKR38s=;
 b=qxeNFI4+UEQuB3L6hw+ucnYUecS5xZm7R4bPLfopviDhZxnRq1OyLcEB
 7pCVSs8mzBifpgspaK1JYWtsABsgdPrArr9iLk4kIKyZUhysWjtH9KlNI
 DMa/EQ5Fe9J+hN2XXiX2tr//uQ0mU+SbZUq9VDqirdfoQLbx6udGgo8sS
 JscVKKiGhZmwoG4Sh+K0Gtgyfnd0IbjxipVfVtwzPJQjERFhkAouM52kO
 D2yK9Cgh0jLtc7gRyx1+pY1+v3M+ca0YyxnzOWla0FrPkaNMpAuPBJr/N
 7AhkK/dQiP6yhsujd5lkrNKpRy3JWhw/0/rdIv0HVPOXOnxQxWspzxYGD A==;
IronPort-SDR: CnxrhXOLXmR71A2wyK2I0c2EAf10dLqnVXBzdXtMJea3l07gw3mfYpYpaPZ1Qv2BfRIo8+nmjy
 wKEqFOBdby3MoWq9L5qIHsAYqj5zlKaDkvcNcfAZ7+o+aSAB1Grqm116B8cr7McS6E48N41xsz
 tf1clhQxjthVQVi0FlRpSI1RcVEskp9EhZ8WNAKxoUDfSaxQFLijvurXrTrNNjHQJPbPcSOYMQ
 mtT5x5gg+GcHqipHpka6Dp+cyCgbCPrTTiU2wQA96PnWgbCs4cCSJzY4mp6YdSYwcnafDQzJ3u
 ptw=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="261219075"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 07:47:58 +0800
IronPort-SDR: hPWa/Qa4zu3Q48BAi/UTrGKAVhUJhGcrQtg2ISdEVXXTqV5B8pjM0/JjEa9NKjHYQhzyhxwtPm
 AXKg5VTN0TeFYhEAq3rwSgOdikIAGfJHTlkaP0pvRnQ1B7D9u/vvzewi73b08g4ZqUXKvq9kTW
 jYWRGRfmZiTAisij/m9a2/V4a+JKxy2khKaqbU2KNQNy9OtwKvk0I5r5xyY4c+5sZaPM3nkX12
 xu4fnQBIMq1OggkZiB9pT8gr2rMBbs3cgTdEcZ6IpA9822+PtZSJxgSnCvDb5sV+V7N0dFm8sN
 6WEQrmfvRYf2Zo32DFKLCNGg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 16:34:13 -0700
IronPort-SDR: XsyBwy90h9RdROcGWpaMw6+WLrhjoApjXmqcWZ6if8rNNYY6S/CVJeRLmXW+HGs9mZ9/RWDNl+
 jFNPd+/lGUTo43TdDfrm3LGOuCAUFn5XUyW/BHfpC6kKAn7MfzmRlMVbf/xYpW0eBatEqcuiJQ
 EZaim0IjnOAfiQD/Su0ZScuXFMpuqBbr6ZxsF+y8j1siMVN9V4oacp2OcHjjXWp4vndHT9Z9/r
 0ywGGb3sHcW5ixh1fjYtGF7hBL0Fb51IlcOdA1Xq9g7dNY7xBxUDIPII7AV5fFCabaqZu+Jb6Z
 tb4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 16:47:59 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 2/7] nvme-core: use I/O timeout in nvme_submit_user_cmd
Date: Thu, 29 Oct 2020 16:47:34 -0700
Message-Id: <20201029234739.21266-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
References: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_194800_736935_F19C016D 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function nvme_submit_user_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable. This function is
also called from the user I/O command contexts (nvme_submit_io,
nvme_user_cmd_XXX) where NVME_IO_TIMEOUT can be used instead of
ADMIN_TIMEOUT.

For now we don't set the request queue's queuedata for admin command.

Use newly introduced helper function nvme_default_timeout() to set the
block layer request timeout value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42ca1b04b6d9..5feb2331df6f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1072,7 +1072,9 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	if (!req->timeout)
+		nvme_req_set_default_timeout(req);
+
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E6BC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 11:31:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF2D61057
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 11:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF2D61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXlzLug9NzWnqflfMwdHmB9fPO/rg/VnY9aOGRdtfmg=; b=puTtYXqIrSEFmac2VYW7rxivAq
	nBsw/ypeljtFKufQ9J/Lr9TN4pT2Lq5+dRBeUDdIWlcuiIOjZSqs+FJI40XGclt1mBXWLCOziAI3h
	Xy5L+TA2ZPMWuxAMLWLr0/J+rGz7G1DLwmHN/UmWpauZTkAXJ/IDDZ9oF/ZJBVydVj2/2bkkk1XFb
	DsD+IW9kxGeSaannnu4xbWD+nrpIWaAU74l3Wu1JedpRGT4EgR+2Jcq8J91BPKA7t7KRVXZOoJtKX
	yrfOBlLi8wDLMa3XnEs3ogZpF/P4Y8sayOUaSaw02OHUx4OvsnZCqbmPdoWe9v1jslzmCEKuyEIxi
	xSoJQUOg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljgtt-000URg-DY; Thu, 20 May 2021 11:31:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljgtd-000UJx-DT
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 11:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=aWE02Fkseo265GsNGUDFAHWPDQVK1FDfHfFGzV5A2zQ=; b=umn7fUmormVFuluk2AdJoz9jkW
 Wn0piegblP/DVoj9SmmlRsOKVAT5yXIZtmHrHVv2ziJPeiOzCWApYG5lDB/jkny1sg4JPS1t0vTC6
 DJMnvcsGBdphe2IG5uh44aZa+LxlZBfHKa0akMSJwNI2Cgg91uPxmPeye918coswoYXseuR63/9Tb
 7eEmsTcJXiNaOoQezdtVQgca8USGNw6iA2WTZEAUao4dIgoZxKxAsfzBxfvASHG7GlQR+DYNMDWKs
 ROqkhOvUWkn9c4CirFyKqSK8Nh/TdIyQh/Wuq57yt6g/MMA80alK4oMj3hIFVHobUndf9zolm6rLp
 VFw3ZNPw==;
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljgtb-00GFaR-1X
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 11:31:20 +0000
Received: by mail-pg1-x536.google.com with SMTP id t193so11656654pgb.4
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aWE02Fkseo265GsNGUDFAHWPDQVK1FDfHfFGzV5A2zQ=;
 b=jnnViPTuyMG8YB2UUf9sIC1AFGfA6sM3lCeb0iBlf1NHYtZQYM0+y22Csptv3XfgXO
 EfLgSj6Bh20UiW8E457D0SkZQIVyJ8zj8WnQt8d5aeALUmm7ZjFPnmLrV0xsOeR6ydNe
 1oJSVlBn28dYO3flDNXQRvB8KktzIm7wp6c9v8KAQ48fLo0Z4XaAC9zCvl7Gcf6gbbCb
 UHIuemJVLjXanVVtY3gDBJNfLfsDih7ahnrQrx0NCn3Sh1qP6blzyDR9bx29WeJV+O3b
 DVJwT6bOk6T1Py1OYx2xMAzYtR12v482vWQfMfUfE2zUTYWu86nOmK1QQcy2wQbeGitV
 n8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aWE02Fkseo265GsNGUDFAHWPDQVK1FDfHfFGzV5A2zQ=;
 b=ZLlwTQaMWQXKLNEMTCfVcY/mkfqIJaFRev5UYbg5wSz5ff50V6S0UAuH+lruhLMH0U
 Mlw3IQ5W29ze0bAg9RyopLYKLYo4EpjbUvRUS5sJLoFXQrAQ67/BKUtgHmor8gU0xUGm
 tOAeS1dZsf1Ztgvri6ETC04jeWaol3VjgoADKiJmpBAKS6OKZoeX9m2pvx/CRfPWdSae
 obG0V2TytWEcTaR6AYO6sRGHrVXQADn2K4T7m0I3khnEvF3onkjKKU4IkRW7wp3PxCR7
 suf3ypN5VCFxEBz9X34R93zIVcZgd3aTXv21yJApsQL84KFdZcchPKeR7zcevm1eqVY0
 tsJQ==
X-Gm-Message-State: AOAM530RifnnFDlYJMd37nDBYgVcMcFfC9tnI6l6dPbqh3qlUqIBdw5b
 yI6UAhiTlnprUrt0EKrnLf4=
X-Google-Smtp-Source: ABdhPJzq6H6FHTWhh3Zzn8UlhRjELOPHIOUueKwAhPci5SatT4QxRqRm1dEjW/6u83Qu9X+2KXTngw==
X-Received: by 2002:a63:e952:: with SMTP id q18mr4110205pgj.430.1621510278036; 
 Thu, 20 May 2021 04:31:18 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id i197sm1917443pgc.13.2021.05.20.04.31.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 May 2021 04:31:17 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, houpu.main@gmail.com,
 larrystevenwise@gmail.com, maxg@mellanox.com, elad.grupi@dell.com
Subject: [PATCH 1/2] nvmet-tcp: fix inline data size comparison in
 nvmet_tcp_queue_response
Date: Thu, 20 May 2021 19:30:45 +0800
Message-Id: <20210520113046.27821-2-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520113046.27821-1-houpu.main@gmail.com>
References: <20210520113046.27821-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_043119_101274_A410F35E 
X-CRM114-Status: GOOD (  12.80  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Using "<=" instead "<" to compare inline data size.

Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsing error")
Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f9f34f6caf5e..d8aceef83284 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -550,7 +550,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		 * nvmet_req_init is completed.
 		 */
 		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
-		    len && len < cmd->req.port->inline_data_size &&
+		    len && len <= cmd->req.port->inline_data_size &&
 		    nvme_is_write(cmd->req.cmd))
 			return;
 	}
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

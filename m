Return-Path: <SRS0=X7Om=YL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D6CA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED4120869
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NAX7+0D1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightbitslabs-com.20150623.gappssmtp.com header.i=@lightbitslabs-com.20150623.gappssmtp.com header.b="i1Dalu86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED4120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xdUcNzPIy5NolPX+AG3N5/Vpu4mbeAOL2OfH0fuNBaY=; b=NAX7+0D1dcoLGHyDOzC65C4MWL
	n0mkCVvVKDn0fvktOf1qkpnR0XlnGwOv4o5NTD+CKmftk8LPXB3tFHCvRGbardqT8hkmLPJ/cMzBJ
	q+U/iypPIn8n8TE+dN0+Vmdrin9WJSTo2eBzLlTWsxQnpHpDPN7OczhP01B3dtP0/AJkXO1F9p6QX
	/uWwDsYRW12E7hsA0qAX7rfh043E8UFYoxiFuQ0g6bKYNd2J0Jv0gKLcWpdT6Wz1cEKRN71kVJ2rZ
	ZIbjJs6LvJWVVkbDVZ3O3Ip79cG2tOzsJ8Rs/VwjqSOS5xeXlcpbrhzjgxjSYyYvjA1dJBSLJqUyT
	Tw4krUwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iLX43-0007ih-0k; Fri, 18 Oct 2019 18:33:27 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLX3z-0007fu-G7
 for linux-nvme@lists.infradead.org; Fri, 18 Oct 2019 18:33:25 +0000
Received: by mail-pg1-x543.google.com with SMTP id w3so3821252pgt.5
 for <linux-nvme@lists.infradead.org>; Fri, 18 Oct 2019 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=00HQUd95WWGWvik2vTXYFzuSy7fErHzjRvGPrYUIr+k=;
 b=i1Dalu86GPAMD+0cACmvx58GBhhX2bRTV0lrertQLFIIRPFrYfx6lbvolCDdGb9FlJ
 JIrZLBdqIEvdU8bQ2H+YKzXmvOvO5rYMOQW51LbCUjHvmYE9B6BwsktiFhHEWji/gQ2e
 ulA7J94DxU22pPeRj/VWaI4WR72VtE5kbdDZfQWqC8oZWyI3ykfWe767Fltbn/MOUuSe
 n1SUnueKQVEhNtinrNP2tb5xnHg/I7YbEnEdd5YwMwrKQx/4zcCWaYaiW5fk2KnaeS4M
 W1wWbO0J8tGX/5ht7UqInr/X7XWjE3VvYeeT2dIY+VTNtYETXGNKl4a6iVsWsNyXHRg4
 jBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=00HQUd95WWGWvik2vTXYFzuSy7fErHzjRvGPrYUIr+k=;
 b=HHVOsIVEcznDh3K4ialx4OVEiOVEHZTAFa88Qx2TV4DdixlX4YHs4V+aYS5MLsbZ5g
 G+4rQDdLTLuXoZbOc2WFExXWsLmkfHrinVHRn1wBQefhGNDyhWSc9y7V43OXf41nDIWM
 BpQFttbC7wkVioinvyAoBOQdb75+vSpkl6IKwI/xvnYN+aDvq0g9nulXlkFqbrVx28Ku
 ohH+p3HVMcQ2QnM3uUSpMqo4kpKqmmzk0pulq3NsN95BcGRDLWbKZmlAOXMyIWer5fSr
 kpwMWHA+OUjGaL8iTHYftN2ePR90cd062uJUyUl0dY86jT74ZdSbBpzmiukyIGjJTQ3F
 Vy1g==
X-Gm-Message-State: APjAAAXkzvpGo4EjaEPx6a0nQQPbXvEjlDlvF6IBicnV4Ok1Qfd6b6W4
 ghqoYLHC9UvkekhlLM1v1QEYZH8aj17lWg==
X-Google-Smtp-Source: APXvYqxN9JPmyWryOp6SwCy3D4diF76ny0Y+dxdeDbtF0ayBQKdnhAryxIUIyrBQ9rE6bVXGnoWqjg==
X-Received: by 2002:a63:2c84:: with SMTP id s126mr11652788pgs.54.1571423601638; 
 Fri, 18 Oct 2019 11:33:21 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:1700:65a0:78e0:b5b2:2e71:2e69:81ce])
 by smtp.googlemail.com with ESMTPSA id q33sm6822415pgm.50.2019.10.18.11.33.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 11:33:20 -0700 (PDT)
From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, keith.busch@intel.com,
 sagi@grimberg.me, hare@suse.de
Subject: [PATCH v2 1/2] nvme-multipath: fix possible io hang after ctrl
 reconnect
Date: Fri, 18 Oct 2019 11:32:50 -0700
Message-Id: <20191018183251.501-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20191018091016.GA25478@lst.de>
References: <20191018091016.GA25478@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191018_113323_739049_A9421C20 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following scenario results in an IO hang:
1) ctrl completes a request with NVME_SC_ANA_TRANSITION.
   NVME_NS_ANA_PENDING bit in ns->flags is set and ana_work is triggered.
2) ana_work: nvme_read_ana_log() tries to get the ANA log page from the ctrl.
   This fails because ctrl disconnects.
   Therefore nvme_update_ns_ana_state() is not called
   and NVME_NS_ANA_PENDING bit in ns->flags is not cleared.
3) ctrl reconnects: nvme_mpath_init(ctrl,...) calls
   nvme_read_ana_log(ctrl, groups_only=true).
   However, nvme_update_ana_state() does not update namespaces
   because nr_nsids = 0 (due to groups_only mode).
4) scan_work calls nvme_validate_ns() finds the ns and re-validates OK.

Result:
The ctrl is now live but NVME_NS_ANA_PENDING bit in ns->flags is still set.
Consequently ctrl will never be considered a viable path by __nvme_find_path().
IO will hang if ctrl is the only or the last path to the namespace.

More generally, while ctrl is reconnecting, its ANA state may change.
And because nvme_mpath_init() requests ANA log in groups_only mode,
these changes are not propagated to the existing ctrl namespaces.
This may result in a mal-function or an IO hang.

Solution:
nvme_mpath_init() will nvme_read_ana_log() with groups_only set to false.
This will not harm the new ctrl case (no namespaces present),
and will make sure the ANA state of namespaces gets updated after reconnect.

Note: Another option would be for nvme_mpath_init() to invoke
nvme_parse_ana_log(..., nvme_set_ns_ana_state) for each existing namespace.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 30de7efef003..d320684d25b2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -715,7 +715,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		goto out;
 	}
 
-	error = nvme_read_ana_log(ctrl, true);
+	error = nvme_read_ana_log(ctrl, false);
 	if (error)
 		goto out_free_ana_log_buf;
 	return 0;
-- 
2.14.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

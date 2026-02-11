Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46438ECD6C5
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BK3yyKCjJyv7t/4i3RZh0Mj38TnlrJwgJTwfSkZBWxI=; b=FvmxJDKNoO9HwgLNZpd2mkBIq2
	UZUfWQJ6Gs9JcpymXjO4S7sZoXpJj/LovlBSIOl4nsspDAK8WqU9M97M5DWHvHpGxBZoNOWAIpvHI
	kaX8IQtqXtyWmYEoITjOdkVz7a38VwqdF1eTjEwMOOK8CzVTKqvvijhU/tmE0z4ildMtWbQw3FA89
	xuQXTg1oSpBtEkTgQAMzBNYQeMBgEfN/yGtcE5yrGEEidt7NFfL7DWOGK5M/bTJZ09kTc+t0h31Pu
	0CkaS0q6vxpLwNWBDM5Cmq9/7DJzENbYJ3dCEH9Fk6lMurLPJYStG6yIuC42HG/MetBy0ej7vbfnh
	EfTCueWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqD6z-00000000qRQ-2JUV;
	Wed, 11 Feb 2026 16:30:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqD6w-00000000qQ5-22bL
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 16:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770827437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BK3yyKCjJyv7t/4i3RZh0Mj38TnlrJwgJTwfSkZBWxI=;
	b=Um5i/YE+SgW3XSCaaems8xeksakvNj1q24PCwMfI8kkzjywVj19K0uLAwoEYREBJf9jRX3
	CWaUXUk/9nl+fnIcvBwAqKlDQ7QVzZUZVAQyDUDdpjd31xUDAqrGnUR2NBx/hHiUOUx06w
	WBtZEVWDKIl65xAyY4wxo2XKDfNJheI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-7ymIkQ-cOLCY9Q-tru2Q0w-1; Wed,
 11 Feb 2026 11:30:33 -0500
X-MC-Unique: 7ymIkQ-cOLCY9Q-tru2Q0w-1
X-Mimecast-MFC-AGG-ID: 7ymIkQ-cOLCY9Q-tru2Q0w_1770827432
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ECC2195609E;
	Wed, 11 Feb 2026 16:30:32 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11A3C1956053;
	Wed, 11 Feb 2026 16:30:29 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@bsdbackstore.eu
Subject: [PATCH] nvme: fix memory leak in quirks_param_set()
Date: Wed, 11 Feb 2026 17:30:28 +0100
Message-ID: <20260211163028.76913-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7U4koKGsdbRmDDjiSBvQd_h3C2eZExRVKgsrVQxfbCw_1770827432
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_083042_596533_9100BCEA 
X-CRM114-Status: GOOD (  10.75  )
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

When loading the nvme module, if the 'quirks' parameter is specified
via both the kernel command line (e.g., nvme.quirks=...) and the
modprobe command line (e.g., modprobe nvme quirks=...), the
quirks_param_set() callback is invoked twice.

Currently, in the double-invocation scenario, the second call
overwrites the nvme_pci_quirk_list pointer, causing the memory
allocated in the first call to leak.

Fix this by freeing the existing list before assigning the new one.

Fixes: b4247c8317c5 ("nvme: add support for dynamic quirk configuration via module parameter")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a6cf0897a0f2..3e1c6adf2cf0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -219,6 +219,7 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 		i++;
 	}
 
+	kfree(nvme_pci_quirk_list);
 	nvme_pci_quirk_count = count;
 	nvme_pci_quirk_list  = qlist;
 	goto out_free_val;
-- 
2.53.0



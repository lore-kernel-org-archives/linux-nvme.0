Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98271CF9C6B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fBde9ITtlgU5yBLNmdT+kj0l5+lBO/8pcvkrtD3QZrY=; b=RcriCD+YE1TzG3zqegtSFiddTD
	uBaDS47hxDZwVh4p5AH+uKb5PLf2NeEA1LMYdc65FEeJUAc84W1UHcCdYw6gEikQzxeO6Rq6rmjlT
	LciKtfHL9IoYJN2eMcqsygfP2tsACxvpg5pa+j1HCi52/pkDLBsnQ8s5g1Glo684UKxy6EY1NLsFl
	a0uhW7e7OLKa0LyoNJXc/gbRP2WpucjoDz0UJtpA9xyl3hDSkVprQVeJhGklwisbX8k/NE151f19f
	HiKEoqfEtmGHoapj9ooDsPXmBgziIfkHx46IYm3y2rp4mn74wrAXPiQAJkag0LUfr4NgIYSRFLLFD
	dpLPB0ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st1QT-00000001hku-2fwu;
	Tue, 24 Sep 2024 09:01:41 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st1QP-00000001hio-2N86
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 09:01:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727168497; x=1758704497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PuD0Dd9Eddx583k0sX/jK2x6LobAMj2kDH70Qdf0rPY=;
  b=PH4Wb98OvjJH9RPqzvaWw1HWeAP+QIrG0EhK/ao2jMKcUMnN1CjHFzx3
   JVWGQ2H/KvgDIYcvjJeBIgX6/jDiPrwts3XbCQ6PfpZLax34D7dWYHtsV
   RhB7c7QXdG3gtffZmg42ekpa80C4bqL43LX3mwiwEf3MNaZLHWVHClRSO
   N+048l6BZhee+CEdIgAx8nvSqAfC9E0lSdo5WmgjXLWPEyeDvBiI9eV9n
   U2+UCKHET1x+EwbmG235q7BJI9YyF1CeS2gfuILYyf+OPTS7OXpF0IzBB
   /9qZu4Q+agdkT9QYj9upgYB1qvCT+hJGCM5gaJWdUgm+6/1TjzmtwTsPj
   w==;
X-CSE-ConnectionGUID: RgSY0HvTQ9y8d+A1Ckrm6w==
X-CSE-MsgGUID: 7UR/zllgSZWZsxT8JnmC+A==
X-IronPort-AV: E=Sophos;i="6.10,254,1719849600"; 
   d="scan'208";a="28275736"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2024 17:01:36 +0800
IronPort-SDR: 66f271bb_ziYrZ9iANTBx8d27pZu+KtY6RwLxjYysgWLzx7jrkNT87A2
 DWQjef7VIVagQcnGOVYYA1xYYDnOZikwHb0I3Ww==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2024 01:00:59 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Sep 2024 02:01:35 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme: null terminate nvme_tls_attrs
Date: Tue, 24 Sep 2024 18:01:34 +0900
Message-ID: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_020137_639107_CF0100C5 
X-CRM114-Status: GOOD (  10.66  )
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

Commit 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a
separate group") introduced the struct attribute array nvme_tls_attrs.
However, the array was not null terminated and caused BUG KASAN global-
out-of-bounds. To avoid the BUG, null terminate the array.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-nvme/jhllwfxcedrcxcnbajwl4x2l2ujcqowqcd4ps574zrafrqhjna@f4icvecutekm/
Fixes: 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a separate group")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index eb345551d6fe..b68a9e5f1ea3 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -767,6 +767,7 @@ static struct attribute *nvme_tls_attrs[] = {
 	&dev_attr_tls_key.attr,
 	&dev_attr_tls_configured_key.attr,
 	&dev_attr_tls_keyring.attr,
+	NULL,
 };
 
 static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
-- 
2.45.2



Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A1C43618
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:32:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C9E613CD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C9E613CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Het4ScvKHpt/X+4T6ztc8G0qZHEQlavh0rvuVLzyfv8=; b=fhxzat83jPHEQ0
	dZ/Ss5jbGyiAlH4jpHJ0Wc89SmwfvMKFrg3p63Sr//9gEopIK5587mxiYkMCj90jPocz6I3Z3pGFf
	4arogkVrCDsDYQfwChMnPFZMXUVCA5O9w05kAX8auXZifDEQx67zjPQxprQLfx2taJnG5mfe1meiZ
	5Ws+JSZHLyg1skkXZVWmlVzYUHOF714Dx6pv4GVIqxSAS62aFnfR+VlOBlg4CHWfzPk2LYB8qryVS
	z24h3/ebNPZJ35GPfiqoxhtaB0vnugrbTaYGsaI53Yv1fZDToY91naRASyJ+NqmBiQ6ntZ8A0vkoY
	IuCNZCuTjKPLHHvGuQyw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhJsW-006Yd8-28; Thu, 13 May 2021 22:32:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsS-006YcB-Nt
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=kGb8w7OA+VecwjXRg6RAtUZUrHcBmrTzMPMqQqpjkm8=; b=BxGxd1rS/no+nW4wvHk9w5ypO3
 HM92G097ElA5vsW+pt0nLzjzTM7av3OyUB/wtk0wKbjpma3+Ab257dR5UaE8rdwMTFI3+gRRmMfbj
 i/4OxBXvGHjJOZdK7b534NviC/fZqzapQMKIo+oX71gGTR1YgSCEl2udM72MMsmnIH9VgwDmyNwNO
 Q/V6HBaI8JOgAHKq9CBpOD0C4WOVjn+JIsVZoE6QTs5LLz8m+8DeRVC4UGr/5ilJH48kcHcXOHNqn
 sc/wZe4lDvGS4idcMKxyPC9lG0vYtZeRRn/G8FQIEdXmx2wfqnu2hK6PwGGCjvcitTTgd96nG+Ad4
 AN059gtg==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsP-00BZ9L-SE
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=kGb8w7OA+VecwjXRg6RAtUZUrHcBmrTzMPMqQqpjkm8=; b=eGbHnD9CNeacCKyZbuiHdS6KFZ
 NNh/EZ5WKODS1Ve6hb1tF/uAsrIqT4gYpJq4dxG0nF2fvIpAi7TpV7+/Y6LNZx1pFlY/hFAgny73W
 YtwZdP5IKdbhnFLh6KOTjJPOyogKxWXzq0K5Uu3ECThupT7cYwnsUUsGUYZBl9Fc4L7bqM9BzM7kp
 WC8F7PvsKKU2uOJ6Z2Fe47S/Ut/YmpU8uQ9Z/nZuPUE3EHFlWo3EHFOsmuSzH7OEgCTdiaglnj5LW
 nloEQgOv8SrxTyCv/NT8SVr0wrClZ2lqYuGBcRUJczrCPrgJ3bbnOLMmFmVp7MYt9Q7mA3ab0Nreo
 FRk7EUkg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsL-0000nD-QQ; Thu, 13 May 2021 16:32:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsF-0001SX-Uh; Thu, 13 May 2021 16:32:07 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 13 May 2021 16:31:43 -0600
Message-Id: <20210513223203.5542-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 02/22] PCI/P2PDMA: Use a buffer on the stack for collecting
 the acs list
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153217_998139_E46CC344 
X-CRM114-Status: GOOD (  15.29  )
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

In order to call the calc_map_type_and_dist_warn() function from
a dma_map operation, the function must not sleep. The only reason
it sleeps is to allocate memory for the seq_buf to print a verbose
warning telling the user how to disable ACS for that path.

Instead of allocating the memory with kmalloc, allocate it on
the stack with a smaller buffer. A 128B buffer is enough to print
10 pci device names. A system with 10 bridge ports between two devices
that have ACS enabled would be unusually large, so this should
still be a reasonable limit.

This also allows cleaning up the awkward (and broken) return with
-ENOMEM which contradicts the return type and the caller was
not prepared for.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 6f90e9812f6e..3a5fb63c5f2c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -500,11 +500,10 @@ calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
 {
 	struct seq_buf acs_list;
 	bool acs_redirects;
+	char buf[128];
 	int ret;
 
-	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
-	if (!acs_list.buffer)
-		return -ENOMEM;
+	seq_buf_init(&acs_list, buf, sizeof(buf));
 
 	ret = calc_map_type_and_dist(provider, client, dist, &acs_redirects,
 				     &acs_list);
@@ -522,8 +521,6 @@ calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
 			 pci_name(provider));
 	}
 
-	kfree(acs_list.buffer);
-
 	return ret;
 }
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

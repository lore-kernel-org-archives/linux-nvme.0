Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4C9C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:55:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B18D613E6
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B18D613E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3m7rZl1lLnFwMxrc7FlQiX1RMfLrd/JNqi2lohiw3zc=; b=f1T2pdK1XEiRXB
	ADZikR+qnyEDP7VqBxKSruPbyomiqmAiqzAUguy15IbogHJp7T2ZUoput8lNP8+GzYI0HYbl5eIHQ
	KJfokOdTm9I7gJdPmtYCY+71gFd57yiI73D9/Bht/KSB/sgHlgXWmVgjJ6FaFYsZ6me2sJ1CHFz21
	RUwZc5gQlLRCgp005YXWxz+t/izIpsKm3O147BWa/49LRnp3DGxxSf6tcUJv8IWas0YdtCEdouOJm
	7PdxswwIQGNDgoNSfFprvHOpkWlwdNRKz+XiPquuSFlsJjtLzmaH6eg7XzweGI6K0vimIbTV0QT5z
	KZFFNy6uIpOoDqvjuH7g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhKEk-006bd7-Qw; Thu, 13 May 2021 22:55:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsd-006YeY-8A
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=hPXhcihXAoH8RGaPYoi+qDN3LVubyQfJAgOHoQY58UM=; b=x+uEGuagQnSsHBogR6T6OPaH3W
 dIaXiBb9xFduOhdrD4HiAQGdQDP3rq2qyvcEDT1m1qGbqlLU3B9owvvervp7WdO7YRmx4YW+0s1F/
 xN43nIpYOfiJ1oRqlKTqIWNWuMQ0DefPx9WpvQgAixYB8uXOiscksVpLKuyoSkqykoH9g9dJ9Iczr
 xhiCPhc6DIZeSQ4gRqtc9uQ8sjxKnt11gLyyG933GR+txCyiWvN5h5E+a5+PTaHTLgbtEMelzjYFJ
 SMnCbJk06rujzaKY976OkwjxUfMgAKdtq0JxtlGXGyI5cE5H86cB3RhYm16Yn7hwlZXuFvJr7GtY0
 Xu252acA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsa-00BZH9-Ga
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=hPXhcihXAoH8RGaPYoi+qDN3LVubyQfJAgOHoQY58UM=; b=AJLAGCyL3f4e5xzFbUQ1yVN3cU
 cfpilAC8VhbDKR/rU1qGZpfArLVz5bmlSiNDtkd9Rd8yH0+gfwKMVE80p9zm5420S5vX4IJvKZ6j/
 T2TwuNQpSwbVaD8vI4CePH2nNGQsM0SbEeTBtaU9GwmpHvDHRX3pug4qLd3rpAdbY5agFTV1UO9Iq
 8xOs+p+PX8CFAJ8wtQnJ5SXl0GGWAh+NQiysec3JJ0JzBppU3VYYCchvsyhROMI4sovCFKTEL2biO
 29H9YJoEh5bn7UTnpiUzssbA/UMM9v1OeaKmCk90ULINe+TO62pIjvtvLHXrnmcB2t2q+61rYbfzD
 8MUkVIkw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsZ-0000nF-AO; Thu, 13 May 2021 16:32:27 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsG-0001Sh-AJ; Thu, 13 May 2021 16:32:08 -0600
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
Date: Thu, 13 May 2021 16:31:46 -0600
Message-Id: <20210513223203.5542-6-logang@deltatee.com>
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
Subject: [PATCH v2 05/22] PCI/P2PDMA: Print a warning if the host bridge is
 not in the whitelist
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153228_571777_8225F580 
X-CRM114-Status: GOOD (  13.80  )
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

If the host bridge is not in the whitelist print a warning in the
calc_map_type_and_dist_warn() path detailing the vendor and device IDs
that would need to be added to the whitelist.

Suggested-by: Don Dutile <ddutile@redhat.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 175da3a9c8fb..0e0b2218eacd 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -340,7 +340,7 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 }
 
 static bool __host_bridge_whitelist(struct pci_host_bridge *host,
-				    bool same_host_bridge)
+				    bool same_host_bridge, bool warn)
 {
 	struct pci_dev *root = pci_host_bridge_dev(host);
 	const struct pci_p2pdma_whitelist_entry *entry;
@@ -361,6 +361,10 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 		return true;
 	}
 
+	if (warn)
+		pci_warn(root, "Host bridge not in P2PDMA whitelist: %04x:%04x\n",
+			 vendor, device);
+
 	return false;
 }
 
@@ -368,16 +372,17 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
  * If we can't find a common upstream bridge take a look at the root
  * complex and compare it to a whitelist of known good hardware.
  */
-static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
+static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
+				  bool warn)
 {
 	struct pci_host_bridge *host_a = pci_find_host_bridge(a->bus);
 	struct pci_host_bridge *host_b = pci_find_host_bridge(b->bus);
 
 	if (host_a == host_b)
-		return __host_bridge_whitelist(host_a, true);
+		return __host_bridge_whitelist(host_a, true, warn);
 
-	if (__host_bridge_whitelist(host_a, false) &&
-	    __host_bridge_whitelist(host_b, false))
+	if (__host_bridge_whitelist(host_a, false, warn) &&
+	    __host_bridge_whitelist(host_b, false, warn))
 		return true;
 
 	return false;
@@ -513,7 +518,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
 		if (!cpu_supports_p2pdma() &&
-		    !host_bridge_whitelist(provider, client))
+		    !host_bridge_whitelist(provider, client, acs_redirects))
 			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

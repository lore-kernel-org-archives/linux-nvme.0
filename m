Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640EF606A320
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T/YqXtOP;
	dkim=pass (2048-bit key, unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=T1t2jRp4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=9GksjCUt61tneKQonk5k4yGW1d91mGEwlUuzESkWVdM=; b=T/YqXtOPgL/VP65JJJ6UweIswg
	xZYxbW6QjU0CWgr96ySbi/lusxNy+6fh4PF/OgPKCxLYn6Gup31NZSBbPhmSbgxCo7yeHeaEPLDFc
	IKKZ5rHFRAHa2w7DCYFjs34hAqmup0M3BNFvXDwEblWG8tuqfUJik65Qj12uWWRx4UJSYSXN/N8f5
	nzLcp/aqdvftAINXssNaBZYh3tuaOdLKni6K5bz9q9xZjV3j8HvnlDNaP+UQNL/0oeC+Ep1PKgGqB
	EIVCmT45JkOaLNmu/nFADq+GYDxFVTX/13CV/UJi4JfU9vKnmeTovmUM1ieyrbsFdOHxlisnG6KNX
	TQjpJhzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNGl4-0000000DhtA-1PCm;
	Sat, 31 Oct 2026 21:37:02 +0000
Received: from [80.12.242.76] (helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNGkw-0000000Dhsm-2yKN
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 21:36:56 +0000
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id NGkpxLFbCq3IhNGkpxq0kr; Sat, 31 Oct 2026 22:36:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1793482609;
	bh=9GksjCUt61tneKQonk5k4yGW1d91mGEwlUuzESkWVdM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=T1t2jRp4vCVQgbFqdPR+5NhpVM1dink/iDTDwrZDzwg+2FgvxTRyKQbqs+P1fcMik
	 YDjv6RXviLwQJx+w/dYPmT9kuUfwUxTOrvSiDt+HbDoA4MZHOa2A8xBDv+XpcJql2T
	 8AUsj83SJyj4AG0tYHcbrdomrjkWkQrpqbs/ASgCbzH+NXbihCbouVniSa33RgWiPE
	 HEtQWDY1vpC9kAG/30oHFhxIe2yKWN50GFLRDbPt/NFxDDUOpeSY2cXlB8TeQQxdzi
	 y97GvZUKDW+Opj7hTnhs+alh4HrGrzC8ghNOZIesKBgrvzQSqm6+xE51gPzeqT4n80
	 lvT/L+Az7gLOA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Oct 2026 22:36:49 +0100
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: pci-epf: Constify struct pci_epf_ops
Date: Sat, 31 Oct 2026 22:36:43 +0100
Message-ID: <3e4d3ffc4e3ec822759782afbaac1279c4a83135.1793482573.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261031_143655_154056_EC6D0485 
X-CRM114-Status: GOOD (  10.41  )
X-Spam-Score: -1.3 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

'struct pci_epf_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  90026	  19680	    768	 110474	  1af8a	drivers/nvme/target/pci-epf.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  90090	  19616	    768	 110474	  1af8a	drivers/nvme/target/pci-epf.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/nvme/target/pci-epf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index c683450df422..377cd428fa65 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2587,7 +2587,7 @@ static const struct pci_epf_device_id nvmet_pci_epf_ids[] = {
 	{},
 };
 
-static struct pci_epf_ops nvmet_pci_epf_ops = {
+static const struct pci_epf_ops nvmet_pci_epf_ops = {
 	.bind	= nvmet_pci_epf_bind,
 	.unbind	= nvmet_pci_epf_unbind,
 	.add_cfs = nvmet_pci_epf_add_cfs,
-- 
2.56.0



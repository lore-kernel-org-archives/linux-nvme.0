Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4503DEDEBE0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+bYJxoGJiSgadF5JuKBSKfLsqU/3X+2Cl2fZ2lKuHEQ=; b=fhse5PtjXd/ejQln/EVF+eg8kG
	FZa7PUiS/Jj5OmR/hpgaJpCuAo0H/xMl0yf0/WbZHoIuna1bUNscZXW7WpM7KpbbvLCyp5QuPUp3s
	Car0IXGd4J65BKllL1zkHqIwZwU7wBJvUyAmtRgnDxANi88qJ40r5y44D878VcoTdHWXwS2PAvvbb
	J/RwaFFusIhy5mRYpZEJle2Rnn71weLP0udYp58Z9eMR47Av5RKQDDrttIW0ZxNZ0a0IhGG9TJtjd
	/IsyRxIuPf3Uw3rM/HmtbULemWz5MNOdSDeY2fmDp0nGbmmcHIkuW6wRfsJsg5gc4JQDvTj82iUqa
	v2Muk78Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxV37-0000000Fjxj-3IlI;
	Tue, 03 Mar 2026 19:04:53 +0000
Received: from out-188.mta1.migadu.com ([2001:41d0:203:375::bc])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxV33-0000000FjxJ-487t
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 19:04:52 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772564680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bYJxoGJiSgadF5JuKBSKfLsqU/3X+2Cl2fZ2lKuHEQ=;
	b=s1D4OrrTwU9i2oEBicHGxlYuSQO+Jqn+FHKbmV72z6ui6q6lUNfJSnS0xxf4eDvWBSRSCw
	+PtOWeLF8GH8ZC9WR65nngvkvlhMB8TxF3ZTFNinZGskWp0rYcEy43Dt1uRFf0YhRT2mPp
	I4h1loe8kIoa+w322SVLwy3jnUaIvpY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nvmet-auth: Don't log DHCHAP keys in nvmet_setup_auth()
Date: Tue,  3 Mar 2026 20:03:50 +0100
Message-ID: <20260303190350.78705-4-thorsten.blum@linux.dev>
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_110451_066600_7477FCD4 
X-CRM114-Status: UNSURE (   8.56  )
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

When debug logging is enabled, nvmet_setup_auth() logs the host and
controller DHCHAP key bytes. Remove the keys from debug logs to avoid
exposing key material.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/nvme/target/auth.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 2eadeb7e06f2..f24add0bb86f 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -199,10 +199,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		ctrl->host_key = NULL;
 		goto out_free_hash;
 	}
-	pr_debug("%s: using hash %s key %*ph\n", __func__,
+	pr_debug("%s: using hash %s\n", __func__,
 		 ctrl->host_key->hash > 0 ?
-		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
-		 (int)ctrl->host_key->len, ctrl->host_key->key);
+		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none");
 
 	nvme_auth_free_key(ctrl->ctrl_key);
 	if (!host->dhchap_ctrl_secret) {
@@ -217,10 +216,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		ctrl->ctrl_key = NULL;
 		goto out_free_hash;
 	}
-	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
+	pr_debug("%s: using ctrl hash %s\n", __func__,
 		 ctrl->ctrl_key->hash > 0 ?
-		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
-		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
+		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none");
 
 out_free_hash:
 	if (ret) {
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4



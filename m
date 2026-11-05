Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CA606D802
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kJjiEmC9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=roeOiANIDFUwCk1N8kNAgvb2U58m5KoSZCuD7m0gbng=; b=kJjiEmC9irQwYbN2EUDhqsDKSE
	eGK5nPews3hr0JDtT9NapurylHNqOjqx9HBmumx1gt+oyOSMfMHA8ihVMvUKEA5eYxOYrYZ6M/SRG
	i2NBKtceMQGdXBAqKIVZysJdq68scZCRb4oEpnXc22KGaTA6X18/bMeG5Pm3GQrSnFNS+GtoctLOW
	n/PcQE46AFHSyK/uIVvQgVPQkNZeyr9PTWr6etc37AR0pk1Y+40Hn1eESr8nM3Aqv1dUq3MIqHJRA
	EZOpPrFrf7JWc9Ynr2fYymt6Jq1pWNd1Evx+0kiz/bwB4Dt656ndcxdHlYfZJJn2RR2zwLPuEpoO8
	aKrNh3qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxyu-00000009CYT-2R4W;
	Thu, 05 Nov 2026 13:58:20 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxyr-00000009CVN-0qn7
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 13:58:18 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jL3ml3HNbz8Xrnt;
	Thu, 05 Nov 2026 21:58:15 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A5Dw6So060372;
	Thu, 5 Nov 2026 21:58:06 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 5 Nov 2026 21:58:07 +0800 (CST)
X-Zmail-TransId: 2afb6aec8b6fdec-d453e
X-Mailer: Zmail v1.0
Message-ID: <20261105215807526OqR0Bg86VChvwhCEz5xGr@zte.com.cn>
Date: Thu, 5 Nov 2026 21:58:07 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBudm1lOiByZWplY3QgaW52YWxpZCByZWNvbm5lY3RfZGVsYXkgc3lzZnMgdmFsdWVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6A5Dw6So060372
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 05 Nov 2026 21:58:15 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEC8B77.000/4jL3ml3HNbz8Xrnt
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_055817_407948_75DD2FEA 
X-CRM114-Status: UNSURE (   7.70  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_ctrl_reconnect_delay_store() stores whatever kstrtou32() accepted
into opts->reconnect_delay without validating it.  The nvme-fabrics
option parser refuses reconnect_delay values that are zero or negative,
and the rest of the driver relies on that: nvme_ctrl_loss_tmo_store()
computes

	opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
					    opts->reconnect_delay);

Writing 0 to reconnect_delay and then a positive value to ctrl_loss_tmo
therefore divides by zero in the kernel.  In addition, a value larger
than INT_MAX is truncated to a negative int in the assignment and
silently bypasses the checks done by the fabrics parser.

Reject zero and values that do not fit into the signed int field.

Fixes: 764075fdcb2f ("nvme: expose reconnect_delay and ctrl_loss_tmo via sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport.

Writing 0 to reconnect_delay and then a positive value to ctrl_loss_tmo
divides by zero in nvme_ctrl_loss_tmo_store():

  unpatched                            patched
  reconnect_delay=0 accepted           write rejected (-EINVAL)
  divide error, kernel panic

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 10018c6356b6..d7309a55aa8a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -634,6 +634,14 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 	if (err)
 		return err;
 
+	/*
+	 * reconnect_delay is used as a divisor by nvme_ctrl_loss_tmo_store()
+	 * and the reconnect logic expects a positive value, just like the
+	 * nvme-fabrics option parser does.
+	 */
+	if (!v || v > INT_MAX)
+		return -EINVAL;
+
 	ctrl->opts->reconnect_delay = v;
 	return count;
 }


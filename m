Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEC7EDEBE9
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qQr9ZqAyM8io49WgQ8vaaIUK9upELLZWbIDcV54JoHg=; b=hK3MIp+ya1vkjDhtr70lvBrNGQ
	jI5vNKWJAq7c/dtUVGMpZRfE+paAFeyO74/q8IyO/Nrw64h4N+HRrkwcKHJfQFQN43qkmFJ02A3DF
	M35eFM+m0i17tahli4Uec/2enEpD75YuPGXr7awEmt42WJHBVnfxhYEIZGB1M5zsIvq3RR5B5qLdc
	AZkV2psZ5rjlmlLCPQTBovgUazhdp43z5+p70BoRF1cvOKMg3bkc4GYID8va7dO/Vpga5omfi//Wp
	W9ePZ3xT/dtxENXg5p+4DTVFot247STktwJDXedQn+T1o4qar4dWub8u4TsRSD6zV9I6JrQhazpi+
	39APS7Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxV3E-0000000Fjzt-3g5v;
	Tue, 03 Mar 2026 19:05:00 +0000
Received: from out-183.mta1.migadu.com ([95.215.58.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxV39-0000000Fjwb-0pQb
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 19:04:59 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772564661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qQr9ZqAyM8io49WgQ8vaaIUK9upELLZWbIDcV54JoHg=;
	b=pYa8kbRmvIJbC712lvFNCjfQXGOOj5FABHqsC4TOPemBYI70+lEGTUToAJG7A12c9efEvo
	2O+455jx6BUk7ZFdXxQGniNsitRo1mIJIEGHmn5AQkKl5Ge7fsxwK3LApKjCvXjLuuA4Qn
	rrU4WnQZ9trUTPYBX48zYgMOxNQpV6w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nvme-auth: Don't log shared secret in nvme_auth_dhchap_exponential()
Date: Tue,  3 Mar 2026 20:03:48 +0100
Message-ID: <20260303190350.78705-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_110455_425991_60656537 
X-CRM114-Status: UNSURE (   9.00  )
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

When debug logging is enabled, nvme_auth_dhchap_exponential() logs the
DHCHAP shared secret. Remove the log to avoid exposing key material.

Fixes: b61775d185a3 ("nvme-auth: Diffie-Hellman key exchange support")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/nvme/host/auth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 405e7c03b1cf..5e4df2ac3cc0 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -655,8 +655,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return ret;
 	}
-	dev_dbg(ctrl->device, "shared secret %*ph\n",
-		(int)chap->sess_key_len, chap->sess_key);
 	return 0;
 }
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4



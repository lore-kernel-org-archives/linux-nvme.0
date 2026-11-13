Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1570606B261
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UhMEJiM9;
	dkim=pass (1024-bit key) header.d=scst.dev header.i=@scst.dev header.a=rsa-sha256 header.s=mail header.b=OTRA4icC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=0jtrBX8FtvSLkOBcHo3ilWdn8svmU2wZqpyXZecbL3A=; b=UhMEJiM9kDN0eFzEhLTV5zVEMi
	Ef3nv/GlYzY8Xxe8xXYzJ5kauoN5ILdbNuBmcNmBJSF7/N0wvHRgzfthAhzMqxEQn8d+SmQT9Gc2j
	b/yM1u9JBAKP27xn8va0ERlB+IFYFshL2YIJ+Xg0yYHlmXJO2+8vSE3nY92lQpY60DZuEYUYQL6eD
	YLYPL8rg3FyXf3f47uNgieVb4HtE11jPyB2kZeOv/9UjVASp96QQUThCzjbf0ovzPMcREQd0/Phn8
	Qqi618lvvY3ACya62B0xxspMbXdXaIdxBTRSaE2FGBKf8JQcXduhNkkFU9zsMVapRBSwQdOs5t93l
	JOWmIQsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRp3d-0000000CS6F-12By;
	Fri, 13 Nov 2026 11:03:01 +0000
Received: from forward101d.mail.yandex.net ([2a02:6b8:c41:1300:1:45:d181:d101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRp3Y-0000000CS4Y-10VF
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 11:02:59 +0000
Received: from mail-nwsmtp-smtp-production-main-77 (mail-nwsmtp-smtp-production-main-77.yp-c.yandex.net)
	by forward101d.mail.yandex.net (postfix) with ESMTPS id 7441DC0056;
	Fri, 13 Nov 2026 14:02:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77 with ESMTPSA id m2T1LaofYiE0-Hlo0eWK1;
	Fri, 13 Nov 2026 14:02:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scst.dev; s=mail;
	t=1794567770; bh=0jtrBX8FtvSLkOBcHo3ilWdn8svmU2wZqpyXZecbL3A=;
	h=Subject:From:Cc:To:Date:Message-ID;
	b=OTRA4icC8TyQw7bedOfZ56n6WX2UnOYyEwLgWD6ztbrfp91c3Kdg0mHdDXmai9dr+
	 xxKMCwg1DQcwugQpnD4c4poUQW1ONjjV6ywhlFHtSHiQeSy1LyuakkveHvJLtmgID2
	 i8krOWdCKX33zX8Tzx1XDZHswlg9dcd7X4ZtgNMw=
Authentication-Results: mail-nwsmtp-smtp-production-main-77; dkim=pass header.i=@scst.dev
Message-ID: <0099f610-a48b-4557-8515-e4df444262e8@scst.dev>
Date: Fri, 13 Nov 2026 14:02:47 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, kbusch@kernel.org,
 linux-kernel@vger.kernel.org
From: Gleb Chesnokov <gleb.chesnokov@scst.dev>
Subject: [PATCH] nvmet: report backend transport errors as path errors
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_030257_976814_B3DEB9C1 
X-CRM114-Status: UNSURE (   7.72  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The block backend maps BLK_STS_TRANSPORT to NVME_SC_INTERNAL with DNR
set. This discards the backend's transport error classification. A Linux
native multipath host completes the request before considering path
failover, even if another controller can still access the namespace.

Map BLK_STS_TRANSPORT to NVME_SC_INTERNAL_PATH_ERROR without DNR instead.
The transport failure is behind the controller, so report an internal
path error rather than a host path error. Associate the error log entry
with the namespace, as for the existing access-denied status.

This allows otherwise retryable native multipath requests to reach path
error handling.

Signed-off-by: Gleb Chesnokov <gleb.chesnokov@scst.dev>
---
OpenAI Codex assisted with the code analysis, patch and changelog.

 drivers/nvme/target/io-cmd-bdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 72618dced191..da640b8e8241 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -167,6 +167,10 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		status = NVME_SC_ACCESS_DENIED;
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
 		break;
+	case BLK_STS_TRANSPORT:
+		status = NVME_SC_INTERNAL_PATH_ERROR;
+		req->error_loc = offsetof(struct nvme_rw_command, nsid);
+		break;
 	case BLK_STS_IOERR:
 	default:
 		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.56.0


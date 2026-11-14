Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6229606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cH/m1lHU;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=dWLePgFo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2pYc6UijVi1dVzKNNbe4/SSGyC+4QOdNzqCFDBVOzCQ=; b=cH/m1lHUXKpuFCx36VQ5WPqE+Z
	VCqbLVviWd0qr8GeI8ysS2VvIKrHJsgDSgvKihR+wNZli9Thrpnb+H/OyB27l2S1S5ANmE7MFyCMV
	qr51Q7tXlRVhu+smYqfQ0Q7GEZBgH8WL18aqpyKFvwpE3iDBaVRYd4SF8R8XrsUV+gJuMI8Fsonzj
	3ML9CB7iOJSnKuCJAhnNyqCQ234A2uuATbA3gTQ/qPv4UcK1SJxf7D1xLpW0TVegm5QQ+6XQIcGnL
	5ZnU5mVXGJKJAy4ffO6AObPYI7PcW0kObEbOR7Q+Js1CrsKpH1JJ15+s+5zI2klAB6qFi7hLUbFQW
	A3xkmc0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJAJ-0000000GeHa-2naH;
	Sat, 14 Nov 2026 19:11:55 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHXm-0000000GWxv-13xB
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 17:28:05 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0W3jw4z4yjS4;
	Sun, 15 Nov 2026 01:27:55 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677275;
	bh=SQAa9s9qVGymsPeujlLVA0PUZrLDkbbjCB3mFYRW+a0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=dWLePgFoyytFzOJvuO8XQnDCLYrbyhVcVMBIYrO1tijTMZIX/KIIHxlyZG19Mtu/A
	 3Z3c4UptpNfRGoIzomtTYrD6CIQy08mx6iK6RZQqWRVv555GKbld1C/wHxR6cf3wJX
	 PZEyN97hHVHOgg2QdmGhCocv19sOBE19GuN37ZzgZnnOvSco9oZr8yqEn4Cb1zs1Ea
	 u2Z0NLqmx+TXCw/KfEdTUfzDjjiBUz+RC0np9LKFn6hqU/UtJyKsVuRMQbRO5Fsn+9
	 r9w1cmiPlQdFJUedztNvHbgZ6o0P+KxKbkZVOFOXk+8YAwwidgfMe5f0Tbpg7CFAaa
	 Pum8ueiFcqKPw==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6AEHRmaU012382;
	Sun, 15 Nov 2026 01:27:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:52 +0800 (CST)
X-Zmail-TransId: 2afc6af89a18f0a-53eb7
X-Mailer: Zmail v1.0
Message-ID: <20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn
Date: Sun, 15 Nov 2026 01:27:52 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvNV0gbnZtZTogem5zOiByZWplY3QgYW4gb3V0LW9mLXJhbmdlIHpvbmUgYXBwZW5kIHNpemUgbGltaXQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AEHRmaU012382
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 15 Nov 2026 01:27:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A1B.001/4jRh0W3jw4z4yjS4
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_092802_663923_46A4A4A2 
X-CRM114-Status: GOOD (  13.91  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Sat, 14 Nov 2026 11:11:54 -0800
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_set_max_append() computes the zone append limit as

	ctrl->max_zone_append = 1 << (id->zasl + 3);

where zasl is a u8 from the controller's Identify Controller ZNS data
structure.  A value of 29 or more shifts a 32-bit int by 32 or more,
which is undefined behaviour even with the kernel's -fno-strict-overflow;
GCC may turn the result into zero, one, or another arbitrary value.  The
limit then either disables zone append or advertises a size larger than
the controller and the block layer expect.  This is reachable with a
malicious or buggy controller.

Use an unsigned shift, and fall back to max_hw_sectors, as for a zero
ZASL, when the reported value does not fit.  Warn once about the invalid
value so the device can be identified.

Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with a host-managed
zoned null_blk exported through nvmet and connected over the loop
transport, so the host driver and the target run in the same guest.
A TEST-ONLY hook makes the target report ZASL = 29 in its Identify
Controller ZNS data; only the nvme host patch differs between the two
runs.

The out-of-range shift silently collapses the zone append limit to one
sector on the unpatched driver; the fix falls back to max_hw_sectors
and warns once:

  unpatched                            patched
  zone_append_max_bytes 512            zone_append_max_bytes 1044480
  (max_zone_append = 1 sector)         (fallback to max_hw_sectors)
  no warning                           "invalid zone append size limit 29"

 drivers/nvme/host/zns.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index e31ec6f4f94f..c34015e68f81 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -27,10 +27,15 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 		return status;
 	}
 
-	if (id->zasl)
-		ctrl->max_zone_append = 1 << (id->zasl + 3);
-	else
+	if (id->zasl && id->zasl + 3 < 32) {
+		ctrl->max_zone_append = 1U << (id->zasl + 3);
+	} else {
+		if (id->zasl)
+			dev_warn(ctrl->device,
+				 "invalid zone append size limit %u\n",
+				 id->zasl);
 		ctrl->max_zone_append = ctrl->max_hw_sectors;
+	}
 	kfree(id);
 	return 0;
 }
-- 
2.43.0


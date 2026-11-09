Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DE606EE95
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zpskDgi2;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=FtQneOuQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PgCg/UbfSF4Y1FceeCMsI+hOq/EPutTDQs5k6Ln033M=; b=zpskDgi2/XtJyUm1FzzY9YAzIp
	g/dbNHyGnJZUWFsUPNE6uewUhaWYiQqtlAax+pQUiHOKfC1dm5IPT/6+ejalpr9zTBKuYfjkJuAtH
	F+o5MJKf+KpXpIHPLCVKAll3h05u8MoW3jD/shUhsolOI7M9ogA/IIXYs1t6AWIlu7ZC/njDyIi6+
	DM1MAWs49+D8qUNksdmUH3YFW1w4BPd5LIZBJKFq6Oy9Nmzm9rGt8AfpAUS1FBFZMeA4AH8tsI/q7
	p88PyZXYF5mvMK1KZOoM4DCsaxQXhQvkfQGQUE/HX/Bzo/dbKJh8O+C9+pEPM4fAUAM1WM0LnQE//
	bS05nDMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQSnG-00000001ICN-0yyF;
	Mon, 09 Nov 2026 17:04:30 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQQqS-000000010R4-0ZRx
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 14:59:41 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jNXxJ6l7Vz4xNtl;
	Mon, 09 Nov 2026 22:59:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794236356;
	bh=VyzFy1x5es8MPjdHAbjHFFb6uwYxP6AKzrLvrgEJcko=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=FtQneOuQk7O9zoipD+DRh3k+7+Lgm8xQZ2yBMAh0b33ZB8sKWA3EowMtwZS9av1WG
	 8KfwGMoHWPzP7iDJEXFSzJRazhNaUvEhQUoyNNFcLxNxBsYdVZSu6ldoHBYFfU3YMJ
	 DD3Yx8TB9fiQigyBYFmlMG3t59Fr7QJmHfXNCR3KgGkqekLOfF/2rXCbWrdHN/ONlf
	 KSWJGOrWiwzX7tLS6U0Nbl32akzVbcE6sleg1xShaI4wL6pE8NBuHSTLt8znoyJLYy
	 ekoYNGQr2RCSptfQ6m/sFgUC11tlrDS6YvILVRE20K2EJ/YnHZKo5yBmp7fypEQVS/
	 dqtmQg4hmtolw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A9ExGLY093656;
	Mon, 9 Nov 2026 22:59:16 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 9 Nov 2026 22:59:19 +0800 (CST)
X-Zmail-TransId: 2afa6af1dfc75d7-7d398
X-Mailer: Zmail v1.0
Message-ID: <20261109225919740-DfVem3ttLxIAe7wl3Puh@zte.com.cn>
In-Reply-To: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
References: 20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn
Date: Mon, 9 Nov 2026 22:59:19 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <hare@suse.de>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZS1hdXRoOiB1c2UgdGhlIHBhcnNlZCBvZmZzZXQgZm9yIHRoZSBESC1DSEFQIGtleQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6A9ExGLY093656
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 09 Nov 2026 22:59:17 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1DFC4.000/4jNXxJ6l7Vz4xNtl
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_065940_343507_93453AF8 
X-CRM114-Status: GOOD (  10.57  )
X-Spam-Score: -4.4 (----)
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:04:24 -0800
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

nvme_auth_parse_key() accepts the DH-HMAC-CHAP key with

	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
		return -EINVAL;

and then skips a hardcoded ten characters:

	key = nvme_auth_extract_key(secret + 10, key_hash);

The ten characters assume that the hash identifier is exactly two
characters long.  A string such as "DHHC-1:1:" still makes sscanf()
return 1, and secret + 10 then points one byte past the NUL terminator
of the buffer.  nvme_auth_extract_key() starts with
strlen(secret), so it reads past the end of the allocation.  The sysfs
dhchap_secret and dhchap_ctrl_secret stores only require seven
characters and a "DHHC-1:" prefix, so a short value reaches this code
(even though the nvme-fabrics option parser rejects secrets shorter than
eleven characters).

Use the %n conversion to obtain the real offset after the
"DHHC-1:<hash>:" prefix and reject a string where the prefix is not
complete.  This accepts both one and two character hash identifiers and
never starts the key past the terminator.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, KASAN) with a live loop
controller and host DH-CHAP.

Writing the 9-byte secret "DHHC-1:1:" to the dhchap_secret sysfs
attribute makes the driver start the key ten bytes in, one byte past
the NUL terminator:

  unpatched                            patched
  KASAN slab-out-of-bounds in          write rejected (-EINVAL)
  strlen/strrchr, nvme_auth_extract_key

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index e2e0c736540a..1fdc4e4ed0b9 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -489,17 +489,19 @@ int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret_key)
 {
 	struct nvme_dhchap_key *key;
 	u8 key_hash;
+	int offset = 0;
 
 	if (!secret) {
 		*ret_key = NULL;
 		return 0;
 	}
 
-	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
+	if (sscanf(secret, "DHHC-1:%hhd:%n", &key_hash, &offset) != 1 ||
+	    !offset)
 		return -EINVAL;
 
 	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
-	key = nvme_auth_extract_key(secret + 10, key_hash);
+	key = nvme_auth_extract_key(secret + offset, key_hash);
 	if (IS_ERR(key)) {
 		*ret_key = NULL;
 		return PTR_ERR(key);


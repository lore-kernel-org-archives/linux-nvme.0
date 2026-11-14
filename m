Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49F606A89E
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r57ZSPbr;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=k/n87MZt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=WRNLrpU2e5LOoIR+wQJ0Ri4kspqhz6hENoSzU9nHoLQ=; b=r57ZSPbraCPuLICGlVfUi4k3+H
	BcnJXiuBSU+/ogpVGV0+20nrr5x5oIp0nFQ/uhVrA06PVAJMSKoEzPl2dXfVpRFVMyeWNHeX3+kCF
	quc6qUbXnqYLS2t6SKM93Fg0CHIiuOz1VgWQ/FthiDKCnV10JnTQDO0WG+OPX0ImU/cRBde9733J3
	Z16Sp28xHfmZkj258CDKObrZ4sru5esrQPaVkHzbShYBnKj+DIudySKiSLdzmHZxVIzivv14BSFJP
	neS6qIW1BrKGqZROd+UJrhyPUuPKtZG0/Ig8Dd1MH+79GUWvm7Om+y3XT9TiIrAfagwGdJaGKHw8s
	EC291LGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHXz-0000000GX8F-3BS6;
	Sat, 14 Nov 2026 17:28:15 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHXw-0000000GX5j-3wpG
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 17:28:14 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0p5yv1z4yjS4;
	Sun, 15 Nov 2026 01:28:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677290;
	bh=cM3ClT4u+zl82PZyFZeUSO2AVbc/sz+uQne/Xdz4UdI=;
	h=Date:From:To:Cc:Subject;
	b=k/n87MZt5OItqLhj4Yd7FQmFmZRQ0fAiQh6fUUUs1W734LeypknJ4Za8sc59sHqec
	 JBNgZoiswXO3lkYHbGPCNxhW1cpI77x5vbMhPth+TQpz5GKtPJcZjNnn5tOQxzKQ35
	 3BQ1ITlXnII0/P0ArY7/Qhhic7TznBQ9q6Do9sxRcrhfc49jZlcdGfSKuiXoaE+QF2
	 AlsCE7it8LS5J1K92Gs6w3W58AACl+TmCipvIec4awhRzXau6t/KQ6ifZ4H0Bp6XMv
	 yH3KIeoQF0oohMZJ3CXD/FXlx2dC+83iel5iIJwQ1TOM+Fs32N28FeqLbilgfQqrnZ
	 0wz1hahpWRcHA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6AEHS2ma012439;
	Sun, 15 Nov 2026 01:28:02 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:28:06 +0800 (CST)
X-Zmail-TransId: 2af96af89a26171-58119
X-Mailer: Zmail v1.0
Message-ID: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
Date: Sun, 15 Nov 2026 01:28:06 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBudm1ldDogZml4IHRoZSBDU1RTIHN0YXRlIGl0ZXJhdGlvbiBpbiBkZWJ1Z2Zz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AEHS2ma012439
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 15 Nov 2026 01:28:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A2A.000/4jRh0p5yv1z4yjS4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_092813_364271_7BDA714D 
X-CRM114-Status: GOOD (  12.18  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_ctrl_state_show() uses the size of a sparse name array as a
bit count.  Its last index is NVME_CSTS_PP (BIT(5)), so the loop has
33 iterations and evaluates BIT(32).  This exceeds the width of an
unsigned long on 32-bit systems.  With GCC on x86 this can make a
normal ready status print "ready|ready".

Iterate over the 32 bits of csts instead.  Check the name array bounds
before indexing it and print unknown bits as unsigned values.  The
out-of-bounds lookup requires a reserved status bit; the current target
code does not set those bits.

Fixes: 107a23185d99 ("objtool, nvmet: Fix out-of-bounds stack access in nvmet_ctrl_state_show()")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, KASAN) with the loop
transport.  No in-tree path sets a reserved csts bit, so the guest
injects one through a test-only debugfs attribute added for this test
(not part of the patch).

ORing BIT(31) and then BIT(6) into ctrl->csts and reading the controller
state attribute:

  unpatched                            patched
  BUG: unable to handle page fault     csts_bit31='ready|2147483648'
  RIP: nvmet_ctrl_state_show+0x90      csts_bit6='ready|64|2147483648'
  Kernel panic - not syncing

 drivers/nvme/target/debugfs.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e85fe1d4c9f8..905a08c63669 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -78,18 +78,19 @@ static int nvmet_ctrl_state_show(struct seq_file *m, void *p)
 	bool sep = false;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(csts_state_names); i++) {
-		int state = BIT(i);
+	for (i = 0; i < BITS_PER_TYPE(u32); i++) {
+		u32 state = BIT(i);
 
 		if (!(ctrl->csts & state))
 			continue;
 		if (sep)
 			seq_puts(m, "|");
 		sep = true;
-		if (csts_state_names[state])
+		if (state < ARRAY_SIZE(csts_state_names) &&
+		    csts_state_names[state])
 			seq_puts(m, csts_state_names[state]);
 		else
-			seq_printf(m, "%d", state);
+			seq_printf(m, "%u", state);
 	}
 	if (sep)
 		seq_printf(m, "\n");
-- 
2.43.0


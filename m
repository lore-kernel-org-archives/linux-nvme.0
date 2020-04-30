Return-Path: <SRS0=L5xI=6O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEDEC47247
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2020 21:34:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34CB2071C
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2020 21:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KnLfuhH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34CB2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DRvrAkFrASIUpGnSKD873AOW+bMmYK6AM1s/+r7SJHo=; b=KnLfuhH/dLAhMo
	hy0hQAEsqLUSY3DJBPv0H86Zzp/fVGSjSXJemJ6B3oFrE14VX06k38+YNDiyEC+cPmubEMGJAC6wa
	yO8EnhA55jQ9J/xQva2poZdJ3/Lr9nasKFlPxrHxlNVes3iYdqZT8yWzVtOlcIvtixUeJuCS1PSFv
	uiaQZFrvOVz5xRJII/y0/Gf9pr0dFOAsfozAqjtQzwjqBJc78MfWn9GYNK8kZbp5ndqGYyE41hTkS
	IFPGcc5ztoUl6fCW5XeIralLMz2rNq36ywqGZEvJxn1Yn2jZ2GVyMDpIWfFz29lEZ3512mWB6bgUV
	+UGqOj6+2jcoYVFBCa8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUGp3-0005fk-Bb; Thu, 30 Apr 2020 21:34:21 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUGp0-0005e9-Lt
 for linux-nvme@lists.infradead.org; Thu, 30 Apr 2020 21:34:20 +0000
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M9FX5-1jYxeY344d-006SWG; Thu, 30 Apr 2020 23:34:01 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 15/15] nvme: avoid gcc-10 zero-length-bounds warning
Date: Thu, 30 Apr 2020 23:30:57 +0200
Message-Id: <20200430213101.135134-16-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200430213101.135134-1-arnd@arndb.de>
References: <20200430213101.135134-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:ZiRf4NHy8XQdJ0MYFrHfnPlaQWVkKn55groeh3SGJDg2G6j+ai/
 I0pcRNLPA3tssWEBLLaFPtsMonAIEX+vxcub9bDblZMmmYc7zUnxGsOX+9b6bExxaOmrvgw
 W4obT5PWbdarZi4z3cPFQUdI+MLKaL6Xv/pqI9q9NCY4AohwRyFmyph2p/E9//3zJ+w96Wh
 ptEV1jb5JkCC6T5O0OoCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v95riZ+TqS8=:150R5/f64arOjLP8fwFubM
 XwtgizIru2CUgqiEo6TeHDdrDXTqak3HMJHdQi9qoENwknwnEC9yzONOL2F9dIvxRmvG/IkB8
 ImMfUITMtswMe06/Kub/Zvkk95YC/WGw3YUEzZA2c20iKeVQ70yY6akO48/g3QodSXiWbVyTG
 zgF7KowdpC+QdD901XFJ+Nh5//wH0OEBE0fmDPho31nw/OEJuRXaNQWgNsRN+ZU3HImyIilvI
 gciKoBi2g8eqGVWasqNyuj6WOk9Fg9dEdUPMoFp5ELMvwYMs7mhetALQvvA4Fw5jyOgn9W7rn
 jccJ/pRe5t/VxIa3oA1haWYaFnt65Ff2FWuRg6RzMoAPFmNWBtj1X8krj+FqZXH9dcW41KKi4
 nj8hgaNGKa6e87952Yx2HfKkHauWQNw0EoGMzSWhO9iFm//nXBTWC35SVm4a835kbI/niuV9m
 tKfeZdF391OlPDiYBY1x6dntZwouHEkafrbz91js5ngyUGTIm8JEAYKW/rc12yfNls4s2mREf
 jTuLMQuUFxjX+vp7gH8OE0uL5GX7TKoiEhz36Gd2i7EFmGg7bGweHauvO3eLizFwBMto7rXQq
 k40wZv0F4sAuX1rxzbOxn2aDczG/tqbS55BpnM+CLcBoMTTLVTs6FZ4KldDq8rDa0SSinVYAS
 cnd2E5Rd3XOsVja0GabkD7FMnbkR0uNYbM++CUhoixmRGodgQ3D8v0ltbrSaNgeABdyGY3SRs
 GpK/5YszJDnpSMQzKLffITtvmeZ30/a8Y+wXTgIJ6I1eIvAktpM0Cks7jbDP+8eOiODXsIeqA
 PkVL43RsxXAswxvb3fiP77OZhJmbrf97sjeybX9KAiRIaZ/IeQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200430_143419_007053_39B2EE3A 
X-CRM114-Status: GOOD (  12.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Arnd Bergmann <arnd@arndb.de>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When CONFIG_ARCH_NO_SG_CHAIN is set, op->sgl[0] cannot be dereferenced,
as gcc-10 now points out:

drivers/nvme/host/fc.c: In function 'nvme_fc_init_request':
drivers/nvme/host/fc.c:1774:29: warning: array subscript 0 is outside the bounds of an interior zero-length array 'struct scatterlist[0]' [-Wzero-length-bounds]
 1774 |  op->op.fcp_req.first_sgl = &op->sgl[0];
      |                             ^~~~~~~~~~~
drivers/nvme/host/fc.c:98:21: note: while referencing 'sgl'
   98 |  struct scatterlist sgl[NVME_INLINE_SG_CNT];
      |                     ^~~

I don't know if this is a legitimate warning or a false-positive.
If this is just a false alarm, the warning is easily suppressed
by interpreting the array as a pointer.

Fixes: b1ae1a238900 ("nvme-fc: Avoid preallocating big SGL for data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 887537d1243f..b7ecda48d597 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1771,7 +1771,7 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	res = __nvme_fc_init_request(ctrl, queue, &op->op, rq, queue->rqcnt++);
 	if (res)
 		return res;
-	op->op.fcp_req.first_sgl = &op->sgl[0];
+	op->op.fcp_req.first_sgl = op->sgl;
 	op->op.fcp_req.private = &op->priv[0];
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	return res;
-- 
2.26.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

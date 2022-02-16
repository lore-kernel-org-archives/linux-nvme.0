Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78C4C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=l1wf0qKRjj+f5vJENAikWDbLyKGBFm0qSzgzakYedLg=; b=Qywqj1gwBAMcuwk8axsGCdfxSH
	RI9DpbhVN9XMrjXmEly1mKwPvlzSU8o4afwIQcFPNxM0JjjS0f+PbZ7ol6BkJ1GlAGtETZe33h5pj
	ct3mxa4j+qjm5c4NqdrNqb8OgwOEczNCF6u9b+q6BFYFcP+M9VNtmP5GbqvqomoEODtAzOo2q8Us8
	Rk3DSRHJwdhOaBpOtfnWsFoqpA8wRMubFDK+yG7VUXP+8H3UJKknCKrodjq835gzfHU/AO0idQ+p9
	34Az34x5Jxl4EDGCA89yHGgMSSD303c64phrcZ+rhCJLtxrRbO5O7QngTSPTWg/92VGDTgOKP0giH
	rgKCdoOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKDgv-005fXN-RW; Wed, 16 Feb 2022 06:21:29 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKDgs-005fWg-2S
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 06:21:28 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220216062121epoutp03cf8dfb6c81e9f3e3d7cb1be232c5b49b~UL-IwQTn20517505175epoutp03K
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 06:21:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220216062121epoutp03cf8dfb6c81e9f3e3d7cb1be232c5b49b~UL-IwQTn20517505175epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1644992481;
 bh=l1wf0qKRjj+f5vJENAikWDbLyKGBFm0qSzgzakYedLg=;
 h=From:To:Cc:Subject:Date:References:From;
 b=myUBvN+KGIa3qDvs3bC9aNl5gkxDUvaCL750iLv+fiQaShxnm6waZwJvsZDxXqOm5
 hJpXMWCM3xpwOEEIKpRnsrTkVxwwGHJjJ6yM9Tf+WU5Z9CazvjfdUtKszm2/P8eg2p
 l2HvXgNtjgNQ7Y9yLpZuao7z/pTufcKAf/JLfBCE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20220216062120epcas5p3f9d13cf671d065e5ee0727c6b5937d86~UL-Ihb5bb0229702297epcas5p3L;
 Wed, 16 Feb 2022 06:21:20 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Jz7Bj2vgFz4x9Pw; Wed, 16 Feb
 2022 06:21:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 30.B0.05590.9D79C026; Wed, 16 Feb 2022 15:21:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f~UL8Uys2ZZ2475424754epcas5p1C;
 Wed, 16 Feb 2022 06:18:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220216061807epsmtrp29d729314e60959c7d65b510842ac6af5~UL8Ux7pj20924809248epsmtrp2g;
 Wed, 16 Feb 2022 06:18:07 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-e2-620c97d932a3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6F.4A.29871.F179C026; Wed, 16 Feb 2022 15:18:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220216061806epsmtip19b8cf066c2e71f596720e5cb8d4d1180~UL8TjArzC2679026790epsmtip1f;
 Wed, 16 Feb 2022 06:18:06 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, hare@suse.de, dwagner@suse.de,
 sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, a.manzanares@samsung.com,
 joshiiitr@gmail.com
Subject: [PATCH] nvme-multipath: fix multipath path scan
Date: Wed, 16 Feb 2022 11:43:05 +0530
Message-Id: <20220216061305.45360-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmuu7N6TxJBv8XsFtMP6xocfjxJHaL
 PYsmMVmsXH2UyeL828NMFpMOXWO0mL/sKbvFutfvWRw4PHbOusvucf7eRhaPTas62Tw2L6n3
 2H2zgc2jb8sqRo/Np6sD2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
 c1NtlVx8AnTdMnOAblJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX
 5qXr5aWWWBkaGBiZAhUmZGf8u3uFqeAwb0X7z6uMDYwd3F2MnBwSAiYS+xetZO1i5OIQEtjN
 KNG7dAcLhPOJUeLI8SPsEM43Rol7/xsYYVra1y6ESuxllHhxqZsNwvnMKLFoI8gwDg42AU2J
 C5NLQRpEBEIktj7ewwZiMwsESxxues0CYgsLWEi8nbWWCcRmEVCVuH9nKVgNL1D8Yc8KVohl
 8hIzL31nh4gLSpyc+YQFYo68RPPW2cwgeyUE7rFL/N60mhmiwUViw+f77BC2sMSr41ugbCmJ
 z+/2skHYxRK/7hyFau5glLjeMJMFImEvcXHPXyaQB5iBHli/Sx8iLCsx9dQ6JojFfBK9v58w
 QcR5JXbMg7EVJe5Negp1tLjEwxlLoGwPiY2z94LdICQQK/GlZSH7BEb5WUj+mYXkn1kImxcw
 Mq9ilEwtKM5NTy02LTDOSy2Hx2xyfu4mRnDa1PLewfjowQe9Q4xMHIyHGCU4mJVEeOPOciYJ
 8aYkVlalFuXHF5XmpBYfYjQFBvJEZinR5Hxg4s4riTc0sTQwMTMzM7E0NjNUEuc9lb4hUUgg
 PbEkNTs1tSC1CKaPiYNTqoFJcNv3u2curS/5z8PdMvOJznpT/p3KD+ZHHZ7vOOvaamnHkPjE
 gFRJwUl3Wh/pGOxuvGDz7975JM7pq/ZcYhNZ0Z+3Zoeg1Hzen/IpeZoaazb1XjkafH9jyg7X
 ysYrN7QfaLz7KVewIPPsqv66vjPq/m8ioi8vN39wxfTrjJO/gkUeeC24c3Vfj+8/rwtGjnrG
 XcWr428v/xHE/flM04+DU88E3Gw6tePxfB7Fjd0p/lsd5Gqq62I+nkzgYNlhcntjotCWt7tv
 ht+Q9HhxtuJwUtO1X7tYUr4UZbKyK//3SWdm4QgLvGud8GDDUY+tSd5z/A4ueb77tdn8d4Hd
 /Ws2s11v3rPwXP0qFxG/6o7VpkosxRmJhlrMRcWJAB0EPEYkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnK78dJ4kg95ZxhbTDytaHH48id1i
 z6JJTBYrVx9lsjj/9jCTxaRD1xgt5i97ym6x7vV7FgcOj52z7rJ7nL+3kcVj06pONo/NS+o9
 dt9sYPPo27KK0WPz6eoA9igum5TUnMyy1CJ9uwSujH93rzAVHOataP95lbGBsYO7i5GTQ0LA
 RKJ97UJ2EFtIYDejxLX+CIi4uETztR/sELawxMp/z4FsLqCaj4wSbw92AzkcHGwCmhIXJpeC
 1IgIREkc+P6HEcRmFgiVWLRjAZgtLGAh8XbWWiYQm0VAVeL+naVsIDYvUPxhzwpWiPnyEjMv
 fWeHiAtKnJz5hAVijrxE89bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0
 L10vOT93EyM4eLU0dzBuX/VB7xAjEwfjIUYJDmYlEd64s5xJQrwpiZVVqUX58UWlOanFhxil
 OViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDN9Itbt4VZazuLMIuZeAer/oKovCvy1XnN
 t5kexp5mFrqn0nkz3rxMr2W/xqK8ky09pvMvLZBeMtH7c06OeZjjftmsZe1lIkd5c5JT8mcJ
 TqlY7P7w340V+09mJj8yvzn3Qb2shVPc7UnpWzYEKUx3cVnF8lXl6TrNf4ZMpr3r14Yevu+T
 fPnv0p8Wgu2+h2TtzZaeqqz8LR/y84DQnZIbn/fMu9B6y3Hp2W+rjh9cvjCxSK3q6P/MvPgS
 qXOcq8Jizgk95GE4X3WtNDYkMX2S+EXV7PokqUV/lsd9W3e189n8c0dW1awwYIiYOqk7LmfZ
 1BmZttslnhdJdmQLLjnVn8N7QdmhVuDKNZNj//cqsRRnJBpqMRcVJwIAoExHoc0CAAA=
X-CMS-MailID: 20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f
References: <CGME20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_222126_653681_A556AF41 
X-CRM114-Status: GOOD (  16.82  )
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

commit e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
introduced NVME_NS_READY flag. nvme_path_is_disabled() declares path/ns
to be disabled if this flag is not found to be set.
This causes side-effect on namespace for which block-interface is not
fully up.

> nvme id-ns /dev/ng1n1
identify namespace: Resource temporarily unavailable

Above issue occurs because nvme_find_path() fails as it does not find
the NVME_NS_READY set.

       ns = nvme_find_path(head);
       if (!ns)
                goto out_unlock;

Go back to old behaviour by moving up setting of NVME_NS_READY.

After this patch:
> nvme id-ns /dev/ng1n1
NVME Identify Namespace 1:
nsze    : 0x3cf00000
ncap    : 0x3cf00000
nuse    : 0
...........

Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 961a5f8a44d2..71c1970f029d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1914,6 +1914,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
+	set_bit(NVME_NS_READY, &ns->flags);
 
 	ret = nvme_configure_metadata(ns, id);
 	if (ret)
@@ -1927,7 +1928,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 			goto out_unfreeze;
 	}
 
-	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
 	if (blk_queue_is_zoned(ns->queue)) {
-- 
2.25.1



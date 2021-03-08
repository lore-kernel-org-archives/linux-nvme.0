Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9E5C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 19:19:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAC065287
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 19:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAC065287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5klQw7XSg61+rt/c/sWtPUYLwnKUcSX9k4cqJDqfFgI=; b=YqFvKqXhYZZTXK12hGodaFhsV
	M7PN1lJ89LawLVgaHtg9JRxRCI8yTgUB1RE4XtTL3j5/K6wiDCvPGnJjuRET3CtBc0qf4VSn4vRv3
	5Ux/6dDKegKpbORAHsFaN1GBVYsQI00/16zargWX+levKVwvJqF+Hmz8dIPrPMZ6zFezLAWltTXKa
	ibfpuFlSkv7cOEVKRpQrK7C/By8KVG1KlrkOtaAHCu1h9vsKhLs5cVJj4oLJHBvbpkjSxYrvPT6YO
	aBEdzwBwh7TQJVu+2fk8VggVGk1mNkmSE/VdknWVsWq42bUiFVaYwe+ICwEHN/E30S/twFoSbr20s
	+7aWVTPFw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJLPN-0022VK-SQ; Mon, 08 Mar 2021 19:19:13 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJLP6-0022Oi-AX
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 19:18:58 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210308191852epoutp02c1231d2b00f86ff8f76ddadb5cc537ef~qdChAkP2R1281112811epoutp02S
 for <linux-nvme@lists.infradead.org>; Mon,  8 Mar 2021 19:18:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210308191852epoutp02c1231d2b00f86ff8f76ddadb5cc537ef~qdChAkP2R1281112811epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1615231132;
 bh=JJcs8VtHxZogMEvvBHpUQm8prqw6SZDSpd+8UdSNYRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q/fkneRtIlw/XHWs7KJ4CTNoi2n+s3NRziE+MT3H7V9BGYHwcBM1JVhNxht4e706k
 7bkscmeJRAf4BWKgHOjb2O30PIQ0H1C8rACsfaInZdI9lpIfmUYi4mkMciDkczY/m3
 GZ75Nutax+Uwb03yB6P9h4PIzOgJ5N03BXND1KG8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210308191852epcas5p2d5d23a8f4987a45939418e09d98620a8~qdCgkUVdk2858228582epcas5p26;
 Mon,  8 Mar 2021 19:18:52 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2D.D1.50652.B9876406; Tue,  9 Mar 2021 04:18:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210308191851epcas5p3253b85f29279714544c8c14a7525ce7d~qdCf45toZ1328913289epcas5p3s;
 Mon,  8 Mar 2021 19:18:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210308191851epsmtrp12047687ddd06f8ebc6c01631f37d1168~qdCf3o7Xl1002510025epsmtrp1Q;
 Mon,  8 Mar 2021 19:18:51 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-e6-6046789bd52a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A9.A1.13470.B9876406; Tue,  9 Mar 2021 04:18:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210308191849epsmtip246471e79cbf1fd84591055dc6de18027~qdCd9vmEd0220002200epsmtip20;
 Mon,  8 Mar 2021 19:18:49 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, Kanchan
 Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/2] nvme-core: reduce checks for zero command effects
Date: Tue,  9 Mar 2021 00:48:04 +0530
Message-Id: <20210308191804.8582-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308191804.8582-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZdlhTS3dOhVuCwfMqi/97jrFZrFx9lMni
 6P+3bBaTDl1jtJi/7Cm7xZUpi5gt1r1+z+LA7jGx+R27x/l7G1k8Nq3qZPPYvKTeY/fNBjaP
 vi2rGAPYorhsUlJzMstSi/TtErgyZt9awlLwja3i3i+5BsaPrF2MnBwSAiYSa3ZuYAGxhQR2
 M0o8+GnfxcgFZH9ilFi88jkrhPONUeLn00PsMB3X/x2ASuxllHj95iY7RPtnRolDb/y7GDk4
 2AQ0JS5MLgUJiwgoSfxd38QCEmYWyJB4dEYXxBQWcJOY91EZpIJFQFViwvPvbCA2r4C5xNnO
 pUwQm+QlZl76DjacU8BC4vTuRawQNYISJ2c+AbuZGaimeetsZpBrJAReskt8u/+PFWS+hICL
 xNVFvBBzhCVeHd8Cdb2UxMv+Nii7WOLXnaNQvR2MEtcbZrJAJOwlLu75ywRxsqbE+l36ELv4
 JHp/P2GCGM8r0dEmBFGtKHFv0lNocIpLPJyxBOoCD4n5+/0h4dTNKPFpXSf7BEb5WUg+mIXk
 g1kIyxYwMq9ilEwtKM5NTy02LTDKSy3XK07MLS7NS9dLzs/dxAhOKlpeOxgfPvigd4iRiYPx
 EKMEB7OSCG9vj3OCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4dBg/ihQTSE0tSs1NTC1KLYLJM
 HJxSDUxlxUztO+8qGtsefnVm8mmuf83zzE6++ZtjFF0d+GLOjC+OTieCzsndLolkbZv2uZOv
 98aV3Mu3z+VJmG46uJ5PefODhSdWpX5Q0zjKlL9l6kd+K7ZG2UKPpd5rpKKfbP6i1RO2ojui
 p+Xwm3KOzyufO5xkrK3K3/bMwvxI5I0rLCyrZ7wq/zJbbONGA47M2jfeFReYexdeTbu19Mn1
 mQdL3KJWz1Wt5rvzxuyP7fz8Kw85z9wxXGV4wefgSTYjZYEK786ouB2OSxeI/9pzdJ+Y4KWt
 rfsKp53JvjDp4v+5999JLJ0b+JP5yl7z9c7pf6f99dpRNYP/9Isoh//u/xP3rYibuGa6b4Zq
 8oxX/bNPrlZiKc5INNRiLipOBAAP4XComQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvO7sCrcEgwknBSz+7znGZrFy9VEm
 i6P/37JZTDp0jdFi/rKn7BZXpixitlj3+j2LA7vHxOZ37B7n721k8di0qpPNY/OSeo/dNxvY
 PPq2rGIMYIvisklJzcksSy3St0vgyph9awlLwTe2inu/5BoYP7J2MXJySAiYSFz/dwDI5uIQ
 EtjNKLGncQM7REJcovnaDyhbWGLlv+fsEEUfGSW+dmwH6uDgYBPQlLgwuRSkRkRASeLv+iYW
 EJtZIE9ie3MHG0iJsICbxLyPyiBhFgFViQnPv7OB2LwC5hJnO5cyQYyXl5h56TvYKk4BC4nT
 uxeB3SYEVDPn801miHpBiZMzn0CNl5do3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem5xYbFhjm
 pZbrFSfmFpfmpesl5+duYgSHtpbmDsbtqz7oHWJk4mA8xCjBwawkwtvb45wgxJuSWFmVWpQf
 X1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9OKd875C4M6At3k2pdryCh2
 v7yasmWBZ0fB7fQ54i59S+b1CJmsUJ0odv7l3SbXX9G/Tos4C5ppsTMZ6YmIPL34+6NaZceP
 s6+6PYxSfQy3RT09tqJYamdPXrJn3nLZZeVql9QYkqZ1PXhwwPh4WdSJdRV5Ni8i8+NT5tT2
 Xz+ZGKpVlc+yRr1I6tP1899v93D0Tb02YeGVm8ZuLU01OcLqe0yEBRmvvgmLzS/sjU47ns/W
 VPHlXR/j9x2mPx3nJ9QkvP134VSER8QrkVRhd+kJ2zX1Uv2unEuYeySjW3rNdIVbdbt4pOPi
 rePuffv02OywNO8HrvNstrMWu5qlaLftiQ4o+PeosMfqsa6QEktxRqKhFnNRcSIAxZDVg9wC
 AAA=
X-CMS-MailID: 20210308191851epcas5p3253b85f29279714544c8c14a7525ce7d
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210308191851epcas5p3253b85f29279714544c8c14a7525ce7d
References: <20210308191804.8582-1-joshi.k@samsung.com>
 <CGME20210308191851epcas5p3253b85f29279714544c8c14a7525ce7d@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_191856_868778_79050BEE 
X-CRM114-Status: GOOD (  13.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For io passthrough commands, effects are exepcted to be zero.
nvme_passthrough_end() does three checks in futility for this case.
Bail out of function-call/checks.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..ddb495dd0842 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1136,7 +1136,8 @@ void nvme_execute_passthru_rq(struct request *rq)
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
 	blk_execute_rq(disk, rq, 0);
-	nvme_passthru_end(ctrl, effects);
+	if (effects) /* nothing to be done for zero cmd effects */
+		nvme_passthru_end(ctrl, effects);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01724C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 19:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=BIXnNOJLKRkJXHmgmmLirYjmeRqqf/Xrz7MbbUYTVs8=; b=mBTIFS109xPAWJoYU5wJBnrIBA
	Z+tWJzE5Vho2CPTc9wZ/dK7iUsGijj0BIy1WCKjr9TZYPfxy1V+O2KtnMdirCM9g7RqMqaVHva5PY
	BaqIjF60kgf4AQqT9DAx9kWAfAhWDK6DuNoqeJkrBbTOXYLxlrTVaMgAzhm8ZPnC8nw2JDXcg+E5i
	S8O9ZT2eqHj/+9Jfyynex+7KyVa3hQNYt21XooBtcNhd/nzt4Jv+G85XLzL6KQWoeG0jVxgiZJZVR
	vLhvAPvKCQ1zhKWJ2f1DX6axzDlMc1+uKSbYK7Udi9T1a79S3BNmTGk6IroW4ltvabSF3nhz+nXsk
	GN1W5Mwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngXI1-000UCV-9u; Mon, 18 Apr 2022 19:44:01 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngXHw-000UA9-VL
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 19:43:59 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20220418194352usoutp02ee6cd2ba1e6fbb6d4bf8008334998598~nFSPt7xZi2418524185usoutp02X
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 19:43:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20220418194352usoutp02ee6cd2ba1e6fbb6d4bf8008334998598~nFSPt7xZi2418524185usoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1650311032;
 bh=BIXnNOJLKRkJXHmgmmLirYjmeRqqf/Xrz7MbbUYTVs8=;
 h=From:To:CC:Subject:Date:References:From;
 b=DN24diz5u6nqjYTVuRStIOlNJmKxYZW+wc7moR+hMz4vOwC4dwLUuNI5i7AlV0POF
 UO9JtAD990a5Ry5UnUujxOcpgWkvBBtc2QDVWHpGgbTbmBzTVNWMH+zc1/33BPQOPP
 hj7Hqg7CcA+2Ibxlo9dTpE1NqkpsIPuv2kYoBp7M=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220418194351uscas1p10334b4817e01194d4437a72442e562fb~nFSPIRkBE0182301823uscas1p14
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 19:43:51 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id 37.C7.09642.77FBD526; Mon,
 18 Apr 2022 15:43:51 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220418194351uscas1p18e05fad61bc279e8ea18d1a1a8597dc3~nFSOwSTBr2981029810uscas1p1g
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 19:43:51 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-19-625dbf7773d6
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 07.AA.09702.77FBD526; Mon,
 18 Apr 2022 15:43:51 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
 SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.7; Mon, 18 Apr 2022 12:43:50 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::ddc9:3655:8940:70fb]) by
 SSI-EX3.ssi.samsung.com ([fe80::ddc9:3655:8940:70fb%4]) with mapi id
 15.01.2375.007; Mon, 18 Apr 2022 12:43:50 -0700
From: Vincent Fu <vincent.fu@samsung.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH] nvme: have nvme_setup_rw return BLK_STS_OK
Thread-Topic: [PATCH] nvme: have nvme_setup_rw return BLK_STS_OK
Thread-Index: AQHYU1ygOzbkSUYee0y6dbHOXK1LYw==
Date: Mon, 18 Apr 2022 19:43:50 +0000
Message-ID: <20220418194324.589248-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7djX87rl+2OTDI71mVjMX/aU3YHRY/OS
 +gDGKC6blNSczLLUIn27BK6MrjVLmQqes1Us3DKbqYHxPmsXIyeHhICJxInW2UxdjFwcQgIr
 GSX+LexihHBWMUmcnHOQBaZq6+ubUFVrGSWWfNzBBuF8ZJRY82cuC4RzgFHi3IvvQGUcHGwC
 mhJv9xeAdIsIuErsXrqLEcRmFlCXOLZxAxuILSxgLfFy3QRGiBoHiVPTv7OAtIoI6EmsPJEA
 EmYRUJXY9OI9WAmvgI3Ewf5fYDajgJjE91NrmCBGikvcejKfCeJQQYlFs/cwQ9hiEv92PWSD
 sBUl7n9/yQ5RrydxY+oUNghbW2LZwtfMEPMFJU7OfAL1sKTEwRU3wN6SEHjELnF68VmoBS4S
 i2d8gSqSlrh6fSozRFE7o8TcjTCJCYwS159IQdjWEv86r0Ft5pP4++sRI8iTEgK8Eh1tQhMY
 lWYh+WEWkvtmIblvFpL7FjCyrGIULy0uzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMEaf/Hc7f
 wXj91ke9Q4xMHIyHGCU4mJVEeHuWRCcJ8aYkVlalFuXHF5XmpBYfYpTmYFES512WuSFRSCA9
 sSQ1OzW1ILUIJsvEwSnVwORzJ+z7nsB21xLhekftsuibPQalhrM3vTBUbJqXqvjvHrcMX3Gy
 sKeL8Aee3hldIkFPg1bzGHyTcy52yJxmvmFXgK/3pQvsak37exLvNwvbpU7Z/EL97Qw5lQ25
 rxujj9mlRssZvX6auCBrZeZFzzNCmrdC4rpUC39MW81UXy2yquTFFBcVuUebkqUiry6pTv77
 PLOkr2tBc9K9Sf+X3BQ9eLP0WYjm1SnR0UEZml0Few0MP7woLpp5Xd3IO6R7buOPmOqQ+xWF
 hZuXWj9/5/TKPeXYZo4ffzYXveMQn8K6NH6O8fW0ljuyFVvOP1bg9fm+dO/tqQwlVhVBv3wS
 RNmP/Gk+JaX+oy7a0stCiaU4I9FQi7moOBEAyQRx4oADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWS2cA0Ubd8f2ySwdJeCYv5y56yOzB6bF5S
 H8AYxWWTkpqTWZZapG+XwJXRtWYpU8FztoqFW2YzNTDeZ+1i5OSQEDCR2Pr6JhOILSSwmlHi
 4KKELkYuIPsjo8S/ByfYIJwDjBIzLtxn72Lk4GAT0JR4u78ApEFEwFVi99JdjCA2s4C6xLGN
 G9hAbGEBa4mX6yYwQtQ4SJya/p0FpFVEQE9i5YkEkDCLgKrEphfvwUp4BWwkDvb/ArMZBcQk
 vp9awwQxUlzi1pP5TBB3Ckgs2XOeGcIWlXj5+B/U/YoS97+/ZIeo15O4MXUKG4StLbFs4Wtm
 iPmCEidnPmGBqJeUOLjiBssERtFZSFbMQtI+C0n7LCTtCxhZVjGKlxYX56ZXFBvmpZbrFSfm
 Fpfmpesl5+duYgTGxOl/hyN3MB699VHvECMTB+MhRgkOZiUR3p4l0UlCvCmJlVWpRfnxRaU5
 qcWHGKU5WJTEeYVcJ8YLCaQnlqRmp6YWpBbBZJk4OKUamFo19umnLp/PdCeWa/9XjwN+rddm
 99gyfAlhtYtN00n7FH9+d/mPa96CDBk9t/7/bI/K/7T8A9eOQ0GRr/hW2S4Ky2bxV2JUrVzb
 cVlhk+jKM9l1ZtOrmX5Nj12/JPTC8z1H8voW7/9h8CAm2j5rQapWyvciN7fc1wsvnZBKdU3N
 iGBwtz1oKbN9vQPny+XHqk/MyTqU9eLs3FePZ/+Vn19x6ctyR9/TqSdvnvxRwPe3J0fZrMPk
 9d+JJ97X7g4Uf/9k4tfFikElYh6Tw6/NefRaoyb6qb7w4Ya+9OkcTHNcOD78uRChmqA3NXzn
 v4yzxqlHo+6y2CT+yOA/dSMr7CW3pUzlgXWZgttSjHok2pRYijMSDbWYi4oTAS2Y8yf4AgAA
X-CMS-MailID: 20220418194351uscas1p18e05fad61bc279e8ea18d1a1a8597dc3
CMS-TYPE: 301P
X-CMS-RootMailID: 20220418194351uscas1p18e05fad61bc279e8ea18d1a1a8597dc3
References: <CGME20220418194351uscas1p18e05fad61bc279e8ea18d1a1a8597dc3@uscas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_124357_354213_893A6E68 
X-CRM114-Status: GOOD (  12.86  )
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

Return BLK_STS_OK instead of 0 on success. Since BLK_STS_OK is defined
as 0 this patch results in no functional change but to avoid confusion
and to be consistent with nvme_setup_write_zeroes as well as
nvme_setup_discard we should have nvme_setup_rw also return BLK_STS_OK.

Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b9b0fbde9..f45665e36 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -895,7 +895,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns=
 *ns,
=20
 	cmnd->rw.control =3D cpu_to_le16(control);
 	cmnd->rw.dsmgmt =3D cpu_to_le32(dsmgmt);
-	return 0;
+	return BLK_STS_OK;
 }
=20
 void nvme_cleanup_cmd(struct request *req)
--=20
2.25.1


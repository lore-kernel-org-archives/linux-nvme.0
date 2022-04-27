Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F82C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 19:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=MyUZpdhjaYGCKVHsiwKmxPCa/D451WZtYWwXONEG+kk=; b=0SjtTLif7dyhbpy2P9Ojo42v6a
	Q/w19pXYqCdeGeJur1n/EDHYjjPhCXz1gw1GWlQysFydqY//NyPozReg+M4sLU4OtR0yQ9rS52DWH
	b0oyDaKRwe9ekJkriDUlDAXSBkLE08w8M4Nc+NXIH8x/xPm7EKVh//QWf//oRDBSmH1P1an8Lr4Eo
	rFHp6TvOvDc8BDMSsxAtSmHbeTvRbaIZ1v30Yp1xiErSUsIYfAuACOfQ0gnHLeY9AIpoGUS8brmi9
	zzi8+9AycvIiwEJ5JWEMp7wHZc7gtITCqtf0365b74uecqjz3P8UoaSnLpjPucsCjVSp0EbuIsLnX
	ASpOZIGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njn3w-003FBn-UT; Wed, 27 Apr 2022 19:10:56 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njn3t-003FB2-Cm
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 19:10:55 +0000
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20220427191046usoutp02d73faf3ce96b547494f2d87850019b75~p1o6U_Fmk3009430094usoutp02O;
 Wed, 27 Apr 2022 19:10:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20220427191046usoutp02d73faf3ce96b547494f2d87850019b75~p1o6U_Fmk3009430094usoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651086646;
 bh=MyUZpdhjaYGCKVHsiwKmxPCa/D451WZtYWwXONEG+kk=;
 h=From:To:CC:Subject:Date:References:From;
 b=Juq0rSbyP+e8lUsEmPiLbaeIFepMNCqop4pIrVo/XCyrxBeM1HEZ7FHhEtTTn2WM+
 39NP7fHtg2UsDNIIX2vI6W+dAceLb0z25gTTqKKlbaxsXReXRgRk45aLG/kqmwzoar
 /3zH7tFS3VXcswrj2nhs7JEK4pg94r66xJdkxv/4=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220427191045uscas1p2f17c5f411c2ebd00765db925f5a6ebc8~p1o5f_Eym2441024410uscas1p2z;
 Wed, 27 Apr 2022 19:10:45 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id 4B.32.09642.53599626; Wed,
 27 Apr 2022 15:10:45 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
 [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220427191045uscas1p2cff082022143327c9d6bfdf39e4eb861~p1o5Q2UJC2660226602uscas1p2o;
 Wed, 27 Apr 2022 19:10:45 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-fe-62699535d9aa
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 5C.A9.09672.43599626; Wed,
 27 Apr 2022 15:10:45 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
 SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.7; Wed, 27 Apr 2022 12:10:44 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
 SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.007; Wed,
 27 Apr 2022 12:10:44 -0700
From: Vincent Fu <vincent.fu@samsung.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Vincent Fu <vincent.fu@samsung.com>, Pankaj Raghav
 <p.raghav@samsung.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2] nvme: return BLK_STS_OK on success in nvme_setup_rw
Thread-Topic: [PATCH v2] nvme: return BLK_STS_OK on success in nvme_setup_rw
Thread-Index: AQHYWmp+iFNRo2Q7AUyzdjI7vVBRiw==
Date: Wed, 27 Apr 2022 19:10:43 +0000
Message-ID: <20220427190933.627688-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djX87qmUzOTDO49E7aYv+wpu8W61+9Z
 HJg8zt/byOKxeUl9AFMUl01Kak5mWWqRvl0CV8bfP7/ZCmZxVOxsuM3WwPiJrYuRk0NCwERi
 /4xp7F2MXBxCAisZJe7d+s4M4bQySbxfdZkFpupc82aoqrWMEgvfTmeDcD4ySsy6f58VwlnG
 KHHtaQtQPwcHm4CmxNv9BSDdIgKuEruX7mIEsZkFCiU2Xr4LZgsLuEv82dHABFHjI7Fx8jJm
 CFtPovvubzCbRUBV4vTNrWD1vAI2Em8nTgKLMwqISXw/tYYJYqa4xK0n85kgLhWUWDR7DzOE
 LSbxb9dDqD8VJe5/f8kOUa8ncWPqFDYIW1ti2cLXzBDzBSVOznwC9bGkxMEVN1hA/pIQ+Mou
 cbBrPitEwkXiesNlqKHSEn/vLmOCKGpnlJi78QtU9wRGietPpCBsa4l/ndegNvNJ/P31iBEU
 QBICvBIdbUITGJVmIflhFpL7ZiG5bxaS+xYwsqxiFC8tLs5NTy02ykst1ytOzC0uzUvXS87P
 3cQITByn/x3O38F4/dZHvUOMTByMhxglOJiVRHi/7M5IEuJNSaysSi3Kjy8qzUktPsQozcGi
 JM67LHNDopBAemJJanZqakFqEUyWiYNTqoEpPPyZl8T5RtYvdlvdv04vkr/+48bUo/9mvNoY
 WK3t57hj+dv2WhaOtuZ683u8MpPu2TA8XJ6uzxqTZy6ZlfT7bCt3a+HW95O/nY+IfliwyTFo
 VWXirxjH9uOuHrM5ZnX8ZDvP+VVT9IyHsodE7p3siOhiYYsW39+N5jnyb2v2T9JruLZBlHvH
 +hIdrVnT16srp9tGt17gWx+9kfm1yOZU2Rb9bMGsB5LHHGeoKVTejeZ+cVex3E3I/PuXT3sX
 Fl8TsZxy+gzfNo/CK9lWZctWTGauTZKQds9+8aHp7d8aARuRm488nq38LSjC/exn5oOewrzD
 nZG5q9rMv74+VRdz+37Pt5nf5ZM5ns04ekqJpTgj0VCLuag4EQAVVHt/iwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWS2cA0Sdd0amaSwbQqi/nLnrJbrHv9nsWB
 yeP8vY0sHpuX1AcwRXHZpKTmZJalFunbJXBl/P3zm61gFkfFzobbbA2Mn9i6GDk5JARMJM41
 b2bvYuTiEBJYzShx4/5UVgjnI6PEy0+rmSGcZYwSx24sYepi5OBgE9CUeLu/AKRbRMBVYvfS
 XYwgNrNAocTyz41gtrCAu8SfHQ1MEDU+EhsnL2OGsPUkuu/+BrNZBFQlTt/cClbPK2Aj8Xbi
 JLA4o4CYxPdTa5ggZopL3HoynwniUgGJJXvOM0PYohIvH/9jhbAVJe5/f8kOUa8ncWPqFDYI
 W1ti2cLXzBDzBSVOznzCAlEvKXFwxQ2WCYyis5CsmIWkfRaS9llI2hcwsqxiFC8tLs5Nryg2
 ykst1ytOzC0uzUvXS87P3cQIjJTT/w5H72C8feuj3iFGJg7GQ4wSHMxKIrxfdmckCfGmJFZW
 pRblxxeV5qQWH2KU5mBREud9GTUxXkggPbEkNTs1tSC1CCbLxMEp1cCUNulzXcDr8NYz2+Je
 zXt99Xphg9mCr0u2vlwj+uLCqxOrlorNOGusK7tzyXpZ19qvlncXWa54pJO6irXKQ3Tmh70/
 z/xv4d888/nSB6d/qRyWYDDIP7z1iJxR3R27D0EqKz5OEf5++MfpM5+C55wu/2H8YkXHouj7
 do1zp2nyMX/cee9BVOF71RaXldZLjsyoDDKon698tN0vj3W9a2f1wVum76Z2xhoH2d16vWFz
 /VYbt88/jxz2P8Blz2Wz6NPKGx2fI2ySPkyYxqa1ZT6HZMumg08EFRKTRe7NkfZecr2Ufd1b
 3l0cjyu+7fd94FG68NvZwF39P/4kGLkqCfJsFVHlUW+JMZ7pEs/19CGro4ASS3FGoqEWc1Fx
 IgB31VfCAwMAAA==
X-CMS-MailID: 20220427191045uscas1p2cff082022143327c9d6bfdf39e4eb861
CMS-TYPE: 301P
X-CMS-RootMailID: 20220427191045uscas1p2cff082022143327c9d6bfdf39e4eb861
References: <CGME20220427191045uscas1p2cff082022143327c9d6bfdf39e4eb861@uscas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_121053_755096_3618A817 
X-CRM114-Status: GOOD (  12.71  )
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
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
v1 -> v2:
  - improved commit message first line
  - added reviewed-by tags

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


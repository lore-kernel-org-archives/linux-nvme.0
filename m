Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CDFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OfcoM9MGknWZYzPFI8WXDQat1wocEJjkPlYS9E4EcJA=; b=YT4oewjhFFbHcvQeQq6YHIm5JR
	2k63idJwgkCZBY5bENP4rfo2e6mKGcqlyHAIyc0NuMhMBx4zSU2Rg5Pl7cg9bOnuECZsKTo34D9RC
	659os8HsuPYmAH4pD4bqZcfdMi+zQXCzJq/y5ZZ8zeI763+0vz2pFPfEF1aeW8gWukHrGdrZF5WC0
	MzYQKGqaWBvRvN1k60U9eedHvfXY+w7jq7KQ6zSWOqDrHF/nWIDBXNOtIA3vUBYBvYCPnx1Rs6u4T
	xDRmoWsRtM4BU/URBq8jyC9kInedbizl7hjMI1avKPB1n2u6rMQopEqD/9FAcOp4wtqzS8ZNze8qk
	zIiNrDPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk60x-007eDo-26; Thu, 28 Apr 2022 15:25:07 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk60t-007eAx-F8
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 15:25:05 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20220428152459usoutp023bb9c74b86894a2badba27ba0804a746~qGNEbc-hy1994019940usoutp020;
 Thu, 28 Apr 2022 15:24:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20220428152459usoutp023bb9c74b86894a2badba27ba0804a746~qGNEbc-hy1994019940usoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651159499;
 bh=OfcoM9MGknWZYzPFI8WXDQat1wocEJjkPlYS9E4EcJA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=ppPBsrQFP5IvMNn9xHmBdTiunQusn9JQOwtTMEHw2bd3Q6ul/FvxFnSbcKyBtSo13
 3I9jxekmZDjOGot7EnD3LDznMT0XkIakCvZ4EXk6M73K1cCncqI72ixv7+oMVuw1hK
 Lxh+DjmZaZ2jYeosY3RLOBsH0x9kZI8DpFPzoX90=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
 [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220428152459uscas1p21238e1c8df8b79400117674b8a358a60~qGNETAoM71632016320uscas1p2C;
 Thu, 28 Apr 2022 15:24:59 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges3new.samsung.com (USCPEMTA) with SMTP id CF.62.09749.BC1BA626; Thu,
 28 Apr 2022 11:24:59 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220428152459uscas1p22f3ecc16b67150e80c357854a44561a6~qGNEBfqkz0308503085uscas1p2J;
 Thu, 28 Apr 2022 15:24:59 +0000 (GMT)
X-AuditID: cbfec370-a83ff70000002615-3b-626ab1cb3075
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 10.D1.09665.BC1BA626; Thu,
 28 Apr 2022 11:24:59 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
 SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.7; Thu, 28 Apr 2022 08:24:58 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
 SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.007; Thu,
 28 Apr 2022 08:24:58 -0700
From: Vincent Fu <vincent.fu@samsung.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme: have nvme_setup_rw return BLK_STS_OK
Thread-Topic: [PATCH] nvme: have nvme_setup_rw return BLK_STS_OK
Thread-Index: AQHYU1ygOzbkSUYee0y6dbHOXK1LY60F8heA//+Ou+A=
Date: Thu, 28 Apr 2022 15:24:58 +0000
Message-ID: <579a543aa3104596a3d3eb8e41e96cda@samsung.com>
In-Reply-To: <YmqtycoRZO3yxVCW@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djXc7qnN2YlGTxapGhxesIiJov5y56y
 OzB5bF6h5bF5SX0AUxSXTUpqTmZZapG+XQJXxs7WjIL3HBV71+9kamBcwN7FyMkhIWAi8WHz
 brYuRi4OIYGVjBJPv35jgnBamSSurVnMBlO1/uBsZojEWkaJrY07GCGcj4wShw9/YoFwljFK
 9HesBWrh4GAT0JR4u78ApFsEyLy1vJ0ZJMws4Cqx5mwWSFhYwF7i57cDLBAlDhKnpn9nASkR
 EbCSmLEqGyTMIqAqsfVMOyOIzQsUXj5vIdhwTgFdiYs7wEoYBcQkvp9awwRiMwuIS9x6Mp8J
 4mRBiUWz9zBD2GIS/3Y9hHpFUeL+95fsEPU6Egt2f2KDsLUlli18zQyxSlDi5MwnLBD1khIH
 V9yAsjs5JB6fVwU5QULARWLHZnmIsLTE9DWXwWEgIdDOKDF34xeo+gmMEtefSEHY1hL/Oq9B
 7eWT+PvrEeMERuVZSM6eheSkWUhOmoXkpAWMLKsYxUuLi3PTU4uN81LL9YoTc4tL89L1kvNz
 NzECk8Xpf4cLdjDeuvVR7xAjEwfjIUYJDmYlEd4vuzOShHhTEiurUovy44tKc1KLDzFKc7Ao
 ifMuy9yQKCSQnliSmp2aWpBaBJNl4uCUamBanLS4bvOBE8cOL5JlkZ2WqeR0eptqfHbjsWSx
 Z6m/Nktcvr0m0fPWbR2x15F2vI9anB61Oc7YFGMS+/3woXnJj6qsK37ut5cWE5Nb33bAO/4j
 g3r3rCvt4bfaLqjdZj8pYbaI8QHPC5v1EaeXOwZ07YzoL4tZOeNAqlvmYqbJuz8++eDSuKP1
 ReIkxcZ+bkaH/4vyAxu5Gjky61be3jafQ+pmWVjP5BrGW0vfHz+p77tJZfb+hSt3nZTpSf4m
 ssI5l5k3aXJQhvLOuSaPbl9b+tXPb/GteCluyXsOzSUBzonddbv174sfm8BznKfYy4Uxe9/E
 u+yde+3Xa7EXqHT17W1bHbwhe8czn5deAZ+UWIozEg21mIuKEwHJ+97AhQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LJbGCaqHt6Y1aSwYcf3BanJyxispi/7Cm7
 A5PH5hVaHpuX1AcwRXHZpKTmZJalFunbJXBl7GzNKHjPUbF3/U6mBsYF7F2MnBwSAiYS6w/O
 Zu5i5OIQEljNKDF10nwWCOcjo8Sbme+YQKqEBJYxSuxtCuxi5OBgE9CUeLu/ACQsAmTeWt7O
 DBJmFnCVWHM2CyQsLGAv8fPbARaIEgeJU9O/s4CUiAhYScxYlQ0SZhFQldh6pp0RxOYFCi+f
 t5ANYutmoK3n7jOC1HMK6Epc3AFWzyggJvH91BqwY5gFxCVuPZnPBHG+gMSSPeeZIWxRiZeP
 /7FC2IoS97+/ZIeo15FYsPsTG4StLbFs4WtmiL2CEidnPmGBqJeUOLjiBssERvFZSFbMQtI+
 C0n7LCTtCxhZVjGKlxYX56ZXFBvnpZbrFSfmFpfmpesl5+duYgRG1Ol/h2N2MN679VHvECMT
 B+MhRgkOZiUR3i+7M5KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83rETowXEkhPLEnNTk0tSC2C
 yTJxcEo1MPWo1fOlfZWXmMb27dHrJ2LvY3qYmgxUn+dL3fgTdfDgPb4b7RHRX63d0npbeurq
 JTwY3HQOpu33mNyjfCbbtvsxt4zr+x06mf5L1/BeuRSu+9ZvTUVeotxExfwFm6409tqxmR9r
 W/BDrEbW6ZWT27qiYw6ss/hes6SqbK8JqC9hepv0JnZ7tQdbW+6Zg5IOZ8+a/ig0OX/lTkDQ
 hMdmXkLCb+PkdLdeeOXRKG12Ytl1Pu6yWWq79/WsP3JA7ekcnhm7ZT9+tjtyZ+v1mo+RN8WN
 TO8tdbylxfp9d9/mqwI3FTJeeYgeiftT3mQ67er/Ce7vU/8fvmg3seqK5qv3p7cfOXVt+qoF
 3bW+DYo9T5VYijMSDbWYi4oTAbPUyAcXAwAA
X-CMS-MailID: 20220428152459uscas1p22f3ecc16b67150e80c357854a44561a6
CMS-TYPE: 301P
X-CMS-RootMailID: 20220418194351uscas1p18e05fad61bc279e8ea18d1a1a8597dc3
References: <CGME20220418194351uscas1p18e05fad61bc279e8ea18d1a1a8597dc3@uscas1p1.samsung.com>
 <20220418194324.589248-1-vincent.fu@samsung.com>
 <YmqtycoRZO3yxVCW@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_082503_836132_C2F6F09C 
X-CRM114-Status: GOOD (  19.68  )
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

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Thursday, April 28, 2022 11:08 AM
> To: Vincent Fu <vincent.fu@samsung.com>
> Cc: linux-nvme@lists.infradead.org
> Subject: Re: [PATCH] nvme: have nvme_setup_rw return BLK_STS_OK
>=20
> On Mon, Apr 18, 2022 at 07:43:50PM +0000, Vincent Fu wrote:
> > Return BLK_STS_OK instead of 0 on success. Since BLK_STS_OK is
> defined
> > as 0 this patch results in no functional change but to avoid confusion
> > and to be consistent with nvme_setup_write_zeroes as well as
> > nvme_setup_discard we should have nvme_setup_rw also return
> BLK_STS_OK.
>=20
> I really don't see the point.  blk_status_t like all __bitwise types
> is designed to be able to cope with a plain 0 just fine.

Thank you for the feedback. This is obviously a small cleanup but I found i=
t
confusing that the other nvme_setup_* functions returned BLK_STS_OK whereas
nvme_setup_rw returned 0. The code is easier to understand if all of these
functions are consistent and this change saves people the trouble of making
sure that BLK_STS_OK is defined as 0.


Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFA0C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 05:18:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587CA61153
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 05:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587CA61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=CcfzAg7U+4XA0jC0fJ6/A/VqwAyMn93HaewD8TJpJY0=; b=CLEU6qRCC1JP1lmLDZmynqmzy
	K+fh1izhEWjGtVCZsem+pEsQcKPtShkfwNwMQihsoz06Hpn6WQyP3r7tTnTEFbaRMIXSDgLIpTjqJ
	yZGAEsBvbMATqw7gMpJ42ud7vV+gNkRSyswl1YvBV4cqJBXCGz0PpDZClzlobtvnGljQgws1bThrZ
	E7beQ0sGYNGMUP6kwE9DiWI/8C8Ip3G5vJBNv/7nHbgba601FUQQkh2h1Wf76FKCIR3prxGfYPdTx
	FW1QE5wAi4V+EtMo9moC+r8ccfJ4YZM6omS9/PKbwUGEi6s5ATQSPYvp/E7wWSnot6d1pXqxwCDxz
	eFsMct3Yw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWXuX-00BVZ3-KO; Wed, 14 Apr 2021 05:17:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWXuU-00BVYw-PD
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 05:17:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=UxVAPQzY5KiuYEI1a8AAT2n0pd1VziJpvEGkIwB5MSA=; b=xX4NIxqidR14zmS2w8fTtjsPfA
 yV+rWydPWr6Dy4pDdwuDeLAoe3b6WlZDEFqTiAUC257ECrkVTM/PD+Tg1aAv6H0iSg3wveCCZIYDC
 4gQGCnVJl3jpHwyh9aO6hdgcsigxyNUEkRv5jWsqHwYh3IuJThnNG/11DWlSWFhisOMOUJazBdeW5
 dyban3q/kfZiD3yz8sNUd1rdRM03odl1Flr6BY7WBU4fWza8uhuqoKgYhKqvxT0x1s2lyIcHc3vV+
 HYZjGzxGRL7M0aPFYXlNGwzobTeEQcr0RHb5EjLLJGNs+MzfReZsYPOi8qm5rB9zFhHNHQnLBf5cX
 0zT90Udw==;
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWXuP-007UU8-2Q
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 05:17:52 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210414051734epoutp02f9ac7ce009009f9bffdceddf8f577738~1obhtEe062411024110epoutp02c
 for <linux-nvme@lists.infradead.org>; Wed, 14 Apr 2021 05:17:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210414051734epoutp02f9ac7ce009009f9bffdceddf8f577738~1obhtEe062411024110epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1618377454;
 bh=UxVAPQzY5KiuYEI1a8AAT2n0pd1VziJpvEGkIwB5MSA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=QSEXoSB6XLPKsmOEG4PzOBCnAcdaoUvQBWjmsBXp3u9xMcw2EaLXx2Np3WPnSEtkw
 gszQf2raPicLf9C8bd/y6eqNgptIHsDYtaDR53DNT0QDH1lH1ZU3VVN/wUq3RYYn5G
 wPDYMAgpMvk9zbbg4zlX/0QsXH21j846AsLaeNQE=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20210414051733epcas5p142e9bf8ecf3991f6e9e6abdd3c1168df~1obhEZbUc3169031690epcas5p1Y;
 Wed, 14 Apr 2021 05:17:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 8A.72.41008.DEA76706; Wed, 14 Apr 2021 14:17:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210414051733epcas5p31d0a4727a2c05b76bcf7ee75c290aaef~1obgcF3jx0977309773epcas5p3d;
 Wed, 14 Apr 2021 05:17:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210414051733epsmtrp177c53b47dade3b5d437e999e5fead36a~1obgbSxh70782207822epsmtrp1M;
 Wed, 14 Apr 2021 05:17:33 +0000 (GMT)
X-AuditID: b6c32a4b-661ff7000001a030-9c-60767aed029d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 16.AE.08745.DEA76706; Wed, 14 Apr 2021 14:17:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210414051731epsmtip1b9e3c28ec4f2ab63799cb6a4f6d7d03d~1obe0t1Hx2409124091epsmtip1Q;
 Wed, 14 Apr 2021 05:17:31 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/2] kref and paasthrough cleanup
Date: Wed, 14 Apr 2021 10:46:27 +0530
Message-Id: <20210414051629.103383-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7bCmuu7bqrIEg5mXDSyaJvxltlh9t5/N
 Ytbt1ywWK1cfZbI4+v8tm8WkQ9cYLeYve8puse33fGaLK1MWMVuse/2exeL1j5NsDtwe5+9t
 ZPG4fLbUY9OqTjaPzUvqPXbfbGDz6NuyitGj/UA3UwB7FJdNSmpOZllqkb5dAlfGlc3rWArO
 MlX07L7A1sDYwdTFyMkhIWAi8XXuEtYuRi4OIYHdjBIXrh5mgnA+MUo86b3BCOF8ZpSYufUp
 I0zL/KPv2SASuxgl/vV+YoGr2rF3J9AwDg42AU2JC5NLQRpEBJIkml40ge1jFnCXuP2kB8wW
 FjCUuLvxEQuIzSKgKvF4yTGwBbwClhIrJjUwQyyTl5h56Ts7RFxQ4uTMJywQc+QlmrfOZgbZ
 KyHwl13i9Y9GqIdcJFq757JD2MISr45vgbKlJF72t0HZxRK/7hyFau5glLjeMJMFImEvcXHP
 XyaQB5iBHli/Sx9iGZ9E7+8nYGEJAV6JjjYhiGpFiXuTnrJC2OISD2csgbI9JE7O6AL7RUgg
 VuJxWxPjBEa5WUhemIXkhVkIyxYwMq9ilEwtKM5NTy02LTDOSy3XK07MLS7NS9dLzs/dxAhO
 PVreOxgfPfigd4iRiYPxEKMEB7OSCK/blJIEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rw7DB7E
 CwmkJ5akZqemFqQWwWSZODilGpiuRWgaX2US2Rn+RilFYj6/xAumlFNpMXqbGmL9S+P3pYvv
 sJZceT6qdMOe8131j8Q7iw6vPB/d3KWoEnH9SKHyullXE5rbp+1K+6xcd/5iTvunpNjkz52T
 dgo9fN63q2+N5FLxgq1GDGESf4KjpxV2zuDWe3+8TPXcjMz5Crt+Pg/xm2KfNXXD7/v9Cx0X
 Z8tViHe9qlt0gvFma+g+Zp4lr5bqXTvXUTb36qGAOc5s9164JQlvPCvf6/nsM4PUxR9nPi01
 q1/6jLncNc5ixvcZvwNO6IVv0fecJ7npbNGfMxWlt25bahouv/S7Yp/j9YP82QXb1n074FkT
 fn4vc8uLsg/GHz5vWegstn6K47QOJZbijERDLeai4kQAKNuBaawDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnO7bqrIEg127WS2aJvxltlh9t5/N
 Ytbt1ywWK1cfZbI4+v8tm8WkQ9cYLeYve8puse33fGaLK1MWMVuse/2exeL1j5NsDtwe5+9t
 ZPG4fLbUY9OqTjaPzUvqPXbfbGDz6NuyitGj/UA3UwB7FJdNSmpOZllqkb5dAlfGlc3rWArO
 MlX07L7A1sDYwdTFyMkhIWAiMf/oe7YuRi4OIYEdjBITJl9khUiISzRf+8EOYQtLrPz3nB2i
 6COjRG/HDsYuRg4ONgFNiQuTS0FqRAQyJM6famUBCTMLeEqsnygPEhYWMJS4u/ERC4jNIqAq
 8XjJMUYQm1fAUmLFpAZmiPHyEjMvfWeHiAtKnJz5BKyeGSjevHU28wRGvllIUrOQpBYwMq1i
 lEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgObi2tHYx7Vn3QO8TIxMF4iFGCg1lJhNdt
 SkmCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUx8wnHc
 s33ncYZF9IfOjE4PcvoXOVNx0rybVq3HQv/MPrQ64LuDQUpv64oWpakBn56W7p3bH7eh+5z+
 1zW3LjPdZphpH2FjVOT8L4SH/3TlPA+ZqP2v6+1nz9/x3iGwa01b5cHMFzM+6SsnP9+lq7Iz
 8Ni+bp5vC2S5du64YxO+evlVQeU3skelXitIcL/d/fVb5Gce5rdcXc2bGjT6vgikmgZybki4
 uv3l55XO7oL71M+dlDxX5RCz9In+vSu7vfKnmey5eaAqUPcsm+v3NY80Z038FM/tI1O0YkP6
 gXmO18JWzjDOOPeIN/xB47q2TxZ79q7nm+PdMNM7anrvlD+XLDO3TJqyuarxaPvvQw4zlFiK
 MxINtZiLihMBVJ/xsN0CAAA=
X-CMS-MailID: 20210414051733epcas5p31d0a4727a2c05b76bcf7ee75c290aaef
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210414051733epcas5p31d0a4727a2c05b76bcf7ee75c290aaef
References: <CGME20210414051733epcas5p31d0a4727a2c05b76bcf7ee75c290aaef@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_221749_649822_879DDA5F 
X-CRM114-Status: GOOD (  10.03  )
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

First patch is to avoid opencoding ns->kref, while second one gets rid
of a memset in passthrough io path.

Kanchan Joshi (2):
  nvme: add nvme_get_ns helper
  nvme: avoid memset for passthrough requests

 drivers/nvme/host/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

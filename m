Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7ABC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 11:47:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6D66112F
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 11:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6D66112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gdMw1c3/JFwATsK5vxeQSJmw7PMlFMtOcmT7WO8l3d8=; b=NMlbC9UpYNKf5wcfXJw5hsc9I
	cCSkPqqxWxv1qKsOKuc9jZuj3qOgG1VYiVAhpdw6QsVLuuaafgSIa0t61dPFj/D6C0Nqdelb4DSPD
	pjds+L0HrmLPQ5FOh128+WcQWRKT251+rTANqZtIDx9DYZniOCQxd+d0qrEmP1ODRWuEsR1U37Kqg
	8s5wLtmkaYrO07eIajvmagKVheKxXdZ08LvDM5O4Wo60c5WffjmmU6kGCa+JmyZLBtpLuMyePptAl
	rnV1x1xyBomBpNpt/4hKRqZ6I41WLqc/Mfd4cvEMlE7N/p4+kgcg+oOAlZCYAPpvVigJ3Q40xUGr1
	hQtavyHaQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUT7t-007tOX-3q; Thu, 08 Apr 2021 11:47:09 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUT7l-007tM2-3v
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 11:47:06 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20210408114655euoutp0249a031b0ea9685d9f98cf768d5515ff5~z33wcT1bK1863418634euoutp028
 for <linux-nvme@lists.infradead.org>; Thu,  8 Apr 2021 11:46:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20210408114655euoutp0249a031b0ea9685d9f98cf768d5515ff5~z33wcT1bK1863418634euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617882415;
 bh=Claa8szoXeW09SoG++7Be8p20qwLcRrSDC4NVJqMnSY=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=s+v1vDt+R6K8NhiG9hsYIvjzzjsocmONyYiXHBuLPYNacbV9XVf7vjk2KQGJcyZJY
 Z4ATNH1SlZ9YKorXpUyAigAN+mp0gQeGhQhd3S5ZDA3olOUN7La7XgmUcjXVwtu8Jc
 +sOggwqMm1GNqJFvkpMxKGT11Ro50nuQDHcZjr1M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210408114654eucas1p1c30e12d8fd050270e28651f4ac60ec9d~z33wHBvja2524125241eucas1p1y;
 Thu,  8 Apr 2021 11:46:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 94.CE.09452.E2DEE606; Thu,  8
 Apr 2021 12:46:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210408114654eucas1p276568a104ae5177fafa9602bd66f5dc4~z33vw82V91841618416eucas1p2D;
 Thu,  8 Apr 2021 11:46:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210408114654eusmtrp2a5be79d0a576e0eb08fcf660018336e6~z33vwQbQe1687916879eusmtrp2F;
 Thu,  8 Apr 2021 11:46:54 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-9a-606eed2efc7a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.6C.08705.E2DEE606; Thu,  8
 Apr 2021 12:46:54 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210408114654eusmtip225e0651c8468f06124108069cba5de6f~z33vk_2LM1698616986eusmtip2I;
 Thu,  8 Apr 2021 11:46:54 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 8 Apr 2021 12:46:53 +0100
Date: Thu, 8 Apr 2021 13:46:53 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
 <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210408114653.slyeuzqpdbkvnqzb@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408112740.GA9567@lst.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87p6b/MSDObfN7b4v+cYm8XK1UeZ
 LM6/PcxkMenQNUaL+cueslv86uS2WPf6PYsDu8fE5nfsHjtn3WX3OH9vI4vHplWdbB6bl9R7
 7L7ZwBbAFsVlk5Kak1mWWqRvl8CVsW/nFJaCHraKxx3T2BsYn7F0MXJySAiYSEyf+Jypi5GL
 Q0hgBaPE9jk3WSGcL4wSCy+8g8p8ZpRYffcHE0zLqcm32CESyxklJt6ZzwZXNfsdTGYLo8Tv
 jz2MIC0sAioSe/avYAWx2QTsJS4tu8UMYosIKEk8fXWWEaSBWeACo8S/mZvZQBLCAp4SR2d8
 BNvHK2AjMbnlJDOELShxcuYTsNOZBawkOj80AQ3lALKlJZb/44AIy0s0b50NVs4poC2x6OtL
 FpASCQFlieXTfSE+qJVYe+wM2J0SAv85JPYsPM8IUeMicf2EKkSNsMSr41vYIWwZif875zNB
 1DczSpxZc4UZwulhlPgzaQVUs7VE35kciAZHiftPFrJBhPkkbrwVhDiNT2LStunMEGFeiY42
 oQmMKrOQ/DULyV+zEP6aheSvBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQKT0el/
 xz/tYJz76qPeIUYmDsZDjBIczEoivDt6sxOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ866avSZe
 SCA9sSQ1OzW1ILUIJsvEwSnVwJT2Z0ua1bNf52O6bwg1lWyqqrm80NXc6nx14I70B7ycX1M9
 732cXWCp9Pk74+kjr/9e/skTdnH2pu5k240HfTN+zZ4WqrfgOOfW/1r2f46JXXXkTT0zPyau
 /HmHlcyBgz82HwmJPma49Iv0HG129lXVCalBiperXG1dmW3/VIdOd/ay/7WcY+fpnnc/N87l
 2bPeOOPtwdsbVHbOlc++dzdl2YV5Mp6cHc7npt1uP77Nu/GWpp93xtT9i5b8ODyn5/EeYe5y
 wX6XvAabtlfOv84k3hUWKfOR31H7sPKE2FdPbfZFOQcPKtb3qayfY/5ZtvDbnOXCvcYKRl/N
 RO9JyQWsYBPyMTGOnfN+kUKI6V8lluKMREMt5qLiRACfMBLFtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7p6b/MSDH7ekrb4v+cYm8XK1UeZ
 LM6/PcxkMenQNUaL+cueslv86uS2WPf6PYsDu8fE5nfsHjtn3WX3OH9vI4vHplWdbB6bl9R7
 7L7ZwBbAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
 l6CXsW/nFJaCHraKxx3T2BsYn7F0MXJySAiYSJyafIu9i5GLQ0hgKaPEq90fmSASMhKfrnxk
 h7CFJf5c62KDKPrIKPHg2U4WCGcLo8SOaxfZQKpYBFQk9uxfwQpiswnYS1xadosZxBYRUJJ4
 +uosI0gDs8AFRol/MzeDNQgLeEocnQGxjlfARmJyy0lmiKl7mCValm+BSghKnJz5BOxYZgEL
 iZnzzwNN4gCypSWW/+OACMtLNG+dDbaMU0BbYtHXlywgJRICyhLLp/tCfFAr8er+bsYJjCKz
 kAydhWToLIShs5AMXcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwWrcd+7l5B+O8Vx/1
 DjEycTAeYpTgYFYS4d3Rm50gxJuSWFmVWpQfX1Sak1p8iNEUGEQTmaVEk/OB6SKvJN7QzMDU
 0MTM0sDU0sxYSZx369w18UIC6YklqdmpqQWpRTB9TBycUg1M8084ca2a7/AnM145obncrbv8
 uoVIv/K8+e6pO79qqE7fk7r8DvcdWxNmG+7X+/3LpApvOV4MFW69uTp+rcKtmWtKohS33J5y
 sfu95+Hrv7I/vPivmmP+N+doe46ZjvJfn0+sd2+eiYqZy3b0dX31Apdp2yo+8G6w223/P8k4
 r/tqtHr/HZeGhUt+bYxKN1+5JaxqUeFk59qSdIVtqywPBK1UKlRO1vqf+m2ZpUj2kvmK/odY
 doas5ZyQ+drRcK+u0eT7zVXbdwvdOakYvLdBkWPvk2/z5n1Ybpra4HUi3WeBe+UFmbzmBbsX
 p29dfulZ68af0cl39jRfqk/5uLZyw7Oy+xVysz9cWzmLYaVDhhJLcUaioRZzUXEiADaHQQpf
 AwAA
X-CMS-MailID: 20210408114654eucas1p276568a104ae5177fafa9602bd66f5dc4
X-Msg-Generator: CA
X-RootMTR: 20210407171407eucas1p2e8bf869cecf13d6810d797515afff126
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210407171407eucas1p2e8bf869cecf13d6810d797515afff126
References: <20210407153536.GA8667@localhost>
 <20210407154730.GC8667@localhost> <20210407164818.GA31878@lst.de>
 <20210407170905.GB9994@localhost>
 <CGME20210407171407eucas1p2e8bf869cecf13d6810d797515afff126@eucas1p2.samsung.com>
 <20210407171400.GA32592@lst.de>
 <20210408071128.pps76zydao3oufqn@mpHalley.localdomain>
 <20210408072641.GA24793@lst.de>
 <20210408102625.2u6sarhs2qss35ft@mpHalley.local>
 <20210408112740.GA9567@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_124704_037223_1A1BCCD0 
X-CRM114-Status: GOOD (  12.52  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDguMDQuMjAyMSAxMzoyNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5PbiBUaHUsIEFw
ciAwOCwgMjAyMSBhdCAxMjoyNjoyNVBNICswMjAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+
PiBJbiB0aGlzIGNhc2UsIEkgYmVsaWV2ZSB3ZSBzaG91bGQgc3RpbGwgY3JlYXRlIHRoZSBjaGFy
IGRldmljZSBzbyB0aGF0Cj4+IGFueSBPTUUtc3BlY2lmaWMgTlZNZSBkZXZpY2UgY2FuIHN0aWxs
IGJlIHVzZWQgZnJvbSB1c2VyLXNwYWNlIHdpdGhvdXQKPj4gcmVxdWlyaW5nIFNQREsgYW5kIGEg
UENJIGRldGFjaC4KPgo+T01FPwoKT0VNLi4uIFNvcnJ5LgoKPgo+PiBEb2VzIHRoaXMgc291bmQg
Z29vZCB0byB5b3U/Cj4+Cj4+IFJlZ2FyZGluZyB0aGUgY3VycmVudCBsb2dpYywgSSB3b3VsZCBu
b3QgbWluZCB0aGF0IHRoZSBibG9jayBkZXZpY2UKPj4gc3RpbGwgYXBwZWFycyBhcyBhIHplcm8g
Y2FwYWNpdHkgdG9vLiBXZSBjYW4gdGhpbmsgb2YgcmVtb3ZpbmcgdGhpcyBpbgo+PiB0aGUgZnV0
dXJlIGFzIHRoaXMgcGF0aCBiZWNvbWVzIG1vcmUgc3RhYmxlLiBJdCByZXF1ZXJpZXMgS2FuY2hh
bidzIHdvcmsKPj4gb24gaW9fdXJpbmcgdG8gYmUgdXNhYmxlIGZvciBJL08uCj4KPkkgdGhpbmsg
d2l0aCB0aGUgY3VycmVudCBwYXRoIHRoaXMgc2hvdWxkIGp1c3Qgd29yay4gIElmIHlvdSBoYXZl
Cj5hIGRldmljZSB0aGF0IHRyaWdnZXJzIHRoaXMgY2FzZSBwbGVhc2UgdGVzdCBpdC4KCkNvb2wu
IEknbGwgdGVzdCB0aGF0LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=

Return-Path: <SRS0=FTT0=YE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC1C10F14
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2019 00:52:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CDD2053B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2019 00:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f1jZ/ZjL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FCPfWtCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CDD2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j4kC0N5EDnefKrYwQ2i8d6cfVlUI9WHABIJz+lSleYo=; b=f1jZ/ZjLM3t31r
	f3m4DZgduSGporjP2hTf1KbcDBjrWUjXWY1hCYtUTRcqHblrcpV8+0/0WvqBCd9Hu5v/kIVhbdo+o
	kPilWyurS1Dq8Klte9AXCMKvAMRRSzBt1pWgFAMJP9ZxTuIv5B8yEtgP/y78d8nsfirFgRQP+Bili
	Dbyz++gv5sODxj/mNP2kuEXtwmqsJkWIK3nDlA40unwEYGkMKdECzKzq3yWnmLcNw9HzFEgxrNPMb
	6VAzS9SZSu6pvT3seoieN/NasN8zFWZtbt33t3PvldFNXuLVwdYp6T4fuzytHc+8AJn65Ec/c5hI/
	pIERDJTf8AGAkv0pOIEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIjA4-0001Gg-VJ; Fri, 11 Oct 2019 00:52:04 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIjA2-0001Fs-9a
 for linux-nvme@lists.infradead.org; Fri, 11 Oct 2019 00:52:04 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20191011005159usoutp0245f3625af594fb548c45b629bbcc5399~McXVvxydg2301323013usoutp02z;
 Fri, 11 Oct 2019 00:51:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20191011005159usoutp0245f3625af594fb548c45b629bbcc5399~McXVvxydg2301323013usoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1570755119;
 bh=7vgHb/uNXeteYjuQxUx373xvBn+hQuNl3YGrI8lW+zY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=FCPfWtCZpzGoxLetAJgQG0Zbii5RSTEgzG3qZR21m/PykP/bwnnolJUG9E61nMR1v
 gIvZ3CkDOuee0Awr1B4f7F+a+lqWj587yI5OoKR8NgRF/cuFuacn9rYjA7odR353Z2
 f5SyfLBNLE2DU0/PwfhyHl8jrOH7iAT/hXme0Ri4=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191011005158uscas1p20e7334640ea70f0c1e2bbaeff5cb216c~McXVgiY7u0145401454uscas1p2N;
 Fri, 11 Oct 2019 00:51:58 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id C5.C1.04518.E22DF9D5; Thu,
 10 Oct 2019 20:51:58 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191011005157uscas1p13e806bf7ef28ddb2783824cda7afc3fe~McXUlbZRs0442604426uscas1p1k;
 Fri, 11 Oct 2019 00:51:57 +0000 (GMT)
X-AuditID: cbfec36f-9e3ff700000011a6-23-5d9fd22ec796
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 82.AB.04386.D22DF9D5; Thu,
 10 Oct 2019 20:51:57 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
 SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 10 Oct 2019 17:51:57 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
 SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
 15.01.1713.004; Thu, 10 Oct 2019 17:51:57 -0700
From: Judy Brock <judy.brock@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCHv2 5/6] nvme: Prevent resets during paused states
Thread-Topic: [PATCHv2 5/6] nvme: Prevent resets during paused states
Thread-Index: AQHVbzI+dJlszoeR2E+qT0eglmqvQadAj46AgAAtZYCAEyh68IAAl1MAgAA+1BA=
Date: Fri, 11 Oct 2019 00:51:57 +0000
Message-ID: <18826c8a6c9545759d25534366e33aab@samsung.com>
In-Reply-To: <20191010135914.GB56376@C02WT3WMHTD6.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djXc7p6l+bHGjScNrVYMeMTq8XK1UeZ
 LHYv/MhkMenQNUaL+cuesluse/2exYHNY9b9s2we5+9tZPFYvOclk8emVZ1sHpuX1HvsvtnA
 FsAWxWWTkpqTWZZapG+XwJWxaKFzwRmhimffGxgbGB/wdzFycEgImEg8nW3QxcjJISSwklHi
 x/0UCLuVSWLjZl8QG6TkxddrTF2MXEDxtYwSbbffskE4Hxkl9l45ApU5wCjx5tRmNpAWNgFN
 iaNnmlhAbBEBZYm782eygtjMAp1MEu9a+UBsYQEXiZNv29khalwlVnV+ZYWw/STW/2hlA7mO
 RUBV4nhLEkiYV8BKYsvtzcwgNqeAncTim61gqxgFxCS+n1rDBDFeXOLWk/lMEFcLSiyavYcZ
 whaT+LfrIRuErShx//tLdoh6HYkFuz+xQdjaEssWvmaG2CUocXLmExaIekmJgytusID8KCGw
 iF1i65UJ7BAJF4l1x7dCLZCWmL7mMlTRLkaJyX2nmCCc44wSE06cY4SospZY9HUV1Go+ib+/
 HjFOYFSeheTyWUiumoXkqllIrlrAyLKKUby0uDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMAmd
 /nc4fwfj+SXJhxgFOBiVeHhnyM+PFWJNLCuuzD3EKMHBrCTCu2jWnFgh3pTEyqrUovz4otKc
 1OJDjNIcLErivKd2d0cLCaQnlqRmp6YWpBbBZJk4OKUaGAP3T1p/WUMhUC/zULb76XJG26u6
 ZzfuzS7r0WNwfmffPc++U7Qj7dullwpzuM6nJEzRW2XtUTfdomh3n/xyi2Xsbfdzfhr8sM4P
 NH+4uLNT3zHqtpHfh9mbz605xr5pX/qPZdOzZzz8rzD141beuHdSvWe5W5j5Ii0DCzw26K7e
 +nLJ2wftBUosxRmJhlrMRcWJAJu1XYE+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWS2cA0SVf30vxYg2MzzCxWzPjEarFy9VEm
 i90LPzJZTDp0jdFi/rKn7BbrXr9ncWDzmHX/LJvH+XsbWTwW73nJ5LFpVSebx+Yl9R67bzaw
 BbBFcdmkpOZklqUW6dslcGUsWuhccEao4tn3BsYGxgf8XYycHBICJhIvvl5j6mLk4hASWM0o
 cWTuBmYI5yOjxK03G9khnAOMEudb/jKDtLAJaEocPdPEAmKLCChL3J0/kxXEZhboZJJ418oH
 YgsLuEicfNvODlHjKrGq8ysrhO0nsf5HK1sXIwcHi4CqxPGWJJAwr4CVxJbbm6EWP2KSOPD6
 LFg9p4CdxOKbIPWcHIwCYhLfT61hgtglLnHryXwmiBcEJJbsOc8MYYtKvHz8jxXCVpS4//0l
 O0S9jsSC3Z/YIGxtiWULXzNDLBaUODnzCQtEvaTEwRU3WCYwis9CsmIWkvZZSNpnIWlfwMiy
 ilG8tLg4N72i2DgvtVyvODG3uDQvXS85P3cTIzBWT/87HLOD8e6S5EOMAhyMSjy8HxTnxwqx
 JpYVV+YeYpTgYFYS4V00a06sEG9KYmVValF+fFFpTmrxIUZpDhYlcd5WiQVRQgLpiSWp2amp
 BalFMFkmDk6pBkZv1qdTTwYFObrtPicix6FYtZ7ryawWgewpb33bWK+LW+8XP5urnZu0QPG7
 6v3dL+c4xErG8lpu3F9SZrtM5OaNmHWHI1d+zH7hfueRtUqk6e+tpUIFCQ6XVtUmd/W8UvTS
 KXzEdJs9l/PSpozV5z0lBNoz1zq5Hnog5XfMifeq82STfU+UZiuxFGckGmoxFxUnAgD0wg21
 0QIAAA==
X-CMS-MailID: 20191011005157uscas1p13e806bf7ef28ddb2783824cda7afc3fe
CMS-TYPE: 301P
X-CMS-RootMailID: 20191010120317uscas1p1e4483ca19dbb0e550c413c18c5928537
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-6-kbusch@kernel.org> <20190927214121.GK16819@lst.de>
 <20190928002349.GA17232@C02WT3WMHTD6>
 <CGME20191010120317uscas1p1e4483ca19dbb0e550c413c18c5928537@uscas1p1.samsung.com>
 <2f876efff1484f5f95b852584b27efc6@samsung.com>
 <20191010135914.GB56376@C02WT3WMHTD6.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_175202_474696_A1BF4EB7 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Edmund Nadolski <edmund.nadolski@intel.com>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> That is rather unusual, which means it is a good test to have! Would you consider porting your case to blktests?

I'll find out if it is allowed. Where are "blktests"  and is there a pointer to how cases are added?

Thanks,
Judy

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Thursday, October 10, 2019 6:59 AM
To: Judy Brock
Cc: James Smart; Edmund Nadolski; Christoph Hellwig; linux-nvme@lists.infradead.org; Sagi Grimberg
Subject: Re: [PATCHv2 5/6] nvme: Prevent resets during paused states

On Thu, Oct 10, 2019 at 12:03:16PM +0000, Judy Brock wrote:
> Hi Keith,
> 
> Any chance you can get this patch in to the nvme tree soon? 

I'll try to find some time to respin today to address some of the feedback.

Christoph, are you okay with my explanation for not introducing another ctrl
state? We could add a paused state, but I think it's a bit risky for no real
gain.
 
> We believe it may fix an issue we have seen. We are throwing a ton of stuff
> at two controllers on a dual ported device at the same time including
> multiple nested resets, nested FW Activations, nested Formats, DSMs, FW
> Downloads, etc. We saw this in dmesg in one test run. We think Processing
> Paused bit was probably not valid at the time as we don't have any record of
> any FW Activates that went to either of the controllers and never finished.

That is rather unusual, which means it is a good test to have! Would you
consider porting your case to blktests?

   https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_osandov_blktests&d=DwICAg&c=JfeWlBa6VbDyTXraMENjy_b_0yKWuqQ4qY-FPhxK4x8w-TfgRBDyeV4hVQQBEgL2&r=YJM_QPk2w1CRIo5NNBXnCXGzNnmIIfG_iTRs6chBf6s&m=Hs0mocSKTjH-thQeB1DSzzm-eTmZH3RXTCGZpRSBlWk&s=PPcqQ2ySml8pGvqNMVV9-KQc2mH-RbyN_3yqeV4yf9A&e= 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=JfeWlBa6VbDyTXraMENjy_b_0yKWuqQ4qY-FPhxK4x8w-TfgRBDyeV4hVQQBEgL2&r=YJM_QPk2w1CRIo5NNBXnCXGzNnmIIfG_iTRs6chBf6s&m=Hs0mocSKTjH-thQeB1DSzzm-eTmZH3RXTCGZpRSBlWk&s=b4-R8uoEjU4mBPehgtQfsanEEv8D-sgbkUvLPTO3ZCM&e= 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

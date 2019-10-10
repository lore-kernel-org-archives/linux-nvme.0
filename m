Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D370FC10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 12:03:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E68620650
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 12:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WlyVsq/v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HADV8++B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E68620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gfS54DsUbfyK6CHy7ANttAKf1rBNTDaLIKxfRPmgmEw=; b=WlyVsq/vlkpFQH
	TrLLSDizPK6mmuCjyWJPPYaiF7DDsJ/gZkO5jE1dRVPA+xF9OSYPzXliBG5PYoGMPOEOw41KLI3yt
	ScQxbdlOkJSPcCZvaL4ySSDJ2bSM2ixFeY7LuK+NhWSHoMQuQT4l8bUSr+mAN/hh2uDkJi9Ttzr77
	M5ffkOeVwDQBv07V4QHYuvf+ifzruOjnwtkdkd7+mwclmo/VCFQaHCE4NxDnFiUJBy2W7DdlRbHdj
	P35wZFwvrIK7SK4+B5YnDF5cNIDjsFT0zGbgW6Nzcbh5zMjTm8jHq5QaXiZoLxKWPneXq/3hOw8tL
	HNbJ7R10qo4QPr2L3XCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIXAC-000681-Ou; Thu, 10 Oct 2019 12:03:24 +0000
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIXA8-00067P-MG
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 12:03:22 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20191010120318usoutp01af3bf4244e2a3b78e057991e27270962~MR4MjGu6U0197201972usoutp01v;
 Thu, 10 Oct 2019 12:03:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20191010120318usoutp01af3bf4244e2a3b78e057991e27270962~MR4MjGu6U0197201972usoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1570708998;
 bh=LkNniN7Lrfl+RgO0vMkRPqS4BH3G7D4MhdfDSn01Lek=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=HADV8++B0Rcbdb5vMQkA7R2fBqIsjC8+hIf1zFL6wLkkYOYWRNWifGqcLhP261WAy
 RJ73KIvoxE4+cZ7I3AFyX9aHcfmwWbqGIl/fMVYuq+jn8VdXmK4l/eMCTpGcFbo47P
 WWVIoobHi8IktHVWr84t/hDj1bv7rZeb/C51JRxk=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191010120318uscas1p1a16f2705ac2104e9cbad762ae78b217a~MR4MUJZTE0097100971uscas1p1J;
 Thu, 10 Oct 2019 12:03:18 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id 48.6A.04518.60E1F9D5; Thu,
 10 Oct 2019 08:03:18 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191010120317uscas1p1e4483ca19dbb0e550c413c18c5928537~MR4Lx9qSM1968919689uscas1p1M;
 Thu, 10 Oct 2019 12:03:17 +0000 (GMT)
X-AuditID: cbfec36f-9cbff700000011a6-a8-5d9f1e06f965
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 53.84.04386.50E1F9D5; Thu,
 10 Oct 2019 08:03:17 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
 SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 10 Oct 2019 05:03:16 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
 SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
 15.01.1713.004; Thu, 10 Oct 2019 05:03:16 -0700
From: Judy Brock <judy.brock@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCHv2 5/6] nvme: Prevent resets during paused states
Thread-Topic: [PATCHv2 5/6] nvme: Prevent resets during paused states
Thread-Index: AQHVbzI+dJlszoeR2E+qT0eglmqvQadAj46AgAAtZYCAEyh68A==
Date: Thu, 10 Oct 2019 12:03:16 +0000
Message-ID: <2f876efff1484f5f95b852584b27efc6@samsung.com>
In-Reply-To: <20190928002349.GA17232@C02WT3WMHTD6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURzGPXd3d9fV4jrN/VN6Wy9YmpZJXKykF4tZX+pjhtXQ2xTdlF21
 9EuSiC+haBblzPdpuk3xJUw3kzWznE1HGOIMksTyjShFGUlKbneB357n/H/nPM85HJInbuMH
 kEmqdEatkqdICSHe/X519BixpybueFnJNrr5+TKfbtEPYrSpbgmjH1vGEV3T9F1Aty3+ws8R
 Ms3UCCGzf+3AZQ1985isU1dIyLq0D2QmRw5xjYgVnklgUpIyGXVY1B1hYrk2X5A263ffYGnB
 c1CDTxEiSaAioNwRU4SEpJhqQeDsLME5k4fBrN3EK0LebmiyOBdzaTHVimAlN5ODlhDk5vwg
 OGNG0L+gcVMEdQQGbQ9xl/ajLsJ6sR1zQTxqFkFZ+4p74EtFg/VnvoCDLoGucJXP6QtQuWFw
 R+PUIeid7+e5uoqoSGgfv+Ja9qbCwTxS6cYR5Q/OYYM7l0dJYHKmBuNa+0B9ZZ/nBv6wYfxG
 cHo/TDnnBRwfArWmZYLTwdBUt+jmRZt7rRUzOMfvgrfNE+5nAapeAIX2z56DosFm/s3ndCA8
 M4x5ICOC8pJhjDMfEJQOjSKOOg31qzpP9A5YX5tGpeiAZktzzZZWmi2tNFta1SJchyQZLKtU
 MGy4irkXysqVbIZKERqfquxEm7/o48ZAag+ya+MtiCKRdLso0VoVJ+bLM9kspQUByZP6ieo1
 L+LEogR5VjajTr2tzkhhWAsKJHGpRDRsenRTTCnk6Uwyw6Qx6v9TjPQOyEGRA6EhM2cnrCuF
 A4ZWrf78m6Ha6S5Fgc/J7ie9Baeq9OtXJw/bsE/61Vt/7j71rg5KD/KiJxp9wxqV1VEy6bu8
 7GbzdWNrRNYXB+FMTrhcu/C6Oriux7aTbyid6yjdJQqhX3XM7d399+DL2BjV1Ci9Jhrzqkhy
 SPYNyXkmo/OGFGcT5SeO8tSs/B/XKgDpQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWS2cA0SZdVbn6swfaDchYrZnxitVi5+iiT
 xe6FH5ksJh26xmgxf9lTdot1r9+zOLB5zLp/ls3j/L2NLB6L97xk8ti0qpPNY/OSeo/dNxvY
 AtiiuGxSUnMyy1KL9O0SuDImL2lnL3guUrHm0EqWBsbFgl2MnBwSAiYSt3qbmboYuTiEBFYz
 SjRcamCDcD4yShw9/Qoqc4BR4sPreawgLWwCmhJHzzSxgNgiAs4Sf3vPgxUxCzxnlJi44QtY
 QljAReLk23Z2iCJXiVWdX1khbCeJ2f/WMIPYLAKqEjtf7gOyOTh4BawkNlzzgli2klHi785W
 JpAaTgEjiQNnZ4P1MgqISXw/tQYsziwgLnHryXwmiB8EJJbsOc8MYYtKvHz8jxXCVpS4//0l
 O0S9jsSC3Z/YIGxtiWULX4PV8woISpyc+YQFol5S4uCKGywTGMVnIVkxC0n7LCTts5C0L2Bk
 WcUoXlpcnJteUWycl1quV5yYW1yal66XnJ+7iREYr6f/HY7ZwXh3SfIhRgEORiUe3oyTc2OF
 WBPLiitzDzFKcDArifAumjUnVog3JbGyKrUoP76oNCe1+BCjNAeLkjhvq8SCKCGB9MSS1OzU
 1ILUIpgsEwenVAOjxCSnk6dm7LywINZwxd93BnbsNdymF78J9X7q1PlZ9D+o6t9c6+63kU2v
 FX3ufJQKOX9rwnfV9YpWvywXmf9fFFIlYHPdv2MXq097xp6z9XI1ESsn/dk/+YPR4gZhoR13
 upW6/70+cb3MfY2m4b395rtdLhzfJfF87p3J3Ix5v2yf7VU8dmmuuxJLcUaioRZzUXEiAAB2
 JTfTAgAA
X-CMS-MailID: 20191010120317uscas1p1e4483ca19dbb0e550c413c18c5928537
CMS-TYPE: 301P
X-CMS-RootMailID: 20191010120317uscas1p1e4483ca19dbb0e550c413c18c5928537
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-6-kbusch@kernel.org> <20190927214121.GK16819@lst.de>
 <20190928002349.GA17232@C02WT3WMHTD6>
 <CGME20191010120317uscas1p1e4483ca19dbb0e550c413c18c5928537@uscas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_050320_875884_8223331B 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: Judy Brock <judy.brock@samsung.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,

Any chance you can get this patch in to the nvme tree soon? 

We believe it may fix an issue we have seen. We are throwing a ton of stuff at two controllers on a dual ported device at the same time including multiple nested resets, nested FW Activations, nested Formats, DSMs, FW Downloads, etc. We saw this in dmesg in one test run. We think Processing Paused bit was probably not valid at the time as we don't have any record of any FW Activates that went to either of the controllers and never finished.

kern  :warn  : [Wed Oct  2 14:21:06 2019] nvme nvme0: Fw activation timeout, reset controller
kern  :warn  : [Wed Oct  2 14:21:06 2019] nvme nvme1: Fw activation timeout, reset controller

thanks,

Judy

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Friday, September 27, 2019 5:24 PM
To: Christoph Hellwig
Cc: Edmund Nadolski; Sagi Grimberg; linux-nvme@lists.infradead.org; James Smart
Subject: Re: [PATCHv2 5/6] nvme: Prevent resets during paused states

On Fri, Sep 27, 2019 at 11:41:21PM +0200, Christoph Hellwig wrote:
> On Fri, Sep 20, 2019 at 06:34:30AM +0900, kbusch@kernel.org wrote:
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 95b74d020506..33b5729763c2 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3742,15 +3742,14 @@ static void nvme_fw_act_work(struct work_struct *work)
> >  		if (time_after(jiffies, fw_act_timeout)) {
> >  			dev_warn(ctrl->device,
> >  				"Fw activation timeout, reset controller\n");
> > -			nvme_reset_ctrl(ctrl);
> > -			break;
> > +			nvme_reset_continue(ctrl);
> > +			return;
> 
> Hmm, I find the use of a function named nvme_reset_continue here
> rather confusing, as there is no reset we are continuing.  Yes, we place
> the controller in resetting state, but it isn't really a reset in the

A PAUSED state would have to copy the same transitions that RESETTING has. It
seems simpler to just collapse this with the existing RESETTING state, and we
also don't need a special way to schedule reset_work from it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=JfeWlBa6VbDyTXraMENjy_b_0yKWuqQ4qY-FPhxK4x8w-TfgRBDyeV4hVQQBEgL2&r=YJM_QPk2w1CRIo5NNBXnCXGzNnmIIfG_iTRs6chBf6s&m=esS-yc3HRUgI7AHbyjPV-1pJ3qRobo7jEiiqE-oMMpE&s=cCuZq1RCdLq7SrMkSFBJiSVlT_GcXGTKTN7e_55QRwE&e= 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

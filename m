Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0178C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 09:39:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5846120B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 09:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5846120B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S8hoTFDL7KC6eHFp1d2pN5vAvnk9V4NsdcU5NlaFKJ0=; b=kdvx+yfIeJoa7HH5xmGrNNpdz
	fW6BW23T769kqQoKYrhdZ1XUxEbI8mS94+gkEsFJusNnQrSiEOr4p8WBs5jlAURa3UumBdDSH3Wv4
	DJ0fPOqfSxsVqc1IF8CzA7CMo/7cdzu4bLB6SFMPlN8pmnHzc+OxflGZdzIYws22HD0EDfZIx+ODo
	JFozEmiJB6kj4j9iv+2Drn7DAHZk4bbQejt+R5vhpWkTMBwkrQ3ApjmP4++oKhP9Vs4DHc4wh6jRA
	2nN9mxqF51E8qlIBiwom23jraU0XOHR7DY0uP4KQ4wFC6oHf7u1ycGT2MI+H2pi7hkC2R+YjaSSq6
	veDnhzKsQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVt1v-006JJS-6J; Mon, 12 Apr 2021 09:38:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVt1i-006JGH-8M
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 09:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:In-Reply-To:
 MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xXr3pXqFAodEd1ApbblBkpg/YRKqvxcKFnt+Kbq4+wQ=; b=1XfUt/QOZS5jSCkVc8WjiYODHZ
 qliluJihZ6NtRbbDUkSKSIlaqc4Y834a4N15TM01886TYnlGQ6EptDFRWHWYGGeq2kL7VkI5/kNHE
 E+WD3GnS02DPqCtA+jM3KGUwdL42jS8bcKoxvRYSsuZCbOuELCNcpPlwF2WtArTMt+DBBUaP9FPH1
 6U7HvK3q9tlgJo9896KWGQBxRxxSRfE1zZwMRi0+3DoKRQsdM6oqfzHRauWO42EBtgACMvsLz7SH+
 CLgcnydynQHRNqeDpQgKG/RPgqqk0m1SDWQw1XRVFiQ2FEfOUSBVi+8CQGlbgIqjgk3DYsrSppbtW
 N9QnJ1Ow==;
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVt1e-0064ny-Sk
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 09:38:37 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210412093829epoutp017b25fa303d099a39e74a8ccdfb391cdd~1EsxIFple0331803318epoutp01U
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 09:38:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210412093829epoutp017b25fa303d099a39e74a8ccdfb391cdd~1EsxIFple0331803318epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1618220309;
 bh=xXr3pXqFAodEd1ApbblBkpg/YRKqvxcKFnt+Kbq4+wQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=F3zakRgdAkdrSpRsbRpE0u/I9MKgD/B/m2JDCcG0lBfy9YqnbAVq5avg29DY+jguD
 XHkkP4lsov7Zq18oaqanG/+Q7osDmyi8FgiEevaUT+jqmpsQyQXpNYiY6NiqzZI7GZ
 mv6x1nmAFy5ObHprIdFD3cQFIygAGxK75fcr+Tf0=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210412093829epcas5p3120b64d391c32f3d5c1819a5a131453f~1Eswx072Y1769217692epcas5p3c;
 Mon, 12 Apr 2021 09:38:29 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DB.F2.39068.51514706; Mon, 12 Apr 2021 18:38:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210412085650epcas5p3d1f871bc995a7f489f19a37612a43c77~1EIZVG_wH0979709797epcas5p3S;
 Mon, 12 Apr 2021 08:56:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210412085650epsmtrp2eae44db33353c72e5c85ef3c7ee32bd7~1EIZUVw4I0414204142epsmtrp2O;
 Mon, 12 Apr 2021 08:56:50 +0000 (GMT)
X-AuditID: b6c32a4a-60fff7000000989c-70-607415150b1b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 00.E3.08745.25B04706; Mon, 12 Apr 2021 17:56:50 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20210412085648epsmtip14d948ca0846a8b6684742352d3447ab8~1EIXuyhCV1893318933epsmtip1h;
 Mon, 12 Apr 2021 08:56:48 +0000 (GMT)
Date: Mon, 12 Apr 2021 14:26:09 +0530
From: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org,
 tasleson@redhat.com, tbzatek@redhat.com, prakash.v@samsung.com,
 d.palani@samsung.com, javier.gonz@samsung.com, k.jensen@samsung.com,
 mohit.kap@samsung.com, krish.reddy@samsung.com
Subject: Re: libnvme questions
Message-ID: <20210412085609.GA8179@test-zns>
MIME-Version: 1.0
In-Reply-To: <20210408164645.GA3667@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7bCmlq6oaEmCwb8l/Bazbr9msXj79QGb
 xeM7n9ktTjbuYbWYdOgao8XCjcuYLOYve8puseaFssWVKYuYLS7eu8luMe/PR3YHbo9NqzrZ
 PDYvqfd4v+8qm0ffllWMHu0HupkCWKO4bFJSczLLUov07RK4Mj5/38VW8IW/4tuXy+wNjI+4
 uhg5OSQETCT+Xr/I1sXIxSEksJtR4tKhG+wQzidGidNnLzGDVAkJfGaU2LMyHK6j6xUjRNEu
 RokF1ydBtT9jlJh26y9YB4uAqsS8WdeARnFwsAkYSXxvtQUJiwgoS9ydP5MVpJ5Z4CejxLIX
 19hAEsICchJ3N15gBLF5BXQkmpdMYoewBSVOznzCAmJzCjhLHLj4gwnEFgUadGDbcSaQQRIC
 MzkkFn77xgZxnovEowM3mCBsYYlXx7ewQ9hSEp/f7WWDaGhmlNj35QoLhDOBUWLK/HdQHfYS
 F/f8BbOZBTIkjj78zQgRl5WYemodVJxPovf3E6h6Xokd82BsVYnHFw5CXSEtMXvlJ6i4h8Tm
 1s/QMHrAJLGjZRHzBEb5WUjem4VkH4RtJdH5oYl1FjD4mIFmLf/HAWFqSqzfpb+AkXUVo2Rq
 QXFuemqxaYFRXmq5XnFibnFpXrpecn7uJkZw0tLy2sH48MEHvUOMTByMhxglOJiVRHiTKosT
 hHhTEiurUovy44tKc1KLDzFKc7AoifPuMHgQLySQnliSmp2aWpBaBJNl4uCUamDyfp0vupzp
 8sfDwU5qFz8+ESueszgk46rC5elrXt1+1jzHyn4hq7vc3D6+dTsW7dttHJoyO0d3i7e91lSN
 gHnhggnP756drLvmk5yjaEiQZf8KJ32z5vZ58/SvdDRVXtadm3eXuePjlU2Jfnm8K3pOfNqU
 5DOtP+SCeNL2aX3rmIsNpIpz+zZlejL9an+4oZpXfZbTY4ns53OD/37yO5mo7ebt+6dl9VHJ
 559+dBjpHBFcdEVkY4J9+MT7f78yx/VfZDp76FPnuwJJ7ZQnyRMvnHvxNewUO+9B37gDO2b9
 Zj77ftveX7c0hL4qzeSc3vlrWd3pTu3zew7PvaPEpvau6pv2FrNXzqrJT2q07jknK7EUZyQa
 ajEXFScCABgTvM7JAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnG4Qd0mCQeMSdotZt1+zWLz9+oDN
 4vGdz+wWJxv3sFpMOnSN0WLhxmVMFvOXPWW3WPNC2eLKlEXMFhfv3WS3mPfnI7sDt8emVZ1s
 HpuX1Hu833eVzaNvyypGj/YD3UwBrFFcNimpOZllqUX6dglcGQ2/bzAXLOOtWLLiHnMD4zqO
 LkZODgkBE4m/Xa8Yuxi5OIQEdjBKTHoxjwkiIS2x7+F1FghbWGLlv+fsEEVPGCU273zMCpJg
 EVCVmDfrGlCCg4NNwEjie6stSFhEQFni7vyZrCD1zAI/GSWWvbjGBpIQFpCTuLvxAiOIzSug
 I9G8ZBLU0AdMEi/vTmKDSAhKnJz5BGwzs4CZxLzND5lBFjADXbT8H9jVnALOEgcu/gA7VBRo
 2YFtx5kmMArOQtI9C0n3LITuBYzMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgmNF
 S2sH455VH/QOMTJxMB5ilOBgVhLhTaosThDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
 QHpiSWp2ampBahFMlomDU6qBSV+oaNf1k/ctPJ/LfooJK2ox+/02LXb34vfhkbXbFn3e0LN8
 e42H0qulUc/jvtoz2Gv3b9uxJCPdnKPy18X1ymarf6gctbM7L36QzcGF9efbA5IcUrLBUx6t
 MZzWZu9iGbjB4Ym92JwThy0152yPZPY/mCvfLB2y8P3iS9UXdvzL+Lb07ZvfpWrfXWzeqnx3
 +vL7k2vs0y+dmuq/ZNcuqpnb8lygtvSgvwQX3/Setfop04X6j9z5wcm3wihix5xrayX5jS2m
 93BpnXZx+sHbedd630+ul2zK7xxusx9MuXBDTUAno/B1vsysUIOtAu4LtTbIccpXqYXPuckv
 +FIjLfHyilVWE9ynNp3c5CvgqsRSnJFoqMVcVJwIAP/10HAEAwAA
X-CMS-MailID: 20210412085650epcas5p3d1f871bc995a7f489f19a37612a43c77
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----9CMuN9iDGEr79_UZ9KBz13DO6G9EfLQokAV6LaKoO8yZ8pVk=_73099_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210407123854epcas5p48217db953741a57d651a8a8bf240ee23
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
 <20210407233706.GB32309@redsun51.ssa.fujisawa.hgst.com>
 <20210408075126.GC12847@test-zns>
 <20210408164645.GA3667@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_023835_433715_858CF749 
X-CRM114-Status: GOOD (  21.37  )
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

------9CMuN9iDGEr79_UZ9KBz13DO6G9EfLQokAV6LaKoO8yZ8pVk=_73099_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Apr 09, 2021 at 01:46:45AM +0900, Keith Busch wrote:
>On Thu, Apr 08, 2021 at 01:21:26PM +0530, Padmakar Kalghatgi wrote:
>> On Thu, Apr 08, 2021 at 08:37:06AM +0900, Keith Busch wrote:
>> > On Wed, Apr 07, 2021 at 06:08:06PM +0530, Padmakar Kalghatgi wrote:
>> > > Since most of the companies who develop SSDs, use MI(sideband) channel, we think this will be a good enhancement to the existing functionality which the nvme-cli provides.
>> >
>> > Can we even use this from a Linux host? I thought the sideband channel
>> > was typically connected to the baseboard management controller.
>> >
>> Yes, this can be used from Linux host by having additional hardwares, like TotalPhase's aardvark, Corelis etc, which are connected to the NVMe device.
>
>That doesn't sound something for end users, but okay. Can we see the
>nvme-mi bus driver before considering tools and emulation?
>
Please find the below block diagram for the MI communication on the
linux host. The nvme-bus driver is  nothing but the USB driver of the 
hardware which is provided by the vendor.

 ____________________                                                   
|                    |                                                  
|                    |                                                  
|      NVMe-CLI      |             _____________           ____________ 
|     (MI Plugin)    |     USB    |  Aardvark   |  SMBus  |            |
|                    |============|  \Corelis   |=========| NVMe Device|
|                    |            |_____________|         |____________|
|____________________|                                                                     


------9CMuN9iDGEr79_UZ9KBz13DO6G9EfLQokAV6LaKoO8yZ8pVk=_73099_
Content-Type: text/plain; charset="utf-8"


------9CMuN9iDGEr79_UZ9KBz13DO6G9EfLQokAV6LaKoO8yZ8pVk=_73099_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

------9CMuN9iDGEr79_UZ9KBz13DO6G9EfLQokAV6LaKoO8yZ8pVk=_73099_--


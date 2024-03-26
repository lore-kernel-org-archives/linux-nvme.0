Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D2CC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jvHeX6C8SXBIjytRxIs75BdlrWPmrI7kR9RyY4yAdu4=; b=SEwajs6qRw/moAV/S8pVdX9rQo
	6bOhL7l5pmlKnZC/wdCxUUNyr+chQrMu4sk4qpJTApzPQfGcPQ15/9Ka6CEic+lu6Pf42kyAYOPS7
	T0yWFNFWUrEA9vhYiok5J5lW2dBDk67PcaWjDbjBdfUcV4Fx/SexwZ5DLOFo2pqL4ZkKe/2tOYSTM
	/dAf2RIj6iG0fgiCaUanxK4TA6xbLOkeC1Yu2v1KMzXmShBpM4nhf1BirbrCEuQ3Htq4X3nTp5uHr
	SZNGEMS04qWI1yb0Oz3QuEyHFRvgqciUgN3F380CJLbXWBbytSQMIv8dB7iXtqvoFCFI8zFrLKnEb
	cyOeEcVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp7OE-00000004nzc-1D3c;
	Tue, 26 Mar 2024 14:02:58 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp7O5-00000004nv9-1I67
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 14:02:56 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240326140242epoutp027864ad7dda8643c5550d467d284b1e13~AVWfIGmAB3100731007epoutp02a
	for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 14:02:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240326140242epoutp027864ad7dda8643c5550d467d284b1e13~AVWfIGmAB3100731007epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711461762;
	bh=jvHeX6C8SXBIjytRxIs75BdlrWPmrI7kR9RyY4yAdu4=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=qiWJ2MbTfoKL746IpaEyZcW92l3e7gNyQ++WjJhEfTDIvjzmgnA2crp701ZYTR+GG
	 bPLBP4fVdfuGITZbVUxzY0Rwp2Xdp0slCNYelnoMfjgURQJ1B0JM/umA/ZWpz7e9el
	 Gj1dlaIsSy/AC8eHTJBEo10G2n8DWUdmR8tz9v4s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240326140242epcas5p10f04c0974e91947d1c1444d12c2ff023~AVWe5pahM1488814888epcas5p1X;
	Tue, 26 Mar 2024 14:02:42 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4V3s291mCmz4x9Ps; Tue, 26 Mar
	2024 14:02:41 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.D6.08600.185D2066; Tue, 26 Mar 2024 23:02:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240326140240epcas5p10d997a58af322290df2f86e5f1dfb567~AVWdOlHtt1751417514epcas5p1K;
	Tue, 26 Mar 2024 14:02:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240326140240epsmtrp1e5490353cacbd1750d480b0625c14585~AVWdOHYqF3202032020epsmtrp17;
	Tue, 26 Mar 2024 14:02:40 +0000 (GMT)
X-AuditID: b6c32a44-921fa70000002198-fe-6602d581a505
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4D.A0.08924.085D2066; Tue, 26 Mar 2024 23:02:40 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240326140239epsmtip179ee3820b95817acd4a73e24b5a14c91~AVWcrUD9I2249622496epsmtip1G;
	Tue, 26 Mar 2024 14:02:39 +0000 (GMT)
Message-ID: <3efcf01d-e83a-e5ad-d335-7516b857eef0@samsung.com>
Date: Tue, 26 Mar 2024 19:32:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] nvme: initialize identify ns data to NULL
Content-Language: en-US
To: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <a92a1493-29ae-4f89-b17b-54d03ec0becc@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmlm7jVaY0g/ab3BarT/SzWcxf9pTd
	gclj56y77B6bl9QHMEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
	Krn4BOi6ZeYAjVdSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr
	5aWWWBkaGBiZAhUmZGc07dvOXnCJtaLx1DP2BsajLF2MnBwSAiYSpw/dBrK5OIQEdjNKnF02
	Bcr5xChx/spORgjnG6PE7r334VoWvDgDldjLKHGw8wUThPOWUaK1aScTSBWvgJ3ExGWT2UBs
	FgFViXXtrxkh4oISJ2c+AZskKpAs8bPrAFANB4cwUP2jhnSQMLOAuMStJ/PBxogIeEncvbQR
	rIRNQFPiwuRSkDCngK3EtpfnWCHK5SW2v53DDHKChMAhdoll83ewQRzqIrH/zwpWCFtY4tXx
	LewQtpTEy/42KDtZ4tLMc0wQdonE4z0HoWx7idZT/cwge5mB9q7fpQ+xi0+i9/cTJpCwhACv
	REebEES1osS9SU+hNolLPJyxBMr2kLjw6hozJHS+AAO05QXTBEb5WUgBMQvJx7OQvDMLYfMC
	RpZVjJKpBcW56anJpgWGeanl8DhOzs/dxAhOcFouOxhvzP+nd4iRiYPxEKMEB7OSCG/LF4Y0
	Id6UxMqq1KL8+KLSnNTiQ4ymwBiZyCwlmpwPTLF5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJ
	pCeWpGanphakFsH0MXFwSjUw+dVF+gatrEtw+MNzOOti6CtG9dVSrklsVw9r7bdX3cjEyPTH
	pTDJSsalSumm0raTjUrcj7at2Lvk4b17UZyfapRZWgs0eMq1F3zOn5y++dMh78t6D48nRL2N
	anv83WJNyY8sYWaPM5IPJe/ke2dvXdUVZrtka52VT+2dj419G1X9TzCocqx9mcnucEyn5xGn
	dJBumn9jEsvMd34zSlt84yo5T6mIv1RUuF9nV3efj213rd79Z9cmfTcXftXxonp9aJTl7pjH
	+w4ktXj9v3Lv/jahwxbnW/kmyLqF+N5fPm3O6dv8rHqeF1IespaWbKm6oXuLa31i3+lQz2O/
	5O8FX426eyxAuIn/tv/hbdJKLMUZiYZazEXFiQBAnMfO+QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnG7DVaY0g/eNcharT/SzWcxf9pTd
	gclj56y77B6bl9QHMEVx2aSk5mSWpRbp2yVwZTTt285ecIm1ovHUM/YGxqMsXYycHBICJhIL
	Xpxh7GLk4hAS2M0oseDDTCaIhLhE87Uf7BC2sMTKf8/ZIYpeM0q8v/karJtXwE5i4rLJbCA2
	i4CqxLr214wQcUGJkzOfgNWICiRLvPwzEaiZg0MYqP5RQzpImBlo/q0n88F2iQh4Sdy9tJEN
	Yv4XRomTv54zgdSzCWhKXJhcClLDKWArse3lOVaIXjOJrq1djBC2vMT2t3OYJzAKzkKyeRaS
	FbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwMGtp7mDcvuqD3iFG
	Jg7GQ4wSHMxKIrwtXxjShHhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgt
	gskycXBKNTB1x25akj9Z2vjtUvdU6338r2z2sFovXaT6g4Xvdke+oONui3tx/0VZHjJbL7pq
	91xhbtm8ydOvvxLv8/BM2SRl3Cuc7bt7TZPluf1F/joNl//d3SHz7eIelq3/7ye67H4jzuoW
	8lY/jU1t34vIX7FqmzhOv7Mr8hDVYZ64+HdFe8WSVdOqbx/+t69f6c4Gsevq10Qss3mYFpj4
	vToYHX0r+YjMB8bGuU+Ngr0uLn17adfx35l3lrWU/jtwksWef1+RxM3MVV+3cK+KLLyfoVLw
	NP1RVPy2/A067nM3aCY/ff6D6+d+t7N7Fi265B4e5ivRZPZmwoH6M2rXJC1Fl2nx2m/O21d3
	vmH9xSXxep/SlViKMxINtZiLihMBz3WvatUCAAA=
X-CMS-MailID: 20240326140240epcas5p10d997a58af322290df2f86e5f1dfb567
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240325154544epcas5p4acf7f376241637872a433314489586fa
References: <CGME20240325154544epcas5p4acf7f376241637872a433314489586fa@epcas5p4.samsung.com>
	<20240325154503.11510-1-ikegami.t@gmail.com>
	<dee7f8a3-34af-e12c-ac7d-721960fc0744@samsung.com>
	<a92a1493-29ae-4f89-b17b-54d03ec0becc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_070250_229079_36B8A12B 
X-CRM114-Status: GOOD (  12.91  )
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

On 3/26/2024 7:08 PM, Tokunori Ikegami wrote:
> 
> On 2024/03/26 17:50, Kanchan Joshi wrote:
>> On 3/25/2024 9:15 PM, Tokunori Ikegami wrote:
>>> Currently nvme_identify_ns() sets the data to NULL if failed.
>>> Also the data is not freed if the function returned failure.
>> If it fails, it frees the allocated memory too.
>> So I don't see how the patch helps.
> Yes I think this just helps if in future thenvme_identify_ns() function 
> or the caller functions changed the implementation.

Not a compelling case of future convenience, IMHO.

In the current scheme of things, the assignment to NULL in all the 
callers of nvme_identify_ns (there are few more than what this patch 
covered) is redundant.


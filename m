Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBFDC6FA82
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MkB767neFMUV5ApfT4B/wKKXyVOpkyniO4NvuSC66e0=; b=S+nPxP6g9AgO/vvjEBawLig0Im
	bkfuGeokFV5yhJxSZb4P8bXg9ovuzN5097yLkk7QsQZSAiO3U+Ug1zC1tUxqnwdBjD2PZz1IiIZ6c
	HZ5FfvPmfkKQ+dT5toq0vxIIhEUu8iU7sHpLFE6w/5jR1E3mvlNDI8w81xM1B+5DmI1JC0ycZvPmi
	qT56qJOVrxa9uSWZvNoahoYk19i9Td+CH0nkfoFYZqLS7Cwf0CybuWyKhO2/LqQSWW4BPF7kRcT58
	iORTDpkPABZeGSg5AXMQ6KrHhF4ywqRUx/eHmhgvVogK9NiSvhv9mt/+9YBxgIUpsttiJpquT8rnD
	C4ZUTq1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWdxK-00GIaC-0u; Fri, 09 Sep 2022 13:22:02 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWdx8-00GIVO-Jf
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 13:22:00 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220909132144epoutp01b0101fed1b3c568f733aa57788814a1f~TM9thgkzo2305923059epoutp01S
	for <linux-nvme@lists.infradead.org>; Fri,  9 Sep 2022 13:21:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220909132144epoutp01b0101fed1b3c568f733aa57788814a1f~TM9thgkzo2305923059epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662729704;
	bh=MkB767neFMUV5ApfT4B/wKKXyVOpkyniO4NvuSC66e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZL/qxP45EZ80eBUfsykWG3Mwi03p05Pv3zZ+cM4nSQdyW6p7STB0LL5WonzlD/zo
	 dAG+Uvv6xSjsiZSp3KkrvuFlmTD0IX2ej1DBA637t2LBvrNMZjXA3cCuTquCNTsjzw
	 YRzg9v396YyWGWaCnDWZ5Wd5+uH1tOeXtk32+z28=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220909132143epcas5p2223731bdbdb9f3ede29e04646f2069db~TM9sfjSkK0677206772epcas5p2E;
	Fri,  9 Sep 2022 13:21:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MPGq86r0lz4x9Pp; Fri,  9 Sep
	2022 13:21:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.53.53458.4ED3B136; Fri,  9 Sep 2022 22:21:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220909132140epcas5p293e45f71b884cdb34d988c0fe056c357~TM9pQk5_p1869918699epcas5p2P;
	Fri,  9 Sep 2022 13:21:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220909132140epsmtrp27304b16f93bb4ba2d40bcb815f303939~TM9pP6e_e1402014020epsmtrp2I;
	Fri,  9 Sep 2022 13:21:40 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-30-631b3de47434
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.18.18644.4ED3B136; Fri,  9 Sep 2022 22:21:40 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220909132139epsmtip28fe5970ae9cd11350286f2274213bf55~TM9ocAgCX0640306403epsmtip2h;
	Fri,  9 Sep 2022 13:21:39 +0000 (GMT)
Date: Fri, 9 Sep 2022 18:41:55 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Keith
	Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: restrict management ioctls to admin
Message-ID: <20220909131155.GA21234@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220908213517.3085323-1-kbusch@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTS/eJrXSywf4zRhYrVx9lsli7l91i
	0qFrjBbzlz1lt1j3+j2LA6vHxOZ37B7n721k8di0qpPNY/OSeo/dNxvYAlijsm0yUhNTUosU
	UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
	9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Izvs5/wF6wjbvi
	YP8jpgbGe5xdjJwcEgImEhMmrWHsYuTiEBLYzSixf8JvKOcTo0TTu+ssEM5nRonX83cwwbSc
	3n8LKrGLUWLq5nlQzjNGiQVfzrGDVLEIqEjc3rOJuYuRg4NNQFPiwuRSkLCIgLzE/Ae9bCA2
	s0CyxNfTR8DKhQXsJF5NecYMYvMK6EpMnXCOCcIWlDg58wkLiM0pYCrxuPUamC0qoCxxYNtx
	JpC9EgJv2SUu3rvIDHGdi8S1xzvYIGxhiVfHt7BD2FISn9/thYonS1yaeQ7qmxKJx3sOQtn2
	Eq2n+pkhjsuQ2Lb5F5TNJ9H7+wkTyC8SArwSHW1CEOWKEvcmPWWFsMUlHs5YAmV7SOzpb2WF
	hEkHo8TFN7NYJjDKzULyzywkKyBsK4nOD02ss4BWMAtISyz/xwFhakqs36W/gJF1FaNkakFx
	bnpqsWmBUV5qOTySk/NzNzGCk6OW1w7Ghw8+6B1iZOJgPMQowcGsJMLLYiidLMSbklhZlVqU
	H19UmpNafIjRFBg9E5mlRJPzgek5ryTe0MTSwMTMzMzE0tjMUEmcd4o2Y7KQQHpiSWp2ampB
	ahFMHxMHp1QDU9nGNU+lmY05GLtPO4W3GF7p0lfaPV0kltMy69nrzVUyR3O/BU6d8uNST4LV
	+Sd9LCs5pi2W2xD/Mvb40X1fft+L59n4YbnSz6NNs3+cc94h9HjpDCWV/vMvr8nW6oud2nvd
	8Y1BC098T4vcdqGUysmODIWmbLNPifTzWR9Y4c72WtPG8Np1xV1BGnYbqnq7Q19FTT4u+f2H
	+fMfUSsmyawTyPvGK5+x7aLMVaPvXbq6huEiIR41+rd+2Hj8aRMINT4TY53bMPVdx4ePXAVF
	F7X5PY9eMamf87faf4lc/q3HiWe0d3euZT+3ZC2Pw7vkkE3KLp+EhSxSzhT9WHOXg0HZUnqb
	sSdX/8LvZ9NllFiKMxINtZiLihMBlkenZBcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvO4TW+lkgwmz2SxWrj7KZLF2L7vF
	pEPXGC3mL3vKbrHu9XsWB1aPic3v2D3O39vI4rFpVSebx+Yl9R67bzawBbBGcdmkpOZklqUW
	6dslcGV8XbGJseAFR0XL0pmsDYyr2LsYOTkkBEwkTu+/xdLFyMUhJLCDUWLX9KNMEAlxieZr
	P6CKhCVW/nvODlH0hFHiffMqsCIWARWJ23s2MXcxcnCwCWhKXJhcChIWEZCXmP+glw3EZhZI
	lvjd3MoKYgsL2Em8mvKMGcTmFdCVmDrhHBPEzA5GiX3n/7BBJAQlTs58wgLRbCYxb/NDsPnM
	AtISy/9xgIQ5BUwlHrdeAysRFVCWOLDtONMERsFZSLpnIemehdC9gJF5FaNkakFxbnpusWGB
	UV5quV5xYm5xaV66XnJ+7iZGcLBrae1g3LPqg94hRiYOxkOMEhzMSiK8LIbSyUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwOfJefpVqpeijvVrQ58bc
	vtuvbxUu6w2a+c6N9a5b1+mOGq6bz5c3cU3+/zxvYtSFKT9eau6JYXiwnmfKbrOtCo/vJste
	VbhbtGL7q30r3y3a1x5eUC0WMKOnOS2kdZHVIraqOI/pb25ld4s7H1K7fj2aM6tc7Tifufud
	otA3E25MWSNQ/C1gEe8ye4k9LatTjOZtKAucurx7I4fZ5WfO4q9ufZN95hwqovPAyDWo6pOV
	TjHzFs5KpokbvBxZ/395fEzWeGFQWNOWb1cW5bRkStzfeos1Lcl054dZd1/dfWz5+C2L7DSH
	owcvRth6/ZiVseRArNN8Z0/TcCepq4Kl75N2W3/jv+RgbMPtmx31RomlOCPRUIu5qDgRACBz
	HMLlAgAA
X-CMS-MailID: 20220909132140epcas5p293e45f71b884cdb34d988c0fe056c357
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----3GC0G0c67CHFz-pUzO9qV37oeXJmKwYP9xQRy1YHFCjbzJ45=_f58bb_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220908214000epcas5p1a9bf63bc35632888248e094daacbcbde
References: <CGME20220908214000epcas5p1a9bf63bc35632888248e094daacbcbde@epcas5p1.samsung.com>
	<20220908213517.3085323-1-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_062155_944096_CC5D6987 
X-CRM114-Status: GOOD (  16.41  )
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

------3GC0G0c67CHFz-pUzO9qV37oeXJmKwYP9xQRy1YHFCjbzJ45=_f58bb_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Sep 08, 2022 at 02:35:17PM -0700, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>The passthrough commands already have this restriction, but the other
>operations do not. Require the same capabilities for all users as all of
>these operations can be disruptive.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
> drivers/nvme/host/ioctl.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>index 27614bee7380..d23978e993c6 100644
>--- a/drivers/nvme/host/ioctl.c
>+++ b/drivers/nvme/host/ioctl.c
>@@ -749,6 +749,9 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
> 	struct nvme_ctrl *ctrl = file->private_data;
> 	void __user *argp = (void __user *)arg;
>
>+	if (!capable(CAP_SYS_ADMIN))
>+		return -EACCES;
>+

I too came across this and wondered why this check is not present here.

Acked-by: Kanchan Joshi <joshi.k@samsung.com>

It's a different matter that I was looking at increasing the access
granularity (something like scsi whitelisting). Hope to have
conversations on a RFC soon.
>
>

------3GC0G0c67CHFz-pUzO9qV37oeXJmKwYP9xQRy1YHFCjbzJ45=_f58bb_
Content-Type: text/plain; charset="utf-8"


------3GC0G0c67CHFz-pUzO9qV37oeXJmKwYP9xQRy1YHFCjbzJ45=_f58bb_--


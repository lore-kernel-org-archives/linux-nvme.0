Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E58C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M5lIh+0g4RVNuSl4I2ihfuO8hSMYO8QcXEzge+qBXwk=; b=yt3Dmns9MS7Zq+MoNecH+lXaWJ
	2DPELlc4mURBI4dunoHTo8jhmEFQTYPIeYO8HrglxgpRcQfeDSdDpIT9RsozVAMdqLXbg5aL7m0AW
	4MIzfZCMBQJDI4XN26r71Kohy9zbqHRq11AJ2Ir1e503u8B1ECtTQP4vr6awovkE1lO6Crj64UQPm
	MK7hvEjmSv1Xa6R0mK/MGNDWKRrdZmDSu39dURUrJ6eXPQs08dvZyC09q25neKdadSSLGi+5NspOh
	8gEb7XUx+Ae8RhccqdEwLKkMJF1swL5E85t0XzEfi17BhoGHe0oFYWuOzAOXbZLUC2UtImj5WpF0k
	v5biM+rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOvXf-00000009S7v-2CZc;
	Wed, 03 Jul 2024 08:40:43 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOvXa-00000009S6n-30pb
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 08:40:42 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240703084030epoutp010e90c09e475942167f7371fa7dc6cc19~ep0bCo5Io0169701697epoutp01E
	for <linux-nvme@lists.infradead.org>; Wed,  3 Jul 2024 08:40:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240703084030epoutp010e90c09e475942167f7371fa7dc6cc19~ep0bCo5Io0169701697epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719996030;
	bh=M5lIh+0g4RVNuSl4I2ihfuO8hSMYO8QcXEzge+qBXwk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sBU8icKY7nsnaCYVDuNO0OjJtOk/v17z/wLrsBJHxf8a74EKZQtD6c+d9/ZYFo1/U
	 S01PHhQ4IxTBu7HX5egQXSrMFUHX7v7zGqtcxEclPnd909a6HPf1KZ/ZhgU3JNxrly
	 Z6tAZjv0GED37CTgLKMJobVnK8KG1VbDziIEp9wQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240703084029epcas5p490c1cc88930cb4a4748d4d68de91263a~ep0awQ0Xs1634316343epcas5p4A;
	Wed,  3 Jul 2024 08:40:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WDYBh0HV3z4x9Q8; Wed,  3 Jul
	2024 08:40:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.99.06857.B7E05866; Wed,  3 Jul 2024 17:40:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240703084027epcas5p4d3ee9d82f350c9e49c2d619a27e1e253~ep0Ymkqyk0790907909epcas5p4l;
	Wed,  3 Jul 2024 08:40:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240703084027epsmtrp2c04b4274ad7996ba0d24342fab7a01cb~ep0YluweL0035000350epsmtrp2d;
	Wed,  3 Jul 2024 08:40:27 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-c1-66850e7b22aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	72.89.07412.B7E05866; Wed,  3 Jul 2024 17:40:27 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240703084025epsmtip13d228727cf5d426e378fc9a2e867beeb~ep0XB8Nt22594125941epsmtip11;
	Wed,  3 Jul 2024 08:40:25 +0000 (GMT)
Message-ID: <f79cc36c-cd03-bb5e-2eae-3612176a474e@samsung.com>
Date: Wed, 3 Jul 2024 14:10:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v3] nvme: enable FDP support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, bvanassche@acm.org,
	javier.gonz@samsung.com, gost.dev@samsung.com, Hui Qi
	<hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240702113954.GA15325@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmpm41X2uaQccDK4vVd/vZLKZ9+Mls
	cfPATiaLlauPMlnsXLaW3eLxnc/sFpMOXWO0mL/sKbvF8uP/mCy2/Z7PbLHu9XsWB26Py1e8
	Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5vHx6S0Wj74tqxgDOKKybTJSE1NSixRS85LzUzLz
	0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
	pCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGe0zHjFVHCFveLkBvcGxols
	XYycHBICJhITNm5i7WLk4hAS2M0osaT3HzuE84lRYvX8PWBVQgLfGCXeLrOG6Vj4/jYjRNFe
	RonmTdegOt4ySnx8uZUJpIpXwE7iwrftLCA2i4CKxNm+CywQcUGJkzOfgNmiAskSP7sOgG0Q
	FjCQuHzgOzOIzSwgLnHryXywOSICShJPX50F28Ys0MwkMevBFqAiDg42AU2JC5NLQWo4BXQk
	7l1rZ4folZfY/nYOM0i9hMAODonJR/azQ5ztIrH90htmCFtY4tXxLVBxKYnP7/ZCAyNb4sGj
	BywQdo3Ejs19rBC2vUTDnxusIHuZgfau36UPsYtPovf3EyaQsIQAr0RHmxBEtaLEvUlPoTrF
	JR7OWAJle0gc2fsDGnDrGSX+HtzINoFRYRZSsMxC8v4sJO/MQti8gJFlFaNkakFxbnpqsWmB
	cV5qOTy+k/NzNzGCU7GW9w7GRw8+6B1iZOJgPMQowcGsJMIr9b45TYg3JbGyKrUoP76oNCe1
	+BCjKTB+JjJLiSbnA7NBXkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwc
	nFINTGdSrSdf1Pz0/XfC2Q7ttS/mrOV9ITN9vmXM99d8SeGH1BdetAgxPmTLqNvSbych8eIk
	w7f9AVe61+4Rn90zZ4GwJrP4o087N0x3iQlN+Nq88aXLjSOHd00LZlB1f7VyqqvepsZFqsfr
	Pl15UJdnWSckJOOvuoNt9f25D+9c+qu4aWHMhJirHzd+j4zdOXex1uXQa52FwkUrimy210zh
	iLycvM2Lc7VrmTpDHZfiE8+HZ9/+e8n43yi97eS0y91cH3ZOjfG7+1InrG/S7NctspbhsiV2
	y5rZV79wWT5p29FrZafreJ9/ud4cmMH2vJNlcfGBZY+/e3wyPv7yL98+GZ+shUc6O7982lwq
	1SERfrBRiaU4I9FQi7moOBEAPSB1e04EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnG41X2uaQc9DUYvVd/vZLKZ9+Mls
	cfPATiaLlauPMlnsXLaW3eLxnc/sFpMOXWO0mL/sKbvF8uP/mCy2/Z7PbLHu9XsWB26Py1e8
	Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5vHx6S0Wj74tqxgDOKK4bFJSczLLUov07RK4Mlpm
	vGIquMJecXKDewPjRLYuRk4OCQETiYXvbzN2MXJxCAnsZpTonv6QFSIhLtF87Qc7hC0ssfLf
	c3aIoteMEucub2MCSfAK2Elc+LadBcRmEVCRONt3gQUiLihxcuYTMFtUIFni5Z+JYIOEBQwk
	Lh/4zgxiMwMtuPVkPtgcEQEliaevzjJCxJuZJBaf0YJYtpZRYtal/0AXcXCwCWhKXJhcClLD
	KaAjce9aOztEvZlE19YuqF55ie1v5zBPYBSaheSMWUjWzULSMgtJywJGllWMkqkFxbnpucmG
	BYZ5qeV6xYm5xaV56XrJ+bmbGMFxp6Wxg/He/H96hxiZOBgPMUpwMCuJ8Eq9b04T4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1Oqgen2lpU5jUxKWxPj7LIr
	+1zE1ecIBRpYM4bvcGWVuOurnrwx0/xNwoprPzffuH9F59aph5Vfmr1PpDdmFf5bOqNcfEG6
	0YfXM7xce7hS85mctp3TcPqWuerA6Z9l8vuMn0j+8ddMP/jeUF30ofzzCnfLMpEdj8ObrIyn
	V02+o1P+Ut2+T+y3sa3ruv/86/+ffOmeZCOZHyja/0ww6aLQZbHqD6f2XI0LbvHf8UjB2bCZ
	2fiSR2D0PHtzZ5ZLIZ1xb2of6Ofk19bonXScZnbOqt45zHv+1RurjI0MFaP3rDhRtfYKu4Z6
	z2/VyMYftW/cE/Tev79+i8cvzzL82SvPff+c/n+wdY/P/ZwtLD9RiaU4I9FQi7moOBEASyuA
	1SoDAAA=
X-CMS-MailID: 20240703084027epcas5p4d3ee9d82f350c9e49c2d619a27e1e253
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702103348epcas5p1015eafbddf4795558843cd74b0453b12
References: <CGME20240702103348epcas5p1015eafbddf4795558843cd74b0453b12@epcas5p1.samsung.com>
	<20240702102619.164170-1-joshi.k@samsung.com>
	<20240702113954.GA15325@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_014041_030811_902371AC 
X-CRM114-Status: GOOD (  16.30  )
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

On 7/2/2024 5:09 PM, Christoph Hellwig wrote:
> Same NAK as before.  FDP was intentionally designed to not fit the
> clearly documented Linux needs.

That was not the design goal of FDP. It is ludicrous for any storage 
technology to have that as an intentional design choice.

> If you want support for Linux data
> temperature hints work with the NVMe technical working group to make
> it happen.

The value does not come from the temperature-sensitive names that we 
have in Linux. It rather comes from keeping the WAF low and from using 
Linux file-sytems. The write-hint interface, despite not being ideal, 
happens to be the only interface we got for the latter.

If/when anything different grows in the device-side, we can trivially 
change the plumbing this patch does.

People need support for what we have in current spec and more 
importantly in products. It's not a Meta/Samsung only thing. Many 
hypsercalers and enterprise customers need this.


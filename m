Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BDDC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 07:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bomq5uKbuRivd/0IS2b2qGsu/Aszcoj+7st7Up+vv/c=; b=hplZpye09z0OMjeJeyVMEPZ/cQ
	fvzt5F9qf/MQpqRLgO0s4QtKUzbj/X/hhXZZP4Sufarv51Y32tcjArm5EC2H0hyZAPFqlw48OGAhs
	QCodkOJTU+R4ynu2YAHSHER+0uTDD/rPHNqawirHb+U6JxhyM5mLICKthQ6/E7T4dxlvg9jkoWF9R
	oAN6ktB+Mb+OtY6yeoE4nZQcBaU3LQR8o5j2InfQ2wQoDyx9g3v9dTVh43m+YEgheOgRkm2blOiuV
	uNJPhfLArayDPq4rnDPDhzoRPWxTIacYiOI8ZxjKuo44d0z3tMUoGv0MNnTXRBZ3gTO6TdyVQf3g7
	kyNBgtvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovZGo-00BEPE-Mm; Thu, 17 Nov 2022 07:25:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovZGl-00BELu-9F
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 07:25:09 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221117072500epoutp011251100cace1057203d1ec2f023d49c2~oTm8L9TBk1337513375epoutp01S
	for <linux-nvme@lists.infradead.org>; Thu, 17 Nov 2022 07:25:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221117072500epoutp011251100cace1057203d1ec2f023d49c2~oTm8L9TBk1337513375epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668669900;
	bh=bomq5uKbuRivd/0IS2b2qGsu/Aszcoj+7st7Up+vv/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvVeHVYF4ax7zBhAWu1LAm9Sybm9KJpWvlPjynSVxiFPjjuwQwBtaqTkZVkrTWvBd
	 hdER/Giz5rn3TBPyTK+ravN7UvTNVauNIwdEOhcTfk3qTkuiWkl9vSPS037tKDPbrP
	 M0wAb417kK9qx/F0ricvz1tvBgQiwx+y9oKKIop0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20221117072500epcas5p274e5f5728189dfc02d57e25c8bf34671~oTm75rPef3234232342epcas5p2I;
	Thu, 17 Nov 2022 07:25:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4NCWdl1blHz4x9Q3; Thu, 17 Nov
	2022 07:24:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.5B.39477.9C1E5736; Thu, 17 Nov 2022 16:24:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221117072457epcas5p38a61bb22518e7c7eb7b32077621b948a~oTm5NKrE70971709717epcas5p33;
	Thu, 17 Nov 2022 07:24:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221117072457epsmtrp2b08b3c7f57446ba76b57ba015435039d~oTm5MWwaw0757107571epsmtrp2a;
	Thu, 17 Nov 2022 07:24:57 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-2f-6375e1c955d1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	3E.0F.18644.9C1E5736; Thu, 17 Nov 2022 16:24:57 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20221117072456epsmtip277c450105fb88454edb235f699fe5325~oTm38ZaMW2257622576epsmtip2g;
	Thu, 17 Nov 2022 07:24:56 +0000 (GMT)
Date: Thu, 17 Nov 2022 12:43:37 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: August Wikerfors <august@augustwikerfors.se>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens
	Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1
 256G and 512G
Message-ID: <20221117071337.GA29422@test-zns>
MIME-Version: 1.0
In-Reply-To: <e775398c-97bc-fc1d-a785-6d3c80bce9c6@augustwikerfors.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlu7Jh6XJBj8XGFocvXqWzeL/nmNs
	FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPnsmr2T0mNr9j9zh/byOLx6ZVnWwem5fU
	e+y+2cDm8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
	i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
	1BIrQwMDI1OgwoTsjMlvt7EXvOCo+PVuP2MD4yH2LkZODgkBE4lXz7ezgdhCArsZJe7fVOti
	5AKyPzFKXL3zggki8ZlR4sbFFJiGlXcmMkIU7WKUWNg+gw3CecYoce9VLzNIFYuAqkTDhEUs
	XYwcHGwCmhIXJpeChEUEDCT6//0Bq2cWOMQo8eDzMxaQhLBApMSjFdfBtvEK6EpsWHOLEcIW
	lDg58wlYDaeAm8T8wy/A5osKKEsc2HacCWSQhEAvh8Tejc+ZIc5zkdj0fxMrhC0s8er4Fqg/
	pSQ+v9vLBmEnS1yaeY4Jwi6ReLznIJRtL9F6qh9sDrNAhsTN23+gbD6J3t9PmECekRDgleho
	E4IoV5S4N+kp1CpxiYczlkDZHhIX7nWxQgLlDaPE9hNXmCcwys1C8s8sJCsgbCuJzg9NrLOA
	VjALSEss/8cBYWpKrN+lv4CRdRWjZGpBcW56arFpgVFeajk8jpPzczcxglOoltcOxocPPugd
	YmTiYASGLQezkghv7sXSZCHelMTKqtSi/Pii0pzU4kOMpsD4mcgsJZqcD0zieSXxhiaWBiZm
	ZmYmlsZmhkrivItnaCULCaQnlqRmp6YWpBbB9DFxcEo1MIV47LgRqb+XJbzots8i28Id8e19
	T+NPLg4MOrTYzbCc1VWMkT/iUsO/Qs6z/f0++RvXril6vtfovfTj9P0zDvedvGx9cLWAgXHN
	mbjrTxOtHgqvNhNcXuqcmKAW9WKysKmNz4Z1Hk3aUveOpGVvX/vcNb+G5+0Zk2mbPzz4r+Bz
	rvaU9qGrceL/De++5WVb9GH9rcrKi3MOvZi5PS/tvLZfxA8G7SCPLhkvYyGZB8nfPLnnBflM
	W1D58OVmFmu7a3lrezZVaTbfP785suBAi4hEpt2dDoa3DzZPSFaTlTm7dfUuY7N1j1cm/FAy
	na7Bk6JyLKIzXnzF471eN487OE60zt48MXiJ1Zn3YdbqxUosxRmJhlrMRcWJAGIpwbAqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO7Jh6XJBr/3y1gcvXqWzeL/nmNs
	FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPnsmr2T0mNr9j9zh/byOLx6ZVnWwem5fU
	e+y+2cDm8XmTXAB7FJdNSmpOZllqkb5dAlfG1Z3dTAWz2Coe9DQxNjD2sXYxcnJICJhIrLwz
	kbGLkYtDSGAHo8SXfQdZIBLiEs3XfrBD2MISK/89B7OFBJ4wSuxZywRiswioSjRMWARUz8HB
	JqApcWFyKUhYRMBAov/fHzaQmcwChxglev+eB5spLBAp8WjFdbBeXgFdiQ1rbkEtfsMo8WPz
	A6iEoMTJmU/AGpgFzCTmbX7IDLKAWUBaYvk/DpAwp4CbxPzDL5hBbFEBZYkD244zTWAUnIWk
	exaS7lkI3QsYmVcxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHhZbWDsY9qz7oHWJk
	4mAEup+DWUmEN/diabIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
	skwcnFINTEc0kqO9vA/x9czw4JQrrtmV9G/Npx18YouF/uYveh1U/fr8qqLz96zjXQJNn3xo
	2r9ye+L+STw7Sx13GzfNum7MXWji2Z1gX8JmuOme8EKt9DmflIXsd/6wXRvyveGOjFzMupPL
	3YUfhUx9lp7X/tvqweOHfZYV6y6eZwy8fX1X+tKyS5L/BLQk3rcxnqvf/siv6jCzRoPVqitW
	9itPV647ZLPm/qLMJ+vtfny+vHbX+6aVP5PD1rz9aFKRW3ttQ459vKDbp5W8X9btDxHdaCBv
	+aLzR6T9rxlnjx/9wObYuuhY3f2f1gJL327Z3JrCfSWx3CNqIs8tyz2l564bt3jI8Vys7pe+
	GF/zzDCBUVSJpTgj0VCLuag4EQD7cqZJ+QIAAA==
X-CMS-MailID: 20221117072457epcas5p38a61bb22518e7c7eb7b32077621b948a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4e5e3_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221116175159epcas5p4093dd66e85ed287cf9bd9acaec766aa3
References: <20221116171727.4083-1-git@augustwikerfors.se>
	<20221116171935.GA24524@lst.de>
	<CGME20221116175159epcas5p4093dd66e85ed287cf9bd9acaec766aa3@epcas5p4.samsung.com>
	<e775398c-97bc-fc1d-a785-6d3c80bce9c6@augustwikerfors.se>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_232507_974982_87962DAF 
X-CRM114-Status: GOOD (  16.13  )
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

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4e5e3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Nov 16, 2022 at 06:42:43PM +0100, August Wikerfors wrote:
>On 2022-11-16 18:19, Christoph Hellwig wrote:
>>On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
>>>The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
>>>reports eui as 0001000200030004 when resuming from s2idle, causing the
>>>device to be removed with this error in dmesg:
>>>
>>>nvme nvme0: identifiers changed for nsid 1
>>
>>What EUI did it report before? Is the identifier stable after
>>multiple resume cycles?
>The original EUI is "002538e621b440e5". Using the patches from [1] and 
>[2] for debugging I consistently get this output on every resume:
>>eui changed from 002538e621b440e5 to 0001000200030004

Can you please share the firmware version of this SSD?

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4e5e3_
Content-Type: text/plain; charset="utf-8"


------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4e5e3_--


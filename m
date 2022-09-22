Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568F2C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 06:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NpAJm7SdkB4V1zNdxqhgCx2KoC5uSuENjriGVncFv80=; b=tiLhagWjG4ohgSACqjRNAPkm1A
	ROM8sVtXenn1RmaddlYxfnrCDbrHmBMBEHpL37Ya83xwYm7Pba/Pjb5a/LkuVX+kCFnGSneUxMFyA
	/euVV95eJCFpDOG31R4lOe11K0z25URm08d7UuG6x5xKeGu66VBgfuJ7X+/mJ1cWroX1iYAkSO9fC
	Ln+zByFdFFYQFTE9qkNw1sCyb9hQN0fVr/kWtD7R6/ElUy5b/G1HkIOx1mQiXSu8uW/8CBkBl+oB/
	ueVX/3ZyTUkwcPnmHXTfYIPJFp4q8zbe3LYr4Uz8Qs0A7K62E5i2VWAWuPWb31DqIgbZyehwsQNkt
	ctl+It1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obG6r-00Dfuk-Oi; Thu, 22 Sep 2022 06:54:57 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obG6o-00Dfrk-1U
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 06:54:56 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220922065432epoutp04985c7916e7ba5266ed1571acbc827529~XHEWmpVuI1917819178epoutp04F
	for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 06:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220922065432epoutp04985c7916e7ba5266ed1571acbc827529~XHEWmpVuI1917819178epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1663829672;
	bh=NpAJm7SdkB4V1zNdxqhgCx2KoC5uSuENjriGVncFv80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=opjxhd/8qIrSHoyONXWfexECe9SZLB8hVlFvBJk5rUrXAI2DBDXpSdft8feG+y+Rb
	 so5yvVoeL03PIwy/furmKbxtKBLSkG4TO0bibotSHVJr7bIJrWlA02YvbYbW9HvzCK
	 7MBMN839fSzaWX6ySthUXYxMAvw1M2wQootxo0UU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220922065432epcas5p226a5b541302a6cbffa13ba16b20c22a8~XHEWX7oFi3028930289epcas5p2h;
	Thu, 22 Sep 2022 06:54:32 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MY5cQ2lGHz4x9QF; Thu, 22 Sep
	2022 06:54:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DE.E7.39477.4A60C236; Thu, 22 Sep 2022 15:54:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220922065428epcas5p279d9b1ed468a87846db765c1f504d952~XHESVUo0o3028930289epcas5p2a;
	Thu, 22 Sep 2022 06:54:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220922065428epsmtrp2c1759865a44dda3917d61382db8041b8~XHESUOQ730348703487epsmtrp2c;
	Thu, 22 Sep 2022 06:54:28 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-00-632c06a46e2e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	31.54.18644.4A60C236; Thu, 22 Sep 2022 15:54:28 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220922065426epsmtip2a4bbfea0c66183303723f541a0d3f77b~XHEQ0dw503219832198epsmtip2V;
	Thu, 22 Sep 2022 06:54:26 +0000 (GMT)
Date: Thu, 22 Sep 2022 12:14:39 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, j.granados@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Message-ID: <20220922064439.GA23511@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220910053536.GB23158@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmlu4SNp1kg8YOeYvVd/vZLFauPspk
	sXT/Q0aLx3c+s1tMOnSN0WL+sqfsFutev2dxYPc4f28ji8fls6Uem1Z1snlsXlLvsftmA5tH
	35ZVjAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
	OUCnKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0M
	jEyBChOyMxo7njIW/OOuONe/ga2B8SVnFyMHh4SAiUT3y/AuRi4OIYHdjBL79p9hhHA+MUrc
	3bGXHcL5zCixt+U3UxcjJ1hH08ZXjCC2kMAuRomLk2wgip4xSvR+62MHSbAIqEosuPeEGWQF
	m4CmxIXJpSBhEQEliaevzoJtYBaYxSix5vgsVpCEsICNxKblD9hAbF4BXYnlS9qYIGxBiZMz
	n7CA2JwCOhITn10BqxcVUJY4sO04E8ggCYFODomZ256zQlznItH3dAvUpcISr45vYYewpSQ+
	v9vLBmEnS1yaeQ6qpkTi8Z6DULa9ROupfrCjmQUyJS6trgcJMwvwSfT+fsIECS5eiY42IYhq
	RYl7k55CbRWXeDhjCZTtIbFz11I2SJhMYJLof3WHbQKj3Cwk78xC2DALbIOVROeHJlaIsLTE
	8n8cEKamxPpd+gsYWVcxSqYWFOempxabFhjlpZbDYzg5P3cTIzhpanntYHz44IPeIUYmDsZD
	jBIczEoivLPvaCYL8aYkVlalFuXHF5XmpBYfYjQFxs5EZinR5Hxg2s4riTc0sTQwMTMzM7E0
	NjNUEuddPEMrWUggPbEkNTs1tSC1CKaPiYNTqoFJynjCAh5t/rSlO+6UaGT5rJb4dyldwdeM
	KcuqgI1Rc8fanZpvWOWzA+e0285fUJr72M/zD4vzssN+2caBwkku+4UOlbPG8R3b+9/X9Me8
	ev2i5Qu7/+587uXcHKGzL/+304TI9IM1r/0yXkX8/7tp0fFWxhzpv51l2z69uzMpMPCPsc3s
	7WLxphPLVMNmrylYOvec5MHvlU8KNzDoLPtQoJEXYTr/RMXBqU72XqIRj1a/mCCdf/uXtd3n
	iat+bLU0L4tM1ujXCIzpOnvuR7jgkqtlixw7fRI7eQzZtjwt/6nvEumsuiZJKtxt3aIv/fv3
	PVm/MST5iZpVrGHEwphP09UZDl37+6lnqvSEoCwlluKMREMt5qLiRABlMqXHIwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSvO4SNp1kg8OT2CxW3+1ns1i5+iiT
	xdL9DxktHt/5zG4x6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	fVtWMQawRXHZpKTmZJalFunbJXBlHLj/mLlgLWfF5caZbA2Mm9i7GDk5JARMJJo2vmLsYuTi
	EBLYwSix9ftFRoiEuETztR9QRcISK/89Z4coesIoMWv/GyaQBIuAqsSCe0+Yuxg5ONgENCUu
	TC4FCYsIKEk8fXUWbCizwCxGiTXHZ7GCJIQFbCQ2LX/ABmLzCuhKLF/SxgQxdAKTxNf+B6wQ
	CUGJkzOfsIDYzAJmEvM2PwRbwCwgLbH8HwdImFNAR2Lisytg5aICyhIHth1nmsAoOAtJ9ywk
	3bMQuhcwMq9ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOBi2tHYx7Vn3QO8TIxMF4
	iFGCg1lJhHf2Hc1kId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
	ODilGpguapbPy9vF93/e2/6aVUaf52dev2jH0H3Ji08ilN/wx8PD7/+1+yx9kfOy+F7P5ok7
	dKaHPs6OYuSvOZuu+NI/WVX1cKtfh8ubXrNbjl1n0q8zt091UupOjN//pSb4qXrd2rer8m8H
	3fmw4HbvgtSsCCUD3x87r3Q/EDvZ1HKIzfGjfx/POZ97u6dJVfoJ3fp54fqasIcO21tisswD
	/1UqT/CLDtpkWX3x49G3zYUTFVSzp921Mj4pcNFK5arPhRV3pj6bfvM6Dys7V7LJuZqfdz1u
	5uWcnsyko2r49nx4mmzRoniBZwwvHfqaO8R73dmj2Z7o71gvJzDtgODfycxLm/dXBZ1fZi7h
	VHVsuZ4SS3FGoqEWc1FxIgBCVhM+9QIAAA==
X-CMS-MailID: 20220922065428epcas5p279d9b1ed468a87846db765c1f504d952
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----STjx0DdB5XWzR39.p0qqcVQtF-toHyOxq53rKg1ScZo20x2r=_12f279_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
References: <20220909163307.30150-1-joshi.k@samsung.com>
	<CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com>
	<20220909163307.30150-2-joshi.k@samsung.com>
	<47e19485-f321-cd2a-3408-173434b04d01@kernel.dk>
	<20220910053536.GB23158@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_235454_690281_3D11439C 
X-CRM114-Status: GOOD (  19.35  )
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

------STjx0DdB5XWzR39.p0qqcVQtF-toHyOxq53rKg1ScZo20x2r=_12f279_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Sat, Sep 10, 2022 at 07:35:36AM +0200, Christoph Hellwig wrote:
>On Fri, Sep 09, 2022 at 10:55:45AM -0600, Jens Axboe wrote:
>> > +bool nvme_io_cmd_allowed(u8 opcode, fmode_t mode)
>> > +{
>> > +	/* allow write/read based on what was allowed for open */
>> > +	/* TBD: try to use nvme_is_write() here */
>> > +	if (opcode & 1)
>> > +		return (mode & FMODE_WRITE);
>> > +	else
>> > +		return (mode & FMODE_READ);
>> > +}
>>
>> The read/write distinction doesn't make a lot of sense to me. You've
>> already been able to open the device at this point. It would only make
>> sense to limit some things based on FMODE_WRITE imho, not FMODE_READ.
>
>True.  Note that the I/O queues can also send fabrics commands, which
>we must exclude, and I'd also very much exclude vendor specific commands
>as we can't trust them at all - they aren't even guaranteed to interpret
>the nsid field like the standard ones.

I see. 
So next version (with reduced scope limited to io-cmd only) will -
a) not allow fabrics and VS commands at all
b) allow write-cmds iff FMODE_WRITE is set
c) allow read-cmds without looking at FMODE_READ

Please correct if something sounds amiss in that.

------STjx0DdB5XWzR39.p0qqcVQtF-toHyOxq53rKg1ScZo20x2r=_12f279_
Content-Type: text/plain; charset="utf-8"


------STjx0DdB5XWzR39.p0qqcVQtF-toHyOxq53rKg1ScZo20x2r=_12f279_--


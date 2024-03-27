Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A224CC47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Mar 2024 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=una1HYSdVM6tYkjzKdUNl/O2Y+ZZNq/Yux8uDVcibfo=; b=OKgLNUmN1oUKy1YwDuZuBaoW8T
	6z6hpFu3jlJyvY25OqNmurtxaZHDiBffefiTCyz6UjeIf0fOkHWNi+ttkCnsOKpCfCiY7IxPLQdfU
	mMSI3TuyVKIseM8BQIOKSQeOgagefR+L1KQse9pTI5qxui2gljZxVqGiKy6gy3MKEOuLgNtk9Upae
	bRsLUhpfcz8CzkJl8sOatn0GSzl+xQW5cB6YgdeqVZmC0yUisUrDuoonoICsS6zEk1AQeoC44fiWU
	J4M2x67o1zSdzxieneeCAiguqV8SKxbqThP1SqqJPaFuE2JXVRZZYAs3D12MDYIm8Q1QTiIVqKUiC
	HSyXv8xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpTbd-00000009Gt3-1PXi;
	Wed, 27 Mar 2024 13:46:17 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpTbY-00000009Gq4-0oJM
	for linux-nvme@lists.infradead.org;
	Wed, 27 Mar 2024 13:46:15 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240327134602epoutp029c44924bcb0cadba8bff43032247f99b~AoxNmTU-72122721227epoutp02Y
	for <linux-nvme@lists.infradead.org>; Wed, 27 Mar 2024 13:46:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240327134602epoutp029c44924bcb0cadba8bff43032247f99b~AoxNmTU-72122721227epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711547162;
	bh=una1HYSdVM6tYkjzKdUNl/O2Y+ZZNq/Yux8uDVcibfo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JQ6PNnJx7AdmlnZrxKWjUWJJTO1+yuTcGEU6B4/hLNuLqtwzgLUjGq4U0xDKsFNLQ
	 D5V4nmndGWAhXcP9qqsGSIxRqQAF3tkocpo7vK2So4yPA2mXYuVMAqAp4VZONxQBs2
	 99O8QXBV+bmptZlOB1W0TxcJkJ0JakGGvGgIUvN8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240327134601epcas5p2e16fd35ed10455651e4054dba73900ed~AoxNF6BBB0638906389epcas5p2u;
	Wed, 27 Mar 2024 13:46:01 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V4ScR66Xnz4x9Pp; Wed, 27 Mar
	2024 13:45:59 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.6F.08600.71324066; Wed, 27 Mar 2024 22:45:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240327134559epcas5p1dd8a667cc1b0262d2ee458c559e2046f~AoxLHW1JC0214702147epcas5p12;
	Wed, 27 Mar 2024 13:45:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240327134559epsmtrp1f0f35df3559df0ed54fd8aaf04d0104b~AoxLGmVI91932719327epsmtrp1n;
	Wed, 27 Mar 2024 13:45:59 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-3e-660423172074
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.EF.08924.71324066; Wed, 27 Mar 2024 22:45:59 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240327134557epsmtip168d28035b07ca17472e5e72c49393c09~AoxJtpiy-0831008310epsmtip1F;
	Wed, 27 Mar 2024 13:45:57 +0000 (GMT)
Message-ID: <c196e634-7081-9d90-620c-002d3ff15dfc@samsung.com>
Date: Wed, 27 Mar 2024 19:15:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC]
 Meta/Integrity/PI improvements
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com, Christoph Hellwig
	<hch@lst.de>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmpq64Mkuawc/Nuhar7/azWaxcfZTJ
	4s9DQ4tJh64xWuy9pW2xZ+9JFov5y56yW+x7vZfZYvnxf0wOnB6Xz5Z6bFrVyeaxeUm9x+Qb
	yxk9dt9sYPP4+PQWi8eEzRtZPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDU
	NbS0MFdSyEvMTbVVcvEJ0HXLzAG6TUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJT
	YFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnbHrG2/BAfGKx/9esDQwtgl3MXJySAiYSLTMv8Lc
	xcjFISSwm1Fi7o2T7BDOJ0aJrqNnGCGcb4wS//9NBCrjAGs5eCECIr6XUWLmlKdQ7W8ZJdYu
	fcwEMpdXwE6iZeleMJtFQFXi6IqjbBBxQYmTM5+wgNiiAskSP7sOsIEMFRaIkXi2zxUkzCwg
	LnHryXywVhEBU4nJn7aygcxnFnjMJDH9eD9YPZuApsSFyaUgJqeAscTmGXEQrfIS29/OATtH
	QmAph8SxF9cZIW52kbi1TxDiY2GJV8e3sEPYUhIv+9ug7GSJSzPPMUHYJRKP9xyEsu0lWk/1
	g73ODLR1/S59iFV8Er2/nzBBTOeV6GgTgqhWlLg36SkrhC0u8XDGEijbQ+LH5RNs8HBet2kF
	ywRGhVlIYTILyfOzkHwzC2HzAkaWVYySqQXFuempyaYFhnmp5fDITs7P3cQITrZaLjsYb8z/
	p3eIkYmD8RCjBAezkghvyxeGNCHelMTKqtSi/Pii0pzU4kOMpsDImcgsJZqcD0z3eSXxhiaW
	BiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1MMX8+a0SHTm9S1V+mndJ84fJ
	HXsvvXu686JyAeem3PfeyoeLbnydlLB4OWdUcF90aqzsnUvTLvzWYlo2MdzsDoNqrbro/Qu7
	xDZueC3T22zsf0zx/Ne/Vx7Xr/g/ZadJ//vzTr+nXNauOjDveOOvJe4pc5aWxb18smjX996p
	XOmpCappiYf0sk7rqpr2vz3SLDlfMebBrvo1VTyHp+ife/clgpFnm0e65HIxj+asOr+8a8fO
	61XcY1j+w+bbFYUJU6/1ML//s3LizLNaKc+Xb9z4yOLMSveaOVeXcEyW28OvUt1wPvaaJJPb
	4e8Lmc7JXkiyCXdQWHmVtfvI///nfmgWnP0/yZYlZkce1xMLT+EXSizFGYmGWsxFxYkAONRg
	JD8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTldcmSXN4NlaIYvVd/vZLFauPspk
	8eehocWkQ9cYLfbe0rbYs/cki8X8ZU/ZLfa93stssfz4PyYHTo/LZ0s9Nq3qZPPYvKTeY/KN
	5Yweu282sHl8fHqLxWPC5o2sHp83yQVwRHHZpKTmZJalFunbJXBl7PrGW3BAvOLxvxcsDYxt
	wl2MHBwSAiYSBy9EdDFycQgJ7GaU2Ns/l7WLkRMoLi7RfO0HO4QtLLHy33N2iKLXjBKHN99n
	AUnwCthJtCzdywRiswioShxdcZQNIi4ocXLmE7AaUYFkiZd/JoINEhaIkdi7bT1YnBlowa0n
	88F6RQRMJSZ/2soGsoBZ4DGTxJev29jhTpq7YjsbyKlsApoSFyaXgpicAsYSm2fEQcwxk+ja
	2sUIYctLbH87h3kCo9AsJGfMQrJuFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L
	10vOz93ECI4uLc0djNtXfdA7xMjEwXiIUYKDWUmEt+ULQ5oQb0piZVVqUX58UWlOavEhRmkO
	FiVxXvEXvSlCAumJJanZqakFqUUwWSYOTqkGJsbS9at/Jmb3VLdumsUkvlu934519/E7c49+
	7H01R9pW9PXfP6Hxqb8uRadvlDbpa738k/nytpLrO+daWF2zMzsT3/mhKyBI4Ar3WuUn5hYf
	3/rcbL/kkpVybb3tnFyZV3zJYVe+LU9VaZVT+9tVcmOv33fP8gqr92c/Bvx1nrXsMmfdnZy+
	I5y7PN6sMxAKszrw7rmuxLQaxot+c30FfM5tNbNfyxIlLBq8y01Q487lkAkSOzRaQjatDSo8
	vVuGz2mnAIOL1rt0n/X/VYMNQmLtcpmWbshY3vSY//QCmQslf9u3fNms9DXoh4bK4Uq3xfwr
	jk039by2tfAnw2LXGyyWt1IPzXw/s6sz7dWuTiWW4oxEQy3mouJEAA52GWkdAwAA
X-CMS-MailID: 20240327134559epcas5p1dd8a667cc1b0262d2ee458c559e2046f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240222193304epcas5p318426c5267ee520e6b5710164c533b7d
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	<aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	<yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_064613_083803_CE705F4F 
X-CRM114-Status: GOOD (  28.04  )
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

On 2/27/2024 4:45 AM, Martin K. Petersen wrote:
> 
> Kanchan,
> 
>> - Generic user interface that user-space can use to exchange meta. A
>> new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
>> direct IO.
> 
> Yep. I'm interested in this too. Reviving this effort is near the top of
> my todo list so I'm happy to collaborate.

The first cut is here:
https://lore.kernel.org/linux-block/20240322185023.131697-1-joshi.k@samsung.com/

Not sure how far it is from the requirements you may have. Feedback will 
help.
Perhaps the interface needs the ability to tell what kind of checks 
(guard, apptag, reftag) are desired.
Doable, but that will require the introduction of three new RWF_* flags.

>> NVMe SSD can do the offload when the host sends the PRACT bit. But in
>> the driver, this is tied to global integrity disablement using
>> CONFIG_BLK_DEV_INTEGRITY.
> 
>> So, the idea is to introduce a bio flag REQ_INTEGRITY_OFFLOAD
>> that the filesystem can send. The block-integrity and NVMe driver do
>> the rest to make the offload work.
> 
> Whether to have a block device do this is currently controlled by the
> /sys/block/foo/integrity/{read_verify,write_generate} knobs.

Right. This can work for the case when host does not need to pass the 
buffer (meta-size is equal to pi-size).
But when meta-size is greater than pi-size, the meta-buffer needs to be 
allocated. Some changes are required so that Block-integrity does that 
allocation, without having to do read_verify/write_generate.

> At least
> for SCSI, protected transfers are always enabled between HBA and target
> if both support it. If no integrity has been attached to an I/O by the
> application/filesystem, the block layer will do so controlled by the
> sysfs knobs above. IOW, if the hardware is capable, protected transfers
> should always be enabled, at least from the block layer down.
> It's possible that things don't work quite that way with NVMe since, at
> least for PCIe, the drive is both initiator and target. And NVMe also
> missed quite a few DIX details in its PI implementation. It's been a
> while since I messed with PI on NVMe, I'll have a look.

PRACT=1 case, figure 9 and Section 5.2.2, in the spec: 
https://nvmexpress.org/wp-content/uploads/NVM-Express-NVM-Command-Set-Specification-1.0d-2023.12.28-Ratified.pdf

I am not sure whether SCSI also has the equivalent of this bit.


> But in any case the intent for the Linux code was for protected
> transfers to be enabled automatically when possible. If the block layer
> protection is explicitly disabled, a filesystem can still trigger
> protected transfers via the bip flags. So that capability should
> definitely be exposed via io_uring.
> 
>> "Work is in progress to implement support for the data integrity
>> extensions in btrfs, enabling the filesystem to use the application
>> tag."
> 
> This didn't go anywhere for a couple of reasons:

Thanks, this was very helpful!


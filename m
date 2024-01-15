Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73A2C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BXsSyq/ETS6VHy49YmdYk+79vD9CUUsCSBhh019gJfo=; b=XbKWm+e9N/EggNog/9pH7eyZNr
	0FI0uY27FVUFQ9HaneR9sHtIV/eub/+0l8r90HzpbN0HCr5rwsNdjqQM2gVgUvOo6F/6+wM9Ltpmx
	V+mzxlGykGGfPrZCfiIkz99fdOFdKdpRSQwZs3xLDYqmkOwhrHDqm3e+jCAYDLWHlhe2LrJrpuJTU
	NACRktKHmqO2RB9X9n3s8Ob0zbTc0XN+jzQQTSxi/X2wzGYXYz/lBdDPYEJGhuPjQLE/PaCR5+AjE
	rljOzveXX+lFnhQwIZokG11h2Va8ftDOL2Q+p821kag5AwI+WO5TQw2BCZfUmfQcHuIFYouobWn4d
	B2ZXmzdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPRAq-009qoR-0L;
	Mon, 15 Jan 2024 17:55:00 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPRAl-009qkl-2j
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 17:54:59 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240115175447euoutp0242520538b0befaa7a8ba5f669fa9e14d~qlt2t1t-00561405614euoutp020
	for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 17:54:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240115175447euoutp0242520538b0befaa7a8ba5f669fa9e14d~qlt2t1t-00561405614euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705341287;
	bh=BXsSyq/ETS6VHy49YmdYk+79vD9CUUsCSBhh019gJfo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=l7pl4ljPIyngWGzwFF2ot1P5WbmqQ8vkaXcgZMAQQve5V2Ama9mPoJW1nHAI33Wjm
	 5t1UVOq8SGsSZDYds9zUGFeEurbCK2E2t/sEwSnP9NZk6lfxmUrdbYSrrDKaS6lgVQ
	 W99ujb/t3GI4kT2bo0158K5yodQQjzbUNgN0ptho=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240115175447eucas1p2579ccc7b04824ded5b2e7ea9ace6b99f~qlt2VREfc2424624246eucas1p2T;
	Mon, 15 Jan 2024 17:54:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B7.6E.09539.76175A56; Mon, 15
	Jan 2024 17:54:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240115175446eucas1p111db0849d5ea9fa820c71ad5a003f637~qlt16QncW1005210052eucas1p1O;
	Mon, 15 Jan 2024 17:54:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240115175446eusmtrp2b6e3ba6dac4ad20d4e5b5e1c06da268f~qlt15rFlu1804618046eusmtrp2Y;
	Mon, 15 Jan 2024 17:54:46 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-74-65a57167756f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 83.7B.09146.66175A56; Mon, 15
	Jan 2024 17:54:46 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240115175446eusmtip1dfaeaa659f9440378ec2fe2893a2726c~qlt1u5Ktw1870818708eusmtip1o;
	Mon, 15 Jan 2024 17:54:46 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 15 Jan 2024 17:54:46 +0000
Date: Mon, 15 Jan 2024 18:54:45 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<a.manzanares@samsung.com>, <linux-scsi@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<slava@dubeiko.com>, Kanchan Joshi <joshi.k@samsung.com>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Message-ID: <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20240115084631.152835-1-slava@dubeyko.com>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7rphUtTDf4t4beY9uEns8XeW9oW
	e/aeZLGYv+wpu0X39R1sFvte72W2+HR5IZDYMpvJgcPj8hVvj0dPDrJ6HFz/hsVj85J6j8k3
	ljN6fN4kF8AWxWWTkpqTWZZapG+XwJUxd+Vv5oLrghWvL8k2ME7j62Lk5JAQMJHYPK+bvYuR
	i0NIYAWjxIED8xkhnC+MEtcnzWKDcD4zStx78IYdpuXo5assEInljBIXXu5lgata8W8FlLOV
	UeL7wv2MIC0sAqoSt6duZwOx2QTsJS4tu8UMYosIaEnM3jeFCcRmFljNJPHwuGAXIweHsECO
	RPsUb5Awr4CLxLO2c6wQtqDEyZlPWCDKrSQ6PzSxgpQzC0hLLP/HARLmFLCQeDLzLQtIWEJA
	WWL5dF+Im2slTm25xQRymYTABw6JNd2LoZ5xkdj/aAeULSzx6vgWKFtG4v/O+UwQdrbExTPd
	zBB2icTi98eYIeZbS/SdyYEIO0ocurOTESLMJ3HjrSDEkXwSk7ZNh6rmlehoE4KoVpNYfe8N
	ywRG5VlI3pqF5K1ZCG8tYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZhyTv87/mkH
	49xXH/UOMTJxMB5ilOBgVhLhrb6zJFWINyWxsiq1KD++qDQntfgQozQHi5I4r2qKfKqQQHpi
	SWp2ampBahFMlomDU6qBqZEvWOHpLj61FJEV5cEGe54VhMqUuh3QSjy2eMWCuVuv7Oh9/TIu
	KYpvh6/bNhfeXy+YZii9KHus9eJN/P6HukH/OvMM+Q8JinrNSZGPiJL1kD6b91KIecaTc+se
	+erKchksDi3zXTBdTv57WL1EffBsmbffxK5diGh5uTry0XuL9vCJBmpZObKp7S8qGD7yL+te
	JzZD8XDnu1snOqomeCdOOX32tE5/pMscIX6vNQus1zg88lp3coPvcontpjYrHOYpGIstvaik
	t7GsY9JJL54lj7IVglS6V6yaZ7pl1TfD1MAy26lzmLa527zdU3TjEGtjk9abzx5y9gsXLHHo
	D7rxp/zUshOKn1TDHPNDlViKMxINtZiLihMBlz9nUqgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7pphUtTDR591LeY9uEns8XeW9oW
	e/aeZLGYv+wpu0X39R1sFvte72W2+HR5IZDYMpvJgcPj8hVvj0dPDrJ6HFz/hsVj85J6j8k3
	ljN6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
	pG+XoJcxd+Vv5oLrghWvL8k2ME7j62Lk5JAQMJE4evkqSxcjF4eQwFJGiYOnJzFCJGQkNn65
	ygphC0v8udbFBlH0kVHiS9tyRghnK6PE6m0LwDpYBFQlbk/dzgZiswnYS1xadosZxBYR0JKY
	vW8KE4jNLLCaSeLhccEuRg4OYYEcifYp3iBhXgEXiWdt51ghZnYzSnz6vY4ZIiEocXLmExaI
	XguJmfPPM4L0MgtISyz/xwES5gQKP5n5lgUkLCGgLLF8ui/EzbUSn/8+Y5zAKDwLyaBZSAbN
	Qhi0gJF5FaNIamlxbnpusaFecWJucWleul5yfu4mRmD0bTv2c/MOxnmvPuodYmTiYDzEKMHB
	rCTCW31nSaoQb0piZVVqUX58UWlOavEhRlNgQExklhJNzgfGf15JvKGZgamhiZmlgamlmbGS
	OK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5Nb2qMm6f7fOR6R3ivvH7yZvJo/PopFtPxlevap
	6LjnW74WMPpdF3ltePKJeNS+pz7rzV5Mfbxuy/784sKY5ZF9HFO7N+oGdiYr6FrK1IkrbI+c
	p1AlJHLUJ6A5uKCtYZNmgNiGBUc+nT+2eUGfo9y0zoZnm9tOVhuvadB4K37Ff+3r+BMrz3x6
	fnnKUa6nKbIrQmbI6O88/D5/dvvHeP/a1858Kk+sUk+V6q7b1p4skOL9gS3ghtDe+Qmrz/W/
	suervGnhfeyDysJFeglW/w0eT7592fjaI6Xll16a2iZOnvt5/RWrB1HfhHwOBJRs+1WztrdI
	Y5pxUn+w+sN02Vz7x3Hber94yegy6Mx89ECJpTgj0VCLuag4EQAmyXQiRwMAAA==
X-CMS-MailID: 20240115175446eucas1p111db0849d5ea9fa820c71ad5a003f637
X-Msg-Generator: CA
X-RootMTR: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
	<20240115084631.152835-1-slava@dubeyko.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_095456_470504_8EF62D07 
X-CRM114-Status: GOOD (  15.54  )
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

On 15.01.2024 11:46, Viacheslav Dubeyko wrote:
>Hi Javier,
>
>Samsung introduced Flexible Data Placement (FDP) technology
>pretty recently. As far as I know, currently, this technology
>is available for user-space solutions only. I assume it will be
>good to have discussion how kernel-space file systems could
>work with SSDs that support FDP technology by employing
>FDP benefits.

Slava,

Thanks for bringing this up.

First, this is not a Samsung technology. Several vendors are building
FDP and several customers are already deploying first product.

We enabled FDP thtough I/O Passthru to avoid unnecesary noise in the
block layer until we had a clear idea on use-cases. We have been
following and reviewing Bart's write hint series and it covers all the
block layer and interface needed to support FDP. Currently, we have
patches with small changes to wire the NVMe driver. We plan to submit
them after Bart's patches are applied. Now it is a good time since we
have LSF and there are also 2 customers using FDP on block and file.

>
>How soon FDP API will be available for kernel-space file systems?

The work is done. We will submit as Bart's patches are applied.

Kanchan is doing this work.

>How kernel-space file systems can adopt FDP technology?

It is based on write hints. There is no FS-specific placement decisions.
All the responsibility is in the application.

Kanchan: Can you comment a bit more on this?

>How FDP technology can improve efficiency and reliability of
>kernel-space file system?

This is an open problem. Our experience is that making data placement
decisions on the FS is tricky (beyond the obvious data / medatadata). If
someone has a good use-case for this, I think it is worth exploring.
F2FS is a good candidate, but I am not sure FDP is of interest for
mobile - here ZUFS seems to be the current dominant technology.

>Which new challenges FDP technology introduces for kernel-space
>file systems?

See above. All we have done is wire up the NVMe driver. This is a good
discussion for LSF/

>Could we have such discussion leading from Samsung side?

Of course. We are happy to host a session on this if it gets selected.
We will add it to one of our submission.


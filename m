Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFA9EEE26C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 12:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=dNSjkxkLqvKCjuCLMthsAFsvsu
	Z+pTKmA+wpgyu2z7+xlszcx4mPWoBwi6HVdnniZrGlZPSyT/1S7j2o/oTqe0p6t+DgUtbQ+PWXve/
	cBWppGZzmc0noe9/Lye3fsbJXWbleP7+H6qtqkVNLzCYkJJkvw6gTzll0+anjOX7nWv8B0KujJ8pU
	w83VyTyWwUOP4clkhjk9T4jGufFR5ERtkJnHyPqY5IDP1Mmkdwkt9oizKoUrnSCyQQrRV31ybXSAx
	LhWTL9gv7KynHdl6fi9kq/uh59OTSv4IqFfNG1SAw6bpsRr3hJ0GBVGc/7fmdrRZB690yWf9GJ4C3
	TFEJveHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5W6-0000000Fujj-0TdR;
	Fri, 13 Sep 2024 12:35:14 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5W3-0000000Fuii-09O7
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 12:35:12 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240913123506epoutp047c43928c1b9d48067ba7d04d51c00dd0~0zd0JuEki1639816398epoutp041
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 12:35:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240913123506epoutp047c43928c1b9d48067ba7d04d51c00dd0~0zd0JuEki1639816398epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726230906;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OnzXToObvVrHsf6umPQVQTsqNG1RC20r96PWuWDTrOZHpykf0l/ieO5DKY1Bh7gFQ
	 Gznu9wB+p6h/KdhsJTIuGq4g+dQQ+t9PrjruWANaIw3dctGhGj28lWzXb/5txOqTrv
	 DZWdqrqj+KkptFocAWy2vacggoHWvjU6jn4z9Fo4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240913123506epcas5p4ee5083a8e3816b21cb21d31135a9317e~0zdz2mboA0204402044epcas5p4q;
	Fri, 13 Sep 2024 12:35:06 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X4v085RR9z4x9Pq; Fri, 13 Sep
	2024 12:35:04 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.08.09743.77134E66; Fri, 13 Sep 2024 21:35:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240913123502epcas5p3941c0ef27fd0936749cd7e21df2eb344~0zdw9lBgb0717807178epcas5p3g;
	Fri, 13 Sep 2024 12:35:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240913123502epsmtrp204e7b7e889696e487750ec8591cec23f~0zdw3rhHN1685416854epsmtrp2B;
	Fri, 13 Sep 2024 12:35:02 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-14-66e431776fd6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	12.BA.08456.67134E66; Fri, 13 Sep 2024 21:35:02 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240913123501epsmtip273923a0ac0c32e8fa2c640ee089efecd~0zdvfDYIw0673906739epsmtip2b;
	Fri, 13 Sep 2024 12:35:01 +0000 (GMT)
Message-ID: <862a80c3-a6a3-d611-d4f8-6de333b1ecae@samsung.com>
Date: Fri, 13 Sep 2024 18:05:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCHv4 06/10] block: provide helper for nr_integrity_segments
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240911201240.3982856-7-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmlm654ZM0g/sTeSxW3+1ns1i5+iiT
	xaRD1xgtzlxdyGKx95a2xfxlT9ktuq/vYLNYfvwfk8W61+9ZHDg9zt/byOJx+Wypx6ZVnWwe
	m5fUe+y+2cDmce5ihcfHp7dYPD5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDU
	NbS0MFdSyEvMTbVVcvEJ0HXLzAG6TUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJT
	YFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnXFqx1KmAqOKa3P7mBoYdbsYOTkkBEwk/vXtYOpi
	5OIQEtjNKPHs1FRmCOcTo8TcSVPZIZxvjBInJn1hhmlpmPQVqmovo8TRc50sIAkhgbeMEj/v
	1IDYvAJ2Ei9PPGQEsVkEVCX2XGxggogLSpyc+QSsXlQgSeLX1TlgNcICPhJb1mwHW8AsIC5x
	68l8sJtEBE4ySuyYcJURIqEs0dnzEegkDg42AU2JC5NLQcKcAuYSX7YeYYcokZfY/nYO2HES
	Aks5JE6eusAKcbWLxJXOSywQtrDEq+Nb2CFsKYnP7/ayQdjZEg8ePYCqqZHYsbkPqtdeouHP
	DVaQvcxAe9fv0ofYxSfR+/sJE0hYQoBXoqNNCKJaUeLepKdQneISD2csgbI9JHb0vWKDhNt2
	RolpBw+xTGBUmIUULLOQvD8LyTuzEDYvYGRZxSiZWlCcm55abFpglJdaDo/u5PzcTYzghKvl
	tYPx4YMPeocYmTgYDzFKcDArifBOYnuUJsSbklhZlVqUH19UmpNafIjRFBg/E5mlRJPzgSk/
	ryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkGJsmrTQmB22qY72Vs
	Png45OXvHUeU/uv93rsyuWte0cU1p2cb7t10TpHX0/8ji86E/VGNliY2YWtaN61Zd1vteqqX
	SaNVQguLh1L+o4MB73h925pT4+q0Jyd+XCJzzEup2/3Rg+2xP3RmtlU8FFJO3ZHUkWhncUd1
	/+lre3bPf1Pnv3BrZ+XZ1196GI8vE7uRqzNdYeOkRZIWm2uuH1C4ub70z63Hsg+EDgk8kWZM
	E3hrZ5DBZbJMRUCZo6LJefvq+pPfd6kpFyclT+Ge4nXw6LpVa5vMWS0/62479sOsof3qvYsf
	vJr7nXT8/fN/XGJoDlfL/Ttj3woFOfep+6webufjUHRf6PyeY+6tuwyejkosxRmJhlrMRcWJ
	AKPyTE1BBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXrfM8EmawY2Lehar7/azWaxcfZTJ
	YtKha4wWZ64uZLHYe0vbYv6yp+wW3dd3sFksP/6PyWLd6/csDpwe5+9tZPG4fLbUY9OqTjaP
	zUvqPXbfbGDzOHexwuPj01ssHp83yQVwRHHZpKTmZJalFunbJXBlnNqxlKnAqOLa3D6mBkbd
	LkZODgkBE4mGSV+Zuxi5OIQEdjNKvPh7mwUiIS7RfO0HO4QtLLHy33N2iKLXjBLN0xczgiR4
	BewkXp54CGazCKhK7LnYwAQRF5Q4OfMJ2CBRgSSJPfcbweLCAj4SW9ZsZwaxmYEW3Hoynwlk
	qIjASUaJZ1++MUEklCU6ez5CbdvOKPHl+gK2LkYODjYBTYkLk0tBajgFzCW+bD3CDlFvJtG1
	tYsRwpaX2P52DvMERqFZSO6YhWTfLCQts5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqX
	rpecn7uJERxfWlo7GPes+qB3iJGJg/EQowQHs5II7yS2R2lCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1ME0wEWX6vzsxjVcren6acUWOiZzpyhVdn75o
	FItdm2n2uzGxKHnyQp84F0uu27Off7TdFd5v/lqrwP2w4o995lwb+JpC4+59sS5nv+xWPOWF
	uNOz6E2JT20vTWjumerMcFcuOO2Wo6LFqhZhtygGh7yZJ5xMXcReleekyB9NP/CmxETkyM+p
	C39nVe6YvGLhxx9JlluN368/ms946x3rrwDfv3dnHnqyNWfLtCfHw0w339uxNVNO3+60fnoL
	g/6rovjL//zTXS5pCDJLbVKRk924w415x+UtGQI3RH9VHnxk/+JuIVfPxFnMD4pi7A9dqfS3
	Y/3gdUJl+qJHB0/JaW5yPSq11NC4eP291alM8UosxRmJhlrMRcWJAPWNtN0eAwAA
X-CMS-MailID: 20240913123502epcas5p3941c0ef27fd0936749cd7e21df2eb344
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911201325epcas5p23107c22f460df737f59f3b90ba12d72c
References: <20240911201240.3982856-1-kbusch@meta.com>
	<CGME20240911201325epcas5p23107c22f460df737f59f3b90ba12d72c@epcas5p2.samsung.com>
	<20240911201240.3982856-7-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_053511_417574_2E0CFCB1 
X-CRM114-Status: UNSURE (   6.65  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


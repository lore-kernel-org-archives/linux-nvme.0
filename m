Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E47BC38A02
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 05:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LoBOAPK0nSAFEgq/EFpjRNssIyVY0UR51j1Af+3m7I4=; b=PJF4b6IUJmZJtf0TvWHyUUBbdv
	fmDdL1fDCSxzP5IEx7yuBAxPafmZ/c3nsQcbzQb/cIzR0+uM7yG+pvcvByg9uDWKcPZD37PbPEoEm
	mLS9LXh88hcWn4l74bTXR8ovrykXLn8SrM35An9zwXIrDFwpRM6Dzn6+jpoLM+6zUhh1htNgCki73
	zEtsEagBqRPwwrDloDJDCZM98LVV9LVa1ZYzycrG6KPaY86AR1bwGWjtMVbYzsIlqPKU1fZL4ZFks
	32MO/dbVOCG4QuXnU80aViRX0gs2R1pX6bsYe+SmSxV+yBTtrXNROAROaZ7XYeUHS4qQEsOXN+8Br
	orRHkVAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooI14-00FpH3-Nw; Fri, 28 Oct 2022 05:34:50 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooI0y-00FpFs-Su
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 05:34:48 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221028053437epoutp01647e1afa467acc8e2e036442e5b59d52~iJM1-4EBq1742417424epoutp01N
	for <linux-nvme@lists.infradead.org>; Fri, 28 Oct 2022 05:34:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221028053437epoutp01647e1afa467acc8e2e036442e5b59d52~iJM1-4EBq1742417424epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666935277;
	bh=LoBOAPK0nSAFEgq/EFpjRNssIyVY0UR51j1Af+3m7I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HvBs+Im6rVfIyf9MOGBZBJJsGvBjgYV5/0jX8w0njreYpY4mEm1LKi2PDPVGRt4M8
	 9nmxme0CzWdjIGrVTQJ4tC1p93zWMhoc0xfi4i6ysEqGPZJIyGE0zBPGioMO6FHXdG
	 kYIUNQEErBC1R+MC6BjjRJoJxE00dSAIVYXwpxvs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20221028053436epcas5p22c221960d7fb37233e5984303b6ff7b4~iJM1wpE1N2624726247epcas5p2D;
	Fri, 28 Oct 2022 05:34:36 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4MzB7b0HDXz4x9Q0; Fri, 28 Oct
	2022 05:34:35 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.0D.39477.AE96B536; Fri, 28 Oct 2022 14:34:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20221028053434epcas5p4efdc0a0cd03124d104911f12f266fa8f~iJMzR17dN1005410054epcas5p4Z;
	Fri, 28 Oct 2022 05:34:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221028053434epsmtrp116ec40eccbcaaeec5ced768d88d1e344~iJMzRC3J13013430134epsmtrp1c;
	Fri, 28 Oct 2022 05:34:34 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-b7-635b69ea7a6c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E7.BB.14392.AE96B536; Fri, 28 Oct 2022 14:34:34 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221028053432epsmtip1295ca2256d7678f7c48a6e6a63f9024d~iJMx2fyF91681216812epsmtip1I;
	Fri, 28 Oct 2022 05:34:32 +0000 (GMT)
Date: Fri, 28 Oct 2022 10:53:18 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	chaitanyak@nvidia.com, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCHv2] nvme: quiet user passthrough command errors
Message-ID: <20221028052318.GA4034@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221027150417.1954662-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmlu6rzOhkg+6rJhZ7+k8xWay+289m
	8f7gY1aLw48nsVusXH2UyWLSoWuMFmeuLmSxmL/sKbvFutfvWRw4Pc7f28jicflsqcemVZ1s
	HpuX1HvsvtnA5nHuYoVHb/M7No+PT2+xeGw+XR3AGZVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2Pd5cXsBQc4K5a8eMfewNjM0cXIySEh
	YCKx6/x25i5GLg4hgd2MEn1LPzBBOJ8YJf5vWcsO4XxjlPi5+zQLTMu9LdegWvYySvQ+m8cG
	4TxjlNhzazYrSBWLgKrE4uY3QB0cHGwCmhIXJpeChEUEFCXOA8MDpJ5Z4BqjxI55e8CmCgs4
	SWxd0MkMYvMK6Ehc6rzFBGELSpyc+QSshlPAXOJD6w42EFtUQFniwLbjYLdKCKzkkJjc84sR
	4jwXiZabd9kgbGGJV8e3sEPYUhIv+9ug7GSJSzPPMUHYJRKP9xyEsu0lWk/1gx3BLJAhcarv
	IyOEzSfR+/sJE8gzEgK8Eh1tQhDlihL3Jj1lhbDFJR7OWAJle0g8vr4OGihdjBIfG1eyT2CU
	m4Xkn1lIVkDYVhKdH5pYZwGtYBaQllj+jwPC1JRYv0t/ASPrKkbJ1ILi3PTUYtMCo7zUcngs
	J+fnbmIEp1otrx2MDx980DvEyMTBeIhRgoNZSYT37I3wZCHelMTKqtSi/Pii0pzU4kOMpsD4
	mcgsJZqcD0z2eSXxhiaWBiZmZmYmlsZmhkrivItnaCULCaQnlqRmp6YWpBbB9DFxcEo1MGVf
	V3ourc0m2/Bx8nd+7TP3WyYnbGkpnHwnuPXNjj4DmegS0Y3ydQLnlzWr20R7Nuy2UZx/lu23
	+r75LZvPm/Dz7jzSzfF4JduvWA/5iZyn3Gt2W6byZ+n+u1B4QWymev3CsISfgkead/6LSqpy
	atx7KPGlogXf+pqImwuW3YllkvU/Z9D+iO/JlzOzLd+UqS5M+rhk3dkX7/gOVTS7XWGMWDZJ
	I3m5jMphmVMKQjxCR6wq1p2449TUzPP6Ijub/QO9p13bZXYWb1bZ/GzZD+tTV/99+hT8K1nr
	TuQMBf5r0ey1TLnfV536XB+w9fqca1vi3E1jjN+v0n0arj7R59TyND+TnH8uEc98omcuUFFi
	Kc5INNRiLipOBACNd+fGPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnO6rzOhkg74+Vos9/aeYLFbf7Wez
	eH/wMavF4ceT2C1Wrj7KZDHp0DVGizNXF7JYzF/2lN1i3ev3LA6cHufvbWTxuHy21GPTqk42
	j81L6j1232xg8zh3scKjt/kdm8fHp7dYPDafrg7gjOKySUnNySxLLdK3S+DK+H7jCGPBJ7aK
	eavPMjYwnmftYuTkkBAwkbi35RpzFyMXh5DAbkaJf+d72SAS4hLN136wQ9jCEiv/PWeHKHrC
	KPFr03SwBIuAqsTi5jcsXYwcHGwCmhIXJpeChEUEFCXOA90EUs8scINR4vGtzSwgCWEBJ4mt
	CzqZQWxeAR2JS523mCCGdjFKtG3YyAiREJQ4OfMJWAOzgJnEvM0PmUEWMAtISyz/xwES5hQw
	l/jQugPsUFEBZYkD244zTWAUnIWkexaS7lkI3QsYmVcxSqYWFOem5xYbFhjmpZbrFSfmFpfm
	pesl5+duYgTHjpbmDsbtqz7oHWJk4mA8xCjBwawkwnv2RniyEG9KYmVValF+fFFpTmrxIUZp
	DhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUyZr7fdYxVeJVK/OPNH95oPR0ytFm7u19mQ
	cHZZprZO4W0H3cPXY+XD6/xsvNXqEud6bOrMX7Js8m1nJU0Dk1n3n4neyzn3ncNUO9qt5bfi
	9C19nZ83SRVJntzNJHB0ccyWd3uvqwRvTLsVza13U5V3roNCXOGNXzbT5fzvJX1r0Ht77Pxf
	h4Z9287EXszz3n+yrZLX8F8lx9ZpEmdZCzSO/Lo38ZHow3bjpJik958uzJCINFkQt6uWd7Lr
	3Xr2JZUXr2vz5vLOqpk3b/mWONM2yVRpL8VHLjxsbdNsF6rcfSQh1qLmsrDy1bsKZ76Hy8xu
	fy46LB9fNjPzJvOZdKvXfBN2H/guvvT5fOnPkcVKLMUZiYZazEXFiQAnczb6DAMAAA==
X-CMS-MailID: 20221028053434epcas5p4efdc0a0cd03124d104911f12f266fa8f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_9eaa8_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221027151545epcas5p4b0d216b828a5c33ec15ff84e7f847e52
References: <CGME20221027151545epcas5p4b0d216b828a5c33ec15ff84e7f847e52@epcas5p4.samsung.com>
	<20221027150417.1954662-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_223446_429573_1D61E3E4 
X-CRM114-Status: GOOD (  15.26  )
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

------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_9eaa8_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Oct 27, 2022 at 08:04:17AM -0700, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>The driver is spamming the kernel logs for entirely harmless errors from
>user space submitting unsupported commands. Just silence the errors.
>The application has direct access to command status, so there's no need
>to log these.
>
>And since every passthrough command wants the quiet flag, move the
>setting to every user's common initializer.
>
>Cc: Daniel Wagner <dwagner@suse.de>
>Cc: Alan Adamson <alan.adamson@oracle.com>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
>v1->v2:
>
>  Set the quiet flag in the common initializer instead of open coding
>  the flag for each path.

now open coding can be removed in pci.c too. That is still being done at
two places.

With those changes in - 
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_9eaa8_
Content-Type: text/plain; charset="utf-8"


------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_9eaa8_--


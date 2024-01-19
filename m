Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05500C4725D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8cj8yi3f/yHfGmWyRmLF9hRdnCFp9eAZlsSvzZqRGg=; b=ujzgwSuIxY/wEZzzfOIaEbRn4r
	Zdkxjs426UZWi+i/1w1QomyVaz7E51TPd6XXB1QTRUFh42Ud4t4pbnGLfRQU7VQ6eJvVDcoIunTX0
	eAnGY+fUYDhqKFEv66WGjuK1RSTjd+XZ2eGPcLknWTy3AJqL06dQ59pYYqLBDe4YTBv6f/PM9+EpJ
	8LIkUI0vq+Q2unifYQTlbI2v6zYAa5P3neBsv2PmzCksQO+uPgBTOlAeqYeG6QM0qrtyJmS6KgA6N
	stCzCcePhigUVV8x8GolmzYCoaXCBDnTffcVEMsQ85kcrIdH89KM2EI2DP6RrCshclAhA/JhHVICC
	saQW9lNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQlds-0051jP-0U;
	Fri, 19 Jan 2024 09:58:28 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQldm-0051i0-0S
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 09:58:26 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240119095814epoutp01fb990d475446e2b9e2ac95db92e3be61~rty59WDMx2332823328epoutp01X
	for <linux-nvme@lists.infradead.org>; Fri, 19 Jan 2024 09:58:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240119095814epoutp01fb990d475446e2b9e2ac95db92e3be61~rty59WDMx2332823328epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705658294;
	bh=Z8cj8yi3f/yHfGmWyRmLF9hRdnCFp9eAZlsSvzZqRGg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QdPmAUGuK94oO/YGq3Uv6BRjW97EFyCFHopcn0ZgsGFXrFNbeQ929zxuBGTdTVBcb
	 EFmtnhNjiI8dAv7BFf4FLGstGM/FyQdUEaxMctZd6whLzUinZ7ejbkjpcsNta1slfb
	 hh4WHsip4CskhhPbAnYxYTmFyDX2Ot1hI+kqJxXQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240119095813epcas5p33065cc4ff14476102f05bf8b5164fd5f~rty5pl1jT2592325923epcas5p3Q;
	Fri, 19 Jan 2024 09:58:13 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TGZn01Swgz4x9Q1; Fri, 19 Jan
	2024 09:58:12 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E7.6E.08567.4B74AA56; Fri, 19 Jan 2024 18:58:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240119095811epcas5p2155a2273662e73131c45402e9301f094~rty3xRCuz2298822988epcas5p2_;
	Fri, 19 Jan 2024 09:58:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240119095811epsmtrp13b53e0bc56899b1f241820732cf61726~rty3wO1IX1734417344epsmtrp1I;
	Fri, 19 Jan 2024 09:58:11 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-10-65aa47b4c138
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.24.18939.3B74AA56; Fri, 19 Jan 2024 18:58:11 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240119095810epsmtip2f1fef4fdef921138c785fdf354d7754c~rty2TfYIL2428524285epsmtip22;
	Fri, 19 Jan 2024 09:58:10 +0000 (GMT)
Message-ID: <9b0521a9-c0d6-693b-3596-c1110c497173@samsung.com>
Date: Fri, 19 Jan 2024 15:28:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Content-Language: en-US
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, Viacheslav
	Dubeyko <slava@dubeyko.com>
Cc: lsf-pc@lists.linux-foundation.org, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, slava@dubeiko.com, Bart Van Assche
	<bvanassche@acm.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240117115812.e46ihed2qt67wdue@ArmHalley.local>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmhu4W91WpBk1rOCymH1a0mPbhJ7PF
	4zuf2S323tK22LP3JIvF/GVP2S26r+9gs9j3ei+zxafLC4HEltlMDlwel694ezx6cpDV4+D6
	Nywem5fUe0y+sZzRo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
	LS3MlRTyEnNTbZVcfAJ03TJzgG5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
	FOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnLGp1KLglXDHp+zn2BsZv/F2MnBwSAiYSG+etYO5i
	5OIQEtjNKHFo22R2COcTo8SvLYdZQKrAnPebfWE6Lq15yApRtJNRouvRLTYI5y2jRPOFW0Dt
	HBy8AnYS8085gzSwCKhKLFyznw3E5hUQlDg58wnYUFGBJIlfV+cwgpQLC+RItE/xBgkzC4hL
	3HoynwnEFhHIkFj67CULyHhmgdlMEt9edbGC1LMJaEpcmFwKUsMJtGnKt2NMEL3yEs1bZ4N9
	IyGwlENi1qQ2FoijXSRO9bUwQtjCEq+Ob2GHsKUkXva3QdnJEpdmnmOCsEskHu85CGXbS7Se
	6mcG2csMtHf9Ln2IXXwSvb+fMIGEJQR4JTrahCCqFSXuTXrKCmGLSzycsQTK9pD48GQiNGzX
	M0msmHONZQKjwiykUJmF5P1ZSN6ZhbB5ASPLKkbJ1ILi3PTUZNMCw7zUcnhsJ+fnbmIEp1st
	lx2MN+b/0zvEyMTBeIhRgoNZSYSXX3VVqhBvSmJlVWpRfnxRaU5q8SFGU2D0TGSWEk3OByb8
	vJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamA6e/zez3l43bf3H
	4s5d7RmXVuycsMyVNb5X4kr1N9veWbU3zxyR0ktiY9LvPhumKfQonnPig2nXp6+Mv/CTZf3E
	lVf6vzI5PqusXno2sJdZa3fmhqBAndYtd18fceTUC59uuN7PceFV3+1WHVdWzLqoczxoUl2T
	m/flHdxL5XVmZSzzzezYOv2efI230eJnKYsvhJdoXOO9f9qW/XFS2frcvQ9meeiL+jbc/3zk
	DgfvAfWg6qnJhiLvN3FmNj06cmLKTqbL/f83V4kVcC6VjztbP/mgzf4ow7ePmOI1q5e9tvwW
	HHs9T18nO+ebUc1OzRn6se82Mxf0Ltp/6WRSwhqhPW3c5RG/pnwK+Vn+4Y4SS3FGoqEWc1Fx
	IgA8TVaoQAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXnez+6pUg97TehbTDytaTPvwk9ni
	8Z3P7BZ7b2lb7Nl7ksVi/rKn7Bbd13ewWex7vZfZ4tPlhUBiy2wmBy6Py1e8PR49OcjqcXD9
	GxaPzUvqPSbfWM7o0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmLWh0KbglXTPp+jr2B8Rt/
	FyMnh4SAicSlNQ9Zuxi5OIQEtjNK9J2+xgyREJdovvaDHcIWllj57zk7RNFrRollJ3YDORwc
	vAJ2EvNPOYPUsAioSixcs58NxOYVEJQ4OfMJC4gtKpAksed+IxNIubBAjkT7FG+QMDPQ+FtP
	5jOB2CICGRI/Pz5nARnPLDCbSeLqxwmMELvWM0lsf/2WFaSZTUBT4sLkUpAGTqC1U74dY4IY
	ZCbRtbWLEcKWl2jeOpt5AqPQLCRnzEKybxaSlllIWhYwsqxiFE0tKM5Nz00uMNQrTswtLs1L
	10vOz93ECI4qraAdjMvW/9U7xMjEwXiIUYKDWUmEl191VaoQb0piZVVqUX58UWlOavEhRmkO
	FiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDk6vtckOW1GO++6ffcmsOTn3Or624pHiRH49r
	7/l1zJN7zIXuSknsPj7nhszZJPfKqYltK97Vrf5qxCL6LrnihJvcw6uq0tt7C//uzVs+m+Uc
	931rp51Z+6/pbG02vrlf5MbXXwKzKmcZBOVGsi+tidw+QW771+5vXf1qUsc+Pd90p2WidIzV
	mlMGXLuzODriEw894Pg1MzLSlyGntfbd5Jv6Je96E0+prfli/PZ7zZ2gJVOlvvyR4kjWVjBw
	0NrcyzHBreDZ/yOzeepjZodXlBTNWN7eF54Xt3HBjebYcIuSNaHstmdrn50/1lf/Y+erdAG3
	3siENzNOXM7N2JZQ/ims7v2jn+FaKrpuXNuPKLEUZyQaajEXFScCAGcPtaAZAwAA
X-CMS-MailID: 20240119095811epcas5p2155a2273662e73131c45402e9301f094
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
	<20240115084631.152835-1-slava@dubeyko.com>
	<20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
	<86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
	<20240117115812.e46ihed2qt67wdue@ArmHalley.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_015823_651191_F0C1C777 
X-CRM114-Status: GOOD (  20.27  )
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

On 1/17/2024 5:28 PM, Javier González wrote:
> On 16.01.2024 11:39, Viacheslav Dubeyko wrote:
>>
>>
>>> On Jan 15, 2024, at 8:54 PM, Javier González 
>>> <javier.gonz@samsung.com> wrote:
>>>
>>> On 15.01.2024 11:46, Viacheslav Dubeyko wrote:
>>>> Hi Javier,
>>>>
>>>> Samsung introduced Flexible Data Placement (FDP) technology
>>>> pretty recently. As far as I know, currently, this technology
>>>> is available for user-space solutions only. I assume it will be
>>>> good to have discussion how kernel-space file systems could
>>>> work with SSDs that support FDP technology by employing
>>>> FDP benefits.
>>>
>>> Slava,
>>>
>>> Thanks for bringing this up.
>>>
>>> First, this is not a Samsung technology. Several vendors are building
>>> FDP and several customers are already deploying first product.
>>>
>>> We enabled FDP thtough I/O Passthru to avoid unnecesary noise in the
>>> block layer until we had a clear idea on use-cases. We have been
>>> following and reviewing Bart's write hint series and it covers all the
>>> block layer and interface needed to support FDP. Currently, we have
>>> patches with small changes to wire the NVMe driver. We plan to submit
>>> them after Bart's patches are applied. Now it is a good time since we
>>> have LSF and there are also 2 customers using FDP on block and file.
>>>
>>>>
>>>> How soon FDP API will be available for kernel-space file systems?
>>>
>>> The work is done. We will submit as Bart's patches are applied.
>>>
>>> Kanchan is doing this work.
>>>
>>>> How kernel-space file systems can adopt FDP technology?
>>>
>>> It is based on write hints. There is no FS-specific placement decisions.
>>> All the responsibility is in the application.
>>>
>>> Kanchan: Can you comment a bit more on this?

Application-specific placement (with write-hints) is almost 
FS-independent, and some applications (that require more control or 
predictable outcomes across file systems) prefer that.
It also punts the responsibility of accuracy on the application side 
(and kernel prefers that at times).

FS-specific placement is the next step, but it needs to be 
discussed/done at each FS level. The effort (and likely outcome, too) 
will vary.

Also, we will need to avoid the hint collision between the user and 
kernel. Either by extending/reserving a different range of hints 
exclusively for in-kernel use or take the F2FS approach (i.e., mount 
option that keeps hints for the user or FS use but not both).


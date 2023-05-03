Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DDBC77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PX80pXyrz5Pk/LGoddm1Q+DUvFTMdVIqX7qjN4s8Mf0=; b=KBzn28mRlAYVZyl8t350MrtlUp
	80CIFewFdevpcx0GWQoLWrYs2gFZY7ldTuUxp5aiPqCbVMwuIWZ3SzBWaD3AFVRyk5ClQCsrZ6DMD
	kxVidkheLri63xu1B8YdXLjPkaf77Kz3e94eWIW4Q2Gwl3iaQx5XvH4+mf4fOw9EVYjb4DAG33R+e
	EU6TWJRF1yr+OBNpfOe5rFDYlLQbDekal3i+e1K6GA07wZ0GQ5KxP8KhCUaiXq+RAdXwOKIVDgJLT
	LGwTc+RSBdBK9rTabZqKHze9P6bsGNZK1Xv8zi6sX2Idio7wWu0UrlyobaMaGBnzVbRxj31gS6KcY
	TA4Bs5Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu6wU-003fFg-0j;
	Wed, 03 May 2023 07:30:26 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu6wR-003fDe-0H
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 07:30:25 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230503073016epoutp04b61992002c1d44878109cb18c6e95537~bkaNdCjoA0508805088epoutp04D
	for <linux-nvme@lists.infradead.org>; Wed,  3 May 2023 07:30:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230503073016epoutp04b61992002c1d44878109cb18c6e95537~bkaNdCjoA0508805088epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1683099016;
	bh=PX80pXyrz5Pk/LGoddm1Q+DUvFTMdVIqX7qjN4s8Mf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qnQXb0fMU2siOFFr44T5ce/NvMHKEon3DZIS6f17dlA9MxncKBRW8wko1rdjmDCec
	 FVvZp8AhIlRdDe87yP8VKDmdqH0lNydREWqQMaNPR6MWfPMuIsif3WTYC//kyhaAnx
	 6U8rfb25blGskA6C/HMUDPhfC8xvUJlysCjVTVyM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230503073016epcas5p2527fa05cf2c458dba83430f14f265a5c~bkaNL_GQ42217122171epcas5p28;
	Wed,  3 May 2023 07:30:16 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4QB7rl0brCz4x9Q1; Wed,  3 May
	2023 07:30:15 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.A7.55646.68D02546; Wed,  3 May 2023 16:30:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230503073014epcas5p4bffb8eff90ccaac5dcf94b1048b512a0~bkaLkk_Yk3190531905epcas5p41;
	Wed,  3 May 2023 07:30:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230503073014epsmtrp15154f407959302115b23b73f53a8d35d~bkaLjwarb0383503835epsmtrp12;
	Wed,  3 May 2023 07:30:14 +0000 (GMT)
X-AuditID: b6c32a4b-913ff7000001d95e-57-64520d869afc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	3D.71.28392.68D02546; Wed,  3 May 2023 16:30:14 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230503073013epsmtip2a41d5816231594b84091f170eef47d86~bkaKZvW_r1202912029epsmtip2a;
	Wed,  3 May 2023 07:30:13 +0000 (GMT)
Date: Wed, 3 May 2023 12:57:17 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, xiaoguang.wang@linux.alibaba.com, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [RFC 0/3] nvme uring passthrough diet
Message-ID: <20230503072625.GA18487@green245>
MIME-Version: 1.0
In-Reply-To: <20230501153306.537124-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmpm47b1CKwZ8uRovVd/vZLFauPspk
	MenQNUaLM1cXsljsvaVtMX/ZU3aLTX9PMjmwe1w+W+qxaVUnm8fOh5Yem5fUe+y+2cDmce5i
	hcfnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
	mTlAtygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwN
	DIxMgQoTsjM2/F7AXPBXtOLizR2MDYwdQl2MnBwSAiYSzYfvM3cxcnEICexmlJh4eB4ThPOJ
	UWLujKWsEM5nRok53buZYVq23/rECJHYxShxe9U6qP5njBKb171iAqliEVCR+Hl0BVA7Bweb
	gKbEhcmlIGERAUWJ88BQAKlnFljMKNHxbi4rSEJYwEjiZMMesA28AroSm148ZoKwBSVOznzC
	AmJzCphJdPX/B6sRFVCWOLDtONitEgKtHBJd83azQZznIrH/3kkmCFtY4tXxLewQtpTEy/42
	KDtZ4tLMc1A1JRKP9xyEsu0lWk/1gy1gFsiQuD/tIjuEzSfR+/sJE8gzEgK8Eh1t0MBTlLg3
	6SkrhC0u8XDGEijbQ2Lfjc3skEDpZJQ49ug32wRGuVlI/pmFZAWEbSXR+aGJdRbQCmYBaYnl
	/zggTE2J9bv0FzCyrmKUTC0ozk1PLTYtMM5LLYfHcnJ+7iZGcPrU8t7B+OjBB71DjEwcjIcY
	JTiYlUR4PxT6pQjxpiRWVqUW5ccXleakFh9iNAXGz0RmKdHkfGACzyuJNzSxNDAxMzMzsTQ2
	M1QS51W3PZksJJCeWJKanZpakFoE08fEwSnVwOSyZjXvD+b7ncsT5zaaHy3fESvRdOauYsNM
	7bbVM+a7PFv8vzf/Ouu2MKNYfwGrqh8TvcJNg659enOD/fRXNim7eP/CljuFZww/6/FKKM9R
	4NXwYL3naDPloPzN2KfHDvAHcTZqLo43bzLaZfZRaOmvAFmm24dWpjJbSMdday8KlU4N7XS7
	uuG5zrtV6stT5O8znkmt3sd2XNn3s+OepnaJvYalFwparOwm6eivyHywe3mkoZV3RtmNztuz
	JhVz9h9ke7lpToqPUum8loPX8uav/SWzI4kpSc93Ig/DqcDrHT6JU5J2Xb2fqyeeH/vt/puW
	TNtK2WNqh1b5JZie4/ovrHyN8UJyivHL7sRLSizFGYmGWsxFxYkAD778NygEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvG4bb1CKwedLUhar7/azWaxcfZTJ
	YtKha4wWZ64uZLHYe0vbYv6yp+wWm/6eZHJg97h8ttRj06pONo+dDy09Ni+p99h9s4HN49zF
	Co/Pm+QC2KO4bFJSczLLUov07RK4Mm7Ne8desF644nXvY+YGxiv8XYycHBICJhLbb31i7GLk
	4hAS2MEosX/xA3aIhLhE87UfULawxMp/z9khip4AFR1YzgSSYBFQkfh5dAVrFyMHB5uApsSF
	yaUgYREBRYnzQJeA1DMLLGaU2Nj5lxEkISxgJHGyYQ8ziM0roCux6cVjJoihnYwSN7etZYFI
	CEqcnPkEzGYWMJOYt/khM8gCZgFpieX/OEDCnEDhrv7/YHNEBZQlDmw7zjSBUXAWku5ZSLpn
	IXQvYGRexSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHA9aWjsY96z6oHeIkYmD8RCj
	BAezkgjvh0K/FCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4
	pRqYFn0/4SEtaOkhwvqWqf/A0j98hgpBuhoNyQGrSmrezLpUtKhdyigi7PTzey4zqgU+sc9V
	Px+sq518K6V7RftW77mMB9a4aXs3BraX/TL+X/SpZdYT5Rgb8e06XCJ1M2K2a8ycdzpce4pr
	VcuteMkFPerblUK6drV9W5moYCDzw7eC2fLjpnoJT5GeSe31+5OL/Puq/E97K1tO/y/K6Zub
	Z/r/73PuytXrZ7ls3OXxSniJfA7PtQVLQoKmbLkutb1aQzRk5/XnfVktfWd2799ygnVH8Ybi
	Az0nndYlFxxfXBDQ39XlxlbuPCORd02DOI/p7MW9otsmPG22N9zH1rryvPGjlXu8HL9c/qVl
	UKrEUpyRaKjFXFScCAA3qU5H9gIAAA==
X-CMS-MailID: 20230503073014epcas5p4bffb8eff90ccaac5dcf94b1048b512a0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----fzg6GfPKCulTz7v5vTU-rVtg6j3uQrp2-IaGXZnwsLp_SU4m=_62827_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230501154403epcas5p388c607114ad6f9d20dfd3ec958d88947
References: <CGME20230501154403epcas5p388c607114ad6f9d20dfd3ec958d88947@epcas5p3.samsung.com>
	<20230501153306.537124-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_003023_674531_390362AF 
X-CRM114-Status: GOOD (  22.04  )
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

------fzg6GfPKCulTz7v5vTU-rVtg6j3uQrp2-IaGXZnwsLp_SU4m=_62827_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, May 01, 2023 at 08:33:03AM -0700, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>When you disable all the optional features in your kernel config and
>request queue, it looks like the normal request dispatching is just as
>fast as any attempts to bypass it. So let's do that instead of
>reinventing everything.
>
>This doesn't require additional queues or user setup. It continues to
>work with multiple threads and processes, and relies on the well tested
>queueing mechanisms that track timeouts, handle tag exhuastion, and sync
>with controller state needed for reset control, hotplug events, and
>other error handling.

I agree with your point that there are some functional holes in
the complete-bypass approach. Yet the work was needed to be done
to figure out the gain (of approach) and see whether the effort to fill
these holes is worth.

On your specific points
- requiring additional queues: not a showstopper IMO.
  If queues are lying unused with HW, we can reap more performance by
  giving those to application. If not, we fall back to the existing path.
  No disruption as such.
- tag exhaustion: that is not missing, a retry will be made. I actually
  wanted to do single command-id management at the io_uring level itself,
  and that would have cleaned things up. But it did not fit in
  because of submission/completion lifetime differences.
- timeout and other bits you mentioned: yes, those need more work.

Now with the alternate proposed in this series, I doubt whether similar
gains are possible. Happy to be wrong if that happens.
Please note that for some non-block command sets, passthrough is the only
usable interface. So these users would want some of the functionality
bits too (e.g. cgroups). Cgroups is broken for the passthrough at the
moment, and I wanted to do something about that too.

Overall, the usage model that I imagine with multiple paths is this -

1. existing block IO path: for block-friendly command-sets
2. existing passthrough IO path: for non-block command sets
3. new pure-bypass variant: for both; and this one deliberately trims all
the fat at the expense of some features/functionality.

#2 will not have all the features of #1, but good to have all that are
necessary and do not have semantic troubles to fit in. And these may
grow over time, leading to a kernel that has improved parity between block
and non-block io.
Do you think this makes sense?

------fzg6GfPKCulTz7v5vTU-rVtg6j3uQrp2-IaGXZnwsLp_SU4m=_62827_
Content-Type: text/plain; charset="utf-8"


------fzg6GfPKCulTz7v5vTU-rVtg6j3uQrp2-IaGXZnwsLp_SU4m=_62827_--


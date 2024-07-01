Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9695CC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 07:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WWxKY9oZHJuFLW7GFgRgK3KCqiFp5Mp6py/ldwZb0+4=; b=i+13gv8py4coU1ujgDsvQWWk2E
	1h7Ha3anQl0QRjact2iXxpS5/jjaFAOR9a8hzim/L+ic3ijKC/a4rpl3Z8q1YGL8tgnJBIXbvNOp+
	hRUX9Ey70CZPJ6szFcUuly6S9AmLJo1TNsIGMQxrUUvKVngGcJfvCOxXA2D9WBtDe6KssyUYK800j
	Zwv5sgThYddV73atjYT5EWod6fVvUjTuni99YSP13CKbvH4YnYy5CEZcRs6H0Dty2MCBED0HQKZ9r
	D4xjvZu8viF9sAUvhH9fvC2P6s15ekMxGV1LpFon/AV+o/ZhCKgT3puU4X8iHloiHEZ064n/J3WgT
	S1D/83PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBWg-000000022u1-2BMK;
	Mon, 01 Jul 2024 07:32:38 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBWX-000000022kT-2YEu
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 07:32:34 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240701073221epoutp03b0c4a9fef0d134647e662d4ea1b5a9ff~eBmW5OkBX2251322513epoutp03b
	for <linux-nvme@lists.infradead.org>; Mon,  1 Jul 2024 07:32:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240701073221epoutp03b0c4a9fef0d134647e662d4ea1b5a9ff~eBmW5OkBX2251322513epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719819141;
	bh=WWxKY9oZHJuFLW7GFgRgK3KCqiFp5Mp6py/ldwZb0+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idF4f0Xiqo7+NthdZVlic2KC/dFKGWHa711zJne34VwXuh1dyvTA3PtyrB2Zml9O5
	 BRrd7ikhtFSowscKS27GrjzA3Cg+ozx26VhsZfHzmJYaRuSC+4tIn4DEW1bNIUgeG9
	 2zcJbyLtDp0LOmd9LWWLivVrOjO3V/2W1t/1KAWA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240701073221epcas5p10f0caa3928d8dfbd1ea0b307ed09c781~eBmWqBc9E1699116991epcas5p10;
	Mon,  1 Jul 2024 07:32:21 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WCHn00t4vz4x9Pw; Mon,  1 Jul
	2024 07:32:20 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.2B.07307.28B52866; Mon,  1 Jul 2024 16:32:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240701073115epcas5p3e2758375e272cba80281fe0ac37394d0~eBlZdJv7g3170731707epcas5p3c;
	Mon,  1 Jul 2024 07:31:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240701073115epsmtrp1a718b5b491b28138bfef63f31c6f7263~eBlZcZpUS0471704717epsmtrp1E;
	Mon,  1 Jul 2024 07:31:15 +0000 (GMT)
X-AuditID: b6c32a44-3f1fa70000011c8b-7f-66825b8264ce
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.9A.19057.34B52866; Mon,  1 Jul 2024 16:31:15 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240701073113epsmtip202f1b5eb771d3ad76dc6fca5098d946d~eBlXyDV_J1952619526epsmtip2J;
	Mon,  1 Jul 2024 07:31:13 +0000 (GMT)
Date: Mon, 1 Jul 2024 12:54:05 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: io_opt fixups
Message-ID: <20240701072405.pnlqogwgyw52xwk3@nj.shetty@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmpm5TdFOawbfr0har7/azWaxcfZTJ
	YtKha4wWe29pW8xf9pTdYvnxf0wW616/Z3Fg9zh/byOLx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPD5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ
	0HXLzAG6RkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1pi
	ZWhgYGQKVJiQnTH1aF7BDPaKs6t+MTcwtrJ1MXJySAiYSCxY9Y65i5GLQ0hgN6PE3juTGSGc
	T4wSl07OZINwvjFK/Jn7jBGm5c/EDqiqvYwSL861MEE4nxkldmx6xA5SxSKgIrHh4EeWLkYO
	DjYBbYnT/zlAwiICShJPX50Fa2YWuMUoca/rP1i9sICUxKZtc5hA6nkFnCX+n1IACfMKCEqc
	nPmEBcTmFDCSONe6hBWkV0LgJ7vEiTVbWSAucpE4d6iJHcIWlnh1fAuULSXxsr8Nyi6XWDll
	BRtEcwujxKzrs6DesZdoPdXPDLKYWSBDYvlSLoiwrMTUU+uYQGxmAT6J3t9PmCDivBI75sHY
	yhJr1i+ABqSkxLXvjVC2h8T5lU3QQGlllFj/7CbbBEa5WUgemoWwbhbYCiuJzg9NrBBhaYnl
	/zggTE2J9bv0FzCyrmKUTC0ozk1PTTYtMMxLLYfHcXJ+7iZGcPrUctnBeGP+P71DjEwcjIcY
	JTiYlUR4A3/VpwnxpiRWVqUW5ccXleakFh9iNAVGz0RmKdHkfGACzyuJNzSxNDAxMzMzsTQ2
	M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgenZvZnV2WtuupVbyr9avMbd1/Ifa7Gt7ak/
	j98+2fj0tx1Tq+HrtXO9t9uyGmy+o88Wv1X/rPGF/Nvr976690wtjG+z/K9y3d7ovIYE79aA
	pjzD/WtdX26+Inv4ZdOWsv3S6/UmMzwqLxdlvfnP+7T+zUk1LL8mup5sLMgpuatqtUjvkBjT
	fGObT+zHNLxv+zlmb7nzs/z/ymlav56r6HX+OipnZ/53S2HNEnWpAMPqidM3rGG/uvHuvsuc
	WgzLHus+vrSZ7cun7gT/G9EaskJmW4Lvnnll0BDDu/iizvG7Qjq2Vr3GOrdWMenNrlrLYd0+
	aUH25wuHdlnNlNwyf2HvXI65B7avSJ8/VWnHihf3lViKMxINtZiLihMBj/RdBygEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvK5zdFOawd7jKhar7/azWaxcfZTJ
	YtKha4wWe29pW8xf9pTdYvnxf0wW616/Z3Fg9zh/byOLx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPD5vkgtgj+KySUnNySxLLdK3S+DKeDq1iangFEvFj46fjA2MF5m7GDk5JARMJP5M7GDs
	YuTiEBLYzShxYcV1doiEpMSyv0egioQlVv57DhYXEvjIKNH5qQDEZhFQkdhw8CNLFyMHB5uA
	tsTp/xwgYREBJYmnr84ygtjMArcYJfZ9VAaxhQWkJDZtm8MEUs4r4Czx/5QCxERDicMrd4Jt
	4hUQlDg58wkLRKuZxLzND5lBypkFpCWW/wObzilgJHGudQnrBEaBWUg6ZiHpmIXQsYCReRWj
	ZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDIa2ntYNyz6oPeIUYmDsZDjBIczEoivIG/
	6tOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi4JRqYGo0bhLL
	aBUvv5eZ7CDzIiWmy8Xws9bOEtXt7aYXq7i5FhyeVfj24/Pj22/4mM1t3cB/skzEw/nA+yo9
	3vUfFZ6bfzs5acKGSVd2VRnvmGhysPIHm83TgooITjH1G9VGp6O25cwRzM+STcspyLnnulV5
	WdqULkFjWRH39VMvHd9wdl3evNMBlyre7j3Mb+Ac8Gfq/v/y7MGsPOdVEisT9qj8jEqZVeH8
	Uy1CdMrRrYKy0k9UotWjvMVcpzTwMHxL+Vm8u/5g3psDKvfV4xdL92QULUjYpGV4SmNL92XG
	hcrRO97snn7QqeSR0j/vsDzGC93cu+76yxwsD5Ju6LdfeG2fzOH29snyKgUH6/bXKrEUZyQa
	ajEXFScCAGZzINfoAgAA
X-CMS-MailID: 20240701073115epcas5p3e2758375e272cba80281fe0ac37394d0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_a96da_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240701073115epcas5p3e2758375e272cba80281fe0ac37394d0
References: <20240701051800.1245240-1-hch@lst.de>
	<CGME20240701073115epcas5p3e2758375e272cba80281fe0ac37394d0@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_003230_322053_FE0D3A28 
X-CRM114-Status: GOOD (  14.58  )
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

------LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_a96da_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 01/07/24 07:17AM, Christoph Hellwig wrote:
>Hi all,
>
>I recently noticed that on my test VMs with the Qemu NVMe emulations I
>see a zero max_setors_kb limit in sysfs.  It turns out Qemu advertises
>a one-LBA optimal write size, which is a bit silly.
>
>This series handles this odd case properly both in the block layer and
>the nvme driver as a sort of defense in depth.
>
>Diffstat:
> block/blk-settings.c     |    5 ++---
> drivers/nvme/host/core.c |    3 ++-
> 2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_a96da_
Content-Type: text/plain; charset="utf-8"


------LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_a96da_--


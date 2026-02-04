Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D3E6E815
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 06:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y2frTBlrPcApGJAKcojyrODxcLgxJHU1QEnp9KWJoZE=; b=wIraHaSz6FSmSF2IxoPUpiZUBW
	FnzeMVCLOi+eQAE1U3820y3ywp+wzWHDcawUF9W7lAYmnsDqfkaGkzDgCMsVH8s4BUHEeGaUfKOu3
	0smNcChR/11UCNe2lOhF72HPPOaM/KMEAUcSIXRiMHtQkPkfAFWiNWjW20lISdAnrawsS1bxhA6sR
	UZSRgioNSBQiltouSwku5fa4UUii2Xy/WVPAwDWVTOeHp8kK/+iMWITUiCnUjY1qPbVfI0fXcYTpP
	D3zi7294/SpOMnedDgmvnR2NOB9GyfdKNDRwcN+oQLdcZEJFB8sgaQxIkl6GSYB7DqVyK9Nh7v9e7
	Ho/jQz+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnW3B-00000007z0W-3OuE;
	Wed, 04 Feb 2026 06:07:41 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnW38-00000007yzW-2CCv
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 06:07:40 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260204060727epoutp03cbc4d9ffd88527d5e873ac78cf7baaae~Q9hqm8-Ok2403824038epoutp03F
	for <linux-nvme@lists.infradead.org>; Wed,  4 Feb 2026 06:07:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260204060727epoutp03cbc4d9ffd88527d5e873ac78cf7baaae~Q9hqm8-Ok2403824038epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770185247;
	bh=y2frTBlrPcApGJAKcojyrODxcLgxJHU1QEnp9KWJoZE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NhzBjLSHtZQSQfwpotD0ry+Zimlaaw5fqm639OJbdbhO5fR5z5AnqlhFlOCe902o8
	 frZCx7w8qfrbc9ahl5e4C1eLYZNUptEigCQ8ZEOyCMxJPQOOiJ1ezeBjZ7cSv9MUPd
	 pWrdY+SkrHWCbDZFh9P9kvzipTxVl2Dyw8JReVZ8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260204060727epcas5p232ff332ff546f37733e37b0c13d6cada~Q9hqaEc0W0625406254epcas5p2u;
	Wed,  4 Feb 2026 06:07:27 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f5VHy44lQz2SSKd; Wed,  4 Feb
	2026 06:07:26 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260204060726epcas5p3816adfde071ae343471ac7a6a33a0e82~Q9ho7YiaV1775217752epcas5p3N;
	Wed,  4 Feb 2026 06:07:26 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260204060722epsmtip24e8143a262629db8288b2256b0e51ace~Q9hlWsA3n1083210832epsmtip2D;
	Wed,  4 Feb 2026 06:07:22 +0000 (GMT)
Message-ID: <beb2ebf6-8207-4bbe-a77c-ccb09e2d841e@samsung.com>
Date: Wed, 4 Feb 2026 11:37:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Christoph
	Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <aYI5S1puAZ-rPvlC@kbusch-mbp>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260204060726epcas5p3816adfde071ae343471ac7a6a33a0e82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260203180716epcas5p1c9658e583e26197b515f6db07a100aa9
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
	<CGME20260203180716epcas5p1c9658e583e26197b515f6db07a100aa9@epcas5p1.samsung.com>
	<aYI5S1puAZ-rPvlC@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_220739_062679_5B74B2A6 
X-CRM114-Status: GOOD (  13.29  )
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

On 2/3/2026 11:37 PM, Keith Busch wrote:
> Thanks for submitting the topic. The performance wins look great, but
> I'm a little surpised passthrough didn't show any difference. We're
> still skipping a bit of transformations with the dmabuf compared to not
> having it, so maybe it's just a matter of crafting the right benchmark
> to show the benefit.
> 

Those numbers were from a drive that saturates at ~5M IOPS, 
sopassthrough didn’t have much headroom. I did a quick run with two such
drives and saw a small improvement (~2–3%): ~5.97 MIOPS -> ~6.13 MIOPS,
but I’ll try tweaking the kernel config a bit to see if there’s more
headroom.

+1 on the topic - I'm interested in attending the discussion and
reviewing/testing v3 when it lands.

Thanks,
Anuj


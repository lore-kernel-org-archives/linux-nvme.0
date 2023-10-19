Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EFECDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 09:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oSzAHDDxaLX8sQ1eCR2Nn3PPW5pgHEkLTuX8/DLLGy0=; b=y+mvjbeHXNSkzp8/2fzgeN711f
	ZU6zw/hpUDnGX12s+NTavjEDPuEkMFQqdTtjq0HUiHCoW0ggNR8ILXXA8fk9bQLYx7UvHgLRjy4bt
	EOOd8+gicnGuWQbvxLOcvbv5bKD7Qqlmi/NwuU10lAFiidVFv5MCkHA6HG+3gnIjs1MWpthw2fNtE
	VnoaXbT8SjVnUFiwvbiOod4Kp+sWqms2MJ5Usqn9D2GNlk6V8sqXKXf9YSzW1BwyuzXlg6N/dkNZF
	NBdK9tFg3rN6zL6heRX2oSVZHTyMYLFauJqDk9OzqbPp4jCawpZN0DYBd5dapSNDRetltAcrYC4rW
	BV6+PR1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtPjz-00GsyC-1a;
	Thu, 19 Oct 2023 09:54:55 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtPjw-00Gsxa-0G
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 09:54:54 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231019095439epoutp02c69af0514d171297ce73cbbf3bb82681~PeZhVWZHi1460614606epoutp02Y
	for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 09:54:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231019095439epoutp02c69af0514d171297ce73cbbf3bb82681~PeZhVWZHi1460614606epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697709279;
	bh=oSzAHDDxaLX8sQ1eCR2Nn3PPW5pgHEkLTuX8/DLLGy0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Q2RY2ex7nNWmlTnnQOO8clQQ9nYXs9VJ5RgdHNlLHZn6XU7d4JSc0qY7CyttzgVPl
	 USxNQcaHQaZqpZEYwgEGg/NlnD4pdDj9CVD6aM+buEpl5dxkUu+JPEKhSR58TV16nx
	 57/qVly4OrI3r3/uIusUQdcVOjGZDcv/c/fDTYIw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231019095435epcas5p2ce8f5aa1dcf4477362bad6bb9f921852~PeZdP560w3185231852epcas5p2c;
	Thu, 19 Oct 2023 09:54:35 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SB33F50PNz4x9Q0; Thu, 19 Oct
	2023 09:54:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.79.19369.9DCF0356; Thu, 19 Oct 2023 18:54:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231019095433epcas5p3cadb8101d3518b0f0380c86c93f12155~PeZbf3Tr50543105431epcas5p3r;
	Thu, 19 Oct 2023 09:54:33 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019095433epsmtrp205cb7c197d1c4739e58ab1be4cfcaa45~PeZbfOd_70563005630epsmtrp2d;
	Thu, 19 Oct 2023 09:54:33 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-b7-6530fcd9fe16
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.44.07368.9DCF0356; Thu, 19 Oct 2023 18:54:33 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019095432epsmtip1b6148f4c5c9428da0ead45265d250008~PeZaTYkzA1565615656epsmtip1R;
	Thu, 19 Oct 2023 09:54:32 +0000 (GMT)
Message-ID: <69b600aa-4669-0afb-467f-996ef30a358f@samsung.com>
Date: Thu, 19 Oct 2023 15:24:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] nvme-pci: meta-transfer via sgl
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231019054846.GG14346@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmuu7NPwapBne+q1usvtvPZnHzwE4m
	i5WrjzJZnH97mMli0qFrjBbzlz1lt1j3+j2LA7vHzll32T3O39vI4nH5bKnHplWdbB6bl9R7
	7L7ZwObRt2UVYwB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
	i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
	1BIrQwMDI1OgwoTsjN4v21gKurgqZh7Zw9LAeJG9i5GDQ0LARGLBtNAuRi4OIYE9jBJ7lx9l
	h3A+MUq8mDETyvnGKLFk1n2mLkZOsI7t8w6zQiT2MkpM2XiLDcJ5yygx89oGdpAqXgE7iQsX
	drGC2CwCqhL/jnYxQcQFJU7OfMICYosKJEn8ujqHEcQWFrCQ6P13HayXWUBc4taT+WD1IgJK
	Ek9fnWUEWcAs0Moo8fnXGjaQw9kENCUuTC4FqeEU0JHY+W0nM0SvvMT2t3OYQeolBKZySOy4
	ep0F4mwXib3bljJD2MISr45vYYewpSQ+v9vLBmEnS1yaeQ7qzRKJx3sOQtn2Eq2n+plB9jID
	7V2/Sx9iF59E7+8nTJBw5JXoaBOCqFaUuDfpKSuELS7xcMYSKNtD4tqFq4yQsLrNKPHj9TLm
	CYwKs5CCZRaS92cheWcWwuYFjCyrGKVSC4pz01OTTQsMdfNSy+Exnpyfu4kRnF61AnYwrt7w
	V+8QIxMH4yFGCQ5mJRFeVQ+DVCHelMTKqtSi/Pii0pzU4kOMpsAImsgsJZqcD0zweSXxhiaW
	BiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1MLEs3WcRt/NNI+/zg7cWv7Nr
	n9N0vpld/vfBKan/JB1t3n930RPTO2xSUrDuXPX/qWV3fpikuS3dc0FS0NU3KD6rsZf3nNIJ
	LzvGTO0w+5ZdTVsPbFRqvmbEsT/m2+vODSpKrT0TeW5cqlEQlPMNmty1d/6+B+3sWT9WXzY9
	fdP/kXicnF29u9bkAxO/bzvep8eoq/al4Z+QXWRRz7Gup0den+fZpPO2b4dMdDpv+uXt94Uu
	vW5gXx5k+F70gHDwhLtiD9dvfnR2/pEUz8Pa6gflLt54pf6MdaHyTdubAcYdsr8Xv+2brMXf
	FL3K7vGq6kC28sv7z8xKTa7d4Zy0do0gl9bsyMZdERf3b3mzcZkSS3FGoqEWc1FxIgA8RyPB
	OAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnO7NPwapBt9fC1qsvtvPZnHzwE4m
	i5WrjzJZnH97mMli0qFrjBbzlz1lt1j3+j2LA7vHzll32T3O39vI4nH5bKnHplWdbB6bl9R7
	7L7ZwObRt2UVYwB7FJdNSmpOZllqkb5dAldG75dtLAVdXBUzj+xhaWC8yN7FyMkhIWAisX3e
	YdYuRi4OIYHdjBJNpyewQiTEJZqv/YAqEpZY+e85O0TRa0aJGbf2MIEkeAXsJC5c2AXWwCKg
	KvHvaBdUXFDi5MwnLCC2qECSxJ77jWBxYQELid5/18GGMgMtuPVkPlhcREBJ4umrs4wQ8VZG
	idcXtEFsIYHbjBKr2sq6GDk42AQ0JS5MLgUJcwroSOz8tpMZotxMomtrF1SrvMT2t3OYJzAK
	zUJyxSwk22YhaZmFpGUBI8sqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzgONLS2MF4
	b/4/vUOMTByMhxglOJiVRHhVPQxShXhTEiurUovy44tKc1KLDzFKc7AoifMazpidIiSQnliS
	mp2aWpBaBJNl4uCUamDq2bP14NkpS1bmJmbfYGqIl723onPRkkn8tw5PNYmLMBc05jIq+6N3
	qsr34ek7TR9brr/NOCtev9PplujuYyYvGlhNHOcFct3YWt53K/7jQdMN31K3XDGUc/6+/qdM
	NnND3+HCqY4RLjMuSn2q601YwODba1J/zrt99U6Zb1PTbX48OfTo665lRxSPhuv8qeSd9otD
	4tvnd1ZKfhKW8e8mllZvXrPnbOCNb5pVqzv3rriv++vqhPNd+k1Ja/y8vN9v02F9/M+dlbf/
	1pcLLbt83qy+GHdLPWbaERbz0C/WdWciPOPYdVZPK2sKNXw4ZVr6isXTM71fHvgTuXH9lL+C
	q16vncMS9+VY0Gtxk5rDv5VYijMSDbWYi4oTAWGLFwgSAwAA
X-CMS-MailID: 20231019095433epcas5p3cadb8101d3518b0f0380c86c93f12155
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018183625epcas5p4d79f229a097cc083c2a2d2c77f6a5bb9
References: <20231018183003.41174-1-joshi.k@samsung.com>
	<CGME20231018183625epcas5p4d79f229a097cc083c2a2d2c77f6a5bb9@epcas5p4.samsung.com>
	<20231018183003.41174-2-joshi.k@samsung.com> <20231019054846.GG14346@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_025452_643630_FC7D93B1 
X-CRM114-Status: GOOD (  16.26  )
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

On 10/19/2023 11:18 AM, Christoph Hellwig wrote:
> On Thu, Oct 19, 2023 at 12:00:02AM +0530, Kanchan Joshi wrote:
>> Introduce the ability to transfer the metadata buffer using sgl.
>> Also add a nvme request flag 'NVME_REQ_FORCE_SGL' that mandates both
>> data and meta transfer via sgl.
> 
> That's really two different changes, that should be separate patches.

Do you mean a separate patch with just this flag?

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..58f8efe1ace9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -184,6 +184,7 @@ enum {
         NVME_REQ_CANCELLED              = (1 << 0),
         NVME_REQ_USERCMD                = (1 << 1),
         NVME_MPATH_IO_STATS             = (1 << 2),
+       NVME_REQ_FORCE_SGL              = (1 << 3),
  };


I thought about it, but did not feel strong about it as all the new code 
was really tied to this flag.
I think the issue is more about the commit message. I can just reword 
the commit description make the connection explicit. Something like this-

Add a nvme request flag 'NVME_REQ_FORCE_SGL' that mandates both
data and meta transfer via sgl. Meta-transfer via SGL is a new ability 
that kicks in only when this flag is present.


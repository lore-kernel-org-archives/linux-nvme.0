Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FD7C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+uzujawcX0eKO7d97yr++ewO34mbcfAQ3xHTcB/APA=; b=lpZfM4qWRP1U0+NsSyW/6L8Kip
	PS6oucbPLyZ6R7lMdE6rvDuGtNW0REc3Gauh1bnTYp87SUtqvy5g/jjPyc9rZLq6eRsXp+zYbOLkG
	oIamVXXAhPf66TmosVYQZY/FbN5b6k0j4PZIkqAooCQA6YktnhTXwV4S8jXkJYno9wNXHp73ojXuA
	M9V53C2cxYfmQ0tFJLQxHNxAeYDflZ8/fOO0Vup94QGpT/suPK1NUWd7gvsyo0KW4f6dhitYuabI0
	AHKoF2I3GBjqQFEPtrhBsUNV4AIt+QUwPNRxoVDJXIYonTUTj/ZDETBxZZPNImECFybC5FhKKlZso
	fWRE+CBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ7rr-001xym-D2; Thu, 09 Feb 2023 14:25:43 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ7rk-001xuh-R2
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 14:25:42 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230209142525epoutp03322bf0d9bc9f053e7de4ce12a51e3367~CLh-f862w2831628316epoutp03J
	for <linux-nvme@lists.infradead.org>; Thu,  9 Feb 2023 14:25:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230209142525epoutp03322bf0d9bc9f053e7de4ce12a51e3367~CLh-f862w2831628316epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1675952725;
	bh=5+uzujawcX0eKO7d97yr++ewO34mbcfAQ3xHTcB/APA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFxvmWUGs8xlx41/sIxK5RIVeJ+HnrBkmJPvNBNjMJ/AoGTeIO9AsEdQZ3ynZP1C5
	 YDfAW3vjzfDE3GcYV4JP/FnRvl6zlEtdgJTtx5JU9dDwv1gTHuWee3j210CkXQgFbX
	 +SMwsUoRIooQHLZWkZ7IId8dJtJIZ0TGxeMhFrNY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230209142525epcas5p275d3a55c8eb86bd0013d063825eb67b9~CLh-TC4n-3109231092epcas5p2r;
	Thu,  9 Feb 2023 14:25:25 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4PCK040Wbnz4x9Pp; Thu,  9 Feb
	2023 14:25:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.50.55678.35205E36; Thu,  9 Feb 2023 23:25:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230209142523epcas5p4fb2262fc0406e73f4da078c3cba78d49~CLh9cLyok0209102091epcas5p4r;
	Thu,  9 Feb 2023 14:25:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230209142523epsmtrp1b998709ebf1858991d360e60e8b704fb~CLh9bmZxH0061600616epsmtrp16;
	Thu,  9 Feb 2023 14:25:23 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-60-63e5025368d8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.93.05839.35205E36; Thu,  9 Feb 2023 23:25:23 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230209142519epsmtip156176ff8e92bc422be364ef9a39fa3a8~CLh5y45yh0790107901epsmtip1n;
	Thu,  9 Feb 2023 14:25:18 +0000 (GMT)
Date: Thu, 9 Feb 2023 19:54:48 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
	Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: make 'at_head' parameter for
 __nvme_submit_sync_cmd() boolean
Message-ID: <20230209142448.GA5403@green5>
MIME-Version: 1.0
In-Reply-To: <ca49bc5b-be11-cebc-d12d-88d0e1f9e32d@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTUzeY6WmyQdd7G4s9iyYxWaxcfZTJ
	YtKha4wW85c9ZbdY9/o9iwOrx/l7G1k8Nq3qZPPYvKTeY/fNBiDjdHUAa1S2TUZqYkpqkUJq
	XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QbiWFssScUqBQQGJxsZK+
	nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbv99OYC2ZzVmye
	cpW1gfEBexcjJ4eEgInE7flH2boYuTiEBHYzSjyetIEJwvnEKHFzygxWCOcbo8Sn1ydZYFp+
	blnMApHYyyixbf13qJYnjBKdrReZQapYBFQkdm4/BDSYg4NNQFPiwuRSkLCIgJLEx/ZD7CD1
	zALtjBIzn59hAqkRFoiTePogDqSGV0BL4uKttywQtqDEyZlPwGxOAWuJSw3/WEFsUQFliQPb
	joPtlRD4yC4x/e0uqIdcJC5/W8AGYQtLvDq+BSouJfGyvw3KTpa4NPMcE4RdIvF4z0Eo216i
	9VQ/2P3MAhkSk8/NgrL5JHp/PwG7U0KAV6KjTQiiXFHi3qSnrBC2uMTDGUugbA+JGbN2MUPC
	5D+jxNKtT1gnMMrNQvLPLCQrIGwric4PTayzgFYwC0hLLP/HAWFqSqzfpb+AkXUVo2RqQXFu
	emqxaYFRXmo5PJKT83M3MYKTo5bXDsaHDz7oHWJk4mA8xCjBwawkwvt94uNkId6UxMqq1KL8
	+KLSnNTiQ4ymwOiZyCwlmpwPTM95JfGGJpYGJmZmZiaWxmaGSuK86rYnk4UE0hNLUrNTUwtS
	i2D6mDg4pRqYQuY8muOwM39PwKU9Dr1BLwq2qk+vSuQ7M+PIw9tnjblWepbPX8uoq1fyPWu7
	zYOsac6Tr3PzzWa6//lE9c2MxSe3N9ktqgj6o9fuWJVqGhAYn1BuL3Hu5UTVdB/emZ4lRm3f
	uld6n2EOaJk2/5rML7vGO9Jqf3adu7782s8pKksrf7j9lqxWUT32olO0lnni/qbTF07cid69
	5e2DQ1Xp72pFf5qzL3a4Gm3KsrshZkVG5iSjK4eVdrn65/soryhrSxJKFeeurkwMZF4uZ/p6
	IVvf/6taLd0dIZMZWu1K1D8yObxk9XoYWcEXyXbokbCB9DqWALUdQfyOc5MX+Wk/cJpffZF/
	k2Jx/JdX16uVWIozEg21mIuKEwEfOSftFwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnG4w09Nkg0WXZCz2LJrEZLFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G4CM09UBrFFcNimpOZllqUX6
	dglcGT96r7MUnGWruHlzKnMD4xrWLkZODgkBE4mfWxazdDFycQgJ7GaUmNN+iAUiIS7RfO0H
	O4QtLLHy33N2iKJHjBJXfj0DS7AIqEjs3H6IrYuRg4NNQFPiwuRSkLCIgJLEx/ZDYPXMAu2M
	El/Xb2UBqREWiJN4+iAOpIZXQEvi4q23UIsbmST+zX/IDpEQlDg58wnYEcwCZhLzNj9kBull
	FpCWWP6PAyTMKWAtcanhH9gDogLKEge2HWeawCg4C0n3LCTdsxC6FzAyr2KUTC0ozk3PLTYs
	MMxLLdcrTswtLs1L10vOz93ECA52Lc0djNtXfdA7xMjEwXiIUYKDWUmE9/vEx8lCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MJmdybnXIu4Zclo2ropp
	ke4yx3nx5Y7PkqVKpohfXcxmnDG3y4bHch+TQ+f1T5F+n7RnTnbr7nnms/xf7w3XLy8i/86w
	Se7uVxT9fFNkzo6CnSn2bkJR2ged2ninvSyLZjz8YbHe+6tSL8XvNd3rjvG5ZiLB18d7tUY2
	7bpW5IvlfrqKck6S7TqXpZ+fX/hfpzhysdCCzZdtXxROP3RbQPXg16tFwWuCXz9ZeCLIaOW1
	F9dD7madPcZ0b+W0hlvz1Jf4/giWehy95YXGxIf1r1T1mIQ8a75OVP3x/bBiS9M5hRk/77DP
	L5KcXnb08g4JtocNsc66t7y79orVayvsfpHGtMIibNLGgOrd9xYsl1RiKc5INNRiLipOBABd
	7Bjl5QIAAA==
X-CMS-MailID: 20230209142523epcas5p4fb2262fc0406e73f4da078c3cba78d49
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_4f85a_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230209110659epcas5p102b788dbdfc75deecdeb6b69a2106f3e
References: <20230208151720.109130-1-hare@suse.de>
	<20230208151720.109130-4-hare@suse.de> <20230209052018.GA8510@lst.de>
	<CGME20230209110659epcas5p102b788dbdfc75deecdeb6b69a2106f3e@epcas5p1.samsung.com>
	<ca49bc5b-be11-cebc-d12d-88d0e1f9e32d@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_062537_562103_DFECDE59 
X-CRM114-Status: GOOD (  15.25  )
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

------3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_4f85a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Feb 09, 2023 at 11:59:49AM +0100, Hannes Reinecke wrote:
>On 2/9/23 06:20, Christoph Hellwig wrote:
>>On Wed, Feb 08, 2023 at 04:17:20PM +0100, Hannes Reinecke wrote:
>>>Use a boolean for the 'at_head' parameter in __nvme_submit_sync_cmd()
>>>to improve readability and consistency; it's being converted into a
>>>boolean anyway.
>>
>>I'd much rather have an INSERT_AT_HEAD bit flag, going all the
>>way down to the block layer.  The use of a boolean for this (and
>>also some other things in the block layer issue path) is really confusing.
>
>I do agree. But that turns out to be a larger and more complex 
>patchset, which I'd rather send as a separate thingie after this one 
>is done.
>Otherwise it'll hold of this patchset, and really is an unrelated issue.

main patch (#2) is no longer coupled to other two now.

------3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_4f85a_
Content-Type: text/plain; charset="utf-8"


------3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_4f85a_--


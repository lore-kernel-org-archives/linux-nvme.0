Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7328CF11E6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KSn2eRpRGegQf6Mgvkf5JlOJofAiIpwhPyJxk9Tm938=; b=nuQyP97CkQvAEsoXNT2ptwdW9/
	pTe5wne16dHuJaSN1y/jOPvjkZ3uEG5MCOsdSQffRmdv5EmW3sJujTwCIOqgvSgM552ci6K+rKY6R
	37bKcOgosSDlnhY8TlRKlbMlESnprOhjexJSX9LYfl3yYoMPA3pqK0SkiLb37OEZdKf48SOyD61jp
	Atrta/QBgiWYvqpU0RBjx8mNWv1s2JeOFgkxYs4gpC/JrdpibdTCz2L7hPQk/EKLsXWDQW8vbh2py
	I7pCzZ88EJ2p/JP49BWIPOFGaUiYPepWBxus4yw44PXSFe3ToPze3hq5VkknU+wg8ub5lrcWWv/Hh
	IdydQwAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sysW8-0000000ClHL-1kNd;
	Thu, 10 Oct 2024 12:43:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sysBn-0000000ChQ6-3Hyu
	for linux-nvme@bombadil.infradead.org;
	Thu, 10 Oct 2024 12:22:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KSn2eRpRGegQf6Mgvkf5JlOJofAiIpwhPyJxk9Tm938=; b=icB9ubbkPyIr/C3f6vS0e23Mxc
	gLh14Cu+9bEm5L3BKJK0jTSWKLwNczS7e3Jq/RBE9Juux34Ybx7Xl/jQga+s3DrXXYA3OjHQyF2J3
	OlvTBeiFCeixP1nyNGgWIx9UdEqHImVSaV1snxN4OeaF1khyai2WrnXV9sgVdt/UdNZJrZj4Dy7ZT
	EoBoVqWdEvZtlot1nm0s3h7zAL9IRkYp/XyDwMsDx8lNQaUtsvIdjs32t7dyykhmJO/YkMV3flnJ5
	udfZD2CXnjNZ1d5NJsxYeOgMLTEclX7dBqfe76ZVzntHOg5x1Zf9ATWiJboT0lokT9FnyyuLoeqpI
	du2vkc4g==;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sysBk-00000005NOk-2vJC
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 12:22:42 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241010122234euoutp02ae498904efd33c62f18f96d46209b64f~9Ftlncya12055120551euoutp02Q
	for <linux-nvme@lists.infradead.org>; Thu, 10 Oct 2024 12:22:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241010122234euoutp02ae498904efd33c62f18f96d46209b64f~9Ftlncya12055120551euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728562955;
	bh=KSn2eRpRGegQf6Mgvkf5JlOJofAiIpwhPyJxk9Tm938=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ToyRddZmn1JbkwQgXPMIvihOF5n1778u3Ijn14a9xJOIP4fV5mCNjjHnIok05vEYN
	 mR2DeeIThyeJpOacWIDItixV27UW8bcoopMfFoEPBgB1onB6KSz3z5/EJhgz+VDYxN
	 ow5X2HtGR1W0L1Yef9puGfOvTc1XYxdCP1+75ru0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241010122234eucas1p2de06eca2fad6538303ae2bafb2563ce3~9FtlUXyUt3036330363eucas1p2U;
	Thu, 10 Oct 2024 12:22:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 73.98.09624.A07C7076; Thu, 10
	Oct 2024 13:22:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241010122234eucas1p230334cbe3575d8f9dd9b3d249f999c9e~9Ftk70V-a3036230362eucas1p2C;
	Thu, 10 Oct 2024 12:22:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241010122234eusmtrp107dd8d52c9bc1daed776ba50fd66e817~9Ftk7FciB0555705557eusmtrp1M;
	Thu, 10 Oct 2024 12:22:34 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-27-6707c70a1de9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C4.BD.14621.A07C7076; Thu, 10
	Oct 2024 13:22:34 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241010122234eusmtip1f25b1c2c79f99ebf0ee3cb7e1b7f6a98~9FtkvEdOP1028610286eusmtip1t;
	Thu, 10 Oct 2024 12:22:34 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 10 Oct 2024 13:22:33 +0100
Date: Thu, 10 Oct 2024 14:22:32 +0200
From: Javier Gonzalez <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Hans Holmberg <hans@owltronix.com>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Keith Busch
	<kbusch@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>, "hare@suse.de"
	<hare@suse.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "brauner@kernel.org"
	<brauner@kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"bcrl@kvack.org" <bcrl@kvack.org>, "dhowells@redhat.com"
	<dhowells@redhat.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>, "vishak.g@samsung.com" <vishak.g@samsung.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241010122232.r2omntepzkmtmx7p@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20241010092010.GC9287@lst.de>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxj23Ht7e9uk7rY086RsEmrVbAyQZcuOOBZM9uNmxmzodJE/WOBa
	mFBrS53OmVWwIETY0gm4rjhlBFjZ6qgIQ2Sx5aOrIEg7NumEQCgLKyBQ9hFgNKPcuvnveZ+P
	8z5vcihccp6UUbnqAlarVubJSSHR2rs8EC908VW7PBYFslhbAWoa/YREZaEWAs10BQGqWljG
	0ePCVQLVVDbx0J1aE4a+burB0GPjAIG+qC7CkP+GGUcm588AXa4qBKjTF4fudLoJ9GX9FB81
	uEIYss3ME2hwzcVLlTLen/Yx7eZRPjM41kww3vt6xm4tJRl70MRnbtZ9zHSMGEhmccpHMF32
	Wh4z/8MwyfRf614X+84yS/atjN0/h73zTLrw9Ww2L/cUq01846gwxzk0Tmo6nz29aJsFBhAS
	lwEBBelXoLt2migDQkpCNwK4PPdLZPgDwPppA8kNSwBe6XaQTyIlv1dFXA0Ato3biP9cVx0+
	jBtaAOyoXgXhCEFvh79eGNqIk3QitLbd2+CltBxOBe6DcACnV/gw0DHLCwtR9C44/3f5RkBE
	p8C7DiOPw2Lo/txPhDFOJ8PShcJ1nlrH0bAhRIVpAR0HTecrCK6qHE5OzwEOn4P3WrhykC4T
	wrpvFzBOeBP+Y52JmKJgwNXC5/BzsO+zS5GHzkKD+8dI+AKAxou3NhZDeg+s6M/jPHvhJY8H
	cPRm+HBOzNXcDE2t1ThHi+DFYgnn3gGbxmaJT8E281OHmZ86zPz/YdcAbgVbWL0uX8XqktTs
	Bwk6Zb5Or1YlZJ3It4P1X9oXcgW/BzWBxQQnwCjgBJDC5VJR/HWeSiLKVp75kNWeyNDq81id
	E0RThHyLaHt2DCuhVcoC9jjLaljtExWjBDIDVnFw9cB37ymnUh6Ma36zXD7gKS057BOPVTaf
	POUbUcS2WzL2ZdxOvJVW2bj7XYdcXq5VV3z0fvI3i2d6XYbctcaMlG2bOtCD1FevZh8dZqX9
	siR8aNI5m6a/na7wbE3tknpdS835m66v8G01guBLugbbXfoYPELs2TmsyJxIcQhdFDrUk/7a
	yzuRpfxw1t5eU3em5a9Hx0Qv6GL9wumctWhjkv2rG611QZ/3SM+5oj/9trTumLcOusHN0+WC
	FbF3ZaQnmXrb4C4p1mQ+EsUWTLQXZaXWT8RQXemDtGD0JH+/O057/GHAWLQbZUUVr8oy9zcL
	Btom43HF87hmQCYndDnKpBdxrU75Ly14R3gUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsVy+t/xu7pcx9nTDX5u5rSYs2obo8Xqu/1s
	Fl3/trBYvD78idFi2oefzBbvmn6zWMyduprVYs+iSUwWK1cfZbJ413qOxWL29GYmiyfrZzFb
	TDp0jdFiyrQmRou9t7Qt9uw9yWIxf9lTdovlx/8xWax7/Z7F4vzf46wOIh6Xr3h77Jx1l93j
	/L2NLB6Xz5Z6bFrVyeax6dMkdo/NS+o9dt9sYPP4+PQWi8fhTYtYPd7vu8rmcWbBEaDk6WqP
	z5vkPDY9ecsUwB+lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
	llqkb5egl3Ho4gO2gr1iFR/XvWFsYPwn2MXIySEhYCLR/nIaC4gtJLCUUWLjCz6IuIzExi9X
	WSFsYYk/17rYuhi5gGo+Mkr079vMCOFsYZRYuuwaM0gVi4CqxO2Wi2wgNpuAvsSq7acYQWwR
	ASWJp6/OgjUwC/xil5g8eTk7SEJYwEDi/fdesAZeAVuJAwdbWSGmrmCR2HR8PQtEQlDi5Mwn
	YDazgIXEzPnngSZxANnSEsv/cYCEOQW0JSY19rFAnKok8fjFW0YIu1bi899njBMYhWchmTQL
	yaRZCJMWMDKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECEwo24793LyDcd6rj3qHGJk4GA8x
	SnAwK4nw6i5kTRfiTUmsrEotyo8vKs1JLT7EaAoMi4nMUqLJ+cCUllcSb2hmYGpoYmZpYGpp
	Zqwkzut2+XyakEB6YklqdmpqQWoRTB8TB6dUA9ORiXcMjWecbIjcd36Oie6aCsM55dt6hHY7
	PC5IzZ23pbW25dtrRreiQ/Kv182UeahobNnd059ZcvDYqeOMn098E12gceQA7+2XovV7P1za
	EmtZWn44zO7jGuXa9daJJxx/8L/WZW5ZpC9ULLOGhblHa6/I9/qUV1tWZ83NKCtdfrBmzc+l
	PHsu58X19b1q2rx55kN2rQ8eP77euXts/pqXkwtP+0XJrWQ4a7Lf3U3tZ4n55eqg7im/zRKv
	PLnP4GC+a9GrTr7Nx3trGnbzWCUvvJD5qKa3ff2JxLLzsc72ehWPwtV+v167WrC6T2IZh7DY
	nv/vNlqs3jvj5tZOvYwnE89Pex47UdK/79lnHpFYJZbijERDLeai4kQAdhDcsbEDAAA=
X-CMS-MailID: 20241010122234eucas1p230334cbe3575d8f9dd9b3d249f999c9e
X-Msg-Generator: CA
X-RootMTR: 20241010092019eucas1p157b87b63e91cd2294df4a8f8e2de4cdf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241010092019eucas1p157b87b63e91cd2294df4a8f8e2de4cdf
References: <20241004062733.GB14876@lst.de>
	<20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
	<20241004123027.GA19168@lst.de>
	<20241007101011.boufh3tipewgvuao@ArmHalley.local>
	<CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com>
	<97bd78a896b748b18e21e14511e8e0f4@CAMSVWEXC02.scsc.local>
	<CANr-nt11OJfLRFr=rzH0LyRUzVD9ZFLKsgree=Xqv__nWerVkg@mail.gmail.com>
	<20241010071327.rnh2wsuqdvcu2tx4@ArmHalley.local>
	<CGME20241010092019eucas1p157b87b63e91cd2294df4a8f8e2de4cdf@eucas1p1.samsung.com>
	<20241010092010.GC9287@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_132240_848280_C111D623 
X-CRM114-Status: GOOD (  23.19  )
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

On 10.10.2024 11:20, Christoph Hellwig wrote:
>On Thu, Oct 10, 2024 at 09:13:27AM +0200, Javier Gonzalez wrote:
>> Is this because RocksDB already does seggregation per file itself? Are
>> you doing something specific on XFS or using your knoledge on RocksDB to
>> map files with an "unwritten" protocol in the midde?
>
>XFS doesn't really do anything smart at all except for grouping files
>with similar temperatures, but Hans can probably explain it in more
>detail.  So yes, this relies on the application doing the data separation
>and using the most logical vehicle for it: files.

This makes sense. Agree.

>
>>
>>    In this context, we have collected data both using FDP natively in
>>    RocksDB and using the temperatures. Both look very good, because both
>>    are initiated by RocksDB, and the FS just passes the hints directly
>>    to the driver.
>>
>> I ask this to understand if this is the FS responsibility or the
>> application's one. Our work points more to letting applications use the
>> hints (as the use-cases are power users, like RocksDB). I agree with you
>> that a FS could potentially make an improvement for legacy applications
>> - we have not focused much on these though, so I trust you insights on
>> it.
>
>As mentioned multiple times before in this thread this absolutely
>depends on the abstraction level of the application.  If the application
>works on a raw device without a file system it obviously needs very
>low-level control.  And in my opinion passthrough is by far the best
>interface for that level of control. 

Passthru is great for prototyping and getting insights on end-to-end
applicability. We see though that it is difficult to get a full solution
based on it, unless people implement a use-space layer tailored to their
use-case (e.g., a version SPDK's bdev). After the POC phase, most folks
that can use passthru prefer to move to block - with a validated
use-case it should be easier to get things upstream.

This is exactly where we are now.

>If the application is using a
>file system there is no better basic level abstraction than a file,
>which can then be enhanced with relatively small amount of additional
>information going both ways: the file system telling the application
>what good file sizes and write patterns are, and the application telling
>the file system what files are good candidates to merge into the same
>write stream if the file system has to merge multiple actively written
>to files into a write stream.  Trying to do low-level per I/O hints
>on top of a file system is a recipe for trouble because you now have
>to entities fighting over placement control.

For file, I agree with you.

If you saw the comments from Christian on the inode space, there are a
few plumbing challenges. Do you have any patches we could look at?





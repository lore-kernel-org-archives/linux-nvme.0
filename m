Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE68D12D49
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2024 17:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fH3KgLGYgx2bjIDYpcdbUhC000esHWCyOqg9tsV+A+0=; b=qxjxa7xobTaRl85bNWYQ/OSgJ6
	JYMeYCQXUxOgGoGdzVZ/N54eCLwt0Hdp8LIiiEh+IZYWQQbpvVeJbn4okvKW/7sm7ux2DLkSUv5za
	62ZoOwX3ZEjN9VPFHZleQCZleu73iimRl6rGqFn0deklfOSafqBR3sHufPpiK2+1narATA4daDtr6
	HlmTVRvVu3allHWpZoR+QqMGmjXfvULSvYeq+c3UPOh8Np7m1LCSkq2OwSj/Er8rvl52F6RA6UH7+
	oDNy6to6Mrk2ofsAcF4hD8TvCVBXDparWH0rZUZNPt+dCC8oK+aIfrtpKRmre8CedMTjC+Nv13vYF
	zHFJkZcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tABwy-0000000FJug-0Cg8;
	Sun, 10 Nov 2024 17:42:12 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tABwu-0000000FJu3-3SVq
	for linux-nvme@lists.infradead.org;
	Sun, 10 Nov 2024 17:42:11 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241110174202epoutp044d5f2f4fff05efbc076a2a7b4bf65a01~GrEXQ4b4c1652016520epoutp04s
	for <linux-nvme@lists.infradead.org>; Sun, 10 Nov 2024 17:42:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241110174202epoutp044d5f2f4fff05efbc076a2a7b4bf65a01~GrEXQ4b4c1652016520epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731260522;
	bh=fH3KgLGYgx2bjIDYpcdbUhC000esHWCyOqg9tsV+A+0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LQdrz031MgP91+SSyk5bpXxmIPjG2IEQiSjfCZLjnmULkv62o7mHxWuB8YWDsdenC
	 KJdVuiyowAiPOknJHfJsK4+kuqhF/VV9Ir07Nr4SHkfG98CXJjuLs15SYkwbrfUH13
	 pGDeunhpuOQYcCLXEvK4U230Wb8HNd/U1HiCONTM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241110174201epcas5p4e9969a9f1616a0837471cb5455cf8924~GrEWFxZ031857418574epcas5p4Q;
	Sun, 10 Nov 2024 17:42:01 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Xmg3X0vJ8z4x9Pt; Sun, 10 Nov
	2024 17:42:00 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.3D.09800.760F0376; Mon, 11 Nov 2024 02:41:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241110174158epcas5p4c3faa7aa5719a889db76599e54c20aad~GrETuq5Od1853718537epcas5p4T;
	Sun, 10 Nov 2024 17:41:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241110174158epsmtrp2dd189699d24af275a7f585503d51c369~GrETsiPZe0120701207epsmtrp2e;
	Sun, 10 Nov 2024 17:41:58 +0000 (GMT)
X-AuditID: b6c32a4b-4a7fa70000002648-7e-6730f0670f41
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	47.DF.08227.660F0376; Mon, 11 Nov 2024 02:41:58 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241110174156epsmtip12765246f822cdd7ec2e6fb9a08811e89~GrERVLV1h2330123301epsmtip1K;
	Sun, 10 Nov 2024 17:41:56 +0000 (GMT)
Message-ID: <47ce9a55-b6fd-47f8-9707-b530f2ea7df5@samsung.com>
Date: Sun, 10 Nov 2024 23:11:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] io_uring/rw: add support to send metadata
 along with read/write
To: Pavel Begunkov <asml.silence@gmail.com>, Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	anuj1072538@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <b11cc81d-08b7-437d-85b4-083b84389ff1@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd+69fUBSdy06zoiTrglhsBXaWtiVWSQZMXeDDSLRLLKt3tCb
	0kEf6W0HY4s2M+XpGGCWQWWCUURhY+ERXko2ilIhIpsQGFVcJYBDwEGZA2HFtbRu/Pc5v8f5
	/h7ncFG+kx3CVWuNtEFLZQvZgVh7X0SkKHNJrBJb1MTykw2M+LLMjRLVDe2AaJz8mk3M97kA
	MfFzF0JcabyBEI8ttzHi7LenEKLCNgaIHsfrxLWeAYyouTTDIUrGO9lEvX0TIYbddhYxbK3m
	JOwku6yTHHJkyES2NBSxydaLJ8mrE2Y2uTzjwMjStgZA3qq9ziFXWvaSLdOLSGrgsawDmTSl
	pA0CWpuhU6q1KrkwKU3xtiImViwRSfYTbwoFWkpDy4WJyamiQ+psTzdCwadUtsljSqUYRhgd
	f8CgMxlpQaaOMcqFtF6ZrZfpoxhKw5i0qigtbYyTiMXSGE/g8axM18AyojfvzZ1uHMTM4CG/
	GARwIS6DDyvOAy/z8asAXhh/vxgEetgF4Om6X1m+w98AupyDrOcZN+1dqM/RA+Dm6SZ/+iKA
	p9opL/PweLh05xzqZQwPg87KWbbPvhMOVE1jXt6Nh8LfHZUcLwfhCji48GTrnl14MjxT4+J4
	BVB8DYGjVUVbDhQPho7pGqQYcLlsPAL+csbkNQfgclh04x7bFxIKOxarUV+ha1zYXkL4OBFW
	W/5g+zgIPrK3cXwcAlce9/jtWdA55cR8/AXsbC31N3wQmv/5jeWVRT2yP3ZH+6R2wK82preq
	gTgPFub7B/oqvF8x488Mhg8qL/qZhG2LncA3tiIUrjvvs8qAwLptKtZtTVq3dWP9X7kWYA3g
	ZVrPaFQ0E6Pfp6Vz/lt3hk7TAraeemRSJ5hyLkXZAMIFNgC5qHAX77WUaBWfp6Q+y6MNOoXB
	lE0zNhDjWU85GrI7Q+f5K1qjQiLbL5bFxsbK9u+LlQiDefOW75R8XEUZ6Sya1tOG53kINyDE
	jAgK8++2VvWHSqc+Ofg0uvZZc7x4KN7lDmiaLXvUW5/4w4kZcUdew/iV8KWfinndKRl3rzWH
	F37/EmrorzMra2wpYUcPn8u5E9Rv+yYd1Wk+tDwLlek2HIfnumcd7aN/9kslkyPpL36EJ51Y
	P5JW8cGESEoW2C0F90JEpgD4wqXZ4R223BUpo4lIuK5ebn7XWB/2XlBv8F8Rb40WpmiP9Xfw
	m8qjFzipZ1ePN4bfmhsaW+g7Wb7qHhFdNswmrwlKLh+Ke8e9x7VntaY0cfPp2OdtufPK2wU5
	vZ0fv2JwPziSb7wgT3hjeCNZ3pdm1+Msl1SSrnMeFSni8m+uq1PnzufVCTEmk5JEogaG+hcM
	0j6wcwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSnG7aB4N0g/c71C0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAVxSXTUpqTmZZapG+XQJXxqeTH5kKGuQqnqw+xdLA
	+Fyoi5GTQ0LAROLE8Z3MXYxcHEICuxklnn75wgyREJdovvaDHcIWllj57zk7RNFrRon9f++w
	giR4BewkPlyaB9bAIqAq8WDGMzaIuKDEyZlPWEBsUQF5ifu3ZgA1c3AIC8RL7JupAxIWEfCR
	mDz/E9hMZoEfTBLbeq5BLehkltg58zETSBUz0BW3nsxnAmlmE9CUuDC5FCTMKWAr0Xn0DhtE
	iZlE19YuRghbXmL72znMExiFZiE5YxaSSbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFi
	bnFpXrpecn7uJkZwHGtp7WDcs+qD3iFGJg7GQ4wSHMxKIrwa/vrpQrwpiZVVqUX58UWlOanF
	hxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTA1ztKrk9sUPHF9sbDkV8OeLZbv2bak
	Wr8t2/LkjXWNdM/ppzU3Wd/feZ1ykX+7pX2XovcVbXGlxr7vTj5eqjwcYbVFK8KuPZ0i/Ww+
	+x/5I7uWbHdd/efYqqDEcxdunjy87dye2u/rntrI67jys1bOuz2vvI3B9X2taUjQQsarCeny
	h7qmmGjfaOriP/JLTOac0faNIUIbZEWsDxhPURCaVDJjx/vsm41379moJSkWrpntKBax7Z//
	OXbzyKBv+y8Kat/KX1lr/Z7v9eqjCm+8JWa+Kznz/ae33GGNiDWfOG/5umSkMMzn+n6XdQJP
	dCuPbiFP9wVfA1713x5zRBvY74RqZPe77N3eLG98Rk6JpTgj0VCLuag4EQB6qhQtUgMAAA==
X-CMS-MailID: 20241110174158epcas5p4c3faa7aa5719a889db76599e54c20aad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241030181013epcas5p2762403c83e29c81ec34b2a7755154245
References: <20241030180112.4635-1-joshi.k@samsung.com>
	<CGME20241030181013epcas5p2762403c83e29c81ec34b2a7755154245@epcas5p2.samsung.com>
	<20241030180112.4635-7-joshi.k@samsung.com>
	<ZyKghoCwbOjAxXMz@kbusch-mbp.dhcp.thefacebook.com>
	<914cd186-8d15-4989-ad4e-f7e268cd3266@gmail.com>
	<ceb58d97-b2e3-4d36-898d-753ba69476be@samsung.com>
	<b11cc81d-08b7-437d-85b4-083b84389ff1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_094209_463002_E5FF13EA 
X-CRM114-Status: GOOD (  16.70  )
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

On 11/7/2024 10:53 PM, Pavel Begunkov wrote:

>>> 1. SQE128 makes it big for all requests, intermixing with requests that
>>> don't need additional space wastes space. SQE128 is fine to use but at
>>> the same time we should be mindful about it and try to avoid enabling it
>>> if feasible.
>>
>> Right. And initial versions of this series did not use SQE128. But as we
>> moved towards passing more comprehensive PI information, first SQE was
>> not enough. And we thought to make use of SQE128 rather than taking
>> copy_from_user cost.
> 
> Do we have any data how expensive it is? I don't think I've ever
> tried to profile it. And where the overhead comes from? speculation
> prevention?

We did measure this for nvme passthru commands in past (and that was the 
motivation for building SQE128). Perf profile showed about 3% overhead 
for copy [*].

> If it's indeed costly, we can add sth to io_uring like pre-mapping
> memory to optimise it, which would be useful in other places as
> well.

But why to operate as if SQE128 does not exist?
Reads/Writes, at this point, are clearly not using aboud 20b in first 
SQE and entire second SQE. Not using second SQE at all does not seem 
like the best way to protect it from being used by future users.

Pre-mapping maybe better for opcodes for which copy_for_user has already 
been done. For something new (like this), why to start in a suboptimal 
way, and later, put the burden of taking hoops on userspace to get to 
the same level where it can get by simply passing a flag at the time of 
ring setup.

[*]
perf record -a fio -iodepth=256 -rw=randread -ioengine=io_uring -bs=512 
-numjobs=1 -size=50G -group_reporting -iodepth_batch_submit=64 
-iodepth_batch_complete_min=1 -iodepth_batch_complete_max=64 
-fixedbufs=1 -hipri=1 -sqthread_poll=0 -filename=/dev/ng0n1 
-name=io_uring_1 -uring_cmd=1


# Overhead  Command          Shared Object                 Symbol
# ........  ...............  ............................ 
...............................................................................
#
     14.37%  fio              fio                           [.] axmap_isset
      6.30%  fio              fio                           [.] 
__fio_gettime
      3.69%  fio              fio                           [.] get_io_u
      3.16%  fio              [kernel.vmlinux]              [k] 
copy_user_enhanced_fast_string
      2.61%  fio              [kernel.vmlinux]              [k] 
io_submit_sqes
      1.99%  fio              [kernel.vmlinux]              [k] fget
      1.96%  fio              [nvme_core]                   [k] 
nvme_alloc_request
      1.82%  fio              [nvme]                        [k] nvme_poll
      1.79%  fio              fio                           [.] 
add_clat_sample
      1.69%  fio              fio                           [.] 
fio_ioring_prep
      1.59%  fio              fio                           [.] thread_main
      1.59%  fio              [nvme]                        [k] 
nvme_queue_rqs
      1.56%  fio              [kernel.vmlinux]              [k] io_issue_sqe
      1.52%  fio              [kernel.vmlinux]              [k] 
__put_user_nocheck_8
      1.44%  fio              fio                           [.] 
account_io_completion
      1.37%  fio              fio                           [.] 
get_next_rand_block
      1.37%  fio              fio                           [.] 
__get_next_rand_offset.isra.0
      1.34%  fio              fio                           [.] io_completed
      1.34%  fio              fio                           [.] td_io_queue
      1.27%  fio              [kernel.vmlinux]              [k] 
blk_mq_alloc_request
      1.27%  fio              [nvme_core]                   [k] 
nvme_user_cmd64


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67977C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4BcyKe56ztD+lnm938/6LqmBi37tVsoiHEhtNJhj4sA=; b=HAW2k7m6hGrcKcq3lbHU82CDjX
	Uyx75JilhwqiMPJ+91a8E8Zwny7P1xTqwg3IBvGb9XXqm0WXF1CMiLaa73246HP0RIU25MxS1jBkF
	MxOWNPBnD9Fg6FhRhX0eCHNgTsdaiKUB0w0BFyyoRrnHDGB0OAJeHlSOUjDSWSSUVw4LSl64lsfSz
	kL2QOVrXYeddtSjOy69o5G6HLDJBOC7TURNAU2SUUmAbS+aafIuFPqC9cuhJ8a4ZNi94w2whD6Emb
	HUoGGuqKiDOtfc+HXC+Xoz6GONqjtnK8zkK5u92TgFCeJ9nI+M0VwMMOCs24zQFO2V0m1WuzW7kZ8
	mBvmq5Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuR2W-00000004ses-286H;
	Tue, 18 Mar 2025 07:07:04 +0000
Received: from [203.254.224.34] (helo=mailout4.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuR2S-00000004scM-36bT
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:07:03 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250318070653epoutp0425d2911ef553cdc0a8d81a8e776d20af~t0_WCtYEX0457804578epoutp04c
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 07:06:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250318070653epoutp0425d2911ef553cdc0a8d81a8e776d20af~t0_WCtYEX0457804578epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742281613;
	bh=4BcyKe56ztD+lnm938/6LqmBi37tVsoiHEhtNJhj4sA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NDVZQYJK5vFZn8vMYAWJyNm613DPQhfMBWmKdxUgI0vmEaF3GW/vk+qxdv1xuoYlm
	 MbYO+X/wOfnlXfpuu0TH2ohk1a3dweYP7AJSjtLGomUPdvcIJBniAFW6cXQIHs55m0
	 v8253dvfJZWEHAtNr9vZZhBIecVRqDPA0z/V9ugE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250318070653epcas5p3beda02f314d748f29f9f6fdbb6d76eff~t0_VkBnTa1730717307epcas5p34;
	Tue, 18 Mar 2025 07:06:53 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4ZH2vW4CVYz4x9QF; Tue, 18 Mar
	2025 07:06:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6B.92.19933.78B19D76; Tue, 18 Mar 2025 16:06:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250318070647epcas5p2f3e162aa3a172113cbda22326e7bd34e~t0_QALYS90333203332epcas5p2D;
	Tue, 18 Mar 2025 07:06:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250318070647epsmtrp2a497a90be0e121f52a9bd2bb8de63412~t0_P-YHaA2960529605epsmtrp2i;
	Tue, 18 Mar 2025 07:06:47 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-d5-67d91b8716ec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.72.23488.68B19D76; Tue, 18 Mar 2025 16:06:46 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250318070645epsmtip28678c6c9740b3ed29fd27514977523ad~t0_OdCvfv0823908239epsmtip2U;
	Tue, 18 Mar 2025 07:06:45 +0000 (GMT)
Message-ID: <edde46e9-403b-4ddf-bd73-abe95446590c@samsung.com>
Date: Tue, 18 Mar 2025 12:36:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: "hch@infradead.org" <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <Z6GivxxFWFZhN7jD@infradead.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmpm679M10g55WGYvTExYxWfztusdk
	8eehocXeW9oWlx6vYLfYs/cki8X8ZU/ZLfa93sts0drzk91izbqP7A5cHptXaHlsXlLvMfnG
	ckaPpjNHmT3Wb7nK4jFh80ZWj8+b5DzaD3QzBXBEZdtkpCampBYppOYl56dk5qXbKnkHxzvH
	m5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2opFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
	Si1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO6Gn7zVTwV7ri+OUX7A2MV0W7GDk5JARM
	JBo6brB2MXJxCAnsZpT4cncfM4TziVFi+bSXUJlvjBJtk/YydjFygLVMeagBEd/LKDH7wzkm
	COcto8TjvmcsIHN5Bewk/i/7wAhiswioSmxvXQUVF5Q4OfMJmC0qIC9x/9YMdhBbWMBGonvX
	ITaQBSIC2hKLH9eBzGQW+MAs0fZsMxNIDbOAuMStJ/OZQGrYBDQlLkwuBQlzCuhK7P/9jQWi
	RF5i+9s5YB9ICGzhkHjd+5EF4k8XiQ13LrFC2MISr45vYYewpSQ+v9vLBmFnSzx49ACqvkZi
	x+Y+qHp7iYY/oDDiAFqgKbF+lz7ELj6J3t9PmCBhwivR0SYEUa0ocW/SU6hOcYmHM5ZA2R4S
	l1ZthgbVF2aJh3va2CYwKsxCCpVZSL6cheSdWQibFzCyrGKUTC0ozk1PLTYtMMpLLYfHd3J+
	7iZGcPLV8trB+PDBB71DjEwcjIcYJTiYlUR43Z9cTxfiTUmsrEotyo8vKs1JLT7EaAqMnonM
	UqLJ+cD0n1cSb2hiaWBiZmZmYmlsZqgkztu8syVdSCA9sSQ1OzW1ILUIpo+Jg1OqgWmV4JeV
	KTMjWMQMWGt/W64Vk5RRnr7gsp3JLc27RTVzBaZcnPHjxYS5ax6wFWgdOS7pWpEx9xB78MMf
	kxSNLqh52nlwFJmXNb59/N1k1gKHKxs9c4V3LzZlr9z/fF1XcCezunKv8yyPX3zi/+aICN0r
	1phVE/vP3apgTd3GUuXADJGwmNf5R6x4X8oIXJ94YOfjZonwzUKK5d6R1Rt1mDcv3hgTsz7I
	8/l/O6nFSw/c54mf8sHMKkfi9gMmFlP7yco75Oc/3nvQre6lc6ivTX/R369dBfLPQxk27r71
	88y2yYfF/Kd5q/83VP92jsXGZW+Z8E3jwFiJzBWvg0926F0M7OBLcZ/rNWH1l+iO20osxRmJ
	hlrMRcWJADEFMl1HBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvG6b9M10g/3t1hanJyxisvjbdY/J
	4s9DQ4u9t7QtLj1ewW6xZ+9JFov5y56yW+x7vZfZorXnJ7vFmnUf2R24PDav0PLYvKTeY/KN
	5YweTWeOMnus33KVxWPC5o2sHp83yXm0H+hmCuCI4rJJSc3JLEst0rdL4MroafvNVPBXuuL4
	5RfsDYxXRbsYOTgkBEwkpjzU6GLk4hAS2M0osezIOeYuRk6guLhE87Uf7BC2sMTKf8/ZIYpe
	M0r0LP3MBpLgFbCT+L/sAyOIzSKgKrG9dRULRFxQ4uTMJ2C2qIC8xP1bM8AGCQvYSHTvOsQG
	slhEQFti8eM6kJnMAh+YJZZufcEMseALs8ScmefAhjIDXXHryXwmkAY2AU2JC5NLQcKcAroS
	+39/Y4EoMZPo2toFVS4vsf3tHOYJjEKzkJwxC8mkWUhaZiFpWcDIsopRMrWgODc9N9mwwDAv
	tVyvODG3uDQvXS85P3cTIzjStDR2ML771qR/iJGJg/EQowQHs5IIr/uT6+lCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEeVcaRqQLCaQnlqRmp6YWpBbBZJk4OKUamHT9LD177vsv3/vcSKtmAfO3
	x/vnfH1nse8MT75kmJK6tJCIt0qFKoO4fso5zumKmd+Zcj/1abr/vPYmInSpfstqPsk+77XL
	VpXmydb6PwpfZ96xwt7yUNqHXS6xbH/XvcqaUq+dFVjD1CJ6kuPR+wWzHOYZc4TEKllZRnys
	OTvTseRaVuXsHX3JfLZH2wQe81X7hZxawPwod5KX0c+A5eWNnC/Zt3ycyXR57b3jZz9cubHc
	wD+dNe6PWqa9B9/5q/vWnnxQuqpv2xSbm/PC2lj6piyK6BefK/7+7R9ZvUitq/XGH4+82DZX
	VW/GlQJd4bVqxVttdf681bCZvEf0Sh3LtCdpr3aVvrp9TFLCRYmlOCPRUIu5qDgRAE9nlqMj
	AwAA
X-CMS-MailID: 20250318070647epcas5p2f3e162aa3a172113cbda22326e7bd34e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
	<20250130091545.66573-1-joshi.k@samsung.com>
	<20250130142857.GB401886@mit.edu>
	<97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
	<b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
	<Z6B2oq_aAaeL9rBE@infradead.org>
	<bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
	<eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
	<cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
	<Z6GivxxFWFZhN7jD@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_000701_420506_278778D5 
X-CRM114-Status: GOOD (  28.50  )
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

On 2/4/2025 10:46 AM, hch@infradead.org wrote:
> On Mon, Feb 03, 2025 at 06:57:13PM +0530, Kanchan Joshi wrote:
>> But, patches do exactly that i.e., hardware cusm support. And posted
>> numbers [*] are also when hardware is checksumming the data blocks.
> 
> I'm still not sure why you think the series implements hardware
> csum support.

Series ensure that (a) that host does not compute the csum, and (b) 
device computes.
Not sure if you were doubting the HW instead, but I checked that part 
with user-space nvme-passthrough program which
- [During write] does not send checksum and sets PRACT as 1.
- [During read] sends metadata buffer and keeps PRACT as 0.
It reads the correct data checksum which host never computed (but device 
did at the time of write).

> The buf mode is just a duplicate implementation of the block layer
> automatic PI.  The no buf means PRACT which let's the device auto
> generate and strip PI.

Regardless of buf or no buf, it applies PRACT and only device computes 
the checksum. The two modes are taking shape only because of the way 
PRACT works for two different device configurations

#1: when meta-size == pi-size, we don't need to send meta-buffer.
#2: when meta-size > pi-size, we need to.

Automatic PI helps for #2 as split handling of meta-buffer comes free if 
I/O is split. But overall, this is also about abstracting PRACT details 
so that each filesystem does not have to bother.
And changes to keep this abstracted in Auto-PI/NVMe are not much:

  block/bio-integrity.c     | 42 ++++++++++++++++++++++++++++++++++++++-
  block/t10-pi.c            |  7 +++++++
  drivers/nvme/host/core.c  | 24 ++++++++++++++++++++++
  drivers/nvme/host/nvme.h  |  1 +

>  Especially the latter one (which is the
> one that was benchmarked) literally provides no additional protection
> over what the device would already do.  It's the "trust me, bro" of
> data integrity :)  Which to be fair will work pretty well as devices
> that support PI are the creme de la creme of storage devices and
> will have very good internal data protection internally.  But the
> point of data checksums is to not trust the storage device and
> not trust layers between the checksum generation and the storage
> device.

Right, I'm not saying that protection is getting better. Just that any 
offload is about trusting someone else with the job. We have other 
instances like atomic-writes, copy, write-zeroes, write-same etc.

> IFF using PRACT is an acceptable level of protection just running
> NODATASUM and disabling PI generation/verification in the block
> layer using the current sysfs attributes (or an in-kernel interface
> for that) to force the driver to set PRACT will do exactly the same
> thing.

I had considered but that can't work because:

- the sysfs attributes operate at block-device level for all read or all 
write operations. That's not flexible for policies such "do something 
for some writes/reads but not for others" which can translate to "do 
checksum offload for FS data, but keep things as is for FS meta" or 
other combinations.

- If the I/O goes down to driver with , driver will start failing 
(rather than setting PRACT) if the configuration is "meta-size > 
pi-size". This part in nvme_setup_rw:

                 if (!blk_integrity_rq(req)) {
                         if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
                                 return BLK_STS_NOTSUPP;
                         control |= NVME_RW_PRINFO_PRACT;
                 }



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142DDC35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r+OZ0dZjRdagPeJioXzbnIj1AKfJy9OpWi/BR3HcRpc=; b=W00ua5mqqSg5YK762DKYIQC+Wz
	xkAstX7w5Csh8OnGA94NtEAhvCb+WldFBuKXg0IJQcTpSiEoeHzHGuXaHtwV7DcxOCaL/IsK1nfi4
	o2Zs5vhWjK055//j4j5loNEg3foDYEBthJfk2nZI0ewZ2G+9KJbBh/ZuGIewo0SlUJ4d+0+sI2hkS
	O/AIa/6Js0ZJqTLpsbe15AMFWSL8PIO3z6xerIisomL/Gwyq9btdcRGhTGK1EJ7zAgX8DRmbBAPCN
	ZciqXyEARvPkeQUzShhkWzC9LP2WQmFxrjpublviOtS7mmL02R/A1/UCT1fzyyvvNyg1JwQNqfp+T
	GUecXnRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuxpI-00000009nlh-3iaN;
	Wed, 19 Mar 2025 18:07:36 +0000
Received: from [203.254.224.33] (helo=mailout3.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuxoL-00000009nab-1fuu
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 18:06:40 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250319180633epoutp03bacb7596c7c8e8a0303f5c464715f990~uRnmYQ4dk1459014590epoutp03Y
	for <linux-nvme@lists.infradead.org>; Wed, 19 Mar 2025 18:06:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250319180633epoutp03bacb7596c7c8e8a0303f5c464715f990~uRnmYQ4dk1459014590epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742407593;
	bh=r+OZ0dZjRdagPeJioXzbnIj1AKfJy9OpWi/BR3HcRpc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cp6G1JXW2TPfq9kLMUYadZsNun55gCCLBh3fmFI3NIymu410SIGfNoq/aJp8cC/AL
	 FBYjj1pX8QPjTksSkDuu9sEuuE+h0ysFTT4uPLnd4DqSfX3MbwczWk747qY5XHszDZ
	 oapQusRRPXvXVd6YkfpJs5SJrO7qiqYfw/2/ss3o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250319180633epcas5p37fdb720f28677dc579821d1b4f820966~uRnmEC2MM1969719697epcas5p32;
	Wed, 19 Mar 2025 18:06:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZHxVH4ZWnz4x9Pv; Wed, 19 Mar
	2025 18:06:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.5D.19956.7A70BD76; Thu, 20 Mar 2025 03:06:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250319180631epcas5p47dbbc86eb8982b6cb230ab33dfd43aa0~uRnj33X9u1744817448epcas5p4N;
	Wed, 19 Mar 2025 18:06:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250319180631epsmtrp176ea9c1c70e9a2b5756a793717c5e402~uRnj3F3l21334513345epsmtrp1G;
	Wed, 19 Mar 2025 18:06:31 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-d5-67db07a78a2b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.EC.18729.6A70BD76; Thu, 20 Mar 2025 03:06:31 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250319180629epsmtip27f2b0f464fbd09d8727b5ef0ca773742~uRniVqTrs2457824578epsmtip25;
	Wed, 19 Mar 2025 18:06:29 +0000 (GMT)
Message-ID: <435cf6be-98e7-4b8b-ae42-e074091de991@samsung.com>
Date: Wed, 19 Mar 2025 23:36:28 +0530
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
In-Reply-To: <Z9kpyh_8RH5irL96@infradead.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhu5y9tvpBn9uy1qcnrCIyeJv1z0m
	iz8PDS323tK2uPR4BbvFnr0nWSzmL3vKbrHv9V5mi9aen+wWa9Z9ZHfg8ti8Qstj85J6j8k3
	ljN6NJ05yuyxfstVFo8JmzeyenzeJOfRfqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON45
	3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hAJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmt
	UmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xtSbfxkLtvNWrG69z9zA+I2ri5GTQ0LA
	RGLuy6UsXYxcHEICuxklVvw+yASSEBL4xCix9akpROIbo8Tn59dZYTqmrtoO1bGXUaLtxQUm
	COctUEfDZbAqXgE7iZ27zoLZLAKqEk+WLGKGiAtKnJz5hAXEFhWQl7h/awY7iC0sYCPRvesQ
	WxcjB4eIgLbE4sd1IDOZBT4wS7Q92wx2ErOAuMStJ/OZQGrYBDQlLkwuBQlzCuhKbHl+kBGi
	RF5i+9s5zCC9EgI7OCQm3twBdbWLxK+P19ggbGGJV8e3sEPYUhIv+9ug7GyJB48esEDYNRI7
	NvdB9dpLNPy5wQqylxlo7/pd+hC7+CR6fz8BO0dCgFeio00IolpR4t6kp1Cd4hIPZyyBsj0k
	9k94ywgJqjMsEpvfnWSbwKgwCylUZiH5chaSd2YhbF7AyLKKUTK1oDg3PbXYtMA4L7UcHt/J
	+bmbGMHJV8t7B+OjBx/0DjEycTAeYpTgYFYS4XV/cj1diDclsbIqtSg/vqg0J7X4EKMpMHom
	MkuJJucD039eSbyhiaWBiZmZmYmlsZmhkjhv886WdCGB9MSS1OzU1ILUIpg+Jg5OqQYmg+2L
	6pxbDzC/3Sd5Nn6N7EX+a2alxpud3Mp/SdpZ5V59Ne2ql+APiZ93vyc1LrNwj57NyxTwbOvN
	2L1NdSvyP8uZviw6u5BXMeLE9/31Ux5e/fj6zWTLLRpsG1dM+iDovtp6aVjzypCUKzXybKdt
	/+fq1vyWDPooIi5woN/kkUy97enOaxqcKoail740cPn6HXg3cf/85xUzz4Q3fXBivi/H+ePd
	Nu6/CTEvDs9pNNNlnPM36aTMg3mbAzZ8zAmb+H/rLpdGXtFvdpYZm36Ef2bkn85/7/W+A7u5
	PaV8fB7JHZnDfPvIqvymxozsc7Z2UiXzrkZnPVdsCDEUl2dP5/NJtW/+yGl1+GjGxJ6JSizF
	GYmGWsxFxYkATfiznkcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO5y9tvpBs3HmCxOT1jEZPG36x6T
	xZ+HhhZ7b2lbXHq8gt1iz96TLBbzlz1lt9j3ei+zRWvPT3aLNes+sjtweWxeoeWxeUm9x+Qb
	yxk9ms4cZfZYv+Uqi8eEzRtZPT5vkvNoP9DNFMARxWWTkpqTWZZapG+XwJUx9eZfxoLtvBWr
	W+8zNzB+4+pi5OSQEDCRmLpqO0sXIxeHkMBuRolDv68xQSTEJZqv/WCHsIUlVv57zg5R9JpR
	4uDabSwgCV4BO4mdu86ygtgsAqoST5YsYoaIC0qcnPkErEZUQF7i/q0ZYIOEBWwkuncdYuti
	5OAQEdCWWPy4DmQms8AHZomlW18wQyw4wyKxvG8aG0gDM9AVt57MZwJpYBPQlLgwuRQkzCmg
	K7Hl+UFGiBIzia6tXVC2vMT2t3OYJzAKzUJyxiwkk2YhaZmFpGUBI8sqRsnUguLc9NxiwwLD
	vNRyveLE3OLSvHS95PzcTYzgWNPS3MG4fdUHvUOMTByMhxglOJiVRHjdn1xPF+JNSaysSi3K
	jy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cC0rt3H9EagrTpb1ofsx3cf
	3eiYsTL+ZPXiFyH8Uiny8avzXn/czVTxfYdEi4H/6o/zP3yZvH3qn1/BJ05xpb1ZN1/rYbK9
	cYiB7SONJXXHNtWvvv/s6DvOmp/N3auOKXtv99zatyXs5LaG7afyPs0qz7hbdSE4bcaS+oK2
	yP0HfvOY6fEoLl4z/5qD/vGbjE/frLVavubv8ljT7reGG5z/dJr//jVHcxVP6Czx5uoph47z
	7/lodHbCLLmO3wskt60KSdznwrpRdKqv+t6n75sNaxtlwy6xNTsZnGHKWSzRqq9icTno5fo3
	ee4PRVuMn67z+WY6ufSRh7rPq0ui+7YduLi81ovflbn/ubaph504hxJLcUaioRZzUXEiAOXN
	lTYkAwAA
X-CMS-MailID: 20250319180631epcas5p47dbbc86eb8982b6cb230ab33dfd43aa0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250318080742epcas5p31b31b3024d6f7d9d150c8a7c2db4dffd
References: <20250130091545.66573-1-joshi.k@samsung.com>
	<20250130142857.GB401886@mit.edu>
	<97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
	<b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
	<Z6B2oq_aAaeL9rBE@infradead.org>
	<bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
	<eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
	<cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
	<Z6GivxxFWFZhN7jD@infradead.org>
	<edde46e9-403b-4ddf-bd73-abe95446590c@samsung.com>
	<CGME20250318080742epcas5p31b31b3024d6f7d9d150c8a7c2db4dffd@epcas5p3.samsung.com>
	<Z9kpyh_8RH5irL96@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_110638_877578_FD638FA3 
X-CRM114-Status: GOOD (  19.44  )
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

On 3/18/2025 1:37 PM, hch@infradead.org wrote:
> On Tue, Mar 18, 2025 at 12:36:44PM +0530, Kanchan Joshi wrote:
>> Right, I'm not saying that protection is getting better. Just that any
>> offload is about trusting someone else with the job. We have other
>> instances like atomic-writes, copy, write-zeroes, write-same etc.
> 
> So wahst is the use case for it? 

I tried to describe that in the cover letter of the PoC:
https://lore.kernel.org/linux-btrfs/20250129140207.22718-1-joshi.k@samsung.com/


  What is the "thread" model you are
> trying to protect against (where thread here is borrowed from the
> security world and implies data corruption caught by checksums).

Seems you meant threat model. That was not on my mind for this series, 
but sure, we don't boost integrity with offload.

>>
>>> IFF using PRACT is an acceptable level of protection just running
>>> NODATASUM and disabling PI generation/verification in the block
>>> layer using the current sysfs attributes (or an in-kernel interface
>>> for that) to force the driver to set PRACT will do exactly the same
>>> thing.
>>
>> I had considered but that can't work because:
>>
>> - the sysfs attributes operate at block-device level for all read or all
>> write operations. That's not flexible for policies such "do something
>> for some writes/reads but not for others" which can translate to "do
>> checksum offload for FS data, but keep things as is for FS meta" or
>> other combinations.
> 
> Well, we can easily do the using a per-I/O flag

Right, a per-I/O flag (named REQ_INTEGRITY_OFFLOAD) is what I did in the 
patch:
https://lore.kernel.org/linux-btrfs/20250129140207.22718-2-joshi.k@samsung.com/


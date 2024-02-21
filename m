Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A5AC48BF6
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U5oHcP4oFU2TyXagBnUm+DqGwQdtbRsO0Zx9zN4Envg=; b=BUTFwFB0bSE9fN97v2U8lHEm2w
	IZrdFAXB0iQqDKWQS7TWwWtBwyU0JIietVMGMsTXe74pTC8hO8Zy6V0X5FXY+EOQToQYGEXXJuRs/
	2xf8+ZeERwhnrJv8R0tZjBlNZ/PaeTXO/j0qHcwvA5brjdsRinKzXLsQKKNi0WfKTuNc2H09nkyg0
	QL5H84hOJZlxjRDFBZzda8Kz/T/xmFo8SGVGe8T8km1cammcec0a8qdPZF2xuYRnYuQiCg0hFIawS
	kCOR++h/b7IVBqX4r8VHNd4Xhm4YGunVkqrtsV63yGSC7robC5wERpEWNYDzAYqa5C5JztU6DNh+t
	bIbw4d4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcivi-00000000GUq-37i3;
	Wed, 21 Feb 2024 09:30:18 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcivf-00000000GSw-2LfD
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 09:30:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9E077CE1CAB;
	Wed, 21 Feb 2024 09:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE537C433F1;
	Wed, 21 Feb 2024 09:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708507812;
	bh=nJDvNRnCHO0W6kka+FAavHGHLfb0qEsB5Cywd7hyRYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pMhK5LfZEWKt5b29Lv2PN1zIzxTetEpwbyg4YP/287Doxc7muAIxS1bDC15kdqtsb
	 Qb5rDFQRTd1A3nOhbZYsaOQZvGpNeMZyLd9wEblZDzPFrn7GmkVJnthqy9Jqt7fWVS
	 8hSWzQTj/zm/b+drtISAFWN8bqPYKnYgYoePAvqjMyPky5RBlkH2KKzROcKctPtMuO
	 Jkt5BJPxl+QJcKEN1YbzF2R/VlPToT1ivJdSKPlz+evf8umMUQzvX/7KFf4Fh5EBrf
	 RXMdiCjo0tqTazSx5bk49zwyWy4TdiYwem0DTNuthc0pu4BCRkrFaaZYGnVT857VlN
	 p+W7yZyrhcHfA==
Message-ID: <99bba6e6-1ae3-49d2-842b-680257cedbad@kernel.org>
Date: Wed, 21 Feb 2024 18:30:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v0] nvme/029: reserve hugepages for lager
 allocations
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Keith Busch <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Yi Zhang <yi.zhang@redhat.com>
References: <20240220081327.2678-1-dwagner@suse.de>
 <6xxslyeuaetammpqcsekkmzmuz5vmtscrhczi6inwoj2ne52se@mh2zrp6kxgiv>
 <eo2iqix7vzrjgjs6bhx44s3rxblxorc4za62rrzaw5hqb5xqlh@uad7uc4lx35z>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <eo2iqix7vzrjgjs6bhx44s3rxblxorc4za62rrzaw5hqb5xqlh@uad7uc4lx35z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_013015_883597_4E09C20F 
X-CRM114-Status: GOOD (  17.59  )
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

On 2/21/24 16:37, Daniel Wagner wrote:
> On Wed, Feb 21, 2024 at 06:22:29AM +0000, Shinichiro Kawasaki wrote:
>> I found this changes makes the test case fail when the kernel does not have
>> CONFIG_HUGETLBFS. Without the config, /proc/sys/vm/nr_hugepages does not
>> exist.
>>
>> When CONFIG_HUGETLBFS is not defined, should we skip this test case?
> 
> Obviously, we should aim for really solid test cases. Though it is not
> guaranteed that the test will pass even with CONFIG_HUGETLBS enabled. I
> suspect we would need to make some more preparation steps that the
> allocation has a high change to pass. Though I haven't really looked
> into what the necessary steps would be. The sysfs exposes a few more
> knobs to play with.

"echo 3 > /proc/sys/vm/drop_caches" before mounting hugetlbfs should allow for
the big pages to fit... Still no guarantees but likely that will lower setup
failure frequency.

> 
>> If this is
>> the case, we can add "_have_kernel_option HUGETLBFS" in requires(). If not, we
>> should check existence of /proc/sys/vm/nr_hugepages before touching it, like:
>>
>>        if [[ -r /proc/sys/vm/nr_hugepages &&
>>                      "$(cat /proc/sys/vm/nr_hugepages)" -eq 0 ]]; then
> 
> Sure, I'll add this and also fix the typos in the commit message.
> 
>>
>> Also I suggest to add in-line comment to help understanding why nr_hugepages
>> sysfs needs change. Something like,
>>
>> # nvme-cli may fail to allocate linear memory for rather large IO buffers.
>> # Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
>> # from HugeTLB pool.
> 
> Ok.
> 

-- 
Damien Le Moal
Western Digital Research



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE48CF8873
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMmkCzSXIAM+PLZxbf+a1AidtWBAPGqD1VWOkXNMcPo=; b=GoWDQU2ndJFvQvLP48pjqD+11N
	eCHzAgfHGZKduPKPYVOmf4Uo8HOjU9LTAiNaSJF/L1wr299gipktKCfH5SluZnavgipt0ezGjEGuP
	9svyySehVVd2aY+fcleoS6wyBk0pS/s0DchoCl5YzJhumYWb9nVLwIQ6Tiej1iz8BSDK3YxzDUewb
	0t4DwZhK+7t2mBwZNaejr5hejNvua6Lf8Jn/wb7ljAyaUk69eAg7z33YU0VfjeAAcBJv06384Q+ju
	3lQCkYWwKl/71vlANupXanHNlc4MizKwvLrwFWaYYNAngWW2g9Sm6XS0u4M99lDkOsouro+wp0+6m
	9RiTm2Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sx000-0000000F0bB-0GlE;
	Sat, 05 Oct 2024 08:18:48 +0000
Received: from out-189.mta1.migadu.com ([95.215.58.189])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swzzw-0000000F0a6-37Vl
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 08:18:46 +0000
Message-ID: <21e1b842-7662-46cb-9da7-fe37a3b3119b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728116318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMmkCzSXIAM+PLZxbf+a1AidtWBAPGqD1VWOkXNMcPo=;
	b=ZUetfGHlSxiTqLvxg1v3AM+K64bVN20czslKjjbF5TywuBJdYVWyEu54jBenAtlpBhHE+F
	AKa18sJR8W0TwofNKhn89ulvAHbmynuArQ+cJgPHcLIlug7bjNHXXq5xQWfGNqYWCa7fxq
	zonkQB3gbpcaKde/TTazAA8GwkMpP3Y=
Date: Sat, 5 Oct 2024 16:18:06 +0800
MIME-Version: 1.0
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
 <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
 <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
 <b60fa0ab-591b-41e8-9fca-399b6a25b6d9@linux.dev>
 <c5c3c7d7-2db9-44fe-a316-b0b5bab30f1e@kernel.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <c5c3c7d7-2db9-44fe-a316-b0b5bab30f1e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241005_011845_671925_6AA3A8D2 
X-CRM114-Status: GOOD (  14.44  )
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


在 2024/10/5 9:41, Jens Axboe 写道:
> On 10/4/24 7:26 PM, Zhu Yanjun wrote:
>> ? 2024/10/5 0:31, Bart Van Assche ??:
>>> On 10/4/24 5:40 AM, Zhu Yanjun wrote:
>>>> So I add a jiffies (u64) value into the name.
>>> I don't think that embedding the value of the jiffies counter in the kmem cache names is sufficient to make cache names unique. That sounds like a fragile approach to me.
>> Sorry. I can not get you. Why jiffies counter is not sufficient to
>> make cache names unique? And why is it a fragile approach?
> 1 jiffy is an eternity, what happens if someone calls
> kmem_cache_create() twice in that window?

Got it. Thanks a lot.

Zhu Yanjun

>
>> I read your latest commit. In your commit, the ida is used to make
>> cache names unique. It is a good approach if it can fix this problem.
> That seems over-engineered. Seems to me that either these things should
> share a slab cache (why do they need one each, if they are the same
> sized object?!). And if they really do need one, surely something ala:
>
> static atomic_long_t slab_index;
>
> sprintf(slab_name, "foo-%ld", atomic_inc_return(&slab_index));
>
> would be all you need.
>
-- 
Best Regards,
Yanjun.Zhu



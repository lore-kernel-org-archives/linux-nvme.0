Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9B6EF48CA
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 04:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Date:
	Content-Type:To:In-Reply-To:Mime-Version:Message-Id:Subject:From:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vnI2EwY0aYjtueepJB2owejzWOQGYSlo3u7P0AqTyQM=; b=YFuB3NG30A9LGI3cNXYWonGByW
	4NJje9ZqG/dUPluTLGZzgzn2yAXO3WQwJ64WY2unIu05/bv3KAckK7JSHSCOsU6YVNM/hiz73R2yy
	pvBgxEcggpDQXYI5WTv54BKn6NG/yyaKBrsJDIfaGT6wpoude6ez7y2xlvy6nLA5GCVkpecYvGZvO
	7B7DdEErZA4FobQ9Z0WyVoi+R/z7D8ZAH5UPQaj9WacZUVOZYZCSlB6EzC+KliSy0dshij8DOql5M
	exfenAW2NnBoffUimWd+0yOZADi4yLDIHi164EH+asDZo7YRmWNyuOyQS3+9nkNNJGYsjBlxF1ijv
	n7EbFfBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqkTi-00000002wl9-2Lku;
	Fri, 13 Feb 2026 04:08:26 +0000
Received: from sg-1-12.ptr.blmpb.com ([118.26.132.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqkTf-00000002wdp-0Eua
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 04:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770955691;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=vnI2EwY0aYjtueepJB2owejzWOQGYSlo3u7P0AqTyQM=;
 b=IpqfGXDbA+XaHCYs+nvIoenLCVxVyhXJbGPR/SaVzGfucK5lcQXwNgBLfgmtM6hjA0WkVG
 7JQeI9k+Jcb4gXn4BKVdy9Wzq0/Kl3u4X9g5MUFf2gDzh0Hq/NPHbtevaWsHJ/qOhugiNZ
 IK4si996dTC/guK37CCoNemDZjboyU2S44WJ5uH/DMAn5eHiSepTaPJlKuCmpnDfEtZyZy
 5VmRrtgRuePicf/TUqyE45PDYiz+GOO9tD69chYdwWYrj5VBTXScGrzLVk9ICGfnPIa07U
 iwbDYXquqHP9myerxVStLCTS6NtQIZG1HRWCuW50t30X6H2UMyoqpAmq9HDang==
X-Lms-Return-Path: <lba+2698ea3a9+339442+lists.infradead.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Yi Zhang" <yi.zhang@redhat.com>, 
	"Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, 
	"Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH] blk-mq: use NOIO context to prevent deadlock during debugfs creation
Message-Id: <f3653533-4af9-4bcc-886d-7fb7b7015034@fnnas.com>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fnnas.com>
In-Reply-To: <88a12e1c-05b6-44de-806e-06a8e2ff7c0a@linux.ibm.com>
Received: from [192.168.1.104] ([39.182.0.132]) by smtp.feishu.cn with ESMTPS; Fri, 13 Feb 2026 12:08:08 +0800
To: "Nilay Shroff" <nilay@linux.ibm.com>, "Jens Axboe" <axboe@kernel.dk>, 
	<ming.lei@redhat.com>, <hch@lst.de>, 
	"Steven Rostedt" <rostedt@goodmis.org>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 12:08:06 +0800
User-Agent: Mozilla Thunderbird
References: <20260212080135.1673063-1-yukuai@fnnas.com> <88a12e1c-05b6-44de-806e-06a8e2ff7c0a@linux.ibm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_200823_901455_A502597F 
X-CRM114-Status: GOOD (  15.58  )
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
Reply-To: yukuai@fnnas.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi

=E5=9C=A8 2026/2/12 16:46, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 2/12/26 1:31 PM, Yu Kuai wrote:
>> Creating debugfs entries can trigger fs reclaim, which can enter back
>> into the block layer request_queue. This can cause deadlock if the
>> queue is frozen.
>>
>> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
>> to detect this condition, but it was racy since the queue can be frozen
>> from another context at any time.
>>
>> Introduce blk_debugfs_mutex_lock()/blk_debugfs_mutex_unlock() helpers
>> that combine the debugfs_mutex with memalloc_noio_save()/restore() to
>> prevent fs reclaim from triggering block I/O. Replace all raw
>> debugfs_mutex lock/unlock pairs with these helpers.
> It looks like there are still a few places where ->debugfs_mutex is
> taken but the code paths do not enter fs-reclaim. For those cases,
> it may not be necessary to wrap the critical section in a NOIO context.

I agree it's not necessary, however I also feel it doesn't matter.

>
> Perhaps it would make sense to provide two separate helper APIs: one
> that acquires ->debugfs_mutex and also saves/restores the NOIO context
> (using memalloc_noio_save()/restore()), and another that simply acquires
> and releases ->debugfs_mutex without entering NOIO. Callers could then
> choose the appropriate helper depending on whether the code path may
> trigger fs-reclaim.

I don't have preference here, I can do this in the next version.

>
> For reference,
> blk_mq_freeze_queue()/blk_mq_unfreeze_queue() vs
> blk_mq_freeze_queue_nomemsave()/blk_mq_unfreeze_queue_nomemrestore()
>
> Thanks,
> --Nilay

--=20
Thansk,
Kuai


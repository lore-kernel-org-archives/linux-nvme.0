Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E07CDB479
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 01:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nk+RbEX3vABDg6Ras4W0WVMsG3qs52+keVK6eAM+VuU=; b=URECwtRm3cT7K6ptOU7iVntGBa
	xSA2eFJCitdF9FMgIK+MXe6xQaXjEXCP8P/wuR/8xIjjNw+47zxb0mtO0HxzGQPw3RuzRtYNfOzRT
	bzTZE/jNlvH0Gh7E81Zm01xSQD9izZhH6uoGW+beigrXyms2+twGDjr8wcdn4O9xHYMEfDqw/JEMC
	lSy5BrZ5Dpann0i6v64Wc5RuNgw0hlp/7n00ZOyAKkS4Qti6/HgdeEcxUnur7tU76ph/ondWBQlYI
	lEa6kptO+D+A78xt8L6prolCGHNHKKcdsU0Y06Abr8mfb9mFE86Dmsb5sm1ci86Rdy73j1TaJQKoz
	iMbzKqpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcCXl-0000000725I-1ZXe;
	Wed, 24 Jun 2026 01:36:45 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcCXh-0000000724k-3zCE
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 01:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782264996; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nk+RbEX3vABDg6Ras4W0WVMsG3qs52+keVK6eAM+VuU=;
	b=mtwzl1fOM4IdlCAhEGXaD5/izoPYfZJp4T0cS+RFBziPHQKjJokCqrUYz53wXC1wh3Xrn36BCvlUGKvCs/OOGZ7v6wn5DdhtuLtuxL4JPuKDX81YWu+QgwdRH6h4xMvDdweoUqf+tiuFNe9qb7daRrEyBqW+vtuODmb2HQWh2nU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X5Vla-j_1782264992;
Received: from 30.178.83.21(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5Vla-j_1782264992 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 09:36:33 +0800
Message-ID: <5f8ea7b9-e57b-4b7f-a98b-08ec7f06cbcd@linux.alibaba.com>
Date: Wed, 24 Jun 2026 09:36:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: expose path_state via sysfs
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20260622130318.2346995-1-kanie@linux.alibaba.com>
 <ajp9gHepQX-j1-Lz@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ajp9gHepQX-j1-Lz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_183642_705922_8684F81E 
X-CRM114-Status: UNSURE (   7.63  )
X-CRM114-Notice: Please train this message.
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



在 2026/6/23 20:35, Keith Busch 写道:
> On Mon, Jun 22, 2026 at 09:03:18PM +0800, Guixin Liu wrote:
>> The attribute reflects the result of nvme_path_is_disabled() checks:
>>    - "enabled"                   : path is available for I/O
>>    - "disabled (ctrl_down)"      : controller is not live/deleting
>>    - "disabled (ana_pending)"    : ANA state change pending
>>    - "disabled (ns_not_ready)"   : namespace is not ready
> I'm a bit late to looking at this, but just a knee jerk thought,
> wouldn't you want to distinguish "enabled optimized" vs "enabled
> unoptimized"?
Sure, good idea, I will change this in v3, thanks.

Best Regards,
Guixin Liu



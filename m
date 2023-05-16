Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E512C7EE25
	for <linux-nvme@archiver.kernel.org>; Tue, 16 May 2023 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mckk/1eSa92UDNT9PM1pbNYpthKB9JMGKfwOo4DD6nA=; b=SFDzucwm3oHnRRPLabg2DGgXFd
	oBhh8lsdCYvbD1J9VvCaIaeHkhHu7mplRmBFdYkzVmHFGs3p5SCuFdjRmqoXwVoFtdJknkr2beHcW
	Pds5tDlcjQWhG38OgKWXJ4VB5B79R2VwUlCLAZPvaMjM26hAqjpTn6aI96TEYBOmjusU5s27pXCnV
	So11hCJY3+mTQ2GJgqO/JKZ6OnZr/fiRba9sa103WUXCWQuWlrcNuGHlrbOtLeKCZoSzgY7A8tXfy
	q3Y5ILDX07WtRSfrDFNVG03PkHFBV4ZVBiOPPC60KtG6LhwCED35bwS7EORKCUlZeIlJMRrhVkzFG
	jVhlTITQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyvGM-0061B9-1l;
	Tue, 16 May 2023 14:02:50 +0000
Received: from m126.mail.126.com ([220.181.12.36])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyvGH-00619o-0v
	for linux-nvme@lists.infradead.org;
	Tue, 16 May 2023 14:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=mckk/1eSa92UDNT9PM1pbNYpthKB9JMGKfwOo4DD6nA=;
	b=UVuTAVN8EAlFqT7Bsk6o0klJkk5GSdb8SseTtPe8g5EmM9GqqjePTszp8Mc4D7
	y29fIxvBC96iSThlG2MzwysikA9BzPhvWEnnGHnWwDZvLoCspWpCHXc2kTrgHJ9H
	nBvfMgXptKKmxKmMal7iBuwPeNYW6nufre0YQbboGvuzo=
Received: from [10.0.2.15] (unknown [120.244.62.38])
	by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wDn7AQhjGNke7aJAw--.14124S2;
	Tue, 16 May 2023 21:58:58 +0800 (CST)
Message-ID: <1d32a220-d941-6e67-58db-3e949d599812@126.com>
Date: Tue, 16 May 2023 21:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me, ahuang12@lenovo.com,
 sunjw10@lenovo.com
References: <20230502125412.65633-1-jiweisun126@126.com>
 <ZGKY1A1q5Px64v9h@kbusch-mbp>
From: Jiwei Sun <jiweisun126@126.com>
In-Reply-To: <ZGKY1A1q5Px64v9h@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn7AQhjGNke7aJAw--.14124S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWDAryxuryrJw1rWFyrtFb_yoW8CFy3pF
	Z7Jr9IkF1qvryftrZ7Cw4FgF1DZw4kKw43Grn7GryxAw1rW3sIqr4I9ws5uFyjvrZagryv
	yw1jq3s3Zr1DCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWc_fUUUUU=
X-Originating-IP: [120.244.62.38]
X-CM-SenderInfo: 5mlzvxpvxqijaw6rjloofrz/1tbijh1xjVpEI4KeTAAAsC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_070245_751828_1DC09F97 
X-CRM114-Status: GOOD (  16.28  )
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

Hi Keith,

On 2023/5/16 04:40, Keith Busch wrote:
> On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
>> From: Jiwei Sun <sunjw10@lenovo.com>
>>
>> A soft lockup issue will be triggered when do fio test on a 448-core
>> server, such as the following warning:
> ...
>
>> According to the above two logs, we can know the nvme_irq() cost too much
>> time, in the above case, about 4.8 second. And we can also know that the
>> main bottlenecks is in the competition for the spin lock pool->lock.
> The most recent 6.4-rc has included a significant changeset to the pool
> allocator that may show a considerable difference in pool->lock timing.
> It would be interesting to hear if it changes your observation with your
> 448-core setup. Would you be able to re-run your experiements that
> produced the soft lockup with this kernel on that machine?
We have done some testes with the latest kernel, the issue can not be 
reproduced,
and we have analyzed the ftrace log of nvme_irq, we did NOT find any 
competition for
the spin lock pool->lock, and all the dma_pool_free function completed 
within 2us.

  287)               |        dma_pool_free() {
  287)   0.150 us    |          _raw_spin_lock_irqsave();
  287)   0.421 us    |          _raw_spin_unlock_irqrestore();
  287)   1.472 us    |        }
+-- 63 lines: 287)               |        mempool_free() {-----------
  435)               |        dma_pool_free() {
  435)   0.170 us    |          _raw_spin_lock_irqsave();
  435)   0.210 us    |          _raw_spin_unlock_irqrestore();
  435)   1.172 us    |        }
+--145 lines: 435)               |        mempool_free() {---------
  317)               |        dma_pool_free() {
  317)   0.160 us    |          _raw_spin_lock_irqsave();
  317)   0.401 us    |          _raw_spin_unlock_irqrestore();
  317)   1.252 us    |        }

Based on the test results and analysis of the code principles, your 
patch has fixed this performance issue.

By the way, another task hung issue was triggered in the test. We are 
analyzing it, but this is another story,
we can discuss it in other thread.

Thanks,
Regards,
Jiwei



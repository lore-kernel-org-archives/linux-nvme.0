Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02355C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ju0CbMkQoDNKqp7ipEqWc0aXC0Km3KIFa+IXTdTSXKI=; b=m2Qw8PMU81tzA//VEw6gnesxu9
	4T6J18CCNy+ulTUE9YDce0oGWP5NlFTnyR//0mXru5fLt/v9En2X7RaVsTegwqBS7xNpJLYBQ+ft0
	qTjBFUjZFfcG7owTs+76k1Ac7oKQruoze6JuSKVlXygBmv5FmaLzDSZtobPBhpIh6TgqULKcesdz7
	AZ1MypP3fq03l9tZd2bqaHcPL6nxXoAECXd9HsiqgB8z1ZyCTj+2cQyh9QsdrAJ3KdlUSwqRIzF7u
	SWhEcBrao2uRI1Dia7s6nzzeMR6kGrAR9j65g7c/e6C8J7WSTSB5p9Hg3p3FTFIpjxad+B0sLFAlf
	MjxGcp5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUwe-00Brpr-BY; Tue, 06 Sep 2022 09:32:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUwd-00Bro7-Du
	for linux-nvme@bombadil.infradead.org; Tue, 06 Sep 2022 09:32:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ju0CbMkQoDNKqp7ipEqWc0aXC0Km3KIFa+IXTdTSXKI=; b=H0k/KueEDgqGCW1jUQXaNTbuxq
	MMes2I2RDLXLtIUKTXCDow61+T8trE/Ou+lsBKnBbjIhclUDIY8A5F8hR/u1qEqtkBrIvkDkmu9EH
	7TooRCZoeQp8ZC7NqlcT4+GimrLodl2OZaMmAuXuGrWXDsjejTD30iPHn/HmIelZlCIAy5Jtj6egW
	rA9kUIFJEAkUdO9xGldp4dz8bBX4utt6gN8ZDHjbjUYPXnkfGPtzPbQNCAqvppF9guYWCzA8GomxD
	IcncpE6P5qr0ZQFxD55Id5JBpcXakgfZ3K72y98Ri5U0BeJ+bcpgfNrGldM2qfD6qjmmfRz1E2QwJ
	idSV9Q0g==;
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUwS-00A7XB-Ok
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 09:32:28 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMKpd6GL9znVB0;
	Tue,  6 Sep 2022 17:29:29 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 17:32:02 +0800
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
To: Ming Lei <ming.lei@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>, Yi Zhang
	<yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch
	<kbusch@kernel.org>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
 <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com> <YxcIkV2slhTR9MHX@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <5656419a-6271-b387-3e75-4dcb70047545@huawei.com>
Date: Tue, 6 Sep 2022 17:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YxcIkV2slhTR9MHX@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_103225_629482_14FFE5A7 
X-CRM114-Status: GOOD (  15.09  )
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



On 2022/9/6 16:45, Ming Lei wrote:
> On Thu, Aug 25, 2022 at 06:02:33PM +0800, Chao Leng wrote:
>>
>>
>> On 2022/8/21 16:47, Ming Lei wrote:
>>> From: Keith Busch <kbusch@kernel.org>
>>>
>>> In some corner cases[1], freeze wait and unfreeze API may be called on
>>> unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
>>> freeze APIs more reliably, then this kind of issues can be avoided.
>>> And similar approach has been applied on stopping/quiescing nvme queues.
>> This leads to another problem: the process that needs to be
>> in the frozen state is not actually frozen.
>> It's not safe.
> 
> The flag is just to control if queue wait is needed, blk_mq_freeze_queue_wait
> can be done only the flag is set. Not sure how it isn't safe.
I thought that the use of NVME_NS_FREEZE was the same as NVME_NS_STOPPED.
If just set_bit in nvme_start_freeze, it will cause another problem in
below scenario.
A: start freeze and set the bit;B:start freeze and set the bit;
and then
A:test and clear the bit, and unfreeze;B: test and skip;
The queue will be frozen for ever.

In addition, I think patch 2/2 can fix the bug well, patch 1/2 is not necessary.
No matter how to use NVME_NS_FREEZE , it may cause problems.
The freeze mechanism is perfect, and no additional protection mechanism is required.
> 
> Meantime calling blk_mq_freeze_queue_wait() on queue not being started
> to freeze is usually a bug, and I think WARN_ON_ONCE() can be added
> in nvme_wait_freeze().
> 
> 
> Thanks,
> Ming
> 
> .
> 


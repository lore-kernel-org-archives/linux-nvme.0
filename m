Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A4AC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dhbs22+bX7/l5Zi23/3PAU161vuDgztAw21RQs/FhxQ=; b=I9tmhR6MMwb962QSVmff73DR/D
	amkdQv2p193JXIU7AvmkVumr+QGAADb4E5E3AMAgI23s0Lqlub18NM2cL3hEaXq7r+9w7IkJT/6Zg
	ZHK7ueqK2KG4bJbedfuMf16YDlSiD1ZXHqQ59jvBc9BlufSxK+ATH0+iNwj4TwZGiwwxac8eph2xo
	1k0h8EzuDPTkw9seF0Svwzjr3NBddEeJkhkGlqN3X0hi17xByg6m9WaQiBCZHwi6ng7r/gyEdMvGk
	Jjkv1fNog+O/SnUd9JIc0c/0JRFKL+6rUMnnoCpdQj/Bw/tiFNMRWi78+WACZpnXtLTqraw2S5V9j
	zSikZV0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olS3p-00D6Y6-5Z; Thu, 20 Oct 2022 09:41:57 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olRz1-00D3Mw-Un
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 09:37:01 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtMnL59VpzmVFl;
	Thu, 20 Oct 2022 17:32:06 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:36:22 +0800
Subject: Re: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
To: Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<sagi@grimberg.me>, <kbusch@kernel.org>, <axboe@kernel.dk>,
	<ming.lei@redhat.com>, <paulmck@kernel.org>
References: <20221020035348.10163-1-lengchao@huawei.com>
 <20221020063448.GA6246@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <6491f977-95f2-e40e-aa8b-d0671b517903@huawei.com>
Date: Thu, 20 Oct 2022 17:36:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020063448.GA6246@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_023700_240490_00882C41 
X-CRM114-Status: GOOD (  12.66  )
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



On 2022/10/20 14:34, Christoph Hellwig wrote:
> I though the conclusion from last round was to move the srcu_struct to
> the tagset?
If move the srcu_struct to the tagset, may loss the flexibility.
I am not sure that it is good for other modules currently using blk_mq_quiesce_queue.
Another, I am not sure if there will be a future scenario where blk_mq_quiesce_queue
will have to be used, and if it is good for such scenario.
It is a acceptable cost to allocate a temporary array for SRCU, the max memory size
is actually a few hundred KB, and most of the time it's less than a few KB.
So I did not move the srcu_struct to the tagset in patch V3.

It sounds like a good idea that explore moving the srcu_struct to the tag_set,
But we may need more time to analysis it.
I suggest that do the optimization in a separate patch set.
> 
> .
> 


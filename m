Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EF1C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXHp04IHa6+5JI3YI2C8K37BO/BZZXEOcA3tFRo+1PU=; b=HD3a1/4OaStGILox6hRcY5SHiW
	A/QshwdnyUOeqGo30+a9yFx4Yr5ic07c3Cwi87CnDbooAKYRfJ9JhaOvAOsnUHRoZslca6fmpXFEk
	ZCoCkiNCFONuYnxwzMsYRkpO3tDyo7JSoasvpmuGeiGwvtNjopjr5vYEdIqvzt/sdPssH9V3ypmCd
	P8LEUTnMdneGgadMy009WungVfC71VwA/Q0BZObHSYXN9b1r0wLu6TQQPmk0onsOIWl0Sg8HsOLHw
	h8Rlx+XHiDh0HCp8OjPsLR6j7MXxtcTZ0dTCWpZfTEPikA3qHotTHj1Pa+iDOuv5wj3VqRLabiGen
	w8nl4Krw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okjGF-005IPl-Kw; Tue, 18 Oct 2022 09:51:47 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okjGC-005IBX-Qd
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 09:51:46 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ms8Fk5HHhzJn2S;
	Tue, 18 Oct 2022 17:48:58 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:51:04 +0800
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<kbusch@kernel.org>, <ming.lei@redhat.com>, <axboe@kernel.dk>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
 <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
 <20221017134335.GA24959@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <50737260-4865-68f9-9bfe-a3de3d89f21d@huawei.com>
Date: Tue, 18 Oct 2022 17:51:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221017134335.GA24959@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_025145_061978_916AD044 
X-CRM114-Status: UNSURE (   9.50  )
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



On 2022/10/17 21:43, Christoph Hellwig wrote:
> On Thu, Oct 13, 2022 at 01:28:37PM +0300, Sagi Grimberg wrote:
>>> Because some queues never need to be quiesced(e.g. nvme connect_q).
>>> So introduce QUEUE_FLAG_NOQUIESCED to tagset quiesce interface to
>>> skip the queue.
>>
>> I wouldn't say it never nor will ever quiesce, we just don't happen to
>> quiesce it today...
> 
> Yes.  It really is a QUEUE_FLAG_SKIP_TAGSET_QUIESCE.
I will modify it in patch V3.
> 
> 
> .
> 


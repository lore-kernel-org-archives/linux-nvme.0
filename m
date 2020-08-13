Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57190C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 03:45:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C022053B
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 03:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eqwzkXqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C022053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lNmqGnEKFZ/oVEw9X8uvcN0JzTfrSHfwjtUHCDG9F7k=; b=eqwzkXqyzLrS9TvdcUKdJ5MU7
	lDbwCD5WIv2sul+aQJ7/YATXRR1s8hSWBK+JS1taiQdNgWuYx2Y33eZ67r/dFcnNnVhHmeTxwCBCF
	2IZHy96rKh2YTwhJh9pdGcORnhzjuMNcZoxzbkr9AbDNr9AtMi163UpehJCqSjswtPGZ5pnb76xis
	ITUfVXKWZ7DBzog7v62aGKwvnyypPyIct+1JMmHhy2c2qlwJLPh5is8+daLcUQI5MCZDUy/KSOHvs
	f+OR8A1TOWCjAvHOXx3WmButYPZmzYdHFFrPLDCh4wspoU0llzFko/TGSyAqqSjOmKJCDX1jUd4GG
	RKAAuFGxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k64Bb-0002ok-2h; Thu, 13 Aug 2020 03:45:51 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k64BY-0002o3-Ks
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 03:45:49 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7EB4E69DEF4760746660;
 Thu, 13 Aug 2020 11:45:43 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 13 Aug 2020 11:45:42 +0800
Subject: Re: [PATCH 1/3] nvme-core: fix io interrupt caused by non path error
To: Christoph Hellwig <hch@lst.de>
References: <20200812081837.22144-1-lengchao@huawei.com>
 <20200812150939.GA29544@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <dfb86f35-45e6-56d3-89c8-51fe443782a1@huawei.com>
Date: Thu, 13 Aug 2020 11:45:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200812150939.GA29544@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_234548_938370_766BBCB4 
X-CRM114-Status: GOOD (  13.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/12 23:09, Christoph Hellwig wrote:
> On Wed, Aug 12, 2020 at 04:18:37PM +0800, Chao Leng wrote:
>> For nvme multipath configured, just fail over to retry IO for path error,
>> but maybe blk_queue_dying return true, IO can not be retry at current
>> path, thus IO will interrupted.
>>
>> For nvme multipath configured, blk_queue_dying and path error both need
>> fail over to retry. We need check whether path-related errors first, and
>> then retry local or fail over to retry.
> 
> Err, no.  None of this really makes any sense.  The existing code
> actually works perfectly well unless you really insist on trying to
> use a completley unsupported multipathing configuration.  I would
> storngly recommend to not use dm-multipath with nvme, but if you
> insist please fix your problems without impacting the fully supported
> native path.
The scenario: IO already return with non path error(such as
NVME_SC_CMD_INTERRUPTED or NVME_SC_DATA_XFER_ERROR etc.), but is waiting
to be processed, at the same time, delete ctrl happens, delete ctrl may
set queue flag: QUEUE_FLAG_DYING when call nvme_remove_namespaces. Then
for example, if fabric is rdma, delete ctrl will call
nvme_rdma_delete_ctrl, nvme_rdma_delete_ctrl will drain qp first, thus
the IO, which return with non path error, can not be failover retry,
and also can not retry local, IO will interrupt.
Another solution can also avoid it: nvme_rdma_delete_ctrl first disable
irq instead of drain qp, then cancel all io(set path error), thus
nvme multipath will failover retry. There may be a little flaw: if
io complete success, which is waiting to be processed, will also be
canceled and failover retry.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

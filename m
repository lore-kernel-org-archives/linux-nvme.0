Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0623C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 02:17:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7E32068F
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 02:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gr19t+Ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7E32068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BiheZ7bxoqPoTabQMmnJIFjkx0GkcH53kirGX6Jqckc=; b=gr19t+UxIw2FsG0ZDQPxRvZzY
	7EWW+K2qUNE3TIqge9gP8oZGSF5EYUWGLDlHEeA/1dQkR0wX4rxFiC2WHAsK/DYCd+EXQDrILIi0M
	RH1AEs/GBecYff2zwNmCZVhMi1MJYLBOH8ONnXXr/I1/Bcuodr3alCe4DiQWdpcgeqknfagmKuHSk
	kWp2nVTrvqkSb204vTYxd3YgJb+WVN43wv+spEpTDWMK/5epE6YeOUVNov2QFMcSiMdIXt/tNPDQ3
	QItP+f3IDHpLmcRcroBzv8Wn+nqkH3fVbdBv8yasCYAWvDW4N3jL5DtF1TMxmlDbhCBcIlxXXpeps
	q9haIO2Yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4xNR-0004Oo-LT; Mon, 10 Aug 2020 02:17:29 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4xNL-0004Nv-Mc
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 02:17:24 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9FC9B9E183C1994204DD;
 Mon, 10 Aug 2020 10:17:07 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 10 Aug 2020 10:17:05 +0800
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
To: Ming Lei <ming.lei@redhat.com>
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
Date: Mon, 10 Aug 2020 10:17:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807134932.GA2122627@T590>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200809_221724_023114_9FBF9CCE 
X-CRM114-Status: GOOD (  12.61  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/7 21:49, Ming Lei wrote:
> On Fri, Aug 07, 2020 at 05:05:59PM +0800, Chao Leng wrote:
>> nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
>> one, if there is lots of name spaces, sync wait long time(more than 10s).
>> Multipath can not fail over to retry quickly, cause io pause long time.
>> This is not expected.
>> To reduce quiesce time, we introduce async mechanism for sync SRCUs
>> and quiesce queue.
>>
> 
> Frankly speaking, I prefer to replace SRCU with percpu_refcount:
> 
> - percpu_refcount has much less memory footprint than SRCU, so we can simply
> move percpu_refcount into request_queue, instead of adding more bytes
> into each hctx by this patch
> 
> - percpu_ref_get()/percpu_ref_put() isn't slower than srcu_read_lock()/srcu_read_unlock().
> 
> - with percpu_refcount, we can remove 'srcu_idx' from hctx_lock/hctx_unlock()
IO pause long time if fail over, this is a serios problem. we need fix
it as soon as possible. SRCU is just used for blocking queue,
non blocking queue need 0 bytes. So more bytes(just 24 bytes) is not
waste.

About using per_cpu to replace SRCU, I suggest separate discussion.
Can you show the patch? This will make it easier to discuss.
> 
> Thanks,
> Ming
> 
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

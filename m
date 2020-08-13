Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F7CC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 04:06:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9396D2076C
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 04:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R6l3L0rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9396D2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PQ6nqTOxv1W+fBiHDJRzCeWVa3zA5Pxyq46SI0agiQ4=; b=R6l3L0rEJRa+dGeNEQ8N7NOgj
	bMan3wkyG5r1cJqlgqgz88jcKVWZuaP6QT7RFKuzKhREC3Hy9nNy78uWIEEPTuisJeRjyl0FYK2S2
	o72rHVD1E5XwoM9qFvdrm4wa/k0Gx2/5nOO4dC1bfpGkqoKOrV1oH2e1U775k+5ai/CnVvsN+/66U
	DMTZVPUbsCjkZ5EAPp/w0HyXMibNzvPpHIVKs2yVQeQJ+plN7sX4RdMwooWl3iOUoteqvcYPlvQ2C
	1zs+b63mV7UGgRbzi6FxtmdLpNzO8zPLpI8hr92CjvMdnxBaC6h94Ca599PBeyN/0yF6zcg53qG6f
	pjo2Z8nIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k64Vv-0004ua-Ea; Thu, 13 Aug 2020 04:06:51 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k64Vr-0004tz-0c
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 04:06:49 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id AEF81B41A5826F961353;
 Thu, 13 Aug 2020 12:06:35 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 13 Aug 2020 12:06:13 +0800
Subject: Re: [PATCH 3/3] nvme-core: delete the dependency on
 REQ_FAILFAST_TRANSPORT
To: Christoph Hellwig <hch@lst.de>
References: <20200812081855.22277-1-lengchao@huawei.com>
 <20200812151340.GC29544@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <f7301c1a-909c-d090-95f9-34af76154547@huawei.com>
Date: Thu, 13 Aug 2020 12:06:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200812151340.GC29544@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_000647_862879_CC45A5EF 
X-CRM114-Status: GOOD (  16.77  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/12 23:13, Christoph Hellwig wrote:
> On Wed, Aug 12, 2020 at 04:18:55PM +0800, Chao Leng wrote:
>> REQ_FAILFAST_TRANSPORT may be designed for scsi, because scsi protocol
>> do not difine the local retry mechanism. SCSI implements a fuzzy local
>> retry mechanism, so need the REQ_FAILFAST_TRANSPORT for multipath
>> software, if work with multipath software, ultraPath determines
>> whether to retry and how to retry.
>>
>> Nvme is different with scsi about this. It define local retry mechanism
>> and path error code, so nvme should retry local for non path error.
>> If path related error, whether to retry and how to retry is still
>> determined by ultraPath. REQ_FAILFAST_TRANSPORT just for non nvme
>> multipath software(like dm-multipath), but we do not need return an
>> error for REQ_FAILFAST_TRANSPORT first, because we need retry local
>> for non path error first.
> 
> This doesn't look wrong, but these kinds of changes really need to
> go along with block layer documentation of the intended uses of the
> flags.  In fact the SCSI usage also looks really confused to me and at
> very least needs better documentation if not changes.  So I think
Yes, SCSI do not define local retry, so complex processing logic is
required.
> you need to do a lot code archaeology, ping the authors and current
> maintainers and sort this out as well.
Now REQ_FAILFAST_TRANSPORT just used for multipath software, the patch
use the advantages of nvme, looks no bad effect.
> 
> More importantly if the above explanation makes sense we really need
> to kill blk_noretry_request off entirely and replace it with a check
> of the right set of flags in each caller as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

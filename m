Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1C2D24466
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 02:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=obbf1ElIuLKuY5so2Q36cZAcpCAlgXWWovjXptITjfw=; b=kU6sE+z178exy2hephemDAFjvb
	osKtV8qadstaPztenfrXB8VibMZ50vmCNqbr8BPrhYbFlDUMt5kDLFBvT7TvgXRMQc2IgJi55WHsB
	rUz5D6DVn9HBpNckf/6HaaN6TIktQpjLC4ZicPRRjln/Lgu3dVGH/o7eABaG16EJ2lIj57jpldEkq
	bWVPg9UNXfLu/6dP8qoWeWf/nUZYFkRJhN9+z1gptxHXMFW87V796h6ymKDubqMLmVwVMQFJGiwhB
	lTa9k3o4fGRjYc2/ug4Zy9SlnnBqZEKxsCxRVZIMHwM+UZEvJdqa/QA8FoOcvaxzmIpAWb/cYklT2
	DUKpFxTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz5IG-0000000F2JQ-29yG;
	Fri, 11 Oct 2024 02:22:16 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz5ID-0000000F2J3-2wOp
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 02:22:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728613328; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=obbf1ElIuLKuY5so2Q36cZAcpCAlgXWWovjXptITjfw=;
	b=HXGAxMYXtRg9VngPB5MeKrbihTimEK8BSeSxH75MUiovzSHohkiyRi9j0XdCfIc9WXeP9JC0/gz011DAdFzClgcM2N+oGLb0iLRMad7fre36eRueHhT8EqAJCBQwSLAr0shcPwyKltxR4eyVWd05X8Pb7xcgYZKZDga0e+N2H04=
Received: from 30.178.81.214(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGoInhv_1728613326 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 10:22:07 +0800
Message-ID: <87da756f-ef7a-44d7-bf92-3800f70da5d9@linux.alibaba.com>
Date: Fri, 11 Oct 2024 10:22:04 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v13 2/2] nvmet: support reservation feature
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, d.bogdanov@yadro.com,
 linux-nvme@lists.infradead.org
References: <20241008102114.26199-1-kanie@linux.alibaba.com>
 <20241008102114.26199-3-kanie@linux.alibaba.com>
 <20241010093041.GB9749@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241010093041.GB9749@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_192214_383288_571D4EEF 
X-CRM114-Status: GOOD (  14.63  )
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


在 2024/10/10 17:30, Christoph Hellwig 写道:
> On Tue, Oct 08, 2024 at 06:21:14PM +0800, Guixin Liu wrote:
>> This patch implements the reservation feature, includes:
> s/includes/including/
Sure, change to "including".
>> 1. reservation register(register, unregister and replace).
>> 2. reservation acquire(acquire, preempt, preempt and abort).
>> 3. reservation release(release and clear).
>> 4. reservation report.
>> 5. set feature and get feature of reservation notify mask.
>> 6. get log page of reservation event.
> Maybe indent this bulleted list (and the other ones) by two characters
> to make it more readable?
Indeed.
>> Not supported:
>> 1. persistent reservation through power loss.
>>
>> Test:
> Tested-by:

Well, I found that "Tested-by: " will be recognized by checkpatch.pl,

it reports warning and error:

WARNING: Use a single space after Tested-by:
#17:
Tested-by:

ERROR: Unrecognized email address: ''
#17:
Tested-by:


I will change "Test" to "Test cases".

>> Use nvme-cli and fio to test all implemented sub features:
>> 1. use nvme resv-register to register host a registrant or
>> unregister or replace a new key.
>> 2. use nvme resv-acquire to set host to the holder, and use fio
>> to send read and write io in all reservation type. And also test
>> preempt and "preempt and abort".
>> 3. use nvme resv-report to show all registrants and reservation
>> status.
>> 4. use nvme resv-release to release all registrants.
>> 5. use nvme get-log to get events generated by the preceding
>> operations.
> That's still very basic testing, but I have no really good answer
> what good test suite would be.
>
>> +static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
>> +					const char *page, size_t count)
> The indentation used in most nvme code is two tabs for prototype
> continuations, can you change to that? I.e.:
>
> static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
> 		const char *page, size_t count)
OK, I will change this in v14.
>> +#define NVMET_PR_NOTIFI_MASK_ALL \
>> +		(1 << NVME_PR_NOTIFY_BIT_REG_PREEMPTED | \
>> +		 1 << NVME_PR_NOTIFY_BIT_RESV_RELEASED | \
>> +		 1 << NVME_PR_NOTIFY_BIT_RESV_PREEMPTED)
> And here I'd expect a single tab indent.
OK.
>
> Except for these nitpicks the code looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, I will send v14 soon.

Best Regards,

Guixin Liu



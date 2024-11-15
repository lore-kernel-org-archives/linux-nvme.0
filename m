Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B595DD6A225
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 01:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ydp2QaLlN5J2sPIaa3o4joQEGnket0TTXriDK4ovWxc=; b=F3hBluZH3fx3iUYCBDdr0tFn/c
	3mLlTTxLMzkzhSOiTBL9IMQ4Bn4DJ2Gm0Ne+SYTstW6VzBvpiDcQwNXgDvQLPveUHoIawQUuKbpTk
	vXMyAwHEK0ld2umNJ+zM4+kroyz7S20b7fLdJAAxlwEhuLtY0CmjJdBWiE156Uno2sm8I8AY7jENZ
	XBV38pumkDFCQVcHJtYXqOZfvL+fJX4gHOoW18LiMwi9Re8byUld4UuNZz/SwTaaVD93wpDmOWOXk
	6n5bjRx5/9ZJkxjDS8JoogDxVvdmUTTA9Yg/Ym08uU4RQSYJba6NHC3uEZDZAXN+dz4644sh63M3W
	hmjlVCqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBlMP-00000001KSZ-0cDC;
	Fri, 15 Nov 2024 01:42:57 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBlMN-00000001KS1-1DMA
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 01:42:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731634973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydp2QaLlN5J2sPIaa3o4joQEGnket0TTXriDK4ovWxc=;
	b=siC8z4rCz7BWufrPK+ds674RJsOCIvUG1Ey5Fi3ON9Aa2LKOSB/VWsEqVJV/rLX99HhWCr5eJKeezghOgSUzriUTpoCYA29JHK0V0q2lmjpLb6ku9wTaJnO2DbBJYu2Cgd2q92uLHJd8kLGcKqPO1ydDfBv3bEl0KAtwqvzrZR8=
Received: from 30.178.81.254(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJQetod_1731634970 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 09:42:51 +0800
Message-ID: <7b4e087f-03b5-42f0-91f9-7393eabbfaf6@linux.alibaba.com>
Date: Fri, 15 Nov 2024 09:42:50 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH RESEND v3 1/2] nvme-multipath: introduce service-time
 iopolicy
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20241114084957.41787-1-kanie@linux.alibaba.com>
 <20241114084957.41787-2-kanie@linux.alibaba.com>
 <b28f56ff-02ba-4fa0-9ee3-329fadac9997@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <b28f56ff-02ba-4fa0-9ee3-329fadac9997@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_174255_540539_39CF9D14 
X-CRM114-Status: UNSURE (   9.69  )
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


在 2024/11/14 18:53, Chaitanya Kulkarni 写道:
> On 11/14/24 00:49, Guixin Liu wrote:
>>    
>> +static struct nvme_ns *nvme_service_time_path(struct nvme_ns_head *head)
>> +{
>> +	struct nvme_ns *opt = NULL, *nonopt = NULL, *ns;
>> +	unsigned int min_inflight_nonopt = UINT_MAX;
>> +	unsigned int min_inflight_opt = UINT_MAX;
>> +	unsigned int inflight;
>> +
>> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
>> +		if (nvme_path_is_disabled(ns))
>> +			continue;
>> +
>> +		inflight = atomic64_read(&ns->ctrl->inflight_size);
> atomic64_read has return type s64, is there any particular reason not to use
> s64 ? OR
>
> even u64 as it is used in many places in kernel ? OR
>
> conversion from s64 to unsigned int is done intentionally ?
>
> -ck
>
Changed in v4, thanks.

Best Regards,

Guixin Liu



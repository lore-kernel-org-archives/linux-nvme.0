Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529BC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:08:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F2764DFA
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F2764DFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i0AcG2Z9LNtLzI/Am5eawZ3O/jcYKRZxKnEMUUFiROk=; b=tNAPOPFEc+67jKZE6WKzpVq3G
	4Vd3S5+nvBD9+6Aqas0ZMlXVI2m7/0ietl/MLmlo1eSDU4gtOiEQHIM3s8MCYuqO2nrGp0KSMUAg1
	8MmKnJCGy/PnG3y7uhc7EGjrAlxiOcmBrVDSDJpHxjyuqz5/YMS0nHQ4mqVNelPbCu5H9JW3cfY8H
	l6PLfUB/xjx5py09m0mEpeeCczaFEVOQkBbEKbYPLBm5BnyRpVeDxCslgRkiI/WYz5Qpv1GPMWzKw
	F/Emoj0b1Jbzmy11BCmA6PH0i16zObzOuZ+f4a6scdmw9vzGlXsazywW5JtE4I5wV72HDIh6v3/BV
	Xm0Yu3yLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5K8q-0008IR-8E; Fri, 29 Jan 2021 03:08:12 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5K8n-0008Hs-MP
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 03:08:11 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DRj0845LQz13mVC;
 Fri, 29 Jan 2021 11:06:00 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 11:08:00 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 11:07:59 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
Date: Fri, 29 Jan 2021 11:07:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_220810_126649_1119D83D 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, Jens
 Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/29 9:42, Sagi Grimberg wrote:
> 
>>> You can't see exactly where it dies but I followed the assembly to
>>> nvme_round_robin_path(). Maybe it's not the initial nvme_next_ns(head,
>>> old) which returns NULL but nvme_next_ns() is returning NULL eventually
>>> (list_next_or_null_rcu()).
>> So there is other bug cause nvme_next_ns abormal.
>> I review the code about head->list and head->current_path, I find 2 bugs
>> may cause the bug:
>> First, I already send the patch. see:
>> https://lore.kernel.org/linux-nvme/20210128033351.22116-1-lengchao@huawei.com/
>> Second, in nvme_ns_remove, list_del_rcu is before
>> nvme_mpath_clear_current_path. This may cause "old" is deleted from the
>> "head", but still use "old". I'm not sure there's any other
>> consideration here, I will check it and try to fix it.
> 
> The reason why we first remove from head->list and only then clear
> current_path is because the other way around there is no way
> to guarantee that that the ns won't be assigned as current_path
> again (because it is in head->list).
ok, I see.
> 
> nvme_ns_remove fences continue of deletion of the ns by synchronizing
> the srcu such that for sure the current_path clearance is visible.
The list will be like this:
head->next = ns1;
ns1->next = head;
old->next = ns1;
This may cause infinite loop in nvme_round_robin_path.
for (ns = nvme_next_ns(head, old);
	ns != old;
	ns = nvme_next_ns(head, ns))
The ns will always be ns1, and then infinite loop.
> .

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

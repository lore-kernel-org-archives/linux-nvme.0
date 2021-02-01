Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E38AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 09:40:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CDE64EAE
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 09:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CDE64EAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+e1qSU8Z6tCe/ubreAX4iLXzJvD5EPcQMSTxkZNde+s=; b=mFdSba6eNjQkjJZoWWl9Izqkw
	Xjy5uNYl9FN2TzRMBWXJGBOWOQYfv8b3kR4EVIhez883qCIFbpDsWWFxGLtcvy87KmdEInzQbKLwA
	u6QNdUuzIwpc5Vm6U98+bou8sPqAjIsy5UI4wjHE/LzB8nVFIllLJ6j4igTjA/xTdAPbVtC23eHHy
	ulkkEb5oJJaKNgcoQUlX3DXTeKvL/suzhfis4oD/DIChGxZ/NKbEcVSWaFoijH+2ENqiJaPkD77MJ
	p4DEojD3/wtkDnfWumRIDe/MABTKn6DqL3EXzQeNclv2L95CfaEjhZGE9/46ysAOPWLdU/9rHiki4
	QZQQfguVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6VhV-0000GT-W2; Mon, 01 Feb 2021 09:40:54 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6VhR-0000EU-JU
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 09:40:51 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DTjZj05Nwz5NJk;
 Mon,  1 Feb 2021 17:39:25 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 1 Feb 2021 17:40:41 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Mon, 1 Feb
 2021 17:40:40 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, "Daniel
 Wagner" <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
 <65392653-6b03-9195-f686-5fe4b3290bd2@suse.de>
 <81b22bbf-4dd3-6161-e63a-9699690a4e4f@huawei.com>
 <715dd943-0587-be08-2840-e0948cf0bc62@suse.de>
 <eb131d8f-f009-42e7-105d-58b84060f0dd@huawei.com>
 <ac019690-7f02-d28c-ed58-bfc8c1d48879@suse.de>
 <6ceff3cb-c9e9-7e74-92f0-dd745987c943@huawei.com>
 <114751ac-1f7d-ce5e-12c5-7d6303bdb999@suse.de>
 <aebc6c2d-4711-95ba-daf2-1cd17fc6f0e7@huawei.com>
 <47a1b796-9d91-5947-4bac-dd8f397041a3@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <bd37abd5-759d-efe2-fdcd-8b004a41c75a@huawei.com>
Date: Mon, 1 Feb 2021 17:40:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <47a1b796-9d91-5947-4bac-dd8f397041a3@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_044051_082613_4C50FBF0 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/2/1 16:57, Hannes Reinecke wrote:
> On 2/1/21 9:47 AM, Chao Leng wrote:
>>
>>
>> On 2021/2/1 15:29, Hannes Reinecke wrote:[ .. ]
>>> Urgh. Please, no. That is well impossible to debug.
>>> Can you please open-code it to demonstrate where the difference to the current (and my fixed) versions is?
>>> I'm still not clear where the problem is once we applied both patches.
>> For example assume the list has three path, and all path is not NVME_ANA_OPTIMIZED:
>> head->next = ns1;
>> ns1->next = ns2;
>> ns2->next = head;
>> old->next = ns2;
>>
> And this is where I have issues with.
> Where does 'old' come from?
> Clearly it was part of the list at one point; so what happened to it?
I explained this earlier.
In nvme_ns_remove, there is a hole between list_del_rcu and
nvme_mpath_clear_current_path. If head->current_path is the "old", and
the "old" is removing. The "old" is already removed from the list by
list_del_rcu, but head->current_path is not clear to NULL by
nvme_mpath_clear_current_path.
Find path is race with nvme_ns_remove, use the "old" pass to
nvme_round_robin_path to find path.
> 
> Cheers,
> 
> Hannes

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

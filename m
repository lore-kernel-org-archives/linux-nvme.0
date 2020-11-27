Return-Path: <SRS0=q43r=FB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27B6C63798
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2020 01:27:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BAA2220B
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2020 01:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="on108kTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BAA2220B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wQf1YO0A0Uz1ZdGulG2HpU2X8YMPoFA4PkzNFrWfEdo=; b=on108kTrmcqNvga8tpoH0Z9tk
	dSuUZ0OW+FJ/p8DMVJOdDstx8Dda0BdM9QOHsxSwFKKnNFJ3lSxiS/Fgeh8ExFVauJ73X0ejRsnTn
	34GwtEZs+C1WHDQQTysp993ADOBCh4svkRkne8wLrK2EXsKMj6AfjWlTp+gAn7DvMasH4Q9os17w9
	ByXeD/6f+iN2LMYcJGD0PqSJbCTR/vNS4rTUzdouik67vkEdA83WPkUBP7Ny5/AxBeGenMvqL5o7w
	uWKavYF0ik3tU/7TROXHSAeA0JIX2MNOahmpQj4nEuLyFsomfuIpYqHKifWZzdUoJlp8ygQlTTrvd
	55xaHwDNQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiSXz-000079-3e; Fri, 27 Nov 2020 01:27:39 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiSXt-00005v-2f
 for linux-nvme@lists.infradead.org; Fri, 27 Nov 2020 01:27:34 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Chxn448wvz4wlR;
 Fri, 27 Nov 2020 09:27:04 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 27 Nov 2020 09:27:26 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 27
 Nov 2020 09:27:25 +0800
Subject: Re: [PATCH v11] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bf6b3ed97dec401ab9ba9626d7764ab1@kioxia.com>
 <4cfe3787-659c-8300-609a-d6cb2901e04e@huawei.com>
 <a9a2b522-2417-f751-8520-9baa88c2338d@grimberg.me>
 <3c71869dd01d46ac8c47780ccbfab043@kioxia.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <182fcb7f-1420-3654-936c-49a3eadcb819@huawei.com>
Date: Fri, 27 Nov 2020 09:27:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3c71869dd01d46ac8c47780ccbfab043@kioxia.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_202733_412880_F74CF611 
X-CRM114-Status: GOOD (  10.13  )
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, "Ewan D.
 Milne" <emilne@redhat.com>, James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I suggest that both visible and modify are supported.

On 2020/11/26 20:58, Victor Gladkov wrote:
>>> Looks good. It might be better to add fast_io_fail_tmo to
>>> nvme_dev_attrs so that it can be viewed and modified dynamically.
>>
>> I thought it was added, I recall asking this in the past...
> 
> Do we want fast_io_fail_tmo to be only visible or modified dynamically too?
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

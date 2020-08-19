Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59985C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 01:43:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269F22083B
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 01:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mvmj4ytu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269F22083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vvEKfl4W/JPNLCW0VUFZWxplhrSkQITagPHRXLI4n9E=; b=mvmj4ytuAL+EKL2LeTwQPxVAr
	POOOejlMhUSPhwx0ofHa7EvVvyZqTyWmsEx9+oBaqrzK5sZqcF92ZsmUHbKTDJRvoKE+TdH2YD4JF
	8s+pdixDrPMUarw8XStuPxn9XhLEz46RfMf1NpLh0hIwqGq+ErAogZm66Ng5DaPc7k3xaweiH7U7C
	zDWoaXhQbl74aSyaX7frEpyHJR+rSoSwsolSOuc9ahI/2hxKtsBhezN5zOh4TSztEQilQ7kEc8DV5
	rhebWSIlCjRusiF+Wul4dxqD2liTcC+yXr9IQJvjM2dN15U9kyvWmZPjj2NUgCmF3zLX2Pnzo6Swx
	r8gDRk7bw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8D88-000162-F2; Wed, 19 Aug 2020 01:43:08 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8D84-0000rb-3F
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 01:43:05 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6F80E18E012645966473;
 Wed, 19 Aug 2020 09:42:51 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 19 Aug 2020 09:42:50 +0800
Subject: Re: [PATCH 3/3] nvme: redirect commands on dying queue
To: Christoph Hellwig <hch@lst.de>
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-4-hch@lst.de>
 <fa05af11-d82a-13a4-e892-6dd8e65bf981@huawei.com>
 <aeb44221-8740-3ff8-1932-e9c2c106ea57@huawei.com>
 <20200817081351.GA16571@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c0730878-1e10-bddd-ee17-23d003dc670a@huawei.com>
Date: Wed, 19 Aug 2020 09:42:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200817081351.GA16571@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_214304_408704_A02C85F3 
X-CRM114-Status: GOOD (  16.59  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/17 16:13, Christoph Hellwig wrote:
> On Mon, Aug 17, 2020 at 01:49:47PM +0800, Chao Leng wrote:
>> If without any multipath, will not retry.
> 
> Which is the right thing to do.
Suggestion:
Do not use blk_noretry_request. The local retry mechanism, which is
defined by nvme protocol, is conflicted with REQ_FAILFAST_TRANSPORT.
blk_noretry_request is not a good choice for nvme, even for SCSI,
this is not a good choice too, so SCSI does not use this MACRO.
We can seperate REQ_FAILFAST_TRANSPORT with other FAILFAST flag.
For REQ_FAILFAST_TRANSPORT, do local retry for non path error.
For other FAILFAST flag, complete request with error code immediately.
> 
>> This may not be what we expected.
>> If we can support both NVMe multipathing and third-party multipathing,
>> it would be great. In addition to DM-MULTIPATH, third-party multipathing
>> software is provided by storage vendors, such as PowerPath(DELL&EMC),
>> SecurePath(hp), Ultrapath(huawei), etc.
> 
> For dm-multipath we only guarantee we don't break old behavior.  ANA
No, now we do not guarantee this. For example, if target return
NVME_SC_NS_NOT_READY or NVME_SC_CMD_INTERRUPTED, we do not local retry,
and translate to BLK_STS_TARGET, blk_path_error treat it as retrying
failover path will not help, will cause io interrupt. This is serious
problem.
  /**
  * blk_path_error - returns true if error may be path related
  * @error: status the request was completed with
  *
  * Description:
  *     This classifies block error status into non-retryable errors and ones
  *     that may be successful if retried on a failover path.
  *
  * Return:
  *     %false - retrying failover path will not help
  *     %true  - may succeed if retried
  */
static inline bool blk_path_error(blk_status_t error)
{
	switch (error) {
	case BLK_STS_NOTSUPP:
	case BLK_STS_NOSPC:
	case BLK_STS_TARGET:
	case BLK_STS_NEXUS:
	case BLK_STS_MEDIUM:
	case BLK_STS_PROTECTION:
		return false;
	}

	/* Anything else could be a path failure, so should be retried */
	return true;
}
> was never supported without nvme-multipath so this isn't part of it.
> 
> Out of tree junk is completely unsupported per the kernel wide policy,
> unrelated to the nvme driver itself.
If we can support third multipathing software without extra cost,
and have no bad effect on NVMe, we will get more palyers, supporters,
and contributors, will faster nvme over fabric development.
I will try to do this base on your patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4339C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 03:53:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9939E206A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 03:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZKVUORyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9939E206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aqIL4Z4xYGiYWbndPvZPR4Ct9XfaCn2YC06h296+pu0=; b=ZKVUORyiDbqEylimWAkZWgd+A
	B6H77JA5xF/gkDsBMxeV09QzvhIRmjBi1Zg4sXPJP8lTQm30ZB3kvI7DuY7YiE7iFmbsdmrNsrFJL
	myc/jG8BKM9f7/9XnJwqy+qeFDF6thuWyeLS/iEdBUb+x8LovQZmHQ6qudzwLqv7uaeIT45vmM5EV
	9ROhYrsTqlJ3NO8e5KT9Cc9PzhaRImOIbMVSiQj73edHgIRKQbihvTx6mk1a89hdhVAOz1KXRCi/V
	5PPFcPPNWwKH+2oz0YYZS03YSkNDRCB8VX8qjncCpWul51DiffNNxbRqrAIeGLZ8BWpk5407SIR76
	z+oEoZIpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k64Iw-0003rm-WC; Thu, 13 Aug 2020 03:53:27 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k64It-0003dJ-M5
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 03:53:24 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 52D9EFD50C6FEB740FE2;
 Thu, 13 Aug 2020 11:53:18 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 13 Aug 2020 11:53:15 +0800
Subject: Re: [PATCH 2/3] nvme-core: delete the dependency on blk status
To: Christoph Hellwig <hch@lst.de>
References: <20200812081844.22224-1-lengchao@huawei.com>
 <20200812151035.GB29544@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <98a09d55-2a2e-fc2e-83ec-429843461bd6@huawei.com>
Date: Thu, 13 Aug 2020 11:53:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200812151035.GB29544@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_235323_974541_1D5B800E 
X-CRM114-Status: GOOD (  10.38  )
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



On 2020/8/12 23:10, Christoph Hellwig wrote:
> On Wed, Aug 12, 2020 at 04:18:44PM +0800, Chao Leng wrote:
>> nvme should not depend on blk status, just need check nvme status.
>> Just need do translating nvme status to blk status for returning error.
> 
> While this doesn't look wrong it also doesn't save us a single
> instruction and actually adds more lines of code.  Do you have a good
> reason for this change?

If need retry, save nvme_error_status. Of course, it doesn't matter.
There's no logical change, just want nvme do not care blk status when
check retry.
It is ok to change or not.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

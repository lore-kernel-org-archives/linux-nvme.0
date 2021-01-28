Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148DDC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 01:34:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FC664DDA
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 01:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FC664DDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AiJi0FAa5bVOW3HwlNopnC6IXph+OqOkvwzqKJxWy+k=; b=Ij57r5jsVyqQC9inDFZ0VSzE+
	FbXmcDIdG3H5MqPlvWYZwe1m5nCO4rp5GuZnhHDt2zwvZKE/burI6xdKwBLprTRBXZ784nk9F9lUg
	NLFDuwCfdWQVvNldr2VxZ7wCqWyA14O9yPIYIQisC0eHO/9+f0sh6arK2WxDyApdDquc+MwSskHmf
	QHdQnhFU/T9qEWJ2C3Xy3e8kvlPCPT+7E//sLdurK+x17FAy3gcGJEHEovEcAMG6P7T7MHmJP3Obb
	UZbsV1RGYITgIK5OZN+XAlIWW2+96N+NTpC8XvFgPkCgW56pFI+6mZOEca/3ncIfP52Mtk4GxLRkX
	xKKBFuOnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4wCf-00075D-2F; Thu, 28 Jan 2021 01:34:33 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4wCc-00074W-Rm
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 01:34:31 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DR2zb3tnBz5LYf;
 Thu, 28 Jan 2021 09:33:15 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 28 Jan 2021 09:34:28 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Thu, 28
 Jan 2021 09:34:27 +0800
Subject: Re: [PATCH v4 1/5] blk-mq: introduce blk_mq_set_request_complete
To: Christoph Hellwig <hch@lst.de>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-2-lengchao@huawei.com> <20210127164020.GA23417@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <15301bba-f7db-a0c9-c7fa-6efaafefd21c@huawei.com>
Date: Thu, 28 Jan 2021 09:34:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210127164020.GA23417@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_203431_170037_D3A6EBC5 
X-CRM114-Status: UNSURE (   8.10  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/28 0:40, Christoph Hellwig wrote:
>> +static inline void blk_mq_set_request_complete(struct request *rq)
>> +{
>> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>> +}
> 
> This function needs a detailed comment explaining the use case.
> Otherwise we'll get lots of driver abuses.
ok, thanks.
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

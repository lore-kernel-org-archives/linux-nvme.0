Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97F8C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:47:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A32360240
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A32360240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/yDqv9zrqS06VJ0ypbIimNyxR/x/FZM1i3Vq00R2Q5w=; b=bbEN03t1EydX9D26z3tJSdBh5L
	aWDaK6yW/Vv1RP9NJYxuV88kGOBq6xvnIsqCyEnNR7aJxw7Kje0flDm661cfpmx48eqTb3bJ7Z+Rh
	048lc3aFFrw9jItUweKGrT9XUAFR/kDgaE5bAnqQsCIoy/jjbCHJiDRSPvwuMrXBiaKqMIRV71VqG
	vMH8gMfbiHFGW+W5hIeRQFaje37EWHdDaw+J5VQ0ne3hlPWkztSDcerDB6g/reCc8Sxq6oZLLQ6YP
	abXNA4EOSY2dFh3/eeCCKdt0EkfWusoC+qce3oPNlrqPP1hl2j05wi7u9cWnsilWIGva2trUsEwGk
	Z9geu7HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDdLE-005Bx6-BY; Wed, 11 Aug 2021 01:47:36 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDdLB-005Bwo-9k
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 01:47:35 +0000
Received: from dggeme719-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gkt3c2BDgzYn1T;
 Wed, 11 Aug 2021 09:47:08 +0800 (CST)
Received: from [10.169.46.19] (10.169.46.19) by dggeme719-chm.china.huawei.com
 (10.1.199.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 09:47:22 +0800
Subject: Re: [PATCH 1/2] nvme-rdma: always try to configure io queue when user
 wants it
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210803090630.14425-1-liruozhu@huawei.com>
 <20210803090630.14425-2-liruozhu@huawei.com>
 <26de6354-640f-688d-5d01-33ea81ce68be@grimberg.me>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <757d63be-39f1-ad5b-72e2-8199617ebfa4@huawei.com>
Date: Wed, 11 Aug 2021 09:47:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <26de6354-640f-688d-5d01-33ea81ce68be@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme719-chm.china.huawei.com (10.1.199.115)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_184733_662926_D727A56A 
X-CRM114-Status: UNSURE (   8.45  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Because another solution has been applied, this problem has been solved. 
You can safely ignore this patch set now.

Thanks,
Ruozhu

On 2021/8/11 9:30, Sagi Grimberg wrote:
>
>> During reconnection, if set queue count feature failed, we will
>> set ctrl->queue_count to 1, and schedule another reconnection.But when
>> ctrl->queue_count is 1, we won't try to configure io queue again.
>>
>> We should always try to configure io queues if user wants it.
>
> I'm assuming this is not relevant anymore?
> .

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

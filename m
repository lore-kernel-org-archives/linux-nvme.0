Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0891C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:33:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F263361040
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F263361040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a0VY9nezazQWY+sqEjDHYy1gJoGUpcrvn6KMuJzikoY=; b=QcTnCeTqiDohbpDrGL3EN1aeB
	FDHJhhPRae6H5mgKaAWBRRwjn9c5OJ2AJ1TLsjFz152+Jy1NP8oJfzXKovhI364mLU4Gs1GCIqiTA
	Dutfd/VmZbPYGtqR6l7BZsTsMUevWj0oe/oQOSTLk6MIz1N1UEbzNJRGLB+px041urlUrMbGHpawO
	L+Ix0wEOZNuCQR8veAHhS7ATznpQgcqIK2pgS8cbqXgGyBRU73AV2Ek7oa1ytmmxlaoOxzJP0iG6c
	R+mFzfkrPn2oigKk7Tc/Hu0ql722YLso+HUXFQdaavNaIOQiEhYssnIC5+g1wqD4xOq22L5x5s/iq
	h3WJHAIhw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljDso-002kIl-Jy; Wed, 19 May 2021 04:32:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljDsn-002kIB-4Y
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 04:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=zOWIg0ZhkA5qh7hVNavc5PbVc6LM1T3fR120XfHVQSU=; b=z4eHJiqKb/0xW4xgx0xLML9Spt
 h2OfeYf9O8kokzZYYGCYRMQeW80aVWg01JducUKIXJ4QYYe3rc7NVdc3Ue5t4UWmay7IlZlWkauQm
 k2rg3dVQ/klCfysdEzbtL7wzNUy/RHFi12PuGRVdtMIthxMqwVyLlkFLKnHrfPSqO1TzZKk4p2Gxa
 2aUNFucHt/l9q5nKQ7Ac9bhDkWuVfzQ+VvqGza3iNEZR4btZJXffvknZGiKz4edWp9BQhwpp5ljog
 HRxefXxt1F+ShEspFQEBGD8Ki/KxTzsNbKy8ZxWDynMXegRiO8ckYqu8DVHZmQRpou7OEPHyOuG3K
 fwCP2hDA==;
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljDsg-00F7UC-0V
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 04:32:27 +0000
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlKdm1mzzzCst2;
 Wed, 19 May 2021 12:29:32 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 12:32:18 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 12:32:18 +0800
Subject: Re: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "amit.engel@dell.com" <amit.engel@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linfeilong@huawei.com"
 <linfeilong@huawei.com>
References: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
 <BYAPR04MB4965E8D55C4349EC01EF61FB862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Wu Bo <wubo40@huawei.com>
Message-ID: <ead259ae-2955-1fda-7deb-6262fdc21ecf@huawei.com>
Date: Wed, 19 May 2021 12:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E8D55C4349EC01EF61FB862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_213226_254958_F3460648 
X-CRM114-Status: GOOD (  11.02  )
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

On 2021/5/19 4:27, Chaitanya Kulkarni wrote:
> On 5/18/21 01:21, Wu Bo wrote:
>> From: Wu Bo <wubo40@huawei.com>
>>
>> When cntlid_min is greater than cntlid_max,
>> goto wrong label, should be goto out_free_sqs
>> label. Otherwise there is a memory leak problem
>> on the nvmet_alloc_ctrl function().
>>
>> Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")
>> Fixes: 6d65aeab7bf6e ("nvmet: remove unused ctrl->cqs")
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> ---
> 
> Looks good, except commit message could be better :-
> 
> When cntlid_min is greater than cntlid_max, goto wrong label, should be
> goto out_free_sqs label. Otherwise there is a memory leak problem on the
> nvmet_alloc_ctrl function().
> 
> Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")
> Fixes: 6d65aeab7bf6 ("nvmet: remove unused ctrl->cqs")
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> 
> 
> with above :-

Thanks for your review. I will make the commit message better.
and I found the nvmet-loop has a similar issue,
will send patch series soon.

Thanks,
Wu Bo
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> 
> .
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

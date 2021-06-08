Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF48C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 12:44:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B0061078
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 12:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B0061078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=70EhmDzL5sklcHksrOzBtxVqwoOlFBXRyVAELISoghM=; b=ZedyrruZP4Y/UgXGWhKy8x9KUw
	kKDvWt8Wgz8Bo9iBRAkjH/9JRqbGmhbRHvzlkTxCxeByUknczCQHPZe4vauRWNtNFL7SzwPhpOoli
	2gHbwkbOrIdq9a1HrsAm8GEyTcTd5Rx+VQO9R9sOmJbZ76FVxkE6PAST4UlFmyhjQmiaJBKFzo38K
	SbMs3LklgtEW6RKXRt4ZPoaGZNFYslv5hVrnY5o4I1wcRBhlSU9hoqR26nZ1yFyXEb26TfPRhZn87
	QxbgWsL0WtnT5tIaRCsbBggo2ws4Geo6D8KcWsQaqBE9Xcs7Lcv/3aozXBO77JPyWfpSoNZFs/CwZ
	FkWCp4Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqb5a-008RN0-0I; Tue, 08 Jun 2021 12:44:14 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqau5-008Mtx-J0
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 12:32:23 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzqK63sn7z6tsc;
 Tue,  8 Jun 2021 20:28:26 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:32:16 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:32:16 +0800
Subject: Re: [PATCH] nvme-multipath: combine grpid and ANA state checks in
 nvme_parse_ana_log()
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linfeilong@huawei.com>
References: <1623125616-629270-1-git-send-email-wubo40@huawei.com>
 <20210608052320.GA13828@lst.de>
From: Wu Bo <wubo40@huawei.com>
Message-ID: <0f672080-671b-c1b8-18d5-3ddad90f53c4@huawei.com>
Date: Tue, 8 Jun 2021 20:32:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20210608052320.GA13828@lst.de>
Content-Language: en-US
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_053221_870536_947E12E8 
X-CRM114-Status: UNSURE (   9.77  )
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

On 2021/6/8 13:23, Christoph Hellwig wrote:
> On Tue, Jun 08, 2021 at 12:13:36PM +0800, Wu Bo wrote:
>> -		if (WARN_ON_ONCE(desc->grpid == 0))
>> +		if (WARN_ON_ONCE(desc->grpid == 0 ||
>> +			le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
>>   			return -EINVAL;
>> -		if (WARN_ON_ONCE(le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
>> -			return -EINVAL;
>> -		if (WARN_ON_ONCE(desc->state == 0))
>> -			return -EINVAL;
>> -		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
>> +		if (WARN_ON_ONCE(desc->state == 0 ||
>> +			desc->state > NVME_ANA_CHANGE))
> 
> So besides making the code impossibl to read due to the incorrect
> indentation this also makes each WARN_ON_ONCE cover multiple conditions.
> Not very useful for debugging.
> .
> 

Indeed, not very useful for debugging, please ignore this patch.

Thanks,
Wu Bo


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

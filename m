Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 06:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SU6KDdNOo3blQ8ua6YKiSgCdM27iqqwoJ6oMEsFgNkY=; b=EUVNsq4+vGWABMtwMbCnav0AB7
	Tta7jGDyPBUJdS3BStM5W2EGQR1JVVM5gOH9KLeynNK2CqrLlNBhWY42YRR1CunCp7Oax8cD/X68J
	Uu2r+q0OAAfqX7cslE9tn94k/i7VbD9XumR2odHzyx9eegk5fpmVE7q6dzaEprGdppOzbdqIwjzZz
	AqXvuGNKEzCJMbJWYF0bW25BWvjFbbjWs8NG8hsjKp+Bpiu+H18+fARe95qwEHZq/KEcEqIgTho8B
	+wCpYjYCqateLIuiMjw4LhgsABvOg9YDmzw8XFJXOi0RmfRGD97r3YFybHBZgZS5hQDoXAEJHaIUN
	LfWNoiqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4G3O-00DbcU-T0; Thu, 23 Jun 2022 06:10:58 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4G3M-00DbZ0-8l
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 06:10:58 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LT8xF2y02zDsPy;
	Thu, 23 Jun 2022 14:10:09 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 14:10:43 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 14:10:42 +0800
Subject: Re: [PATCH] Revert "nvme: remove the .stop_ctrl callout"
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>
References: <20220610095637.3714-1-liruozhu@huawei.com>
 <63de8107-6428-2163-28f7-b2edcedc6114@grimberg.me>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <92bf5cae-086f-8a1e-b925-c77eb1b7c4ba@huawei.com>
Date: Thu, 23 Jun 2022 14:10:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <63de8107-6428-2163-28f7-b2edcedc6114@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_231056_539237_423FB2B3 
X-CRM114-Status: UNSURE (   8.19  )
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

On 2022/6/22 19:26, Sagi Grimberg wrote:

> Indeed this analysis is correct.
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
> Couldn't retrieve the discussion that led to this patch
> or the submission of it, but it does add a regression.
> Perhaps you should have the title reflect that this is a regression so
> stable kernels can pick it up.
>
> .

Thanks for the comment, I'll send v2 to reflect that it's a 
regression-fix patch.

thanks,
Ruozhu



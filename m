Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3960C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 06:42:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FC764DCF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 06:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FC764DCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=esj/7fEQtDBCN1XaVeZkEcl5m/Aygm3Qvv5zGCHeYIk=; b=2z+lP2/EpBIWZqHZXiKVKy2Mx
	DYH77tD7swgzuBJR56Qg7f/rBa2zh3bZNnECeXE/LEr739U7YlLkOyR7RJYlZbxkaaKAmF3FgG5Q7
	6Gcg+dYxCjdFbu1AqI4dMEYkVXzs1GKgiuxJs1II5j4+u+nmcmR7+E0VUKFr92B3hwbk8OgKhF6dL
	q1msG/8q+dAQdqyKBhIJzm6jN0fr3eXIre4qJyozFq9FabzjhOuec+/wfhFbr5C06/KNBJ74/5ecO
	JD3j4bE+tbxl8pfRxDI3mH7cVnIhuP19tdxT8lpnB3uPevrF1qo3wxevYkeFJ9ZkDRquhrfWIYAoa
	2GSjB9eCA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEnsL-0004E5-5l; Wed, 24 Feb 2021 06:42:21 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEnsH-0004Cl-33
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 06:42:18 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DlmWH4dKmz5T9c;
 Wed, 24 Feb 2021 14:40:11 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 24 Feb 2021 14:42:11 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Wed, 24
 Feb 2021 14:42:11 +0800
Subject: Re: [PATCH 0/2] nvme: sanitize KATO handling
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210223120728.104699-1-hare@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <36e3bfd8-0c69-7540-c9f2-fd37070dc107@huawei.com>
Date: Wed, 24 Feb 2021 14:42:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210223120728.104699-1-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_014217_459055_13BC1A62 
X-CRM114-Status: GOOD (  19.54  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/2/23 20:07, Hannes Reinecke wrote:
> Hi all,
> 
> one of our customer had been running into a deadlock trying to terminate
> outstanding KATO commands during reset.
> Looking closer at it, I found that we never actually _track_ if a KATO
> command is submitted, so we might happily be sending several KATO commands
> to the same controller simultaneously.
Can you explain how can send KATO commands simultaneously?
> Also, I found it slightly odd that we signal a different KATO value to the
> controller than what we're using internally; I would have thought that both
> sides should agree on the same KATO value. And even that wouldn't be so
> bad, but we really should be using the KATO value we annouonced to the
> controller when setting the request timeout.
> 
> With these patches I attempt to resolve the situation; the first patch
> ensures that only one KATO command to a given controller is outstanding.
> With that the delay between sending KATO commands and the KATO timeout
> are decoupled, and we can follow the recommendation from the base spec
> to send the KATO commands at half the KATO timeout intervals.
> 
> As usual, comments and reviews are welcome.
> 
> Hannes Reinecke (2):
>    nvme: fixup kato deadlock
>    nvme: sanitize KATO setting
> 
>   drivers/nvme/host/core.c    | 22 +++++++++++++++++-----
>   drivers/nvme/host/fabrics.c |  2 +-
>   drivers/nvme/host/nvme.h    |  2 +-
>   3 files changed, 19 insertions(+), 7 deletions(-)
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

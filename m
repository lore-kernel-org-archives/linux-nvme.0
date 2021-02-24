Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83DDC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:27:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D5764ECF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D5764ECF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D8rJldci/TD1lrCq3ZkhDml5k5Tcpr2Nnz6HhOgzwVk=; b=QH33RCPsYfI+EFGuy76STh5uN
	kwXz9LPnqtf3mHkThD41pqm5vNM149iQySYRejpFiUosdb08k/ImQLc/ZY8KHPK9uqaHse2yTRg+7
	uWckJmSWMBeLreV9vG6vFPLAI++EMhrb7qNkkuCHWGSOff8hXhwFPUltdP7SQALpPsd/ZJYCpPW3s
	PS2B4x+jFIjFJTTHVeytTmUjRQjM+xrE7zWUsRv/Z8fPFD48013aUxVh2KWApAO45ZOQOD/hRPwcG
	9RIqpFI5qbnpcj8L5TcWoC8kQfojws/2FJIYbLFwE5qFd4dYB5lIwiDPqz7q1z61rRbQR+cB02uQq
	jZesCI1cA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEoaL-0008AW-L6; Wed, 24 Feb 2021 07:27:49 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEoaI-00088P-Jo
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 07:27:48 +0000
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DlnW23k3zzWDZT;
 Wed, 24 Feb 2021 15:25:02 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 24 Feb 2021 15:27:36 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Wed, 24
 Feb 2021 15:27:36 +0800
Subject: Re: [PATCH 0/2] nvme: sanitize KATO handling
From: Chao Leng <lengchao@huawei.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210223120728.104699-1-hare@suse.de>
 <36e3bfd8-0c69-7540-c9f2-fd37070dc107@huawei.com>
 <06e3b90a-719e-9561-5c63-67dac0a782e1@suse.de>
 <1834a11c-c472-e14f-ece3-a96ec2ced044@huawei.com>
Message-ID: <da5f1559-16da-377a-1394-09419f6a1fd7@huawei.com>
Date: Wed, 24 Feb 2021 15:27:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1834a11c-c472-e14f-ece3-a96ec2ced044@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_022747_318068_83E518A2 
X-CRM114-Status: GOOD (  15.58  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/2/24 15:20, Chao Leng wrote:
> 
> 
> On 2021/2/24 15:06, Hannes Reinecke wrote:
>> On 2/24/21 7:42 AM, Chao Leng wrote:
>>>
>>>
>>> On 2021/2/23 20:07, Hannes Reinecke wrote:
>>>> Hi all,
>>>>
>>>> one of our customer had been running into a deadlock trying to terminate
>>>> outstanding KATO commands during reset.
>>>> Looking closer at it, I found that we never actually _track_ if a KATO
>>>> command is submitted, so we might happily be sending several KATO commands
>>>> to the same controller simultaneously.
>>> Can you explain how can send KATO commands simultaneously?
>>
>> Sure.
>> Call nvme_start_keep_alive() on a dead connection.
>> Just _after_ the KATO request has been sent,
>> call nvme_start_keep_alive() again.
> Call nvme_start_keep_alive() again? why?
> Now just nvme_start_ctrl call nvme_start_keep_alive().
> The ka_work will be canceled sync before start reconnection.
> Did I miss something?And all flight request will be canceled before start reconnection.
Is the request hang on block?
>>
>> You now have an expired KATO command, and the new KATO command, both are active and sent to the controller.
>>
>> Cheers,
>>
>> Hannes
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> .

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

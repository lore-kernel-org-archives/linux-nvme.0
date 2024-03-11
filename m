Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD15C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Mar 2024 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hyQUr8jGn3hIN05OzMWDA66EXbEY31C85c4ZhIxNXkc=; b=vWwP8LgW0xvRLrhO+0hJYCrpGo
	sa1AFJTAkfxMUFNTS9W/tk7sdKf4z9glaZ53IhzfUVQz9/RfO43cBnTEV5Iurk4q6lHUulCZzpJ02
	pW1EB2HRsn9e+kv0NuDCPG0OuKqLPjL9H7wUGndiIZXw5FYKAcajFgPsMnyrphRtoMQzFDkknRPLy
	mM8ag/s89ub43pHWAZ9CfJeSb+PqYyeZMD2ufp3qW/sVUJua+aGJrJoFeutZcO4gC+V//QBdTyGLv
	R6+FYmxARQGb9WvMd0KPsu0aBUeIzMB9/k3Qas8W5i45MWVOZ9tCHwhYA5Er+BNlC0YCheVqf7Z6F
	EjP30fFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjdha-00000001FW7-1Uma;
	Mon, 11 Mar 2024 11:20:18 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjdhV-00000001FTD-1UwE
	for linux-nvme@lists.infradead.org;
	Mon, 11 Mar 2024 11:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710156001; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hyQUr8jGn3hIN05OzMWDA66EXbEY31C85c4ZhIxNXkc=;
	b=AWTPahNrRFKpB4mVnYcVT7vMhK+7mw70lWVykG9qCM1aUA2R8ax5WFzZk3RsQhBHtAIbdUaJWvC+sTj/KVL8AwcO5VYe3kv+nDCN9X/wzWWLBZ9E/wQyqv1lCFhoDxwrSf+TftFLapP7dUeKBfEEC6wM0gubZEfFqAUiie1lPSo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2FpFbA_1710155997;
Received: from 30.178.90.245(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2FpFbA_1710155997)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 19:19:58 +0800
Message-ID: <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
Date: Mon, 11 Mar 2024 19:19:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
 <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
 <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_042013_928958_7ACDEAD6 
X-CRM114-Status: UNSURE (   7.31  )
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

>>
>> What do you think Sagi? Or may be we can declare that 
>> preempt_and_abort is not supported, just
>>
>> like SPDK does.
>
> It can definitely come incrementally, but at the very least it should 
> be incorrectly supported.
>
> Out of curiosity, doesn't your use-case need a fencing protection 
> against inflight I/Os reordering during
> preemption?

The cluster use stonith(shoot the other node in the head) to protect 
sources,

and the backend storage(our storage system goes like this, so does disk 
firmware I think.)

can process write I/O operations on a first-come,first-served basis if 
the range of

data accessed by two I/O operation overlaps, for example, hostB preempt 
and abort

hostA, then host B send I/Os, the backend storage will handle hostA's 
I/O first(by the timestamp).

Best regards,

Guixin Liu




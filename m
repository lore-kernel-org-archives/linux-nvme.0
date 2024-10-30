Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1742AD74977
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uoo3Lc5DmFlhvD8lfBYIIcl/AfQ0Wc/Iq+BmIpcYqUA=; b=Ye+4mV+b8vEJjr8Lb+AANp/jW8
	3BFx+8jQtigsriRTagLlUgRYzwkeaX4s8pRbSYpZOE7sXmqGBZDSwUVLBvvYSDaDd6QBwz7JIgvNj
	o0/6Vv91y5nRzzMGUlQ9louW1N1tTH1vVC8JrUkzu2+LNTvmDV//zj0vPrkhD/bTmUlbvMjoAWUOy
	00EAR6ABcKdo76VxlQNiNCND5Ht/OQVEF14QczrWZEhEoWwRveMUBoT3t/QhqTsZg/EfsJ+mDNYoj
	SBqBAB2pg87B2q5ATQiXO7dptAcCUPfIpJE/6o/JThEYJeUBWAwA1Wz6kqFzXG/ZMdT1ZdogZq5vW
	LWLR9G/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62S7-0000000H11n-47a5;
	Wed, 30 Oct 2024 06:45:11 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62S4-0000000H0yc-1dT7
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730270705; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uoo3Lc5DmFlhvD8lfBYIIcl/AfQ0Wc/Iq+BmIpcYqUA=;
	b=sGxoa6au8PrTtI6ODxlJLypc2eAFuSXIA/+Ba/j2LIn8/l3uJQGtCL4b3qXTw56jo9H60CW4PqW7iFNii7+Aj3fOn8y/7chfJZ/XIbzaTBDClU8ijlubuEQlcfKfqZ05mhXZLp3T0EDlIxOnfBxgT9rGzyxfuSB8n+iOfQWj3dI=
Received: from 30.178.82.27(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIClCg9_1730270699 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 14:45:00 +0800
Message-ID: <29c4f757-3c9d-488b-b700-c35afea5e4c3@linux.alibaba.com>
Date: Wed, 30 Oct 2024 14:44:57 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
To: "hch@lst.de" <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
 <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
 <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
 <20241030055342.GA841@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241030055342.GA841@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_234508_909543_D39C7A14 
X-CRM114-Status: UNSURE (   7.14  )
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


在 2024/10/30 13:53, hch@lst.de 写道:
> On Wed, Oct 30, 2024 at 09:44:25AM +0800, Guixin Liu wrote:
>> I need serverve some cpu core to do other things, such as handle events
>>
>> and managements, so that the nvmet_wq can't running on all cpu cores,
>>
>> currently, I restrict it by setting the cpumask of nvmet_wq（that's why
>>
>> I expose nvmet_wq to sysfs）.
> Can you resend the patch with an explanation of the use case in the
> commit message?  Thanks!
Sure.


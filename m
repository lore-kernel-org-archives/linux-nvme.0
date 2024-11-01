Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769AAE67493
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIyueU57hH3OLb5owPJTOIj/H/u9OAJs9LJIweqO8qI=; b=JKPZGm43Szcf8uBIpfq7jv0H2/
	aftQqslQqb3iY1gk6/ooQhxzjVyK94Y0QhyBFy6UdhVbyQTolZS7+HVYPfUHGcIzWvQI00v+g/kgm
	X5yJCVQI+3bzxC2vGp9eJfiKkd26mewW79MST/I6jGu8hys0pGQeVjqFnbPe+jtg11OhdTlebwavb
	S8XYkHMdREtRMNC+DnRtyu8I2fSjys9Ag7DorFaVeBJ8VUVQR/DEQT0xFt96wTQWOeHCoUNDXP0/r
	8i2Bkhd1xvQ6LAy5BxtUk2cla/vjBIuwkiKjDwZWo0G0fmWDQfeI1Fx+7J9SJoqFOYjqIMXAZLr0o
	+R2Ivksg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6gXB-00000005Qsx-0qEA;
	Fri, 01 Nov 2024 01:33:05 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6gX7-00000005Qq3-2CcH
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 01:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730424776; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZIyueU57hH3OLb5owPJTOIj/H/u9OAJs9LJIweqO8qI=;
	b=wBIweUlk8MHvSI51Jf8AuLc6pq0OtkXUtbNd+plnDuxBv+F1golXqMDRNw4tV/9tAIoQ3xJTfuCuzW5HBeOcucdIvUo9RF3b8vEDU2PyBG0cKQaO/1PATIQ4QcfdtR+hR1t284NGYRzRsvN6OKqGc2mhzd0rzVJKfiRx7LZMFpY=
Received: from 30.178.81.166(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIK-Bnv_1730424774 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Nov 2024 09:32:55 +0800
Message-ID: <c0120704-9592-4fb7-a3a1-333fe7af0fb5@linux.alibaba.com>
Date: Fri, 1 Nov 2024 09:32:53 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvme: check at least one ns identification reported
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20241031103803.55219-1-kanie@linux.alibaba.com>
 <20241031125501.GA17520@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241031125501.GA17520@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_183302_116333_3659E7C8 
X-CRM114-Status: UNSURE (   6.69  )
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


在 2024/10/31 20:55, Christoph Hellwig 写道:
> On Thu, Oct 31, 2024 at 06:38:03PM +0800, Guixin Liu wrote:
>> Per 2.1 base NVMe spec:
>>    At least one Namespace Identification Descriptor identifying the
>>    namespace (i.e., NIDT field set to 1h, 2h, or 3h).
>> Check there is at least one reported.
> NVMe 1.0 didn't have any of these identifier, so it's unfortunate
> but perfectly valid if devices don't have any.

Maybe I can add a "NVME_VS > 1.0" check?

Best Regards,

Guixin Liu



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF91CDB466
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2fxb8QiopP7jUhlGWL826dFHa0SwlkS7jSL87O4lPM=; b=x3cIes3QA4UnrjGXSQoxAFCWKA
	hVJee9HxYReSpe7OjEQHdU2adSIkV3ksz9lQip+1B4+Y4Ru0c1y7S0k4QNxWbymeV4mRnYJdURD8l
	/y92fvSC5m5iVPMwiq3fAlAQlkKOq/JmRD0KOOXlZzVuHoTZJMe8xSXUBx83cLRlGtUTmDSwTWMZT
	FKhu1okjusTank3xQaiNmTQ+FVjdgVi9N/VZ4hUAFKzWXoZa0dIJD2bDS+F4CUMyp1OjIMDnnp0Ef
	g9ZrTOoLoxIaW732+QlBRty7LQUPORJW2Rsw+yEMwnuJR1DUrMwIld4jlU7yykKnSMlSnuzzEEQIB
	7S0U1noA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcg6f-00000008sj3-115S;
	Thu, 25 Jun 2026 09:10:45 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcg6a-00000008sha-43ru
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 09:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782378637; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=g2fxb8QiopP7jUhlGWL826dFHa0SwlkS7jSL87O4lPM=;
	b=uwNb+LLkSkp37Ca5dVapnnqX20gYNU9HI2Rx3oB0BP4pfOILn+oKLJczirMvIdVvbof6gWrxQMuICUFzFkF7d+3jJLzj7AIsl61JPaGuuNoAeWztgXcDsD1tXgi7qzHfc06MZYJQ9eMkqcbgZOlQAmagoXA96XOGgWj+gO/bpss=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5b1hm3_1782378635;
Received: from 30.178.83.229(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5b1hm3_1782378635 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Jun 2026 17:10:36 +0800
Message-ID: <f0c00d47-0f33-4c9a-84ea-2fb82cd4d102@linux.alibaba.com>
Date: Thu, 25 Jun 2026 17:10:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: add namespace-level debugfs for reservation
 state
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.com>,
 linux-nvme@lists.infradead.org
References: <20260622104418.2070277-1-kanie@linux.alibaba.com>
 <5b2a11e8-bb66-4111-9090-bcdbb0458fcf@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <5b2a11e8-bb66-4111-9090-bcdbb0458fcf@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_021041_875166_2649D2D1 
X-CRM114-Status: UNSURE (   9.24  )
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



在 2026/6/25 15:17, Daniel Wagner 写道:
> On Mon, Jun 22, 2026 at 06:44:16PM +0800, Guixin Liu wrote:
>> This series adds debugfs support for inspecting NVMe target reservation
>> (PR) state at the namespace level.
>>
>> Patch 1 introduces per-namespace debugfs directories under each subsystem,
>> providing the infrastructure for namespace-specific debug entries.
>>
>> Patch 2 adds a 'reservation' file that exposes the persistent reservation
>> state including enable status, generation counter, holder information, and
>> the full registrant list.
>>
>> Example output with two registered hosts and an active holder:
>>
>>    $ cat /sys/kernel/debug/nvmet/testnqn/ns1/reservation
>>    enable : 1
>>    generation : 2
>>    notify_mask : 0x0
>>    rtype : write_exclusive
>>    holder : hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
>>    registrants:
>>      hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
>>      hostid=22222222-2222-2222-2222-222222222222, rkey=0x2222
> I expect blktests will make use of this interface eventually. The parser
> for this wont be dead simple, sure doable but not simple. If you see a
> way to make a bit simpler I wouldn't mind.
How about this:

1. One holer, multi registrants:
   enable=1
   generation=2
   notify_mask=0x0
   rtype=write_exclusive
   holder=11111111-1111-1111-1111-111111111111,0x1111
   reg=11111111-1111-1111-1111-111111111111,0x1111
   reg=22222222-2222-2222-2222-222222222222,0x2222

2. No holder, multi registrants:
   enable=1
   generation=1
   notify_mask=0x0
   rtype=none
   holder=none
   reg=11111111-1111-1111-1111-111111111111,0x1111
   reg=22222222-2222-2222-2222-222222222222,0x2222

3. No registrant:
   enable=1
   generation=0
   notify_mask=0x0
   rtype=none
   holder=none

4. Reservation not enabled:
   enable=0

Otherwise, the notify_mask can be stringization:

   notify_mask=reg_preempted,resv_released,resv_preempted

Best Regards,
Guixin Liu



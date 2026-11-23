Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C22606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mZm5UViQ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AxSD1Wc+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FKyPx0YtITK/3JAhFBfeRg4gh0YCZdlEYzVxV8et/Vk=; b=mZm5UViQXjxUEq
	h0RYg+a/4HtIZ2RhsnD7upUFr6v8ajpfyWy/kkR0PiH5UVPDmCN9qjN4lTi/C41Rowns9ERNOQW4U
	ClmmH2KipmX633JBt/YFF61xrb49+zITbDdturzMiQzc8vukx6DmDyMtXeA5kBraucDnloV1BHzEL
	j2MzgEgmsNtS2LxsEEkx1jBKn/zvqiAf851kEW0jwhPh+myKrgW8LSw/QKMUYHTIAUbVXfz4QrOs3
	MOzm4MzfFlN3C/Fj16mNBjLDuofOEBOcA/4p9wXuEESs7K5ULmW9TgiSImShZSXPY3z+1NrXxiu2y
	AHwh0bFBxzYKoj0H+Taw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVJP7-000000027KR-1IN8;
	Mon, 23 Nov 2026 02:03:37 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVJP4-000000027Jz-1ySa
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 02:03:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795399407; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FKyPx0YtITK/3JAhFBfeRg4gh0YCZdlEYzVxV8et/Vk=;
	b=AxSD1Wc+LxRnWyz+qsz/HRi/gUPcJgMH2v44fz725mFP+isEymFw10vb9kpDayO5eymZfF2l+xM3a2nIF7RVN4T8keh1Q2bDskvL1v49G51qHbISabrTChU56OJ8nz6UfNYwOyrNz5TnI6KZbpWhH0LBiJNl4smBfraaxaY4pkI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFC-AlW_1795399405;
Received: from 30.178.68.101(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFC-AlW_1795399405 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 10:03:26 +0800
Message-ID: <9acc2e3e-058c-46d8-867c-390e9c3b6052@linux.alibaba.com>
Date: Mon, 23 Nov 2026 10:03:23 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme-hwmon: notify hwmon alarms on the SMART /
 Health Status AEN
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261110110737.3965373-1-kanie@linux.alibaba.com>
 <20261110110737.3965373-2-kanie@linux.alibaba.com>
 <5dfddff9-2158-4660-8393-d0670fba5254@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <5dfddff9-2158-4660-8393-d0670fba5254@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_180334_702700_73A25E70 
X-CRM114-Status: GOOD (  17.63  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/18 22:28, Nilay Shroff 写道:
> Hi Guixin,
>
> On 11/10/26 4:37 PM, Guixin Liu wrote:
>> The NVMe hwmon support exposes the temperature alarm as a plain sysfs
>> attribute, so monitoring tools have to poll temp1_alarm to learn about
>> a critical temperature condition. The device does send a SMART / Health
>> Status asynchronous event when a critical warning is raised, but the
>> host never enables it in the Asynchronous Event Configuration, and the
>> completion path silently drops the event.
>>
>> The temperature warning is bit 1 of the SMART / Health Critical
>> Warnings field of the Asynchronous Event Configuration (feature 0x0b,
>> command dword 11 bits 7:0), which mirrors the critical_warning byte of
>> the SMART log. Unlike the notice events, it has no OAES capability bit,
>> so the subscription does not go through ctrl->oaes.
>>
>> The event stays latched until the SMART log is read with RAE cleared,
>> so the deferred work re-reads it before the completion path re-arms
>> the Asynchronous Event Request, and then calls hwmon_notify_event()
>> on temp1_alarm. hwmon_notify_event() also feeds the thermal zone
>> registered with HWMON_C_REGISTER_TZ and emits the standard hwmon
>> uevent, which a plain sysfs_notify() would skip.
>>
>> The nvme-pci transport completes asynchronous events from interrupt
>> context, so the completion path only queues the work.
>>
>> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
>
> I was looking at this patch and found the temperature alarm notification
> particularly useful. I think this functionality could also be integrated
> into nvme-top.
>
> With this change, nvme-top could rely on hwmon uevents to detect NVMe
> temperature alarm changes instead of polling temp1_alarm.
>
> I also noticed that Sashiko raised a few review comments on this patch,
> which appear valid to me. Are you planning to address those comments and
> send an updated version?
Sure, I'm working on v3 patch - there are quite a lot of senarios to take into account.

Best Regards,
Guixin Liu
>
> Thanks,
> --Nilay



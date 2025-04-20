Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287ECC369C2
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Apr 2025 06:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kMW4fvPFuojcmaWACfE+86JvZbwXndDrxVjxQIjcb1I=; b=l+Kgmi6M4EE5PEeXskRM4P71Fc
	+Cud59y410tmGJY1SrtX6PAdcF6I/p8LB+jcqI/90R2wpM4HR8zf7wIvEDNoCZqSUYh/ngUSap/NR
	gupBA06znMuWHj/89k9ahnw3pFe6p7mLW7jKiwh634GFcxORFjDHUTEWDrqXxSgB43Yo21n0Q/8gd
	gQOJJqjqB6riDz+iZJtIBJIj8dVyJNYan9h7QNvBfS2e6y4SZLekqn66PFddH21mYfU8WP8fOmgno
	6ibOXtoHKunZEhsaHjf3wSyugUuFx077bAyAaH0imqgIh2feyO2vgg4460L4lRx92uTj6zkSjifMV
	IC1KB7AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6NtD-00000002FsH-3NhA;
	Sun, 20 Apr 2025 06:10:51 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Nt6-00000002FrU-2DuB
	for linux-nvme@lists.infradead.org;
	Sun, 20 Apr 2025 06:10:45 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so16922515e9.2
        for <linux-nvme@lists.infradead.org>; Sat, 19 Apr 2025 23:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745129442; x=1745734242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMW4fvPFuojcmaWACfE+86JvZbwXndDrxVjxQIjcb1I=;
        b=aoBxAMq3mRL8GcrOYMNGB3+dPnMoQXBJLi2GRDnXwS5714XAI8gsqHIo7sSEqnIY12
         Gz4ccRvEmxJLnyOFBo5wojwBoXb9sCaHmLVFQzfBeJgXEItcI9XUk1AxuYG+1WjnGhRp
         TKjE5Jd9oHRt5mI0PG4nl34gTb527moWMGxfRr6MQ3BARtRuvsc/MGPr8v5KXoc2mi+B
         sCi2+lzZgacDve0G8bDJ8Z/yNnLXEWAd9sHWw7koCLMd3NqU852OrWvbxx7lt+rhtsnp
         9Vmh8dIoCFexJrP3Njir2qd5pB3PDH2rr1DgE1ubpP+8GQXrHzh7HRZtGt6TAnbh3S8f
         aU/w==
X-Forwarded-Encrypted: i=1; AJvYcCUQPErwETCTfLM+bX6mjB/Za0Es0quGJFFDm7CQbrobH4cdfUQ/xsM6rY3aeuw7ML5uYl8uEiFP3lni@lists.infradead.org
X-Gm-Message-State: AOJu0YysiUtSIN0VMNyzD7UqTMB4MBAB4umijrauvtoul/2B7wwAprAF
	pFcWis4N/aFD6A6wusI707A9obT8pFIvslC0jG2HOWrlbp9WUm3s
X-Gm-Gg: ASbGnctVUfUX9tFf6bx1tryv46kWqrU5/7kqHjpo/EYvlzS098TJAoC3MxPN+w/6xDi
	ZqsXu2UEDHWE9zy7s4EPwAsqlu3yN3rqBvYaFB8yz6YDTcdq55zCN6U8EqtraUW6WJ+BxFaQ2IW
	JCWiN+lqNUaZig+fXQMA6ZkmguESvwkQm6e7on+YyNSkh+5kwbX3DOyauV7mDrL9yChLDewetXF
	VOzWShX1YakSkZnUYbz/A0xl6kFMJb0gWzBaYqT1g068P6dabr3rRe5InK4lArrhEgdj17Q/mJR
	8SMZEgEKsVUIqqEdVkzkD+3nx6aFLwkUliEAYVcfHQKR3kxxgwgsMXbyjeSqBhufvUW3thC6MU0
	Wep4nng==
X-Google-Smtp-Source: AGHT+IH2uOJo6cTZC3bNf4K3tJmcGtT7cvc1CxjN2zQIQlFmlp39AUAS/ih7kssaw4WIh4jlWlXNEw==
X-Received: by 2002:a05:600c:3c89:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-4406abb05eemr68594645e9.19.1745129442278;
        Sat, 19 Apr 2025 23:10:42 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acc9esm88546465e9.13.2025.04.19.23.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 23:10:41 -0700 (PDT)
Message-ID: <78298ce0-3f40-4726-a1a0-fc7aac883bc4@grimberg.me>
Date: Sun, 20 Apr 2025 09:10:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests nvme/062 hang
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, Alistair Francis <Alistair.Francis@wdc.com>
References: <5hdonndzoqa265oq3bj6iarwtfk5dewxxjtbjvn5uqnwclpwt6@a2n6w3taxxex>
 <0278196f-ecd8-4282-af2c-b63fdceaf831@grimberg.me>
 <CADUfDZqa6dWFgkPX=FHyekKyXBCkm-_3bigcbF2BddUUnste9w@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZqa6dWFgkPX=FHyekKyXBCkm-_3bigcbF2BddUUnste9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250419_231044_574742_55F51321 
X-CRM114-Status: GOOD (  18.37  )
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



On 18/04/2025 20:01, Caleb Sander Mateos wrote:
> On Wed, Apr 16, 2025 at 3:28 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>> On 16/04/2025 9:31, Shinichiro Kawasaki wrote:
>>> Hello all,
>>>
>>> Recently the new test case nvme/062 was added, which tests
>>> "TLS-encrypted connections". I ran it with the kernel v6.15-rc2, and observed
>>> "BUG: kernel NULL pointer dereference" followed by system hang [1].
>>>
>>>     When I had run the test case with v6.14 kernel, I had not observed the
>>>     failure. However, I noticed that when I repeat the test case several times on
>>>     the v6.14 kernel, the same failure happens. It looks that the problem has been
>>>     existing for a while, and kernel changes between v6.14 and v6.15-rc2 increased
>>>     the failure ratio.
>>>
>>> Actions for fix will be appreciated. I can run tests with debug patches or fix
>>> candidate patches.
>>>
>>> [1]
>>>
>>> [  285.443497][ T1440] run blktests nvme/062 at 2025-04-16 14:41:30
>>> [  285.586272][ T1531] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>> [  285.596633][ T1532] nvmet: Allow non-TLS connections while TLS1.3 is enabled
>>> [  285.601564][ T1535] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>> [  285.646164][ T1542] nvme nvme1: failed to connect socket: -512
>>> [  285.651941][   T48] nvmet_tcp: failed to allocate queue, error -107
>>> [  285.654954][   T65] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>>> [  285.658205][ T1542] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
>>> [  285.659759][ T1542] nvme nvme1: creating 4 I/O queues.
>>> [  285.662596][ T1542] nvme nvme1: mapped 4/0/0 default/read/poll queues.
>>> [  285.665446][ T1542] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
>>> [  285.763327][ T1560] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
>>> [  285.923585][ T1567] nvme nvme1: failed to connect socket: -512
>>> [  285.932856][  T120] nvmet_tcp: failed to allocate queue, error -107
>>> [  286.035851][   T98] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
>>> [  286.038496][ T1567] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
>>> [  286.040096][ T1567] nvme nvme1: creating 4 I/O queues.
>>> [  286.070856][ T1567] nvme nvme1: mapped 4/0/0 default/read/poll queues.
>>> [  286.074999][ T1567] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
>>> [  286.200199][ T1604] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
>>> [  286.388688][ T1617] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>> [  286.406950][ T1621] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>> [  286.460711][ T1628] nvme_tcp: queue 0: failed to receive icresp, error -4
>> Adding Caleb as well I see here also icresp failed with -4
>> Should we hadd special handling for -EINTR?
> What do you have in mind? As far as I can tell, the only relevant
> place in net code that could result in -EINTR is sock_intr_errno(),
> which is only returned when the current task has a signal pending. (If
> there is evidence to the contrary, I would love to see it! Maybe
> tracing signal_generate/signal_deliver would illuminate what's going
> on?) Returning immediately from the syscall when there's a pending
> signal and letting userspace handle the signal and choose to retry the
> syscall seems like standard practice.

We need to understand why this test crashes, and why other tests 
(outside of blktests)
are regressing.

I would like to understand if the source is MSG_WAITALL, and why.


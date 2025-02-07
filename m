Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0DFC02196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wi+hsSxwL48BJWdvEH+dCrUwWcJbi6dKrKEe7Une4uc=; b=tWr6UgT6veFmardD0uVJDmNfd3
	bEkVDP3yRU/4YqAQcYKZ1oZwWFPxItKXjIrzeBwS9brdaZEoJuBKz0j3wTTvlOKJuPrHxb2bd09Y+
	Ck6rQdkOFtA8/55yMBdY59bWNhae17mKaV9NmdqoKWH3LrxVatClQ44sf+DhSdMj0nQFzPGG+ehQ5
	RTYlAJcYtRmhJPieLH3TE8TQ3dA1opiENn7d5jUd2nUBOtYPMtVvOAiLR7kYxUveIQTqXaiJIzEZz
	pl7SXx7T6U0ilMm3bKClOWQxvqzqeQVxBovQhl+AKnqEqDta7Wte4RiFsLz6cBhsPHakdIgjNEL1d
	DiE9qeMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgKMP-00000008xH7-0zKB;
	Fri, 07 Feb 2025 09:09:17 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgKEE-00000008vFv-3FWk
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 09:00:52 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dcb33cba1so159329f8f.2
        for <linux-nvme@lists.infradead.org>; Fri, 07 Feb 2025 01:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738918848; x=1739523648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi+hsSxwL48BJWdvEH+dCrUwWcJbi6dKrKEe7Une4uc=;
        b=aMWl4u4cmqGLbZsINqNAS8nC6DVB/OMJnIT0OgibYQf6Y2gP2H1Dtgv76J1vtSZpPj
         50epMyuqR/APUTPoxRM3RZSzRnxKCXbXWj6UvnIkhENA80PMtV0D6ozOQ6XbhMzMydlw
         2QCl5d4ozvbtDqyEovAaNv8gXmWuyAr3qkmu74I8qX+OneEHQ2A0JRSg9KHE2g3A8zpD
         LnAOG/QOftgEpNi0QlgBowjrOJCwqCuX9Pr3Zdj18ScHYyI2bB6BEqljeO1NgnX+5n63
         iEPSbmUx0ldmGvpTy/Z61DtWCbB1w3+mQuwEoBYaMssNaxQT7LKSoVJOlTDplHWiJn8C
         cnug==
X-Forwarded-Encrypted: i=1; AJvYcCXzhqZa/hYITtCAZOY6WVH/oAcwS6ZvRxGCKRv6JzzMeUSBI1yMWWsf0r1tO45rrvEIHpl4/2gX/Lwh@lists.infradead.org
X-Gm-Message-State: AOJu0YyjC/sdTNmbuEQN9oAUOluV4iUIVuZ9Fle4K89+nRrJdnFjQC0u
	TD+Mv6jAuqlWc0cbga2qZfNoqHwu8RQl7n6kDDqTDnUgEv3j4PTz
X-Gm-Gg: ASbGncu1KtK6Zbj2Ql+TWx1i1nBpDsJWxT/stSok/1c7tOvodBNxDIPfHqXLR8Bg7+G
	Q21qYh4zunWTOMUNWwvDR6CmiHvDvEUh+VoAnkwckdxr0gHlLtnR7kzAE/sNiGyU621xx68KrHs
	E6a1oa0qkP5VyV7s1aAo3KmpCDCuPVkNM141xQbXiFhbbpG6VV99w6AkAFCUYXCydlHo3zeZFB9
	p1RS+fbj6NPtPFnp2YWW68zztztAEUDs6LgzMbJM2wK+O12OYSPf0bTbyUZt8s03eDwzLfiCP6i
	A520RGkDaW9vo+291sI8R8a9QlHQN/KfAHUmlnnu28/NKME092c=
X-Google-Smtp-Source: AGHT+IGrM/pVkC7rcM06bjl4EiBZZYPUyVaJNlTyzeV5cXumq2HC7zDLdm2x7LlvT0BByVhx8CKGEQ==
X-Received: by 2002:a05:6000:188b:b0:38d:c58f:4ceb with SMTP id ffacd0b85a97d-38dc9374960mr1604987f8f.43.1738918848339;
        Fri, 07 Feb 2025 01:00:48 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc31b9394sm2997751f8f.11.2025.02.07.01.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 01:00:47 -0800 (PST)
Message-ID: <67b7e3e2-ce79-459f-a451-8d4dfbae299b@grimberg.me>
Date: Fri, 7 Feb 2025 11:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
To: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Mohamed Khalfella <mkhalfella@purestorage.com>,
 John Meneghini <jmeneghi@redhat.com>, Randy Jennings
 <randyj@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
 <Z5yYk7vHIhMfiPz1@infradead.org>
 <527f476b-18e3-43f9-98c3-d19a25a6488a@suse.de>
 <613065bf-ad13-489e-9d57-408684e85923@flourine.local>
 <PH0PR84MB1358752FEA88D5EF0971B27E98E82@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
 <Z6OMGweV-wUI3iVn@infradead.org>
 <DM4PR84MB1374EB9468EC63867217240E98F72@DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <DM4PR84MB1374EB9468EC63867217240E98F72@DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_010050_817797_979C7ED5 
X-CRM114-Status: GOOD (  29.11  )
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




On 05/02/2025 18:53, Ballard, Curtis C (HPE Storage) wrote:
>>> On Fri, Jan 31, 2025 at 06:48:20PM +0000, Ballard, Curtis C (HPE Storage) wrote:
>>> If there are specific aspects of TP4129 that are broken, I would be interested in learning more about them and how they are broken.
>> Serious Curtis, we've been through this a dozen times in the TWG.
>> It just adds another best effort timer that is not better than the
>> one that already is there.  But you guys insist on papering over it,
>> an there is no real reason for Linux to adopt that.  (despite the pages
>> long John rant).
>>
> Thanks for that response Christoph. It is really helpful to understand that
> the concern is around the timer and the "best effort" aspects. I was aware that
> concerns had been expressed on whether the timer was reliable and the TWG took
> those seriously.
>
> Reading between the lines on the term "best effort" I think that the concern
> is that the timers don't provide a reliable technique to prevent the ghost
> write data corruption issue that was discussed at LSF last year.
>
> There was quite a bit of work to go through scenarios, and timer processing, to
> address the concerns that the timer was a "best effort" (to reuse the term)
> rather than a reliable method. I'm not aware of a scenario where applying the
> timers, with the process described in TP4129, fails to provide a reliable
> assurance that it is safe to retry write commands.

Unless the controller is able to reliably upper bound its abort 
operation of all inflight
commands I can't see how this is 100% reliable. Which will likely mean 
that a healthy
margin is taken such that it will not break in practice.

>    While it is slower than
> any of us would like, having a method to prevent the possibility of data
> corruption seems like a worthy effort.
>
> If there is a scenario where the timer management model described in TP4129
> isn't a reliable method of determining that it is safe to retry write commands
> then we need to do some investigation to see if we can resolve that issue.
>
> I appreciate the comments on TP8028. I don't like how slow the timer method is
> and really hope that we can continue to work on methods of making NVMe-oF
> error detection and recovery faster, while maintaining data integrity. The
> TP8028 effort is what we have in development and I'm optimistic that we'll be
> able to discuss that model at LSF.

I think its reasonable for a subsystem to report the host a failover 
delay. While it is
indeed a "best effort", its most likely sufficient for implementers to 
never see
where it breaks... I just had an issue with prior attempts to make it 
behavior universal.

I also agree that making quiesce in failover explicit is the best 
solution. But I don't think
we should reject any attempt of making the host respect the controller CQT.


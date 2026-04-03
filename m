Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D50E88D84
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 04:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZrMSG5WhqiegT+A0sFDzBwpum3aJGNMaHDmV5z7yNwo=; b=wXilGrx9KcPYFM0n+JLyGXqhSW
	6xUafPplbq7Pu+pE2FzwwLU+8rMlGp9vSHlr3mNpskcvrcZ3oIB8yanZydqlmn75+TZ2pKl+oXf2h
	qVqiwxSPa6t735lGlJm7wvRQq6wlCHeRVEiQhgHh9ZIdaD4fPM7HmPb/oqee6PUYZj9gFDv2GZa/s
	OmK0sE4B0eENYkz2+J3gampIC6JvOC3lk4TNGolAkMrcYI9Vmbica1DN4yoyUPpYzBcjy7iivqXIt
	iN7Cemo+tM+YMOXUVY05Mo4VGGSckb2rASH+fFoj6HOxhPyqoIFMj4S7BL8RhPlp5bNv+pEIMRVuJ
	BsS1XVtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ssB-000000037KQ-22ZS;
	Sat, 04 Apr 2026 04:44:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Tkm-000000014fT-2lR8
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 01:55:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775181317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrMSG5WhqiegT+A0sFDzBwpum3aJGNMaHDmV5z7yNwo=;
	b=FfdyKUsNIOhByVOgsPUr8rtxkka0b97BuqpvRT0h6WwwBh/SRK0TyRDG4oyW7ikCn2zDmW
	lZTXqmuXI6QthUFzVguNXcLo8ViIXKLKVcRBP+i+BEO2DZ5cwJ9fXnd2VKFSm0CqcCLGh1
	+48WLsc60AFN1ihIfwN0rUBWSNf+VeA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-NvGV8eYKMJmendw6hIzqCQ-1; Thu,
 02 Apr 2026 21:55:11 -0400
X-MC-Unique: NvGV8eYKMJmendw6hIzqCQ-1
X-Mimecast-MFC-AGG-ID: NvGV8eYKMJmendw6hIzqCQ_1775181307
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 270C4195608F;
	Fri,  3 Apr 2026 01:55:05 +0000 (UTC)
Received: from [10.22.88.243] (unknown [10.22.88.243])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EAEF1800361;
	Fri,  3 Apr 2026 01:54:55 +0000 (UTC)
Message-ID: <57ccc69b-2f4b-40ae-b7a5-feb99e34789a@redhat.com>
Date: Thu, 2 Apr 2026 21:54:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/13] isolation: Introduce io_queue isolcpus type
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
 James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 liyihang9@h-partners.com, kashyap.desai@broadcom.com,
 sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
 chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
 sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
 ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, tglx@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org,
 ruanjinjie@huawei.com, yphbchou0911@gmail.com, wagi@kernel.org,
 frederic@kernel.org, chenridong@huawei.com, hare@suse.de, kch@nvidia.com,
 ming.lei@redhat.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com,
 neelx@suse.com, mproche@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
 MPT-FusionLinux.pdl@broadcom.com
References: <20260330221047.630206-1-atomlin@atomlin.com>
 <20260330221047.630206-10-atomlin@atomlin.com>
 <20260401124947.-d4D5Cr-@linutronix.de>
 <5e6aa61e-0ad0-4027-bba9-cd906ab0d7e8@redhat.com>
 <20260402075810.w0GVbX0Z@linutronix.de>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260402075810.w0GVbX0Z@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: t6JUzARA3LX2qH08D5odwqrN9cWnGDl4jEFVJ0kgxzY_1775181307
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_185520_779531_231ADB80 
X-CRM114-Status: GOOD (  17.11  )
X-Mailman-Approved-At: Fri, 03 Apr 2026 21:44:33 -0700
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

On 4/2/26 3:58 AM, Sebastian Andrzej Siewior wrote:
> On 2026-04-01 15:05:21 [-0400], Waiman Long wrote:
>>> Could we please clarify whether we want to keep it and this
>>> additionally or if managed_irq could be used instead. This adds another
>>> bit. If networking folks jump in on managed_irqs, would they need to
>>> duplicate this with their net sub flag?
>> Yes, I will very much prefer to reuse an existing HK cpumask like
>> managed_irqs for this purpose, if possible, rather than adding another
>> cpumask that we need to manage. Note that we are in the process of making
>> these housekeeping cpumasks modifiable at run time in the near future.
> Now if you want to change it at run time, it would mean to reconfigure
> the interrupts, device and so on. Not sure if this useful _or_ if it
> would be "easier" to just the tell upper layer (block in case of I/O)
> not to perform any request on this CPU. Then we would have an interrupt
> on that CPU but it wouldn't do anything.
> It would only become a problem if you would have less queues than CPUs
> and you would like to migrate things.

I know that it will not be easy. Anyway, I will let this patch reaching 
a good compromise and get merged first before thinking about that.

Cheers,
Longman



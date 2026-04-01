Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792BDD39438
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/3sAJ1FdjGwRu+DMqvGIwhQdYQkK9kW2zWLcKVGLOXc=; b=1Fq+bYd+VzdqEp5Ey4a0p7cwZp
	JmPflJQVVt+rVmQpGLGKITpI+AJfSHGqqZfnRHbYRsAQyatuXNZVPQYEo3ABGMsKbgTU97BGLnufi
	YYWrzGds1tU7l4siaeP/R68hRnEnKroYNL8OVdokJPAOjzFZyijigBrs+BhFCNddqP3cZblSqNYTH
	yxUvScYqfv2CRTs8HxLF+fVKpdGcUqKgKrXKhhhf5NDm0ux0mlL6lir4v1H2VT26C6uYywq/a1z5b
	SczHgdm3LXRfgpEmvB/IMwbLJKJLVif8zEPVN+I9N0+8Cz6eWL2XUclVts0yPe5a2Y2ljo8TpFHmd
	uqr+XpLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Iok-00000000GH5-24vx;
	Thu, 02 Apr 2026 14:14:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w80su-0000000Fzwl-0Smz
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 19:05:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775070344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3sAJ1FdjGwRu+DMqvGIwhQdYQkK9kW2zWLcKVGLOXc=;
	b=chhC9Ol504m9LLSg19g9pQQva5ICkHzw8ifGFbdHAuSseFpTv+BzJruv1UYy8+GQOder+e
	N2OEz46VGqbn9S3c+gspvKDKUteLoajZ+ZJuuI6x5+u0pbs9Y9taU+u64kYrMvNcqvG9EA
	rU1aV+eH91SKax9/zyGoGwu1QQBMrrI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-gdXDJV8FOZaZNkUCfQRb2A-1; Wed,
 01 Apr 2026 15:05:41 -0400
X-MC-Unique: gdXDJV8FOZaZNkUCfQRb2A-1
X-Mimecast-MFC-AGG-ID: gdXDJV8FOZaZNkUCfQRb2A_1775070333
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FF8D1955D4D;
	Wed,  1 Apr 2026 19:05:31 +0000 (UTC)
Received: from [10.22.81.104] (unknown [10.22.81.104])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2C8F180035F;
	Wed,  1 Apr 2026 19:05:22 +0000 (UTC)
Message-ID: <5e6aa61e-0ad0-4027-bba9-cd906ab0d7e8@redhat.com>
Date: Wed, 1 Apr 2026 15:05:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/13] isolation: Introduce io_queue isolcpus type
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 mst@redhat.com, aacraid@microsemi.com,
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
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260401124947.-d4D5Cr-@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: m0QB3gEUG0szpEI_Xdp9j6n2XvqXa70Iz20Y9kh2yY0_1775070333
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_120548_234557_1991470F 
X-CRM114-Status: GOOD (  13.37  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 07:14:40 -0700
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

On 4/1/26 8:49 AM, Sebastian Andrzej Siewior wrote:
> On 2026-03-30 18:10:43 [-0400], Aaron Tomlin wrote:
>> From: Daniel Wagner <wagi@kernel.org>
>>
>> Multiqueue drivers spread I/O queues across all CPUs for optimal
>> performance. However, these drivers are not aware of CPU isolation
>> requirements and will distribute queues without considering the isolcpus
>> configuration.
>>
>> Introduce a new isolcpus mask that allows users to define which CPUs
>> should have I/O queues assigned. This is similar to managed_irq, but
>> intended for drivers that do not use the managed IRQ infrastructure
> I set down and documented the behaviour of managed_irq at
> 	https://lore.kernel.org/all/20260401110232.ET5RxZfl@linutronix.de/
>
> Could we please clarify whether we want to keep it and this
> additionally or if managed_irq could be used instead. This adds another
> bit. If networking folks jump in on managed_irqs, would they need to
> duplicate this with their net sub flag?

Yes, I will very much prefer to reuse an existing HK cpumask like 
managed_irqs for this purpose, if possible, rather than adding another 
cpumask that we need to manage. Note that we are in the process of 
making these housekeeping cpumasks modifiable at run time in the near 
future.

Cheers,
Longman



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8238C02198
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Feb 2025 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVdm69LZsZ68krGUaP9kXt8m8hyGi0rmZ8yyErWTcD8=; b=rVpfFxgWnMmC0gqIzE5Bs8jE/f
	UlZmBN5gIyuLils8hEp0CKse5L9wMn+pSwKUW0Mrs7JvjXE1RcIfRr1bavKbD6NGtUUoGFF194cv5
	MctXcKb7dZ6FvVAmLoLTingW9VN4JbFdt/uYWZ+aVPtyXP5RHdQLTEwEh92LHGb39fo76C13jHKbt
	//y1Xp7H0scoTotQuCnwWDaeX7AZAolZCZ2S/kvBMZjx5j5stVRyaOPwd4eQ0HRK1I9an7w89Nszl
	4liCNZaNdTvofY0/HqcyXhCeQEWIIZAJVctXMZvAWQTPXvSAJl9nr7Jo/0hh/jR6+TPujl8DehrRp
	9EkTduAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tg4ah-00000006pX2-3Xzr;
	Thu, 06 Feb 2025 16:18:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tg4VS-00000006oUR-2JjT
	for linux-nvme@lists.infradead.org;
	Thu, 06 Feb 2025 16:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738858412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVdm69LZsZ68krGUaP9kXt8m8hyGi0rmZ8yyErWTcD8=;
	b=F/5VdY1REXIrqxo9kRb9t+CR5LqaPgUWI2URLBlDOh8yDcRN1SoVcK8rNPo0ABJTeWyI3O
	AaozXEg0TeepeTNX4nIpqT9z2d8QKcmjxBdVluG6Wxnb3/UN0O0VdxVAcamS9sOZ1IrPrY
	hNwQLA/YrkfJq54F2HdU2BAEZdQJxxw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-T1GqqBqSPv-C-_i1YCftdg-1; Thu,
 06 Feb 2025 11:13:28 -0500
X-MC-Unique: T1GqqBqSPv-C-_i1YCftdg-1
X-Mimecast-MFC-AGG-ID: T1GqqBqSPv-C-_i1YCftdg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 808A719153F0;
	Thu,  6 Feb 2025 16:13:20 +0000 (UTC)
Received: from [10.22.90.103] (unknown [10.22.90.103])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFD4D1955BCB;
	Thu,  6 Feb 2025 16:13:18 +0000 (UTC)
Message-ID: <3184caaa-7254-494a-948e-4a3aefd05f4f@redhat.com>
Date: Thu, 6 Feb 2025 11:13:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nvme_tcp] possible data corruption when host detected path error
 and resubmit IOs on another path
To: Jiewei Ke <kejiewei.cn@gmail.com>, linux-nvme@lists.infradead.org
References: <DD72B155-35CF-47F6-A342-13445A9E432F@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <DD72B155-35CF-47F6-A342-13445A9E432F@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hEfasHvLGlm2xraIvwE81T4vjnMwUJhT_8EBN18-qJo_1738858407
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_081334_673057_AFCF9BA1 
X-CRM114-Status: GOOD (  21.74  )
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

Hi Jiewei.

There have been issues reported on this list[1] were some NVMe/TCP attached storage arrays are
experiencing data corruption during error insertion testing. These data corruption issues have
been attributed to ghost writes in the storage array following commands replayed on the host
during Keep Alive Timeout testing. TP4129 was developed to address those issues by introducing
a Command Quiescence Time (CQT) timer to the protocol. TP4129 is now a part of the NVMe 2.1
specification.

My question is: did you find this problem through some kind of testing or is this something
you've seen during code inspection?  Are you reporting this because you've experienced data
corruption with your NVMe/TCP controller?

If you have a test of some kind that allows an easy reproduction of this problem it would
be helpful.

/John

[1] https://lore.kernel.org/linux-nvme/1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me/

On 12/30/24 9:32 PM, Jiewei Ke wrote:
> Hi experts,
> 
> When the NVMe host driver detects a command timeout (either admin or I/O
> command), it triggers error recovery and attempts to resubmit the I/Os on
> another path, provided that native multipath is enabled.
> 
> Taking the nvme_tcp driver as an example, the nvme_tcp_timeout function is
> called when any command times out:
> 
> nvme_tcp_timeout
>    -> nvme_tcp_error_recovery
>      -> nvme_tcp_error_recovery_work
>        -> nvme_tcp_teardown_io_queues
>          -> nvme_cancel_tagset
> 
> nvme_cancel_tagset completes the inflight requests on the failed path and
> then calls nvme_failover_req to resubmit them on a different path. There is
> no wait time before the I/O is resubmitted. This means that the controller
> on the old path may not have fully cleaned up the pending requests,
> potentially leading to data corruption on the NVMe namespace.
> 
> For example, consider the following scenario:
> 
> 1. The host sends IO1 to path1, but then encounters a timeout for either IO1
> or a previous I/O request (e.g., keep-alive or I/O timeout). This triggers
> error recovery, and IO1 is retried on path2, which succeeds.
> 
> 2. After that, the host sends IO2 with the same LBA to path2, which also
> succeeds.
> 
> 3. Meanwhile, IO1 on path1 has not been aborted and continues to execute.
> 
> Ultimately, IO2 gets overwritten by the residual IO1, leading to potential
> data corruption.
> 
> This issue can easily be reproduced in our distributed storage system.
> 
> I noticed that the NVMe Base Specification 2.1, section "9.6 Communication
> Loss Handling," provides a good description of this scenario. It introduces
> the concept of Command Quiesce Time (CQT), which allows for a cleanup period
> for outstanding commands on the controller. Implementing CQT could
> potentially resolve this issue.
> 
> Are there any plans to add CQT support to the NVMe host driver? In the
> absence of this feature, is there any recommended workaround for this issue?
> For instance, could using Device Mapper be a viable substitute?
> 
> Thank you,
> Jiewei
> 



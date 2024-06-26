Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4296C3064D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5QY5hJae6l+5ZJIAe2hmaDyYs4OgH5aPGkBmEaOLMdg=; b=vaxPP9BuVS9vbob/xQ5mWy561U
	O3BzING015tCVVxnyWJ79emY0UUVhqnnqVyRp9M2B/R3zOoMp/7g2HIzXsOtSWEw18p6/jjSl3pHF
	RmCSRRjEdgI3b8mmh3+dYKYM4gTqS9WWTlSj8z7r3rks1TxIxe0UWPKEOsAgdV67FwnxsQfHFg/Zd
	J2I5BZeB18cpcoIpZu/vjXt23IQYaBN7fTnH25ENvLvFbDTrpcyMZHiLdRF5K6hEINNLFiLMdtScL
	o1o/R+9VhvBChksrQpVa1zxk8aNLXlpHpXJvjYCuRulhtJ5zULqQl5MLfHAdF+asey6iP4XPCeBh/
	oM7kGSLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYBo-000000082TR-1ql6;
	Wed, 26 Jun 2024 19:20:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYBl-000000082SK-23wE
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719429616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QY5hJae6l+5ZJIAe2hmaDyYs4OgH5aPGkBmEaOLMdg=;
	b=UfMSu8HF6jkju+Vm1t9G1wykh8HKqQ6ERw8zpgMpPP/2KkZwGqijQcVZ45KhXzSPj61F5F
	peX6n1mlrIVJcjQU+izZZq8Q8Wg/xfRMIkjP8Fws+PdxZbl3iYuwEuPGMB0dDEU4J+CGoK
	3lC7Gy/agT7NgqlsKaRwM+CtAM3VxSs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-3AIp45DLNLKqms-mlSNHAA-1; Wed,
 26 Jun 2024 15:20:12 -0400
X-MC-Unique: 3AIp45DLNLKqms-mlSNHAA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E9F91956087;
	Wed, 26 Jun 2024 19:20:11 +0000 (UTC)
Received: from [10.22.17.122] (unknown [10.22.17.122])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93F6C1956087;
	Wed, 26 Jun 2024 19:20:09 +0000 (UTC)
Message-ID: <fc2fd513-ab39-4d87-b2ce-e1f86bdf5d45@redhat.com>
Date: Wed, 26 Jun 2024 15:20:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] nvme: add reserved ioq tags for cancel
To: Keith Busch <kbusch@kernel.org>
Cc: sagi@grimberg.me, emilne@redhat.com, hare@kernel.org, kbusch@meta.com,
 linux-nvme@lists.infradead.org, mlombard@redhat.com
References: <50a62d8e-b45e-4ae0-81dc-f12c46a5a65b@grimberg.me>
 <20240626183819.23960-1-jmeneghi@redhat.com>
 <Znxl9kFmoJWg1S0D@kbusch-mbp.dhcp.thefacebook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Znxl9kFmoJWg1S0D@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_122018_275048_33027AE3 
X-CRM114-Status: GOOD (  14.75  )
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

On 6/26/24 15:03, Keith Busch wrote:
> On Wed, Jun 26, 2024 at 02:38:19PM -0400, John Meneghini wrote:
>> If the nvme Cancel command is supported, we need to reserve 2 tags for
>> each IO queue. Note that one addition tag is reserved to account for
>> the case where this is a fabrics controller.
>   
>> @@ -4580,9 +4581,13 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>>   	 */
>>   	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
>>   		set->reserved_tags = NVME_AQ_DEPTH;
>> +	else if  (effects & NVME_CMD_EFFECTS_CSUPP)
>> +		/* Reserve 2 X io_queue count for NVMe Cancel */
>> +		set->reserved_tags = (2 * ctrl->queue_count);
> 
> The reserved_tags are already per queue, no need to multiply.

Ahh, ok. I wasn't sure about this. So the tag set belongs to the controller, and is shared by all IO queues, but reserved tags 
are reserved for each IO queue.  Let me fix that before I begin testing this.

>>   	else if (ctrl->ops->flags & NVME_F_FABRICS)
>>   		/* Reserved for fabric connect */
>>   		set->reserved_tags = 1;
> 
> You mentioned an addtional tags is supposed to be reserved for fabrics.
> Shouldn't this just be an "if", not an "else if", and then increment
> reserved_tags?

Yes, good point. I was thinking we don't need more than 2 tags if it's a fabric.

So you want to reserve 3 tags when both cancel and fabrics are true?

/John



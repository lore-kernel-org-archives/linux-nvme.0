Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C12C369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 01:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VcSXw+s5+3IcDt4ycVWOHEvd84hZVwK8heBLaI0+unM=; b=wwK3bf5NurJev+uWwl+J+ELIFg
	0RvXtHH6U8B1aCGtInPcM3+uLFdsa5z5Gl6OKfknMi6zwQ9BS5AsarrM8lJK1oIhI7PBNvcT26kQ9
	gTkjBGjJdTeMQqqNgWxL8xNulE3m89iaDmL5nFsgPvLoP+4hlh7aICnKX2LWrw4iKOZj4UkGrpaWG
	DZJRMjSb7R2mVL6wRoThETKfgYwYaIJ3hX5fY8JY+aiv1I+Qnzqt67vup66quisaoB+fOUFXb9qmJ
	3LQe6KkJ/631nB4ajICg/W8ZuBErsC0HAUw7pq5wWrEq8XhfUjXesDUO3QhFqo29QK2KJ8NVgHBuv
	hSjpNf7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u87wN-0000000Fhm1-08C5;
	Fri, 25 Apr 2025 01:33:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u87wJ-0000000FhkH-0YOX
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 01:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745544792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcSXw+s5+3IcDt4ycVWOHEvd84hZVwK8heBLaI0+unM=;
	b=Ngokn9HqHHmfelS29Rxie7CLwmJwdlkerLA+D7mj+cVjs+AA4TxjUgnSYP3X5g8Zw1gtnK
	cL8Ga2ZGdR2Su7tVKejOwuU43yv46jvasEnt7VXCm+eAYZ7YGwFX3h7EMjsu9eafoEWxWj
	kUohoGD8keh6wxv+AYcpOJYO1v/jp0w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-8O4CrLA7NT2m330BUYl0_A-1; Thu, 24 Apr 2025 21:33:11 -0400
X-MC-Unique: 8O4CrLA7NT2m330BUYl0_A-1
X-Mimecast-MFC-AGG-ID: 8O4CrLA7NT2m330BUYl0_A_1745544791
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54a6b0c70so172939885a.0
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 18:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745544791; x=1746149591;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcSXw+s5+3IcDt4ycVWOHEvd84hZVwK8heBLaI0+unM=;
        b=iR4LnzPbWwsQIKwj73D0VOXjY77NbDmI1XTdw1HmXc2/jPuqQUR1HxTL1srjyQDya2
         QbL9/bL6Inr2KP/E3BK8Rw/2ArHVXQEjZSrAXhgVJP6k/+NG7ubAO46l8qnsAjdBKqEb
         R9Ws0NXSCkm74rnMRF7PW/agkyz/VUFdw2hc8qul2v+nUaxTedr5y77dKKH4D7s+DU3/
         vyrK0p8mvqjL9QpoCSOJ2AMxasg6r3pDSK+q6bifOJZFPavDzFhpbzcGBhvG9neansQm
         3K1BG5o2yOMZEdmMVHuH/eVb4UsKdX5NrBPeghRPYsi2ZA5lfjRfTF+cvp27hiPk1iYu
         0leg==
X-Gm-Message-State: AOJu0Yy0EwUjaqrO7wJP/rnXh3HjyIEhTskrauFQsgNT9tVJs69nDXT1
	ttnhVFtDC/w0mI54ydnIG3l1dl+3gbD9FRUYe5PXe94/OiBaQeckImrjDgvS0QTANCWdWahijVl
	rgWOBIZ/+fhY/NpWBXZzjJB1WMYsnXXlI4kLeeYCuq3VHGiovg5qNkkTBcBj/q8Cx
X-Gm-Gg: ASbGnctv2Si3gUvZqH9RPLarU5shMJFnlwUtYnfVt/63RzrROLMDE4eSlP+aXGMPZvq
	9BMRCpG58fSk1AWoI0eLcwso5/gyYUOuSIP7S8131eyrf5Db+Z0z9owPDsxkk/EsM9MlTxLEbCF
	LvXqKzGYWhLg38jc4JNDik2GjFY/pOqPtzpX94TqyfnLvVqVSiG+dVlwyOIMYk04wSQq6ITxnSJ
	tooYkoI3TOcl+flKE6jecYI9EEqpgIhZMZQ+/xfphx6lHpRSO4VrKNj9SnIgaQ+jS7k2fRI0Ken
	iuSOi5UsCjtzm2Vrt+jsZTZ9EYcwaUno/XvkddysgufA9tlrKbsgQmA/Ag==
X-Received: by 2002:a05:6214:509d:b0:6f4:c21b:cd6a with SMTP id 6a1803df08f44-6f4cb9bf08bmr12494686d6.18.1745544790772;
        Thu, 24 Apr 2025 18:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKObHEDSD0uhwvqx0FfjX6CMdc6GExMF71Kip+fcZML4+LupklZTjnnCP6brVsoSZep1xQvQ==
X-Received: by 2002:a05:6214:509d:b0:6f4:c21b:cd6a with SMTP id 6a1803df08f44-6f4cb9bf08bmr12494386d6.18.1745544790425;
        Thu, 24 Apr 2025 18:33:10 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0938399sm16447456d6.40.2025.04.24.18.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 18:33:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
Date: Thu, 24 Apr 2025 21:33:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Waiman Long <llong@redhat.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pSdbELYjGzwtzJNZyurJYrW_tmrNgUsoVrTwyqO3bnU_1745544791
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_183315_254325_BEB26389 
X-CRM114-Status: GOOD (  14.19  )
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


On 4/24/25 8:53 PM, Kamaljit Singh wrote:
> Hi Waiman,
>
>> On 4/23/25 1:30 PM, Kamaljit Singh wrote:
>>> Hello,
>>>
>>> While running IOs to an nvme fabrics target we're hitting this null pointer which causes
>>> CPU hard lockups and NMI. Before the lockups, the Medusa IOs ran successfully for ~23 hours.
>>>
>>> I did not find any panics listing nvme or block driver calls.
>>>
>>> RIP: 0010:cgroup_rstat_flush+0x1d0/0x750
>>> points to rstat.c, cgroup_rstat_push_children(), line 162 under second while() to the following code.
>>>
>>> 160                 /* updated_next is parent cgroup terminated */
>>> 161                 while (child != parent) {
>>> 162                         child->rstat_flush_next = head;
>>> 163                         head = child;
>>> 164                         crstatc = cgroup_rstat_cpu(child, cpu);
>>> 165                         grandchild = crstatc->updated_children;
>>>
>>> In my test env I've added a null check to 'child' and re-running the long-term test.
>>> I'm wondering if this patch is sufficient to address any underlying issue or is just a band-aid.
>>> Please share any known patches or suggestions.
>>>                -          while (child != parent) {
>>>                +         while (child && child != parent) {
>> Child can become NULL only if the updated_next list isn't parent
>> terminated. This should not happen. A warning is needed if it really
>> happens. I will take a further look to see if there is a bug somewhere.
> My test re-ran for 36+ hours without any CPU lockups or NMI. This patch seems to have helped.
>
I now see what is wrong. The cgroup_rstat_push_children() function is 
supposed to be called with cgroup_rstat_lock held, but commit 
093c8812de2d3 ("cgroup: rstat: Cleanup flushing functions and locking") 
changes that. Hence racing can corrupt the list. I will work on a patch 
to fix that regression.

Cheers,
Longman



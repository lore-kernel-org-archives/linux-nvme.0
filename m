Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA539C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 21:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aU4NFciLR4UCyMwqNbOWtp1Qy37FjSg/5JGcNCTMQtY=; b=BtcmfsI0C8MKYzu8f3Y2WqmUAy
	CHrdLc0xzTgTON6YwF1uSDBKNogRo0v0Wpda/sYdNQPqSscRKFVL6uOfziiFznhdh/pUwndb2nptD
	tBpoJiTyYWoCifRk4ehQjScVq/nlolJ7wEzKNQX+vbltNlxxiJIUl1Y2LpW1ZSKkmolu8jsRD3Q/V
	WYIpaGuZ6QVOZVtgVRmW1JWscmYcPhvrFV/pWJrBLk46BwikuaFa8HjQFyQJ2rEqLilwQx7KrxJIX
	TokM2jEpvQui7LaTEQ2RiDGRK/axjM8/c/WTa9MRKHWBWfPFrBugLcPDCm65EABVtyobst2mO8reM
	FiT+ZnzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7hbk-0000000C6Kf-0OEY;
	Wed, 23 Apr 2025 21:26:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7hbg-0000000C6K9-2h3O
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 21:26:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745443569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aU4NFciLR4UCyMwqNbOWtp1Qy37FjSg/5JGcNCTMQtY=;
	b=F9s9UYiRbOLfhW9Kwhsv76TeWe4A1+TefuoYoWQCqO6tLFqSBhVDTa3g0xjKleGMvXd9zf
	e7w5Ay0iqhWnVTt7l9Ymho0FbV3i80kJ38+MiXyoSx2LPPlYi2dyNu+sLrj6JPMJxV+swM
	+y/D/humE9oLPRbKUIVG6nnFphkY3S8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-ZEJ8GMJfMR6HuGXdy4IDaw-1; Wed, 23 Apr 2025 17:26:07 -0400
X-MC-Unique: ZEJ8GMJfMR6HuGXdy4IDaw-1
X-Mimecast-MFC-AGG-ID: ZEJ8GMJfMR6HuGXdy4IDaw_1745443567
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5750ca8b2so46373585a.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 14:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443567; x=1746048367;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aU4NFciLR4UCyMwqNbOWtp1Qy37FjSg/5JGcNCTMQtY=;
        b=i9HyNjNvCY9wboX3r7GjhqOdIwx4huMJl3ugo7eDR9C0ONXqgMRzLEnV5TbgJrggTP
         /xhnFhR1vC8KeKBal8LROu7L0nkWf6C87dIqMUj4hkWytN5RZPw4zpzmcCEPUkaqtLkI
         j9l3epTfkooL94HDvgboY/CRJCScOplcWRrXgrQyU+hwhQQIP+/KldkyZNLqVLe3vdhH
         ovJ3bU86vZP4I693S7KKOVG20xj8IMdzfC2R18nd7drG2GFZKAJgnUVQilKoj/f13Vi2
         YAedW3+Q2yqkZC3ZK6sCqHeVrjkEnMEtO/kOHnOx/8eM+GtyqmFgGIPtkcsWEUDIRSk4
         EfbA==
X-Gm-Message-State: AOJu0YxMSoFEuMEW7oX+XDxPtvBL1/6wvLG++NoaKZ7jM9X0kfzDfdhP
	YNolxKq9MzTsxlRjRYbogdoQQVSvU05HAy6enuAUVJtteeOV8mvIZ09hcy5hEe1abaKOwi6uBOB
	vbZlTUa2YUp4HI9cblYggx4O81xinyekhJzFfLg5HK79LzLs+OW9miJ3Ji/ApbXrg
X-Gm-Gg: ASbGncsk8ZeiehGc0lFc+uBqG38DoSVcbcKG2bTsmiuPVqcwqX7T3ROblkJQnJZtzbE
	0K5dI2G+q0zNvCXk1VthhW9Ysh/zihlZsWfvwrV1kYYbpePn7Nx9TYqeTjQKk/47pWjARB5owNp
	m0TkuPQODYxGLEmhKEz9Llbqqq82mocq0fx01usVufL37M+4pybNV8ZahDohkv6F82JEv4Xl7SK
	gOSqXxTYSjCrDVqQHTErKos+kKkDk2lwyOnmjzSKYGsecGuJFDQtutlPTFj6qrF9kY12ViStBnU
	ISDTmaUeZS9otaEKHF6xNCjGfTG6ph8ntVsLg1gD4myrCHZd/RkeZgGu1Q==
X-Received: by 2002:a05:620a:199f:b0:7c5:46e4:480b with SMTP id af79cd13be357-7c956eda80amr54939685a.22.1745443567272;
        Wed, 23 Apr 2025 14:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8haqQUDBHoe6I7z1HOjPMMGHldKnDbmOSgGYPeTOaPgqtmaNKn/a8LPm4WITMwLxPdPWBbw==
X-Received: by 2002:a05:620a:199f:b0:7c5:46e4:480b with SMTP id af79cd13be357-7c956eda80amr54937985a.22.1745443567003;
        Wed, 23 Apr 2025 14:26:07 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a70768sm731509485a.23.2025.04.23.14.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 14:26:06 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
Date: Wed, 23 Apr 2025 17:26:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J0U00wDNaZKUplagf2C6HfcrPGRB-GtWuE2Z_kPE08M_1745443567
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_142612_766885_301D7976 
X-CRM114-Status: GOOD (  14.06  )
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


On 4/23/25 1:30 PM, Kamaljit Singh wrote:
> Hello,
>
> While running IOs to an nvme fabrics target we're hitting this null pointer which causes
> CPU hard lockups and NMI. Before the lockups, the Medusa IOs ran successfully for ~23 hours.
>
> I did not find any panics listing nvme or block driver calls.
>
> RIP: 0010:cgroup_rstat_flush+0x1d0/0x750
> points to rstat.c, cgroup_rstat_push_children(), line 162 under second while() to the following code.
>
> 160                 /* updated_next is parent cgroup terminated */
> 161                 while (child != parent) {
> 162                         child->rstat_flush_next = head;
> 163                         head = child;
> 164                         crstatc = cgroup_rstat_cpu(child, cpu);
> 165                         grandchild = crstatc->updated_children;
>
> In my test env I've added a null check to 'child' and re-running the long-term test.
> I'm wondering if this patch is sufficient to address any underlying issue or is just a band-aid.
> Please share any known patches or suggestions.
>               -          while (child != parent) {
>               +         while (child && child != parent) {

Child can become NULL only if the updated_next list isn't parent 
terminated. This should not happen. A warning is needed if it really 
happens. I will take a further look to see if there is a bug somewhere.

Cheers,
Longman



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E523C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 01:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KCClB33bqWUfAaosnf+MBH1sPLHPMLDQYLjiZVeb+ZA=; b=WHqVHDnavy5AkquzkU5iFF+RFC
	kIfdglxQkoeEET2NrChG6aRMZxTuAkvPVYXSMpICPDkgWmclT/JittekcW5n+oxzTUvtkKLcdTc6D
	xfr+kzsKnXTd4b1bfra58wi+qZwTtlVwduqx1Qh+QadtCKIPVMSO/dKh7xOz5jRgdwh+lStXeIR40
	kPWUd/CPSNohrdTLbGzewU5JvIA/TvZZoKPW7/ZMz/8HTpjIEgUjbqsTmKM2F8cPtUhZXqjVENdVQ
	Z9XO5yQ56oqTbK3+3UAWgxHyX7uMLSf5zlnqFT/tn8Azce3XRDSbDztm1ZadLs01ZAgvlB2+OiRif
	m8JN9QGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u886Z-0000000Fij5-31Na;
	Fri, 25 Apr 2025 01:43:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u886W-0000000Fiid-2jay
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 01:43:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745545427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCClB33bqWUfAaosnf+MBH1sPLHPMLDQYLjiZVeb+ZA=;
	b=BhhoNaRAYNZLBj9ZnaCWe0nEU+v+T7qOv16yjg7t0oaw0+7uwfOGvAnDXyAS/FIqPVcA9T
	urUQwXeDTNdYj+XnnTnjO54/Dl4qpFzroAIVj2qTHgSH9vBiKNsIDO4BqLsuIUwZQyYnVF
	/Cz3BblryAMuiEyejTU2lmc/QSxlJXw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-u9M1qgDGPDqHx9AySWDhUQ-1; Thu, 24 Apr 2025 21:43:45 -0400
X-MC-Unique: u9M1qgDGPDqHx9AySWDhUQ-1
X-Mimecast-MFC-AGG-ID: u9M1qgDGPDqHx9AySWDhUQ_1745545425
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5cd0f8961so353407085a.1
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 18:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745545425; x=1746150225;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCClB33bqWUfAaosnf+MBH1sPLHPMLDQYLjiZVeb+ZA=;
        b=rE8cPAy55JIah3DJ7Y7uRIixITv8/9ydPBbdWgdbMEDj4FGVPeIWcW2Rcr2CUt0m7d
         FYOgU5O3gzgwu0hjG2ZzJoa8RgL5p1JqAbspQiwqDA6PsMj0YTPt20/8F6k+L+fqLktT
         jJ3ti74L6MKUKOrvkW1wRvT0YXpf86GVdatsy0/fa7bBgIdu/nBmVtc2qsYDniqyTHYQ
         S4TSHihiJVMytkzlQ9vwopKYoS0AK7kSMNYkIFMBp9xq6H7yGk4T5UbrytRQibWzjMRI
         lcQPZsOLezTciE4lz6pPZfKoA9m4ATdsFjAHCKh10tTjobrt9UeJ4UJ96lqY98iJxgSS
         aYSQ==
X-Gm-Message-State: AOJu0Yxm2QQ0LCtmApgmE/KUUAtvw6YIdVOh2MMLqD7Qoj6QVU95mgp4
	6kOWon++DQWNDRsFG7oTHoCI2S7i8jcGSP/ad3AC76I5tUmkCd/tZY3AtoHnS/5Y6I7PQJ38Q9m
	soedqvj5X1xcc04eHEk0JxoLDB7tbCNgdd0aIOCwdSV6wDJXkQY+JjrIWclRnJ0Xs
X-Gm-Gg: ASbGncuJk9lcqtfdhalWzcBVq27LQTypgEW4jCI9QfM/vnjAYCQ+AkxCuTMwZz/PQlf
	tK5YoctwzLdrOqymhHn4Jbr/0VmYSL7BkgIFXWW7LO8JeQM4wKe9qLLQwqxDsCdXp3Cs3rJYLsV
	nvTi5ANOhIc2gtNh+ruGFGZfugitqPFTm/zksF/EMp34YeQWj22nKV48bmbBhet6gv1INSjj2ai
	eLHI3krDyvUM9ke2DBIaxKJ1uJUe8oyc3LBjLLa0BYSFgb9O6xcsGsT3mxRr2d9S5rsuHMZiLeU
	jkNjg/K2zwqJUV26iGq+WMF8iDHWzRkYgJE2p9U+7J/mIRm/nfLgahRJAw==
X-Received: by 2002:a05:620a:440a:b0:7c5:5a51:d2d1 with SMTP id af79cd13be357-7c9607cfa80mr128585885a.55.1745545425328;
        Thu, 24 Apr 2025 18:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG//NEwXF6JviKiJm8lmp5FnRYUompC92ypydph5SsIh1bKbr7cFsk6XGINnp7DwftF8KhI1g==
X-Received: by 2002:a05:620a:440a:b0:7c5:5a51:d2d1 with SMTP id af79cd13be357-7c9607cfa80mr128584085a.55.1745545425090;
        Thu, 24 Apr 2025 18:43:45 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cdc559sm161890185a.57.2025.04.24.18.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 18:43:44 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <20aa3292-091c-4d27-a77e-c0aef4bbb276@redhat.com>
Date: Thu, 24 Apr 2025 21:43:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: Waiman Long <llong@redhat.com>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
In-Reply-To: <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RlVjTYiyvWJ34qJeJ5VcM-gt691--wnC4Tah6D7Kuz8_1745545425
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_184348_769677_0214CA9D 
X-CRM114-Status: GOOD (  15.65  )
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

On 4/24/25 9:33 PM, Waiman Long wrote:
>
> On 4/24/25 8:53 PM, Kamaljit Singh wrote:
>> Hi Waiman,
>>
>>> On 4/23/25 1:30 PM, Kamaljit Singh wrote:
>>>> Hello,
>>>>
>>>> While running IOs to an nvme fabrics target we're hitting this null 
>>>> pointer which causes
>>>> CPU hard lockups and NMI. Before the lockups, the Medusa IOs ran 
>>>> successfully for ~23 hours.
>>>>
>>>> I did not find any panics listing nvme or block driver calls.
>>>>
>>>> RIP: 0010:cgroup_rstat_flush+0x1d0/0x750
>>>> points to rstat.c, cgroup_rstat_push_children(), line 162 under 
>>>> second while() to the following code.
>>>>
>>>> 160                 /* updated_next is parent cgroup terminated */
>>>> 161                 while (child != parent) {
>>>> 162                         child->rstat_flush_next = head;
>>>> 163                         head = child;
>>>> 164                         crstatc = cgroup_rstat_cpu(child, cpu);
>>>> 165                         grandchild = crstatc->updated_children;
>>>>
>>>> In my test env I've added a null check to 'child' and re-running 
>>>> the long-term test.
>>>> I'm wondering if this patch is sufficient to address any underlying 
>>>> issue or is just a band-aid.
>>>> Please share any known patches or suggestions.
>>>>                -          while (child != parent) {
>>>>                +         while (child && child != parent) {
>>> Child can become NULL only if the updated_next list isn't parent
>>> terminated. This should not happen. A warning is needed if it really
>>> happens. I will take a further look to see if there is a bug somewhere.
>> My test re-ran for 36+ hours without any CPU lockups or NMI. This 
>> patch seems to have helped.
>>
> I now see what is wrong. The cgroup_rstat_push_children() function is 
> supposed to be called with cgroup_rstat_lock held, but commit 
> 093c8812de2d3 ("cgroup: rstat: Cleanup flushing functions and 
> locking") changes that. Hence racing can corrupt the list. I will work 
> on a patch to fix that regression.

Oh, this problem has already been fixed in the cgroup/for-6.16 commit 
7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with 
cgroup_rstat_lock"). It should be in the linux-next tree.

Cheers,
Longman




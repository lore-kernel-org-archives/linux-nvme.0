Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766CBC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BuIu6FpgSdCcAuTLohsFBTj2vc6nnMTkVfa1ZAvd/hA=; b=gTE86n0S8J//5+iN59DY7sKAUd
	EMAWwKpFR3kezta34m8KC/ISxXNgeuJ3OmOX/9UgJTU+hmd45D58IvVEslx+GHOJvBUrmltgWtD6d
	GjZDVC5Le61wYqjz383K/J3zBWgQX83x4BCUUriySIuQzFUnoul0QlvAb8cK5ZkPZG5E8GpDj5H4l
	O0ISszrlQh7k3b4TqByy94D/a8hGlHkvchNkhdte07uYu+cT3bqHLfWnDWrzYV0lHJF6g8gTYrgWT
	RzPN0Ycep5YIANssSWA2KB7/L36DB3S8KudV/lLLRyZBnJvjdYUJFOiyoZGvYehxV11X6lSat/E9H
	OBgh8Avg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u88CS-0000000Fj3D-3Z8l;
	Fri, 25 Apr 2025 01:49:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u88CQ-0000000Fj2n-2ZO4
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 01:49:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745545793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuIu6FpgSdCcAuTLohsFBTj2vc6nnMTkVfa1ZAvd/hA=;
	b=HHrJP95mgVqUbpzBpsVdnhuhaNdlNzvBQ++ne+qHQzX7Ptgb38vUAnJDrWQxB8Ed5VyEqE
	TvbxhEBEkMTd1fAgRSoIfQ+6CvFqag5j9nBcohLWuEKWyzhngxQKQQqvZH3RrpRFgL8HiD
	WQt5d5JVjgXmz+Upivg1zM6b42u8F/w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-Jv39h5TmMv2q8skktjQ3Sw-1; Thu, 24 Apr 2025 21:49:51 -0400
X-MC-Unique: Jv39h5TmMv2q8skktjQ3Sw-1
X-Mimecast-MFC-AGG-ID: Jv39h5TmMv2q8skktjQ3Sw_1745545791
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4770cbdb9c7so31747541cf.1
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 18:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745545791; x=1746150591;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuIu6FpgSdCcAuTLohsFBTj2vc6nnMTkVfa1ZAvd/hA=;
        b=eC8IKaIUeBD3t7ZOVoWJ1QFrdkdfVAV3cydjGQSO8UWCBtSiwd0BXc0TQcTBS8gf9V
         fs++f4yPyrWiuK1nCB30mxO0+1rb2Kj3mP58NfB2DkT7pvJPS3Zrl8++RskuoaCpp3in
         6iW0UqbHjr9YTVflm8zbBRtDKg9Blfvu4Nn3+sKIrJqAAUFh2pS8ypjglokToE5WdP3k
         DRIcg+XD16Xoi39cE6chevWy297LNEpqRJgJ+1c14Y3UzSRlwaaaEvhxdb/XkLpFiRic
         I9wug02Xm1wnxbsTrXO1wTnV2drDdjAzzg9QNv64Ov7/gW1RJupATgswCCG78z2X8TEc
         jWyw==
X-Gm-Message-State: AOJu0Yz4Ny3PFFjbyHK7+M/+2x7FGn2MlDZLZajdobM+W2O6DsGS37SO
	oFDwCHaOhn1tOsjGm9i8A5Aq8UILqqL5xzZ8O7MXfGTdJZ53NkYmLHIisy0WQXk9GF770l0acNe
	WwA56DDw6aqomd6P9ZO1IFTmuKuydTYCLubrNdn+viFwTz0fpBdp971Cx9g07OjsB
X-Gm-Gg: ASbGncvh3ee660jKgjHh2ffZ2aScj7yQOBH8uHne3nUbgFvF0Pb3YtjwwUi24zO47Mo
	VwVgRrAz/Q4pGefVxUtQ+cbumZHRh0lbGKhPVNEjwVoC2grpkPjRfAh/QjsXNmyw7UWxczhw+Ej
	6zLEJZVJoqa6ACKQFkrheHBNz40kZGrsyhPWuzkfxFmuGcj2OIos29a858PCGdQzYQIl5EQfc4U
	Tk7y+VMRiaapQouPzD1wGL80eIzD/eqkr6wJ+pwhbcR1eVR2N64HRxVAciXYxLH2C813UH5YR0B
	5hfMZlIE4F/882v3Of5bB3AJvCasbZUgs2iLaT55LH/KuftbI7sQzfb2PQ==
X-Received: by 2002:a05:622a:24d:b0:476:7e6b:d2a2 with SMTP id d75a77b69052e-48024a7dac2mr8362771cf.35.1745545791018;
        Thu, 24 Apr 2025 18:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAJgknqPbNDIbXMiiiqKtYRR3XWPVLR30o7wYomwXhVSzOlUPsR/NBaj6Mbpm5BZORkv9JUg==
X-Received: by 2002:a05:622a:24d:b0:476:7e6b:d2a2 with SMTP id d75a77b69052e-48024a7dac2mr8362551cf.35.1745545790675;
        Thu, 24 Apr 2025 18:49:50 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9eaf2867sm19489011cf.7.2025.04.24.18.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 18:49:50 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com>
Date: Thu, 24 Apr 2025 21:49:49 -0400
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
X-Mimecast-MFC-PROC-ID: YrJtBX82zV9P4m9CR8hUgEfbq4_OhXO6gc4eR-jCi6o_1745545791
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_184954_737608_D6A6982F 
X-CRM114-Status: GOOD (  16.91  )
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

It should also be in v6.15-rc1 branch but is missing in the nvme branch 
that you are using. So you need to use a more updated nvme, when 
available, to avoid this problem.

Cheers,
Longman

>
> Cheers,
> Longman
>



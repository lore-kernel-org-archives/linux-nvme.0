Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B61C369D3
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pProaOAcY22PUYh6aXXhX0tcj+PiRJFj37d/6nPGIUY=; b=lvl1xh8wKPIMLNRaVWf9MKjVz1
	jBTQHEEjjoC/UHGJgINlkA70pOSiyyopFNw6JnNrTjZTg/VTwccJckxdBelBhoAs8WIQxXAYCMq5c
	/K7aF8YiDZPma/A9/LV5TOh2O+J7QANINYSkTKYTFTxlkrtlm7/uRsqbJ1xcNFlR4NoaCxdO5Ynji
	H6GGB3xNxuQZTdfFV3WmTnmUFX3KPIy57+TAuIqaHBpqPNIBRwng+X+feE0Ok7UVVEEozu+4dT3Uu
	5GQs6y/8X6IQptAgATSCdfn2xCWhQTWq37t1pzhtHkbiiaxB545tFqeDHqp/3wBYJxfaiTIcJXXXt
	WgKcD6DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8LxC-00000000EGA-2ylj;
	Fri, 25 Apr 2025 16:31:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8KtG-000000001rT-0FcO
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 15:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745594577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pProaOAcY22PUYh6aXXhX0tcj+PiRJFj37d/6nPGIUY=;
	b=PaNRlg+NHkkuxcdCOHgfAjNX770ZDCVoFreIhYmmHt4dnkcK2QHCTjvOWbRDZaFKLLX11t
	lttSxv9uzGQqv3/qIrf0HFguS3U6xCHowPzj/CDadXHW60BeYN6ZePrCl/ECksVPfxvPup
	f6IOn44o5KULIwM8Aa0cypmYKniH8c0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-q50me0FOPH6Ny3xq0zmjtg-1; Fri, 25 Apr 2025 11:22:53 -0400
X-MC-Unique: q50me0FOPH6Ny3xq0zmjtg-1
X-Mimecast-MFC-AGG-ID: q50me0FOPH6Ny3xq0zmjtg_1745594573
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c53e316734so392734585a.2
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 08:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745594573; x=1746199373;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pProaOAcY22PUYh6aXXhX0tcj+PiRJFj37d/6nPGIUY=;
        b=BOCO9ix9gPJrLeI+cNHgZPLdK/Rg9NLsLujQDVQNSegWNRNwKwwywlxMfOmNYlc5Im
         RK4xLRHl/US7SRDxsyhILn9SpqNgbigutQ3QbLnH8/J/SOp+WuEaTgyGiDgD2UCOW4Fu
         IeYnCByIdAnT2+95fVlMahsFqIdnGoFzUIqqDicgrgyuOtXgH8RjISNrueoszzYn5BUI
         YpYvq/8bAHR3njxleHbejqGsiMUBp15O8TXdXshek2TmRgMiIw1Ec3Fj67Q/C6kzVWVw
         c3yYoAgtCqrUo5AfBqY6QXDFU3SKILoH28CENNYfgY8jHDTAfhrE9kj/mkbhPh2OyStK
         w5rw==
X-Forwarded-Encrypted: i=1; AJvYcCWb2CpOrECwr0FRTeemyOSxbSrvfDdy90+sPmHhwuoQNCflxf8kPs4YRRCalj3CImBjgUR58KpIqVPJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/CW6n6xogAjO4iFo6T3cNjcuexPKU5vJBC0z8ZQ4JMuXtPYjI
	4qXGg+VCYhASYPEyrnVvQNxxtv5185h5TBuoaCtnK9sbHkey0HTZo5FkrCWyhm3lS7Ws830j+cm
	/Xj1huKkGYS1E1KFkBVU8sW3vBp71dROdFZ592INDjlVHA2ZGwct3cgGuDg6BHiqA
X-Gm-Gg: ASbGnct8yO6GLs+dGQoNOUgxGa72IdgguzAjnvBxGxhBHtw8bmIw9BaFk21blhR0pyi
	fJRa/YDJ5oRp4ikEALufmwiUxnaqk4hZQteAlZ9RWY+afUDdXtQtalMF9NCljrrmuaI8EcNsoJt
	5rEpLtqHxLqnDUl6+pF7P4KU6pGVfZrQWtw88+u+dLeuxxFdALbvmu4NWPck1m5fmKPIUwjIrn5
	kpmfZqol6EKkYvZQW3m6ivRozP+8LL7n1Dj5B4gIS4qrnOH+OA3qIwuQ/B1W6g0Z0s3iuI0f4+8
	jWx5LdwxNmsx0D2PFMbLmip8DFKZQPG1swiuEgnQZroJtDhwTjv9rIjCdA==
X-Received: by 2002:a05:620a:319a:b0:7c7:a63c:319a with SMTP id af79cd13be357-7c9606b05a4mr434229485a.9.1745594572982;
        Fri, 25 Apr 2025 08:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6em+X09lALI/H5J1BXx46XSb5pfUcEyWkE5OIrodgaIGgquVEvwQi2aqd6SqAbIBWR3hbaA==
X-Received: by 2002:a05:620a:319a:b0:7c7:a63c:319a with SMTP id af79cd13be357-7c9606b05a4mr434224385a.9.1745594572413;
        Fri, 25 Apr 2025 08:22:52 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbca1fsm228970585a.36.2025.04.25.08.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 08:22:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8a85a074-d4fe-404e-9438-131963a51051@redhat.com>
Date: Fri, 25 Apr 2025 11:22:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: hch <hch@lst.de>, Waiman Long <llong@redhat.com>
Cc: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
 <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com>
 <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <20250425145450.GA12664@lst.de>
 <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com>
 <20250425151140.GA14859@lst.de>
In-Reply-To: <20250425151140.GA14859@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H7RZ2xqwEFY7sBvipzs59fwHhMkGsur5QU93QcFeiiI_1745594573
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_082258_189327_FB517A0C 
X-CRM114-Status: GOOD (  11.77  )
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


On 4/25/25 11:11 AM, hch wrote:
> On Fri, Apr 25, 2025 at 11:04:58AM -0400, Waiman Long wrote:
>> On 4/25/25 10:54 AM, hch wrote:
>>> On Fri, Apr 25, 2025 at 02:22:31AM +0000, Kamaljit Singh wrote:
>>>>> It should also be in v6.15-rc1 branch but is missing in the nvme branch
>>>>> that you are using. So you need to use a more updated nvme, when
>>>>> available, to avoid this problem.
>>>>>
>>>> Thank you for finding that commit. I'll look for it.
>>>>
>>>> Christoph, Sagi, Keith, Others,
>>>> Can this commit be merged into the nvme-6.15 branch please?
>>> What commit?
>>>
>> commit 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with
>> cgroup_rstat_lock")
> I don't see how that is relevant for the nvme tree?
>
The nvme-6.15-2025-04-10 branch used by Kmaljit includes some v6.15
commits like the cgroup commit 093c8812de2d3 ("cgroup: rstat:
Cleanup flushing functions and locking") but not its fix commit
7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with
cgroup_rstat_lock"). That can cause system crash in some cases. That
problem will be resolved if nvme is rebased on top of v6.15-rc1 or
later as the fix commit will be included.

Cheers,
Longman



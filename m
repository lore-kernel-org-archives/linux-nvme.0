Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C39D41D41
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOYYrAKsRLkotEPjA+hBse5PtLPm2vozdMcs0N4/zA4=; b=pRd+Lq4vpCnnYXwr+tvvuNkmRY
	bz+EIcxZaSLjaeX3gM2ky9LSP8gpQYTLMl88yIV0KijN5NYcchPD/qDcrm0QbG/wa0TBWT5JeautY
	3/D+N9eTuYySqsDuIGQQZw80EaMvEx6C/cAG/hTjOtLptacoda107epZN+hdZ+38Z2CwF0VhTygta
	v+IlG9bIL4/QXBr7edX2Uy+daEKwdorVtjUeYGCOSVwyT+lL4K4bGiu9AmMNmpfliIaXRmS58gH2s
	4+lniZbL71ZIhcUcO4oZcLG9gZJVYw1+dgtvnScY4h225GudjvV3mT79iN9RTSprL4YfBbw7EK2Nz
	SvtFUxhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAflT-00000001sHH-2xmL;
	Tue, 12 Nov 2024 01:32:19 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAflQ-00000001sGV-41QP
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 01:32:18 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso45167855e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2024 17:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731375135; x=1731979935; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOYYrAKsRLkotEPjA+hBse5PtLPm2vozdMcs0N4/zA4=;
        b=GtNZmZOzkZuIPDY1C2u6pkwi0/85CYkGbXIgc/BHnkxM9cO8rMxlc5epsb1pbTZX5R
         xbZ+9csj2QsNmho73iV7nSPBZvlGF8GLnOrCgHgei4RBLasKa7Fz0g8Ux1KrXyB/Fegp
         HMrHXVGSLeSbkpGVXGEN7cLUMrKfSGI9AQ/CdstOZlrATL30iqgYmA1kuePI6y9dGB/z
         yTkfh+aAUYLKn/uknHnw52UraNSMuYI+lsua82NzHrMFtw2iuzlmQJ85NfcNfNWxCOVv
         2DSqcyu3QFq9LYu8sT4CZlcder2PduR5f0JmAjkbnNZ5R+rFh0OmJLtK0fpt9aVwSVWk
         wU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731375135; x=1731979935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOYYrAKsRLkotEPjA+hBse5PtLPm2vozdMcs0N4/zA4=;
        b=pQE0DlXqvjqDPt87MEfW/YebGPgHtX6HICkF4orAn70bUsbS9kDn4Eq/sBgtFxJ4jr
         45YuN6VmjjvPNoM7esmBCKr2TlmbJacm/VYewPoiVna3521rlJza4+8lS4Sn3okM43aN
         RTGj65tFs+mUqUJZenPMtfSVObzfIb64XJJZ46npJ6vbk9UHTw6hvElCVH6oz32ELN2l
         GaJJAG01Z9fGqNaHVGykzS6xbuZNd8CsslltlXUsP+3CuBGI2yISI5koHffGxNmuNKhH
         3XtoPMkgUynbuhHfoJQdAS3h/PNcdCjxG0Q3+o3owjxuqWlrHngxd4vmxfMTSqZMPV07
         SDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrs/1tGodob69eZTqR6WfRdz9eTzqqzZvJ/0erIDVfT88eQX6UMDT83DB/nCNRZUhnUhrxmSHuu/bV@lists.infradead.org
X-Gm-Message-State: AOJu0YybnCVQQUbFZV+OIEgBixfJcMmZU3mlYWmDKfp8R04nUUimyzeg
	lPjZv/3ylSRud0BE2wFMXun4cAHUqU/12kz4hZ0Ze44sUU/vSnnr
X-Google-Smtp-Source: AGHT+IFUwkZdPumBasVvTtECag2f1YXtLMhxIHiAzpbsfxbCn/aAobFfjpRlKsPysUvhvUitAG5Mww==
X-Received: by 2002:a05:600c:4f83:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-432b7517aa4mr116959285e9.21.1731375134452;
        Mon, 11 Nov 2024 17:32:14 -0800 (PST)
Received: from [192.168.42.75] ([85.255.234.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c1c81sm194974655e9.32.2024.11.11.17.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 17:32:14 -0800 (PST)
Message-ID: <642d46b9-0869-42a9-b7fb-c9b51cb23b8b@gmail.com>
Date: Tue, 12 Nov 2024 01:32:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] io_uring/rw: add support to send metadata along
 with read/write
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 anuj1072538@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
References: <20241030180112.4635-1-joshi.k@samsung.com>
 <CGME20241030181013epcas5p2762403c83e29c81ec34b2a7755154245@epcas5p2.samsung.com>
 <20241030180112.4635-7-joshi.k@samsung.com>
 <ZyKghoCwbOjAxXMz@kbusch-mbp.dhcp.thefacebook.com>
 <914cd186-8d15-4989-ad4e-f7e268cd3266@gmail.com>
 <ceb58d97-b2e3-4d36-898d-753ba69476be@samsung.com>
 <b11cc81d-08b7-437d-85b4-083b84389ff1@gmail.com>
 <6bca474e-361d-40a3-b28b-93f561dbdd85@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <6bca474e-361d-40a3-b28b-93f561dbdd85@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_173217_035028_A245F4DD 
X-CRM114-Status: GOOD (  24.20  )
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

On 11/10/24 18:36, Kanchan Joshi wrote:
> On 11/7/2024 10:53 PM, Pavel Begunkov wrote:
> 
>> Let's say we have 3 different attributes META_TYPE{1,2,3}.
>>
>> How are they placed in an SQE?
>>
>> meta1 = (void *)get_big_sqe(sqe);
>> meta2 = meta1 + sizeof(?); // sizeof(struct meta1_struct)
>> meta3 = meta2 + sizeof(struct meta2_struct);
> 
> Not necessary to do this kind of additions and think in terms of
> sequential ordering for the extra information placed into
> primary/secondary SQE.
> 
> Please see v8:
> https://lore.kernel.org/io-uring/20241106121842.5004-7-anuj20.g@samsung.com/
> 
> It exposes a distinct flag (sqe->ext_cap) for each attribute/cap, and
> userspace should place the corresponding information where kernel has
> mandated.
> 
> If a particular attribute (example write-hint) requires <20b of extra
> information, we should just place that in first SQE. PI requires more so
> we are placing that into second SQE.
> 
> When both PI and write-hint flags are specified by user they can get
> processed fine without actually having to care about above
> additions/ordering.

Ok, this option is to statically define a place in SQE for each
meta type. The problem is that we can't place everything into
an SQE, and the next big meta would need to be a user pointer,
at which point copy_from_user() is expensive again and we need
to invent something new. PI becomes a special case, most likely
handled in a special way, and either becomes one of few "optimised"
or forces for nothing its users into SQE128 (with all additional
costs) when it could've been aligned with other later meta types.

>> Structures are likely not fixed size (?). At least the PI looks large
>> enough to force everyone to be just aliased to it.
>>
>> And can the user pass first meta2 in the sqe and then meta1?
> 
> Yes. Just set the ext_cap flags without bothering about first/second.
> User can pass either or both, along with the corresponding info. Just
> don't have to assume specific placement into SQE.
> 
> 
>> meta2 = (void *)get_big_sqe(sqe);
>> meta1 = meta2 + sizeof(?); // sizeof(struct meta2_struct)
>>
>> If yes, how parsing should look like? Does the kernel need to read each
>> chunk's type and look up its size to iterate to the next one?
> 
> We don't need to iterate if we are not assuming any ordering.
> 
>> If no, what happens if we want to pass meta2 and meta3, do they start
>> from the big_sqe?
> 
> The one who adds the support for meta2/meta3 in kernel decides where to
> place them within first/second SQE or get them fetched via a pointer
> from userspace.
> 
>> How do we pass how many of such attributes is there for the request?
> 
> ext_cap allows to pass 16 cap/attribute flags. Maybe all can or can not
> be passed inline in SQE, but I have no real visibility about the space
> requirement of future users.

I like ext_cap, if not in the current form / API, then as a user
hint - quick map of what meta types are passed.

-- 
Pavel Begunkov


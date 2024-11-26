Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA0ED3B98B
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1sK9vv1q3OjkhDWkUYaudPgFH+wG3hp3SHQxCzra7k=; b=ZFdXgZ0hanWZ2YQRsNxOUGc5OC
	ea6P0wi887Wtz2bl117iwgMWJn9BIEwgJgOTgIFabX0zQAfvKC8Ybo0yIkV6u14LIvj/8xrAZDXnV
	FWcTSgR5Kpgb080cYCvuCw995WZpFHNakYHstnaiHryRdhGkyvIoP+NoNU+5CoLRR3leEoksGBk9d
	VM8J3JdzexXxkpGMbfT4pvQD59S9E0Vew0kAwruvSByIdgopkqEsmFnHgeyM8ZwdRkgRBbHKojh72
	NwSvxUKcp19AkT9Bxl6ecGctaTgdxfCXtcBy1Ie7zK+qNPC9Z8qBnOjcAB7yY5oMswVaXj3KP6eh+
	vTUWnQBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFvSA-0000000Ago8-3z5r;
	Tue, 26 Nov 2024 13:18:06 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFvEH-0000000Ae8d-1ZzZ
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 13:03:46 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so6509774a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 26 Nov 2024 05:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732626223; x=1733231023; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1sK9vv1q3OjkhDWkUYaudPgFH+wG3hp3SHQxCzra7k=;
        b=Fvruc99lIQDy/pwiiiv4T6eMYgDzg7w063aGxSeZH+Js5SCSThg69UXs03Q7oM1joc
         3MnmdXZpA+CoJw21t8ChwPGuP6WNdQyaM8AnC/+LFzvuWhndn6tRK2fg/8r7if9qJ6Kg
         JwxzL7KEsv27wuBTExoNfW7sePXC6R0/c6t4QYAu/uSzpDT37qsOIRPjU3vZlhuYZLkV
         rd85dXuApVVZbEfuXrj+dg4TIiAtVZ1wymqv5cYjismlbvRWdE5KUf03FoaO1M2icEem
         GbdDo1LBAOa3ieTWeDn0/tJXQrlymcRByYjV4A4A1BCNVJTtCRcbnh5m9oW9ZfffjhCL
         o14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732626223; x=1733231023;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1sK9vv1q3OjkhDWkUYaudPgFH+wG3hp3SHQxCzra7k=;
        b=M4zrVe28tOTVZmOeSVLpv7yy9O2o/A2whlYE6z84MMrcf4w2wc7BdqfWQxkV0Ar0X9
         ZSrZBnwxUjqbLGLb4xqOlpIE1ORyC97uv3Ip+uLTGKDak8RN71whuxpmc2rE4TD/biCF
         YFXYh0yCijXXMhjriODHGMvLEfzeyPu8tMvWXSFG6LOOjRNsiEkh+k1OXB1k5tn/qFgp
         GR6i0p0oNK9IVkXI0jnxh3FqE2mQ9ss8IYj8eNBadzbCPt53KGFyy8aWkAJa58jl8cwD
         HQiEcQO85FAt9fA5ydl2h5gNXBslKwunE6qTb66mDBMuFsOu3xE9CExQGOsGreR/vdwl
         wcww==
X-Forwarded-Encrypted: i=1; AJvYcCW4rQ7umc9WNB8vGp5tAIL8fTMmv4qUznAu8L3EAeADOxfZYqyQqoj38myt8eL4upIQMeuaybErfhMk@lists.infradead.org
X-Gm-Message-State: AOJu0YzSj8xgscu6jZ7N657r79fQvYEhmTTuSI3PlUHbDypEWNIueeE6
	CNDAH5N9SiGovyFkCu/eSaX5KUE0u960omFvUSLBIo6sA4MTTbP9
X-Gm-Gg: ASbGncs4FH/FNy1f8QHThsVpvYy2uKPH2Ors8onFe8jY+ENDxB0VKYpsNKt37Aw/dDz
	o+NMKMChNoC5k31HxY33HOCqg9yiQ1uiFJVIYAv5h/ZkWp3K8HFrp1kJl8ZdOjJ3/71uQ8cI6da
	NVxnmpxK0DU5dmQyZdTmdatD58oAwmFwC9bIacLtZbqu5b98ArfOktJofar/GThnq6SSGGeOVAr
	tmLdA5ev3mMTIEhx89xoK8wPQsy3uh8j+vkmSUEr9h2n7Mqvy9oE5d758JcZg==
X-Google-Smtp-Source: AGHT+IGUJJ67zkkw70cU7BTJtW/UZE3uVK6vKazeu4jCOhtR1atDsPsUa64nDbaBqFhJig6PgL/VRA==
X-Received: by 2002:a17:906:9ca:b0:aa5:3663:64ba with SMTP id a640c23a62f3a-aa536636946mr882554866b.43.1732626216465;
        Tue, 26 Nov 2024 05:03:36 -0800 (PST)
Received: from [192.168.42.208] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2efbf1sm591067766b.44.2024.11.26.05.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 05:03:36 -0800 (PST)
Message-ID: <ad230264-62c1-4e52-b412-d951be514593@gmail.com>
Date: Tue, 26 Nov 2024 13:04:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] io_uring: introduce attributes for read/write
 and PI support
From: Pavel Begunkov <asml.silence@gmail.com>
To: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, martin.petersen@oracle.com, anuj1072538@gmail.com,
 brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241125070633.8042-1-anuj20.g@samsung.com>
 <CGME20241125071502epcas5p46c373574219a958b565f20732797893f@epcas5p4.samsung.com>
 <20241125070633.8042-7-anuj20.g@samsung.com>
 <2cbbe4eb-6969-499e-87b5-02d19f53258f@gmail.com>
Content-Language: en-US
In-Reply-To: <2cbbe4eb-6969-499e-87b5-02d19f53258f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_050345_413055_70AD0C24 
X-CRM114-Status: GOOD (  11.23  )
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

On 11/26/24 13:01, Pavel Begunkov wrote:
> On 11/25/24 07:06, Anuj Gupta wrote:
> ...
>> +/* sqe->attr_type_mask flags */
>> +#define ATTR_FLAG_PI    (1U << ATTR_TYPE_PI)
>> +/* PI attribute information */
>> +struct io_uring_attr_pi {
>> +        __u16    flags;
>> +        __u16    app_tag;
>> +        __u32    len;
>> +        __u64    addr;
>> +        __u64    seed;
>> +        __u64    rsvd;
>> +};
>> +
>> +/* attribute information along with type */
>> +struct io_uring_attr {
>> +    enum io_uring_attr_type    attr_type;
> 
> Hmm, I think there will be implicit padding, we need to deal
> with it.

And it's better to be explicitly sized, e.g.
s/enum io_uring_attr_type/__u16/

>> +    /* type specific struct here */
>> +    struct io_uring_attr_pi    pi;
>> +};
> 
> This also looks PI specific but with a generic name. Or are
> attribute structures are supposed to be unionised?
> 

-- 
Pavel Begunkov


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1C0D6ACC2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 11:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CehglWY5cUyKQpTdTFxSNmTAz6hCZtKrvb/Ae4vWfPc=; b=nV61BIP19KRnQj0VrJsQ1H4s1N
	h008dORoBdBAl0o+lE5G7tEd23aKqwqoFgzyZudzRl4WYv/rBIeLgYfu2JSgqW1Ot3NH6aEE9WX0G
	nURSedGAEZwZRdn5AcAsTVbknMR5lC3m3rVD9RwGJSGYOuHCRLZ5awvzNPslQaiklcEDIuIFXWHe7
	j3kThaCYGwhCyVoPYxx4GswSy+cDrMdT1GgPA0pr5xi3+JtU1nvirn0qBp2rpqTNvgcUgAP39P0zm
	3AGDHNGiBUJArTh2B6e8v90uwwDulsNSzGO/Tv3YD309F/LkAZH+jCtLqIjAcqwB+RREpo5DBUg5b
	G/MEc/vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGGC7-0000000D0mZ-2w8E;
	Wed, 27 Nov 2024 11:26:55 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGG8d-0000000D06t-0et3
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 11:23:20 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-aa545dc7105so567996366b.3
        for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 03:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732706597; x=1733311397; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CehglWY5cUyKQpTdTFxSNmTAz6hCZtKrvb/Ae4vWfPc=;
        b=FD6l8x/zeBOoyoDy5odF7f8A9itnV8mOZjAg3NRFXDRztD14pIfHfmqNnm0qfe6xCf
         imA7S9pAkc8Ax8Ec3gA5FIaQ+PggY1Daylocg/nau+waFu8M2fyy+agyRQUheMx7usxd
         TeVIHRGRhmgEjQmi2MGjtty7zfDrbWXNyIIRHq+xwuK2AKl2mljiQcKNVwlBf1qFQTQH
         ApARStA7wpp+WHidli9umi4iR6NqDjbgIeMUuaXGp9x1snNom7+xaiQ984Zw2dYiPC1P
         ekQEXEcQIKEK8x0D2Dv7YufIfzifLqz8hSpKkcA1DXU968Wt8DDl+000Jk754DIUbL/T
         D94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732706597; x=1733311397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CehglWY5cUyKQpTdTFxSNmTAz6hCZtKrvb/Ae4vWfPc=;
        b=Gu5dfgcAGnDGPNDbmimkZ1ao3JfLhUNHs2mV0u9VjpkLo8ukoFnAFgQa+H51SWPWG1
         ovGPa3O1S9VEdOEVLoYxy028OnzBekluEp/6Zzf2CPrpE9fZtHn0DNIvG4vERrbi0pzd
         v50RuHVd2dErvXY6jQO6IGL9T6eA5VV3kPmFNn7PEg3FFMHvPfKWgz5+W2EXHkFeNt60
         LzhDEkdNNbjzQ42WbiJkfJa91b+mfaiHoi/aD8bOS1RR5WMarEXFCMwOasdhLjaQS2LT
         2v8Kx2Z+82ZWi90XZVmf/NlpZKhvbwT7P9X8Z2GeH/xMrkYaaiOGUiGImoPpN76tgmu1
         tJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCVNTqVKhmSWNYHvXntLqQIz+aiD6/3+Gt+hkUrnBGRATQIYxNqk2EcCNhCx/xDiMsGYl3oWFWqAnw/7@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0np34icwUhUwT3kTNufohWYIj1n8FlJL4CDuZwyixtfJ1jUsb
	EubLyQQR0xb/LHhGo2dzko1ks9diAqLZGz15M4cAKzf8SwW9yIaX
X-Gm-Gg: ASbGncsntiY0x9WVW+lqzeLFSKRxZ/8NuT4ePFnAxBU/imkjXAjwCsYRpKWSGjdxcwR
	7v3I9hsT7hMOMm4YScgBFHkfRyYB3XZvhsZx2s0/GxLe4NE57Oo3HFh06zCZrtlYCSTFFaE/dYE
	c+VihtbGE5EJvfdII3Ol5IcTQn287o0EgQmZWektVoeQ/2RC9PbXslyrt6RV0rwwi2vgJ5jqa0+
	o8V4IkQbortPsi8RffVD0ze+vGrT64BGyMj6tjJIFIfPPforKArpH08heMBDQ==
X-Google-Smtp-Source: AGHT+IFsufWWnsFArYdPuvs9Ad81sVtZ17075H7eNLYpimFeYT75Kvd58Sonb/NBCuJN36c+6qQFJg==
X-Received: by 2002:a17:906:1da9:b0:aa5:274b:60e9 with SMTP id a640c23a62f3a-aa580f4df12mr158891366b.33.1732706597304;
        Wed, 27 Nov 2024 03:23:17 -0800 (PST)
Received: from [192.168.42.127] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5372002aasm536402466b.66.2024.11.27.03.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 03:23:16 -0800 (PST)
Message-ID: <6c870f8d-6293-4d4b-be2b-f0e221cd103f@gmail.com>
Date: Wed, 27 Nov 2024 11:24:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] io_uring: introduce attributes for read/write
 and PI support
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 martin.petersen@oracle.com, anuj1072538@gmail.com, brauner@kernel.org,
 jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241125070633.8042-1-anuj20.g@samsung.com>
 <CGME20241125071502epcas5p46c373574219a958b565f20732797893f@epcas5p4.samsung.com>
 <20241125070633.8042-7-anuj20.g@samsung.com>
 <2cbbe4eb-6969-499e-87b5-02d19f53258f@gmail.com>
 <20241126135423.GB22537@green245>
 <a9d500a4-2609-4dd6-a687-713ae1472a88@gmail.com>
 <20241127094644.GC22537@green245>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241127094644.GC22537@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_032319_201792_B02099DE 
X-CRM114-Status: GOOD (  16.12  )
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

On 11/27/24 09:46, Anuj Gupta wrote:
> On Tue, Nov 26, 2024 at 03:45:09PM +0000, Pavel Begunkov wrote:
>> On 11/26/24 13:54, Anuj Gupta wrote:
>>> On Tue, Nov 26, 2024 at 01:01:03PM +0000, Pavel Begunkov wrote:
>>>> On 11/25/24 07:06, Anuj Gupta wrote:
>>
>> Hmm, I have doubts it's going to work well because the union
>> members have different sizes. Adding a new type could grow
>> struct io_uring_attr, which is already bad for uapi. And it
>> can't be stacked:
>>
> 
> How about something like this [1]. I have removed the io_uring_attr
> structure, and with the mask scheme the user would pass attributes in
> order of their types. Do you still see some cracks?

Looks good to me

> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
...
> +static int io_prep_rw_pi(struct io_kiocb *req, struct io_rw *rw, int ddir,
> +			 u64 attr_ptr, u64 attr_type_mask)
> +{
> +	struct io_uring_attr_pi pi_attr;
> +	struct io_async_rw *io;
> +	int ret;
> +
> +	if (copy_from_user(&pi_attr, u64_to_user_ptr(attr_ptr),
> +	    sizeof(pi_attr)))
> +		return -EFAULT;
> +
> +	if (pi_attr.rsvd)
> +		return -EINVAL;
> +
> +	io = req->async_data;
> +	io->meta.flags = pi_attr.flags;
> +	io->meta.app_tag = pi_attr.app_tag;
> +	io->meta.seed = READ_ONCE(pi_attr.seed);

Seems an unnecessary READ_ONCE slipped here

> +	ret = import_ubuf(ddir, u64_to_user_ptr(pi_attr.addr),
> +			  pi_attr.len, &io->meta.iter);
> +	if (unlikely(ret < 0))
> +		return ret;
> +	rw->kiocb.ki_flags |= IOCB_HAS_METADATA;
> +	io_meta_save_state(io);
> +	return ret;
> +}
...

-- 
Pavel Begunkov


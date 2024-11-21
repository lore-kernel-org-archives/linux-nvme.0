Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685FCD78782
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yq70YJzrFfkaT6vO9+6QOQ5rfwZ7sR/Fpz34vhs1TzQ=; b=Ucrc0/qb4P7nMMbJrDruSSrR8T
	qoyWy/wQigdNkNzYPqqNwXI+0evoUNbZtBUTSk9csHopwAxStcfCa6oqLDHSxxffBMlanCIL2SHok
	x3ijqDZakd0Lb7DFoXo5bU7cqUGrCjixt0zvkT7GGUiLpuhb+kw3W/yEu6JJRrOQanKZAY5z+cqfT
	45GdW/pHzrXUhCIn8Gm/htN2xI7QN4aS4ky+RSUmVic+2Xnzpk7NHeG5XKxfQ9wTYnUMh8GRYcLSK
	t9dqdU6rSdaCqlafvspV3Ho+P1QsAW/1+RdhbWC9ENnV3xx/iqZGpLPvNhZhkaFIoFEvlmnFzzR5p
	uWXf5Aqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE9MQ-00000000Mcg-2ylD;
	Thu, 21 Nov 2024 15:44:50 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE9MO-00000000Mbv-3c88
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 15:44:49 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so19975311fa.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 07:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203887; x=1732808687; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yq70YJzrFfkaT6vO9+6QOQ5rfwZ7sR/Fpz34vhs1TzQ=;
        b=VLr2OSk2SA9R5HlzlfSPMNiMxdhIZpMGrQbuSonYqlxxkuNezqqhLppCunSYx/AWZN
         9jW323tj3vEXiJ0w+VZttBu9BtThdwSDLY/zZ9rFGU4tjv8tlhtKqx8ROV/Cb9TkDCBC
         WY/7ngyegOLq2MYkUvBCbhGsTFvQA28vCFI9gurYdd3CqmNKRdOemrZQwzShs2aq1cOT
         ICNA72NzQy2MtYmjCaHme62F1dPUVPOmv4pUVn3MVhcFyKz6NTFdcSBgATMHPhyftTs5
         W7pssDOrhoLdfalnP9nq8683CHjnblly6Gnr2aVD2O6Ie/tboAwtI/IST0UlCEpbf98q
         f9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203887; x=1732808687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq70YJzrFfkaT6vO9+6QOQ5rfwZ7sR/Fpz34vhs1TzQ=;
        b=pse3Kqk6HHSHdMnDY40uo4L1U6cd2n7X/G/1WzSBFW2OW+SdyQIx2DXf4a/uS0nOkN
         YTmiMIqTyRgP+P5rKJjyY+oK9Ud/L47+S4Mql8Oy+qwBRHD4lUZS+EP2zEFWA2eHfYAH
         GzT/odleck1zVbrP4wl01jIqSmGAsS6X+KI3dWT0gckMejVw/usRt8Om2p7wNl9kOFtT
         DdlBqiobzuk5RaVUI35vXqlQ1symyo5sG7j4MF+cv4qMKP1Bsa0INXRfZzIaOTTLRodT
         9NZN1SlEoaW9kpVe0TYdcJmV9kxcM86N0tqUt/TqncNhpgtRR4o4krWm0fRDnC1bZeGx
         Qbbw==
X-Forwarded-Encrypted: i=1; AJvYcCW+XMIvJmfsc6X7dsxZLFFdzEIk6l/cKAWWKXTjIdySu/jZbeqR4sfhI+rR+aFuoOcFZ1uPw2aiXa9K@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5SOEhK7Bl+GI2V7ltGix3f4D9jnYkf8N821EDl9c7gTvLx/F/
	vSf13dnuCFVxwd3pM5v9jDopeCIEI8Y1MsVUu4Ffa/FObGQensSsaYnVtw==
X-Gm-Gg: ASbGncurPylVlVjvurjFcIEUI4vVrVUU+mK/mMtNXRwYq9EFctc2mzsjb0AuhEG5/nB
	8FG45VTL+RMosC3MVEYIW/4u7/9VeTHbBchxG4jhTsdUNcjnK5OTqcxRzJWunLw+cHgHHQxmuWt
	4YNWDOfGI5HtnvoGGByl8XdawdsGVVIwSpwbrXXHGXStJTr+A/6Ca8KhoVvPVRAaew2c3eELX9r
	zISPD7Stl+duXEcZ66BGNdYw0f5xE/PoHXIUtYpE4fNQTc26YRb+M/ADyNhnQ==
X-Google-Smtp-Source: AGHT+IF++NRQF74gXAH6xM1W4Qh3AQIH8KSN5zEQe3RTf9TGDltr4dR/aWa+g/x4zzyWxju6+0KAMw==
X-Received: by 2002:a05:6512:1195:b0:535:6a34:b8c3 with SMTP id 2adb3069b0e04-53dc13230b4mr6167738e87.5.1732203886812;
        Thu, 21 Nov 2024 07:44:46 -0800 (PST)
Received: from [192.168.42.120] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f43801f5sm93964866b.190.2024.11.21.07.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 07:44:46 -0800 (PST)
Message-ID: <506ca9ff-40c2-49eb-bcc3-e1735a4f4cd9@gmail.com>
Date: Thu, 21 Nov 2024 15:45:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
 martin.petersen@oracle.com, anuj1072538@gmail.com, brauner@kernel.org,
 jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com>
 <c622ee8c-82f0-44d4-99da-91357af7ecac@gmail.com>
 <b61e1bfb-a410-4f5f-949d-a56f2d5f7791@gmail.com>
 <20241118125029.GB27505@lst.de>
 <2a98aa33-121b-46ed-b4ae-e4049179819a@gmail.com>
 <20241121085935.GA3851@green245>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241121085935.GA3851@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_074448_902048_1C4081CD 
X-CRM114-Status: GOOD (  20.29  )
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

On 11/21/24 08:59, Anuj Gupta wrote:
> On Mon, Nov 18, 2024 at 04:59:22PM +0000, Pavel Begunkov wrote:
>> On 11/18/24 12:50, Christoph Hellwig wrote:
>>> On Sat, Nov 16, 2024 at 12:32:25AM +0000, Pavel Begunkov wrote:
...
>> Do we have technical arguments against the direction in the last
>> suggestion? It's extendible and _very_ simple. The entire (generic)
>> handling for the bitmask approach for this set would be sth like:
>>
>> struct sqe {
>> 	u64 attr_type_mask;
>> 	u64 attr_ptr;
>> };
>> if (sqe->attr_type_mask) {
>> 	if (sqe->attr_type_mask != TYPE_PI)
>> 		return -EINVAL;
>>
>> 	struct uapi_pi_structure pi;
>> 	copy_from_user(&pi, sqe->attr_ptr, sizeof(pi));
>> 	hanlde_pi(&pi);
>> }
>>
>> And the user side:
>>
>> struct uapi_pi_structure pi = { ... };
>> sqe->attr_ptr = &pi;
>> sqe->attr_type_mask = TYPE_PI;
>>
> 
> How about using this, but also have the ability to keep PI inline.
> Attributes added down the line can take one of these options:
> 1. If available space in SQE/SQE128 is sufficient for keeping attribute
> fields, one can choose to keep them inline and introduce a TYPE_XYZ_INLINE
> attribute flag.
> 2. If the available space is not sufficient, pass the attribute information
> as pointer and introduce a TYPE_XYZ attribute flag.
> 3. One can choose to support a attribute via both pointer and inline scheme.
> The pointer scheme can help with scenarios where user wants to avoid SQE128
> for whatever reasons (e.g. mixed workload).

Right, the idea would work. It'd need to be not type specific but
rather a separate flag covering all attributes of a request, though.
IOW, either all of them are in user memory or all optimised. We probably
don't have a good place for a flag, but then you can just chip away a
bit from attr_type_mask as you're doing for INLINE.

enum {
	TYPE_PI = 1,
	...
	TYPE_FLAG_INLINE = 1 << 63,
};

// sqe->attr_type_mask = TYPE_PI | TYPE_FLAG_INLINE;

Another question is whether it's better to use SQE or another mapping
like reg-wait thing does. My suggestion is, send it without the INLINE
optimisation targeting 6.14 (I assume block bits are sorted?). We'll
figure that optimisation separately and target the same release, there
is plenty of time for that.

-- 
Pavel Begunkov


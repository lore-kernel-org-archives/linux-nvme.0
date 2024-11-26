Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888A8D3B9A7
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yVDOYNO+iQ6ZhvMztIaukFD/X8oZpaR2llnamKczTuE=; b=VKOV0oW1nIVzVseZCic+kMSyRW
	OxqG/7Oom1Ag9mcBWAaTKDs0pdT1fjdi5XBEtzkfPAA05EcfG1lkvJ4K9uw0vQ+b1WXGLyCMLAV/R
	rEYqA5atNFbwJa4l4Vja0nmmYQoDl9VBm2xCk9292K8SjCijl3WId9TI3Tb+8cYDbUYFdsbn4T5rS
	GbvB3BHALUjiC4ND6Bb3R0BligV7HhwjfWCYLVhZTX2Mgyl0Bb8oeFfdGA5V58DOHdH83GAo4etXu
	isrc8WrHE/bRJKFs4xXJLMCEpGPD2qqW50F+GDPd21Rg9f6tVNo0wVekkwtY+ncrV5iYy7+l1HQjc
	myf7wIXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFxjn-0000000B2oT-37Bz;
	Tue, 26 Nov 2024 15:44:27 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFxjl-0000000B2ng-0NWh
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 15:44:26 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so2930776e87.3
        for <linux-nvme@lists.infradead.org>; Tue, 26 Nov 2024 07:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732635863; x=1733240663; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVDOYNO+iQ6ZhvMztIaukFD/X8oZpaR2llnamKczTuE=;
        b=gVNw20rqCb/9vJ6DH+mE2pvNTmQ2xKfw0wTARZ901pM1gAYrRQSWHBflhHHcgSlOXF
         8zGsPp1OIoM2rzRgSdo86YpRCi3KAF6E1uLfqJLYdFxUVneNxAXUQPIdjXQucZ8L3JwR
         YNkkYi/FVV+tvHZD/clLYUdyyr0H7hzjFk/IiUCL6i944C+juHhWPXH9eZeCUg8Y/DQ3
         lHX7R8liKprPk8On7DajGIByKXu8CuayauSJxkiuF93OOX0m0v/eVw2M66yvqOnoJxdL
         pCJ0+19N7ChwcTnAMXbq/HPr90EISR0iM7n9aGtW+c3B7HsbMhXg4ZZy8divFvG3GhJJ
         qwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732635863; x=1733240663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVDOYNO+iQ6ZhvMztIaukFD/X8oZpaR2llnamKczTuE=;
        b=HCQlyoQ8Q1h7nPh24RbYnTBpmelG/r6kD/4vKkatFCF3+pIxGmOG4xYuSsQWtErGNI
         BN042E8DV2bRf1NXEmruRaGyJMAiKbzFKAbspentlr702oqW/voX+nHOwMx4XQFthfru
         pXw1sv6rZxTKwZzxTsM6jSGYHuOftq02G9CYRBzSK97Wc7aPt8lo8cbtcPK49XyNHRrD
         ZZ025XEBDoi39jlFiQBKYoq0XFBW4eNPxzT1/58NyDDe+blvjEN5zWbf343x9AiMLfkg
         RorcSgflOfp4BwMgENrFgCJ0xSs7VKQkBATAcIcma0pk6eLzrmUXrEdqtk4JS/JLRuEd
         xTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfFr5lpk0ip3bPD+sS/3XOsLb+R+cC0w1N2MraP9Nb0VDbrzzoY32GI0wfp61i5ohffGbBiZ9hh0Cc@lists.infradead.org
X-Gm-Message-State: AOJu0Yzh38VKvnu+9JU+827f236OUovlvFF7VwUxQPY6vnuG53ljlsiR
	bpY1hZmnPM7i7rtJ1xy808NA0DnPjaQNH7/PAzJI3ZqL06T28Wy1y5Z/Aw==
X-Gm-Gg: ASbGncvWj6W+jWgEyg2uP5BdDzEOjLaHsR+hxKAEBMomeuxC18r/PMGBFoQN51AWEMG
	KLt9o77pBf9EpoCHc1saLIPEsX3KSv0uT5ndb5oCTFH4KuN0GLyVXKADm2Uvbjbe/dgtcmwAa1r
	oruLC+KWbc8i0R5tF6RQZi1qRMYm/MdaXXXQA3p2AJ5ABgHntv1y/HBUUwlU8yvvMSphdX3M5If
	9uFKxTw6cUTXPHL0HZRLhy0VLj7rNbJgvr1dsP8ODw6GSO4R22RrTlimWtJ
X-Google-Smtp-Source: AGHT+IGWo3MB+7Gb6yHS+bWnq0pFj0SiM5AqaPTVwcxWz0pNUpAyD9lUojQtu9SrCdednPlE58PNpA==
X-Received: by 2002:a05:6512:400c:b0:53d:eefc:2b48 with SMTP id 2adb3069b0e04-53deefc2f0amr555039e87.33.1732635862546;
        Tue, 26 Nov 2024 07:44:22 -0800 (PST)
Received: from [192.168.42.58] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28fe55sm602396866b.4.2024.11.26.07.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 07:44:22 -0800 (PST)
Message-ID: <a9d500a4-2609-4dd6-a687-713ae1472a88@gmail.com>
Date: Tue, 26 Nov 2024 15:45:09 +0000
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241126135423.GB22537@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_074425_129342_C381B640 
X-CRM114-Status: GOOD (  18.68  )
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

On 11/26/24 13:54, Anuj Gupta wrote:
> On Tue, Nov 26, 2024 at 01:01:03PM +0000, Pavel Begunkov wrote:
>> On 11/25/24 07:06, Anuj Gupta wrote:
>> ...
>>> +	/* type specific struct here */
>>> +	struct io_uring_attr_pi	pi;
>>> +};
>>
>> This also looks PI specific but with a generic name. Or are
>> attribute structures are supposed to be unionised?
> 
> Yes, attribute structures would be unionised here. This is done so that
> "attr_type" always remains at the top. When there are multiple attributes
> this structure would look something like this:
> 
> /* attribute information along with type */
> struct io_uring_attr {
> 	enum io_uring_attr_type attr_type;
> 	/* type specific struct here */
> 	union {
> 		struct io_uring_attr_pi	pi;
> 		struct io_uring_attr_x	x;
> 		struct io_uring_attr_y	y;
> 	};
> };
> 
> And then on the application side for sending attribute x, one would do:
> 
> io_uring_attr attr;
> attr.type = TYPE_X;
> prepare_attr(&attr.x);

Hmm, I have doubts it's going to work well because the union
members have different sizes. Adding a new type could grow
struct io_uring_attr, which is already bad for uapi. And it
can't be stacked:

io_uring_attr attrs[2] = {..., ...}
sqe->attr_ptr = &attrs;
...

This example would be incorrect. Even if it's just one attribute
the user would be wasting space on stack. The only use for it I
see is having ephemeral pointers during parsing, ala

void parse(voud *attributes, offset) {
	struct io_uring_attr *attr = attributes + offset;
	
	if (attr->type == PI) {
		process_pi(&attr->pi);
		// or potentially fill_pi() in userspace
	}
}

But I don't think it's worth it. I'd say, if you're leaving
the structure, let's rename it to struct io_uring_attr_type_pi
or something similar. We can always add a new one later, it
doesn't change the ABI.

-- 
Pavel Begunkov


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A662D3B98B
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 13:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TYeQkAYIxhkFR/C0PdfSBmynLd1wfKbnNjKfq6tkF10=; b=sBIcKgq0qlKiwCQhIWkpslZgpO
	Gi/Eq+0ZXt6qSUBEowFi8e3LcjDTSXnjdkNzqJ3r9rzccgtVbKY/pVcBrsiX/tauFv/n+IDV/MQvO
	cb5eKvEQGS0QhY245RT9UzAlLvj3t7vaNVeviYcPSfuIElM2Onoy323jISrp/2ee3O968bwHM7Lyn
	d0zRA7bKjxbJsbCL3wwoxUK+tEK7WFIWIHTQCENRcPqroF+EmiaQP/GFU87/1p7F5v4WI1/cpym/W
	GNFGrgsSHXR/u+9feEf3P3Hnz2PV+TxLABN2bbnU8GUh61kgU85zttFVjrpXfKO8tm3s5BgUo3Brb
	we0nV+zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFvE6-0000000Ae5y-0EVc;
	Tue, 26 Nov 2024 13:03:34 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFv44-0000000Ac7F-1fyq
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 12:53:13 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5cfddc94c83so7027785a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 26 Nov 2024 04:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732625591; x=1733230391; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYeQkAYIxhkFR/C0PdfSBmynLd1wfKbnNjKfq6tkF10=;
        b=gO7bMmuJIvSYi69jUJj9N1bfzhHjBkb9DMzNNM3gohl9opLhxPqF9ytBIxZBO5J5rs
         I4OqQfd2eRXg2RdbfhERK+MEAVDoPg4YbVclKNXlbneQuVP+IeH3Mwx4xIrX7AtjLswF
         tjKd7CijGxkpM9SX5bs8jFu8y03YMhPk/iC3iMXxK/W2p+CXednlvweMZZiJP37umh8F
         ZF1lp7TQ/QQkVXcKgLgdgyHYf/FPTR6CGOvB1/untxtERFWVFXUr/LxlXxTFlZlRHANJ
         ZUqbVsE8RPCHQqy8g+BvRsHCxhFjiSbi7/ppuypmZaMcYv5NBjLKYcGnn+qXQ7T/ai6D
         dukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732625591; x=1733230391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYeQkAYIxhkFR/C0PdfSBmynLd1wfKbnNjKfq6tkF10=;
        b=THECCVNdfQNQVOgnAT1qK/GTkH12fG0KMpk7K2kMjqgtNhyggkEcc74sdgBVMcozkx
         8Q5Nyg0geJpvmNjqP/YJscbZZ++IUh/IPNZZOecaBg4YGOyVpGGMOtULZB6xe4nZywzB
         CcwEbWi5/FbVnjIYJnnl2i739mzpNaXbihcQmlmW5fK+KelmyTav7KFedsk5TX5V//zM
         4CeW7VYWav8BoFZACXEi06oYDAzVYqz+kk7LXp48sGhPQ3CRGn10oG36a6DnoiYi5yNj
         elrYQt8PLyC/sbq1jQbAibVjEEIgYqunsWe8Ow/pks1a69z6tOfi1myH305krTlBNGot
         JfkA==
X-Forwarded-Encrypted: i=1; AJvYcCWaq78bcWPqO1sffDCVnqfPXAQBIrJC9gLfSG2Vd3PsN/pw7ubzISkh9nofCDxDrYDjhnhuXQ+TWaEH@lists.infradead.org
X-Gm-Message-State: AOJu0YzOUH4JTIb6fxoy6BRzZKnTZ/+FSOhsW/+DgKiqprvsGVAef0A0
	8OHtTh6/8AbKnRI64WCkvqZlPUBENNPY84T0c9q4tNudWeFmdLaRT+Qe0g==
X-Gm-Gg: ASbGncvnuhrfwIcWa8IoCviDL68y9SrRtEf7qLE3IWO0U2qfpJUO9xuXCiI/YpKZnkz
	dfI14kpW19xgjmMbBE0ROE1qsuuIp7VB7znqNRjW3t7ZQ5zY/r6wZQ7TjwPMQhHHbqk6UQ86u7r
	hJyqqEaHOGfHOg9IyhqiDRXhwiq1xesV6Eg9WFuRG3wEAugGGFnIzsNZVpZdUS2Jng09kRhXNGo
	poqSvjdht//F0EZU20d9SAjZV5x6XklnigdOJ4586X5uKinbdEVlfkf1OFwGA==
X-Google-Smtp-Source: AGHT+IGkolV4gihApPpCMJ1KiZPbLGP6lKKAGid5kl9EQsMAfw6bzTw1axV/cNE6wN4oES6cLCpT/A==
X-Received: by 2002:a17:907:7854:b0:a9a:6bc2:c0a3 with SMTP id a640c23a62f3a-aa50990b2c0mr1380344766b.7.1732625590540;
        Tue, 26 Nov 2024 04:53:10 -0800 (PST)
Received: from [192.168.42.208] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcf9sm588338766b.118.2024.11.26.04.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 04:53:10 -0800 (PST)
Message-ID: <37ba07f6-27a5-45bc-86c4-df9c63908ef9@gmail.com>
Date: Tue, 26 Nov 2024 12:53:57 +0000
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
 <a28b46a0-9eb5-45db-80ec-93fdc0eec35e@gmail.com>
 <20241126104050.GA22537@green245>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241126104050.GA22537@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_045312_466867_ED062FFA 
X-CRM114-Status: GOOD (  22.16  )
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

On 11/26/24 10:40, Anuj Gupta wrote:
> On Mon, Nov 25, 2024 at 02:58:19PM +0000, Pavel Begunkov wrote:
>> On 11/25/24 07:06, Anuj Gupta wrote:
>>
>> ATTR_TYPE sounds too generic, too easy to get a symbol collision
>> including with user space code.
>>
>> Some options: IORING_ATTR_TYPE_PI, IORING_RW_ATTR_TYPE_PI.
>> If it's not supposed to be io_uring specific can be
>> IO_RW_ATTR_TYPE_PI
>>
> 
> Sure, will change to a different name in the next iteration.
> 
>>> +
>>> +/* attribute information along with type */
>>> +struct io_uring_attr {
>>> +	enum io_uring_attr_type	attr_type;
>>
>> I'm not against it, but adding a type field to each attribute is not
>> strictly needed, you can already derive where each attr placed purely
>> from the mask. Are there some upsides? But again I'm not against it.
>>
> 
> The mask indicates what all attributes have been passed. But while
> processing we would need to know where exactly the attributes have been
> placed, as attributes are of different sizes (each attribute is of
> fixed size though) and they could be placed in any order. Processing when
> multiple attributes are passed would look something like this:
> 
> attr_ptr = READ_ONCE(sqe->attr_ptr);
> attr_mask = READ_ONCE(sqe->attr_type_mask);
> size = total_size_of_attributes_passed_from_attr_mask;
> 
> copy_from_user(attr_buf, attr_ptr, size);
> 
> while (size > 0) {
> 	if (sizeof(io_uring_attr_type) > size)
> 		break;
> 
> 	attr_type = get_type(attr_buf);
> 	attr_size = get_size(attr_type);
> 
> 	process_attr(attr_type, attr_buf);
> 	attr_buf += attr_size;
> 	size -= attr_size;
> }
> 
> We cannot derive where exactly the attribute information is placed
> purely from the mask, so we need the type field. Do you see it
> differently?

In the mask version I outlined attributes go in the array in order
of their types, max 1 attribute of each type, in which case the
mask fully describes the placement.

static attr_param_sizes[] = {[TYPE_PI] = sizeof(pi), ...};
mask = READ_ONCE(sqe->mask);
off = 0;

for (type = 0; type < NR_TYPE; type++) { // or find_next_bit trick
	if (!(mask & BIT(i)))
		continue;
	process(type=i, pointer= base + attr_param_sizes[i]);
	off += attr_param_sizes[i];
}


Maybe it's a good idea to have a type field for double checking
though, and with it we don't have to commit to one version or
another yet.

-- 
Pavel Begunkov


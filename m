Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098FCD609CF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ZlrO5h50BcTQskeYOFGG+Op70eMgkFj46C8sSDAd2w=; b=aKyImpwTkKxH6v1LWfN0tgxYCz
	2d8Ui/gmqtP3F7yebZI8oSioBBjRBJj/vt3wvG3QnSWcwWi86p3c1wiYqk37VNDwCjA6o8Aauia9l
	rVrupT5xGOD8u1gxEOM9UhX1IfAl5zsmpqq0lobT0a0yqvuVGujflIcgMd9c6Ualo3VmaSe37ni0L
	vkxB1MNBKrO0uAtyaJOb2YyBRyp2jrsLplGTNmpoA8EOY/jzodaRybnM3Q7OQNdYX3eArOhOG8QnS
	VE7fyVNdDLw8zFNNBBqm6jh/9ypxgdjHGFPjTWOy++OkXF90xu4ruPUggu2YsufEZe97MEJu0LpSN
	MK5keaKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGFTJ-0000000Csss-3jLq;
	Wed, 27 Nov 2024 10:40:37 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGFNu-0000000Crnq-0hFj
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 10:35:03 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-382423f4082so4800346f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 02:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732703700; x=1733308500; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZlrO5h50BcTQskeYOFGG+Op70eMgkFj46C8sSDAd2w=;
        b=Mcxq30sN5d/1v4SKZQ/oXEtXY62dtrfL1ACwq7VjRZo8gBZj0dORvQeqcHrGcTeVng
         m3e+WB5/0OtQmIDl8sVHtIQ6okyMox3EwlN0771vGNhTKD457Pn1lCf7K9LiyG26hgNG
         N5or0Z+/rVl4TAVXw+QP2xaUbmfDOOAmQWrmO1ZNXPl0Qa2HCRkxzYcj53nPafwaSY/s
         78Rewp2JeFJJ/dG1BtdVtpJuI2p7hjQndqL/PtsB71LrEiTqJ/R8h1xmTIPraYrUBFmc
         uVAL2R+Y5gzmj2Xc11TaZNOlbtee0HnothjziQ2eYuTE6yal1/sbithu2Dep9GoOu6Rz
         x01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732703700; x=1733308500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZlrO5h50BcTQskeYOFGG+Op70eMgkFj46C8sSDAd2w=;
        b=t0itezpUCXzopCxq/S/fyzof/TiGBwKr/V3JHDHzoJ2bfRmPi37sHsfMyAFvgEh28P
         Zwzdt/5n9XlQu+N57Gl/uSJH4qqPdHj696kvafT2/nevOs5ddbOz7dwrAolHiozwYNx2
         pUVZ6RsA+RFAAkk4+nhKOofd6jlX73GTvF/lv0GpUQu6GVKefrh3Ug88g+Y8jGTSyqoV
         HeT9a7dNuTry5QJeDiY798PTsuk3QwlZm8/POkmcEqGeELg0K7ZKjvlHf7Z7z1H+vKWz
         kd71gAVhfiI9TD93WCdXFljtm2Zd+h9d1NNtXD27Z7pAJzFpmF2YDvXz467tCeeDpF/k
         HnfA==
X-Forwarded-Encrypted: i=1; AJvYcCX8yN3Ji+TqKw0HaB5lFZsu9SXC9PWPap8fR+yyCd18VL45+gCb66qhxDMO8V38Xab5WFq867muXU6j@lists.infradead.org
X-Gm-Message-State: AOJu0YyKxQtn/81/j73mza+/qVHHtf84u3ippd0/fh3fAjggemNYBiwi
	ZCVo7NysF0i5GdEcNOytfBAp7ZaAn3RqN1lkY08pn0j2RRmsbKciIkEBMw==
X-Gm-Gg: ASbGncsQ+XBA6bAT8M/DFd5au2D0sxZFtqBCk+RcskdWPr6zvYy8A5LXTibBZJZEo5u
	SGnEftE97tUW9PjxrhlM0Gekcy7xUuEEeWpo9m3P8mpqUZWQr0rk/QvwKciVYa4WYL50b2GMG12
	HvzKFHFN3foHP1TiL3M7D+uWSN2ZlbG5YHfDEEtf9u5BUo21HKdxukqaqJRkt2kCrCYUMIS7VhA
	1jRmcpLlCn4nGWdvU3p/shcFghIw8wj/ew0cz5kZcezhzHWnlMgRlSMiw==
X-Google-Smtp-Source: AGHT+IFk0SXZCKGCnlLrTdF+H7B8tOKDqCjKa0psfP+s3ClB+df5BuAqqiAyl+b/3U4nAA+9UpIchQ==
X-Received: by 2002:a05:6000:440c:b0:382:3f31:f39b with SMTP id ffacd0b85a97d-385c6ebd533mr1529071f8f.25.1732703700155;
        Wed, 27 Nov 2024 02:35:00 -0800 (PST)
Received: from [192.168.42.80] ([85.255.233.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe207sm15991312f8f.36.2024.11.27.02.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 02:34:59 -0800 (PST)
Message-ID: <5f77cc2b-d589-42db-9985-e56bac1da569@gmail.com>
Date: Wed, 27 Nov 2024 10:35:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] io_uring: introduce attributes for read/write
 and PI support
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, martin.petersen@oracle.com, brauner@kernel.org,
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
 <CACzX3AtBc-Vio1H28MM2tRvcLzTYBTFJt8CKgF5NeGTniKFUbQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3AtBc-Vio1H28MM2tRvcLzTYBTFJt8CKgF5NeGTniKFUbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_023502_205068_E9FC6397 
X-CRM114-Status: GOOD (  13.86  )
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

On 11/26/24 16:23, Anuj gupta wrote:
> On Tue, Nov 26, 2024 at 9:14 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
...
>> This example would be incorrect. Even if it's just one attribute
>> the user would be wasting space on stack. The only use for it I
>> see is having ephemeral pointers during parsing, ala
>>
>> void parse(voud *attributes, offset) {
>>          struct io_uring_attr *attr = attributes + offset;
>>
>>          if (attr->type == PI) {
>>                  process_pi(&attr->pi);
>>                  // or potentially fill_pi() in userspace
>>          }
>> }
>>
>> But I don't think it's worth it. I'd say, if you're leaving
>> the structure, let's rename it to struct io_uring_attr_type_pi
>> or something similar. We can always add a new one later, it
>> doesn't change the ABI.
>>
> 
> In that case I can just drop the io_uring_attr_pi structure then. We can
> keep the mask version where we won't need the type and attributes would go
> in the array in order of their types as you suggested here [1]. Does that
> sound fine?

That should work, the approach in this patchset is fine as well.
I'll take a look at the path a bit later today.

> [1] https://lore.kernel.org/io-uring/37ba07f6-27a5-45bc-86c4-df9c63908ef9@gmail.com/

-- 
Pavel Begunkov


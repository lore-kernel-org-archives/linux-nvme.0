Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A69D591A7
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSa4AiSUQT4EIzACqKoBsLT6b9aJkO4XWmWdzOpmUFk=; b=YZXCuRrs2Qxrx0YTZbRgAVI9hv
	OLYPT9FW+pgxDR8UEyfB6P3edoqGv7XGeK0CDpbmH3+8A1CDuF+a89ZZXkoXTZpe/9etmwGwOA550
	TaanTp5iYzfTbFaTlHnmlqoH8r3LQLz5oCO8WqxYLGpJP5dVewqf32Xu4FpJNXfsKfZplDcRaiqVv
	kc9qvZYJcRsSj1MOoHyK479Cg7SW8QALsw8dGEhLsi3Vb3GrZwYK+W5AwmclsUSSvs7cj8XOm/bLP
	wKpStIukQjFDMaCJdoWnx5NPa/kRcmJ6Y2iG2n62vi1UavdDjNGvf45F4oLsbtdah9L5K7vFmoMfL
	HcMuYpZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD55D-0000000A8nf-2LbL;
	Mon, 18 Nov 2024 16:58:39 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD55A-0000000A8lx-1JIt
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 16:58:37 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so3462148a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 08:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949114; x=1732553914; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSa4AiSUQT4EIzACqKoBsLT6b9aJkO4XWmWdzOpmUFk=;
        b=KRxSzIRH4ro4x8zlxfl5EeBwQfjZtG+5ke9zPcm4Bm87lU13tibDzg57Wg3UnD3Y09
         Nauc5pxMEvX8AbxTqCc2W/Xf0VqWDFZDcd0YLpiBMPybyumMxy6KhSC+g3/bIuvuj9KW
         q9upA0tIDy6ogVqk60z3FrNAYdwlJ+FIJfFY09+UStBw1ThAUv0jhi34Cu/mWfs8qLOM
         DBRMUlLe4JWZ8PFVZmrUAjaAIRkaOmL2Zvc8oBVY4Fc9QS5cN2lZT9yXBrGFS7qKI41n
         gLfRMg/hD/DPXW4pPRZBVcDSHRNDfvcNiBVWsqQ3vy3uXG60kR2rLRsNj3tT6UpyucAS
         uqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949114; x=1732553914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSa4AiSUQT4EIzACqKoBsLT6b9aJkO4XWmWdzOpmUFk=;
        b=BJ3Uls4P6M0ng2k3asnTPscFeQBvhicq52QRrFNcIuhyT6gY3+WKLkbUjBlLOEK0SK
         lDUGI6BBy7WRT/F+7qsBGvbr6fmu1FBSngU9yDhWXfqe1muCbom3DWktNo/N5dbyl1Uj
         WY5DluZ/Z2nmv20ta9yBUdpJkt4xH9QQiMEuY0sT7VEi4Zw4Z21PBuWK5gieTW/mybIU
         HT/eFXGFJzJtSjcDcoI9rejsRzTOIZhO+iQnV6CtlzkhVBJ+1/HTZW9jHpOzISdSKipk
         eBhBLpnH9zgt4SwWO6HuyMFOTmH14EiC/gQv3SSHk0NklJP/VhyY/kLtG6gHn41NmWKk
         G7rA==
X-Forwarded-Encrypted: i=1; AJvYcCXEcwEPZJqh8LXMDkzeNiQC057CXPU5W7QFZsZY3sQOBQSGLqEMUsIoVVGaTo7uHCTuwEZKOBtTwiue@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5O3dr4a/7APDSZ7x7oJQJI30r2WRqWFoHnbo2P1xLx59OR0gu
	aiXshqurXJX+0pdtaWx8Ps8AqDInrByrqw/5zyIZWbp4nbf+Tz9c
X-Google-Smtp-Source: AGHT+IH52mNHQGeEuqVdr1cSbraHrFN8r876XTWARB223O2IQYjwJD8dVGvodh77iQ1knokoJYKsEw==
X-Received: by 2002:a17:907:7f88:b0:a9a:7f84:93e3 with SMTP id a640c23a62f3a-aa48341a1c8mr1260995866b.14.1731949114149;
        Mon, 18 Nov 2024 08:58:34 -0800 (PST)
Received: from [192.168.42.187] (82-132-219-237.dab.02.net. [82.132.219.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e048f12sm557010566b.173.2024.11.18.08.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 08:58:33 -0800 (PST)
Message-ID: <2a98aa33-121b-46ed-b4ae-e4049179819a@gmail.com>
Date: Mon, 18 Nov 2024 16:59:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241118125029.GB27505@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_085836_352701_B4F8FDD5 
X-CRM114-Status: GOOD (  18.85  )
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

On 11/18/24 12:50, Christoph Hellwig wrote:
> On Sat, Nov 16, 2024 at 12:32:25AM +0000, Pavel Begunkov wrote:
>> We can also reuse your idea from your previous iterations and
>> use the bitmap to list all attributes. Then preamble and
>> the explicit attr_type field are not needed, type checking
>> in the loop is removed and packing is better. And just
>> by looking at the map we can calculate the size of the
>> array and remove all size checks in the loop.
> 
> Can we please stop overdesigning the f**k out of this?  Really,

Please stop it, it doesn't add weight to your argument. The design
requirement has never changed, at least not during this patchset
iterations.

> either we're fine using the space in the extended SQE, or
> we're fine using a separate opcode, or if we really have to just
> make it uring_cmd.  But stop making thing being extensible for
> the sake of being extensible.

It's asked to be extendible because there is a good chance it'll need to
be extended, and no, I'm not suggesting anyone to implement the entire
thing, only PI bits is fine.

And no, it doesn't have to be "this or that" while there are other
options suggested for consideration. And the problem with the SQE128
option is not even about SQE128 but how it's placed inside, i.e.
at a fixed spot.

Do we have technical arguments against the direction in the last
suggestion? It's extendible and _very_ simple. The entire (generic)
handling for the bitmask approach for this set would be sth like:

struct sqe {
	u64 attr_type_mask;
	u64 attr_ptr;
};
if (sqe->attr_type_mask) {
	if (sqe->attr_type_mask != TYPE_PI)
		return -EINVAL;

	struct uapi_pi_structure pi;
	copy_from_user(&pi, sqe->attr_ptr, sizeof(pi));
	hanlde_pi(&pi);
}

And the user side:

struct uapi_pi_structure pi = { ... };
sqe->attr_ptr = &pi;
sqe->attr_type_mask = TYPE_PI;

-- 
Pavel Begunkov


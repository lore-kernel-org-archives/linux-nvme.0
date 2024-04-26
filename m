Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164D6C4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Apr 2024 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oLE1VhiQpQ5OcS9V/M7lYJTy+r9DsERvO0PIhyj9Gu0=; b=d5BhTqG/u7TC3EMTLSe1DZ2Gd+
	h860NLbAPtcVkZ8nJhoQyO4uov0OVq7a5TJz/PwTx/vLqXIpgG+cQcoMg1X47XJ3RrAvy02jchiUP
	DfDbF8tpUC/EqFJxIZhqQo/gqRuwhxNVSwDFIQY9MTL0gvByrgN/6wZ3XOd4mwqshEt1S8pqQktZe
	eA/0Sd6FvpM7fxqVhxnA7ClOnqf7OU9tBBVBEVS3x6TbTQHieIWDFlNuT3LCf7AZgFRgqKsWwBut6
	YQe9khdIKgyyksdPaZ2BCPZjp8DpBwEMpUEt+da5SbNWHYMPrqqlAPSEQwf6HglvRdiETdLAGpxwf
	FhjPbo4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0MQP-0000000CnyF-0Gmz;
	Fri, 26 Apr 2024 14:19:41 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0MQK-0000000Cnxb-2Lho
	for linux-nvme@lists.infradead.org;
	Fri, 26 Apr 2024 14:19:38 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7d9ef422859so17585839f.0
        for <linux-nvme@lists.infradead.org>; Fri, 26 Apr 2024 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714141175; x=1714745975; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLE1VhiQpQ5OcS9V/M7lYJTy+r9DsERvO0PIhyj9Gu0=;
        b=13mLajZBR7qS42XKTxPrxXsi6BGRAT8uPcWBngu6EJnQZCC4UKw0hzlJDbr2JFkJQM
         fDcs5HNg9ScnVRIlVcp4nlT/BBhwxWgZWmmD2pldjbClJal4OuRqyFnmB/G/98kfbHgB
         2A3W1MvCt2nR12dM/KE1hODW0GYH9Ertf+EnGIIkRe2IzSW5HW2Y0MjpEQbGYPrXSJfa
         Q84N3bAcbTWxMadcjSaWDd6v/pu5ROG7Ka1gGdFYQ2jSU50G/gFxpy0i+9gEqNEBLl+F
         QZKAmv7Zf5Z7NBQKEzLc8FlmO2N88iFMizKjuUQOctGBzn8bdsnEnQOmVstooQkJz/gx
         4ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714141175; x=1714745975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLE1VhiQpQ5OcS9V/M7lYJTy+r9DsERvO0PIhyj9Gu0=;
        b=LsKWE3DHEjdYF2LIKK2n+tBnOOpQUHpNPxDcvI4jq697AHCvZr41FyOwyhknKchWfT
         MoRk0K2/oIloNGJfYw4p9PhsJ8mWyZ+ncRIIa1jmlP9qJYPzaZ+AZ69nf+Sk40syxRLW
         YHwaZCsxGQcq69ArF0xQpcsh0fnivJFi6sE6uUSNg0mVqx/PsrSplkfOZT3DtUH0S1uN
         fiNJAQWItX/dnvyuXmrTsZP20CYzz4RUuurQqH/EM+SqZFTjYc1Oa8ON1LwzIaUp2HS7
         5baw1C44hptOYYGW2fLuDUUA6rpICEPkvLtVxndk931o7Nqr4nOoZibTQhBcKJqIfrL4
         2uKg==
X-Forwarded-Encrypted: i=1; AJvYcCXXtsUJMcDc1Jri2HNyy/Gz4lceoEFlGm0Wq//SgB6V1cxjvTO3PeMVEqpqKxn1PCBbylueMFylaifhdA+xeGi94IhZstHRL9lqBLbJUHk=
X-Gm-Message-State: AOJu0YzSPrnuTyiFS3Fr0rANqyuH5UplXux7Emi3waluGq04WwIy/JlS
	HFoYcv4dNhyveDq5wZHMC+o1J19lOdEGHFWgnh1bBaNrO2UPpXW6RxcJHq93TLs=
X-Google-Smtp-Source: AGHT+IEs6ahfJZD0YETX4+8tBvgF8wLQ8qrIx4W8ZCh/u5tNqzsjvVGNUuw9621GGMdtYRmctPFEMA==
X-Received: by 2002:a92:de03:0:b0:36c:3856:4386 with SMTP id x3-20020a92de03000000b0036c38564386mr1137817ilm.3.1714141175204;
        Fri, 26 Apr 2024 07:19:35 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r13-20020a056638130d00b0048301287b9bsm5541463jad.162.2024.04.26.07.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 07:19:34 -0700 (PDT)
Message-ID: <16d4a454-19a3-4300-a819-b53cabf75b57@kernel.dk>
Date: Fri, 26 Apr 2024 08:19:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Read/Write with meta/integrity
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
 kbusch@kernel.org, hch@lst.de, brauner@kernel.org
Cc: asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <CGME20240425184649epcas5p42f6ddbfb1c579f043a919973c70ebd03@epcas5p4.samsung.com>
 <20240425183943.6319-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240425183943.6319-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_071936_735312_F09B8D88 
X-CRM114-Status: UNSURE (   5.59  )
X-CRM114-Notice: Please train this message.
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

A lot of the initial patches appear to be fixes on the block side,
maybe it'd make more sense to submti those separately?

Comments in other patches coming.

-- 
Jens Axboe




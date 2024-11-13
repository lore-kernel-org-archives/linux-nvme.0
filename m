Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636F6D462BF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YxoYvCc4g+aZSytICLtm1wqwtJPWfG0efXdLC41s+ig=; b=Fe73kcHMu0SuewnKHdgYoalCOE
	b6y1ojYmgSGMdhTJFh+WoL+HkgB0qTYDrHSM89bRVooPG7XwDTOeFBXqcO2nEIrrnNuSpzM0KZMUU
	wuh1ea2rg+g7EMFjr1lYgonxoFT7VJQ7BPPsaxJLC1QJvUd0BIFMdRjqcmvGcg9skPnFFkjCYgUYg
	O2w3c3YosQUgBqUTzJblgDXmM0FyINJNioxkUd3APrGr951pQUCX+ue1zqcxKh4SxMQN0rJSPN5TS
	mEQLUX1HUlpu9s6IawsZYAkAsjtP/6ZGZ7vNt3N3v/xc7ySMWTJepjD7SApjsN8rqTG9mNI32MMow
	tKZ9yfSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBF54-00000007GIT-2gE6;
	Wed, 13 Nov 2024 15:14:54 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBF4x-00000007GHB-34ME
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 15:14:49 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-20cf6eea3c0so67762365ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 07:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731510886; x=1732115686; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxoYvCc4g+aZSytICLtm1wqwtJPWfG0efXdLC41s+ig=;
        b=Mgf83sm9bXxaA12neaEBn9ZWoDwKP6jrhYG39oUALyHVnRgoQFYb6hD+Sg7msojoFQ
         qsLjp2UHmk4oz6LOfQuCdVUV/hv0vk76g2EtwgY4LAgLgDyfntpxa1+EEVprPtaqNiKH
         M0Xaam0xJ7uza4HKoH64AWSM9Dq9IvgzX996neyt6xbPZnQRbqt7vsF1HfyKN3ci1YAd
         7hVI8mRyc2z12YhqTaUXEvTmFZpmbY5x8uD78ysUBPkDo4kSAUoJ2p9r3WUkqj2zL/k4
         uRpHPOTmm0Cym5Ryxk870ZGeMT8Gni624G3qKDmyQ2sM0yBjT23+LgqZYQhpjjEzs6a8
         Hesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510886; x=1732115686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxoYvCc4g+aZSytICLtm1wqwtJPWfG0efXdLC41s+ig=;
        b=ml+bmMfI4FjFaZig7PTDxgV0NW3bb85O4z8PDDSP+4azxyOMoZ08AezMwCz+HUqm1s
         KycUDjLX3NocEMUbB5gAL203bIF4r9Lg/TrcuzUtw9m7q+HvJch0XMPdXtL+wO2zqZ5J
         tkal03JnB0WjLkVci4zdQzuE2qBItozDnjIYVCJcr9eTQZTY9gIHh6wvOm4p7plEbNsl
         pEIC+KVtRuhp/i8oxV2Pc7tZgp/aygyCmZkW7Z928kqlbiKOlptjZS1P2xaXf0kQfGNT
         b9a33SOazB/aj23N2C2d0tfSaq5pLJ1x4G6Eva89CEOOnLN9rPeFrE4/58WZDtPe+3Ge
         z0KA==
X-Gm-Message-State: AOJu0YyY8GSHqEYOGKBBHU1LyFOOOUKlOQgU/ZHAO3DQ09YcUJ7ps+a0
	U1nE0Vzd/fruX83EkVY4wY+6K1OO+JmRa7ju6SRxFWw5WtD8BmpTmz3EXQ==
X-Google-Smtp-Source: AGHT+IFic0QeHTlnubM/t7SmaHAaRr5Exw91FFWaF1xHi1RMs4JhHR++O00lbBx57x39O6Gg3i0mPQ==
X-Received: by 2002:a17:902:db0b:b0:20b:5b16:b16b with SMTP id d9443c01a7336-2118359cb22mr304013765ad.36.1731510885653;
        Wed, 13 Nov 2024 07:14:45 -0800 (PST)
Received: from ?IPV6:240b:10:2720:5500:51e0:eacf:2b7d:db2? ([240b:10:2720:5500:51e0:eacf:2b7d:db2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5b849sm110738485ad.214.2024.11.13.07.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:14:45 -0800 (PST)
Message-ID: <52a74c14-e95a-4065-9b38-8aae830ae239@gmail.com>
Date: Thu, 14 Nov 2024 00:14:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: use BIT_MASK and GENMASK for NVME definitions
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
References: <20241111170935.4540-1-ikegami.t@gmail.com>
 <ZzLZCzXfrLAP_RO8@infradead.org>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ZzLZCzXfrLAP_RO8@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_071447_820638_60A5A8BC 
X-CRM114-Status: GOOD (  12.00  )
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

On 2024/11/12 13:26, Christoph Hellwig wrote:
>> -	NVME_CMBSZ_CQS		= 1 << 1,
>> -	NVME_CMBSZ_LISTS	= 1 << 2,
>> -	NVME_CMBSZ_RDS		= 1 << 3,
>> -	NVME_CMBSZ_WDS		= 1 << 4,
>> +	NVME_CMBSZ_SQS		= BIT_MASK(0),
>> +	NVME_CMBSZ_CQS		= BIT_MASK(1),
>> +	NVME_CMBSZ_LISTS	= BIT_MASK(2),
>> +	NVME_CMBSZ_RDS		= BIT_MASK(3),
>> +	NVME_CMBSZ_WDS		= BIT_MASK(4),
> Nothjing genmask here, and a lot less readable for no good reason at
> all.
Is it still no good to change BIT_MASK() to BIT()?
>>   	NVME_CMBSZ_SZ_SHIFT	= 12,
>> -	NVME_CMBSZ_SZ_MASK	= 0xfffff,
>> +	NVME_CMBSZ_SZ_MASK	= GENMASK(19, 0),
> This is using the GENMASK that you mentioned, and now I actually
> need to look up what GENMASK does to decipher the previously perfectly
> understandable code.
-       NVME_CMBSZ_SZ_SHIFT     = 12,
-       NVME_CMBSZ_SZ_MASK      = 0xfffff,
+       NVME_CMBSZ_SZ_MASK      = GENMASK(31, 12),
Is this also still not understandable?
> Could people please stop sending or suggesting cleanups that make
> the code much worse?

Sorry for bothering you. Also the changes were not considered enough but 
still seems better to use the existing bit operation macros instead of 
the current implementation. Also thinking to change to use FIELD_GET() 
and FIELD_PREP() macros. If possible to make sure let me reconfirm your 
opinion for above. Thank you.



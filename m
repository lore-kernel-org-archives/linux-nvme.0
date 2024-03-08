Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2757BC54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzUtklwPlJOuPJluAgACqxyTfZzplj9AthRwSYyjjp8=; b=rUor37qbPzI3IJC2Zt9cRCzmFR
	/ifbT8Wln+uHhx1S4205d5g/7Xu606zGATYZzvsHq+0XeLeBLzul7v4/xOCIQ7/4psvPRSiJ2Ut/3
	u3qiJJBhSNUFfoDNLnu29rFa18cG+tGmS+kLTdPkJXyDdiDOAEojAMSM1HzZlPINYUWRBuW4paKS4
	dYIeRIpU4iirE+Qs1s+OmRbKLI2DmH+DudOD8RpUHdIDaQlJaaVF8egf9B+BQSxAf+dyTY1J5t0uz
	eKaR6EBky0qxeF8wI1LPPXi+3coBHNdTmM8nOsNbFKLRbxu7IBeFgL0Le1IT7fRqoHh7XwNgltyi2
	grtcFhRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridrK-0000000AS1j-2p4X;
	Fri, 08 Mar 2024 17:18:14 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridrG-0000000ARxp-1peF
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 17:18:12 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-365b5050622so1911105ab.0
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709918288; x=1710523088; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzUtklwPlJOuPJluAgACqxyTfZzplj9AthRwSYyjjp8=;
        b=R6RR3HPem73sTuioKFspuUIsdlFCvWz33GAm4n6ZIFpZsu5VGLDkOKD12sByOg9lhm
         6K4Y7AXNPDn+6Mm0p9qSYMIqvqbJd7ifoof7beg/uE1OaseTJmKstgxyRTll5s5Xja0u
         mRU9xZsYoCC8QoYlRBLWlwwBJxQuR3x+iRcuk1bu1UVe2h4QmPbXcmZsfsVQVscgYCaD
         +HROB5pvaF2Ei7opG0+hmG4y+t5o3tsB2J3FWICBYDhKtGiFRydiUcE9Wn0y3vvcLzH5
         Rvg6rZynl9hk0Zwy4HRpFmz4Qx2bfRIKC+rI2h4ix4PIKrzZehoiv6UtKRoo+opm9YQ4
         LeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918288; x=1710523088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzUtklwPlJOuPJluAgACqxyTfZzplj9AthRwSYyjjp8=;
        b=muuauRAanFqOmt3kUB7Ju+nPsihltRuYqz7Cus8PbsC8rvO3SO7Lw/OIr0Tdjw38mi
         R5Pl+1qO5oESqRDDAG08kWJ/VWX4UTxyYfH92y3EaaaQLaKvqAFoL7+8bRd5dbvQoWfz
         1unXtvFxSAJ5A9wM9klIIM9VyY6znD3ZXHI8vSB9ssj7yCLRb4EqKGE/SgUufXYbPZvG
         8PrdxJzEXNKkE5GhDC98l6rMyEWmJUG7hYwZnCTVJPtxOZsyqcHqr7RWIFUsgA/vKVB8
         rSFA7F5xbj+WP/l46fwnxY0Y01myZ8i51+jp0iQp1auZj8EmrcGlBl0FJFTYJP0ceDsj
         uRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGnYALmXap6D3Wc3/pFiwtrenGrRWAJ8RW45SYSgAxiES+Z9gyfT/irg/CWb2me2MKQ69dWxYU4TJuozF4EH0x5/tmOGFMIfn0BHcK6FQ=
X-Gm-Message-State: AOJu0YxVnYldR3/TPTHFthY0E2wcsAI+BBq9m9DWInudv+rmcz0otuhk
	jbszRF4wCVwv5LcGdTj1Ifl7/n4p+yj1SnKdjS2LyNhIyquWdz3eg13wZqUdpMQ=
X-Google-Smtp-Source: AGHT+IHxACDHwXpB1DRHc3vyvQVo+hhXIx+dv77eD2O+Lwu72LmdLkTlNoD1vGHkQjkQPAl9xihoxQ==
X-Received: by 2002:a6b:7709:0:b0:7c8:7471:2f59 with SMTP id n9-20020a6b7709000000b007c874712f59mr2596113iom.0.1709918288476;
        Fri, 08 Mar 2024 09:18:08 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id do32-20020a0566384ca000b004743bc59379sm4533416jab.59.2024.03.08.09.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 09:18:08 -0800 (PST)
Message-ID: <30c3773b-4db3-4278-a127-df8c075e8109@kernel.dk>
Date: Fri, 8 Mar 2024 10:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] fs: Initial atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
 djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
 ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, nilay@linux.ibm.com, ritesh.list@gmail.com,
 Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20240226173612.1478858-1-john.g.garry@oracle.com>
 <20240226173612.1478858-4-john.g.garry@oracle.com>
 <1f68ab8c-e8c2-4669-a59a-65a645e568a3@kernel.dk>
 <67aa0476-e449-414c-8953-a5d3d0fe6857@oracle.com>
 <eef12540-84b6-4591-a797-6cfea7b28d48@kernel.dk>
 <8fde7b95-fed0-4cfd-a47e-455cccf1a190@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8fde7b95-fed0-4cfd-a47e-455cccf1a190@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_091810_600974_16C904F5 
X-CRM114-Status: GOOD (  10.28  )
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

On 3/8/24 10:15 AM, John Garry wrote:
> On 08/03/2024 17:05, Jens Axboe wrote:
>>> And the callers can hardcode rw_type?
>> Yep, basically making the change identical to the aio one. Not sure why
>> you did it differently in those two spots.
> 
> In the aio code, rw_type was readily available. For io_uring it was
> not, and I chose to derive from something locally available. But
> that's a bit awkward and is not good for performance, so I'll follow
> your suggestion.

It's literally just one caller back, it's not like you had to look hard
to spot this. Don't take lazy shortcuts -  it's not very confidence
inspiring if this is the level of attention to detail that went into
this patchset.

-- 
Jens Axboe



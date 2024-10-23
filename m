Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CD5CFA452
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IhU9icz1vShdMAvU1NJ1i2U5k9ZE15DFpA53Ai20dlU=; b=Cirvv7omRMhQJPMZPe3r2T3gq0
	cFMY3OF/MicCtFm+EtqZFhdKpR01jKGZBtMOHGAnPqhMj80gy7q/j4gzsn3ddDpq/TIVXU+RqDPmn
	S6g53WUSBIV+ITDxNTGzVup+BXIJEvAM7wSJ+rnjf5rNvkOH9G/PQsnIFtm/WjxBTTyWEdamca3Z5
	qKmqIJldUZ8wf51fJETwSiFJ0um8eqvC2Fi5U4CtOn55LW4Vkrma5NUsIDI1U132cjOgjS9LxDzk2
	k0DCeTNeiIOnMvKo8gISOuLtrMMY1oz2F2W1N3ujA26FcVHi09lZXPiqSGy+ERSt4XzSj/HAi6DDy
	9rBsAD8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3etm-0000000FK0g-1as7;
	Wed, 23 Oct 2024 17:11:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3eIw-0000000FBRR-18jt
	for linux-nvme@bombadil.infradead.org;
	Wed, 23 Oct 2024 16:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=IhU9icz1vShdMAvU1NJ1i2U5k9ZE15DFpA53Ai20dlU=; b=EfRebBzj0wzjZpYEJ9u0qiYFYw
	KZA0OZmc8pZxHcHPlyln/7usgTlHQ/sRVEYyxlcsP1tQ0f54u/DQB/p3F5sbVQ86W/jvocHpPywJu
	/t/MlxpmUmbuZllchzGGtNF2qZxlb0ROtpNOLu5PjDOB2fm0u1Tqad6J5u0lNrmA92P8P3mwfQnoo
	6donctRpDNBFpGA2tW6tblXTWGveCuJDcbLpKJpooDfLPc72iQXLQbdmNSnPjz6EL4YJ76H5+jo8f
	iZ7e8awvoXEQyMOwpbyigJSeG8w+1ogaKzNEAt755IOFTxtf41UnomEWsRAcp4II85EZTb5EMoFEN
	k2/puh6Q==;
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3eIt-00000008SYa-0iJx
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 16:33:49 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso8656b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729701224; x=1730306024; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IhU9icz1vShdMAvU1NJ1i2U5k9ZE15DFpA53Ai20dlU=;
        b=KQJ0fWDok5mrrUytohO08lA5gk/nHNHTfp+A418uuHdmSU42/2oDAYa0ph04IAtWKM
         UmgGfvEATgv7bR4fLMjyG+whO2mHa25sykQKlljkGRYQFXJkyojRvdJ1ngoQJ3Y9A3QW
         JyBpUnvszrsTYIjsk0hqORrN8FF36cLOlUgFLt/Opgzt6kAQTIADpgUjgFtkgVqfuhyl
         F+5GHjkCWFj5le6m6LbiaIwFtrbILaYW1JgSFCWIgNQnl3Dh8omP4N6cLDmbg4nYQ9g2
         APvBqRCkEXRxk1nLBpO4GW6Tr4gC9JlWdwKh18T9EQ2IKv4kFeJc7EJrWDccPAJSTwht
         O8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729701224; x=1730306024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhU9icz1vShdMAvU1NJ1i2U5k9ZE15DFpA53Ai20dlU=;
        b=IPX5y531ySTdoxZ87g+/dUExcK2SYutNXTdu6tpT7S6EGJoz2pvlW1w8lcdnhIXbiJ
         ksAECKBPjqMHZmdzlllIjwLgemqUHxEYeWEyMx3STWcjRkIO0ScHWd6yqQJT5Ggs3GJN
         Bp1VkfiVJbpuE9twxg81htoN77P4YGD44h4+0gwazNYfd2CkbMw3yp9TTYy3L3CFW+i9
         v70/bylu2bDhnu35uCyNy5IOmOiypJwTPv63VsCJpjbC8TygZ8a55XzQNNHaJls3Rhte
         rmI2eaJPzD7IA3jQ10r55QtHpcPf37vHobfn2LgkIojJJ4VnlQA+cnD4oDOFI335698B
         arBw==
X-Forwarded-Encrypted: i=1; AJvYcCU+jsIRK/oUkzUNS9EWu5yISG8L6HeXPSDfJA95FZNGWlYQ176wtHKimmUgMKQtYT3BQdCZXRs1kPrq@lists.infradead.org
X-Gm-Message-State: AOJu0YzS2jSPq2MZHl4/8wPNtSnEVLctw0h02UUJGZjIvn24+dh6X+9U
	0/aFUmy6EHQhTLywOrcCl2YSidb0rYvqWUobKw/hZgrH0nMp+aCK
X-Google-Smtp-Source: AGHT+IEdKz5ZE1B36TZsbYoCKf9Qfpbgv7X3n0DpX7f8QXNcrrFgvsZy8w4YnrhkKES8dIJf7BGxww==
X-Received: by 2002:aa7:88cb:0:b0:71e:1722:d02c with SMTP id d2e1a72fcca58-72030a79c21mr4571214b3a.3.1729701223634;
        Wed, 23 Oct 2024 09:33:43 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:2599:5aa5:a0f:e0fd? ([240b:10:2720:5500:2599:5aa5:a0f:e0fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d75a2sm6490028b3a.135.2024.10.23.09.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 09:33:43 -0700 (PDT)
Message-ID: <a4d2bbb3-2718-4fda-b225-a2ba66f451cb@gmail.com>
Date: Thu, 24 Oct 2024 01:33:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme: change nvme_ns_has_pi() to
 nvme_ns_supports_pract()
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
References: <20241023100915.11263-1-ikegami.t@gmail.com>
 <ZxjwAsny4yOUHvUD@infradead.org> <Zxj2rPzTGILnrUup@kbusch-mbp>
 <Zxj3xwDyP1j8Y1Ms@infradead.org> <Zxj4SDRxSJfca_Wa@kbusch-mbp>
 <a41a55be-dd3d-477b-8eac-27f80da63ed0@gmail.com>
 <ZxkSJJm54Gs9exWw@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ZxkSJJm54Gs9exWw@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_173347_357906_7157DD45 
X-CRM114-Status: GOOD (  14.69  )
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

On 2024/10/24 0:11, Keith Busch wrote:
> The important point for those MS>8 formats is the host *must* provide a
> buffer for the transfer, otherwise you'll get corruption. This means
> those formats are not usable if your kernel didn't set
> CONFIG_BLK_DEV_INTEGRTY, or you have a fabrics transport that doesn't
> support these.
>
> The format where MS == PI size can still work without
> CONFIG_BLK_DEV_INTEGRTY or fabrics support because the the pr-action
> disables the host<->device transfers.
Okay I will do study more later about the block device integrity feature.
> The function, nvme_ns_has_pi(), is specifically looking for the formats
> that don't require the host to provide a metadata buffer. The comment
> above the function says exactly this:
>
>    "NVMe ns supports metadata actions by the controller (generate/strip)"
>
> The only time that happens with PRACT is if metadata size equals the PI
> size. Section 2.1.5, Figure 9 says this more succiently.
Now I could understand fully with your advice including the driver 
implementation and the section 5.3.2 also checked again.
> It should work fine with any MS>PI size as long as the disk can
> successfully register with blk_integrity, which again, depends on your
> kernel config and transport type. That block layer can handle protection
> information with extra metadata in the same buffer.
Noted this also. Thank you so much for your explanation.


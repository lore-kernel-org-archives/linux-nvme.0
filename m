Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10764CF5398
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZ6c/mCNP/LLZQwjvBNqvY1NBGX2IteH2XgCWyPLqk8=; b=4EzwoW3NTOQT/tZXGg9etHvD+W
	MAnuTkUTpdzFXBK7gbjhgII00YaxF3tF3wwgHMDqm6w+pEFAL5aZ4yDmwaQ30vMcf6kNgSbWYT6+E
	ClUc9QsjGZ6q49VP2UnbeRv9501gwrfOPGSaS+d57v0LLjMjNYb1+q3+XRnifSHG7oK1Vo5tYfI7J
	12Sww+kjLJ8wB72b9rcfXRU0U+j1acsknm45NEixXcmRrONKys1il1mYKNEAGB1M7h8xWcW1mQu0b
	Fne6LbOU8Jq2+WttpE0g7e5uJo2ulKvJyxkZaZXZB01lIQnUa8Wyh/95DNn5lmH7aSmIMo95sQPi2
	7vt9sJ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cgK-0000000Eo8V-0IFq;
	Wed, 23 Oct 2024 14:49:52 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cav-0000000EmhD-1RbT
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 14:44:19 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-71e52582cf8so4903378b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729694656; x=1730299456; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZ6c/mCNP/LLZQwjvBNqvY1NBGX2IteH2XgCWyPLqk8=;
        b=jNqvLU1IrbGNPxpXrw6KTJS9oH9L1Nebi9/7lQnDhZm1ekrBQoVqY3QtPf9kmGK2Fh
         vDZdqPUMs6mt28JvUKOjMNrWlnyeApYemKhg5f5vA0KLbntoVrJ6EuaswkN0DbqlXK/f
         QxKLI1Pb51pVZUAVKUAU9zso8d7/JXlQiyAe2WLnaeaflqma82VVVDXSN6lhWLLxLpId
         /gdFvyxSU5/ZgtrsjdMSDMJXqwRyWMGEjUhJ4xp5q6UXL6VhXGMpo2cePbM6accKeSzA
         gHSg/uhghiERMMnfQHJE5kojKcpbDNTHtyg/qF74ShdMtbexfYIX4DHfRvh5NCSUZ9Xa
         L/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729694656; x=1730299456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ6c/mCNP/LLZQwjvBNqvY1NBGX2IteH2XgCWyPLqk8=;
        b=kwdM+1uKOy6efMX+Gr6UgUE2v40NRE/OpprB/24dkkxVjqPivXt6ufNkxea8X9MmHN
         64VsNK9x0SlLMTDYmkqkul67dCp6sGGo4UnNmGW7Va1qicA9dTlywWE+mz18OZjdES+M
         1vMzgLENdyf4oNL8TAPOcRd27dUSYSURbPF7QLHHX/nHIWvJIZTlqhRZEsdh8bgFnowh
         vm8OtQg/M/EewF35VMjFoyMS/6CGxDZaKMxIGCWhN4nu2ouDrwCFJXq5H+a88nPNC7La
         OjQjzskKzTLr6xQO8XFXgyAwu9tyL+N7Vhx2hUS/ImQKBk8Bw32i9BVy51AK4ieQDz22
         kG5g==
X-Gm-Message-State: AOJu0YykRvfaOzCzTfU5FHvA2u95VRE3tRWgaju05f19hhy1S6OEI/w+
	RRLQ2M4H86cUCk73Hcv28lXGc1Jg49FgkJNPcZtlXSlWW7xPAP0Q
X-Google-Smtp-Source: AGHT+IF7Oz5xKsUQXfvLxYOioJPzxTx4UrydIp+ogOzL4D1Zhe5XVd5qV7QUbT+XbbC0BKFnEU9IQg==
X-Received: by 2002:a05:6a00:856:b0:71e:cb:e7bf with SMTP id d2e1a72fcca58-72030cbcd70mr3548862b3a.18.1729694656004;
        Wed, 23 Oct 2024 07:44:16 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:2599:5aa5:a0f:e0fd? ([240b:10:2720:5500:2599:5aa5:a0f:e0fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415066sm6432258b3a.198.2024.10.23.07.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:44:15 -0700 (PDT)
Message-ID: <a41a55be-dd3d-477b-8eac-27f80da63ed0@gmail.com>
Date: Wed, 23 Oct 2024 23:44:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme: change nvme_ns_has_pi() to
 nvme_ns_supports_pract()
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
References: <20241023100915.11263-1-ikegami.t@gmail.com>
 <ZxjwAsny4yOUHvUD@infradead.org> <Zxj2rPzTGILnrUup@kbusch-mbp>
 <Zxj3xwDyP1j8Y1Ms@infradead.org> <Zxj4SDRxSJfca_Wa@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <Zxj4SDRxSJfca_Wa@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_074417_436789_8EB9F742 
X-CRM114-Status: GOOD (  17.69  )
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


On 2024/10/23 22:21, Keith Busch wrote:
> On Wed, Oct 23, 2024 at 06:19:03AM -0700, Christoph Hellwig wrote:
>> On Wed, Oct 23, 2024 at 07:14:20AM -0600, Keith Busch wrote:
>>> You can't just have a patch declare that PRACT works this way. The spec
>>> says it only works if ms == PI tuple size, otherwise it doesn't do
>>> anything.
>> Well, that means the patch as-is is broken, isn't it?
> That's what I've been saying since v1. For some reason that feedback
> isn't getting through...
Sorry for wasting your time and confusing but if you have a time please 
let me confirm again below. (It is okay when you have a time case.)
About the mention "The spec says it only works if ms == PI tuple size, 
otherwise it doesn't do anything." do you mention for example the 
specification description below?
--------------------------------------------------------------------------------
(NVM-Express-NVM-Command-Set-Specification-Revision-1.1-2024.08.05-Ratified)
5.3.2.1 Protection Information and Write Commands
Figure 166 provides some examples of the protection information 
processing that may occur as a side effect
of a Write command.
...
If the namespace is formatted with protection information and the PRACT 
bit is set to ‘1’, then:
...
2. If the namespace is formatted with Metadata Size greater than 
protection information size, then the
logical block data and the metadata are transferred from the host buffer 
to the controller. As the
metadata passes through the controller, the controller overwrites the 
protection information portion
of the metadata without checking the protection information portion 
regardless of PRCHK settings.
The logical block data and metadata are written to the NVM (i.e., the 
metadata field remains the
same size in the NVM and the host buffer). The location of the 
protection information within the
metadata is configured when the namespace is formatted (refer to the DPS 
field in Figure 114).
Figure 166: Write Command 16b Guard Protection Information Processing
...
[figure b]
b) MD>8 (e.g., 16), PI, PRACT=0: Metadata remains same size in NVM and 
host buffer
...
[figure d]
d) MD>8 (e.g., 16), PI, PRACT=1: Metadata remains same size in NVM and 
host buffer
--------------------------------------------------------------------------------
In the example case b) and d) the 16B MD data should be sent by the host 
application but the driver does not set or handle any 8MD and 8PI. Is 
this understanding correct?
By the way actually does the kernel nvme driver support the ms >= PI 
LBAF case as correct by the current implementation? (Seems only 
supported for the ms == PI LBAF case only.)
   Note: Only the function nvme_configure_metadata() checks the ms >= PI 
case to set PI type.


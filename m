Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D759AC25B79
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWV4yy/Z+cUw9UGHT49UYwgUTncAuMe482lXvoxuX6M=; b=Tt25R0m06PRaTn9nPbKKlXP7CO
	BCoJAUQq06oZdtU1KSkh4C9qCzw9eMqelZHXRgV6/5f17hpUbYe1EM8q+TYXQdKe1dYL38MBFPUtI
	LM1uIhlZjES4izgM7drWziLjVTFwfUKtFUwCwTpCiRsKzIzlEWG77+29+dsfDh7giGkqZrKRnlRR/
	miXOGheRxxFD+aPteJgQZu4BciGyXKnoBaeH5A/NT0eAMLIeE9CSTwMP/O6pAoVvPKVY9TVbTF+Rr
	RjWT0ACKvFVjN3jgc4USxY7018O70lmSapNldICtIGpI3VIpYPdOmVdWPyCc0Vpqzs+8vAyZbsl7V
	m+1xiZgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA85t-00000006J3G-1CvY;
	Thu, 23 May 2024 13:02:53 +0000
Received: from mail-lj1-f179.google.com ([209.85.208.179])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA85o-00000006J2Y-44go
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 13:02:51 +0000
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e1e8c880ffso13009311fa.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 06:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716469365; x=1717074165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWV4yy/Z+cUw9UGHT49UYwgUTncAuMe482lXvoxuX6M=;
        b=YE/rh8l2vnN9oi2JRz+hXP67lhtjvTiwCJPuEuBHg980kYpuhg64gI3RvDDYpw9+ED
         RFXBYFbvMaPgL771wQ6X0tby6Imi4/M3apaKfhjirqQPbBDc3tS4cm7XBTCFbKP9cuqx
         lPVYjcmgz1Qy9i8JEf5YClRo8bmkBHPC2b+WKPK4V6AdmqjPHn1yxYQojSv43G1pqnB/
         D1OblpmJ1hexAs3AHmf5328lQMNZP3cRNPTiq8Eltn0IZfXPQ5f0JI31Y20at9GvPQGS
         vFOK7uK955r9arDAEKmCv2CFxdFoBn6ot31e3LlsVjrvKltKhlr9OTdFlGfAS7cKmgZx
         dc8g==
X-Forwarded-Encrypted: i=1; AJvYcCUqnwlnWHgsGxlL4qM7T5T8zL/oZc2zVUFVu8x5Apc9oG0yZ+35YzGkV9MYJnidsSkeSGGf8KYwfZBuGnG7/fely6fgqO6sK69CfCoZQ4E=
X-Gm-Message-State: AOJu0YwJD9LUOl9xP4DkqtBs01W6BzwkWzbSCFg0ulP1OE510w8Etkv+
	lSUZHJeWgY/OTq3PdSbkLlMXTPasfcYKKr6Lo2utNz3r6BtPJKSs
X-Google-Smtp-Source: AGHT+IFIwc+sJigR8KtwBqIBqVNChDDu+Cl6XveSBY/EWWRi+IRasgvX/l4CxeZWYLGm98Q+0214/A==
X-Received: by 2002:a05:651c:1050:b0:2e2:714c:23d2 with SMTP id 38308e7fff4ca-2e94948f1a5mr36469541fa.1.1716469364858;
        Thu, 23 May 2024 06:02:44 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f55264sm24318075e9.21.2024.05.23.06.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 06:02:44 -0700 (PDT)
Message-ID: <4509c11d-b3ae-4be9-9904-5aaf2628f7f2@grimberg.me>
Date: Thu, 23 May 2024 16:02:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240522091534.472449-1-sagi@grimberg.me>
 <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm>
 <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com>
 <20240522162845.GA16783@lst.de>
 <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me>
 <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com>
 <20240523065412.GA29137@lst.de>
 <a643075c-a51a-413a-a0a0-7954049ad918@grimberg.me>
 <20240523123949.GA20758@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240523123949.GA20758@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_060249_044548_C77A3D85 
X-CRM114-Status: GOOD (  12.97  )
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



On 23/05/2024 15:39, Christoph Hellwig wrote:
> On Thu, May 23, 2024 at 01:04:13PM +0300, Sagi Grimberg wrote:
>>
>> On 23/05/2024 9:54, Christoph Hellwig wrote:
>>> On Wed, May 22, 2024 at 03:36:19PM -0600, Keith Busch wrote:
>>>> The below patch is what I'm messing with. I have a CMIC PCI NVMe and
>>>> nvme native multipathing enabled, and that can recreate the lockdep
>>>> splat 100% of the time. It goes away with this patch. Non-multipath
>>>> devices are harder to hit the lockdep splat for a different reason.
>>> I much prefer the srcu locking as it has real benefits as well over
>>> a global-ish rwsem.  I'll try to get to a real review in a bit.
>>>
>> Can you explain what are these benefits?
> No having a global lock taken for namespace lookups.

its a rw lock, not sure if its not a marginal value, especially given
the nature of sequences where we lookup ctrl namespaces.

I just want to have good testing before we touch these areas that
are all done in ctrl reset and error recovery which historically manifest
most of the issues...

and all this because lockdep complains on false-positives...

I'm not against addressing this, but we should be a bit more cautious...


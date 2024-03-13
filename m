Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63DFC54791
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0PME895sLJpChG/9LV689NgF95ULzwwJxEC48Fbhoq8=; b=RzWPfNaSWZd0zNmW+pw+uRYZ1W
	MOfCX1+KYRVbpC+98e45Uq5lbOafeeZ2PpB72zoau4APPpMv02Ef3a+plV33Q3+Z4axRawlv4pe2K
	etJIXzQmzvwEE5mnULzwMOCYEf40tV/3jQb5iyNzxu4EeLfeeOKco/SHfMtSN47n21nQtv7quULRB
	fjYCN8fGC2eFlLF34fejPfsDV8LZ+fbeOOMaAtRrcCYUQn9s9u5VE1OuhE7+HB9Ev5xzG4lTeYDxj
	/nmg5jqjHvl5mobjyIyJ5TBrNR/CykpACTip0m9Bh0Z0UK21DCa6iiNxyFcyDbxSbUc48Q5h8JpRX
	QQdLgNoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkLK2-00000009ZuC-3hNL;
	Wed, 13 Mar 2024 09:54:54 +0000
Received: from mail-lf1-f54.google.com ([209.85.167.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkLJz-00000009ZtX-2ESF
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 09:54:53 +0000
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513ca732deaso45441e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Mar 2024 02:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710323689; x=1710928489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PME895sLJpChG/9LV689NgF95ULzwwJxEC48Fbhoq8=;
        b=tUpA4dYqDTBcuZ/7jKErjX8p6qootItQd1fQNuz40cVtONAPhKVj5wJFqKASwLRPyK
         3Atg2wx1dwmYFtbcyd2I0yiKtrF1wYgsHSgX8+dre6ANir4ZMBD3BHODYdmryGmn+vx+
         /ZEJsCHMBjf6UXY2CHdWUVpGf7sfcYTZu83JCPCgcfHuhrhqxE4id8MTYrL6oD8/Mz+y
         ddkw5SxLgnyrvqCrn5eMpDwZPumRTXBELwAv8RzqTV0OFzmIhM/83s2CiJFqihghAhRd
         z3ink1wnMWaEd94NPptHEJ6p2GbDDmbmxdYRVgVvXhaNT3GWJstm6mFrh8wpd9L6rc90
         i9AA==
X-Forwarded-Encrypted: i=1; AJvYcCXs+yDBjlIOMmQ21Mbz1JKxUJERfbFb95HJi/3upiCWeRLZdLcZ1ve9kVzxc6GKx+F6C8pVy4L61wU52hbrESnwIpbWE1vGHcdLlAEpGtw=
X-Gm-Message-State: AOJu0YxlAmu4Gh1LOzXnN+cHJaILQ/1VYeqfNToI6qCy+JS20hJGQgNS
	5RCESpzoUnOk12IEoGUtmXPdhGlrDe3vUzSMDoSFDrHVHEJyCMfl
X-Google-Smtp-Source: AGHT+IHiM+WfV3EKpPpEnmLaxDxjgjPJ2e5ZEE7IoEwoZwKf9CKwfXb3y84PywtKpqcEDv+hftPjsA==
X-Received: by 2002:a19:434c:0:b0:512:bd32:ed55 with SMTP id m12-20020a19434c000000b00512bd32ed55mr764645lfj.4.1710323688809;
        Wed, 13 Mar 2024 02:54:48 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id y9-20020a056000108900b0033e206a0a7asm11305486wrw.26.2024.03.13.02.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 02:54:48 -0700 (PDT)
Message-ID: <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
Date: Wed, 13 Mar 2024 11:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: he-IL, en-US
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
 <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
 <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
 <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
 <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_025451_675105_2571773B 
X-CRM114-Status: GOOD (  18.27  )
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



On 13/03/2024 5:42, Guixin Liu wrote:
>
> 在 2024/3/13 05:31, Sagi Grimberg 写道:
>> So I understand from you that there is out-of-band mechanism for 
>> fence guarantee?
>>
>> In any event, Christoph reminded me that preempt and abort is 
>> mandatory, so we cannot
>> get away without doing it.
>>
> Agree.
>> I suggest to introduce a per-ns-per-controller percpuref, with an 
>> xarray that is rcu protected.
>
> I will implement it in v9, and I also think that we should a 
> time-limited wait.

If it is time-limited, and you didn't manage to wait, so you need to 
fail the preempt and abort
action (without DNR set so the reservation holder can retry if it 
chooses to).

>
>>
>> btw, I also think that reservations on nsid=0xffffffff should also 
>> work. IIRC there were at least
>> two use-cases that would have benefited from reservations on all 
>> subsystem namespaces.
>> It can also be a lot more lightweight to implement that (outside of 
>> conflicting reservations checks). 
>
> You mean one host can reserve all of namespaces by sending one 
> reservation command?

Yes. The use-case is to have the reservation in the subsystem level.
The spec seems to imply that this is a valid reservation request.

>
> Well, Could you please tell me which two use-cases?

Don't remember for sure, but IIRC I've seen people run oracle rac with 
all namespaces in the
nvmet subsystem is exposed to DB hosts, and there were many namespaces.

>
> I think this will make the target code too complicated, because the 
> reservation situation on each
>
> namespace may different, we should handle it one-by-one, and if failed 
> in middle, we should revert
>
> the handled namespaces.

Not sure why you'd assume that, this would be a subsystem-wide 
reservation, which should simply
cross-check individual namespace reservations for conflicts. Sure it 
adds complication, but I think implementing
it on every individual namespace is a naive implementation.


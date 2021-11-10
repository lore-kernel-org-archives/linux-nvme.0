Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0755EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 19:45:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBADF61106
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 19:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBADF61106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mE5lp/N1gFoUbv2yhkOGdLVDkCSb0CZ04SRNSNvolFA=; b=LD/ARH95vh/fPwi3zZQEjztwWC
	qgIMxfjaohoke3p4ojPCCBBWoUZdofYtdPFl/Ak4Tu/Z05ZUEjeclirML/eIwyb3lYqVbfIDRGq5i
	VvB5VkNqq2srVVH5IaldFsRg2AQDLhQiqBbC1fiHtM/fMRXEAoKuhBw7Et/TviCzTEsaeEIM/KyHA
	qtnzkuBuMKDhMCck0awqfp+xs8xNoonm7jlbmBaiL7RD3WBcpJz5vVAWdBltkMuotOmEYZd4Suf3i
	kwNTSJkYQ0dpxZzBnD0hPENvZo554KlZPA4kPvgUU94wG+c/y5pzY4gI8e5d7Fnm6/R0rY+B1mI9Q
	FRe+cOCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mktXB-006Bq9-PW; Wed, 10 Nov 2021 19:45:25 +0000
Received: from mail-qt1-f174.google.com ([209.85.160.174])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mktX8-006Bof-Lj
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 19:45:24 +0000
Received: by mail-qt1-f174.google.com with SMTP id n15so3270634qta.0
 for <linux-nvme@lists.infradead.org>; Wed, 10 Nov 2021 11:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mE5lp/N1gFoUbv2yhkOGdLVDkCSb0CZ04SRNSNvolFA=;
 b=kEjekGSEjEGS3CFgG0Fd7oP6iU+OogosODO7pymLPrmw1CNgVYirRPm60clRLsny31
 LsGVPopIyyAMCHVhC7fOuF8ZAYEIpIYNDxBUPMNmMpPYNfu8+s2lY4ijHKKX3/8Ewn99
 62f1pp4NoUO6loNueRr96/nkas+qdmhAjz59+zs7kgc7C08siVdOwyJtfLYzf8wyyTEO
 51Kff84+AXdoHDFFgTFpa34EE0J9IrXW2JyHl8nzo1YByndkWTfYY4oJIUU1LCKXl/bO
 T3Y/U5HoTaYFDU84zBpxgXYnSK2TR7ow3APb78gunWiGehuHlomGvSvABDREwHfXQ9ZE
 Gnyw==
X-Gm-Message-State: AOAM532KX7XhGSQmPJedF0NccBhifdmyMMqdYVyzcur5ZgY1nFouZAYH
 r9jyNnUjNJd8YEUlFKqMwcg=
X-Google-Smtp-Source: ABdhPJzJvRVqEN+qccrSws5gXxux0RDJJW5hZrPCexr0kCQv48OGZoH/DBzDWly1X7eQrOfAd3bGxQ==
X-Received: by 2002:a05:622a:1649:: with SMTP id
 y9mr1714606qtj.268.1636573520500; 
 Wed, 10 Nov 2021 11:45:20 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e61c:920d:94f8:8f26?
 ([2600:1700:65a0:78e0:e61c:920d:94f8:8f26])
 by smtp.gmail.com with ESMTPSA id n3sm396913qkp.112.2021.11.10.11.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Nov 2021 11:45:20 -0800 (PST)
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
To: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 chaitanyak@nvidia.com, oren@nvidia.com, benishay@nvidia.com,
 borisp@nvidia.com, aviadye@nvidia.com, idanb@nvidia.com, jsmart2021@gmail.com
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
 <20211109143102.GA25263@lst.de>
 <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
 <a70fd129-d69d-2905-c43b-41eae0b3b8f8@nvidia.com>
 <20211109190432.GA2661484@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e2d589ab-2457-a3c8-ba2a-9e4f813d9a72@grimberg.me>
Date: Wed, 10 Nov 2021 11:45:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211109190432.GA2661484@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_114522_758496_01729881 
X-CRM114-Status: GOOD (  26.70  )
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

Hey, sorry for the late chime here, ramping up on some emails.

>>>>>> Max, if you can't point us to a broken target (and yes, it is broken)
>>>>>> this will not go anywhere.
>>>>> Any target that uses Apple device as backend can be harmed.
>>>>>
>>>>> Most simple example is Linux PT target that copy the sqe as-is and passes
>>>>> it to the NVMe Apple drive.
>>>> Take another close look at how command_id are assigned my Linux driver.
>>>> We obviously do not pass it through as that would be completely broken.
>>> Also worth noting this driver has always defined the command id as a
>>> __u16, not __le16, yet we don't have any bug reports from big-endian
>>> hosts.
>>
>> Right, my bad. I thought that the pass-through target uses the same id.
>>
>> Linux PT target works fine.
>>
>> Bad example.
>>
>> Linux kernel world is covered but I still think we need to add this ability
>> for fabrics controllers as we did for pci controllers.
>>
>> There are a lot of vendors out there with their optimizations and solutions
>> and by adding some code to cover a broken TCP target (that no one said what
>> is this target and why nobody fixed it) by default that hurts others (even
>> if it's spec compliant) is not a good practice.

Completely disagree here. The TCP original report was just an example of
lack of protection we have against spurious completions. Nothing
specific about nvme-tcp here, this was discussed and agreed on in
the original report.

> Could you qualify the harm this caused? The command id is just an opaque
> cookie; the target should not do any interpretation on it, so this
> encoding should be inconsequential from the target's perspective.

Exactly, the command id is an opaque that is solely up to the host
discretion in terms of how to use it. It's pure coincidence that Linux
uses it for command indexes.

Any implementation that interprets command ids to _anything_ needs
a quirk, not the other way around.

> There are more hosts than just Linux that may encode id's with flags for
> driver use, so non-compliance here is just asking for trouble.

I know of at least one significant host implementation where command
ids are not indexes.

> If a vendor wants to constrain the command id for some vendor specific
> optimization, they should bring forth a TPar and fight it out in the
> workgroup.
> 
> We did get bug reports that not validating command id's will crash the
> kernel or corrupt data if an unexpected response is observed. Even
> though the incorrect id is not the kernel's fault, we generally strive
> for resilience against those types of observations in spite of
> potentially flaky hardware.

Agreed.


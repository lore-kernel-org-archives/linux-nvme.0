Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F99C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 16:08:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B874F60F5B
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 16:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B874F60F5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vTqcirYSr1i+q/bpd3wk16YI1xoAA+PgHF95M7UuRXY=; b=nUS6/AK0i8x7pKtt+vqD7PxOdm
	MV8Di5afW/xjwEBQFUxWg/j/lhWsN/gbz4m/pFyFi4vbc9vC4lFHskMTNe1N/pvwpyrRW+0RGEO3f
	fDs//AFR33Qll4WlqlqwnVJmL8VD3Rp7veOkdNhKG1ZNVIAnpyfQP+a5kA+YQjtDwb/7q8XyITGUx
	uR6LHFkviT/xbDQ8gpY74iW0TqkoCrFYmsFVMCw0S2p/OxyB/5fHiu5VtIU6XBHMJ0V1N1V6q38BM
	UaJLcx5oyaIPZQRHRHS6L+Ltn7CJ4ildcdeSxl3j9xFZ1JspLRIiLO173ekn4jfWHe65+P2IfC6MX
	NpxnUlzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlZ60-00BCXf-7O; Fri, 12 Nov 2021 16:08:08 +0000
Received: from mail-qk1-f179.google.com ([209.85.222.179])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlZ5y-00BCWv-7m
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 16:08:07 +0000
Received: by mail-qk1-f179.google.com with SMTP id de30so9605600qkb.0
 for <linux-nvme@lists.infradead.org>; Fri, 12 Nov 2021 08:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vTqcirYSr1i+q/bpd3wk16YI1xoAA+PgHF95M7UuRXY=;
 b=KMeFH8lcdut/friWx741mgF1apOCVAK5N9vb0GmWUu9xu2KVt3CpyzvumZBoM1JGCW
 RaJi5MFjmB019rdzbcMjZIf/RwVM1hLZAbRzFrZ9u0CMYoYpvc8Lgx8MoLGdzb8b2enU
 AN78d+GJTrC2e45oMMyVEYL7EUSbZ4Bnrk2TVO+umk3hhPAlRFV+JgkFO7p4XYjTJjQd
 vyb7O2mKj78QJCMRUjU+28WGb1aSn/JjrXy1+nACOyJqifvN4v1ZvLu7P/sjSveKHlcP
 5eDtpW2w6d4obVG0t5zq0hcUAvBnKg/aTZEUYjyCyLgaFdaXmsNfLWJXj/vsJSUQo5OG
 vXxA==
X-Gm-Message-State: AOAM531tFE/IYAvXxcLPs2Atr6Fr7QVZ4dN4XDZ21a538rXHfnJNug2h
 03S+xkYVVaHBIEUmiSJ7yHc=
X-Google-Smtp-Source: ABdhPJxZGGDcxllKaGgbvcOX/cEXrkQ4OlwFAGLXWXml1oonDLMv4lWrmty8WqKUSYEbT9sllbxtwA==
X-Received: by 2002:a37:9507:: with SMTP id x7mr13161566qkd.105.1636733284688; 
 Fri, 12 Nov 2021 08:08:04 -0800 (PST)
Received: from [192.168.4.254] ([72.166.42.242])
 by smtp.gmail.com with ESMTPSA id u27sm3555234qtc.58.2021.11.12.08.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Nov 2021 08:08:04 -0800 (PST)
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
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
 <e2d589ab-2457-a3c8-ba2a-9e4f813d9a72@grimberg.me>
 <fc27faf4-c876-ced5-c9cb-2d6730e07f2d@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <53205a07-1af6-38a5-c60c-ca7d12226202@grimberg.me>
Date: Fri, 12 Nov 2021 11:07:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fc27faf4-c876-ced5-c9cb-2d6730e07f2d@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_080806_315528_1024AD10 
X-CRM114-Status: GOOD (  27.13  )
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


>> Completely disagree here. The TCP original report was just an example of
>> lack of protection we have against spurious completions. Nothing
>> specific about nvme-tcp here, this was discussed and agreed on in
>> the original report.
>>
> You are ignoring the facts:
> 
> 1. The device that broke the spec in the first place was that device for 
> which caused you to add the gen bits to CID.

Correct.

> 2. These gen bits are causing the limit of 4K Q_depth.

Correct. Which should be more than enough.

> 3. It's not mention anywhere in the spec, and if it was intended to be 
> implemented like it's now - it would have mentioned in the spec.

As Keith mentioned, the spec doesn't define anything about how the host
should set the command id, hence it is free to do what it wants. The
spec doesn't need to say "the host can set the command id field however
it sees fit". See Keith comment on the field endianess.

> 4. Since gen bits were introduced, other devices got broken (such as 
> Apple), hence the quirk for PCI.
You mean it _exposed_ an already broken device. Yes, that is correct.

> 5. The gen bits adds "if" conditions and logic to the fast path for 
> "innosent" transports.

There is nothing transport specific about any of this, so I'm not sure
I understand what you are talking about.

> 6. This series just extends this quirk for fabrics.

I don't think the patchset got rejected, the ask afaict was to document
known broken controllers - exactly like pci quirks.

Here is the original question from Keith:
"Are there really fabrics targets behaving this way, or is this series
anticipating they might exist?"

I don't think there is any desire to keep any controller that got the
spec wrong in this particular case unusable.

> 7. Even if not broken, some devices may suffer from reduced performance 
> having CID space spanning all 16 possible bit - fact that we ignore

Not sure exactly what you mean here. Again, if the controller assumes
anything on how the host would populate the command id it is doing
something wrong. It's not a theoretical argument, this controller
already does not work with existing at least one host implementation.

So you are correct, we don't take it into consideration.


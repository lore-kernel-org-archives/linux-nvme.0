Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F74AC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:27:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200E665139
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200E665139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JuqZ8+UQAmgM2I7+MmE4p0YI1CFWLwGtjAAUIGC12js=; b=Qmbrt/PM267Jf1c3AbEeEF2p2
	x0JN/Ag2Ld464lyyyyWDgK11wsLY56yC055oVG93w9OIjf5oxyTVIn2P/dz/dOqky/aN0OqDYVH2N
	Gk3Tqv7CcrcX6fwGkqxWG4WfoW5CoJLfkzdD8hIepn8MqwIMmImDe71gRxD3GFPIeN8zOGMeyx7Xn
	18wh/uZ0hAKLuWyw0PVpGmkWBvhKY5frDMzEgTro2qqGYB+md5HW3Haexffa/zpgqaQxCake9aOxb
	RK8mRQA/siQgOHVpae5Axzpb3TN+lO05cpF26pUZrjj2wgLDBsRaW6qd4fTXScB4l8IZuNXFHiZ6L
	Is3t/MvrQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMEPf-001cFQ-VW; Tue, 16 Mar 2021 18:27:28 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMEPb-001cEY-Ey
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 18:27:25 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 mz6-20020a17090b3786b02900c16cb41d63so1898572pjb.2
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 11:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QSvD+3ZUQl19RMHTMuRQwdKRuzj95RLIxI8jS7Ci88Y=;
 b=g4goa8o+hbC0IbxN+yXfwDnjJ1D0VbrrwxAAVSYnE9rD4NqnWfTMDuD4E6mlGqD5JV
 Rf+dFDF+0TShYER9WU+YZUPkAk8A9mMqyRw2VrO2Gh9OIBL6Oza2Bk1h9yh8nrEFVy01
 +X9GDotbwT+kXWH9nYokaDqJUEwPlRBHCHXKD82cq6GOJuuaourm1fAMyZrKP5T7cARc
 /QFvj3IZzmCbSkH8a0TWPGrDcnQ9nP2NzEoxu2C0vCG1+qqyFf8aplMLGbTg+oD+XALU
 UWR/GUbTAc5OA5Bai3UHWEwW/nWkZgs1EtCIrO+Ue7dSE5otrQrLAs0kzrdQWbsVkNpp
 Cesg==
X-Gm-Message-State: AOAM5310oybkuOO8f1krYeUnAVI8CJeAOsLzjHZKT3DQqT52V1NFa/q+
 3p/6e5usLwQHP+VhkSnViug=
X-Google-Smtp-Source: ABdhPJxQVtxkEV+ZdTJYNsLpp08Jr5ULEN66mHyEI3Ss8AABOnLC7/oM4wBoeUW2fyL0SQtCEoe+VA==
X-Received: by 2002:a17:90a:ad87:: with SMTP id s7mr407296pjq.20.1615919242056; 
 Tue, 16 Mar 2021 11:27:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id f23sm17055780pfa.85.2021.03.16.11.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 11:27:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-pci: allocate nvme_command within driver pdu
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20210316170632.4161183-1-kbusch@kernel.org>
 <20210316180255.GA30086@lst.de>
 <20210316181354.GC4161119@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f1fea65d-2be1-dc87-5f64-116884f452e9@grimberg.me>
Date: Tue, 16 Mar 2021 11:27:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316181354.GC4161119@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_182723_794956_4EA8B3D5 
X-CRM114-Status: GOOD (  16.52  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> All the nvme transport drivers had allocated the nvme command within the
>>> driver's pdu except for pci. Align pci with everyone else and replace
>>> the stack variable with the pdu command.
>>
>> At some point in this series nvme_request.cmd should become the
>> actual structure instead of a pointer so that we can remove this
>> indiretion.  I'd be tempted to just do this in the initial patch,
>> but I'm fine with any kind of patch ordering.
> 
> I tried to start off in that direction, but had some trouble. All the
> fabrics drivers embed their preallocated command within a larger
> protocol specific payload, so we either need the indirection or have a
> copy of the command.

Yes, tcp and fc have headers that prepend the command so its better
for them to have cmd+header allocated together.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

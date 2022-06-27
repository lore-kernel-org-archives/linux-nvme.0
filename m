Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C78FC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 11:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uE+eulmFH4z0hsd2nrT7zhmC8xpNv65029v4FW+nlt4=; b=DWULMbwlzLAsnveMSmeOQZKKKs
	VtGCy6AlDGJINAqkL7/VmAo1w/+r7Pa5jTFeA7vAxwbt9W+/bOHPkZJaWFIgAnmls61TLjiNAkD31
	ElLD0ICfK+4IDFKSfK6kiCkhSOamuAQUbVB+0YamOvs6QEJdfUkEjgJcavRKJ2Ea8E26Ls22QDKBC
	UNIzyt2UlNrlc7pC7rJLHRKsQQhUFFGzWi9ymO9UklTAWW/aB1pcjmiiZlBSkS6h3vYNWKiypvRUK
	q1dan8n95+0TuK7t3WIQzUiVJwoio0fWoN0mvPzZQi1j34hu4+XAWR7SiL6rBLdUzKjWOMjUvLnff
	rTczLLLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5mxu-000WV5-S9; Mon, 27 Jun 2022 11:31:38 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5mxr-000WRg-Nn
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 11:31:37 +0000
Received: by mail-wr1-f47.google.com with SMTP id o4so8656769wrh.3
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jun 2022 04:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uE+eulmFH4z0hsd2nrT7zhmC8xpNv65029v4FW+nlt4=;
        b=e8u5Yr/ehXhJuFvQEISsHqeDcB4LQKL1xjWkqCggrgOdqZbvoEzJd+mNr6MVOXVM7y
         vcWAEnLUDI0Y8MVApMnDjshG5GoC+9ep7rqk4WKYRXEcwELxvmPl6xNQC5g9SnJ5tp5y
         NJiJkAbGh6RLzg9o3AY0xSfKsPLosQllLh5s7ZIlCm6xKyGwaNnsDpjM2ht3PyWZrWoQ
         bZWTSQs2hMp8IMJpXF/PiLXKXVnez4NQGgmun8lTY+RYQtPGeCBp+HA6yxydjRrG5/+Z
         2yB2fMiH2cRivRDl4o5QQbIzPqkcPr1V/I6dRIgnC1jZVpmPwU8JpyKCdHNxJIYKViz1
         AUOQ==
X-Gm-Message-State: AJIora9y2QLmWfJ/fwefigM79STcs28R6rTbkBF/wkIXW6u+XOngO9HD
	jPcspCSt3xAVIhgoVvJGwcQ=
X-Google-Smtp-Source: AGRyM1t2eZcJPac+M5OY5dG0orxBzMOyDpYJyZlf8y9V45T3d8uOglG95cbXRw4NLx9EXnq9EJUs/w==
X-Received: by 2002:adf:d213:0:b0:21b:8b4a:24be with SMTP id j19-20020adfd213000000b0021b8b4a24bemr11623410wrh.234.1656329492893;
        Mon, 27 Jun 2022 04:31:32 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b0020c5253d8fcsm12129505wrx.72.2022.06.27.04.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 04:31:32 -0700 (PDT)
Message-ID: <7d8f7f85-9984-14eb-e16b-b3abc15312af@grimberg.me>
Date: Mon, 27 Jun 2022 14:31:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH nvme-cli] udev: re-read the discovery log page when a
 discovery controller reconnected
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20220627080650.108936-1-sagi@grimberg.me>
 <20220627090255.5vpqvzcd7l2vjja2@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220627090255.5vpqvzcd7l2vjja2@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_043135_864279_EECD619E 
X-CRM114-Status: GOOD (  15.26  )
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


>> When using persistent discovery controllers, if the discovery
>> controller loses connectivity and manage to reconnect after a while,
>> we need to retrieve again the discovery log page in order to learn
>> about possible changes that may have occurred during this time as
>> discovery log change events were lost.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
>> index 434cc080ffe3..245e0d0dbad0 100644
>> --- a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
>> +++ b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
>> @@ -17,3 +17,10 @@ ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_AEN}=="0x70f002",\
>>   ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
>>     ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
>>     RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=none\t--transport=fc\t--traddr=$env{NVMEFC_TRADDR}\t--trsvcid=none\t--host-traddr=$env{NVMEFC_HOST_TRADDR}.service"
>> +
>> +# A discovery controller just (re)connected, re-read the discovery log change to
>> +# check if there were any changes since it was last connected.
>> +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="connected", ATTR{cntrltype}=="discovery", \
>> +  ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
>> +  ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
>> +  RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=$kernel\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"
> 
> Stupid question, but when we issue the initial 'nvme discover' wouldn't
> we run this rule as well? And if so, is this okay?

It will... and it is redundant, but don't think its a big deal because 
at worst we retrieve the log page and try to connect twice, one of these
will see EALREADY...


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A716E810D2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfUzzZbBrD0qcgN+R23UDIWkaz3NIlPBS+ysBbpjsRM=; b=czOVdmTQNRAIELjJnsVVUHdCvh
	rYi0NlvbrjsjkPUMIDjO4DPpaCIerqUHVSSnCGFdk8JARXgW3pTF43WKasQGvBFbNIv6cZc7EFvj3
	EIBGRurWYWXqVkgZLFjRpW7PsKxGMuM86bC35TQgvha18K4CLiCyFCjqy2jqdrOAXlUhTrutWJ15A
	RgBwdVceL1S7pUknPESXofFKtkR98f5EAHPmHzPGONRpmyIWa/ULu2+Yoi+cD5Jh6anMB2ob9fJIE
	9nIy3+ivtC9ssldyxxJlEs+f5k+niFrVaybTxEpin/18liI3tPSgvGj57S6e3N7b5Vab31qrMfx3K
	PgHC69Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSlY-000oHy-1a;
	Wed, 27 Sep 2023 11:31:40 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSlV-000oHX-0Y
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 11:31:38 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3232bb059d3so1134930f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695814294; x=1696419094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfUzzZbBrD0qcgN+R23UDIWkaz3NIlPBS+ysBbpjsRM=;
        b=YEmnb/m3suvARlPyB2vuHbbMk6fyQZOd8LnDkZ+OHd4vS7aRo8ZATFeq4+/9xBRzbL
         ZYBtMhpDiy+t82iCokO5YaKeMlVUXEGuR8IIRCFDJK5rMuVhpxFmcSgd3zf//07zoWd8
         oinjXD4aru4S7QRJJCWpzZd7elpAeyCSCJLl5frbJOgcweKMDXSY5hXRHpnat4PCIP74
         E3RQvyGVZSsevMd/8doRQ/vsdyTZV1cnzBq1HKyc0DuBap6bZhZvbqPCDi/05rSUWdTW
         xTqKkH5xDMnclQ5YATo06uCgYI3eMGHDUSLJQTJ4YH4zjJttHCIzTGXkYIkDKK2TcYUc
         6A5g==
X-Gm-Message-State: AOJu0Yz9VAW1GrK5FkWCN3lBZBvDdWj+e3Q0P0sGBz0OOPtC8P68oq0s
	gNMlLl+g1op8n6Z6xzRcspA=
X-Google-Smtp-Source: AGHT+IFgIEtCHGc03HwLyKu5gtnc+Y+uGriL6ShTTp/qmqyumV5lbiphPFPfyRhfKuAMpy9kOfs8dg==
X-Received: by 2002:adf:fc4f:0:b0:317:5f08:32a3 with SMTP id e15-20020adffc4f000000b003175f0832a3mr1284422wrs.6.1695814294201;
        Wed, 27 Sep 2023 04:31:34 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s7-20020adfea87000000b0030ada01ca78sm16812551wrm.10.2023.09.27.04.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 04:31:33 -0700 (PDT)
Message-ID: <c6c4cbab-9f03-f7f2-6985-c627f2aaece8@grimberg.me>
Date: Wed, 27 Sep 2023 14:31:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] nvme-multipath: add "use_nonoptimized" module option
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, "Ewan D. Milne" <emilne@redhat.com>,
 linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-4-emilne@redhat.com>
 <5df9a1f8-fb2d-4819-88a8-a3f3c32cdab5@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5df9a1f8-fb2d-4819-88a8-a3f3c32cdab5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_043137_226230_3C0DC452 
X-CRM114-Status: GOOD (  16.31  )
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


>> Setting nvme_core.use_nonoptimized=true will cause the path
>> selector to treat optimized and nonoptimized paths equally.
>>
>> This is because although an NVMe fabrics target device may report
>> an unoptimized ANA state, it is possible that other factors such
>> as fabric latency are a large factor in the I/O service time.  And,
>> throughput may improve overall if nonoptimized ports are also used.
>>
>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
>> ---
>>   drivers/nvme/host/multipath.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
> No. Please don't.
> 
> There's a reason why controllers specify paths as 'active/optimized' or 
> 'active/non-optimized'. If they had wanted us to use all paths they 
> would have put them into the same group.
> They tend to get very unhappy if you start using them at the same time.
> (Triggering failover etc.)

I have to agree here. This is effectively a modparam that says
all paths are optimized regardless of what the controller reports.

While I do acknowledge that there may be some merit to use non-optimized
paths as well, but its almost impossible to know some latent optimum
path distribution. Hence the host forfeits even attempting.

If the controller wants all path used, it should make all paths
optimized and the host can examine QD accumulating on some paths
vs others.


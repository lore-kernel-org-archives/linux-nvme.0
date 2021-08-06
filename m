Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F6CC4338F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:37:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC2A61167
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DAC2A61167
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=qz8Gn/TefY6siTC8boxrOZ8Eon
	pFX/NYTSdhZTvTPoOYQWsvQPmYsRgpV5yuNSm77cfvbLhoqHZdzx2OFfZyrhSv36vqsAgjckdPGgM
	RdfkN12B8du6XxlDYupLq3AFyK8YdaTC1oV1kIStICS1tQfnRNxa0fwuxI1gQp0aSADo60wN3Yoy9
	deiFhsDQ4zypUOO8aocm3dRVuWYIBs5QciEhaRi4fF0UsAasqcU3Z9l/UKTULWP6CToDB8T5xpLq0
	j77JgdbtKT54z+sDsKUyU8jL/+Nz2epYQZlphV1rgstIEJO+lUt64GzaDMJnBOYY7R5PtmaTiDMa9
	SH3RzfLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC5ev-00DK1C-L5; Fri, 06 Aug 2021 19:37:33 +0000
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC5et-00DK0X-Dx
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 19:37:32 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 o44-20020a17090a0a2fb0290176ca3e5a2fso19473696pjo.1
 for <linux-nvme@lists.infradead.org>; Fri, 06 Aug 2021 12:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=IgKc4EXkw4tU25GrzZ4NbiDXCoBlyIqyiwv9WWYf03KLuDqrqFw1TEC3jV67m31cQI
 uX+vEsHSZGAFAPwIWTSWwvNIaFxuLneDIq8zBmQ5m4TzXSpiVqEoa3H88AhrkvQCTH71
 wIkLo1ID2yqZvSS1rXVxmQYzTp42v0tuoysOb1XAbu6+Go5GDcoLbZUY/u0xgfe4OfaE
 RK+qjCrU+zE9aENRhHy0B1l9dnj1VBaTlhyuueR1oW0r8DFqU3ZCf4dCMo3LZWtRP7Qy
 /rEaER19bSWoCGGPvXCHnKVwc2l3nswazfF0hprEo2gNaH5UuKMh4xp89PuK/ech75u+
 GnwQ==
X-Gm-Message-State: AOAM532Yofc/ZiNm0mDpdULNhNdXBqSQIhowja6e4u6YeMSdHQ+VQMWq
 WsB3iFSd6s+DPFISkr8wLRw=
X-Google-Smtp-Source: ABdhPJwfetuwpDkagI4u46pE+jG/I1eEKzQsCToNvNTkgraKUrQzZjUvJpakyzzMXUb5+PrCqVMDCw==
X-Received: by 2002:aa7:860e:0:b029:3bd:7e49:7a14 with SMTP id
 p14-20020aa7860e0000b02903bd7e497a14mr12488372pfn.40.1628278650381; 
 Fri, 06 Aug 2021 12:37:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7?
 ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
 by smtp.gmail.com with ESMTPSA id d22sm12589016pgi.73.2021.08.06.12.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 12:37:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme: allow user toggling hmb usage
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: kai.heng.feng@canonical.com
References: <20210727164044.2285364-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <acef176a-b541-47cb-a175-f5f76c41d3b6@grimberg.me>
Date: Fri, 6 Aug 2021 12:37:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727164044.2285364-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_123731_505504_B3ED7F41 
X-CRM114-Status: UNSURE (   8.09  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

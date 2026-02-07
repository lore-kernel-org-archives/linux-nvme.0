Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB35EE0AE0
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 13:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICk9ju2yutBKU4OY66W6DWt0U+hbrJeOlR3Ai3PGRhc=; b=e/kmx5yDPYGXCuP0fx8BUAh29E
	+uNEvppGkw7HoI2xclqQtxRXCIq5qEB970sPnlgmfDz4g07XgaloH2hswqhhb8M60DXCDTBFGbhAc
	n5QKbKjf99+WpyQUvnmtNLS07pOYxjW15eHMLXZCLy+4hJFTElA8dSYDfnA9AepSIU4WPKhhIaIwu
	AcqRcgTI9QA2FfZh1UOkXAspTTvlnTcY0JjKeDEvZtCUTlvSCjl9v7r5ycjiDlJu4RVmqU6ek7se5
	FjDn2E2vCOE1EPLDRtAOaXg+J1I5WxQFktvb31vsBW5yUDjOllGK5yN+TufAOTznTwPfyvAEXrQTK
	WkJSBntw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiRl-0000000CUHW-2eWx;
	Sat, 07 Feb 2026 13:34:01 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiRi-0000000CUH6-1Klq
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 13:33:59 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso574935e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 05:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770471236; x=1771076036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICk9ju2yutBKU4OY66W6DWt0U+hbrJeOlR3Ai3PGRhc=;
        b=V/Q+SbCPuAR571J5hgnQTEfcq4H+xiRN9+gv3Lru1jV5dfjBfuH3xcl9o4O+HTJyF8
         RzTXsJzMel4pN3idhu/Ge/noeIAjVPjldvtGzj5Pod+P1OGV3RjPZ0h/cft1BXPzdnB0
         210Ju0DFL6GgcpdTkrh7Pe/JViobi9CnklxgGaqjak6GvNru46DDl4K4P3hqEefCcbhj
         GLvgBxs4T5K0Inu/OF3TLiNtdAJi/BAzzzoBif21GZxkzsRDjZ3FpWSHpDhSCfxcDG2v
         1ikucQ0dLMI7itmr0IgccGwtSIRgy3gNjl24WXUi1l1g4tWaatFp8lHfc0UbBvd3J4gI
         1Cuw==
X-Forwarded-Encrypted: i=1; AJvYcCX4L1Gqgb0zGw56j9Yk36Pumy5c1YwieJ2NqsgQFbnxBJBJGNcsVYt0lh8aOL+58NUAiNXpmKwDc33o@lists.infradead.org
X-Gm-Message-State: AOJu0YytWfMs4amQvCkhlJdb40SaRP1qtmBsQAVHjKizkW0Dtw1UX8nz
	XF496uRTDekD2l2JXvMWnl7rVr0gSQ3XqNkrHgn0JRIH+Q5+h/IuF+et
X-Gm-Gg: AZuq6aKhARigFvaHbOcjbbUz/PyBO/WkXighjR386pPMZD7iKySrhRtBCebrUoN8r6a
	Xq6ndjHrSM81LOWHIVRQZrIk70XDUnpK4B7sHaGjVUX62XjuuklMg/44RYv5UmuOQb4aAhICMyc
	K7B8J9frJ22UuczTnOx81vw1ujWPnx/hJ4pRli7gH0kDLA4klvrpDBdOSFfenhduqmoSNnDqyN/
	fgEppvqwVTPbDMGX5zpSrX8V3/VkchyTD+vSgJMZZBETxe2aN868Klah04D1dgWmdNkZ7/US7vn
	yafOvRsarLIl6O+a0Jo0Zz2AKWLmwuXIoWPiGjOJKKZoFeBmZ9hkEhWjHw4jodfli4JLV/V4kMl
	AnU4Mk1E+7sz5IELwHiGFdC6i1hzZ+5Cwtf+9jU7KvgPFqVQUbuf08yDRZJHpbIgpvJaVjClD/j
	bs4hNcQgxFh2w3+15d22r8M7kU5eBlvWO6xAcIk/7Ds3w=
X-Received: by 2002:a05:600c:4e48:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-483201e5913mr83935955e9.13.1770471236037;
        Sat, 07 Feb 2026 05:33:56 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320719b8fsm123657865e9.9.2026.02.07.05.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 05:33:55 -0800 (PST)
Message-ID: <7d73bff7-96eb-4d94-b9c7-3d3271ce144b@grimberg.me>
Date: Sat, 7 Feb 2026 15:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/7] nvme: export I/O requeue count when no path is
 available via sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, hare@suse.de,
 dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260205124810.682559-1-nilay@linux.ibm.com>
 <20260205124810.682559-5-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260205124810.682559-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_053358_365283_FA8F5CC6 
X-CRM114-Status: GOOD (  11.81  )
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


> When the NVMe namespace head determines that there is no currently
> available path to handle I/O (for example, while a controller is
> resetting/connecting or due to a transient link failure), incoming
> I/Os are added to the requeue list.
>
> Currently, there is no visibility into how many I/Os have been requeued
> in this situation. Add a new sysfs counter, requeue_no_available_path,
> to expose the number of I/Os that were requeued due to the absence of
> an available path.
>
> This statistic can help users understand I/O slowdowns or stalls caused
> by temporary path unavailability, and can be consumed by monitoring
> tools such as nvme-top for real-time observability.

Other than the debugfs comment, would it make sense to have a reset
functionality to these files (via write to the file)?

Other than that, patch makes sense to me.


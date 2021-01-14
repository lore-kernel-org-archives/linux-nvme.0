Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8663BC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:08:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE370235F8
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE370235F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=iLt6AyjJFsevvk19t00swzon0
	ooVDX1WT+LSaHmiBkuEBfUknTAPeNS8t6XPczKZmFU1++Zi0JyKHLqcRI1JjfFOxPfl5nvhQ7earF
	EXmEG6KpqmJ3Ifu59wXbGnLAG8Kr+tbmybZGl9C3KT3yz0bjORmHkbW8gF7HmWttQt6S+JUOzrncp
	uWo1toMs0XS5KFr6vEI3azhs38M23jfmwaAjWth2b4DI6yqf7grLG5zc9m/144elbG/AU2+5elaDK
	76KiCcm9klKaCUeQebllMk2L7u1/eG8/U73PY7ga/BEFopfyEZx5q5JMKGqLdJPfHqi4VLzOm1pvV
	7NrQeySlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzs2b-00020W-Jx; Thu, 14 Jan 2021 02:07:13 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzs2Q-0001tm-17
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 02:07:02 +0000
Received: by mail-wr1-f53.google.com with SMTP id y17so4137439wrr.10
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 18:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=prAexCQ8OAVrN9HAnPYKR0Ax6sXOLI/CHr+FhKtXxeHe/68l3DiyoWP3Ezdk5/tZOx
 ZWIbitSOJCFFBfSt+R5834km5357GGrh4uDuwVT5dRaD1AgBepkE0XHy+/9hTDSJRcXG
 Ivzgw8V0K2IDu0n83sc6NNjOmGonQc5TR8ictDbmI6st/OpEwtMUsShwKI4KY86Hwg70
 0nfTPvKSdOIG8QZCXFYLn5/6QIKNMoMhlvGCRuMXYmtb67fhxcL7gfs+7mPnC3WjMvTL
 TivtJIOpTiKDgP/rOs9PdwwZV6s2iBsvq1XJJ+g4J7qOucSRLuYP0vsOdkvVx7sLrIw5
 cnbg==
X-Gm-Message-State: AOAM533Ws/G9QFzppjYfH3ks/5dOBsxnI4jQAKIfMx3KieASeV+Ekg7q
 qqAvuxMwdmNc3BwyOXCP3hk=
X-Google-Smtp-Source: ABdhPJzglXTRJ8EZ8JI6gRRjmi1K2rU6I1dcjiWCdEiELcpPQDsM+aiCLJ5KQe+3EZyq0kH9EWiw0g==
X-Received: by 2002:adf:a29d:: with SMTP id s29mr5279728wra.272.1610590020578; 
 Wed, 13 Jan 2021 18:07:00 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id v11sm6215929wrt.25.2021.01.13.18.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 18:07:00 -0800 (PST)
Subject: Re: [PATCH V4 1/4] nvmet: set right status on error in id-ns handler
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
 <20210114013354.33946-2-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3d1c0f3f-f303-4a5a-a2c6-72ca11ca6a5f@grimberg.me>
Date: Wed, 13 Jan 2021 18:06:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114013354.33946-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_210702_101648_256CD4F5 
X-CRM114-Status: UNSURE (   9.25  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BD3C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:23:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256AB64E83
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256AB64E83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=JUh2pfVzSBeu0fTeDt5YaP8Vs
	rp2wLfZ4RcIgvbufhGW7ZGXQvU5lM8dN+isnIGqZjhe8Fmx9jmXkgy6wH/V9PuwcuQM35S6usl2/P
	64NK/ubUhGgyD7WKPGIirAMWnpttxgH8lL9EtAD8hQXg2Sxq6q6P6bgUwBVcbPlKQcPYlfzZh9FLQ
	z5az/wFZRtFY5+v+SGOat7PVUYQ0uikkLB/VTOwt5YXlivDz7dOCsDwj3HZ6d0fseCA4vDyz+GQxf
	1OlJY/l3UxHLPFExzV1pbOJ9m98jdaDbB2Uuroh5etvQeD5Vk1ClM32izGk1JPh6EX7m884tGyWqK
	MH3C8l94w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLqvm-00GV4Q-Gm; Mon, 15 Mar 2021 17:23:02 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLqve-00GV3d-RJ
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:22:57 +0000
Received: by mail-pf1-f176.google.com with SMTP id t85so6993758pfc.13
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=LPvtOtg/DZFfTkVtjmUJ9LpULDQkcJg8X+CyMZRfGcu6aq/B/TGPYGYf1xuBKOLknV
 yE3ouZ1/XzFf3plCOpQ/IL27J9eynqUqS7i7gkjsDGPvGWhqks0qk49S38UIxPq5r1S5
 tsQdSjis8j1AbWFRJa5m/fl1BRRPyuKx1vyZ2hRjBEjOSRJF5XRAf0ch6QXV5AexfnoF
 h9HikpdXin13sdjuZWHzl+dWWVpZxlKF+mowtPUr7RJo/klo1J2gsT7qkFCFunD8yTIe
 NG/avzLRuxG8AKiqcZEcpMk02eU25NybfEHbclsgypWW1QvCEwJdqj1oWRyzEZNacATb
 yLUQ==
X-Gm-Message-State: AOAM533ud7OyKHcorjlE87D5FRNC0l27m7i+ygd2E7EQ9782OF632q+j
 ptZd7Ewswy8yvG+sBqp3uZ8CrEeH31o=
X-Google-Smtp-Source: ABdhPJwnyZft0n9TxcY14zLUsRLQFzRWYyMVXTUHRH47MEDHjS7tTsbjmeMbuptWJerPCwycP8frOg==
X-Received: by 2002:aa7:8d8a:0:b029:1f8:aa27:7203 with SMTP id
 i10-20020aa78d8a0000b02901f8aa277203mr11287402pfr.64.1615828972689; 
 Mon, 15 Mar 2021 10:22:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id u24sm14482263pfm.214.2021.03.15.10.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:22:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: add 'kato' sysfs attribute
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210311103727.47381-1-hare@suse.de>
 <20210311103727.47381-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1c3c649f-22c0-0602-ccc3-49db2bb04943@grimberg.me>
Date: Mon, 15 Mar 2021 10:22:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311103727.47381-3-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_172255_370514_AEFBB674 
X-CRM114-Status: UNSURE (   9.20  )
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

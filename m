Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F153C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:39:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F66664FE9
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F66664FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=K15lmfO7Fuc54ykydBs4Ebl+K
	jlrjtemWYkEYFb9BMRC+ar9fJK92tYiyP6Phn84GYoOaZ1YiIzgOycJ26E1Ke72GCvk2gv6GqY0Nr
	sTUD6guTPgkzARUjRWwsY4uWz8X7zuVKpJxqF3g1BrJ44AC+PGyAWesn6fhz0NNufA6nRDYW0Y/HF
	srxxTLFZ7zgR2Av9WQ8RictcKcyOUxfM+JV58pWY/1ncZKh/NRqdm5sQ5CwihHOnSqloivhlgrPIs
	blyanC3roq3REDSi6QwbCV9jpiinohajONYkRCB5l5uYNNM22YK7622Jq/H8xHhlO49Y8wXRuX27a
	qUt0NCNJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIHDn-00GPIZ-A5; Fri, 05 Mar 2021 20:38:52 +0000
Received: from mail-oi1-f173.google.com ([209.85.167.173])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIHDf-00GPG2-Ij
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 20:38:46 +0000
Received: by mail-oi1-f173.google.com with SMTP id z126so3919620oiz.6
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 12:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=le4E4A1XPqGsj6erIm2DyOppoQS35inv0slCpn8Lvh5rT4eVfqSpmoIyOoYsMhDzUK
 F40d68D0KZ+L6vFBThfhoQt72Uyz1DAlDHUT9XjLcEpkoUJVoO8huoyY5XJ+MeTarULr
 ho9GLeT6qz4bbpM21y2AXUVPAvHFlOlRyxlT4LnorAGci1h7oHxHNinLPJXZr4iQGycU
 wG+Zau4yoDmaQhSTS9oW+RCsWn3zNbYabtZ0BA/U9PgYe2pdkPruK6plngdHXxy6qHvJ
 zhVgHvETsC0etp0EnxgGX1unG1XQC1z36WyA0CJvSbRGBUIMflHUROO/PnXMOczDfn+c
 g+4A==
X-Gm-Message-State: AOAM5314aave9mXClhv0SfC5evnS9bSf7X1i2ZpmN/pX5S4exffWq90o
 EvFl61yjjpAxjHwIHsnEva4Ee8U1D94=
X-Google-Smtp-Source: ABdhPJy3CjoHM6kca+b+yMlNXMVyNKj8EKlbyKMfYEqqF0Tk65SCa4yGJE2tQMjgeEZw4zEKBYdxRg==
X-Received: by 2002:aca:de82:: with SMTP id v124mr8504480oig.125.1614976717825; 
 Fri, 05 Mar 2021 12:38:37 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id f44sm849750otf.7.2021.03.05.12.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 12:38:37 -0800 (PST)
Subject: Re: [PATCH 3/3] nvme: add 'kato' sysfs attribute
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9e0be6b5-e586-8629-6e30-632e17115b25@grimberg.me>
Date: Fri, 5 Mar 2021 12:38:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302092644.80701-4-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_203843_973909_4AA87F6C 
X-CRM114-Status: UNSURE (   9.45  )
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

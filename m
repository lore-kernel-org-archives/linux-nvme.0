Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC094C43461
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9C3206CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yqHjZjxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9C3206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nwwq7NwPo5HU5aQKlN5U0AQ88Dc9Ci1RTXb2EyDPW8o=; b=yqHjZjxzTsf3TqQ5GNoBgy8jc
	AfK91Kvm3wJTMZhXp974p6uH3hukjm7TZvyoPxNsmbuTq0mwWGitfuImXOI5t3yB8jmvsFXQzx2Zf
	B4tKtiGrjPYp6EZcMfXyADVsj8FQQZpxuMf9NOzRX6jm6C0aKjQcd1IwN4zcroRxSKVT/3WXZ3nde
	hHEmVokhdk8+PCpTz0pP2oFT7YY0/814+utepogyeNtZa86byHlLIIq/n3EtItZ1IStBawYPbyghm
	eXtAI4eY5DmM2BGkLlREORqpn8orNVpQNaBRLN70oQ39Q6gBWAy9QuWdbQD+JhFWKY/mKggu+SSk2
	16PljsRKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDwlQ-0007vt-FW; Thu, 03 Sep 2020 21:27:24 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDwl4-0007l1-3a
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 21:27:02 +0000
Received: by mail-wm1-f68.google.com with SMTP id o21so4267806wmc.0
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 14:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pq9FbpKw9X8R9GcMttew4n3AyXMm5oblTqWpcw0Oack=;
 b=hMeKG3n9q7h5Waleux2mzkcNHhCy9o12RApd7XBOzJcCZOWxZDlS2XEDE8D3UhLJNz
 OfMnQzucsnHO32Y+aAUlNVoVlhSVJAlZkBxjqQvKDi+Jyb3Lel9xwEDmrVfR1iFr/EM7
 G1jDSNGeNV3V/qc6pu/1QqOFAyuYSovYRrwSHy+3rINxNT/UFxyKiqXSuwL9mGSjzQ18
 RDUC3ME0911mvp01qf0MEN7SjoKX4Nl8Wj8CF580wkckkntjHxW5QtSUVKP/kQ9iJXqG
 upalOIDlEYOvoHvoCMvuYEykQj7U1bL29MKnEfklUItcO9ziPGVopLMWOq041oW8qmHr
 rp7g==
X-Gm-Message-State: AOAM533xmHxRKUqBL/oO1nzT40OXMThzFhmzMYK00XiHs9GIeeTDBrQi
 GiXgjgpekuu5b8xGTOE8D7o=
X-Google-Smtp-Source: ABdhPJwarxUd9z5Q6nXH7QOzO2DKyJIEJkGcwNO3SpqXxgDjZtz2aqO1IsQn313aBkIxJekJf7WVOw==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr4291569wmb.173.1599168421219; 
 Thu, 03 Sep 2020 14:27:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:79a5:e112:bd7c:4b29?
 ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id i26sm6863015wmb.17.2020.09.03.14.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 14:27:00 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] nvme: cancel async events before freeing event
 struct
To: David Milburn <dmilburn@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, james.smart@broadcom.com
References: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4a221e69-3a8b-6eec-eb3a-b37bb5a01481@grimberg.me>
Date: Thu, 3 Sep 2020 14:26:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_172702_208025_5C8154E5 
X-CRM114-Status: GOOD (  10.22  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For the series:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

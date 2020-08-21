Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B093C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 00:28:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289162076E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 00:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2LXQDhp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289162076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SKxehP+vZMDLVF0PuQCIMnbS4bM91Ir2L+naKCDpG58=; b=2LXQDhp4vkIWbJB57hFFAEgw1
	7uXj+93cnUdua/8buYiEkGX++kIVRC/4vGWb2p4QV1408aDTwnYVvrrmsL3z9NEI5YYZM7lesyrUH
	PIxvw/u49mV1azIsH7csuK5JwbD+9cUHWyQ9h+qmuv4uqQxUKq6eQm73cpQcK1mNrku5mVZXHNtBC
	rEnemQ1MqW0OFWwSzwP2BgYx+vk1PnFx0xe28WeZY5c5Bz7YijP/kltx0a0jmI4v6OHHRiSPIUvJJ
	0Jo0wpAkQKkG4WjnWzModOj4gWAFQvQQGVR4kKOHdNmQXqUgquYx+Y+zljWRr3+Bi04EuMrIajri+
	QVZFY6bgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8uv4-0001Ym-BP; Fri, 21 Aug 2020 00:28:34 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8uv2-0001YG-7s
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 00:28:33 +0000
Received: by mail-wm1-f65.google.com with SMTP id 9so174607wmj.5
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 17:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W5JFMLxD715Af+tLtiiQJstFKOydbczVj8UTFRmCq8c=;
 b=Buw3JBY1VOOICibE26dXxIMrnPL40Zvw5kRxMUHCgj95fyDwh3SJWPvQFO6dsuYUsB
 6HxQ4ihsarezrm9t//06PrkcItRiq9sEbW9gZpZl1uqP8yO1lAWdnKM5nW9weMhRAnCp
 gwEio6jdRPxtoh1NAM/BAmyiSH+7Zy9RbWfLmpzOj8O22ck7oSC6vl1hKh6dOs1chvZ4
 ndFSohsDzgLcdY3MstGos6QVY1XeaifgvVaJzsbFILGH/AJb1mqk0aTDWzSBTD1wR1zc
 tIZyerP8cI1e/NFToQ3pfkR6HTFN0G6VhwSZgG5trNGIh+Xcs/mLac7Lqm+jZagnukMX
 Kxvw==
X-Gm-Message-State: AOAM530D9VK8UEtt/D4VF9CCJvzuAuaUZ9oioVliHRP49xw6aMpb5QWK
 b1kndwZcXViQmQzkF8LdQSxm2efPkI0/GA==
X-Google-Smtp-Source: ABdhPJx2Imv5J0s/AqtOz/KRpL8HBPzeQ1+umix6CCUnIuguc3Yz/n4gAFedWQFLqO4HScvm6d4Vew==
X-Received: by 2002:a1c:5413:: with SMTP id i19mr923439wmb.139.1597969711098; 
 Thu, 20 Aug 2020 17:28:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3?
 ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id l81sm850834wmf.4.2020.08.20.17.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 17:28:30 -0700 (PDT)
Subject: Re: [PATCH 5/7] nvme: Fix controller creation races with teardown flow
To: James Smart <james.smart@broadcom.com>,
 Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1585063785-14268-1-git-send-email-israelr@mellanox.com>
 <1585063785-14268-6-git-send-email-israelr@mellanox.com>
 <fad9c553-28cd-a40c-1a92-6e36fb7ad383@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <53f22e11-057b-2db4-3511-95e7a9cc9c56@grimberg.me>
Date: Thu, 20 Aug 2020 17:28:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fad9c553-28cd-a40c-1a92-6e36fb7ad383@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_202832_304070_5CD55EE9 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gRllJIC0gSSd2ZSBoaXQgYSBzY2VuYXJpbyB3aXRoIHRoaXMgcGF0Y2gsIHdoZXJlIGlmIHRo
ZSBkZXZpY2Ugc3RhcnRzIAo+IHJlamVjdGluZyB0aGUgaW5pdGlhbCBjb25uZWN0aW9ucyBvciB0
aGV5IGNvbnRpbnVvdXNseSBoaXQgYSBmYWlsdXJlIC0gCj4gd2UncmUgZm9yY2VkIHRvIHdhaXQg
Y3RybF9sb3NzX3RtbyBiZWZvcmUgaXQgZ29lcyBhd2F5LiBXZSBjYW4ndCAKPiBmb3JjaWJseSBk
ZWxldGUgdGhlIGNvbnRyb2xsZXIgdmlhIHN5c2ZzLsKgIFRoaXMgc2hvdWxkbid0IGJlIHBvc3Np
YmxlLgoKVGhlIHVzZXIgc2hvdWxkIGFsd2F5cyBiZSBhbGxvd2VkIHRvIGdldCByaWQgb2YgdGhl
IGNvbnRyb2xsZXIuIFdlCnByb2JhYmx5IG5lZWQgdG8gZml4IHRoYXQuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

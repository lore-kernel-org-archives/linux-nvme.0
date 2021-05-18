Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284EAC43461
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 18:40:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0E3611B0
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 18:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0E3611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oVKzqZqQ+BywBL2iIpICuHeJm4Dae3IHy2yevSGE5zk=; b=jHl9dd45YDaeRuytXEP2WPzAo
	ThKSa4mJM5lwhYmlSvqlIqxf7o7LkxCa1dlEDcpMJE6u/xutDeeYNQSBn141a1iyZxkIjHQLa+doD
	RMeNFnhOwCRW3i5WC+IxgOMJl1CyDg5j37VZWfsoaG0UV1ZrXQ3JGQ1erBZ5ioLjxQ5BZyxEz/4Pd
	rP3psCYsEX/sDF2y4vBJGu/p/MWElJM+U+zXSczGGPvkRRZYUP6uBdNgFQd9b3hkxkuKKKiZSguWE
	fSD5qMw9hLNmHNlvoZZUAOBY6n9ytyx5rMzypZDnDfgT6SJb2Mj4Ya8k6oIf+lN/R7x8ld5UYGTCR
	hlmOiLq0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj4cl-001dKk-JC; Tue, 18 May 2021 18:39:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj4ce-001dK6-Ci
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 18:39:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nnII+AOEJrp6p8L/IUi9T9Jz1absoWJyUynX0+3Vd4E=; b=ByuCfO8gsvkGMGSeJrl5jrsZlS
 HNQmwrOQv7iysacPTSRLdFdfqmBx1T5CWz5uUgsybpK2KfAT31Mxqo21Ia1yVz8kn5bfn97UuRo2Z
 mWRjn4TIWMTEs1YHQdq4WSerlEiv7umcDywqMUaZisPKlRRNqmFYcHvWWp+S8xCO+clNCReNTNAYa
 qacV5PbC0QwzCMctJ4dBWL/hbTmYKpSVxwSD+NdMrWblmlRhCpyT74JQaNzQui61BPfmyK8wWgLMm
 4bekDStD3WujdLVF9lylH/6xbywjEhUCWvHDLsCzqB/PCzcBfaq8G3x/zxqdUryazNdMyse63AWzO
 tIGxk+Dw==;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj4cb-00Et3M-Jn
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 18:39:15 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 u5-20020a7bc0450000b02901480e40338bso2055709wmc.1
 for <linux-nvme@lists.infradead.org>; Tue, 18 May 2021 11:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nnII+AOEJrp6p8L/IUi9T9Jz1absoWJyUynX0+3Vd4E=;
 b=dVZPIGIpne6XNb0kOI0sNrPe++VreFqWljOgmfi2YrQpRxm3Bdcdye4lZTk482G0fR
 x+1eQUcz4sjCT4t6eMI709ek5tqKS6jo8OX+0DC9EURQRmBnX+FSZe210bvwnlg6u+KE
 hFcLH47Z6EizQRfC32dL6Ki44xx7idbC1eE/HRs4FQLxQctRDt6A7BhNUDUIgYm7d+0R
 +4kUqdFWCDCwgDTAOR0j29LVczvcQlIC3V+lK8CTOdvuQRlNFa23PTb82TyNG5YYln34
 LmnAvOvSvyTAikANQzohT/rWBz+mmHCc/OrqlBRPn5tVaqDL1UES0dbnxUEWH0UxnZ0t
 Pd9w==
X-Gm-Message-State: AOAM531n0OPYTP11chOnj+UW9b8rsj8crKA5rUMN1A5XK4wksGgzcWPd
 5WiGduHIrLwS23r6ssoQfyZTr8GW/Fc=
X-Google-Smtp-Source: ABdhPJw+/cC84gCSuIsBB72J/fLNWKGHsToMzCZ7k409T6z9SOOf3w3+R87NVFS2g9srh/y7bfsG1w==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr6428163wme.98.1621363149730;
 Tue, 18 May 2021 11:39:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f888:e3f1:214b:6edc?
 ([2601:647:4802:9070:f888:e3f1:214b:6edc])
 by smtp.gmail.com with ESMTPSA id m9sm22858588wrq.78.2021.05.18.11.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 11:39:09 -0700 (PDT)
Subject: Re: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210517083215.105604-1-hare@suse.de>
 <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
 <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de>
 <deb1d103-8fc6-6f38-f9e9-d3a327ea5678@grimberg.me>
 <b7f6c507-d2a4-4231-737e-04e1c8a3df9e@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d81323b2-a914-4dee-718a-39728d2e2039@grimberg.me>
Date: Tue, 18 May 2021 11:39:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b7f6c507-d2a4-4231-737e-04e1c8a3df9e@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_113913_671715_1F2AA0F5 
X-CRM114-Status: GOOD (  13.45  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4+PiBi
L2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+Pj4+IGluZGV4IDA1NTE3OTY1MTdlNi4u
ZWNjOTliZDVmOGFkIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBh
dGguYwo+Pj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4+PiBAQCAt
MTAwLDggKzEwMCwxMSBAQCB2b2lkIG52bWVfa2lja19yZXF1ZXVlX2xpc3RzKHN0cnVjdCBudm1l
X2N0cmwKPj4+Pj4gKmN0cmwpCj4+Pj4+ICDCoMKgwqDCoMKgIGRvd25fcmVhZCgmY3RybC0+bmFt
ZXNwYWNlc19yd3NlbSk7Cj4+Pj4+ICDCoMKgwqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50cnkobnMs
ICZjdHJsLT5uYW1lc3BhY2VzLCBsaXN0KSB7Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAobnMt
PmhlYWQtPmRpc2spCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtibG9ja2Rfc2NoZWR1
bGVfd29yaygmbnMtPmhlYWQtPnJlcXVldWVfd29yayk7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAoIW5zLT5oZWFkLT5kaXNrKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51
ZTsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGtibG9ja2Rfc2NoZWR1bGVfd29yaygmbnMtPmhlYWQt
PnJlcXVldWVfd29yayk7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoY3RybC0+c3RhdGUgPT0g
TlZNRV9DVFJMX0xJVkUpCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRpc2tfdWV2ZW50
KG5zLT5oZWFkLT5kaXNrLCBLT0JKX0NIQU5HRSk7Cj4+Pj4+ICDCoMKgwqDCoMKgIH0KPj4+Pgo+
Pj4+IEkgYXNrZWQgdGhpcyBvbiB2MSwgaXMgdGhpcyBvbmx5IG5lZWRlZCBmb3IgbXBhdGggZGV2
aWNlcz8KPj4+Cj4+PiBZZXM7IHdlIG5lZWQgdG8gc2VuZCB0aGUgS09CSl9DSEFOR0UgZXZlbnQg
b24gdGhlIG1wYXRoIGRldmljZSBhcyBpdCdzCj4+PiBub3QgYmFja2VkIGJ5IGhhcmR3YXJlLiBU
aGUgb25seSBub24tbXVsdGlwYXRoZWQgZGV2aWNlcyBJJ3ZlIHNlZW4gc28KPj4+IGZhciBhcmUg
UENJIGRldmljZXMgd2hlcmUgZXZlbnRzIGFyZSBnZW5lcmF0ZWQgYnkgdGhlIFBDSSBkZXZpY2Ug
aXRzZWxmLgo+Pgo+PiBBbmQgZm9yIGZhYnJpY3M/Cj4gCj4gTm8gZXZlbnRzIHdoYXRzb2V2ZXIu
Cj4gSGVuY2UgdGhpcyBwYXRjaC4KCk5vbi1tdWx0aXBhdGggZmFicmljcyBJIG1lYW50CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

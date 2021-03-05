Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0079C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:31:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD6A64F60
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD6A64F60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oKZyw9BOUcoRwOjUjL4dz8Ci5vDj8V2FhgjXEjbaR4o=; b=IyF65hhjieJp7MNAIidNhPDmo
	r4NkaE1j5jc8xsW6Is1D57FmCuEAt6V/goblY6PWHx3wd4KPz7rLtq9jigP8OzHlgthDcE+rlIc0O
	2XYW2ghf/bH1d9KDpfPYgzpJQBwDPfA2r6b3UhJZhu8pYJiH/ebqfVtmiyfk3bBPVFfqtmHsisEqJ
	lwk162vYKOx//q4fC0nMquDqEeAKemSHShyR+/ZEuz8MH1M9RbVVW4jd4FMeF6eI6d09Gn+16kTvc
	ubNSPo3KcX0e8c1raP3HTPQI6QpFrr/iG1aUrW7X3al8/Kh2TT1w1eh6yK8+tAzv2BMZQAOPizxvo
	wF9KXWBgA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIH6q-00GNzH-Ro; Fri, 05 Mar 2021 20:31:40 +0000
Received: from mail-oi1-f171.google.com ([209.85.167.171])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIH6k-00GNyA-SS
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 20:31:37 +0000
Received: by mail-oi1-f171.google.com with SMTP id l64so3878384oig.9
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 12:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M1dSFSjXUVIaf6NrvS3lSdveQSa6ZdxbfbSDlipzedA=;
 b=JeASt1h8Fj8zzsVNRnQlmsZTHpm9Qtljh3zpwTzMdoBfsHhjPTyvFv9228DdK6m6Vz
 Eckbmk0NxeC+B2/09Nbp1N2Fv1IsI979HakbHPFh1nVdI5aA2RKzGQ0KnZ3AX+Q0cxpr
 I0zXMwAKo/GUkg4AIhXf71xjOCryLoF/v/iz6vuS9fweIXPcdTUItf0sHCSc/ZKTtLYu
 BbVxhwTlLSJnp5MeKVGNYhQEYQfUF8TyF+XLHiFA0F0SVZ1GHKEJiQ43+k1brxJw1tGH
 3UB4fUVyPjQr9RU8daRkDJbVi1dxzAxpgqHTqU+gLILNkBBS/gZudwGtQ+A0u4LqYcOc
 d32g==
X-Gm-Message-State: AOAM533nIfCFuqioFEWonS6mZI+EvWAEo3seehco2GvUspV4l04HmACG
 eU+/rjeQnl7yuQ6CrC5Oxkdz0LJqOYg=
X-Google-Smtp-Source: ABdhPJzQ+tzWC1LZIMc/xsE+FxypaYKK79Cx9WsxOYh4MI0evpZDYriMYjJ0I5BZRbLPXVSLAOoffQ==
X-Received: by 2002:aca:5cd6:: with SMTP id q205mr8412549oib.94.1614976293792; 
 Fri, 05 Mar 2021 12:31:33 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id a23sm823739otf.20.2021.03.05.12.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 12:31:33 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
 <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
 <20201006082727.GC10243@lst.de>
 <a848297e-3243-6366-86ee-0800d51198e1@suse.de>
 <20201006083926.GA13568@lst.de>
 <00e75643-d422-ca12-1648-02ca89044182@suse.de>
 <ce2c93e1-ba38-cebb-33b3-d506116a61aa@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <28830f4b-181d-2a4d-0bdd-2f63fcdbcf72@grimberg.me>
Date: Fri, 5 Mar 2021 12:31:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ce2c93e1-ba38-cebb-33b3-d506116a61aa@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_203135_913970_6B0BB363 
X-CRM114-Status: GOOD (  19.17  )
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

Cj4gQ29tcGFyZSB0aGF0IHRvIHRoZSAnc3RhbmRhcmQnLCBub24tQ01JQyBudm1lLCB3aGVyZSB3
aXRoIHRoZSBzYW1lIHNldHVwIAo+IE1EIHdvdWxkIGRldGFjaCB0aGUgbnZtZSBvbiBpdHMgb3du
Ogo+IAo+ICMgY2F0IC9wcm9jL21kc3RhdAo+IFBlcnNvbmFsaXRpZXMgOiBbcmFpZDEwXQo+IG1k
MTI3IDogYWN0aXZlIChhdXRvLXJlYWQtb25seSkgcmFpZDEwIG52bWUybjFbMV0KPiAgwqDCoMKg
wqDCoCA0MTg5MTg0IGJsb2NrcyBzdXBlciAxLjIgMiBuZWFyLWNvcGllcyBbMi8xXSBbX1VdCj4g
IMKgwqDCoMKgwqAgYml0bWFwOiAwLzEgcGFnZXMgWzBLQl0sIDY1NTM2S0IgY2h1bmsKPiAKPiB1
bnVzZWQgZGV2aWNlczogPG5vbmU+Cj4gIyBudm1lIGxpc3QKPiBOb2RlwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFNOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1vZGVsIMKg
wqDCoMKgwqAgTmFtZXNwYWNlIAo+IFVzYWdlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEZvcm1hdMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZXIFJldgo+IC0tLS0tLS0t
LS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0gCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0gCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0g
LS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLQo+IC9kZXYvbnZtZTBuMcKgwqDCoMKgIFNMRVNOVk1F
McKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUUVNVSBOVk1lIEN0cmwgwqDCoMKgwqDCoCAxICAgICAg
ICAgIAo+IDE3LjE4wqAgR0IgL8KgIDE3LjE4wqAgR0LCoMKgwqAgNTEywqDCoCBCICvCoCAwIELC
oMKgIDEuMAo+IC9kZXYvbnZtZTJuMcKgwqDCoMKgIFNMRVNOVk1FM8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgUUVNVSBOVk1lIEN0cmwgwqDCoMKgwqDCoCAxICAgICAgICAgICAKPiA0LjI5wqAgR0Ig
L8KgwqAgNC4yOcKgIEdCwqDCoMKgIDUxMsKgwqAgQiArwqAgMCBCwqDCoCAxLjAKPiAKPiBBbmQg
eWVzLCB0aGlzIGlzIGV4YWN0bHkgdGhlIHNhbWUgc2V0dXAsIHRoZSBvbmx5IGRpZmZlcmVuY2Ug
YmVpbmcgdGhlIAo+IENNSUMgc2V0dGluZyBmb3IgdGhlIE5WTWUgZGV2aWNlLgoKSSBhZ3JlZSB3
aXRoIENocmlzdG9waCB0aGF0IHdlIHNob3VsZCBkbyBleGFjdGx5IHRoZSBzYW1lIGZvciBhbGwu
CgpIYW5uZXMsIE15IHVuZGVyc3RhbmRpbmcgaGVyZSBpcyB0aGF0IHlvdSB3YW50IHRoZSBkZXZp
Y2UgdG8gZ28gYXdheQphZnRlciB0aGUgbGFzdCBwYXRoIGRpc2FwcGVhcmVkIGJlY2F1c2UgaXQg
YnJlYWtzIG1kLCB3aHkgZG9uJ3QgeW91CndhbnQgdG8gaGF2ZSB0aGlzIGFsc28gZm9yIGZhYnJp
Y3M/CgpZb3UgbWVudGlvbiB0aGF0IGluIGZhYnJpY3Mgb25lIGNhbiBtYW51YWxseSBkaXNjb25u
ZWN0LCBidXQgd2h5IHNob3VsZAp0aGUgdXNlciByZXNvcnQgdG8gYSBtYW51YWwgZGlzY29ubmVj
dD8KCklzIHNvbWV0aGluZyBlbHNlIGJyb2tlbiB3aXRoIHRoaXMgYmVoYXZpb3I/IE1heWJlIEkg
YW0gbWlzc2luZwpzb21ldGhpbmcgaGVyZT8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK

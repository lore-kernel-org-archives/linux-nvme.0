Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC54EC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 08:22:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A2A20792
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 08:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nYSHRStC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A2A20792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jvDoTZ8oOHtgC8L4jL3eiRog5iR1/njZjhBqCXCYJfA=; b=nYSHRStCTrK3+7U7mprIHyBN5
	K6DNhsJO20dyKWaK8tytiymkfy/M2xQqTagwAxNdfZFum8pWMcorS9T4WHLMu+DyHN9S7hbPTx9YJ
	6gTjor32kApC8CuR2pNJssgjJbn1EVZkATsy9ZB+TkmX6mut/AJR5coKJFtWpbHvU+UUSdReN29fl
	qhubmR3jYUFXuS5XJTIivgP0oCEwLkw46VB6v0j3C4N+/HlcBUj1IMrzrEsyOvsUM+mH+zTzOGaIz
	l7b3MSKUzBuckCFcJ/gjB/XubyfeQH3+/eOui38/sY1kYRp/Q3y4Sw9L0yeVhTX3d0yp6T2AUpRh5
	lDHIlbDLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3Egt-0007f4-Co; Wed, 05 Aug 2020 08:22:27 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3Egr-0007eb-GT
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 08:22:26 +0000
Received: by mail-pl1-f196.google.com with SMTP id d1so24818171plr.8
 for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2020 01:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rwPHoV2qEm/4qZzoeJT0Xc8oKr5gX4dwdezZLgLNwY8=;
 b=Bz3pt94KJ3LfG2j6EoBw7AvRQvdzQpQu9o73b0EMc119G9o3Ydy14hFiKcJS+lcpGy
 VR85tnUR60J3Ukw5XIRpsIeUfp+GAFumO/J2S/5FI2xS+iO7lWjHp6DvTaK1jd7Vcx2r
 j6WoL1MMfHhQKPDD5c3G0C4sxDfhMo3vgt766sCeFWcDOGOIG1e3YN45sJUYdcIN2zAI
 RhDPBzDiaHbTTxu8aa/cKXeWqu7nBncFKhFUFy7AzGBJAyqzSokVfSat0P60dg3NvGf1
 7+L7nitZlJNYvDj6bOArGBqK5fJ7P6r2uWTPpYWV9TfOvPU/2CfLj+JelyUxuJ9h5swL
 mSww==
X-Gm-Message-State: AOAM533bcniU0LTzAbaOObHUnRlv01SAY5lF32zA/2cbEg25oToO+qle
 uE1I5jGgX/2Xe9Qxhl9SENc=
X-Google-Smtp-Source: ABdhPJwbwlcqFDehYKS34HBjbjKoe5lYMLi5MlzqhR0/0XmGwqdkyH1lli2g8acgHtV2qUyCWXdZVQ==
X-Received: by 2002:a17:90a:cf95:: with SMTP id
 i21mr2123863pju.135.1596615744552; 
 Wed, 05 Aug 2020 01:22:24 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e1a8:cb16:c589:8b34?
 ([2601:647:4802:9070:e1a8:cb16:c589:8b34])
 by smtp.gmail.com with ESMTPSA id oc4sm2073874pjb.51.2020.08.05.01.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 01:22:23 -0700 (PDT)
Subject: Re: [PATCH] nvme-core: fix deadlock when reconnect failed due to
 nvme_set_queue_count timeout
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20200805063335.19882-1-lengchao@huawei.com>
 <02a20ae5-5af3-8595-c8b4-237449fbc1ee@grimberg.me>
 <c0b91c52-6d5b-90d9-206e-780f836a1ed8@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <26a34c36-a781-acad-1ea9-8dfa03fabf88@grimberg.me>
Date: Wed, 5 Aug 2020 01:22:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c0b91c52-6d5b-90d9-206e-780f836a1ed8@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_042225_583016_73E51B9C 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBBIGRlYWRsb2NrIGhhcHBlbnMgV2hlbiB3ZSB0ZXN0IG52bWUgb3ZlciByb2NlIHdpdGgg
bGluayBibGluay4gVGhlCj4+PiByZWFzb246IGxpbmsgYmxpbmsgd2lsbCBjYXVzZSBlcnJvciBy
ZWNvdmVyeSwgYW5kIHRoZW4gcmVjb25uZWN0LklmCj4+PiByZWNvbm5lY3QgZmFpbCBkdWUgdG8g
bnZtZV9zZXRfcXVldWVfY291bnQgdGltZW91dCwgdGhlIHJlY29ubmVjdAo+Pj4gcHJvY2VzcyB3
aWxsIHNldCB0aGUgcXVldWUgY291bnQgYXMgMCBhbmQgY29udGludWUgLCBhbmQgdGhlbgo+Pj4g
bnZtZV9zdGFydF9jdHJsIHdpbGwgY2FsbCBudm1lX2VuYWJsZV9hZW4sIGFuZCBkZWFkbG9jayBo
YXBwZW5zCj4+PiBiZWNhdXNlIHRoZSBhZG1pbiBxdWV1ZSBpcyBxdWllc2NlZC4KPj4KPj4gV2h5
IGlzIHRoZSBhZG1pbiBxdWV1ZSBxdWllc2NlZD8gaWYgd2UgYXJlIGNhbGxpbmcgc2V0X3F1ZXVl
X2NvdW50Cj4+IGl0IHdhcyBhbHJlYWR5IHVucXVpZXNjZWQ/Cj4gbnZtZV9zZXRfcXVldWVfY291
bnQgdGltZW91dCB3aWxsIG52bWVfcmRtYV90ZWFyZG93bl9hZG1pbl9xdWV1ZQoKTm90IGluIHRo
ZSBwYXRjaHNldCBJIHNlbnQuCgo+LCB0aGUgCj4gYWRtaW4gcXVldWUKPiB3aWxsIGJlIHF1aWVz
Y2VkIGluIG52bWVfcmRtYV90ZWFyZG93bl9hZG1pbl9xdWV1ZS4KPj4KPj4+IGxvZzoKPj4+IEF1
Z8KgIDMgMjI6NDc6MjQgbG9jYWxob3N0IGtlcm5lbDogbnZtZSBudm1lMjogSS9PIDIyIFFJRCAw
IHRpbWVvdXQKPj4+IEF1Z8KgIDMgMjI6NDc6MjQgbG9jYWxob3N0IGtlcm5lbDogbnZtZSBudm1l
MjogQ291bGQgbm90IHNldCBxdWV1ZSBjb3VudAo+Pj4gKDg4MSkKPj4+IHN0YWNrOgo+Pj4gcm9v
dMKgwqDCoMKgIDIzODQ4wqAgMC4wwqAgMC4wwqDCoMKgwqDCoCAwwqDCoMKgwqAgMCA/wqDCoMKg
wqDCoMKgwqAgRMKgwqDCoCBBdWcwM8KgwqAgMDowMAo+Pj4gW2t3b3JrZXIvdTEyOjQrbnZtZS13
cV0KPj4+IFs8MD5dIGJsa19leGVjdXRlX3JxKzB4NjkvMHhhMAo+Pj4gWzwwPl0gX19udm1lX3N1
Ym1pdF9zeW5jX2NtZCsweGFmLzB4MWIwIFtudm1lX2NvcmVdCj4+PiBbPDA+XSBudm1lX2ZlYXR1
cmVzKzB4NzMvMHhiMCBbbnZtZV9jb3JlXQo+Pj4gWzwwPl0gbnZtZV9zdGFydF9jdHJsKzB4YTQv
MHgxMDAgW252bWVfY29yZV0KPj4+IFs8MD5dIG52bWVfcmRtYV9zZXR1cF9jdHJsKzB4NDM4LzB4
NzAwIFtudm1lX3JkbWFdCj4+PiBbPDA+XSBudm1lX3JkbWFfcmVjb25uZWN0X2N0cmxfd29yaysw
eDIyLzB4MzAgW252bWVfcmRtYV0KPj4+IFs8MD5dIHByb2Nlc3Nfb25lX3dvcmsrMHgxYTcvMHgz
NzAKPj4+IFs8MD5dIHdvcmtlcl90aHJlYWQrMHgzMC8weDM4MAo+Pj4gWzwwPl0ga3RocmVhZCsw
eDExMi8weDEzMAo+Pj4gWzwwPl0gcmV0X2Zyb21fZm9yaysweDM1LzB4NDAKPj4+Cj4+PiBNYW55
IGZ1bmN0aW9ucyB3aGljaCBjYWxsIF9fbnZtZV9zdWJtaXRfc3luY19jbWQgdHJlYXQgZXJyb3Ig
Y29kZSBpbiB0d28KPj4+IG1vZGVzOiBJZiBlcnJvciBjb2RlIGxlc3MgdGhhbiAwLCB0cmVhdCBh
cyBjb21tYW5kIGZhaWxlZC4gSWYgZXJyb2UgY29kZQo+Pj4gbW9yZSB0aGFuIDAsIHRyZWF0IGFz
IHRhcmdldCBub3Qgc3VwcG9ydCBvciBvdGhlci4KPj4KPj4gV2UgcmVseSBpbiBhIGxvdCBvZiBw
bGFjZXMgb24gdGhlIG52bWUgc3RhdHVzIGJlaW5nIHJldHVybmVkIGZyb20KPj4gbnZtZV9zdWJt
aXRfc3luY19jbWQgKGVzcGVjaWFsbHkgaW4gbnZtZV9yZXZhbGlkYXRlX2Rpc2sgYW5kIGZvcgo+
PiBwYXRoL2Fib3J0ZWQgY2FuY2VsbGF0aW9ucyksIGFuZCB0aGlzIHBhdGNoIGJyZWFrcyBpdC4g
WW91IG5lZWQgdG8gZmluZAo+PiBhIHNvbHV0aW9uIHRoYXQgZG9lcyBub3QgaGlkZSB0aGUgbnZt
ZSBzdGF0dXMgY29kZSBmcm9tIHByb3BhZ2F0aW5nCj4+IGJhY2suCj4gVGhlIGRpZmZlcmVuY2Ug
aXMganVzdCBFSU5UUiBhbmQgRUlPLCB0aGVyZSBpcyBubyByZWFsIGltcGFjdC4KCkl0J3Mgbm90
IEVJTywgaXRzIHByb3BhZ2F0aW5nIGJhY2sgdGhlIG52bWUgc3RhdHVzLiBBbmQgd2UgbmVlZCB0
aGUKbnZtZSBzdGF0dXMgYmFjayB0byBub3QgZmFsc2VseSByZW1vdmUgbmFtZXNwYWNlcyB3aGVu
IHdlIGhhdmUKbnMgc2Nhbm5pbmcgZHVyaW5nIGNvbnRyb2xsZXIgcmVzZXRzIG9yIG5ldHdvcmsg
ZGlzY29ubmVjdHMuCgpTbyBhcyBJIHNhaWQsIHlvdSBuZWVkIHRvIHNvbHZlIHRoaXMgaXNzdWUg
d2l0aG91dCBwcmV2ZW50aW5nIHRoZQpudm1lIHN0YXR1cyBwcm9wYWdhdGUgYmFjay4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

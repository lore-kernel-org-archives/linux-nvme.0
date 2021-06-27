Return-Path: <SRS0=1ZDZ=LV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFEEC48BC2
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Jun 2021 13:39:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98366161C
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Jun 2021 13:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98366161C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RxSVQw4F7Q7wRJJq6TV24p1a/wynvBG0cOqu/Opomo=; b=RgtdeA0rLVoobB+lHKaHULJZv8
	d1mQKXjpxGbrjJlOuDqhERlkXGB63RDa3QRW9Ypl8iEC9k/PlkNsBaxm3B6CB0oyo+JsZQVlwIQX5
	ObuGJGxNMDywuwTDBS4Yz66lEZvi1puI/4TZn0Czcbkq3za7gd+ipZDHS0/PTbWWOElWJF7Zw0QcG
	dvXdziCUoNpx9qX8OYM7ZDN82wdxg7T8MJ49CtJsjUN9N6p1eX3HuVaHfm88GbUvhroSA5eCT1brJ
	pmqHoHkFcU9rMkeAYolfV+ohcnVHtV1LJcAsCrBqo/BOIFzIeOMIiHKtQ3VH4LnHYTC4P5favhB8O
	5g1JygpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxV0U-005cDR-C3; Sun, 27 Jun 2021 13:39:30 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxV0H-005cD6-42
 for linux-nvme@lists.infradead.org; Sun, 27 Jun 2021 13:39:18 +0000
Received: by mail-pg1-x52c.google.com with SMTP id m2so12920763pgk.7
 for <linux-nvme@lists.infradead.org>; Sun, 27 Jun 2021 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UzuMSjAHSwPwbkGofnl0HTwnxNmS3ZjTTb3rEjQF/3w=;
 b=oFhkyjh9Tjzw/SJQyZblz31RG61uLAPP1YrveTQ2Ma+n4MTSlF7gvF1miHzMi80BO5
 5nEbVuVO5T/HuVnLRiAvLnUJUK2gQNB2vxuBSDL+tKinfm2FbOoehisTjt1q39o0nDAq
 /rtFhgjLkhxuh5rr2QmqqfrQs+CR56fZPaD91zeZH9t76zXFcSFTN8hWz1S24q4IoQVC
 FZ1WkMjHwlj9rD4MaOlkvDanAydWD+Sxc+EUnAuoSPeWLHXQgQNuSBtK5JQ6TfdFGRsZ
 qOUcLVTtHUJOw1vjE4eaplABbi9v+ZzlJQ2Bm09cRMJcx/MOA3BpVTt2iq414oGLq5Eh
 WvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UzuMSjAHSwPwbkGofnl0HTwnxNmS3ZjTTb3rEjQF/3w=;
 b=WFucFrwss2L4TK3nop3bP5VWN/Vgkfp3gP1p4RLu2086/v2BaHmolgpeXqX5Xzbrfg
 Y3i9oeSlouYEvZcJS3oKzfvBJiR2uvtAqZcZyaIDsL19sojWg8//mtaDp8deHaMViLjB
 wIM6qV++5A9FpfXwplKLe9bO9MAhYtzAnHR7Q8wpyD0iUdo6YcyeJysuxB9P3XpBrhUT
 GYUKQM4Crr1MMEcNl4jjSkTWmxvYzl1netoBniOGcLojQ//c2qI2rBrjtr69+574Qifs
 ihRP6mseSh/mQoZ3GmmKPKoaxbBXcyB5pEkYqJqLxa4NYFiXO3XUYHnLMqX8xbDZ/c83
 aUzw==
X-Gm-Message-State: AOAM530HCGW88KWu56SPhbRY78D5KSkEp1NyompMv8JQuk6A+yZf73TW
 dOubIRQnPLL6nbUmT2joUC5NFPJmW4Q=
X-Google-Smtp-Source: ABdhPJzQGp9CcaG0R0KxkirysyqVPspOax9KaCM91kd418lk2up6M6hJ9MLcO9ER83q7ajl6AyKGEg==
X-Received: by 2002:aa7:8d5a:0:b029:302:e2cb:6d79 with SMTP id
 s26-20020aa78d5a0000b0290302e2cb6d79mr19991868pfe.71.1624801155734; 
 Sun, 27 Jun 2021 06:39:15 -0700 (PDT)
Received: from [192.168.1.30] (ip174-67-196-173.oc.oc.cox.net.
 [174.67.196.173])
 by smtp.gmail.com with ESMTPSA id w14sm11408357pjb.3.2021.06.27.06.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jun 2021 06:39:15 -0700 (PDT)
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
To: Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210623143250.82445-1-hare@suse.de>
 <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
 <204a6656-ef83-b688-4979-26fe17f57974@suse.de>
 <cdf40226-12ed-5f87-8549-10b4defceae5@huawei.com>
 <91ff9961-6537-05d1-c552-18a02d13bf0c@suse.de>
 <984b2d1a-f319-1a09-7347-6c4edd1dbab6@huawei.com>
 <d20b23fc-dd08-cb51-eb29-aa033810b0a4@suse.de>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <caa3759f-9a72-5e3b-9097-700132e4ab63@gmail.com>
Date: Sun, 27 Jun 2021 06:39:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d20b23fc-dd08-cb51-eb29-aa033810b0a4@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_063917_228769_6A0EB27F 
X-CRM114-Status: GOOD (  23.32  )
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

T24gNi8yNi8yMDIxIDU6MDkgQU0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA2LzI2LzIx
IDM6MDMgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4KPj4KPj4gT24gMjAyMS82LzI0IDE2OjEwLCBI
YW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+PiBPbiA2LzI0LzIxIDk6MjkgQU0sIENoYW8gTGVuZyB3
cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMjAyMS82LzI0IDEzOjUxLCBIYW5uZXMgUmVpbmVja2Ug
d3JvdGU6Cj4+Pj4+IE9uIDYvMjMvMjEgMTE6MzggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+
Pj4+Pgo+Pj4+Pj4+IEhpIGFsbCwKPj4+Pj4+Pgo+Pj4+Pj4+IGNvbW1pdCBmMjVmOGVmNzBjZTIg
KCJudm1lLWZjOiBzaG9ydC1jaXJjdWl0IHJlY29ubmVjdCByZXRyaWVzIikKPj4+Pj4+PiBhbGxv
d2VkIHRoZSBmYyB0cmFuc3BvcnQgdG8gaG9ub3VyIHRoZSBETlIgYml0IGR1cmluZyByZWNvbm5l
Y3QKPj4+Pj4+PiByZXRyaWVzLCBhbGxvd2luZyB0byBzcGVlZCB1cCBlcnJvciByZWNvdmVyeS4K
Pj4+Pj4+Cj4+Pj4+PiBIb3cgZG9lcyB0aGlzIHNwZWVkIHVwIGVycm9yIHJlY292ZXJ5Pwo+Pj4+
Pgo+Pj4+PiBXZWxsLCBub3QgZXhhY3RseSBlcnJvciByZWNvdmVyeSAoYXMgdGhlcmUgaXMgbm90
aGluZyB0byByZWNvdmVyKS4KPj4+Pj4gQnV0IHdlIHdvbid0IGF0dGVtcHQgcG9pbnRsZXNzIHJl
dHJpZXMsIHRoZXJlYnkgcmVkdWNpbmcgdGhlIG5vaXNlIGluCj4+Pj4+IHRoZSBtZXNzYWdlIGxv
Zy4KPj4+PiBUaGlzIGNvbmZsaWN0IHdpdGggdGhlIHRjcCBhbmQgcmRtYSB0YXJnZXQuCj4+Pj4g
WW91IG1heSBuZWVkIHRvIGRlbGV0ZSB0aGUgaW1wcm9wZXIgTlZNRV9TQ19ETlIgYXQgdGhlIHRh
cmdldC4KPj4+PiBIb3dldmVyLCB0aGlzIHdpbGwgY2F1c2UgY29tcGF0aWJpbGl0eSBpc3N1ZXMg
YmV0d2VlbiBkaWZmZXJlbnQgCj4+Pj4gdmVyc2lvbnMuCj4+Pgo+Pj4gV2hpY2ggb25lcz8KPj4g
SW4gbWFueSBzY2VuYXJpb3MsIHRoZSBkZXN0aW5hdGlvbiBzZXRzIEROUiBmb3IgYWJub3JtYWwg
cGFja2V0cywKPj4gYnV0IGVhY2ggbmV3IGNvbm5lY3Rpb24gbWF5IG5vdCBoYXZlIHRoZSBzYW1l
IGVycm9yLgo+IAo+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIG9ubHkgZm9yIHRoZSBETlIgYml0IHNl
dCBpbiByZXNwb25zZSB0byB0aGUgCj4gJ2Nvbm5lY3QnIGNvbW1hbmQuCj4gSWYgdGhlIHRhcmdl
dCBpcyBub3QgYWJsZSB0byBwcm9jZXNzIHRoZSAnY29ubmVjdCcgY29tbWFuZCwgYnV0IG1heSBi
ZSAKPiBzbyBpbiB0aGUgZnV0dXJlIGl0IHJlYWxseSBzaG91bGQgbm90IHNldCB0aGUgRE5SIGJp
dC4KPiAKPj4+IEkgY2hlY2tlZCB0aGUgRE5SIHVzYWdlIGluIHRoZSB0YXJnZXQgY29kZSwgYW5k
IHRoZXkgc2VlbSB0byBzZXQgaXQKPj4+IGNvcnJlY3RseSAoaWUgdGhlIHJlc3VsdCB3b3VsZCBu
b3QgY2hhbmdlIHdoZW4gdGhlIGNvbW1hbmQgaXMgcmV0cmllZCkuCj4+PiBXaXRoIHRoZSBwb3Nz
aWJsZSBleGNlcHRpb24gb2YgRU5PU1BDIGhhbmRsaW5nLCBhcyB0aGlzIGlzIGFyZ3VhYmx5Cj4+
PiBkeW5hbWljIGFuZCBtaWdodCBjaGFuZ2Ugd2l0aCBhIHJldHJ5Lgo+PiBUaGUgRE5SIHN0YXR1
cyBvZiB0aGUgb2xkIGNvbm5lY3Rpb24gbWF5IG5vdCBiZSByZWxldmFudCB0byB0aGUgCj4+IHJl
LWVzdGFibGlzaGVkIGNvbm5lY3Rpb24uCj4gCj4gU2VlIGFib3ZlLgo+IFdlIGFyZSBqdXN0IGNo
ZWNraW5nIHRoZSBETlIgc2V0dGluZ3MgZm9yIHRoZSAnY29ubmVjdCcgY29tbWFuZCAob3IgYW55
IAo+IG90aGVyIGNvbW1hbmRzIGJlaW5nIHNlbnQgZHVyaW5nIGluaXRpYWwgY29udHJvbGxlciBj
b25maWd1cmF0aW9uKS4KPiBJZiB0aGF0IGZhaWxzIHRoZSBjb25uZWN0IG5ldmVyIHdhcyBwcm9w
ZXJseSBpbml0aWFsaXplZDsgaWYgdGhlIAo+IGNvbnRyb2xsZXIgd291bGQgcmV0dXJuIGEgZGlm
ZmVyZW50IHN0YXR1cyBhZnRlciByZWNvbm5lY3QgaXQgc2ltcGx5IAo+IHNob3VsZCBub3Qgc2V0
IHRoZSBETlIgYml0IC4uLgo+IAo+IENoZWVycywKPiAKPiBIYW5uZXMKCkFncmVlZC4gU2luY2Ug
MS4zIHNwZWMgc2F5czogIklmIHNldCB0byDigJgx4oCZLCBpbmRpY2F0ZXMgdGhhdCBpZiB0aGUg
c2FtZSAKY29tbWFuZCBpcyByZS1zdWJtaXR0ZWQgdG8gYW55IGNvbnRyb2xsZXIgaW4gdGhlIE5W
TSBzdWJzeXN0ZW0sIHRoZW4gCnRoYXQgcmUtc3VibWl0dGVkIGNvbW1hbmQgaXMgZXhwZWN0ZWQg
dG8gZmFpbC4iCgpUaHVzIGlmIHRoZSBpbml0aWFsIGNvbm5lY3QgZmFpbHMgaW4gdGhpcyBtYW5u
ZXIsIGFueSBuZXcgYXNzb2NpYXRpb24gCndpbGwgYmUgb24gYSBkaWZmZXJlbnQgY29udHJvbGxl
ciwgd2hlcmUgaXQgaXMgbm93IGV4cGVjdGVkIGNvbm5lY3Qgb24gCnRoYXQgY29udHJvbGxlciB3
aWxsIGZhaWwgdG9vLiAgVGh1cyAtIHdoeSBjb250aW51ZSB0byBjb25uZWN0IHdoZW4gaXQncyAK
ZXhwZWN0ZWQgZWFjaCB3aWxsIGZhaWwuCgotLSBqYW1lcwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=

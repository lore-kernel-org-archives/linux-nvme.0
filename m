Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFCAC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 20:24:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDE220872
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 20:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ceiq+F/J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VkgdNHjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDE220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mXM+liZ8ihut/jM6tbzB8KOmz7DP6r6S8C81eQswsMw=; b=Ceiq+F/JE6X5OZctQIrkTThsy
	3sJphmpGr2WUAjQwS8tqs44auDyeWe6J4FSQNeDG5JKqSO0q2g/KEU7vJS8KtZ0ueEZVay9+DsEaF
	MGv+EJc4MYEItx5J1KCOj3slDrc24sc16cXujlW1mGNp+9RbWfr5F80f0V3qZOPbMajEBpLYpOdUV
	Glqm4RALN4TtmLfPwapZrm6SZKfRXbmFMxHQbmers1AweylekFIwLgSFJ9v+rCczaGwdgmqT21Ff1
	+oPXXLXMgnumyMy7LS1wl2OOvd/LAP0w2zE+7EymmNqpq+vaf8dCxOnoRc+i/RbMwDszDKX9M6cJY
	zV56RcaJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBkv3-0005an-JC; Fri, 28 Aug 2020 20:24:17 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBkv0-0005Zt-2e
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 20:24:15 +0000
Received: by mail-pf1-x442.google.com with SMTP id d22so1212848pfn.5
 for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2020 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=IDS3NnzgLo0jrRDnLv1X/fj0Kz/8LODkkhTNK4jyDRo=;
 b=VkgdNHjZq31Eigk47vi7CkDqjau+mhw53riN9wARNhROVsSn2/UUqRzJ4oh/vSrxQx
 d3S+/drA+wN7IDQsGamfGjjj6cOFOVVR19bMKsv9INeB4/nh4BEe5h19A0V8DdLeFqzQ
 aS6V94csB6BUgDyDXMVwYBEM5VRp6FHCck4EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IDS3NnzgLo0jrRDnLv1X/fj0Kz/8LODkkhTNK4jyDRo=;
 b=P9LlWp3OFc3Dysgi/UGRXEAKFN7w7T/yWo35qOhHjBeNA2P5MjRh+S7HR7yp9UoVrs
 wI/PBPVkGpOOw5OigQtkVRQtDwQSQWCFaRTqaez5voKFK6HG/ilOse5ztrL10KTZyZjT
 mB5eEvr4cG7eOMPEG8AzxtreTOny6TXrbEyTagPTxb927CxUAOySZ+/Ebc6FQzkU+7xv
 WTBtgTdtP2gdHVSCZmaN/GvAymilYZK2ktdWjyYLhCOiHSL1wyMYraovnBO373gdtrCy
 9GJccgOpG30DrnAwUsMK9qZkrkckn5oUUMHf5u3QnCrfAqYkditTzF1nSi3oW5JvX+M+
 SEhg==
X-Gm-Message-State: AOAM531ExGf9cUtuxFfQWUO8fHHGtOPOAFKkRBHbDKjNCQPrz7DCOFq4
 1qXd8Q3yHEZTBRts7cv5vzMffQ==
X-Google-Smtp-Source: ABdhPJwJFQIEnDqL/cQjIPckGc84unXTiL/Nr/l2N0aCBeG+4HOQULnZIveNW/NMnCw45iHbrlHN2Q==
X-Received: by 2002:a63:6fc6:: with SMTP id k189mr362882pgc.165.1598646252072; 
 Fri, 28 Aug 2020 13:24:12 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id z1sm174013pjn.34.2020.08.28.13.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 13:24:11 -0700 (PDT)
Subject: Re: [PATCH] nvme: Revert: Fix controller creation races with teardown
 flow
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20200828190150.34455-1-james.smart@broadcom.com>
 <0867c437-1521-c0c9-d7fa-6a615d88105a@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <a73cd06b-b319-d55f-1465-4263e08900ae@broadcom.com>
Date: Fri, 28 Aug 2020 13:24:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <0867c437-1521-c0c9-d7fa-6a615d88105a@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_162414_331790_0F65B0A8 
X-CRM114-Status: GOOD (  22.57  )
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
Cc: Keith Busch <kbusch@kernel.org>, Israel Rukshin <israelr@mellanox.com>,
 Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
 Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzI4LzIwMjAgMTI6MDggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4gVGhlIGlu
ZGljYXRlZCBwYXRjaCBpbnRyb2R1Y2VkIGEgYmFycmllciBpbiB0aGUgc3lzZnNfZGVsZXRlIGF0
dHJpYnV0ZQo+PiBmb3IgdGhlIGNvbnRyb2xsZXIgdGhhdCByZWplY3RzIHRoZSByZXF1ZXN0IGlm
IHRoZSBjb250cm9sbGVyIGlzbid0Cj4+IGNyZWF0ZWQuICJDcmVhdGVkIiBpcyBkZWZpbmVkIGFz
IGF0IGxlYXN0IDEgY2FsbCB0byBudm1lX3N0YXJ0X2N0cmwoKS4KPj4KPj4gVGhpcyBpcyBwcm9i
bGVtYXRpYyBpbiBlcnJvci1pbmplY3Rpb24gdGVzdGluZy7CoCBJZiBhbiBlcnJvciBvY2N1cnMg
b24KPj4gdGhlIGluaXRpYWwgYXR0ZW1wdCB0byBjcmVhdGUgYW4gYXNzb2NpYXRpb24gYW5kIHRo
ZSBjb250cm9sbGVyIGVudGVycwo+PiByZWNvbm5lY3QocykgYXR0ZW1wdHMsIHRoZSBhZG1pbiBj
YW5ub3QgZGVsZXRlIHRoZSBjb250cm9sbGVyIHVudGlsCj4+IGVpdGhlciB0aGVyZSBpcyBhIHN1
Y2Nlc3NmdWwgYXNzb2NpYXRpb24gY3JlYXRlZCBvciBjdHJsX2xvc3NfdG1vCj4+IHRpbWVzIG91
dC4KPj4KPj4gV2hlcmUgdGhpcyBpc3N1ZSBpcyBwYXJ0aWN1bGFybHkgaHVydGZ1bCBpcyB3aGVu
IHRoZSAiYWRtaW4iIGlzIHRoZQo+PiBudm1lLWNsaSwgaXQgaXMgcGVyZm9ybWluZyBhIGNvbm5l
Y3Rpb24gdG8gYSBkaXNjb3ZlcnkgY29udHJvbGxlciwgYW5kCj4+IGl0IGlzIGluaXRpYXRlZCB2
aWEgYXV0by1jb25uZWN0IHNjcmlwdHMuwqAgV2l0aCB0aGUgRkMgdHJhbnNwb3J0LCBpZiB0aGUK
Pj4gZmlyc3QgY29ubmVjdGlvbiBhdHRlbXB0IGZhaWxzLCB0aGUgY29udHJvbGxlciBlbnRlcnMg
YSBub3JtYWwgcmVjb25uZWN0Cj4+IHN0YXRlIGJ1dCByZXR1cm5zIGNvbnRyb2wgdG8gdGhlIGNs
aSB0aHJlYWQgdGhhdCBjcmVhdGVkIHRoZSBjb250cm9sbGVyLgo+PiBJbiB0aGlzIHNjZW5hcmlv
LCB0aGUgY2xpIGF0dGVtcHRzIHRvIHJlYWQgdGhlIGRpc2NvdmVyeSBsb2cgdmlhIGlvY3RsLAo+
PiB3aGljaCBmYWlscywgY2F1c2luZyB0aGUgY2xpIHRvIHNlZSBpdCBhcyBhbiBlbXB0eSBsb2cg
YW5kIHRoZW4gcHJvY2VlZHMKPj4gdG8gZGVsZXRlIHRoZSBkaXNjb3ZlcnkgY29udHJvbGxlci4g
VGhlIGRlbGV0ZSBpcyByZWplY3RlZCBhbmQgdGhlCj4+IGNvbnRyb2xsZXIgaXMgbGVmdCBsaXZl
LiBJZiB0aGUgZGlzY292ZXJ5IGNvbnRyb2xsZXIgcmVjb25uZWN0IHRoZW4KPj4gc3VjY2VlZHMs
IHRoZXJlIGlzIG5vIGFjdGlvbiB0byBkZWxldGUgaXQsIGFuZCBpdCBzaXRzIGxpdmUgZG9pbmcg
Cj4+IG5vdGhpbmcuCj4KPiBUaGlzIGlzIGluZGVlZCBhIHJlZ3Jlc3Npb24uCj4KPiBQZXJoYXBz
IHdlIHNob3VsZCBhbHNvIHJldmVydDoKPiAxMmEwYjY2MjIxMDcgKCJudm1lOiBkb24ndCBob2xk
IG52bWZfdHJhbnNwb3J0c19yd3NlbSBmb3IgbW9yZSB0aGFuIAo+IHRyYW5zcG9ydCBsb29rdXBz
IikKPgo+IFdoaWNoIGluaGVyZW50bHkgY2F1c2VkIHRoaXMgYnkgcmVtb3ZpbmcgdGhlIHNlcmlh
bGl6YXRpb24gb2YKPiAuY3JlYXRlX2N0cmwoKS4uLgoKbm8sIEkgYmVsaWV2ZSB0aGUgcGF0Y2gg
b24gdGhlIHNlbWFwaG9yZSBpcyBjb3JyZWN0LiBPdGhlcndpc2UgLSB0aGluZ3MgCmNhbiBiZSBi
bG9ja2VkIGEgbG9uZyB0aW1lLi4gYSBtaW51dGUgKDEgY21kIHRpbWVvdXQpIG9yIGV2ZW4gbXVs
dGlwbGUgCm1pbnV0ZXMgaW4gdGhlIGNhc2Ugd2hlcmUgYSBjb21tYW5kIGZhaWx1cmUgaW4gY29y
ZSBsYXllcnMgZWZmZWN0aXZlbHkgCmdldHMgaWdub3JlZCBhbmQgdGh1cyBkb2Vzbid0IGNhdXNl
IHRoZSBlcnJvciBwYXRoIGluIHRoZSB0cmFuc3BvcnQuwqAgClRoZXJlIGNhbiBiZSBtdWx0aXBs
ZSAvZGV2L252bWUtZmFicmljcyBjb21tYW5kcyBzdGFja2VkIHVwIHRoYXQgY2FuIAptYWtlIHRo
ZSBkZWxheXMgbG9vayBtdWNoIGxvbmdlciB0byB0aGUgbGFzdCBndXkuCgphcyBmYXIgYXMgY3Jl
YXRpb24gdnMgdGVhcmRvd24uLi4geWVhaCwgbm90IGZ1biwgYnV0IHRoZXJlIGFyZSBvdGhlciAK
d2F5cyB0byBkZWFsIHdpdGggaXQuIEZDOiBJIGdvdCByaWQgb2YgdGhlIHNlcGFyYXRlIGNyZWF0
ZS9yZWNvbm5lY3QgCnRocmVhZHMgYSB3aGlsZSBhZ28gdGh1cyB0aGUgcmV0dXJuLWNvbnRyb2wt
d2hpbGUtcmVjb25uZWN0aW5nIGJlaGF2aW9yLCAKc28gSSd2ZSBoYWQgdG8gZGVhbCB3aXRoIGl0
LsKgIEl0J3Mgb25lIGFyZWEgaXQnZCBiZSBuaWNlIHRvIHNlZSBzb21lIApjb252ZXJnZW5jZSBp
biBpbXBsZW1lbnRhdGlvbiBhZ2FpbiBiZXR3ZWVuIHRyYW5zcG9ydHMuCgotLSBqYW1lcwoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

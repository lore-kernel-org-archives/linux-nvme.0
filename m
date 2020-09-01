Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D3C433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 22:01:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145A7206C0
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 22:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZNAbUKzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145A7206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SZS7ymaZ1SEmkUz+CIozmV9QtTI4uJhyT0jYtAZBscQ=; b=ZNAbUKzNDlxesjkT1Hg9/+BvI
	X9bofhK5N+6IkctpjnIP8rCz+NQCcmYRMvIy0u+O+oJ149HyJNYD+UO5FQysroJXcfAm0GRz3OJHP
	VdZyjK+JEjNHtelPF3JAHuJlDPvwPprV0JS5HbwYb30Ysrx/pNNJZCtnDuEGlGKGBkacOV1IrKCWs
	WLhnNr/0F2KvZYlg3qfG0x+32a4RcEOgT53ZQ6SGrYFjzCRVlCy3CClFgK62Cj40BJbMAu2cBuXHZ
	M/3WjqAVHAA9PjeoWLtbb1JWpAfoofIOTArt2D4xTjU7EwJCVuto8PYtdXp80gRWRyMWSSMTCFh0x
	VMqD3oMxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDELG-0007cC-UH; Tue, 01 Sep 2020 22:01:26 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDELE-0007bP-3m
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 22:01:25 +0000
Received: by mail-pf1-f194.google.com with SMTP id 17so1626903pfw.9
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 15:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6Usj/YrrYooLFBIiEKYdngINfSiSPMYMA+NEAbatcIM=;
 b=I0oa60HfjrZnSh0a+5JDyABqk51pauU/kr0aPPSWzDC31RGVoTG36NBEnbBws/npUy
 sUAn9L2hD+/3hOt/nuytLs/r3Vu8fjpv+O+SMeDINNn85TU9s/HfmiLabLJcSNUw/TN3
 MTqPaNwlukcLkwIsekHn5DZ8eH0FP2I05E5UP6F2lIZTaV4Ezjl/fxnhd649jj3AEcjV
 876RRCQ47ohwz2gertXWiZNCobWoHo3lztd5tOiUu19VQDiXxGp9hY6+hokHTt5FPTh0
 KdFLjlv1JFDkmy1C3QeazN0EvZ41lGwGmIZ51vwrHeJryKuRDZI5lWFvstQwyDi1gWnN
 pdOg==
X-Gm-Message-State: AOAM531t7xYldSb/Ev34tGqS/KLRktC1K+OTgJHF+VTpQMj/rZPVivWn
 +dsMA+Lw27lTSgA1Gks/Ulc=
X-Google-Smtp-Source: ABdhPJyJVERwgPjzzt/aocsS1WdB0fk1euLPdtFD/GBVuYfnrWc9rN0D2etp2qHL261lyQ2CQXkmfA==
X-Received: by 2002:a62:82c3:: with SMTP id w186mr210319pfd.287.1598997681066; 
 Tue, 01 Sep 2020 15:01:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61c1:4660:c489:2347?
 ([2601:647:4802:9070:61c1:4660:c489:2347])
 by smtp.gmail.com with ESMTPSA id p9sm3167195pgb.48.2020.09.01.15.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 15:01:20 -0700 (PDT)
Subject: Re: [PATCH] nvme: Revert: Fix controller creation races with teardown
 flow
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20200828190150.34455-1-james.smart@broadcom.com>
 <0867c437-1521-c0c9-d7fa-6a615d88105a@grimberg.me>
 <a73cd06b-b319-d55f-1465-4263e08900ae@broadcom.com>
 <741ec2a7-7a38-9432-33fb-58227bf1f1f1@grimberg.me>
 <7f43e9db-974a-5e98-76a6-ed2f3bd0dc92@broadcom.com>
 <4aaad97e-03b5-5c22-af8e-ae7624e78991@grimberg.me>
 <f7d0c08f-2a34-fffa-7962-d0641bc579fd@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7e78b2e6-d103-23a1-a9ab-d12336a9c089@grimberg.me>
Date: Tue, 1 Sep 2020 15:01:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f7d0c08f-2a34-fffa-7962-d0641bc579fd@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_180124_153537_CD8BD8BC 
X-CRM114-Status: GOOD (  23.27  )
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

Cj4+Pj4+PiBUaGlzIGlzIGluZGVlZCBhIHJlZ3Jlc3Npb24uCj4+Pj4+Pgo+Pj4+Pj4gUGVyaGFw
cyB3ZSBzaG91bGQgYWxzbyByZXZlcnQ6Cj4+Pj4+PiAxMmEwYjY2MjIxMDcgKCJudm1lOiBkb24n
dCBob2xkIG52bWZfdHJhbnNwb3J0c19yd3NlbSBmb3IgbW9yZSAKPj4+Pj4+IHRoYW4gdHJhbnNw
b3J0IGxvb2t1cHMiKQo+Pj4+Pj4KPj4+Pj4+IFdoaWNoIGluaGVyZW50bHkgY2F1c2VkIHRoaXMg
YnkgcmVtb3ZpbmcgdGhlIHNlcmlhbGl6YXRpb24gb2YKPj4+Pj4+IC5jcmVhdGVfY3RybCgpLi4u
Cj4+Pj4+Cj4+Pj4+IG5vLCBJIGJlbGlldmUgdGhlIHBhdGNoIG9uIHRoZSBzZW1hcGhvcmUgaXMg
Y29ycmVjdC4gT3RoZXJ3aXNlIC0gCj4+Pj4+IHRoaW5ncyBjYW4gYmUgYmxvY2tlZCBhIGxvbmcg
dGltZS4uIGEgbWludXRlICgxIGNtZCB0aW1lb3V0KSBvciAKPj4+Pj4gZXZlbiBtdWx0aXBsZSBt
aW51dGVzIGluIHRoZSBjYXNlIHdoZXJlIGEgY29tbWFuZCBmYWlsdXJlIGluIGNvcmUgCj4+Pj4+
IGxheWVycyBlZmZlY3RpdmVseSBnZXRzIGlnbm9yZWQgYW5kIHRodXMgZG9lc24ndCBjYXVzZSB0
aGUgZXJyb3IgCj4+Pj4+IHBhdGggaW4gdGhlIHRyYW5zcG9ydC4gVGhlcmUgY2FuIGJlIG11bHRp
cGxlIC9kZXYvbnZtZS1mYWJyaWNzIAo+Pj4+PiBjb21tYW5kcyBzdGFja2VkIHVwIHRoYXQgY2Fu
IG1ha2UgdGhlIGRlbGF5cyBsb29rIG11Y2ggbG9uZ2VyIHRvIAo+Pj4+PiB0aGUgbGFzdCBndXku
Cj4+Pj4+Cj4+Pj4+IGFzIGZhciBhcyBjcmVhdGlvbiB2cyB0ZWFyZG93bi4uLiB5ZWFoLCBub3Qg
ZnVuLCBidXQgdGhlcmUgYXJlIAo+Pj4+PiBvdGhlciB3YXlzIHRvIGRlYWwgd2l0aCBpdC4gRkM6
IEkgZ290IHJpZCBvZiB0aGUgc2VwYXJhdGUgCj4+Pj4+IGNyZWF0ZS9yZWNvbm5lY3QgdGhyZWFk
cyBhIHdoaWxlIGFnbyB0aHVzIHRoZSAKPj4+Pj4gcmV0dXJuLWNvbnRyb2wtd2hpbGUtcmVjb25u
ZWN0aW5nIGJlaGF2aW9yLCBzbyBJJ3ZlIGhhZCB0byBkZWFsIAo+Pj4+PiB3aXRoIGl0LsKgIEl0
J3Mgb25lIGFyZWEgaXQnZCBiZSBuaWNlIHRvIHNlZSBzb21lIGNvbnZlcmdlbmNlIGluIAo+Pj4+
PiBpbXBsZW1lbnRhdGlvbiBhZ2FpbiBiZXR3ZWVuIHRyYW5zcG9ydHMuCj4+Pj4KPj4+PiBEb2Vz
bid0IGZjIGhhdmUgYSBidWcgdGhlcmU/IGluIGNyZWF0ZV9jdHJsIGFmdGVyIGZsdXNoaW5nIHRo
ZQo+Pj4+IGNvbm5lY3Rfd29yaywgd2hhdCBpcyB0ZWxsaW5nIGl0IGlmIGRlbGV0ZSBpcyBydW5u
aW5nIGluIHdpdGggaXQKPj4+PiAob3IgdGhhdCBpdCBhbHJlYWR5IHJhbi4uLikKPj4+Cj4+PiBJ
IGd1ZXNzIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHRoZSBidWcgaXMgeW91IGFyZSB0aGlua2lu
ZyBhYm91dC4gCj4+PiBNYXliZSB0aGVyZSdzIGEgc2hvcnQgcGVyaW9kIHRoYXQgdGhlIGN0cmwg
cHRyIGlzIHBlcmhhcHMgZnJlZWQsIHRodXMgCj4+PiB0aGUgcG9pbnRlciBzaG91bGRuJ3QgYmUg
dXNlZCAtIGJ1dCBJIGRvbid0IHNlZSBpdCBhcyBhbG1vc3QgCj4+PiBldmVyeXRoaW5nIGlzIHNp
bXBseSBsb29raW5nIGF0wqAgdGhlIHZhbHVlIG9mIHRoZSBwb2ludGVyLCBub3QgCj4+PiBkZXJl
ZmVyZW5jaW5nIGl0Lgo+Pgo+PiBJJ20gcmVmZXJyaW5nIHRvIG52bWVfZmNfaW5pdF9jdHJsLCBp
ZiBkZWxldGUgaGFwcGVucyB3aGlsZSBpdAo+PiBpcyB3YWl0aW5nIGluIGZsdXNoX2RlbGF5ZWRf
d29yaygmY3RybC0+Y29ubmVjdF93b3JrKTsgd29uJ3QgeW91Cj4+IGRlcmVmZXJlbmNlIGFuZCBy
ZXR1cm4gYSBjb250cm9sbGVyIHRoYXQgaXMgcG9zc2libHkgYWxyZWFkeQo+PiBkZWxldGVkL2Zy
ZWVkPwo+IAo+IG9rIC0gdGhhdCBtYXRjaGVzIG15ICJzaG9ydCBwZXJpb2QiIGFuZCBpdCBpcyBw
b3NzaWJsZSBhcyB0aGVyZSdzIG9uZSAKPiBpbW1lZGlhdGUgcHJpbnRmIHRoYXQgbWF5IGRlcmVm
ZXJlbmNlIHRoZSBwdHIuIEFmdGVyIHRoYXQsIGl0J3MgCj4gY29tcGFyaXNvbnMgb2YgdGhlIHBv
aW50ZXIgdmFsdWUuwqAgSSBjYW4gbW92ZSB0aGUgcHJpbnRmIHRvIGF2b2lkIHRoZSAKPiBpc3N1
ZS7CoCBUaGF0IHdpbmRvdydzIHJhdGhlciBzbWFsbC4KCkJ1dCB5b3UgYWxzbyByZXR1cm4gYmFj
ayAmY3RybC0+Y3RybCwgdGhhdCBpcyBhbm90aGVyIGRlcmVmZXJlbmNlLCBhbmQKd2hhdCB3aWxs
IG1ha2UgY3RybCB0byBiZSBhbiBFUlJfUFRSPwoKQW55d2F5LCB3ZSBzaG91bGQgcHJvYmFibHkg
Y29tZSB1cCB3aXRoIHNvbWV0aGluZyBtb3JlIHJvYnVzdC4uLgoKPj4+IEkgZG8gaGF2ZSBhIGJ1
ZyBvciB0d2/CoCB3aXRoIGRlbGV0ZSBhc3NvY2lhdGlvbiBmaWdodGluZyB3aXRoIAo+Pj4gY3Jl
YXRlX2Fzc29jaWF0aW9uIC0gYnV0IGl0J3MgbWFpbmx5IGR1ZSB0byBudm1lX2ZjX2Vycm9yX3Jl
Y292ZXJ5IAo+Pj4gbm90IHRoZSBkZWxldGUgcm91dGluZS4gSSd2ZSByZXdvcmtlZCB0aGlzIGFy
ZWEgYWZ0ZXIgc2VlaW5nIHlvdXIgCj4+PiBvdGhlciBwYXRjaGVzIGFuZCB3aWxsIGJlIHBvc3Rp
bmcgYWZ0ZXIgc29tZSBtb3JlIHRlc3RpbmcuwqAgQnV0IG5vIAo+Pj4gcmVhc29uIGZvciBzeW5j
aHJvbml6aW5nIGFsbCBjdHJsIGNyZWF0ZXMuCj4+Cj4+IElzIGl0IHRoYXQgYmlnIG9mIGFuIGlz
c3VlPyBpdCBzaG91bGQgZmFpbCByYXRoZXIgcXVpY2tseSBzaG91bGRuJ3QgaXQ/Cj4gCj4gbm90
IHN1cmUgd2hhdCB5b3UgYXJlIGFza2luZy7CoMKgIGlmIGl0J3MgaG93IGxvbmcgdG8gZmFpbCB0
aGUgY3JlYXRpb24gb2YgCj4gYSBuZXcgYXNzb2NpYXRpb24gLSBpdCdzIGF0IGxlYXN0IDYwcyAo
YW4gYWRtaW4gY29tbWFuZCB0aW1lb3V0KS4KClRoYXQncyB0aGUgd29yc3QgY2FzZSAoYWRtaW4g
Y29tbWFuZCB0aW1lb3V0KSwgYnV0IGlzIGl0IHRoZSBtb3N0IGNvbW1vbgpjYXNlPwoKV291bGQg
bWFraW5nIHRoZSB0aW1lb3V0cyBzaG9ydGVyIGluIHRoZSBpbml0aWFsIGNvbm5lY3QgbWFrZSBz
ZW5zZT8KSnVzdCB0aHJvd2luZyBvdXQgaWRlYXMuLi4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK

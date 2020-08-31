Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A259CC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 23:15:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3A32064B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 23:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="phKDSlEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3A32064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AvwAZkifIYgJazpOvbBnZoe4G0jhnXY+fGBs2e2y1xY=; b=phKDSlEG8Ef8keF0wwN0O8wjG
	LjF5wwVjS07t8uvMxguHNtXAgJdrMNndd+CHuS37mIllItwfxr/BRdUl+8k3lyhF9UvgXWFz4+eWg
	huJpn9KzmEJhvp2Bj1y8Z37T87rtIF3ALnk38MEJO8npwv6bjYBpIXBGM46Dkij0B4deU4WsJvwl0
	uvNgJDkUp5ZcaTkuhf1yoQkXoIxulzznecxu7CgmSErGItYWWnXnlMQFbomXGsxv8shFAhhMLfaga
	bZp+OW2636CIQLmLBITxmnRPI9465JvqenFeL/KpTUuKBu13uF1R7CYzKAp6mW4lB2r9zIBJiZVn0
	ugzEQv2NA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCt1R-0001SA-4m; Mon, 31 Aug 2020 23:15:33 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCt1N-0001R3-6P
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 23:15:30 +0000
Received: by mail-wm1-f66.google.com with SMTP id s13so986058wmh.4
 for <linux-nvme@lists.infradead.org>; Mon, 31 Aug 2020 16:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=seRWaFKsJJwnBdgycHCuz2a6iCNGF+LkQ7CY/HVXfsU=;
 b=oM+I2cmJ6zJ34MlOcH3cEMc4u3sdC7b1xQVikx2iv+cdOCgTKuqB/kKn31pUXR4IZt
 4a9OQqMj8kPd1v2dQwZerKYWmh/2xb8d93/eWQFdsXFPgcPoO6ExU0S8SzZlbLOt2y7M
 80RAtKwEt/VtD7b9Y2dh+JUXqCBKjdfHq1X0whDEzRLlOUBleiRIz5qC66AKz8A7LgIf
 NGz/12yAJXn9WUoQQR90v/bYsmat5qXwF9pHowFwO2QDCJWHJ9EozC10MgS19Av33Jmg
 07NrL7t+tDYUKSVJrUyUS25l2glM8l+AS3RUsB0fa5v47vPL6EPPbdKD+LinB08bs1Ya
 ntPA==
X-Gm-Message-State: AOAM532sA7DrZYyy/LgaqqcsX/pvN2kPutmIYKKPAKFxq2LS+6JHFIsm
 acaPPN1hmsIAsq76xHjV/SU=
X-Google-Smtp-Source: ABdhPJwjeTo1bu3yF5TVq02iSWppnI2TlBLv8tK8HdAUqLvuxHKeYPAgicSq6kx2aC+RS5mJPdtfhg==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr1371306wmh.152.1598915727686; 
 Mon, 31 Aug 2020 16:15:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:70b6:3990:a389:c0d1?
 ([2601:647:4802:9070:70b6:3990:a389:c0d1])
 by smtp.gmail.com with ESMTPSA id v24sm16254240wrd.6.2020.08.31.16.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 16:15:26 -0700 (PDT)
Subject: Re: [PATCH] nvme: Revert: Fix controller creation races with teardown
 flow
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20200828190150.34455-1-james.smart@broadcom.com>
 <0867c437-1521-c0c9-d7fa-6a615d88105a@grimberg.me>
 <a73cd06b-b319-d55f-1465-4263e08900ae@broadcom.com>
 <741ec2a7-7a38-9432-33fb-58227bf1f1f1@grimberg.me>
 <7f43e9db-974a-5e98-76a6-ed2f3bd0dc92@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4aaad97e-03b5-5c22-af8e-ae7624e78991@grimberg.me>
Date: Mon, 31 Aug 2020 16:15:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7f43e9db-974a-5e98-76a6-ed2f3bd0dc92@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_191529_347138_73B1E0FB 
X-CRM114-Status: GOOD (  23.70  )
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

Cj4+Pj4gVGhpcyBpcyBpbmRlZWQgYSByZWdyZXNzaW9uLgo+Pj4+Cj4+Pj4gUGVyaGFwcyB3ZSBz
aG91bGQgYWxzbyByZXZlcnQ6Cj4+Pj4gMTJhMGI2NjIyMTA3ICgibnZtZTogZG9uJ3QgaG9sZCBu
dm1mX3RyYW5zcG9ydHNfcndzZW0gZm9yIG1vcmUgdGhhbiAKPj4+PiB0cmFuc3BvcnQgbG9va3Vw
cyIpCj4+Pj4KPj4+PiBXaGljaCBpbmhlcmVudGx5IGNhdXNlZCB0aGlzIGJ5IHJlbW92aW5nIHRo
ZSBzZXJpYWxpemF0aW9uIG9mCj4+Pj4gLmNyZWF0ZV9jdHJsKCkuLi4KPj4+Cj4+PiBubywgSSBi
ZWxpZXZlIHRoZSBwYXRjaCBvbiB0aGUgc2VtYXBob3JlIGlzIGNvcnJlY3QuIE90aGVyd2lzZSAt
IAo+Pj4gdGhpbmdzIGNhbiBiZSBibG9ja2VkIGEgbG9uZyB0aW1lLi4gYSBtaW51dGUgKDEgY21k
IHRpbWVvdXQpIG9yIGV2ZW4gCj4+PiBtdWx0aXBsZSBtaW51dGVzIGluIHRoZSBjYXNlIHdoZXJl
IGEgY29tbWFuZCBmYWlsdXJlIGluIGNvcmUgbGF5ZXJzIAo+Pj4gZWZmZWN0aXZlbHkgZ2V0cyBp
Z25vcmVkIGFuZCB0aHVzIGRvZXNuJ3QgY2F1c2UgdGhlIGVycm9yIHBhdGggaW4gdGhlIAo+Pj4g
dHJhbnNwb3J0LiBUaGVyZSBjYW4gYmUgbXVsdGlwbGUgL2Rldi9udm1lLWZhYnJpY3MgY29tbWFu
ZHMgc3RhY2tlZCAKPj4+IHVwIHRoYXQgY2FuIG1ha2UgdGhlIGRlbGF5cyBsb29rIG11Y2ggbG9u
Z2VyIHRvIHRoZSBsYXN0IGd1eS4KPj4+Cj4+PiBhcyBmYXIgYXMgY3JlYXRpb24gdnMgdGVhcmRv
d24uLi4geWVhaCwgbm90IGZ1biwgYnV0IHRoZXJlIGFyZSBvdGhlciAKPj4+IHdheXMgdG8gZGVh
bCB3aXRoIGl0LiBGQzogSSBnb3QgcmlkIG9mIHRoZSBzZXBhcmF0ZSBjcmVhdGUvcmVjb25uZWN0
IAo+Pj4gdGhyZWFkcyBhIHdoaWxlIGFnbyB0aHVzIHRoZSByZXR1cm4tY29udHJvbC13aGlsZS1y
ZWNvbm5lY3RpbmcgCj4+PiBiZWhhdmlvciwgc28gSSd2ZSBoYWQgdG8gZGVhbCB3aXRoIGl0LsKg
IEl0J3Mgb25lIGFyZWEgaXQnZCBiZSBuaWNlIHRvIAo+Pj4gc2VlIHNvbWUgY29udmVyZ2VuY2Ug
aW4gaW1wbGVtZW50YXRpb24gYWdhaW4gYmV0d2VlbiB0cmFuc3BvcnRzLgo+Pgo+PiBEb2Vzbid0
IGZjIGhhdmUgYSBidWcgdGhlcmU/IGluIGNyZWF0ZV9jdHJsIGFmdGVyIGZsdXNoaW5nIHRoZQo+
PiBjb25uZWN0X3dvcmssIHdoYXQgaXMgdGVsbGluZyBpdCBpZiBkZWxldGUgaXMgcnVubmluZyBp
biB3aXRoIGl0Cj4+IChvciB0aGF0IGl0IGFscmVhZHkgcmFuLi4uKQo+IAo+IEkgZ3Vlc3MgSSBk
b24ndCB1bmRlcnN0YW5kIHdoYXQgdGhlIGJ1ZyBpcyB5b3UgYXJlIHRoaW5raW5nIGFib3V0LiBN
YXliZSAKPiB0aGVyZSdzIGEgc2hvcnQgcGVyaW9kIHRoYXQgdGhlIGN0cmwgcHRyIGlzIHBlcmhh
cHMgZnJlZWQsIHRodXMgdGhlIAo+IHBvaW50ZXIgc2hvdWxkbid0IGJlIHVzZWQgLSBidXQgSSBk
b24ndCBzZWUgaXQgYXMgYWxtb3N0IGV2ZXJ5dGhpbmcgaXMgCj4gc2ltcGx5IGxvb2tpbmcgYXTC
oCB0aGUgdmFsdWUgb2YgdGhlIHBvaW50ZXIsIG5vdCBkZXJlZmVyZW5jaW5nIGl0LgoKSSdtIHJl
ZmVycmluZyB0byBudm1lX2ZjX2luaXRfY3RybCwgaWYgZGVsZXRlIGhhcHBlbnMgd2hpbGUgaXQK
aXMgd2FpdGluZyBpbiBmbHVzaF9kZWxheWVkX3dvcmsoJmN0cmwtPmNvbm5lY3Rfd29yayk7IHdv
bid0IHlvdQpkZXJlZmVyZW5jZSBhbmQgcmV0dXJuIGEgY29udHJvbGxlciB0aGF0IGlzIHBvc3Np
Ymx5IGFscmVhZHkKZGVsZXRlZC9mcmVlZD8KCj4gSSBkbyBoYXZlIGEgYnVnIG9yIHR3b8KgIHdp
dGggZGVsZXRlIGFzc29jaWF0aW9uIGZpZ2h0aW5nIHdpdGggCj4gY3JlYXRlX2Fzc29jaWF0aW9u
IC0gYnV0IGl0J3MgbWFpbmx5IGR1ZSB0byBudm1lX2ZjX2Vycm9yX3JlY292ZXJ5IG5vdCAKPiB0
aGUgZGVsZXRlIHJvdXRpbmUuIEkndmUgcmV3b3JrZWQgdGhpcyBhcmVhIGFmdGVyIHNlZWluZyB5
b3VyIG90aGVyIAo+IHBhdGNoZXMgYW5kIHdpbGwgYmUgcG9zdGluZyBhZnRlciBzb21lIG1vcmUg
dGVzdGluZy7CoCBCdXQgbm8gcmVhc29uIGZvciAKPiBzeW5jaHJvbml6aW5nIGFsbCBjdHJsIGNy
ZWF0ZXMuCgpJcyBpdCB0aGF0IGJpZyBvZiBhbiBpc3N1ZT8gaXQgc2hvdWxkIGZhaWwgcmF0aGVy
IHF1aWNrbHkgc2hvdWxkbid0IGl0PwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=

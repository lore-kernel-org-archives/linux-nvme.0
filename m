Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8CEC433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B9E2166E
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kKDzNmGT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fb4BLgz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B9E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=agFg3Hp9T3QUFJNIMNfc0W4Aem+j7+1akivgKF/X8rQ=; b=kKDzNmGTsvmTN7ibySW4TGawV
	NIpS+81qHe+Sw83K5KGqMtbf2I/siPkyZfM/VxuQ0N7KfWaD1c6n9JzhutJkE50YDpLLPDU9nrcUr
	DCYj6aPwYrYLswJk3AbEmK7g5tNyANaUgGDSl2mB6h7KAZJbIaOvGyS3xaXqI3plPRpRg7SkooifX
	kSIyEnqCIhBaaNIKVeUbFRcGo6F8jm2cWSi2AVzomaxZ070htZuxYPHY8kZkFYR37HkGL16fu5LkP
	p5kKKLklZY91sx3RvburmZHspS3u0iMPi4ixZ8TtK/iWSgalRJUu4zvTFfqgoa2/Wd8iYw3opR+wq
	h3Hn6VEAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8NQ-0007lP-HG; Tue, 01 Sep 2020 15:39:16 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8NM-0007gS-JT
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 15:39:14 +0000
Received: by mail-pl1-x644.google.com with SMTP id z15so712064plo.7
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RRYvOyhoaQLRQoFkDFrEsXiZ7Zuv9koBevcFN6f7MdA=;
 b=fb4BLgz31jdUT+jWAnohNdHQUwUJHxaFUJt0+J/RU5BfLmW2fBf7g1HNkJyalHzIsh
 +yIjNhMhHBR2fimg4rDDSLiHuGeltYKKuhkBwlic4kPNOmCz2LDdDGqvDrI2s/HWsh+5
 D2oKM4a3iwbdfb59An1vtscw4AddW1xUYG/Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RRYvOyhoaQLRQoFkDFrEsXiZ7Zuv9koBevcFN6f7MdA=;
 b=p70VYfOsQpjlMu7wpPFK/hXVITt9r0bxCmv2Ar2NTqhm5oZB3s3Q7WqsPDz0mtJy9V
 3sXtV2UscKjKqYShx5T8xrRhB7UJEJsZ3Y04rf7zfq4DeH77Y5BTYixX0By/E/mdfJqi
 wAlT9lVWahWGqkbPPFDYrhgQ9CQAORewFBeBOrysHSZnQ2D1ddgaxyysHsbXZOv516dv
 /P74LcIGR1IGshquNv4CSCATgGpvtjhxm544xAEYfQahoHGshL8dMyOZ33eovPrMyTKV
 XEd09pXV1Hc09xr5Tf8/Ol03O63Lckw1YdIIkveKcaz8x8RFvh09Mgver3rpH9jNitH6
 faYQ==
X-Gm-Message-State: AOAM530uAbIzN7c3ctT4KKZhM8UKWi4XryROpFGh1oVBSpZ8QspJ5sss
 BaaYnsAFTmUnqneLOWq3rEZjdw==
X-Google-Smtp-Source: ABdhPJyuz29Q+A2EIyORe/+mF4K2G3GRqfvu/UuqUbugW3UoA4t0xljuSeaKWLOccqV8dP30q6tVBQ==
X-Received: by 2002:a17:902:6841:: with SMTP id
 f1mr1897802pln.228.1598974744061; 
 Tue, 01 Sep 2020 08:39:04 -0700 (PDT)
Received: from [10.230.128.89] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id d15sm2424063pfr.143.2020.09.01.08.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 08:39:03 -0700 (PDT)
Subject: Re: [PATCH] nvme: Revert: Fix controller creation races with teardown
 flow
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20200828190150.34455-1-james.smart@broadcom.com>
 <0867c437-1521-c0c9-d7fa-6a615d88105a@grimberg.me>
 <a73cd06b-b319-d55f-1465-4263e08900ae@broadcom.com>
 <741ec2a7-7a38-9432-33fb-58227bf1f1f1@grimberg.me>
 <7f43e9db-974a-5e98-76a6-ed2f3bd0dc92@broadcom.com>
 <4aaad97e-03b5-5c22-af8e-ae7624e78991@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <f7d0c08f-2a34-fffa-7962-d0641bc579fd@broadcom.com>
Date: Tue, 1 Sep 2020 08:39:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
MIME-Version: 1.0
In-Reply-To: <4aaad97e-03b5-5c22-af8e-ae7624e78991@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_113912_873919_8108ECA8 
X-CRM114-Status: GOOD (  24.08  )
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

CgpPbiA4LzMxLzIwMjAgNDoxNSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+Pj4+PiBUaGlz
IGlzIGluZGVlZCBhIHJlZ3Jlc3Npb24uCj4+Pj4+Cj4+Pj4+IFBlcmhhcHMgd2Ugc2hvdWxkIGFs
c28gcmV2ZXJ0Ogo+Pj4+PiAxMmEwYjY2MjIxMDcgKCJudm1lOiBkb24ndCBob2xkIG52bWZfdHJh
bnNwb3J0c19yd3NlbSBmb3IgbW9yZSAKPj4+Pj4gdGhhbiB0cmFuc3BvcnQgbG9va3VwcyIpCj4+
Pj4+Cj4+Pj4+IFdoaWNoIGluaGVyZW50bHkgY2F1c2VkIHRoaXMgYnkgcmVtb3ZpbmcgdGhlIHNl
cmlhbGl6YXRpb24gb2YKPj4+Pj4gLmNyZWF0ZV9jdHJsKCkuLi4KPj4+Pgo+Pj4+IG5vLCBJIGJl
bGlldmUgdGhlIHBhdGNoIG9uIHRoZSBzZW1hcGhvcmUgaXMgY29ycmVjdC4gT3RoZXJ3aXNlIC0g
Cj4+Pj4gdGhpbmdzIGNhbiBiZSBibG9ja2VkIGEgbG9uZyB0aW1lLi4gYSBtaW51dGUgKDEgY21k
IHRpbWVvdXQpIG9yIAo+Pj4+IGV2ZW4gbXVsdGlwbGUgbWludXRlcyBpbiB0aGUgY2FzZSB3aGVy
ZSBhIGNvbW1hbmQgZmFpbHVyZSBpbiBjb3JlIAo+Pj4+IGxheWVycyBlZmZlY3RpdmVseSBnZXRz
IGlnbm9yZWQgYW5kIHRodXMgZG9lc24ndCBjYXVzZSB0aGUgZXJyb3IgCj4+Pj4gcGF0aCBpbiB0
aGUgdHJhbnNwb3J0LiBUaGVyZSBjYW4gYmUgbXVsdGlwbGUgL2Rldi9udm1lLWZhYnJpY3MgCj4+
Pj4gY29tbWFuZHMgc3RhY2tlZCB1cCB0aGF0IGNhbiBtYWtlIHRoZSBkZWxheXMgbG9vayBtdWNo
IGxvbmdlciB0byAKPj4+PiB0aGUgbGFzdCBndXkuCj4+Pj4KPj4+PiBhcyBmYXIgYXMgY3JlYXRp
b24gdnMgdGVhcmRvd24uLi4geWVhaCwgbm90IGZ1biwgYnV0IHRoZXJlIGFyZSAKPj4+PiBvdGhl
ciB3YXlzIHRvIGRlYWwgd2l0aCBpdC4gRkM6IEkgZ290IHJpZCBvZiB0aGUgc2VwYXJhdGUgCj4+
Pj4gY3JlYXRlL3JlY29ubmVjdCB0aHJlYWRzIGEgd2hpbGUgYWdvIHRodXMgdGhlIAo+Pj4+IHJl
dHVybi1jb250cm9sLXdoaWxlLXJlY29ubmVjdGluZyBiZWhhdmlvciwgc28gSSd2ZSBoYWQgdG8g
ZGVhbCAKPj4+PiB3aXRoIGl0LsKgIEl0J3Mgb25lIGFyZWEgaXQnZCBiZSBuaWNlIHRvIHNlZSBz
b21lIGNvbnZlcmdlbmNlIGluIAo+Pj4+IGltcGxlbWVudGF0aW9uIGFnYWluIGJldHdlZW4gdHJh
bnNwb3J0cy4KPj4+Cj4+PiBEb2Vzbid0IGZjIGhhdmUgYSBidWcgdGhlcmU/IGluIGNyZWF0ZV9j
dHJsIGFmdGVyIGZsdXNoaW5nIHRoZQo+Pj4gY29ubmVjdF93b3JrLCB3aGF0IGlzIHRlbGxpbmcg
aXQgaWYgZGVsZXRlIGlzIHJ1bm5pbmcgaW4gd2l0aCBpdAo+Pj4gKG9yIHRoYXQgaXQgYWxyZWFk
eSByYW4uLi4pCj4+Cj4+IEkgZ3Vlc3MgSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgdGhlIGJ1ZyBp
cyB5b3UgYXJlIHRoaW5raW5nIGFib3V0LiAKPj4gTWF5YmUgdGhlcmUncyBhIHNob3J0IHBlcmlv
ZCB0aGF0IHRoZSBjdHJsIHB0ciBpcyBwZXJoYXBzIGZyZWVkLCB0aHVzIAo+PiB0aGUgcG9pbnRl
ciBzaG91bGRuJ3QgYmUgdXNlZCAtIGJ1dCBJIGRvbid0IHNlZSBpdCBhcyBhbG1vc3QgCj4+IGV2
ZXJ5dGhpbmcgaXMgc2ltcGx5IGxvb2tpbmcgYXTCoCB0aGUgdmFsdWUgb2YgdGhlIHBvaW50ZXIs
IG5vdCAKPj4gZGVyZWZlcmVuY2luZyBpdC4KPgo+IEknbSByZWZlcnJpbmcgdG8gbnZtZV9mY19p
bml0X2N0cmwsIGlmIGRlbGV0ZSBoYXBwZW5zIHdoaWxlIGl0Cj4gaXMgd2FpdGluZyBpbiBmbHVz
aF9kZWxheWVkX3dvcmsoJmN0cmwtPmNvbm5lY3Rfd29yayk7IHdvbid0IHlvdQo+IGRlcmVmZXJl
bmNlIGFuZCByZXR1cm4gYSBjb250cm9sbGVyIHRoYXQgaXMgcG9zc2libHkgYWxyZWFkeQo+IGRl
bGV0ZWQvZnJlZWQ/CgpvayAtIHRoYXQgbWF0Y2hlcyBteSAic2hvcnQgcGVyaW9kIiBhbmQgaXQg
aXMgcG9zc2libGUgYXMgdGhlcmUncyBvbmUgCmltbWVkaWF0ZSBwcmludGYgdGhhdCBtYXkgZGVy
ZWZlcmVuY2UgdGhlIHB0ci4gQWZ0ZXIgdGhhdCwgaXQncyAKY29tcGFyaXNvbnMgb2YgdGhlIHBv
aW50ZXIgdmFsdWUuwqAgSSBjYW4gbW92ZSB0aGUgcHJpbnRmIHRvIGF2b2lkIHRoZSAKaXNzdWUu
wqAgVGhhdCB3aW5kb3cncyByYXRoZXIgc21hbGwuCgoKPgo+PiBJIGRvIGhhdmUgYSBidWcgb3Ig
dHdvwqAgd2l0aCBkZWxldGUgYXNzb2NpYXRpb24gZmlnaHRpbmcgd2l0aCAKPj4gY3JlYXRlX2Fz
c29jaWF0aW9uIC0gYnV0IGl0J3MgbWFpbmx5IGR1ZSB0byBudm1lX2ZjX2Vycm9yX3JlY292ZXJ5
IAo+PiBub3QgdGhlIGRlbGV0ZSByb3V0aW5lLiBJJ3ZlIHJld29ya2VkIHRoaXMgYXJlYSBhZnRl
ciBzZWVpbmcgeW91ciAKPj4gb3RoZXIgcGF0Y2hlcyBhbmQgd2lsbCBiZSBwb3N0aW5nIGFmdGVy
IHNvbWUgbW9yZSB0ZXN0aW5nLsKgIEJ1dCBubyAKPj4gcmVhc29uIGZvciBzeW5jaHJvbml6aW5n
IGFsbCBjdHJsIGNyZWF0ZXMuCj4KPiBJcyBpdCB0aGF0IGJpZyBvZiBhbiBpc3N1ZT8gaXQgc2hv
dWxkIGZhaWwgcmF0aGVyIHF1aWNrbHkgc2hvdWxkbid0IGl0PwoKbm90IHN1cmUgd2hhdCB5b3Ug
YXJlIGFza2luZy7CoMKgIGlmIGl0J3MgaG93IGxvbmcgdG8gZmFpbCB0aGUgY3JlYXRpb24gb2Yg
CmEgbmV3IGFzc29jaWF0aW9uIC0gaXQncyBhdCBsZWFzdCA2MHMgKGFuIGFkbWluIGNvbW1hbmQg
dGltZW91dCkuCgotLSBqYW1lcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK

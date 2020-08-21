Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59436C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 15:22:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269B92076E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 15:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ahohs9WV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fn9o189P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269B92076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q0aZ8aw0yyHUpiZOO62ZpHiimdO9ac78rAGFx9uxSgc=; b=ahohs9WVJf98NVRcmep/RoNYQ
	tg9NDgkzoaGw1UjnMz9kZ0XHp0NfrO+c207A4ALIjEF/rgPlKoxT/uz88U3Dc/Aym4vVNv14D+rum
	YasRF3Jt5PKdkbkdY10TUByRxIDrVzJp5eput/fJcumG58qtRVBgqfG/01HrmtzsmTd06x/RppWK1
	LduzTBCmBBDh/UBEMeCHwVL7WB1lwC9+7E2VWIpfmlCjWdYHqcInXR5exGQh1DdU0soK/ESAEZ+7F
	dLLE8IZKe82WSzF2eA9z2xKf1Mw8hvFXNbFI4IWPuFXpf+qo73mQYaMIuAVEgAUEawsLE4XKXC+6e
	jAr7mwh2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k98rt-000384-KI; Fri, 21 Aug 2020 15:22:13 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k98rq-00037E-T9
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 15:22:12 +0000
Received: by mail-pl1-x643.google.com with SMTP id b11so1011188pld.7
 for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2020 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=C4RP8HKBpzPeCJoWPn2CksSQndEBHNh91YqGA79jung=;
 b=Fn9o189PR2hDaJcCysfs6J88HvNZo8z9gO/ynelkTMj9A5MV1IAgoKMriQjwYU7Q/4
 h9fpjTYaIjC3TXKMSqVelZJbxADVvHArX5On6Y+ZA1sVq42I6HyPSfzq/uJBqm4GTGlf
 pfRDvcDcGERygUs3bbwgDBFhIbh52t1bem33A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=C4RP8HKBpzPeCJoWPn2CksSQndEBHNh91YqGA79jung=;
 b=YcEVI2vbRuCeTqF+dvLNS9ov/P9UQBzp4OonTdDOyqfbMaJh0F0lM1yvXiRu9i3Yef
 vNHJMFNGyMrfW5suBI1NaaiOtzNahJZqYXbmMwdMIu1FbF79l1rrB0svupW7+hAUI73U
 Y3UyovbXYlRInf/0CE7cxLPvF3hHs+SGlS2F+L/f4XBybIw7uhwuch83w1idEXXf5aj/
 NQnY9rBHov6WqzivPmvL7u8VsDqqIEzXwrCdMYmwkSDIDLeCqRcqeb9x090iY9vYPzFi
 0pJjuiLebZ5S3SzHagnb169S9mNXExmUm8H8cIJQa27BLZRezdASUKQfVqa5U5MAV0+P
 D81A==
X-Gm-Message-State: AOAM533mygAVn+hXeioP4M+6VixvzTRMdcvRmp7Kiap9UVEdU+R9DPQM
 ieKwZsZ+9uEaSbOMSq2DQg3l3xfB0/Hu9PnHmONxAbRqCxaJ7hss5JSVxJgschVzbdmtf/tWgcV
 qz56iJQ39Y6dFQMa7cXtOamCFg1RFxhJl0E2MGPoX7Ur7WI0W8ybsgP+ezKX2OGT+hdDKnp+jsI
 V0jMRkH6in
X-Google-Smtp-Source: ABdhPJz+yFuAdxIITPGX8v7QCxKSd7sxpT9b0LOQaGm7b355MdhXEGIVWcxICcIRzqeS42Pzc2/BUQ==
X-Received: by 2002:a17:90b:3641:: with SMTP id
 nh1mr2858164pjb.157.1598023327144; 
 Fri, 21 Aug 2020 08:22:07 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id gz7sm2272072pjb.45.2020.08.21.08.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 08:22:05 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <75caf43b-818a-c393-bbe9-9e6fde5705e5@broadcom.com>
Date: Fri, 21 Aug 2020 08:22:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200821062217.GC28559@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_112211_159160_CAF8ED5D 
X-CRM114-Status: GOOD (  21.95  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOC8yMC8yMDIwIDExOjIyIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBUaHUs
IEF1ZyAyMCwgMjAyMCBhdCAwMTo0NTo1MFBNIC0wNzAwLCBKYW1lcyBTbWFydCB3cm90ZToKPj4g
SSBzdGlsbCBkaXNsaWtlIGFueSByYW5kb20gaW9jdGxzIGNvbWluZyBpbiB3aGlsZSB3ZSdyZSBz
dGlsbCBpbml0aWFsaXppbmcKPj4gdGhlIGNvbnRyb2xsZXIuCj4gQWdyZWVkLgo+Cj4+ICDCoCBM
b29raW5nIGF0IHRoZSBmbG93IC0gSSB3b3VsZG4ndCB3YW50IHRoZW0gdG8gYmUgYWxsb3dlZAo+
PiB1bnRpbCBhZnRlciBudm1lX2luaXRfaWRlbnRpZnkoKSBpcyBjb21wbGV0ZS4gRXNwZWNpYWxs
eSBpZiB0aGUgaW9jdGxzIGFyZQo+PiBkb2luZyBzdWJzeXN0ZW0gb3IgY29udHJvbGxlciBkdW1w
aW5nIG9yIHVzaW5nIGNvbW1hbmRzIHRoYXQgc2hvdWxkIGJlCj4+IGNhcHBlZCBieSB2YWx1ZXMg
c2V0IGJ5IG52bWVfcXVldWVfbGltaXRzKCkuwqDCoCBCdXQsIGlmIHdlJ3JlIGdvaW5nIHRvCj4+
IGFsbG93IG52bWVfaW5pdF9pZGVudGlmeSB0aGUgYWRtaW5fcSBuZWVkcyB0byBiZSB1bnF1aWVz
Y2VkLgo+Pgo+PiBTbyBJJ20gc3RpbGwgdm90aW5nIGZvciB0aGUgYWRtaW4gcXVldWUgZXhjZXB0
aW9uLgo+IEFuZCBJIHJlYWxseSBkb24ndCBsaWtlIHRoZSBhZG1pbiBxdWV1ZSBzcGVjaWFsIGNh
c2UuICBXaGF0IGlzIHRoZQo+IGFkdmFudGFnZSBvZiBsZXR0aW5nIHVzZXIgc3BhY2UgcGFzc3Ro
cm91Z2ggSS9PIGNvbW1hbmRzIGluIGF0IHRoaXMKPiBwb2ludCBpbiB0aW1lPwoKWW91IHNvbWV3
aGF0IGxvc3QgbWUuLi4gdGhlIHNwZWNpYWwgY2FzZS9leGNlcHRpb24gaXMgd2hhdCBwcmV2ZW50
cyB0aGUgCmNvbW1hbmRzIGluIGF0IHRoaXMgcG9pbnQgaW4gdGltZS7CoCBJIGRvbid0IGtub3cg
b2YgYW4gYWR2YW50YWdlIHRvIApsZXR0aW5nIHRoZW0gdGhyb3VnaC4KCkluIHNvbWUgcmVzcGVj
dHMsIHRoaXMgZ29lcyBiYWNrIHRvIHRoZSBpb2N0bCBpc3N1ZSBmcm9tIHRoZSBjbGkgdGhhdCB3
ZSAKaGFkIDEuNSsgeXJzIGFnby4uLiB3aGVyZSB3ZSBiYWNrZWQgb3V0IHJldHJ5IHBhdGNoZXMu
wqAgVGhlIGRlc2lyZSB3YXMgCnRvIGhhdmUgdGhlIGlvY3RsIHJlamVjdGVkIGlmIHRoZSBzdGF0
ZSB3YXNuJ3QgbGl2ZS4gR3JhbnRlZCwgdGhlcmUncyAKc3RpbGwgdGhlIHJhY2Ugb2YgaXQgcGFz
c2luZyB0aGlzIGNoZWNrIGJ1dCBjb250cm9sbGVyIGNoYW5naW5nIHN0YXRlIGJ5IAp0aGUgdGlt
ZSB0aGUgcmVxdWVzdCBjb21lcyBvZmYgdGhlIHJlcXVlc3QgcXVldWUgKHdoaWNoIGlzIHVsdGlt
YXRlbHkgCndoYXQgdGhpcyBleGNlcHRpb24gcHJldmVudHMpLiBUaGUgYmlnZ2VzdCBpc3N1ZSBJ
J3ZlIHNlZW4gaXMgdGhhdCBpbiAKYmV0d2VlbiB0aGUgMXN0IGNvbm5lY3QgYW5kIHRoZSByZWFk
IG9mIHRoZSBkaXNjb3ZlcnkgbG9nLCBzb21ldGhpbmcgCmhhcHBlbmVkIHN1Y2ggdGhhdCB0aGUg
Y29udHJvbGxlciBpcyBzdGlsbCBjb25uZWN0ZWQgeWV0IGhhcyB0byBnbyAKdGhyb3VnaCBhIHJl
Y29ubmVjdC4gVGhlIGNsaSBzYXcgdGhlIGVycm9yIG9uIHRoZSByZWFkIGxvZyBpb2N0bCwgZ2l2
ZXMgCnVwLCB0aGVuIHByb2NlZWRzIHdpdGggaXQncyBleGl0IHBhdGggdGhhdCBkZWxldGVzIHRo
ZSBjb250cm9sbGVyIC0gCmxlYXZpbmcgbm90aGluZyBkaXNjb3ZlcmVkIGFuZCBubyBldmVudCB0
byBjYXVzZSBpdCB0byByZXRyeS7CoCBXaGVuIHdlIApsYXN0IGRpc2N1c3NlZCB0aGlzIC0gd2Ug
d2VyZSBsb29raW5nIGZvciBraWxsYWJsZSBpb2N0bHMgYW5kIGFsc28gCndhbnRlZCB0byBhZGQg
cmV0cmllcyB0byBudm1lLWNsaSBidXQgdXNpbmcgYSBzdGFuZGFyZCBtZXRob2QuwqDCoCBJJ3Zl
IApoYWQgc29tZW9uZSB3b3JraW5nIHdpdGggbWUgb24gcHV0dGluZyBhdCBsZWFzdCB0aGUgcmV0
cnkgcGFydCBpbnRvIHRoZSAKY2xpIHNvIEknbGwgcG9zdCB0aGVtIHNvb24uCgpSZWdhcmRsZXNz
IC0gZ2l2ZW4gdGhlcmUncyB0aGUgd2luZG93IGJldHdlZW4gY2hlY2sgYW5kIHJlcXVlc3QgYmVp
bmcgCmV4ZWN1dGVkIGJ5IHRoZSBoYW5kbGVyIC0gSSBkb24ndCBzZWUgaXQgd29ydGh3aGlsZSB0
byByZW1vdmUgdGhlIApzcGVjaWFsIGNhc2UuCgotLSBqYW1lcwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

Return-Path: <SRS0=7/L5=4P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4592AC4BA24
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 01:47:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F55208E4
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 01:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZb649sy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GrRrlvZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F55208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=exwkVEujKkQ9rdgWZL5bqeCly7AsBO74v2xMxXqy2wc=; b=cZb649syRwda3rH7M+nobqEPb
	dvaveDV6QIZ1oU3mXsAzeoZ0OeH5+8S5Iuc/hYHGrgZHHScaodP0VsGfPA0YXfvjkM+taQ6Sn/Jbf
	N+rMqfCFfTm+0seg6+P+X/U2Ssw7nMH/2mbpkPJ5XmZW15fIZLuhwJJJaQHqKtQtoxN7Ah/LhW3bU
	WmgAaBAfOQJHDBX8ti/dAUyDhbU8S816xvNNVcw+MiMjHDqpOEmV2tjRhIRYK+mtK5eppTJuzBpOH
	bdzS6DtF3983I6vGo2eN7Ij0ZvqY/TbDchZ2QBKtZ8yWZ/pWpRcy6AH4ERYLI0eYSu5JIYbEwkl9E
	Ln7WWN8IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j78GP-0006Eo-8p; Thu, 27 Feb 2020 01:46:57 +0000
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j78GL-0006Dt-RG
 for linux-nvme@lists.infradead.org; Thu, 27 Feb 2020 01:46:55 +0000
Received: by mail-pj1-x1043.google.com with SMTP id gv17so446051pjb.1
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 17:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=inNbUrXZOUEfsSXJu7i6Sd4I1VyGy/gNTlBVC2kOfHQ=;
 b=GrRrlvZotkr6qZCmZd2hTzkOkrZzNnKr3cZMDKXRhpfkAmDEbX9ww1Lky34c+hs7fr
 9w60Ufvy62tViC14ueApkSnf497x65ktLN05+dmTrQjawBevoMffGjDi1xJ2zXsnPNYc
 BM5+h1B8hRVQyDyp8lba6jfrgqM+ACzal+IhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=inNbUrXZOUEfsSXJu7i6Sd4I1VyGy/gNTlBVC2kOfHQ=;
 b=P7ulIV5iDtDuvYkOcYRLpTZotxjp21VBlphb5fsaZ0rBY1gkFJU8AxiXuR677hEKUQ
 c884kP2UrlCEKgbm+sM8LOpTmCSTpEm/wUPmHxXtlKczleChjTlyWtzN0SHyUA1WEFHn
 aIlf86KNIr2KIOaMUD+Y+y52vIK28DRYn2AhxHH/dIndC7gY/5pl3Ns+INf8QFMIOCL2
 zatOtsBSCa9kL7vbkhFDRlmw8iqPUX969c5IfYjDp4ZuMmIG/NS6t7voZ3PAPH6qLSfO
 stsBdKtQCvBqG+w2TbaeEQhMuH9aQz3iT0u+9UDTuyDe7rOkm81K4z92yzF+wmwk1oZl
 P5Ow==
X-Gm-Message-State: APjAAAUJJpq1kuWHnl7wdcenfUzuCE2Kl/g4ZDwOCTBBpVII0Yl5k1vH
 lYCiiIshvZcUINtJv/gjXKGbew==
X-Google-Smtp-Source: APXvYqwnfwJFVXMfRsDGbqi1cOTr1EsOAQIS5NlDpsSs5nyLpYtoN7AOhwrj0thXqdWT5YedeCJiXA==
X-Received: by 2002:a17:90a:e981:: with SMTP id
 v1mr2187594pjy.131.1582768011585; 
 Wed, 26 Feb 2020 17:46:51 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id q25sm4475543pfg.41.2020.02.26.17.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 17:46:50 -0800 (PST)
Subject: Re: [PATCH RFC] nvme/fc: sq flow control
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <keith.busch@wdc.com>
References: <20200225235956.28475-1-hare@suse.de>
 <913efdfd-6899-08c7-90bb-36f2d33f1e92@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <f110f137-9a25-5978-43f1-3a89023bcac9@broadcom.com>
Date: Wed, 26 Feb 2020 17:46:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <913efdfd-6899-08c7-90bb-36f2d33f1e92@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_174653_880717_6E4006AD 
X-CRM114-Status: GOOD (  23.11  )
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
Cc: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 John Meneghini <john.meneghini@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyLzI2LzIwMjAgMzo0NSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+PiBBcyBwZXIg
TlZNZS1vRiBzcGVjIHNxIGZsb3cgY29udHJvbCBpcyBhY3R1YWxseSBtYW5kYXRvcnksIGFuZCB3
ZSBzaG91bGQKPj4gYmUgaW1wbGVtZW50aW5nIGl0IHRvIGF2b2lkIHRoZSBjb250cm9sbGVyIHRv
IHJldHVybiBhIGZhdGFsIHN0YXR1cwo+PiBlcnJvciwgYW5kIHRyeSB0byBwbGF5IG5pY2VseSB3
aXRoIGNvbnRyb2xsZXJzIHVzaW5nIHNxIGZsb3cgY29udHJvbAo+PiB0byBpbXBsZW1lbnQgUW9T
Lgo+Cj4gSGFubmVzLAo+Cj4gQ2FuIHlvdSBwbGVhc2UgY2xhcmlmeSB3aHkgdGhlIGluZGl2aWR1
YWwgdHJhbnNwb3J0cyBhcmVuJ3Qgc3VmZmljaWVudAo+IGZvciB0aGlzIFFvUyBmZWF0dXJlIHlv
dSBhcmUgdGFsa2luZyBhYm91dD8KCgpJdCdzIGFsbCBhYm91dCBhbGxvY2F0aW9uIG9mIHJlc291
cmNlcyAtIHdoZXRoZXIgbWFuZGF0ZWQgb3Igbm90LiAKQ3VycmVudCBudm1lL252bWVvZiBtb2Rl
bCByZXF1aXJlcyBtZW1vcnkgZm9yIGVudGlyZSBzcSBzaXplICh3ZWxsIG1heWJlIApzcXNpemUg
LTEpIHNvIHRoYXQgdGhlIGhvc3QgY2FuIHNlbmQgYSBzcWUgYW5kIHRoZXJlJ3MgYSBwbGFjZSB0
byBwdXQgaXQgCm9uIHRoZSB0YXJnZXQuwqAgRm9yIGEgdHJhbnNwb3J0IGxpa2UgRkMsIHdoZXJl
IHRoZXJlIGlzbid0IGRlZGljYXRlZCAKbWVtb3J5IGFsbG9jYXRlZCBmb3IgdGhlIHNxIGFuZCBl
YWNoIHNxZSBhcnJpdmVzIGluZGVwZW5kZW50bHksIHRoZXJlJ3MgCmEgZGVzaXJlIHRvIGd1YXJh
bnRlZSBvbmx5IGEgc21hbGwgbnVtYmVyIG9mIGVsZW1lbnRzLCB0aGVuIGxldCB0aGUgCmNvbnRy
b2xsZXIgYWRqdXN0IHNxaGQgdXAgdG8gb3BlbiBtb3JlIG9mIGEgd2luZG93IHRvIGFsbG93IG1v
cmUgCmNvbW1hbmRzIGZyb20gYSBwYXJ0aWN1bGFyIGhvc3QuwqAgV2hlbiB0aGUgc3Vic3lzdGVt
IGlzIG1hbmFnaW5nIAptdWx0aXBsZSBjb250cm9sbGVycyB0byBwZXJoYXBzIG1hbnkgaG9zdHMs
IHRoZXkgbWF5IGJlIGFsbCBzaGFyaW5nIHRoZSAKc2FtZSBzZXQgb2YgcmVjZWl2ZSBidWZmZXJz
LiBUaGUgY29udHJvbGxlciB3b3VsZCBsaWtlIHRvIGNvbnRyb2wgdGhlIAplYmIgYW5kIGZsb3cg
b2Ygd2hhdCBjb250cm9sbGVycy93aGF0IHF1ZXVlcyB1c2UgdGhlIGF2YWlsYWJsZSByZXNvdXJj
ZXMgCmF0IGFueSBwYXJ0aWN1bGFyIHBvaW50IGluIHRpbWUgYmFzZWQgb24gaG9zdC9jb250cm9s
bGVyIFFPUyBzZXR0aW5ncy4KCkFzIG1vc3QgYXJyYXlzIGFyZSBsaW1pdGVkIGluIHRoZSBhbW91
bnQgb2YgbWVtb3J5IHRoZXkgY2FuIGRlZGljYXRlIHRvIApyZWNlaXZlIGJ1ZmZlcnMvcXVldWVz
IGFuZCBhcyB0aGUgcnVsZXMgdG8gZGF0ZSByZXF1aXJlIGd1YXJhbnRlZWQgCmFsbG9jYXRpb24g
b2Ygc3Egc2l6ZSwgdGhlIGNvbnRyb2xsZXJzIGhhdmUgdG8gcGljayBob3cgbXVjaCB0aGV5IHNj
YWxlIAotIGhvdyBtYW55IGFzc29jaWF0aW9ucy9jb250cm9sbGVycyB2cyBob3cgbWFueSBxdWV1
ZXMgcGVyIGNvbnRyb2xsZXIgdnMgCnNxIHNpemUgcGVyIHF1ZXVlIHRoYXQgdGhleSBhbGxvdy7C
oMKgIFRoZSBkaXNhYmxlbWVudCBvZiBzcWZsb3cgY29udHJvbCAKZG9lc24ndCBoZWxwIHRoZSAi
Z3VhcmFudGVlIiwgaXQgYWN0dWFsbHkgY29uZmlybXMgaXQuIFRoZXJlIGFyZSBhIApjb3VwbGUg
b2YgaXNzdWVzIGluIHRoZSBudm1lb2Ygc3BlYyB0aGF0IGNvbmZsaWN0IHdpdGggcmVtb3Zpbmcg
dGhlIApndWFyYW50ZWUgLSBuYW1lbHkgLSBjYW4gYSB2YWx1ZSBvdGhlciB0aGFuIDEgKG9yIDAp
IGJlIHJldHVybmVkIGZyb20gCnRoZSBjb25uZWN0IGZhYnJpYyBjb21tYW5kIGZvciBzcWhkID/C
oCBJdCBjYW4gYmUgYXJndWVkIHRoYXQgb3VyIAppbXBsZW1lbnRhdGlvbiB0b2RheSwgd2hpY2gg
cmV0dXJucyAxLCB3aGljaCBhc3N1bWVzIGFuIGluY3JlbWVudCBhZnRlciAKY29ubmVjdCBhdCBp
ZHggMCBpcyBhY3R1YWxseSBpbmNvcnJlY3QgdG8gdGhlIHNwZWMgYXMgdGhlIHF1ZXVlIGlzIHRv
IGJlIApjcmVhdGVkIGFzIHBhcnQgb2YgY29ubmVjdCBhbmQgaXQgaXMgdG8gYmUgImVtcHR5IiB3
aXRoIApzcWhkPXNxdGFpbD0wLsKgwqDCoMKgIEEgcG9vciBtYW5zIGltcGxlbWVudGF0aW9uLCB3
aGljaCBpZ25vcmVzIHRoaXMgCmluaXRpYWwgY29ubmVjdCByZXNwb25zZSBpc3N1ZSBpbiB0aGUg
c3BlYywgYW5kIHRyaWVzIHRvIGF2b2lkIGRlZGljYXRlZCAKcmVzb3VyY2VzLCB3b3VsZCBsaXZl
IHdpdGggYWxsb3dpbmcgYSBzdG9ybSBvZiAxIHNxc2l6ZSB3b3J0aCBwZXIgcXVldWUsIApleHBl
Y3RpbmcgdGhhdCBpdCB3b24ndCByZWFsbHkgaGFwcGVuIGluIGEgY29tcGxldGUgYnVyc3QsIGFu
ZCBzcWhkIGNhbiAKYmUgY29udHJvbGxlZCBnb2luZyBiYWNrIHRvIHRoZSBob3N0IHN1Y2ggdGhh
dCBmdXJ0aGVyIGlvIGNhbid0IGJlIHNlbnQgCmJleW9uZCAxIHNxc2l6ZXMncyB3b3J0aCB1bmxl
c3MgdGhlIGNvbnRyb2xsZXIgbW92ZXMgc3FoZC4KCgo+Cj4gSWYgd2UgbG9vayBhdCB0aGUgdHJh
bnNwb3J0cyBsYW5kc2NhcGUsIGVhY2ggdHJhbnNwb3J0IGhhcyBhIGNyZWRpdAo+IG1lY2hhbmlz
bSB0aGF0IGNhbiB0aHJvdHRsZSBidWxrIGRhdGEgdHJhbnNmZXJzLiBJbiBGQyBleGNoYW5nZXMg
dGhlCj4gdGFyZ2V0IGlzIGluIGNvbnRyb2wgcHVsbGluZyBkYXRhIGZyb20gdGhlIGhvc3Qgd2l0
aCB4ZmVyX3JlYWR5LAo+IEluIFJETUEgdGhlIHRhcmdldCBkZWNpZGVzIHdoZW4gdG8gaXNzdWUg
cmRtYV9yZWFkLCBhbmQgaW4gVENQIHRoZQo+IHRhcmdldCBkZWNpZGVzIHdoZW4gdG8gaXNzdWUg
UjJULgoKaXQncyBub3QgZGF0YSBmbG93LCBpdCdzIHJlY2VwdGlvbiBvZiBpbyBjb21tYW5kcyB2
cyBzcS4KCj4KPiBUaGVzZSBhcmUgYWxsIGNyZWRpdHMgdGhhdCBnaXZlIHRoZSBjb250cm9sIHRv
IHRoZSB0YXJnZXQgdG8KPiBiYWNrLXByZXNzdXJlIHRoZSBob3N0LiBOb3cgaWYgdGhlIHRhcmdl
dCBkb2Vzbid0IHdhbnQgdGhlIGhvc3QgdG8gc2VuZAo+IG1vcmUgY29tbWFuZHMsIGl0IGNhbiB0
aHJvdHRsZSBzZW5kaW5nIGNvbXBsZXRpb25zIHRodXMgY29udHJvbGxpbmcgdGhlCj4gcGFjZS4K
CnRoYXQgZG9lc24ndCBoZWxwIHRoZSBzeXN0ZW0uIEl0IG9ubHkgbWFrZXMgdGhlIGlvIGxvb2sg
bGlrZSBpdCB0YWtlcyBhIApsb3QgbG9uZ2VyIHRvIGNvbXBsZXRlLiBBdCBzb21lIHBvaW50LCB0
aGUgY29tcGxldGlvbiBoYXMgdG8gZ28gYmFjay4KCj4KPiBJIG11c3Qgc2F5IHRoYXQgcmV0dXJu
aW5nIEJMS19TVFNfUkVTT1VSQ0UgZm9yIGhvc3QgbWFuYWdlZCBTUV9IRUFEIGlzIGEKPiBiaXQg
YXdrd2FyZCBpbiBteSBtaW5kLCBidXQgdGhhdCBqdXN0IG9uZSdzIG9waW5pb24sIHdoYXQgZG8g
b3RoZXJzIGhhdmUKPiB0byBzYXk/CgppdCBpc24ndCBhIGhvc3QtbWFuYWdlZCBTUV9IRUFELiBp
dCdzIGEgcmVhbCBpbXBsZW1lbnRhdGlvbiBvZiAKYWNrbm93bGVkZ2luZyB0aGUgc3EgZmxvdyBj
b250cm9sIHRoYXQgd2FzIG9yaWdpbmFsbHkgc3BlYydkLsKgIFdlJ3ZlIAphbHdheXMgaWdub3Jl
ZCB0aGlzIGluIGxpZXUgb2YgY2hlYXRpbmcgYW5kIHNldHRpbmcgdGhlIGJsay1tcSByZXF1ZXN0
IApjb3VudCwgYW5kIGhvcGVkIGFzIHdlIG5ldmVyIHNlbnQgbGVzcyB0aGFuIGEgcXVldWUncyB3
b3J0aCB0aGVyZSB3YXMgCm5ldmVyIGEgcmVhc29uIGZvciB0aGUgY29udHJvbGxlciB0byBuZWVk
IHRvIG5vdCBpbmNyZW1lbnQgc3FoZCBvbiBhIAoxYnkxIGJhc2lzLsKgwqDCoCBCdXQgdGhlIG90
aGVyIGlzc3VlIHdpdGggdGhpcyBpcyAtIHdlJ3JlIHdhc3RpbmcgbG90cyBvZiAKc3Egc3BhY2Ug
b24gdGhlIGNvbnRyb2xsZXIuIFdlIGhhdmUgNCwgMTAsIDEwMCBzcXMgYnV0IG9ubHkgc2VuZCAx
IHNxJ3MgCndvcnRoIG9mIGlvID/CoCB3aHkgd291bGQgYSBjb250cm9sbGVyIGV2ZXIgd2FudCB0
byBzdXBwb3J0IGEgaGlnaCBxdWV1ZSAKY291bnQgZXhjZXB0IGZvciBhIGJhY2stdG8tYmFjayBh
dHRhY2htZW50IHRvIGEgZml4ZWQgbnVtYmVyIG9mIGhvc3RzICgxIAo/KS7CoCBUaGF0J3Mgbm90
IHJlYXNvbmFibGUgZm9yIGEgcmVhbCBTQU4gZGV2aWNlIC0gc28gd2UncmUgZm9yY2luZyB0aGVt
IAppbnRvIHNtYWxsIHF1ZXVlIGNvdW50cyBhbmQgc21hbGwgc3Egc2l6ZXMgc28gdGhleSBkb24n
dCB3YXN0ZSBtZW1vcnkgCnlldCBjYW4gaGFuZGxlIGJ1bmNoZXMgb2YgYXNzb2NpYXRpb25zLsKg
wqAgU28gaW4gYWRkaXRpb24gdG8gdGhpcyBzcWhkIAp0cmFja2luZyB0aGF0IEhhbm5lcyB3YXMg
cHJvcG9zaW5nLCBmb3IgRkMgYXQgbGVhc3QsIGFzIHNxJ3MgYXJlIApsb2dpY2FsLCBJIHdhcyBh
bHNvIGdvaW5nIHRvIGxvb2sgaW50byBzdXBwb3J0aW5nIG1vcmUgdGhhbiAxIHNxJ3Mgd29ydGgg
Cm9mIGlvcy4KCi0tIGphbWVzCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK

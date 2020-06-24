Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8C0C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:33:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DF120738
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QFtPMSlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DF120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HdXfZ2mAqEJutwEQpuK7VMyxZIdqFoL1YOGE3nIrDwM=; b=QFtPMSlQ+QOW3tE9BHdnTM76w
	LXzHq7gwICBzJzycxhdzYSvxpqQiMe7oayHbQs8StiHGXqasTZvmhKRTj7eLIIhqLqJUATXrxLyKL
	iC1suwJSt2CVr62L1LSv1XHXYcV3tG/2ha59Cy+5DlVj1wsZZpbbuevrQUT0EVYNGygLuxmog6Vvf
	YfUC7l/HiotVwYP3x51mjHJqz9Q3A4drzFsigympk8Bv7REVKT4uPJo09VW1+cUneCcWtkuBAj+47
	7pRWmwb8ZlP+W7TzB/lyHezznv2HOuu/0KqrCjzJslBxK6kAfrmuE4r9iBKGymvqLI7XGbcgDEyo2
	KoP3FO7kQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joADD-0005mK-48; Wed, 24 Jun 2020 18:33:31 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joADA-0005lF-Nu
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 18:33:29 +0000
Received: by mail-pf1-f172.google.com with SMTP id q17so1528479pfu.8
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 11:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DRoXAY61ujBuGuGuDtY/xGH0xaEBTGmp3dkdcOa0oGw=;
 b=nJCeh9Ick+TEbmvZUihLt0RoxS6XqJcWWFWXG+Wyram7hEvkJ7EDUMdj2F7JK/B2ld
 VdhBypNMQ8rz612m26fPbSlB2opGp4IWdXc5myANj1zeBJH6CHzMdMRU5dIrzRlRfQ53
 zrynpsgC7eZtNSQyGPp6ulcz+XYYCPSDXQ6GDaiTBhd8vnqU2mlf+JAlTavQIqKdxBSp
 dz8iIYBZQBCg2zQ3U7KiKc9PL29qi558vIyxrEMB1vId8+Exrlk9VTzozM1O6ZTs87/9
 r6OagmbI+pY8SNKiNdxJnfHQPc7tYWRRVq9nxtyT6Zjkr5OPOhYz9NIUhYtwjnYqmCwq
 nN4g==
X-Gm-Message-State: AOAM530pzvMpKMIkQfCRyuzjkfZ/XbCppZGQkpcyQUlCXB7ejFLWj61r
 5ZxumeUsT7ytydPTgAz+n9A=
X-Google-Smtp-Source: ABdhPJxM+gFoDorwA7Sr7XSBQYVD7Fvy03hdubcRm4eOP8XYB4IhoVY0datfR8mBpxJfmL6bNwlLSw==
X-Received: by 2002:a63:df01:: with SMTP id u1mr20849152pgg.401.1593023607699; 
 Wed, 24 Jun 2020 11:33:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947?
 ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id r77sm3162884pfc.87.2020.06.24.11.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 11:33:27 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
Message-ID: <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
Date: Wed, 24 Jun 2020 11:33:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
Content-Language: en-US
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IElmIHRoZSBjb250cm9sbGVyIGRvZXMgbm90IHN1cHBvcnQgdGhlIENOUyB2YWx1ZSwgaXQg
bWF5IHJldHVybiBJbnZhbGlkCj4+IEZpZWxkIHdpdGggRE5SIHNldC4gVGhhdCBlcnJvciBjdXJy
ZW50bHkgZ2V0cyBwcm9wb2dhdGVkIGJhY2sgdG8KPj4gbnZtZV9pbml0X25zX2hlYWQoKSwgd2hp
Y2ggdGhlbiBhYmFuZG9ucyB0aGUgbmFtZXNwYWNlLiBKdXN0IGFzIHRoZSBjb2RlCj4+IGNvbWVu
dHMgc2F5LCB3ZSBoYWQgYmVlbiBoaXN0b3JpY2FsbHkgYmVlbiBjbGVhcmluZyBzdWNoIGVycm9y
cyBiZWNhdXNlCj4+IHdlIGhhdmUgb3RoZXIgd2F5cyB0byBpZGVudGlmeSB0aGUgbmFtZXNwYWNl
LCBidXQgbm93IHdlJ3JlIG5vdCBjbGVhcmluZwo+PiB0aGF0IGVycm9yLgo+IAo+IEkgZG9uJ3Qg
dW5kZXJzdGFuZCB3aGF0IHlvdSBhcmUgc2F5aW5nIEtlaXRoLgo+IAo+IE15IGNvbW1lbnQgd2Fz
IGZvciB0aGlzIGJsb2NrOgo+IC0tIAo+ICDCoMKgwqDCoGlmICghc3RhdHVzICYmIG52bWVfbXVs
dGlfY3NzKGN0cmwpICYmICFjc2lfc2Vlbikgewo+ICDCoMKgwqDCoMKgwqDCoCBkZXZfd2Fybihj
dHJsLT5kZXZpY2UsICJDb21tYW5kIHNldCBub3QgcmVwb3J0ZWQgZm9yIG5zaWQ6JWRcbiIsCj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuc2lkKTsKPiAgwqDCoMKgwqDCoMKgwqAgc3RhdHVz
ID0gLUVJTlZBTDsKPiAgwqDCoMKgwqB9Cj4gLS0gCj4gCj4gSSB3YXMgc2F5aW5nIHRoYXQgIXN0
YXR1cyBkb2Vzbid0IG5lY2Vzc2FyaWx5IG1lYW4gc3VjY2VzcywgYnV0IGl0IGNhbgo+IGFsc28g
bWVhbiB0aGF0IGl0cyBhbiByZXRyeS1hYmxlIGVycm9yIHN0YXR1cyAoZHVlIHRvIHRyYW5zcG9y
dCBvcgo+IGNvbnRyb2xsZXIpLiBJZiB3ZSBzZWUgYSByZXRyeS1hYmxlIGVycm9yIHdlIHNob3Vs
ZCBzdGlsbCBjbGVhciB0aGUKPiBzdGF0dXMgc28gd2UgZG9uJ3QgYWJhbmRvbiB0aGUgbmFtZXNw
YWNlLgo+IAo+IFRoaXMgZm9yIGV4YW1wbGUgd291bGQgYWNoaWV2ZSB0aGF0OgoKU29ycnksIG1l
YW50IHRoaXM6Ci0tCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggYmE1MTJjNDViNDBmLi4zMTg3Y2Y3NjhkMDggMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKQEAgLTExMzAsOCArMTEzMCwxNCBAQCBzdGF0aWMgaW50IG52bWVfaWRlbnRpZnlf
bnNfZGVzY3Moc3RydWN0IApudm1lX2N0cmwgKmN0cmwsIHVuc2lnbmVkIG5zaWQsCiAgICAgICAg
ICAgICAgICAgICAqIERvbid0IHRyZWF0IGFuIGVycm9yIGFzIGZhdGFsLCBhcyB3ZSBwb3RlbnRp
YWxseSAKYWxyZWFkeQogICAgICAgICAgICAgICAgICAgKiBoYXZlIGEgTkdVSUQgb3IgRVVJLTY0
LgogICAgICAgICAgICAgICAgICAgKi8KLSAgICAgICAgICAgICAgIGlmIChzdGF0dXMgPiAwICYm
ICEoc3RhdHVzICYgTlZNRV9TQ19ETlIpKQorICAgICAgICAgICAgICAgaWYgKHN0YXR1cyA+IDAg
JiYgIShzdGF0dXMgJiBOVk1FX1NDX0ROUikpIHsKICAgICAgICAgICAgICAgICAgICAgICAgIHN0
YXR1cyA9IDA7CisgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHN0YXR1cyA9PSAwICYmIG52bWVf
bXVsdGlfY3NzKGN0cmwpICYmIAohY3NpX3NlZW4pIHsKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBkZXZfd2FybihjdHJsLT5kZXZpY2UsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiQ29tbWFuZCBzZXQgbm90IHJlcG9ydGVkIGZvciAKbnNpZDolZFxuIiwK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5zaWQpOworICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9IC1FSU5WQUw7CisgICAgICAgICAgICAgICB9
CiAgICAgICAgICAgICAgICAgZ290byBmcmVlX2RhdGE7CiAgICAgICAgIH0KLS0KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

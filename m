Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603DDC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 20:46:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E54A207DE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 20:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VBuq0vIg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vt7E/Q8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E54A207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vBscb+hjLqY0Xe7nU+duv07EyU5MAeEgQKr5XxMzaRI=; b=VBuq0vIgSrO0BpL3j9FPg8faV
	H9pUHiBqFB9l/7HETJx1+oBqhfha60o8pzG6A4XsIcApKv4gsHVjYQu1xeTMThl+RN8ugjRE7jSb2
	tly7+TNL4fqp2vKcgRgPnCvy0GnZUa9fAgYlCSvPnqI700L5WFmyMQ/eoEtRzlm5EtNUBmgtT22kk
	ee9TZiB+9HcxtqsuchhVHu8GwGFgkA5+MRji2leQASbPRI1Z0RPh3lfrDKjXBRgoS9P5Nrnn46byh
	NN0WLBbTf7ZCR1TU9dJZHSQrwWjnI5YF0geG/6SSTqFeG5iq1SYEjf+MWgRM+6iqlRRaZAnXlrkUY
	auHm2jtYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8rRi-0001eS-F6; Thu, 20 Aug 2020 20:46:02 +0000
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8rRd-0001dp-C7
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 20:45:59 +0000
Received: by mail-pj1-x1042.google.com with SMTP id nv17so1489100pjb.3
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=seYokn4uAQMoNLE0pUAcvnuifP+FJ0T60g3uK6Tnq0M=;
 b=Vt7E/Q8/mF3g1pdcqoVrUjRk6/WSHJYrLEPEF6yLGkWJkadwf+tEWRkhxq9WF3g0zq
 nC92ep+RX5BfKcyAa8p3dObFjQdqjlfieuE8MKN4Znu+vG6+em2vsHFmutvCjqVZPdY2
 PZpoPw0OYeB2vcq+pMFcnhC7jiq2l0B07nSwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=seYokn4uAQMoNLE0pUAcvnuifP+FJ0T60g3uK6Tnq0M=;
 b=rP/b0VpEgEwZ0S6O5T88QdnILR6gAqOv3FXywqHOeip8QeeUzQIt1Ns+5dAz/mPrRF
 m01SJIQ/QJ5TOZLTc8aJklVIOLKyQiduXb9i7Xvg/uj0hq7Ksv7yoJrQqsqirzOa4lrE
 HZyPcwy7zCpKDTCGMcTESVWtpVkOIJDqkYZuRXn372y/OCamLoZMa1EfFR8/wbfo4Nm+
 T6zu8mLQEsa3jzDZn0X5M5WNH4edX29FX/79YQM+8YH+BNfbSUj4pSyvyMdKQpUpNudD
 TUpRJNt8cMsNavc0sqiuc4fMr6swUY0JbmcUemdltfBfyLJox3xwaIqqiG56foj5PgFC
 WUXw==
X-Gm-Message-State: AOAM532jsQ5FYv700T3sQf9zNyk98Y/U/qtHCJZwF+y3S75wiCMGbWge
 h7qI1Jzj91DFqos9b4NhYgkDicY7xT86aOv7WZfk04Ca8BKIw0yJTmDgvK0n1ZH4yFFj/PvgBeP
 aKgdf76GH3ElE5z5BglCxXJMFSL9IwNvjKbNoB7Q8KWzK6iLd3+r+NN1wnmZiEMaRE2IgxTXChR
 489qpRZQyg
X-Google-Smtp-Source: ABdhPJyXSbJKtCuo3ZENmMzJZ0ANvnJQGIYAHuXE0gjk6D6jyRG1QczYyZ+DTiJupaZYgxZQ3s0zqQ==
X-Received: by 2002:a17:90b:11c4:: with SMTP id
 gv4mr70053pjb.198.1597956354949; 
 Thu, 20 Aug 2020 13:45:54 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id mr21sm3011006pjb.57.2020.08.20.13.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 13:45:54 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
Date: Thu, 20 Aug 2020 13:45:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_164557_725995_717E82FB 
X-CRM114-Status: GOOD (  22.88  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzIwLzIwMjAgOTo1OCBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+Pj4gUmlnaHQg
bm93IHdlIGFyZSBmYWlsaW5nIHJlcXVlc3RzIGJhc2VkIG9uIHRoZSBjb250cm9sbGVyIHN0YXRl
ICh3aGljaAo+Pj4gaXMgY2hlY2tlZCBpbmxpbmUgaW4gbnZtZl9jaGVja19yZWFkeSkgaG93ZXZl
ciB3ZSBzaG91bGQgZGVmaW5pdGVseQo+Pj4gYWNjZXB0IHJlcXVlc3RzIGlmIHRoZSBxdWV1ZSBp
cyBsaXZlLgo+Pj4KPj4+IFdoZW4gZW50ZXJpbmcgY29udHJvbGxlciByZXNldCwgd2UgdHJhbnNp
dGlvbiB0aGUgY29udHJvbGxlciBpbnRvCj4+PiBOVk1FX0NUUkxfUkVTRVRUSU5HLCBhbmQgdGhl
biByZXR1cm4gQkxLX1NUU19SRVNPVVJDRSBmb3Igbm9uLW1wYXRoCj4+PiByZXF1ZXN0cyAoaGF2
ZSBibGtfbm9yZXRyeV9yZXF1ZXN0IHNldCkuCj4+Pgo+Pj4gVGhpcyBpcyBhbHNvIHRoZSBjYXNl
IGZvciBOVk1FX1JFUV9VU0VSIGZvciB0aGUgd3JvbmcgcmVhc29uLiBUaGVyZQo+Pj4gc2hvdWxk
bid0IGJlIGFueSByZWFzb24gZm9yIHVzIHRvIHJlamVjdCB0aGlzIEkvTyBpbiBhIGNvbnRyb2xs
ZXIgCj4+PiByZXNldC4KPj4+IFdlIGRvIHdhbnQgdG8gcHJldmVudCBwYXNzdGhydSBjb21tYW5k
cyBvbiB0aGUgYWRtaW4gcXVldWUgYmVjYXVzZSB3ZQo+Pj4gbmVlZCB0aGUgY29udHJvbGxlciB0
byBmdWxseSBpbml0aWFsaXplIGZpcnN0IGJlZm9yZSB3ZSBsZXQgdXNlciAKPj4+IHBhc3N0aHJ1
Cj4+PiBhZG1pbiBjb21tYW5kcyB0byBiZSBpc3N1ZWQuCj4+Pgo+Pj4gSW4gYSBub24tbXBhdGgg
c2V0dXAsIHRoaXMgbWVhbnMgdGhhdCB0aGUgcmVxdWVzdHMgd2lsbCBzaW1wbHkgYmUKPj4+IHJl
cXVldWVkIG92ZXIgYW5kIG92ZXIgZm9yZXZlciBub3QgYWxsb3dpbmcgdGhlIHFfdXNhZ2VfY291
bnRlciB0byBkcm9wCj4+PiBpdHMgZmluYWwgcmVmZXJlbmNlLCBjYXVzaW5nIGNvbnRyb2xsZXIg
cmVzZXQgdG8gaGFuZyBpZiBydW5uaW5nCj4+PiBjb25jdXJyZW50bHkgd2l0aCBoZWF2eSBJL08u
Cj4+Cj4+IEknbSBzdGlsbCByYXRoZXIgYm90aGVyZWQgd2l0aCB0aGUgYWRtaW4gcXVldWUgZXhj
ZXB0aW9uLsKgIEFuZCBnaXZlbiAKPj4gdGhhdAo+PiB0aGUgcV91c2FnZV9jb3VudGVyIHByb2Js
ZW0gc2hvdWxkIG9ubHkgcmVhbGx5IGJlIGFuIGlzc3VlIGZvciBmaWxlIAo+PiBzeXN0ZW0KPj4g
cmVxdWVzdHMsIGFzIHBhc3N0aHJvdWdoIHJlcXVlc3RzIGRvIG5vdCBhdXRvbWF0aWNhbGx5IGdl
dCByZXRyaWVkIHdoeQo+PiBjYW4ndCB3ZSBqdXN0IHJlamVjdCBhbGwgdXNlciBjb21tYW5kIHRv
IGJlIHN5bWV0cmljIGFuZCBzdHJhaWdodCAKPj4gZm9yd2FyZD8KPj4gVGhlIGNhbGxlcnMgaW4g
dXNlcnNwYWNlIG5lZWQgdG8gYmUgYWJsZSB0byBjb3BlIHdpdGggcmV0cnlhYmxlIGVycm9ycwo+
PiBhbnl3YXkuCj4KPiBMb29raW5nIGF0IHRoZSBjb2RlIGFnYWluLCBJIHRoaW5rIHdlIGNhbiBr
aWxsIGl0IGFzIHdlbGwuCj4KPiBUaGUgY29uY2VybiBpcyB3ZSBtYXkgaXNzdWUgdXNlciBnZW5l
cmF0ZWQgYWRtaW4gY29tbWFuZHMgYmVmb3JlCj4gdGhlIGNvbnRyb2xsZXIgaXMgZW5hYmxlZCAo
Z2VuZXJhdGluZyBhbiB1bmZvcmNlZCBlcnJvciBqdXN0IGJlY2F1c2UKPiB3ZSBxdWV1ZWQgdG8g
ZWFybHkpLiBUaGF0IHVzZWQgdG8gYmUgdGhlIGNhc2Ugd2hlbiB0aGUgYWRtaW4gY29ubmVjdAo+
IHVzZWQgdGhlIGFkbWluX3Egd2hpY2ggbWVhbnQgd2UgbmVlZGVkIHRvIHVucXVpZXNjZSBiZWZv
cmUsIGJ1dAo+IG5vdyB0aGF0IHRoZSBhZG1pbiBjb25uZWN0IHVzZXMgdGhlIGZhYnJpY3NfcSwg
dGhhdCBzaG91bGQgbm8KPiBsb25nZXIgYmUgYW4gaXNzdWUuCj4KPiBpbiBudm1lLXRjcCB3ZSB1
bnF1aWVzY2UgYWZ0ZXIgd2UgZW5hYmxlIHRoZSBjdHJsOgo+IC4uLgo+Cj4gSmFtZXMsIGNhbiB5
b3UgcGxlYXNlIGhhdmUgYSBsb29rIGlmIHRoaXMgaXMgc3RpbGwgYW4gaXNzdWU/CgpJIHN0aWxs
IGRpc2xpa2UgYW55IHJhbmRvbSBpb2N0bHMgY29taW5nIGluIHdoaWxlIHdlJ3JlIHN0aWxsIApp
bml0aWFsaXppbmcgdGhlIGNvbnRyb2xsZXIuwqAgTG9va2luZyBhdCB0aGUgZmxvdyAtIEkgd291
bGRuJ3Qgd2FudCB0aGVtIAp0byBiZSBhbGxvd2VkIHVudGlsIGFmdGVyIG52bWVfaW5pdF9pZGVu
dGlmeSgpIGlzIGNvbXBsZXRlLiBFc3BlY2lhbGx5IAppZiB0aGUgaW9jdGxzIGFyZSBkb2luZyBz
dWJzeXN0ZW0gb3IgY29udHJvbGxlciBkdW1waW5nIG9yIHVzaW5nIApjb21tYW5kcyB0aGF0IHNo
b3VsZCBiZSBjYXBwZWQgYnkgdmFsdWVzIHNldCBieSBudm1lX3F1ZXVlX2xpbWl0cygpLsKgwqAg
CkJ1dCwgaWYgd2UncmUgZ29pbmcgdG8gYWxsb3cgbnZtZV9pbml0X2lkZW50aWZ5IHRoZSBhZG1p
bl9xIG5lZWRzIHRvIGJlIAp1bnF1aWVzY2VkLgoKU28gSSdtIHN0aWxsIHZvdGluZyBmb3IgdGhl
IGFkbWluIHF1ZXVlIGV4Y2VwdGlvbi4KCi0tIGphbWVzCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=

Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19EAC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 18:16:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D443E61625
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 18:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D443E61625
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W83gMt2UsH32vf2zjnGm0cgjtjh3pVnkuxwZ4DS9V1k=; b=Zcs1mN9KJzAMJFsnzYgOnLqQZ
	oBC3nUEJvMWQWIBZh13woUQeg8P1gpTsAz7JBLWR3meaNxFA2zpaP2rBRnGgRUzTyNYE/2eYkFI+c
	Ei9DEHTTCwNs4zEqbsOWN8vLbGCYCEthPmXmxWM+lph9yY0+AIuW8Z9R3C6hQowEL8BU2ITipE6uf
	bP3km40S/EGsBVvxxYlc0G8oYSOX+h+HDjFj0W2gmIWm7UV4q/U0y9d6ZfiQJn7SiKSh1akrMqopG
	+L6TYLlkWhNLjQL+EbWxF63eixacQoqnfiOzH1CIcS2/AFjOWmxQcDUyYYXqT3Q5VRw42RKaCZWpv
	JMCXcS0tQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgWvd-000zkl-Ua; Tue, 11 May 2021 18:16:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgWvb-000zkX-0x
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 18:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=b4PMiCif1x3iYDBqI6f5owLmB4HyczaNc9Vt8ePTfoA=; b=r4m1Qk6pPBNQhIS9usoJbum8VD
 uB51fzkXT2eFd42b2yspl20wsclahwA1zr3wcOk2ZGChkGeUixa5/vmy+2utG9zY4XKYSTpj8cqMv
 JKLH2N0Q8pMtkJt53tsLWUoPaboEt/potENiZ+dPuHTXgxm3aedcAcwu0/+ZgILbtmrHLk13EByqU
 fng42IBMRp6ltdhv+STa9J8unyDNTq3uCO6y61t1KIHtE33gKkK3rRtoeKLuLy6BcukAtZcGesa4G
 gsZ68UOweo9+UHIlrNY8P8XFvwkXu97ncKDIQI7VwRcQR3x54rGCKK9dGThgHAnwKf10ahzqR0qN1
 fxlrIC6g==;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgWvY-009ppL-3h
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 18:16:17 +0000
Received: by mail-pg1-f177.google.com with SMTP id q15so12099619pgg.12
 for <linux-nvme@lists.infradead.org>; Tue, 11 May 2021 11:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b4PMiCif1x3iYDBqI6f5owLmB4HyczaNc9Vt8ePTfoA=;
 b=Y501+HU8q9ayCzQXNMrWASxft42PTwrP+2LdX2R7TL5wC4vZTGr8ysnLc2Uei3IE38
 vCQXfFJn0/MGbhps2mXBx4sVkcbL2w0573gh9eRAZO8xBPocFw9hKhuGR7KboxxJsobs
 SV7h4ZSGuTxarloBuaz68qiWZSqCE3SznUrtpPkHyAUCYm7jPLO5Z8Vh8kFIX/l5TPSu
 tw1FtmTZXbOuj0BVXNbTwFhCSX45DGTH14GCsEcOFJM7RdQZLu1qd2ObOFYT9FVtxd9Z
 bnSIcEgBw9nu6/SvUVFqcE4w+v5r53+YgWgKINTmpCXsepzorRDUEewcKbowcM47JbB8
 swug==
X-Gm-Message-State: AOAM530j/6TaonU4C1hVLqFNtx4KvkIwuoCjispJtQD2wT//eso4ylSI
 xp2vqF1wqm0MKdntf8YbmG4=
X-Google-Smtp-Source: ABdhPJy/S0xkZUvf9TSn7lSiIEUJMHDcs7G0YskbAUaxpQZW5QBFsAoax93TgUAnoX0w0dLOnSHVnA==
X-Received: by 2002:a63:5c4c:: with SMTP id n12mr11568471pgm.288.1620756973013; 
 Tue, 11 May 2021 11:16:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:57ce:f5c2:eedd:e35?
 ([2601:647:4802:9070:57ce:f5c2:eedd:e35])
 by smtp.gmail.com with ESMTPSA id q19sm15729398pfl.171.2021.05.11.11.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 11:16:12 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: "Ewan D. Milne" <emilne@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
 <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
 <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
 <8a396f94-ac33-6bea-8d70-ded0188eb98a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1989b8fe-7ef2-2145-75c5-5e938f74014c@grimberg.me>
Date: Tue, 11 May 2021 11:16:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8a396f94-ac33-6bea-8d70-ded0188eb98a@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_111616_181882_FD48E701 
X-CRM114-Status: GOOD (  26.38  )
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

CgpPbiA1LzkvMjEgNDozMCBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IE9uIDUvOC8yMSAx
OjIyIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pgo+Pj4+PiBXZWxsLCB0aGF0IHdvdWxkIHJl
cXVpcmUgYSBtb2RpZmljYXRpb24gdG8gdGhlIENRRSBzcGVjaWZpY2F0aW9uLCBubz8KPj4+Pj4g
Zm1kcyB3YXMgbm90IGFtdXNlZCB3aGVuIEkgcHJvcG9zZWQgdGhhdCA6LSgKPj4+Pgo+Pj4+IFdo
eSB3b3VsZCB0aGF0IHJlcXVpcmUgYSBtb2RpZmljYXRpb24gdG8gdGhlIENRRT8gaXQncyBqdXN0
IHVzaW5nIHNheQo+Pj4+IDQgbXNiaXRzIG9mIHRoZSBjb21tYW5kX2lkIHRvIGEgcnVubmluZyBz
ZXF1ZW5jZS4uLgo+Pj4KPj4+IEkgdGhpbmsgSGFubmVzIHdhcyB1bmRlciB0aGUgaW1wcmVzc2lv
biB0aGF0IHRoZSBjb3VudGVyIHByb3Bvc2FsIHdhc24ndAo+Pj4gcGFydCBvZiB0aGUgImNvbW1h
bmRfaWQiLiBUaGUgaG9zdCBjYW4gZW5jb2RlIHdoYXRldmVyIGl0IHdhbnRzIGluIHRoYXQKPj4+
IHZhbHVlLCBhbmQgdGhlIGNvbnRyb2xsZXIganVzdCBoYXMgdG8gcmV0dXJuIHRoZSBzYW1lIHZh
bHVlLgo+Pgo+PiBZZWEsIG1heWJlIHNvbWV0aGluZyBsaWtlIHRoaXM/Cj4+IC0tIAo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jCj4+IGluZGV4IGU2NjEyOTcxZjRlYi4uN2FmNDg4MjdlYTU2IDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
Cj4+IEBAIC0xMDA2LDcgKzEwMDYsNyBAQCBibGtfc3RhdHVzX3QgbnZtZV9zZXR1cF9jbWQoc3Ry
dWN0IG52bWVfbnMgKm5zLCAKPj4gc3RydWN0IHJlcXVlc3QgKnJlcSkKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBCTEtfU1RTX0lPRVJSOwo+PiDCoMKgwqDCoMKgwqDC
oCB9Cj4+Cj4+IC3CoMKgwqDCoMKgwqAgY21kLT5jb21tb24uY29tbWFuZF9pZCA9IHJlcS0+dGFn
Owo+PiArwqDCoMKgwqDCoMKgIGNtZC0+Y29tbW9uLmNvbW1hbmRfaWQgPSBudm1lX2NpZChyZXEp
Owo+PiDCoMKgwqDCoMKgwqDCoCB0cmFjZV9udm1lX3NldHVwX2NtZChyZXEsIGNtZCk7Cj4+IMKg
wqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+IH0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+PiBpbmRleCAwNWYzMWEy
YzY0YmIuLjk2YWJmYjBlMmRkZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZt
ZS5oCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+PiBAQCAtMTU4LDYgKzE1OCw3
IEBAIGVudW0gbnZtZV9xdWlya3Mgewo+PiBzdHJ1Y3QgbnZtZV9yZXF1ZXN0IHsKPj4gwqDCoMKg
wqDCoMKgwqAgc3RydWN0IG52bWVfY29tbWFuZMKgwqDCoMKgICpjbWQ7Cj4+IMKgwqDCoMKgwqDC
oMKgIHVuaW9uIG52bWVfcmVzdWx0wqDCoMKgwqDCoMKgIHJlc3VsdDsKPj4gK8KgwqDCoMKgwqDC
oCB1OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZW5jdHI7Cj4+
IMKgwqDCoMKgwqDCoMKgIHU4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHJpZXM7Cj4+IMKgwqDCoMKgwqDCoMKgIHU4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZsYWdzOwo+PiDCoMKgwqDCoMKgwqDCoCB1MTbCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1czsKPj4gQEAgLTQ5Nyw2ICs0OTgs
NDggQEAgc3RydWN0IG52bWVfY3RybF9vcHMgewo+PiDCoMKgwqDCoMKgwqDCoCBpbnQgKCpnZXRf
YWRkcmVzcykoc3RydWN0IG52bWVfY3RybCAqY3RybCwgY2hhciAqYnVmLCBpbnQgc2l6ZSk7Cj4+
IH07Cj4+Cj4+ICsvKgo+PiArICogbnZtZSBjb21tYW5kX2lkIGlzIGNvbnN0cnVjdGVkIGFzIHN1
Y2g6Cj4+ICsgKiB8IHh4eHggfCB4eHh4eHh4eHh4eHggfAo+PiArICrCoMKgIGdlbsKgwqDCoCBy
ZXF1ZXN0IHRhZwo+PiArICovCj4+ICsjZGVmaW5lIG52bWVfY2lkX2luc3RhbGxfZ2VuY3RyKGdl
binCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKGdlbiAmIDB4ZikgPDwgMTIpCj4+ICsjZGVmaW5lIG52
bWVfZ2VuY3RyX2Zyb21fY2lkKGNpZCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKGNpZCAm
IDB4ZjAwMCkgPj4gMTIpCj4+ICsjZGVmaW5lIG52bWVfdGFnX2Zyb21fY2lkKGNpZCnCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoY2lkICYgMHhmZmYpCj4+ICsKPiAKPiBUaGF0IGlz
IGEgZ29vZCBpZGVhLCBidXQgd2Ugc2hvdWxkIGVuc3VyZSB0byBsaW1pdCB0aGUgbnVtYmVyIG9m
IAo+IGNvbW1hbmRzIGEgY29udHJvbGxlciBjYW4gcmVxdWVzdCwgdG9vLgoKV2UgdGFrZSB0aGUg
bWluaW11bSBiZXR3ZWVuIHdoYXQgdGhlIGhvc3QgZG9lcyB2cy4gd2hhdCB0aGUgY29udHJvbGxl
cgpzdXBwb3J0cyBhbnl3YXlzLgoKPiBBcyBwZXIgc3BlYyBlYWNoIGNvbnRyb2xsZXIgY2FuIHN1
cHBvcnQgYSBmdWxsIDMyIGJpdCB3b3J0aCBvZiByZXF1ZXN0cywgCj4gYW5kIGlmIHdlIGxpbWl0
IHRoYXQgYXJiaXRyYXJpbHkgZnJvbSB0aGUgc3RhY2sgd2UnbGwgbmVlZCB0byBjYXAgdGhlIAo+
IG51bWJlciBvZiByZXF1ZXN0cyBhIGNvbnRyb2xsZXIgb3IgZmFicmljcyBkcml2ZXIgY2FuIHJl
cXVlc3QuCgpOVk1GX01BWF9RVUVVRV9TSVpFIGlzIGFscmVhZHkgMTAyNCwgeW91IGFyZSByaWdo
dCB0aGF0IHdlIGFsc28gbmVlZDoKLS0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3Bj
aS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKaW5kZXggOTJlMDNmMTVjOWY2Li42NmE0YTdm
N2M1MDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCisrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3BjaS5jCkBAIC02MCw2ICs2MCw3IEBAIE1PRFVMRV9QQVJNX0RFU0Moc2dsX3Ro
cmVzaG9sZCwKICAgICAgICAgICAgICAgICAiVXNlIFNHTHMgd2hlbiBhdmVyYWdlIHJlcXVlc3Qg
c2VnbWVudCBzaXplIGlzIGxhcmdlciAKb3IgZXF1YWwgdG8gIgogICAgICAgICAgICAgICAgICJ0
aGlzIHNpemUuIFVzZSAwIHRvIGRpc2FibGUgU0dMcy4iKTsKCisjZGVmaW5lIE5WTUVfUENJX01B
WF9RVUVVRV9TSVpFIDQwOTYKICBzdGF0aWMgaW50IGlvX3F1ZXVlX2RlcHRoX3NldChjb25zdCBj
aGFyICp2YWwsIGNvbnN0IHN0cnVjdCAKa2VybmVsX3BhcmFtICprcCk7CiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIGlvX3F1ZXVlX2RlcHRoX29wcyA9IHsKICAgICAgICAg
LnNldCA9IGlvX3F1ZXVlX2RlcHRoX3NldCwKQEAgLTY4LDcgKzY5LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIAppb19xdWV1ZV9kZXB0aF9vcHMgPSB7CgogIHN0YXRp
YyB1bnNpZ25lZCBpbnQgaW9fcXVldWVfZGVwdGggPSAxMDI0OwogIG1vZHVsZV9wYXJhbV9jYihp
b19xdWV1ZV9kZXB0aCwgJmlvX3F1ZXVlX2RlcHRoX29wcywgJmlvX3F1ZXVlX2RlcHRoLCAKMDY0
NCk7Ci1NT0RVTEVfUEFSTV9ERVNDKGlvX3F1ZXVlX2RlcHRoLCAic2V0IGlvIHF1ZXVlIGRlcHRo
LCBzaG91bGQgPj0gMiIpOworTU9EVUxFX1BBUk1fREVTQyhpb19xdWV1ZV9kZXB0aCwgInNldCBp
byBxdWV1ZSBkZXB0aCwgc2hvdWxkID49IDIgYW5kIAo8PSA0MDk2Iik7CgogIHN0YXRpYyBpbnQg
aW9fcXVldWVfY291bnRfc2V0KGNvbnN0IGNoYXIgKnZhbCwgY29uc3Qgc3RydWN0IAprZXJuZWxf
cGFyYW0gKmtwKQogIHsKQEAgLTE2NCw2ICsxNjUsOSBAQCBzdGF0aWMgaW50IGlvX3F1ZXVlX2Rl
cHRoX3NldChjb25zdCBjaGFyICp2YWwsIGNvbnN0IApzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCkK
ICAgICAgICAgaWYgKHJldCAhPSAwIHx8IG4gPCAyKQogICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOwoKKyAgICAgICBpZiAobiA+IE5WTUVfUENJX01BWF9RVUVVRV9TSVpFKQorICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7CisKICAgICAgICAgcmV0dXJuIHBhcmFtX3NldF91aW50
KHZhbCwga3ApOwogIH0KCi0tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==

Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909FFC43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 01:41:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A75208DB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 01:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EPjmbzeT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uvr84yJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A75208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TaK9ZFSMmRlq7RbXc+E61iqJEdRGvYz96Au56WGdemo=; b=EPjmbzeTxW9QNjaiXrjK47aLF
	Nscyth3SiE+vtQIprciW5vJuJxDr0qTxet7n8ZMPMW9ZY+ECI+fg2AH3HpG7BFxlXkr06FO2ozYvI
	ha3TO/sPW6uDZxxYkRWmLI3iGbjKchO0a4NvsJs42GiQqGjbQxf4k44gK7azeLjCLeSCfZPzkdDqR
	2CytuRA25GOjUQwHZ7xoeT7Quedu3qqpQfCl9QfcqF9rU1I1jojysxgi3+/FU5TMRgvRDMJ/GeRMi
	2b6PcLWYa1aPMr73W7+PiCwRv0htSzB9votJSX1PrDtVe0I18CYzlY6WZ7f+mbwyQcyARoI3G84FU
	ZRqtxBePg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHzy4-0005mZ-29; Tue, 15 Sep 2020 01:41:12 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHzy0-0005lV-1h
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 01:41:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600134065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sV4QUQMydz/OP3QtyHddXTi3jxjNlgFoSQ5KG5at0k=;
 b=Uvr84yJ4isb4z9txlMd37uYvo4QfCjxkebgWlLwIy3uNaQfPhb0shzl+jlaX1wsO/KSP4W
 wKHSAWD184y6+FCPGeXDnxsslHzOjcXewp3NR7AzGSfF5kO4RTBMx/EYzykOnw6+w5VHlz
 pvkXC0kDfSJwAMQwC/N0d7J6rDZMwR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-d41pHYguNpuB3nLNzNf7xw-1; Mon, 14 Sep 2020 21:41:00 -0400
X-MC-Unique: d41pHYguNpuB3nLNzNf7xw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71E6D1084D60;
 Tue, 15 Sep 2020 01:40:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-58.pek2.redhat.com [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B22D51002D41;
 Tue, 15 Sep 2020 01:40:54 +0000 (UTC)
Subject: Re: nvme_tcp: nvme connect failed after execute stress-ng: unshare
To: Sagi Grimberg <sagi@grimberg.me>, gscrivan@redhat.com,
 colin.king@canonical.com
References: <643455136.711850.1599712518936.JavaMail.zimbra@redhat.com>
 <34570678-f8e7-a3ce-e7a3-be887ec2d949@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <c5ad05c0-b0aa-bfda-32db-1fd0e0c74e55@redhat.com>
Date: Tue, 15 Sep 2020 09:40:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <34570678-f8e7-a3ce-e7a3-be887ec2d949@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_214108_129479_857F311A 
X-CRM114-Status: GOOD (  17.89  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgU2FnaQoKT24gOS8xNS8yMCA3OjUwIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IEhl
bGxvCj4+Cj4+IFJlY2VudGx5IEkgZm91bmQgbnZtZS10Y3AgY29ubmVjdGluZyBhbHdheXMgZmFp
bGVkWzFdIGFmdGVyIGV4ZWN1dGUgCj4+IHN0cmVzcy1uZzp1bnNoYXJlWzJdLCBieSBiaXNlY3Rp
bmcgSSBmaW5hbGx5IGZvdW5kIGl0IHdhcyBpbnRyb2R1Y2VkIAo+PiB3aXRoIGNvbW1pdFszXSwg
dGhlIGNvbm5lY3Rpbmcgd29ya3Mgd2VsbCBhZnRlciByZXZlcnQgaXQuCj4+IEknbSBub3Qgc3Vy
ZSB3aGV0aGVyIGl0J3Mgb25lIHRlc3QgY2FzZSBpc3N1ZSBvciBrZXJuZWwgaXNzdWUsIGNvdWxk
IAo+PiBhbnlvbmUgaGVscCBjaGVjayBpdC4KPgo+IElzIHRoaXMgZmFpbHVyZSBwZXJzaXN0ZW50
IG9yIHRyYW5zaWVudD8KPgpJdCdzIHBlcnNpc3RlbnQsIGFuZCBtb3N0IG9mIHJlY2VudCBDS0kg
am9iIHdpdGggNS44IHN0YWJsZSBrZXJuZWwgYWxzbyAKc2hvd2VkIHRoaXMgZmFpbHVyZS4KCj4+
Cj4+IFsxXQo+PiAjIHNoIHRlc3Quc2gKPj4gKyAuL3N0cmVzcy1uZy9zdHJlc3MtbmcgLS11bnNo
YXJlIDAgLS10aW1lb3V0IDUgLS1sb2ctZmlsZSB1bnNoYXJlLmxvZwo+PiBzdHJlc3Mtbmc6IGlu
Zm86wqAgWzM1NTUzNF0gZGlzcGF0Y2hpbmcgaG9nczogMzIgdW5zaGFyZQo+PiBzdHJlc3Mtbmc6
IGluZm86wqAgWzM1NTUzNF0gc3VjY2Vzc2Z1bCBydW4gY29tcGxldGVkIGluIDUuMDRzCj4+ICsg
bW9kcHJvYmUgbnVsbC1ibGsgbnItZGV2aWNlcz0xCj4+ICsgbW9kcHJvYmUgbnZtZXQtdGNwCj4+
ICsgbW9kcHJvYmUgbnZtZS10Y3AKPj4gKyBudm1ldGNsaSByZXN0b3JlIHRjcC5qc29uCj4+ICsg
bnZtZSBjb25uZWN0IC10IHRjcCAtbiBucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3Zl
cnkgLWEgCj4+IDEyNy4wLjAuMSAtcyA0NDIwCj4+IEZhaWxlZCB0byB3cml0ZSB0byAvZGV2L252
bWUtZmFicmljczogSW5wdXQvb3V0cHV0IGVycm9yCj4+Cj4+ICMgZG1lc2cgfCB0YWlsIC05Cj4+
IFvCoCA3MDAuMDEyMjk5XSBudWxsX2JsazogbW9kdWxlIGxvYWRlZAo+PiBbwqAgNzAwLjA3MzQx
NV0gbnZtZXQ6IGFkZGluZyBuc2lkIDEgdG8gc3Vic3lzdGVtIGJsa3Rlc3RzLXN1YnN5c3RlbS0x
Cj4+IFvCoCA3MDAuMDczOTIzXSBudm1ldF90Y3A6IGVuYWJsaW5nIHBvcnQgMCAoMTI3LjAuMC4x
OjQ0MjApCj4+IFvCoCA3MTUuMjkxMDIwXSBudm1ldDogY3RybCAxIGtlZXAtYWxpdmUgdGltZXIg
KDE1IHNlY29uZHMpIGV4cGlyZWQhCj4+IFvCoCA3MTUuMjk3MDMxXSBudm1ldDogY3RybCAxIGZh
dGFsIGVycm9yIG9jY3VycmVkIQo+PiBbwqAgNzQ5LjkzOTg5OF0gbnZtZXQ6IGNyZWF0aW5nIGNv
bnRyb2xsZXIgMSBmb3Igc3Vic3lzdGVtIAo+PiBucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5k
aXNjb3ZlcnkgZm9yIE5RTiAKPj4gbnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6dXVpZDplNDA1
ZTZiYi04ZTI4LTRhNzMtYjMzOC0zZmRkYjU3NDZiOGMuCj4+IFvCoCA3NjMuNDE3Mzc2XSBudm1l
IG52bWUwOiBxdWV1ZSAwOiB0aW1lb3V0IHJlcXVlc3QgMHgwIHR5cGUgNAo+PiBbwqAgNzYzLjQy
Mjk3OV0gbnZtZSBudm1lMDogQ29ubmVjdCBjb21tYW5kIGZhaWxlZCwgZXJyb3Igd28vRE5SIGJp
dDogODgxCj4+IFvCoCA3NjMuNDI5NDE5XSBudm1lIG52bWUwOiBmYWlsZWQgdG8gY29ubmVjdCBx
dWV1ZTogMCByZXQ9ODgxCj4+Cj4+ICMgdW5hbWUgLXIKPj4gNS45LjAtcmM0Cj4+Cj4+Cj4+IFsy
XSBzdHJlc3Mtbmc6IHVuc2hhcmUgY2FzZQo+PiBodHRwczovL2dpdGh1Yi5jb20vQ29saW5JYW5L
aW5nL3N0cmVzcy1uZy5naXQKPj4gaHR0cHM6Ly9naXRodWIuY29tL0NvbGluSWFuS2luZy9zdHJl
c3MtbmcvYmxvYi9tYXN0ZXIvc3RyZXNzLXVuc2hhcmUuYwo+Pgo+Pgo+PiBbM10KPj4gY29tbWl0
IGUxZWIyNmZhNjJkMDRlYzA5NTU0MzJiZTFhYTg3MjJhOTdjYjUyZTcKPj4gQXV0aG9yOiBHaXVz
ZXBwZSBTY3JpdmFubyA8Z3Njcml2YW5AcmVkaGF0LmNvbT4KPj4gRGF0ZTrCoMKgIFN1biBKdW4g
NyAyMTo0MDoxMCAyMDIwIC0wNzAwCj4+Cj4+IMKgwqDCoMKgIGlwYy9uYW1lc3BhY2UuYzogdXNl
IGEgd29yayBxdWV1ZSB0byBmcmVlX2lwYwo+PiDCoMKgwqDCoCDCoMKgwqDCoCB0aGUgcmVhc29u
IGlzIHRvIGF2b2lkIGEgZGVsYXkgY2F1c2VkIGJ5IHRoZSAKPj4gc3luY2hyb25pemVfcmN1KCkg
Y2FsbCBpbgo+PiDCoMKgwqDCoCBrZXJuX3Vtb3VudCgpIHdoZW4gdGhlIG1xdWV1ZSBtb3VudCBp
cyBmcmVlZC4KPj4KPj4KPj4gWzRdCj4+ICMgY2F0IHRjcC5qc29uCj4+IHsKPj4gwqDCoCAiaG9z
dHMiOiBbXSwKPj4gwqDCoCAicG9ydHMiOiBbCj4+IMKgwqDCoMKgIHsKPj4gwqDCoMKgwqDCoMKg
ICJhZGRyIjogewo+PiDCoMKgwqDCoMKgwqDCoMKgICJhZHJmYW0iOiAiaXB2NCIsCj4+IMKgwqDC
oMKgwqDCoMKgwqAgInRyYWRkciI6ICIxMjcuMC4wLjEiLAo+PiDCoMKgwqDCoMKgwqDCoMKgICJ0
cmVxIjogIm5vdCBzcGVjaWZpZWQiLAo+PiDCoMKgwqDCoMKgwqDCoMKgICJ0cnN2Y2lkIjogIjQ0
MjAiLAo+PiDCoMKgwqDCoMKgwqDCoMKgICJ0cnR5cGUiOiAidGNwIgo+PiDCoMKgwqDCoMKgwqAg
fSwKPj4gwqDCoMKgwqDCoMKgICJwb3J0aWQiOiAwLAo+PiDCoMKgwqDCoMKgwqAgInJlZmVycmFs
cyI6IFtdLAo+PiDCoMKgwqDCoMKgwqAgInN1YnN5c3RlbXMiOiBbCj4+IMKgwqDCoMKgwqDCoMKg
wqAgImJsa3Rlc3RzLXN1YnN5c3RlbS0xIgo+PiDCoMKgwqDCoMKgwqAgXQo+PiDCoMKgwqDCoCB9
Cj4+IMKgwqAgXSwKPj4gwqDCoCAic3Vic3lzdGVtcyI6IFsKPj4gwqDCoMKgwqAgewo+PiDCoMKg
wqDCoMKgwqAgImFsbG93ZWRfaG9zdHMiOiBbXSwKPj4gwqDCoMKgwqDCoMKgICJhdHRyIjogewo+
PiDCoMKgwqDCoMKgwqDCoMKgICJhbGxvd19hbnlfaG9zdCI6ICIxIiwKPj4gwqDCoMKgwqDCoMKg
wqDCoCAiY250bGlkX21heCI6ICI2NTUxOSIsCj4+IMKgwqDCoMKgwqDCoMKgwqAgImNudGxpZF9t
aW4iOiAiMSIsCj4+IMKgwqDCoMKgwqDCoMKgwqAgIm1vZGVsIjogIkxpbnV4IiwKPj4gwqDCoMKg
wqDCoMKgwqDCoCAicGlfZW5hYmxlIjogIjAiLAo+PiDCoMKgwqDCoMKgwqDCoMKgICJzZXJpYWwi
OiAiN2Q4MzNmNTUwMWY2YjI0MCIsCj4+IMKgwqDCoMKgwqDCoMKgwqAgInZlcnNpb24iOiAiMS4z
Igo+PiDCoMKgwqDCoMKgwqAgfSwKPj4gwqDCoMKgwqDCoMKgICJuYW1lc3BhY2VzIjogWwo+PiDC
oMKgwqDCoMKgwqDCoMKgIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgImRldmljZSI6IHsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJuZ3VpZCI6ICIwMDAwMDAwMC0wMDAwLTAwMDAtMDAw
MC0wMDAwMDAwMDAwMDAiLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInBhdGgiOiAiL2Rl
di9udWxsYjAiLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInV1aWQiOiAiYjA3YzdlZWYt
ODQyOC00N2JmLThlNzktMjZlYzhjMzBmMzM0Igo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9LAo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiZW5hYmxlIjogMSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqAgIm5zaWQiOiAxCj4+IMKgwqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgwqAgXSwKPj4g
wqDCoMKgwqDCoMKgICJucW4iOiAiYmxrdGVzdHMtc3Vic3lzdGVtLTEiCj4+IMKgwqDCoMKgIH0K
Pj4gwqDCoCBdCj4+IH0KPj4KPj4KPj4gQmVzdCBSZWdhcmRzLAo+PiDCoMKgIFlpIFpoYW5nCj4+
Cj4+Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

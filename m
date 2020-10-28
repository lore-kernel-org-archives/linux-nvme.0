Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB46C4363A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 09:29:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C590224687
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 09:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eDU0OU9e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="cG6/9o1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C590224687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kbKCVkKkL4O6zUj4Kz/YQP6UWsp4f0N0WpDMmaUTfko=; b=eDU0OU9eMGx6ClOwbpUvYrQrQ
	/6WwV745E6qpuli5TOdvL8rwgVCASbzLGD8Pq3qCzNu+a76oaSJo72/+Bj/UJ1mQ1EGxvnzZLeOLX
	GNoohkYzLcbKek+42q3/F5Kh4HZIvN1Y8wAPh1okf735EDLSUg1XC3XGA9wQcEMH0K3cUdhtCuTVT
	RpVHuy2P8DjaSymMsBRONK2aaDNwt3TQ3Khr6p5spy9h2TunIZnXyDo72GVHMvmnDiyxy1Vslv0Ob
	BSZf/CQrJ4sKjKqoyNbxJ1bzLaOTB3m4kBI79CiuGeUdi0eCtFuvOe5uuh4U4xhClqGC//3nAlOpV
	ldTkWUayg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXhlZ-0002aA-Oy; Wed, 28 Oct 2020 09:29:13 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXhlW-0002ZZ-TW
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 09:29:12 +0000
Received: by mail-pf1-x442.google.com with SMTP id w21so2583785pfc.7
 for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2020 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VF4gZYFcsN8OoJPW68XIA2tKZhPCND0dogeoGUQ8I+s=;
 b=cG6/9o1qdaoV4pOSKSDRmJgwS/h28HObCWhgg8QoMsjiZW3QFu3IyNmlqLLWbQWlNG
 BYmTShzU6Ysvq8wJeXjJGaZd2tBxE+k2TpNikW1aPZlcK9AfQd7u3dVHtf3kl/+ZFnr2
 3ZbHdvVLzwlIsWhiim8HNUQBsHzASEMYnK9ZBmMEoqjiFLEqZ1ECArOz+f8TrjpFDcRH
 IW3hZsSzVVnyJTaERt6xqtSFTSmT2TwcvidnYhqItLt4gJLG0y4rSFZv3kZnHmzR+zpo
 /TnIOWZLtvXCpnnb/D8LL00syPOSwkMsQwpCze93yhVCk0Rifz4Rm+9nXqBDCFXHdvSS
 6GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VF4gZYFcsN8OoJPW68XIA2tKZhPCND0dogeoGUQ8I+s=;
 b=m5d/geujuevGHakYiaFfSkqgsxFXLYxz49CeX4JmzgWAlY+VytQenuGLy1KbwcfwiW
 Ae8pRwmoLymOSyGuc2IoQcC/cgzFTT3qGxgfIZVF140ieQo8Y0tBEOyDIhNPOmE4Sbkz
 4qZrGii8q7voRtblQ5WfWke87gVlvMTQk+rNbGKBRRCCC2l1yDEETfEqJ8rgX8HgMmDh
 VFAqbG9IdjXPqF2TcEIA7/8YMZ8Jj+ivPXlFBe439pjZafD5z3n/kutevtpzm8Y3gLd+
 ScV9DsuQcGQtVkLbnPmARSyWJjJ3GIyqE8bN7lZ8l5i2EDLcztcAnswsBE4I6Tg1C7A5
 A1kQ==
X-Gm-Message-State: AOAM530XoLFUDoByivfEVjbKKfRS9k+1Yfbh4bJkd62UbSEkZLgHVE4M
 WEvKQ38yhHwGhsXVVl9wYYSbuA==
X-Google-Smtp-Source: ABdhPJw+bDN8DYPHU262PoQiwijKVoHIXzGCs+naDHi90BaCNDFL/gdQ+2pDeJs7wr9RyZn8jR0tsA==
X-Received: by 2002:a65:6883:: with SMTP id e3mr5314254pgt.38.1603877346669;
 Wed, 28 Oct 2020 02:29:06 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
 by smtp.gmail.com with ESMTPSA id y1sm4733534pjl.12.2020.10.28.02.29.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Oct 2020 02:29:06 -0700 (PDT)
Subject: Re: [External] Re: [PATCH 1/2] nvmet: introduce transport layer
 keep-alive
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, chaitanya.kulkarni@wdc.com
References: <20201027121546.1776104-1-pizhenwei@bytedance.com>
 <bbbb8d0e-22a3-0e94-9a0a-b7ce1792a1ae@grimberg.me>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <3f8e5405-152f-d71b-a37f-9bf4f85714c2@bytedance.com>
Date: Wed, 28 Oct 2020 17:29:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bbbb8d0e-22a3-0e94-9a0a-b7ce1792a1ae@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_052911_146305_08E27EDC 
X-CRM114-Status: GOOD (  23.18  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvMjgvMjAgMzoxNSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPiBPbiAxMC8yNy8y
MCA1OjE1IEFNLCB6aGVud2VpIHBpIHdyb3RlOgo+PiBJbiB0aGUgemVybyBLQVRPIHNjZW5hcmlv
LCBpZiBpbml0aWF0b3IgY3Jhc2hlcyB3aXRob3V0IHRyYW5zcG9ydAo+PiBsYXllciBkaXNjb25u
ZWN0aW9uLCB0YXJnZXQgc2lkZSB3b3VsZCBuZXZlciByZWNsYWltIHJlc291cmNlcy4KPj4KPj4g
QSB0YXJnZXQgY291bGQgc3RhcnQgdHJhbnNwb3J0IGxheWVyIGtlZXAtYWxpdmUgdG8gZGV0ZWN0
IGRlYWQKPj4gY29ubmVjdGlvbiBmb3IgdGhlIGFkbWluIHF1ZXVlLgo+IAo+IE5vdCBzdXJlIHdo
eSB3ZSBzaG91bGQgd29ycnkgYWJvdXQga2F0bz0wLCBpdCdzIHJlYWxseQo+IG1vcmUgZm9yIGRl
YnVnIHB1cnBvc2VzLiBJJ2QgcmF0aGVyIHRoYXQgd2UgYmxvY2sgdGhpcwo+IG9wdGlvbiBmcm9t
IHRoZSBob3N0IGFsdG9nZXRoZXIuCj4gCgpBIHRhcmdldCBjYW4ndCBzdXBwb3NlIHRoYXQgaW5p
dGlhdG9yIGFsd2F5cyBydW5zIGFzIGV4cGVjdGVkLgpJJ20gZGV2ZWxvcGluZyBhIHVzZXIgbGV2
ZWwgTlZNZU9GIGxpYnJhcnksIGluIG15IHBsYW4sIHVzZXIgbGV2ZWwgS0FUTyAKdGltZXIgZ2V0
cyBhIGxpdHRsZSBjb21wbGV4LCBJJ2QgbGlrZSB0byB1c2UgVENQIGxldmVsIGtlZXAtYWxpdmUK
dG8gbWFrZSBjb2RlIHNpbXBsZS4gU28gdGhlIHRhcmdldCBzaWRlIG5lZWRzIHRvIGhhbmRsZSB6
ZXJvIEtBVE8gY2FzZS4KCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndl
aUBieXRlZGFuY2UuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1j
bWQuYyB8wqAgMiArLQo+PiDCoCBkcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuY8KgwqDCoMKgwqAg
fCAxNCArKysrKysrKysrKy0tLQo+PiDCoCBkcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmjCoMKg
wqDCoCB8wqAgMyArKy0KPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1p
bi1jbWQuYyAKPj4gYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCj4+IGluZGV4IGRj
YTM0NDg5YTFkYy4uNTNmYmQ1YzE5M2ExIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvdGFy
Z2V0L2FkbWluLWNtZC5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMK
Pj4gQEAgLTcyOSw3ICs3MjksNyBAQCB1MTYgbnZtZXRfc2V0X2ZlYXRfa2F0byhzdHJ1Y3QgbnZt
ZXRfcmVxICpyZXEpCj4+IMKgwqDCoMKgwqAgbnZtZXRfc3RvcF9rZWVwX2FsaXZlX3RpbWVyKHJl
cS0+c3EtPmN0cmwpOwo+PiDCoMKgwqDCoMKgIHJlcS0+c3EtPmN0cmwtPmthdG8gPSBESVZfUk9V
TkRfVVAodmFsMzIsIDEwMDApOwo+PiAtwqDCoMKgIG52bWV0X3N0YXJ0X2tlZXBfYWxpdmVfdGlt
ZXIocmVxLT5zcS0+Y3RybCk7Cj4+ICvCoMKgwqAgbnZtZXRfc3RhcnRfa2VlcF9hbGl2ZV90aW1l
cihyZXEtPnNxLT5jdHJsLCByZXEpOwo+PiDCoMKgwqDCoMKgIG52bWV0X3NldF9yZXN1bHQocmVx
LCByZXEtPnNxLT5jdHJsLT5rYXRvKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvY29yZS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMKPj4gaW5kZXggOTU3YjM5YTgy
NDMxLi40NTExOTJmN2FkNmEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29y
ZS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCj4+IEBAIC0zOTUsMTAgKzM5
NSwxOCBAQCBzdGF0aWMgdm9pZCBudm1ldF9rZWVwX2FsaXZlX3RpbWVyKHN0cnVjdCAKPj4gd29y
a19zdHJ1Y3QgKndvcmspCj4+IMKgwqDCoMKgwqAgbnZtZXRfY3RybF9mYXRhbF9lcnJvcihjdHJs
KTsKPj4gwqAgfQo+PiAtdm9pZCBudm1ldF9zdGFydF9rZWVwX2FsaXZlX3RpbWVyKHN0cnVjdCBu
dm1ldF9jdHJsICpjdHJsKQo+PiArdm9pZCBudm1ldF9zdGFydF9rZWVwX2FsaXZlX3RpbWVyKHN0
cnVjdCBudm1ldF9jdHJsICpjdHJsLCBzdHJ1Y3QgCj4+IG52bWV0X3JlcSAqcmVxKQo+PiDCoCB7
Cj4+IC3CoMKgwqAgaWYgKHVubGlrZWx5KGN0cmwtPmthdG8gPT0gMCkpCj4+ICvCoMKgwqAgaWYg
KHVubGlrZWx5KGN0cmwtPmthdG8gPT0gMCkpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXEt
Pm9wcy0+a2VlcF9hbGl2ZSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfaW5mbygiY3Ry
bCAlZCBzdGFydHMgd2l0aCB0cmFuc3BvcnQga2VlcC1hbGl2ZSAlc1xuIiwgCj4+IGN0cmwtPmNu
dGxpZCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXEtPm9wcy0+a2VlcF9h
bGl2ZShyZXEpID8gImZhaWxlZCIgOiAic3VjY2VlZCIpOwo+PiArwqDCoMKgwqDCoMKgwqAgZWxz
ZQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJjdHJsICVkIHN0YXJ0cyB3aXRo
b3V0IGJvdGggTlZNZU9GIGFuZCB0cmFuc3BvcnQgCj4+IGtlZXAtYWxpdmUiLAo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0cmwtPmNudGxpZCk7Cj4+ICsKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybjsKPj4gK8KgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgcHJfZGVidWcoImN0
cmwgJWQgc3RhcnQga2VlcC1hbGl2ZSB0aW1lciBmb3IgJWQgc2Vjc1xuIiwKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGN0cmwtPmNudGxpZCwgY3RybC0+a2F0byk7Cj4+IEBAIC0xMzgzLDcgKzEzOTEs
NyBAQCB1MTYgbnZtZXRfYWxsb2NfY3RybChjb25zdCBjaGFyICpzdWJzeXNucW4sIAo+PiBjb25z
dCBjaGFyICpob3N0bnFuLAo+PiDCoMKgwqDCoMKgIGN0cmwtPmVycl9jb3VudGVyID0gMDsKPj4g
wqDCoMKgwqDCoCBzcGluX2xvY2tfaW5pdCgmY3RybC0+ZXJyb3JfbG9jayk7Cj4+IC3CoMKgwqAg
bnZtZXRfc3RhcnRfa2VlcF9hbGl2ZV90aW1lcihjdHJsKTsKPj4gK8KgwqDCoCBudm1ldF9zdGFy
dF9rZWVwX2FsaXZlX3RpbWVyKGN0cmwsIHJlcSk7Cj4+IMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygm
c3Vic3lzLT5sb2NrKTsKPj4gwqDCoMKgwqDCoCBsaXN0X2FkZF90YWlsKCZjdHJsLT5zdWJzeXNf
ZW50cnksICZzdWJzeXMtPmN0cmxzKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvbnZtZXQuaCBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaAo+PiBpbmRleCA1NTlhMTVj
Y2MzMjIuLmRlMTc4NWNlOWZjZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9u
dm1ldC5oCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaAo+PiBAQCAtMzA1LDYg
KzMwNSw3IEBAIHN0cnVjdCBudm1ldF9mYWJyaWNzX29wcyB7Cj4+IMKgwqDCoMKgwqAgdTE2ICgq
aW5zdGFsbF9xdWV1ZSkoc3RydWN0IG52bWV0X3NxICpudm1lX3NxKTsKPj4gwqDCoMKgwqDCoCB2
b2lkICgqZGlzY292ZXJ5X2NoZykoc3RydWN0IG52bWV0X3BvcnQgKnBvcnQpOwo+PiDCoMKgwqDC
oMKgIHU4ICgqZ2V0X21kdHMpKGNvbnN0IHN0cnVjdCBudm1ldF9jdHJsICpjdHJsKTsKPj4gK8Kg
wqDCoCBpbnQgKCprZWVwX2FsaXZlKShzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpOwo+PiDCoCB9Owo+
PiDCoCAjZGVmaW5lIE5WTUVUX01BWF9JTkxJTkVfQklPVkVDwqDCoMKgIDgKPj4gQEAgLTM5NSw3
ICszOTYsNyBAQCB2b2lkIG52bWV0X2dldF9mZWF0X2FzeW5jX2V2ZW50KHN0cnVjdCBudm1ldF9y
ZXEgCj4+ICpyZXEpOwo+PiDCoCB1MTYgbnZtZXRfc2V0X2ZlYXRfa2F0byhzdHJ1Y3QgbnZtZXRf
cmVxICpyZXEpOwo+PiDCoCB1MTYgbnZtZXRfc2V0X2ZlYXRfYXN5bmNfZXZlbnQoc3RydWN0IG52
bWV0X3JlcSAqcmVxLCB1MzIgbWFzayk7Cj4+IMKgIHZvaWQgbnZtZXRfZXhlY3V0ZV9hc3luY19l
dmVudChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpOwo+PiAtdm9pZCBudm1ldF9zdGFydF9rZWVwX2Fs
aXZlX3RpbWVyKHN0cnVjdCBudm1ldF9jdHJsICpjdHJsKTsKPj4gK3ZvaWQgbnZtZXRfc3RhcnRf
a2VlcF9hbGl2ZV90aW1lcihzdHJ1Y3QgbnZtZXRfY3RybCAqY3RybCwgc3RydWN0IAo+PiBudm1l
dF9yZXEgKnJlcSk7Cj4+IMKgIHZvaWQgbnZtZXRfc3RvcF9rZWVwX2FsaXZlX3RpbWVyKHN0cnVj
dCBudm1ldF9jdHJsICpjdHJsKTsKPj4gwqAgdTE2IG52bWV0X3BhcnNlX2Nvbm5lY3RfY21kKHN0
cnVjdCBudm1ldF9yZXEgKnJlcSk7Cj4+CgotLSAKemhlbndlaSBwaQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

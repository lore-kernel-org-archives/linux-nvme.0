Return-Path: <SRS0=NJ67=AU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C13EC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2020 20:34:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A520F206DF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2020 20:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yw493SSh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LJJgAYho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A520F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x0aHPR6Y+tRe+QO8haKRUJgBZrX4GyH3la0EAK8d6/I=; b=Yw493SShnpMAheZBGoONljES0
	rQlRrrEHthlHbqqeVEBUvzVAB//4c4jIIeY8wLkhRgvrLWkbnq+14NymQi05IMzRxNFu8oIRX6uJp
	qIHj4CNDafmePeSKdK5LyBTmTVpNZBZuGT8ffBd5f7AhdlM1Jg3cWwyOyn/ypyq0ohcyaz+ZPjAuW
	G1jwUFq+4GFKfmZIwSMbT7B+M6OU/xzJqbzweYY2ZurktsjXAJqQ8bgQBvkbx2Vb3mm16q5g6gFkr
	1P8VCHL9D6XyBXaXqLGV710NmLq8Fu2lCygdiZN/6PaTRbykYMI6/mnDBPmWnA/KwJMack2orte3T
	dJthUqMUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtdFd-0006bc-AA; Thu, 09 Jul 2020 20:34:37 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtdFX-0006b1-HJ
 for linux-nvme@lists.infradead.org; Thu, 09 Jul 2020 20:34:33 +0000
Received: by mail-wm1-x341.google.com with SMTP id f18so3260488wml.3
 for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2020 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=e2LXCRGefu/zB2LeBTKqUAduXfhoUjkbKu2jbM0vNX0=;
 b=LJJgAYhoelMrx9f9gjsFwsUwN6PbBns2436E9U7LxLYxLZ5SbODuhSo9yhwCVinDtb
 8mjlU9XRSwuOteNTqkwUrEpzCp2TxXalxK3eR18onRE2cQ38MjwyqjUgbaU2MX2W3QwH
 6qrwDksLwXSneecA+eHoN8gXPoSvlbm3e0DeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=e2LXCRGefu/zB2LeBTKqUAduXfhoUjkbKu2jbM0vNX0=;
 b=W39kblF8l8mnn47Yl6fi2bSQ7lSZ2mFeZR0mT2QPcF1noWgiHVkwGoYZkLohc/UhDf
 15VUTda4/5uF3bI8D3thT4w8SHhKmwvfBP9l+MzWlFJXHadvf70id2R9WOIHrMexLSfQ
 uPT0LqRrjOg9Bh0A2WW1/M7C919ojz/CFy0KN2yN36d4Vnn8+eLBfKgZ8QE4dLt/fWkX
 TnjUNm3Ng8xltD4cE/SNLhwQxnfiY79C/kbLSZ2HQimmMNbDSBhMzros0NKwzh1j7bi6
 nZNYexCLIVl8Ca46fi5FvsF6Hoqlv2LYF8QLvRUgYqyJjWjtNzWqm4f6fKh34W/lINvz
 fgAw==
X-Gm-Message-State: AOAM533i73iNvWLWa/KEj+kl9Nh5uLqtZdGuI3eegY8kUFr4qot/4nD9
 sjMQ430OffsVNCDHjGN12B0zIA==
X-Google-Smtp-Source: ABdhPJwP+92Hk5j3P941jo7GueFupRCbdhsJzxS5Wa5GKQKlhxqS+hmLi1NyjgMDvOYrmZQFZri73w==
X-Received: by 2002:a1c:48e:: with SMTP id 136mr1603367wme.164.1594326867913; 
 Thu, 09 Jul 2020 13:34:27 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id u84sm6280732wmg.7.2020.07.09.13.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 13:34:26 -0700 (PDT)
Subject: Re: [PATCH v7] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <ca82af03-0cf7-bb71-cf55-caf88c278dfa@broadcom.com>
Date: Thu, 9 Jul 2020 13:34:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200709_163431_845017_314ED3E4 
X-CRM114-Status: GOOD (  26.17  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, "Ewan D. Milne" <emilne@redhat.com>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA3LzgvMjAyMCA4OjA3IEFNLCBWaWN0b3IgR2xhZGtvdiB3cm90ZToKPiBDb21tYW5kcyBn
ZXQgc3R1Y2sgd2hpbGUgSG9zdCBOVk1lIGNvbnRyb2xsZXIgKFRDUCBvciBSRE1BKSBpcyBpbgo+
IHJlY29ubmVjdCBzdGF0ZS4gTlZNZSBjb250cm9sbGVyIGVudGVycyBpbnRvIHJlY29ubmVjdCBz
dGF0ZSB3aGVuIGl0Cj4gbG9zZXMgY29ubmVjdGlvbiB3aXRoIHRoZSB0YXJnZXQuIEl0IHRyaWVz
IHRvIHJlY29ubmVjdCBldmVyeSAxMAo+IHNlY29uZHMgKGRlZmF1bHQpIHVudGlsIHN1Y2Nlc3Nm
dWwgcmVjb25uZWN0aW9uIG9yIHVudGlsIHJlY29ubmVjdAo+IHRpbWUtb3V0IGlzIHJlYWNoZWQu
IFRoZSBkZWZhdWx0IHJlY29ubmVjdCB0aW1lIG91dCBpcyAxMCBtaW51dGVzLgo+Cj4gVG8gZml4
IHRoaXMgbG9uZyBkZWxheSBkdWUgdG8gdGhlIGRlZmF1bHQgdGltZW91dCB3ZSBpbnRyb2R1Y2Ug
bmV3Cj4gc2Vzc2lvbiBwYXJhbWV0ZXIgImZhc3RfaW9fZmFpbF90bW8iLiBUaGUgdGltZW91dCBp
cyBtZWFzdXJlZCBpbgo+IHNlY29uZHMgZnJvbSB0aGUgY29udHJvbGxlciByZWNvbm5lY3QsIGFu
eSBjb21tYW5kIGJleW9uZCB0aGF0Cj4gdGltZW91dCBpcyByZWplY3RlZC4gVGhlIG5ldyBwYXJh
bWV0ZXIgdmFsdWUgbWF5IGJlIHBhc3NlZCBkdXJpbmcKPiAnY29ubmVjdCcuCj4gVGhlIGRlZmF1
bHQgdmFsdWUgb2YgMCBtZWFucyBubyB0aW1lb3V0IChzaW1pbGFyIHRvIGN1cnJlbnQgYmVoYXZp
b3IpLgo+Cj4gV2UgYWRkIGEgbmV3IGNvbnRyb2xsZXIgTlZNRV9DVFJMX0ZBSUxGQVNUX0VYUElS
RUQgYW5kIHJlc3BlY3RpdmUKPiBkZWxheWVkIHdvcmsgdGhhdCB1cGRhdGVzIHRoZSBOVk1FX0NU
UkxfRkFJTEZBU1RfRVhQSVJFRCBmbGFnLgo+Cj4gV2hlbiB0aGUgY29udHJvbGxlciBpcyBlbnRl
cmluZyB0aGUgQ09OTkVDVElORyBzdGF0ZSwgd2Ugc2NoZWR1bGUKPiB0aGUgZGVsYXllZF93b3Jr
IGJhc2VkIG9uIGZhaWxmYXN0IHRpbWVvdXQgdmFsdWUuIElmIHRoZSB0cmFuc2l0aW9uCj4gaXMg
b3V0IG9mIENPTk5FQ1RJTkcsIHRlcm1pbmF0ZSBkZWxheWVkIHdvcmsgaXRlbSBhbmQgZW5zdXJl
Cj4gZmFpbGZhc3RfZXhwaXJlZCBpcyBmYWxzZS4gSWYgZGVsYXllZCB3b3JrIGl0ZW0gZXhwaXJl
cyB0aGVuIHNldAo+ICJOVk1FX0NUUkxfRkFJTEZBU1RfRVhQSVJFRCIgZmxhZyB0byB0cnVlLgo+
Cj4gV2UgYWxzbyB1cGRhdGUgbnZtZl9mYWlsX25vbnJlYWR5X2NvbW1hbmQoKSBhbmQKPiBudm1l
X2F2YWlsYWJsZV9wYXRoKCkgZnVuY3Rpb25zIHdpdGggY2hlY2sgdGhlCj4gIk5WTUVfQ1RSTF9G
QUlMRkFTVF9FWFBJUkVEIiBjb250cm9sbGVyIGZsYWcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBWaWN0
b3IgR2xhZGtvdiA8dmljdG9yLmdsYWRrb3YgYXQga2lveGlhLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxrYXJuaSBhdCB3ZGMuY29tPgo+IFJl
dmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KPgo+IC4uLgo+IC0tLQo+
ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jICAgICAgfCA0OSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystCj4gICBkcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMg
ICB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJp
Y3MuaCAgIHwgIDUgKysrKysKPiAgIGRyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIHwgIDUg
KysrKy0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCAgICAgIHwgIDMgKysrCj4gICA1IGZp
bGVzIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
Cj4gaW5kZXggZjNjMDM3Zi4uY2E5OTBiYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBAQCAtMTM3LDYgKzEz
NywzNyBAQCBpbnQgbnZtZV90cnlfc2NoZWRfcmVzZXQoc3RydWN0IG52bWVfY3RybCAqY3RybCkK
PiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKG52bWVfdHJ5X3NjaGVkX3Jlc2V0KTsKPgo+ICtz
dGF0aWMgdm9pZCBudm1lX2ZhaWxmYXN0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+
ICt7Cj4gKwlzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gY29udGFpbmVyX29mKHRvX2RlbGF5ZWRf
d29yayh3b3JrKSwKPiArCQkJc3RydWN0IG52bWVfY3RybCwgZmFpbGZhc3Rfd29yayk7Cj4gKwo+
ICsJaWYgKGN0cmwtPnN0YXRlICE9IE5WTUVfQ1RSTF9DT05ORUNUSU5HKQo+ICsJCXJldHVybjsK
PiArCj4gKwlzZXRfYml0KE5WTUVfQ1RSTF9GQUlMRkFTVF9FWFBJUkVELCAmY3RybC0+ZmxhZ3Mp
Owo+ICsJZGV2X2luZm8oY3RybC0+ZGV2aWNlLCAiZmFpbGZhc3QgZXhwaXJlZFxuIik7Cj4gKwlu
dm1lX2tpY2tfcmVxdWV1ZV9saXN0cyhjdHJsKTsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2
b2lkIG52bWVfc3RhcnRfZmFpbGZhc3Rfd29yayhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQo+ICt7
Cj4gKwlpZiAoIWN0cmwtPm9wdHMgfHwgY3RybC0+b3B0cy0+ZmFzdF9pb19mYWlsX3RtbyA9PSAt
MSkKPiArCQlyZXR1cm47Cj4gKwo+ICsJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZjdHJsLT5mYWls
ZmFzdF93b3JrLAo+ICsJCQkgICAgICBjdHJsLT5vcHRzLT5mYXN0X2lvX2ZhaWxfdG1vICogSFop
Owo+ICt9Cj4gKwo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9zdG9wX2ZhaWxmYXN0X3dvcmso
c3RydWN0IG52bWVfY3RybCAqY3RybCkKPiArewo+ICsJaWYgKCFjdHJsLT5vcHRzKQo+ICsJCXJl
dHVybjsKPiArCj4gKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmN0cmwtPmZhaWxmYXN0X3dv
cmspOwo+ICsJY2xlYXJfYml0KE5WTUVfQ1RSTF9GQUlMRkFTVF9FWFBJUkVELCAmY3RybC0+Zmxh
Z3MpOwo+ICt9Cj4gKwo+ICAgaW50IG52bWVfcmVzZXRfY3RybChzdHJ1Y3QgbnZtZV9jdHJsICpj
dHJsKQo+ICAgewo+CgpMb29rcyBnb29kIHRvIG1lLsKgIE9ubHkgbml0IEkgc2VlIGlzIC0gd2h5
IGFyZSB3ZSBjaGVja2luZyBjdHJsLT5vcHRzIGluIAp0aGUgeHh4X2ZhaWxmYXN0X3dvcmsoKSBy
b3V0aW5lcyA/wqAgSWYgdGhhdCdzIGFjdHVhbGx5IG51bGwgdGhhdCdzIHZlcnkgCmJhZCBuZXdz
LiBJdCBzaG91bGQgb25seSBiZSBudWxsIG9mIHRoZSBjb250cm9sbGVyIGlzIGluIHRoZSBwcm9j
ZXNzIG9mIApiZWluZyBkZWxldGVkLCB3aGljaCBzaG91bGQgaGF2ZSB0ZXJtaW5hdGVkIGFsbCB0
aGVzZSByb3V0aW5lIHNlcXVlbmNlcyAKYmVmb3JlIHRoZW4uCgpPdGhlcndpc2UuLi4KUmV2aWV3
ZWQtYnk6IEphbWVzIFNtYXJ0IDxqYW1lcy5zbWFydEBicm9hZGNvbS5jb20+CgotLSBqYW1lcwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

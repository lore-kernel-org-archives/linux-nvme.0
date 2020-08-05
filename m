Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A7EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 08:59:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D78E22B40
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I0XlH+OL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT8UWReO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D78E22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vbDS/i06aVLv+FfyUpwaAvnodDWqvLglFEbJ9LvyYf8=; b=I0XlH+OLITCBYDIrl/wfXvarq
	VDY/kBzIo7oxDk/zxBQj5zyoQrKmi+ap6lYIuJX8SI/WTUpafUhZxE2PHqhVAEjfqpHsQgOYpM8Ke
	N3tKznWJciSSBHtE4O/zAJs/eQA2tWekLBWlCdET+uRBZdfUZWzPOWBvfPtZDhe2+pxeyLUQlKC3z
	ZI5jRvy2aSHjzbUGiS3juVwtjQr9RAGkR/MzpOqVvZYEFka8UDnbS1PTrG/no/EwYz6L97DWBablo
	DHgJA7V02L7Ixas7BuuhlNsBhnMSxO7GOJLs7R7j3diQ/g4tQrvYYnT6tv2iICJs9ERPqbk8HIy7Z
	HaxJTRXbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3FGz-00051R-MR; Wed, 05 Aug 2020 08:59:45 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3FGy-00050y-7k
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 08:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596617983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knBmS+iunxzbuYmX5BZ4IC/eX147QBBLva8PZl3vxl0=;
 b=XT8UWReOpvodDVOyApKXC6/vYyZFgPUw22ydNnMFhc1F6bJNY4S6FvzHz7FYzDNGX3Vkzc
 qRI2Q94mkvJe/iKKfeEAvQXixuUbCZtuj/om64AYliFAx2SPZSnYuqYRri8h0u1+Btg1Pz
 o78B8Az9e4fgNK7Af06kSZErPK/szJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-qEgyeRnYNO2goT5YAXYF6w-1; Wed, 05 Aug 2020 04:58:05 -0400
X-MC-Unique: qEgyeRnYNO2goT5YAXYF6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2390E1005504;
 Wed,  5 Aug 2020 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-115.pek2.redhat.com
 [10.72.12.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 602785C1D2;
 Wed,  5 Aug 2020 08:57:59 +0000 (UTC)
Subject: Re: [PATCH rfc 6/6] nvme: support rdma transport type
To: Sagi Grimberg <sagi@grimberg.me>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <20200803064835.67927-7-sagi@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <6edfbfd4-106e-f200-2783-d59615f0a84c@redhat.com>
Date: Wed, 5 Aug 2020 16:57:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200803064835.67927-7-sagi@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_045944_448688_2CD2426A 
X-CRM114-Status: GOOD (  19.13  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Johannes Thumshirn <jthumshirn@suse.de>, Keith Busch <kbusch@kernel.org>,
 Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzMvMjAgMjo0OCBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5
OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+IC0tLQo+ICAgdGVzdHMvbnZtZS9y
YyB8IDE1ICsrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS90ZXN0cy9udm1lL3JjIGIvdGVzdHMvbnZtZS9yYwo+IGluZGV4
IDY5YWI3ZDJmMzk2NC4uMzFkMDJmZWZhNzBlIDEwMDY0NAo+IC0tLSBhL3Rlc3RzL252bWUvcmMK
PiArKysgYi90ZXN0cy9udm1lL3JjCj4gQEAgLTUsNiArNSw3IEBACj4gICAjIFRlc3Qgc3BlY2lm
aWMgdG8gTlZNZSBkZXZpY2VzCj4gICAKPiAgIC4gY29tbW9uL3JjCj4gKy4gY29tbW9uL211bHRp
cGF0aC1vdmVyLXJkbWEKPiAgIAo+ICAgZGVmX3RyYWRkcj0iMTI3LjAuMC4xIgo+ICAgZGVmX2Fk
cmZhbT0iaXB2NCIKPiBAQCAtMjUsNiArMjYsMTIgQEAgX252bWVfcmVxdWlyZXMoKSB7Cj4gICAJ
CV9oYXZlX21vZHVsZXMgbnZtZXQgbnZtZS1jb3JlIG52bWUtdGNwIG52bWV0LXRjcAo+ICAgCQlf
aGF2ZV9jb25maWdmcwo+ICAgCQk7Owo+ICsJcmRtYSkKPiArCQlfaGF2ZV9tb2R1bGVzIG52bWV0
IG52bWUtY29yZSBudm1lLXJkbWEgbnZtZXQtcmRtYQo+ICsJCV9oYXZlX2NvbmZpZ2ZzCj4gKwkJ
X2hhdmVfcHJvZ3JhbSByZG1hCj4gKwkJX2hhdmVfbW9kdWxlcyByZG1hX3J4ZSBzaXcKPiArCQk7
Owo+ICAgCSopCj4gICAJCVNLSVBfUkVBU09OPSJ1bnN1cHBvcnRlZCBudm1lX3RydHlwZT0ke252
bWVfdHJ0eXBlfSIKPiAgIAkJcmV0dXJuIDEKPiBAQCAtMTE1LDYgKzEyMiw5IEBAIF9jbGVhbnVw
X252bWV0KCkgewo+ICAgCQltb2Rwcm9iZSAtciBudm1ldC0ke252bWVfdHJ0eXBlfSAyPi9kZXYv
bnVsbAo+ICAgCWZpCj4gICAJbW9kcHJvYmUgLXIgbnZtZXQgMj4vZGV2L251bGwKPiArCWlmIFtb
ICIke252bWVfdHJ0eXBlfSIgPT0gInJkbWEiIF1dOyB0aGVuCj4gKwkJc3RvcF9zb2Z0X3JkbWEK
PiArCWZpCj4gICB9Cj4gICAKIyBudm1lX3RydHlwZT1yZG1hIC4vY2hlY2sgbnZtZS8wMzAKbnZt
ZS8wMzAgKGVuc3VyZSB0aGUgZGlzY292ZXJ5IGdlbmVyYXRpb24gY291bnRlciBpcyB1cGRhdGVk
IGFwcHJvcHJpYXRlbHkpCm52bWUvMDMwIChlbnN1cmUgdGhlIGRpc2NvdmVyeSBnZW5lcmF0aW9u
IGNvdW50ZXIgaXMgdXBkYXRlZCAKYXBwcm9wcmlhdGVseSkgW3Bhc3NlZF0KIMKgwqDCoCBydW50
aW1lwqAgMC42MTZzwqAgLi4uwqAgMC41MjBzIDQ2MDogdW5sb2FkX21vZHVsZTogY29tbWFuZCBu
b3QgZm91bmQKClRoZSB1bmxvYWRfbW9kdWxlWzFdIHdhcyBkZWZpbmVkIGluIFsyXSwgaG93IGFi
b3V0IG1vdmUgdGhlIGRlZmluaXRpb24gCnRvIFszXSwKClsxXQpfY2xlYW51cF9udm1ldC0+c3Rv
cF9zb2Z0X3JkbWEtPnVubG9hZF9tb2R1bGUKClsyXQouL3Rlc3RzL252bWVvZi1tcC9yYwoKWzNd
CmNvbW1vbi9tdWx0aXBhdGgtb3Zlci1yZG1hCgo+ICAgX3NldHVwX252bWV0KCkgewo+IEBAIC0x
MjQsNiArMTM0LDExIEBAIF9zZXR1cF9udm1ldCgpIHsKPiAgIAkJbW9kcHJvYmUgbnZtZXQtJHtu
dm1lX3RydHlwZX0KPiAgIAlmaQo+ICAgCW1vZHByb2JlIG52bWUtJHtudm1lX3RydHlwZX0KPiAr
CWlmIFtbICIke252bWVfdHJ0eXBlfSIgPT0gInJkbWEiIF1dOyB0aGVuCj4gKwkJc3RhcnRfc29m
dF9yZG1hCj4gKwkJcmRtYV9pbnRmcz0kKHJkbWFfbmV0d29ya19pbnRlcmZhY2VzKQo+ICsJCWRl
Zl90cmFkZHI9JChnZXRfaXB2NF9hZGRyICR7cmRtYV9pbnRmc1swXX0pCj4gKwlmaQo+ICAgfQo+
ICAgCj4gICBfbnZtZV9kaXNjb25uZWN0X2N0cmwoKSB7CgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=

Return-Path: <SRS0=cNJd=3L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDEC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2020 21:57:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5215A2465B
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2020 21:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fi0gpkqf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YwP/tn37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5215A2465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fv1N9TCSWhLtESzBi89zO+zgaCp1lzNbhZ/P8s5JAQc=; b=Fi0gpkqfQdN2j7wMGOthk/s1J
	pyX1F0wAf8EeNd+vvz3cVRPh3C2qnYhGWwrvurYFmwUHYTF84f5up/a7BnlDy2XMYyxHbIuRNb+o4
	iqTNCYYsE7vk26DgcBNFU2n9lpIljkLkEHt8CQ99Z3VCrdgMZffjv6avecfqCFBj0MtzQqZdceGH+
	6ycLt+S6hwA0jzg1E5Mxx9/liDxOp99w0+h2onLufIqw+gzYyrqxR9P5b5rjJ3SdolqZAOscayf8r
	2AqfZP+NCngtyTRIqgH/VX+9YQhM1dWY3pybHakZvSV/W0ibyam9+hfXscY2AJGvrvEgOo6lo0ziL
	QPF4FZfsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iuO08-0004a3-EI; Wed, 22 Jan 2020 21:57:28 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iuO04-0004Yx-9L
 for linux-nvme@lists.infradead.org; Wed, 22 Jan 2020 21:57:25 +0000
Received: by mail-pg1-x542.google.com with SMTP id s64so227325pgb.9
 for <linux-nvme@lists.infradead.org>; Wed, 22 Jan 2020 13:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=APweT09u6jgf9ONoIyFVS+Qm3UM6eBtg65meA6Aba5Y=;
 b=YwP/tn373crlO6zC/K+h10rG92/Ujn7SKorFnbhd0SjP6MqIl032JFMP+1pVtYvRju
 pUpIdJzNPo3QdxhsB4NL2V2JVJHRvV3HELxmb4J6pJ15CjiDhwQSDAvp4cT/MzTTj+Pm
 Teg2yycXONATyPvLKXfSfbSu3SBMzQuYsL3Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=APweT09u6jgf9ONoIyFVS+Qm3UM6eBtg65meA6Aba5Y=;
 b=IY2WUP+fnB/RE4Ri8pLp3w1ZymG+jQK5wPHZGm1oUMKZCgpcVxKm/KSdewqaB0stFb
 7Jk5KY6o2cUZn3VNSRucRZ2VDuXEsI2yoZ9mTB5oOdvRZTR6vxX9ka/uJB8IxC9y9CtU
 64uRifouBW+w8GAIrx8hOpsHyUG1FLLMBM/J/UR9mZD+sPQHckZ/03poym6/YKf8uKE3
 lKxHKMab9qI3csrlzZFay/O7nfT0OR1qcOQuYFQ8hM53jsdtiGa8KfEvfBiadu1kskfV
 NrxLAjFBaRI7QByxfbXt4RgGY3AoCHeuWkdKtlM/RYyi5O3Q+95bJE8c7qPR+lPPy6h7
 nO6w==
X-Gm-Message-State: APjAAAWA5QtEt5UkGChHoV33JdN9nqc4gvcEF2TI8CQXsN7sY3C38sYK
 SGg2otdBi/cCurOoJGI1kGdGQA==
X-Google-Smtp-Source: APXvYqyMLgGTtOKqunhWKQdYkSI7OmacqmXpGgFMv6A++LtiKgfjJ23+2vFbFwz5cTWLir9Ak2yaXw==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr407830pgt.145.1579730242666; 
 Wed, 22 Jan 2020 13:57:22 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id q25sm49131310pfg.41.2020.01.22.13.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 13:57:22 -0800 (PST)
Subject: Re: [PATCH 07/16] nvme-rdma: Add metadata/T10-PI support
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com
References: <20191202144812.147686-1-maxg@mellanox.com>
 <20191202144812.147686-9-maxg@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <522e0efe-5907-b28d-ef90-4ceca0fb3103@broadcom.com>
Date: Wed, 22 Jan 2020 13:57:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191202144812.147686-9-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200122_135724_332486_F5D2F454 
X-CRM114-Status: GOOD (  17.44  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, shlomin@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxMi8yLzIwMTkgNjo0OCBBTSwgTWF4IEd1cnRvdm95IHdyb3RlOgo+IEBAIC0xMjE1LDM0
ICsxMjgzLDExNSBAQCBzdGF0aWMgaW50IG52bWVfcmRtYV9tYXBfc2dfc2luZ2xlKHN0cnVjdCBu
dm1lX3JkbWFfcXVldWUgKnF1ZXVlLAo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gLXN0YXRp
YyBpbnQgbnZtZV9yZG1hX21hcF9zZ19mcihzdHJ1Y3QgbnZtZV9yZG1hX3F1ZXVlICpxdWV1ZSwK
PiAtCQlzdHJ1Y3QgbnZtZV9yZG1hX3JlcXVlc3QgKnJlcSwgc3RydWN0IG52bWVfY29tbWFuZCAq
YywKPiAtCQlpbnQgY291bnQpCj4gKyNpZmRlZiBDT05GSUdfQkxLX0RFVl9JTlRFR1JJVFkKPiAr
c3RhdGljIHZvaWQgbnZtZV9yZG1hX3NldF9kaWZmX2RvbWFpbihzdHJ1Y3QgbnZtZV9jb21tYW5k
ICpjbWQsIHN0cnVjdCBiaW8gKmJpbywKPiArCQlzdHJ1Y3QgaWJfc2lnX2RvbWFpbiAqZG9tYWlu
LCBzdHJ1Y3QgcmVxdWVzdCAqcnEpCj4gICB7Cj4gLQlzdHJ1Y3QgbnZtZV9rZXllZF9zZ2xfZGVz
YyAqc2cgPSAmYy0+Y29tbW9uLmRwdHIua3NnbDsKPiAtCWludCBucjsKPiArCXN0cnVjdCBibGtf
aW50ZWdyaXR5ICpiaSA9IGJsa19nZXRfaW50ZWdyaXR5KGJpby0+YmlfZGlzayk7Cj4gKwlzdHJ1
Y3QgbnZtZV9ucyAqbnMgPSBycS0+cnFfZGlzay0+cHJpdmF0ZV9kYXRhOwo+ICsKPiArCVdBUk5f
T04oYmkgPT0gTlVMTCk7Cj4gICAKPiAtCXJlcS0+bXIgPSBpYl9tcl9wb29sX2dldChxdWV1ZS0+
cXAsICZxdWV1ZS0+cXAtPnJkbWFfbXJzKTsKPiAtCWlmIChXQVJOX09OX09OQ0UoIXJlcS0+bXIp
KQo+IC0JCXJldHVybiAtRUFHQUlOOwo+ICsJZG9tYWluLT5zaWdfdHlwZSA9IElCX1NJR19UWVBF
X1QxMF9ESUY7Cj4gKwlkb21haW4tPnNpZy5kaWYuYmdfdHlwZSA9IElCX1QxMERJRl9DUkM7Cj4g
Kwlkb21haW4tPnNpZy5kaWYucGlfaW50ZXJ2YWwgPSAxIDw8IGJpLT5pbnRlcnZhbF9leHA7Cj4g
Kwlkb21haW4tPnNpZy5kaWYucmVmX3RhZyA9IGxlMzJfdG9fY3B1KGNtZC0+cncucmVmdGFnKTsK
PiAgIAo+ICAgCS8qCj4gLQkgKiBBbGlnbiB0aGUgTVIgdG8gYSA0SyBwYWdlIHNpemUgdG8gbWF0
Y2ggdGhlIGN0cmwgcGFnZSBzaXplIGFuZAo+IC0JICogdGhlIGJsb2NrIHZpcnR1YWwgYm91bmRh
cnkuCj4gKwkgKiBBdCB0aGUgbW9tZW50IHdlIGhhcmQgY29kZSB0aG9zZSwgYnV0IGluIHRoZSBm
dXR1cmUKPiArCSAqIHdlIHdpbGwgdGFrZSB0aGVtIGZyb20gY21kLgo+ICAgCSAqLwo+IC0JbnIg
PSBpYl9tYXBfbXJfc2cocmVxLT5tciwgcmVxLT5kYXRhX3NnbC5zZ190YWJsZS5zZ2wsIGNvdW50
LCBOVUxMLAo+IC0JCQkgIFNaXzRLKTsKPiAtCWlmICh1bmxpa2VseShuciA8IGNvdW50KSkgewo+
IC0JCWliX21yX3Bvb2xfcHV0KHF1ZXVlLT5xcCwgJnF1ZXVlLT5xcC0+cmRtYV9tcnMsIHJlcS0+
bXIpOwo+IC0JCXJlcS0+bXIgPSBOVUxMOwo+IC0JCWlmIChuciA8IDApCj4gLQkJCXJldHVybiBu
cjsKPiAtCQlyZXR1cm4gLUVJTlZBTDsKPiArCWRvbWFpbi0+c2lnLmRpZi5hcHB0YWdfY2hlY2tf
bWFzayA9IDB4ZmZmZjsKPiArCWRvbWFpbi0+c2lnLmRpZi5hcHBfZXNjYXBlID0gdHJ1ZTsKPiAr
CWRvbWFpbi0+c2lnLmRpZi5yZWZfZXNjYXBlID0gdHJ1ZTsKPiArCWlmIChucy0+cGlfdHlwZSAh
PSBOVk1FX05TX0RQU19QSV9UWVBFMykKPiArCQlkb21haW4tPnNpZy5kaWYucmVmX3JlbWFwID0g
dHJ1ZTsKPiArfQo+ICsKPgoKT24gYSBwZXItaW8gYmFzaXMsIHRoZXJlIG5lZWRzIHRvIGJlIHNw
ZWNpZmljIGRlc2NyaXB0aW9ucyBvZiB0aGUgRElGIAppbmZvcm1hdGlvbiB0byBwcm9ncmFtIHRo
ZSBwb3J0IGhhcmR3YXJlLsKgIFRoaW5ncyBzdWNoIGFzIGJsb2NrIHNpemUsIAp0eXBlLCBhbmQg
c28uIEkgc2VlIHRoaXMgcm91dGluZSB1c2luZyBhIG1peCBvZiB0aGUgYmlvIHRoYXQgaXMgCmFz
c29jaWF0ZWQgd2l0aCB0aGUgb3JpZ2luYWwgcmVxdWVzdCBhcyB3ZWxsIGFzIHRoZSBuYW1lc3Bh
Y2UgcG9pbnRlciB0byAKZ2V0IHRoaXMgaW5mby4gwqDCoCBUbyBtZSB0aGUgcmVhY2hpbmcgaW50
byB0aGUgYmlvLCBhcyB3ZWxsIGFzIHRoZSAKbG9jYXRpbmcgb2YgdGhlIG5zIHN0cnVjdHVyZXMg
YXJlIHJlYWNoaW5nIGludG8gdGhlIG90aGVyIGxheWVycyB0b28gbXVjaC4KCldvdWxkbid0IHdl
IGJlIGJldHRlciBvZmYgd2l0aCB3aXRoIHRoZSBjb3JlIGxheWVyIGRvaW5nIGFsbCB0aGUgCnJl
YWNoaW5nIGFuZCBzZXR0aW5nIHVwIGEgcGkgc3RydWN0dXJlIGluIHRoZSBudm1lX3JlcXVlc3Qg
d2l0aCB0aGlzIAppbmZvcm1hdGlvbiA/wqDCoCByZXBsYWNlIGhhc19waSB3aXRoIHRoaXMgcGkg
c3RydWN0IGFuZCAKIm52bWVfcmVxKHJxKS0+cGkucGlfdHlwZSA9PSAwIiBpcyBlcXVpdmFsZW50
IHRvIGhhc19waSA/wqDCoCBJZiB3ZSBkaWRuJ3QgCndhbnQgdG8gcmVwbGljYXRlIHRoZSBQSSBp
bmZvLCB0aGVuIG52bWVfcmVxdWVzdCBjYW4gc2ltcGx5IGFkZCBhIApwb2ludGVyIHRvIHRoZSBu
cywgYW5kIHRoZSBucyBjYW4gYmUgbG9va2VkIGF0IGV4cGxpY2l0bHkgdG8gZ2F0aGVyIHRoZSAK
YXR0cmlidXRlcy4KClRob3VnaHRzID8KCi0tIGphbWVzCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=

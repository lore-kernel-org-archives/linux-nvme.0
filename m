Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306C0C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 18:00:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90CA2173E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 18:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RhSlyPF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90CA2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N9PdX05nDlvrUW+7RIxLpMYy7t+TFOoa4Fx9LM+AZUk=; b=RhSlyPF5oa509naxR5/mjt7O0
	1iTSz3Vm0+TG+3MvDctskYWxzAe6g2G68aLzjF3AP8CNyk4qIb7tIR78I4srzk4DKFktD18vy+eRY
	zwG007ju3WrNspeStBUKS3gZO2qjFEoC+I12S56mtkYf6pTZ4uE4HAFqmWVAfmGo3MSUR8AqnOAsd
	zVyfnRyeNPDQuMRmI90h7S/CFQ9WUtjJ6NI84+Wrop1gvgfh7xf7vP1RfcYIq2ArakJsy06iZBCSA
	qwbpgytLxjPVI3JtMpIZIZiCoq2rBhPn04z4xN1QIvAZ/kinr1nxdTDS/gB2v21+uhtcO/kFyAFkO
	UF4CLRl/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3Nhj-0003j4-Up; Wed, 05 Aug 2020 17:59:55 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3Nhf-0003hK-5Q
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 17:59:52 +0000
Received: by mail-wr1-f68.google.com with SMTP id r2so36462093wrs.8
 for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2020 10:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8Xfr80AqzucZQwBQ+/F+gOUpjpsSV020pySmbLRu/yw=;
 b=hNNNNwP7wsBrzBscu+WSORMNECSrCB/DjygKaeBh7zogJmJcyLSVvDDiu4tXcKu9O9
 wIerH2WzNFAm3x7F4Voxhpai00joz0fQ5K2R8MUnfjw2a6QjXSPJaBK/xsYfSWWOhaaA
 JgPzFBUj7TRJcO1LpKMjTzhCzZdeja3AEJsl1yeevuUjUXLfmJiu9oDYSnAyFB5cfgVi
 p+AeZWwxIfTMnB6efq3ZisiaGXL1BY5lf5nHtv0sNxFBBTbZ6j6mkkQAsrtoETXum/Ez
 9aTQ+CerrtBn1eSXrYsKo97mIwCZukkpskQe/ilI8PivwgTGIX+Gw5BlD4pmhlMIN6yj
 BBhg==
X-Gm-Message-State: AOAM533X9o5cjjALFSbkK1Nr+7TiFR22BezPGgDqPJWRVKYT6WaEn3Q7
 rwViJeTFSopCqRT4uCmgrhw=
X-Google-Smtp-Source: ABdhPJy9KlX1hIfSp30xvwI//ewlrBSnCuyeI/ge0ZLoovlZPzFkG+KlPlEfTGMy4wJRBlLGWlGjDw==
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr3823250wro.341.1596650388332; 
 Wed, 05 Aug 2020 10:59:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2803:3684:5e52:5417?
 ([2601:647:4802:9070:2803:3684:5e52:5417])
 by smtp.gmail.com with ESMTPSA id s131sm3728576wme.17.2020.08.05.10.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 10:59:47 -0700 (PDT)
Subject: Re: [PATCH rfc 6/6] nvme: support rdma transport type
To: Yi Zhang <yi.zhang@redhat.com>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <20200803064835.67927-7-sagi@grimberg.me>
 <6edfbfd4-106e-f200-2783-d59615f0a84c@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f29fc615-a5f7-a160-f33e-d84aca03d639@grimberg.me>
Date: Wed, 5 Aug 2020 10:59:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6edfbfd4-106e-f200-2783-d59615f0a84c@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_135951_214863_18ADD885 
X-CRM114-Status: GOOD (  16.77  )
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Johannes Thumshirn <jthumshirn@suse.de>, Keith Busch <kbusch@kernel.org>,
 Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gIyBudm1lX3RydHlwZT1yZG1hIC4vY2hlY2sgbnZtZS8wMzAKPiBudm1lLzAzMCAoZW5zdXJl
IHRoZSBkaXNjb3ZlcnkgZ2VuZXJhdGlvbiBjb3VudGVyIGlzIHVwZGF0ZWQgYXBwcm9wcmlhdGVs
eSkKPiBudm1lLzAzMCAoZW5zdXJlIHRoZSBkaXNjb3ZlcnkgZ2VuZXJhdGlvbiBjb3VudGVyIGlz
IHVwZGF0ZWQgCj4gYXBwcm9wcmlhdGVseSkgW3Bhc3NlZF0KPiAgwqDCoMKgIHJ1bnRpbWXCoCAw
LjYxNnPCoCAuLi7CoCAwLjUyMHMgNDYwOiB1bmxvYWRfbW9kdWxlOiBjb21tYW5kIG5vdCBmb3Vu
ZAo+IAo+IFRoZSB1bmxvYWRfbW9kdWxlWzFdIHdhcyBkZWZpbmVkIGluIFsyXSwgaG93IGFib3V0
IG1vdmUgdGhlIGRlZmluaXRpb24gCj4gdG8gWzNdLAo+IAo+IFsxXQo+IF9jbGVhbnVwX252bWV0
LT5zdG9wX3NvZnRfcmRtYS0+dW5sb2FkX21vZHVsZQo+IAo+IFsyXQo+IC4vdGVzdHMvbnZtZW9m
LW1wL3JjCj4gCj4gWzNdCj4gY29tbW9uL211bHRpcGF0aC1vdmVyLXJkbWEKClJpZ2h0LCBJIGhh
ZCB0aGlzIGNoYW5nZSBsb2NhbGx5OgotLQpkaWZmIC0tZ2l0IGEvY29tbW9uL211bHRpcGF0aC1v
dmVyLXJkbWEgYi9jb21tb24vbXVsdGlwYXRoLW92ZXItcmRtYQppbmRleCA2NzZkMjgzN2ZiMDYu
LmU1NGIyYTk2MTUzYyAxMDA2NDQKLS0tIGEvY29tbW9uL211bHRpcGF0aC1vdmVyLXJkbWEKKysr
IGIvY29tbW9uL211bHRpcGF0aC1vdmVyLXJkbWEKQEAgLTQ1Nyw3ICs0NTcsNyBAQCBzdG9wX3Nv
ZnRfcmRtYSgpIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmkKICAgICAgICAg
ICAgICAgICAgICAgICAgIGRvbmUKICAgICAgICAgKQotICAgICAgIGlmICEgdW5sb2FkX21vZHVs
ZSByZG1hX3J4ZSAxMDsgdGhlbgorICAgICAgIGlmICEgbW9kcHJvYmUgLXIgcmRtYV9yeGU7IHRo
ZW4KICAgICAgICAgICAgICAgICBlY2hvICJVbmxvYWRpbmcgcmRtYV9yeGUgZmFpbGVkIgogICAg
ICAgICAgICAgICAgIHJldHVybiAxCiAgICAgICAgIGZpCkBAIC00NjksNyArNDY5LDcgQEAgc3Rv
cF9zb2Z0X3JkbWEoKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZWNobyAiRmFpbGVkIHRvIHVuYmluZCB0aGUgc2l3IApkcml2ZXIgZnJvbSAke2klX3Npd30iCiAg
ICAgICAgICAgICAgICAgICAgICAgICBkb25lCiAgICAgICAgICkKLSAgICAgICBpZiAhIHVubG9h
ZF9tb2R1bGUgc2l3IDEwOyB0aGVuCisgICAgICAgaWYgISBtb2Rwcm9iZSAtciBzaXc7IHRoZW4K
ICAgICAgICAgICAgICAgICBlY2hvICJVbmxvYWRpbmcgc2l3IGZhaWxlZCIKICAgICAgICAgICAg
ICAgICByZXR1cm4gMQogICAgICAgICBmaQotLQoKSSdtIG5vdCBhdCBhbGwgc3VyZSB3aHkgdGhl
IHJldHJ5IG1lY2hhbmlzbSB0aGF0IHVubG9hZF9tb2R1bGUgZG9lcwppcyBuZWVkZWQgYXQgYWxs
Li4uCgpCYXJ0PwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

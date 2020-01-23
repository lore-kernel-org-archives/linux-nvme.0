Return-Path: <SRS0=16Sh=3M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986ACC2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 18:53:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6945C21569
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 18:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CNl9N3fY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LAf8cl74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6945C21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2Xqp7B17BcjzBhdx+nUnMcqAD2bxqGrJMHqGYftPQXM=; b=CNl9N3fYNuhx+/NsFQLHJF6zQ
	UjQhSpjjd68EMOtgRp3YN1hMaesA2JVKHQkAtMu1kryfjBWFbQSjdNEXGbR6fUwPTbsHPxIS4BuJv
	J+/JZ4Un4XMAHHatH7oIr9aSU+QB1E95KeN+Xvz8Pbyq1xhc7g6qq2oz/nnSOkG0Y6mU6gdUulz3g
	mcO5fFhatP7LkNfDKdIyONg0z926+ki/dXUtLvfkofbFPo6fVCHF3WKJqS7KOzIWAw+ZWe6xgGy+G
	IJMk6hUPwmHzLj2YQQ6GzjwoKA0UUF/nbKNqKEQtXUPEikkbrJdcewxHwiU5inl/9cyQ7h0ZRV8NE
	GGK4lwXxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iuhb7-0000Iq-K5; Thu, 23 Jan 2020 18:52:57 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iuhb4-0000Hq-36
 for linux-nvme@lists.infradead.org; Thu, 23 Jan 2020 18:52:55 +0000
Received: by mail-pf1-x441.google.com with SMTP id x6so1940300pfo.10
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jan 2020 10:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Vl+Mgi2j7xBK7wyO6fUMssevPOdorj/VX3HjO1Fqv+Y=;
 b=LAf8cl74mWhuYMLbhWQM2If11gts2lInrTV4GnCPawE5nvEvhHxCccVtxvrW557edK
 IKsRltsKrr8M0JfEIe7G2Wt2dNKoFv0vkrg9DZe9xNifUEp/Q8lKi5YznKtb1TlE84dI
 tCT/6VCaqyIRHVF11o4gLNURu0VamnzzGQh2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Vl+Mgi2j7xBK7wyO6fUMssevPOdorj/VX3HjO1Fqv+Y=;
 b=Bsp0AUYw8dVu91NHsYNImc0UBAteeugq4Z0qeBXdWbomzy/xLFWHVnznZPh3BNvkqe
 VvccboEBNugB0wLJ4PSPRvTEfB2jVR79A5p90p2qTJpctYoO2yNSF6MW17oWh8VT8Hd/
 D4xJj19WWNudcZyXUGPjeW4DK/0uYQao8xQn7o3CUwIeybiRN3kUbBsAR4OvcKgVHuSb
 gzVTSW2dmu6As8ko7rWLFTMJYR5dGbUX7hB7qMl0FqcKFbq+6is0XQ2embpMzTqov4Hm
 Cn9NoUePhD03YN6d6zlOq3/WZxDJmjJVawRgeM/+U7wY+lc3sgobDLiYXMiux75H+M2h
 jiPA==
X-Gm-Message-State: APjAAAVNFkLcGs9JpPfSJw1t2m0vr8QUvkrBYZgMaMqbM/tn2R9NC1BW
 BxAD+gfoyTgzxBASH64HqTNoXg==
X-Google-Smtp-Source: APXvYqwTsYMoS+YLT21M4zGEJTmKITpSWXuilqIBdJaUIB/E3yBmBTbLkZoCvnry0OMp5zLorBhgiw==
X-Received: by 2002:a63:4f1b:: with SMTP id d27mr229305pgb.102.1579805573007; 
 Thu, 23 Jan 2020 10:52:53 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id p24sm3419761pff.69.2020.01.23.10.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 10:52:52 -0800 (PST)
Subject: Re: [PATCH 07/16] nvme-rdma: Add metadata/T10-PI support
From: James Smart <james.smart@broadcom.com>
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com
References: <20191202144812.147686-1-maxg@mellanox.com>
 <20191202144812.147686-9-maxg@mellanox.com>
 <522e0efe-5907-b28d-ef90-4ceca0fb3103@broadcom.com>
 <07d7772c-7ec5-d29f-ae84-c177321145ae@mellanox.com>
 <095f5943-5a5f-36ca-a8ee-0c8a9a02cc52@broadcom.com>
Message-ID: <f467d8a0-78ac-78c4-f5dd-59031fbfde2f@broadcom.com>
Date: Thu, 23 Jan 2020 10:52:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <095f5943-5a5f-36ca-a8ee-0c8a9a02cc52@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200123_105254_134326_A2762DAB 
X-CRM114-Status: GOOD (  16.76  )
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

CgpPbiAxLzIzLzIwMjAgNzozNCBBTSwgSmFtZXMgU21hcnQgd3JvdGU6Cj4KPgo+IE9uIDEvMjMv
MjAyMCAxOjU5IEFNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4+Cj4+IE9uIDEvMjIvMjAyMCAxMTo1
NyBQTSwgSmFtZXMgU21hcnQgd3JvdGU6Cj4+PiBPbiBhIHBlci1pbyBiYXNpcywgdGhlcmUgbmVl
ZHMgdG8gYmUgc3BlY2lmaWMgZGVzY3JpcHRpb25zIG9mIHRoZSAKPj4+IERJRiBpbmZvcm1hdGlv
biB0byBwcm9ncmFtIHRoZSBwb3J0IGhhcmR3YXJlLsKgIFRoaW5ncyBzdWNoIGFzIGJsb2NrIAo+
Pj4gc2l6ZSwgdHlwZSwgYW5kIHNvLiBJIHNlZSB0aGlzIHJvdXRpbmUgdXNpbmcgYSBtaXggb2Yg
dGhlIGJpbyB0aGF0IAo+Pj4gaXMgYXNzb2NpYXRlZCB3aXRoIHRoZSBvcmlnaW5hbCByZXF1ZXN0
IGFzIHdlbGwgYXMgdGhlIG5hbWVzcGFjZSAKPj4+IHBvaW50ZXIgdG8gZ2V0IHRoaXMgaW5mby4g
wqDCoCBUbyBtZSB0aGUgcmVhY2hpbmcgaW50byB0aGUgYmlvLCBhcyAKPj4+IHdlbGwgYXMgdGhl
IGxvY2F0aW5nIG9mIHRoZSBucyBzdHJ1Y3R1cmVzIGFyZSByZWFjaGluZyBpbnRvIHRoZSAKPj4+
IG90aGVyIGxheWVycyB0b28gbXVjaC4KPj4+Cj4+PiBXb3VsZG4ndCB3ZSBiZSBiZXR0ZXIgb2Zm
IHdpdGggd2l0aCB0aGUgY29yZSBsYXllciBkb2luZyBhbGwgdGhlIAo+Pj4gcmVhY2hpbmcgYW5k
IHNldHRpbmcgdXAgYSBwaSBzdHJ1Y3R1cmUgaW4gdGhlIG52bWVfcmVxdWVzdCB3aXRoIHRoaXMg
Cj4+PiBpbmZvcm1hdGlvbiA/wqDCoCByZXBsYWNlIGhhc19waSB3aXRoIHRoaXMgcGkgc3RydWN0
IGFuZCAKPj4+ICJudm1lX3JlcShycSktPnBpLnBpX3R5cGUgPT0gMCIgaXMgZXF1aXZhbGVudCB0
byBoYXNfcGkgPyBJZiB3ZSAKPj4+IGRpZG4ndCB3YW50IHRvIHJlcGxpY2F0ZSB0aGUgUEkgaW5m
bywgdGhlbiBudm1lX3JlcXVlc3QgY2FuIHNpbXBseSAKPj4+IGFkZCBhIHBvaW50ZXIgdG8gdGhl
IG5zLCBhbmQgdGhlIG5zIGNhbiBiZSBsb29rZWQgYXQgZXhwbGljaXRseSB0byAKPj4+IGdhdGhl
ciB0aGUgYXR0cmlidXRlcy4KPj4+Cj4+PiBUaG91Z2h0cyA/Cj4+Pgo+PiBOVk1lIG5hbWVzcGFj
ZSBpcyB1c2VkIGJ5IFJETUEvVENQL0ZDIHRyYW5zcG9ydCBkcml2ZXJzIGluIGVhY2ggCj4+IHF1
ZXVlX3JxIGltcGxlbWVudGF0aW9uLiBXZSBjYW4gcGFzcyBpdCBpbnN0ZWFkIG9mIHJlYWNoaW5n
IGl0IGZyb20gCj4+IHRoZSBycSwgaWYgdGhpcyBsb29rcyBiZXR0ZXIuCj4KPiA/PyB0aGVyZSBo
YXNuJ3QgYmVlbiBhbnkgcmVhc29uIHRvIGxvb2sgYXQgdGhlIG5hbWVzcGFjZSBieSB0aGUgCj4g
dHJhbnNwb3J0cyB0byBkYXRlLgo+Cj4gQnV0IHllcywgSSBtdWNoIHByZWZlciBwYXNzaW5nIHRo
ZSBucyBhbmQgdXNpbmcgaXQgZm9yIHRoZSBkaWYgaW5mby7CoCAKPiBUaGlzIHJlbW92ZXMgd2hh
dCBJIGRpZG4ndCBsaWtlIC0gZW5jb2RpbmcgdGhlIHJlbGF0aW9uc2hpcCBvZiBob3cgdG8gCj4g
Z2V0IGZyb20gdGhlIHJxIHRvIG5zIGluIGVhY2ggdHJhbnNwb3J0Lgo+CgphbHNvIG1lYW5zIHRo
ZSBiaW8gaXNuJ3QgbmVjZXNzYXJ5IGluIG1vc3Qgb2YgdGhlIG90aGVyIHJvdXRpbmVzIHVudGls
IAp5b3UgY2FsbCBibGtfcnFfY291bnRfaW50ZWdyaXR5X3NnKCkuwqAgYmxrc3ogY2FuIGNvbWUg
ZnJvbSAoMSA8PCAKbnMtPmxiYV9zaGlmdCkKCi0tIGphbWVzCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

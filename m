Return-Path: <SRS0=0nye=6Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33338C47255
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2020 23:50:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7E72070B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2020 23:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gsy428Jo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d7c3JAWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7E72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f0p5QgtCPTM1HKfjPQ8eeI2zddSo4wpb7VzNOZCm5hQ=; b=Gsy428JonqiBXx7UIT5PRFYMg
	+13gIx7Ww8R1EV3GXY8Y6jhyNOqF5OiTJDMjOzOfYVUixnATxnMG4IqeFggxCVHi7fq+WqUHbxIc9
	KT1S3dbfDz3baJvQkMuZ4xzFm2cplGB/HJz4RhMMGLc+deAczjG0Uk3LFh7HJDirltSZYZXHnTWef
	07VLFCcD3C3KtifkCJDjaYAJPVtSMbKTXwWCfujA61RFpXxnvAoNlsQh8HPDKxWU7BmT9ZRUUF/Tq
	qUfNCb8L0DsRM7YVswmheTX8W2nUnimuUAWwbcJZk0DtFoAAggmlvlhnN8pja5LtuPwQv/nrEEyId
	wH7bG/GHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYIBh-00082W-2f; Mon, 11 May 2020 23:50:21 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYIBd-00082B-KR
 for linux-nvme@lists.infradead.org; Mon, 11 May 2020 23:50:19 +0000
Received: by mail-wr1-x444.google.com with SMTP id x17so13146336wrt.5
 for <linux-nvme@lists.infradead.org>; Mon, 11 May 2020 16:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=helNngrhqVpI2EXfi1Sz4Y9niXnhFln1FptnUrgVDsk=;
 b=d7c3JAWhs5iuO7hqkiPeV5iCmIgiPFbR01nS6qJDM4VGnFzcoZ22Nt9FHF1OBstrMg
 Aw16EprCFaVxfFgB1bumnc3KHQYUHh27oD7WrbiDCdiaO7i6WUvUAp/oMI2m0+BEXX1b
 PprIgOWO1AeM/BQU8HJQDfueKoSO64kHsTKuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=helNngrhqVpI2EXfi1Sz4Y9niXnhFln1FptnUrgVDsk=;
 b=sWkMEBm9UuFZORQvfjtSSdM/ZLvzeWnL8LKOjHLayH4DHAMtUXny+ntDlNwYPvMKGt
 XbHnT+cZK/nsOTyQki/saizjxteZlupr/HEwRz9BOmDCJuco+vtJCc8eed3MWoAw6Xvt
 lXf0e9pSUz3d9Xr9cnRkZG8p5X7IkcaUAL7irsTlQwI78EextYX8fs0FMcnrfBcB2T59
 ZzRu41oHgP2Fw0ng1wehzW0VVKh/JARcYQbddD3nZ5fqQZw8/SyvI8E+zSocDAfpMdn0
 WuRCVlSg6uZcmBeU6Y6y+It+gAoZWiE+5drZVgvP94biqqi31DAfy5Y2QDdgaRIAh496
 fnFw==
X-Gm-Message-State: AGi0PubC83VO6bjfdPYJxzoTKfnLcyNyFeHnV8sd1hoEb8DfReFRBxY6
 K3/fbbGHMlAtEAlX83zpfzwuIA==
X-Google-Smtp-Source: APiQypK9ZCY+VvW2eHij+biZQ45UQx2mQe9v0kjAsVPET/Zf8w8HwyF17G1NzviVDTLx3xXHVGodcw==
X-Received: by 2002:a05:6000:1083:: with SMTP id
 y3mr11031050wrw.425.1589241015601; 
 Mon, 11 May 2020 16:50:15 -0700 (PDT)
Received: from [10.230.128.89] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id 5sm28630712wmz.16.2020.05.11.16.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 16:50:14 -0700 (PDT)
Subject: Re: [PATCH 03/16] nvme: introduce NVME_NS_METADATA_SUPPORTED flag
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-4-maxg@mellanox.com>
 <e21354ca-a7bb-cf2d-d427-c8410c797a49@broadcom.com>
 <71c7458e-81cd-7200-2e1b-3563cdddd5ad@mellanox.com>
 <62322680-afeb-142e-c10b-b4f2d4c419a3@broadcom.com>
 <1b03c314-2e57-5135-6875-a2d37ecf5e20@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <cca0ab45-7dde-c461-b20f-d44f58a8a117@broadcom.com>
Date: Mon, 11 May 2020 16:50:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1b03c314-2e57-5135-6875-a2d37ecf5e20@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200511_165017_672590_82565B05 
X-CRM114-Status: GOOD (  16.66  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA1LzcvMjAyMCAyOjAyIEFNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4KPiBPbiA1LzYvMjAy
MCAxMTo0NCBQTSwgSmFtZXMgU21hcnQgd3JvdGU6Cj4+Cj4+IExldCBtZSByZXdvcmQgdGhpcyBz
bmlwcGV0IHdpdGggd2hhdCB0aGUgZmxhZyByZWFsbHkgbWVhbnM6Cj4+Cj4+IGlmIChJU19FTkFC
TEVEKENPTkZJR19CTEtfREVWX0lOVEVHUklUWSkgJiYgKG5zLT5jdHJsLT5vcHMtPmZsYWdzICYg
Cj4+IE5WTUVfRl9NRVRBREFUQV9TVVBQT1JURUQpICYmICEobnMtPmZlYXR1cmVzICYgTlZNRV9O
U19FWFRfTEJBUykpCj4+IMKgIG52bWVfaW5pdF9pbnRlZ3JpdHkoLi4uLMKgIG5zLT5waV90eXBl
KQo+PiBlbHNlIGlmICghbnZtZV9uc19oYXNfcGkobnMpKQo+PiDCoMKgIGNhcGFjaXR5PTAuCj4+
Cj4+IFRoaXMgbGVhdmVzIHRoZSBjYXNlcyB3aGVyZSBjYXBhY2l0eSBpcyBub3QgemVybydkLCB0
aHVzIHRoZXJlIG1heSBiZSAKPj4gaW8gYXR0ZW1wdGVkIHRvIHRoZSBuczoKPj4gYSBrZXJuZWwg
dy9vIENPTkZJR19CTEtfREVWX0lOVEVHUklUWSBlbmFibGVkLCBhbmQgdGhlIG5zIHdhcyAKPj4g
Zm9ybWF0dGVkIGZvciBwaS4KPgo+IENvbnRyb2xsZXIgd2lsbCBnZW5lcmF0ZSBpdC4KCk9rIC0g
U28gd2hhdCB5b3UgbWVhbnQgd2FzOiBvdGhlciBjb2RlIHdpbGwgbG9vayBmb3IgdGhlIGludGVn
cml0eSBycSwgCmFuZCBpZiBub3Qgc2V0IHdpbGwgc2V0IFBSQUNUIHRvIGhhdmUgY29udHJvbGxl
ciBnZW5lcmF0ZSBpdC4KCkFncmVlLsKgIEkgd2FzIHRoaW5raW5nIHRoYXQgaXQgd291bGQgYmUg
YmV0dGVyIHRvIHZhbGlkYXRlIHdoYXQgd2FzIApnb2luZyB0byBoYXBwZW4gYXQgdGhpcyBwb2lu
dCwgYnV0IHlvdSBhcmUgY29ycmVjdC4KCj4KPgo+PiBhIGtlcm5lbCB3LyBDT05GSUdfQkxLX0RF
Vl9JTlRFR1JJVFksIHRoZSBucyB3YXMgZm9ybWF0dGVkIGZvciBwaSwgCj4+IGJ1dCB0aGUgdHJh
bnNwb3J0IGhhcyBubyBpZGVhIGFib3V0IGEgc2VwYXJhdGUgYnVmZmVyLgo+Cj4gSWYgdGhlIHRy
YW5zcG9ydCBzdXBwb3J0cyBNRVRBREFUQSwgaXQgbXVzdCBoYXZlIGFuIGlkZWEgYWJvdXQgCj4g
c2VwYXJhdGUgYW5kIG5vbi1zZXBhcmF0ZSBtb2Rlcy4KCkFncmVlIC0gaWYgdHJhbnNwb3J0IGRv
ZXNuJ3Qgc2V0IGl0cyBvcHMgZmxhZywgdGhlbiB0aGUgbmV3IGZsYWcgd2lsbCAKbmV2ZXIgYmUg
c2V0LCB0aHVzIGl0IHdpbGwgbm90IGhhdmUgYSBibGsgaW50ZWdyaXR5IHJxIHN0cnVjdCwgc28g
aXQnbGwgCmZhbGwgaW50byBQUkFDVD4KCj4KPgo+PiBhIGtlcm5lbCB3LyBDT05GSUdfQkxLX0RF
Vl9JTlRFR1JJVFksIHRoZSBucyB3YXMgZm9ybWF0dGVkIGZvciBwaSwgCj4+IHRoZSB0cmFuc3Bv
cnQga25vd3MgaG93IHRvIDIgZG8gYnVmZmVycywgYnV0IHRoZSBjb250cm9sbGVyIHJlcXVpcmVz
IAo+PiBleHRlbmRlZCBMQkFTLgo+Cj4gSW4gdGhpcyBwb2ludCBvZiB0aW1lIChwYXRjaCAzLzE2
KSBvbmx5IFBDSSB0cmFuc3BvcnQgc3VwcG9ydHMgdGhlIAo+IG1ldGFkYXRhIGZlYXR1cmUgYW5k
IGl0IGNhbid0IGNvbnZlcnQgZnJvbSAyIGJ1ZmZlcnMgdG8gZXh0ZW5kZWQgbW9kZS4KPgo+IFNv
IGluIGNhc2UgeW91IGdldCBhIHdyaXRlL3JlYWQgY29tbWFuZCBmcm9tIGJsb2NrIGxheWVyICh3
aXRob3V0IAo+IG1ldGFkYXRhIG9mIGNvdXJzZSksIHRoZSBjb3JlIGxheWVyIHdpbGwgc2VlIHRo
YXQgdGhlIG5zICJoYXMgcGkiIGFuZCAKPiB3aWxsIHNldCB0aGUgUFJBQ1QgYml0IHNvIHRoYXQg
dGhlIFNTRCBjb250cm9sbGVyIHdpbGwgZ2VuZXJhdGUvc3RyaXAgCj4gdGhlIG1ldGFkYXRhLgoK
QWdyZWUuCgpMZXRzIG1vdmUgb24uIEkndmUgYmVlbiBhIGxpdHRsZSBzaG9ydCBvZiB0aW1lLiBJ
IHNob3VsZCByZXZpZXcgdGhlIAptZWF0aWVyIHBhdGNoLCBwYXRjaCA2LCB0b21vcnJvdyBzb21l
dGltZS4KCnNvLi4uClJldmlld2VkLWJ5OsKgIEphbWVzIFNtYXJ0IDxqYW1lcy5zbWFydEBicm9h
ZGNvbS5jb20+CgoKLS0gamFtZXMKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK

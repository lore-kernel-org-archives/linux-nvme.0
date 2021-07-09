Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC2C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 11:12:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74402613E1
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 11:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74402613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tE5eGSHgHuvbW57ZiAXnCKxO2gQpKoJDP+T/xtyVTuU=; b=uruU2FLdg+6jIv028WmBdCLlxV
	ykJDlDIC3dDuKuL367yswxtyjkevY36/H1vWG1FXcfpsoqwHx/ugi24vKEFCDI+nOnSnRAtz9kjkk
	7NPTaxUtHFDtzaY07BaQHe1FJDv84yEIUMhLbGkFfORXwMVtzjzZHbYnTMYxUOjaxBOWnRmOY5+Mx
	S3I9LQRvU0gukrpwiT6iTHcIirTDXy3jii0I5YK0fNcBhIXCBMV9+g++7JiseHv7AesNhqVQIEgtE
	AD65G9P/9YIQ9hKm+GQoPxZVcdHUZnYbioVUIWK4+mT8xC6UVGEI5XU2c8fbK07r0kMf2EzeP8aUq
	o9oCudvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1oQT-001dK0-BV; Fri, 09 Jul 2021 11:12:09 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1oQG-001dIA-Bq; Fri, 09 Jul 2021 11:11:58 +0000
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GLqyn74LDz6J6X3;
 Fri,  9 Jul 2021 19:03:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 13:11:44 +0200
Received: from [10.47.93.40] (10.47.93.40) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 9 Jul 2021
 12:11:43 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Robin Murphy <robin.murphy@arm.com>, Ming Lei <ming.lei@redhat.com>,
 <linux-nvme@lists.infradead.org>, Will Deacon <will@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <a44e8a68-d789-e3db-4fbb-404defb431f6@huawei.com>
Date: Fri, 9 Jul 2021 12:04:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.93.40]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_041156_743992_172AF3B4 
X-CRM114-Status: GOOD (  16.80  )
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

T24gMDkvMDcvMjAyMSAxMToyNiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IG4gMjAyMS0wNy0wOSAw
OTozOCwgTWluZyBMZWkgd3JvdGU6Cj4+IEhlbGxvLAo+Pgo+PiBJIG9ic2VydmVkIHRoYXQgTlZN
ZSBwZXJmb3JtYW5jZSBpcyB2ZXJ5IGJhZCB3aGVuIHJ1bm5pbmcgZmlvIG9uIG9uZQo+PiBDUFUo
YWFyY2g2NCkgaW4gcmVtb3RlIG51bWEgbm9kZSBjb21wYXJlZCB3aXRoIHRoZSBudm1lIHBjaSBu
dW1hIG5vZGUuCj4+Cj4+IFBsZWFzZSBzZWUgdGhlIHRlc3QgcmVzdWx0WzFdIDMyN0sgdnMuIDM0
LjlLLgo+Pgo+PiBMYXRlbmN5IHRyYWNlIHNob3dzIHRoYXQgb25lIGJpZyBkaWZmZXJlbmNlIGlz
IGluIGlvbW11X2RtYV91bm1hcF9zZygpLAo+PiAxMTExIG5zZWNzIHZzIDI1NDM3IG5zZWNzLgo+
IAo+IEFyZSB5b3UgYWJsZSB0byBkaWcgZG93biBmdXJ0aGVyIGludG8gdGhhdD8gaW9tbXVfZG1h
X3VubWFwX3NnKCkgaXRzZWxmIAo+IGRvZXNuJ3QgZG8gYW55dGhpbmcgcGFydGljdWxhcmx5IHNw
ZWNpYWwsIHNvIHdoYXRldmVyIG1ha2VzIGEgZGlmZmVyZW5jZSAKPiBpcyBwcm9iYWJseSBoYXBw
ZW5pbmcgYXQgYSBsb3dlciBsZXZlbCwgYW5kIEkgc3VzcGVjdCB0aGVyZSdzIHByb2JhYmx5IAo+
IGFuIFNNTVUgaW52b2x2ZWQuIElmIGZvciBpbnN0YW5jZSBpdCB0dXJucyBvdXQgdG8gZ28gYWxs
IHRoZSB3YXkgZG93biB0byAKPiBfX2FybV9zbW11X2NtZHFfcG9sbF91bnRpbF9jb25zdW1lZCgp
IGJlY2F1c2UgcG9sbGluZyBNTUlPIGZyb20gdGhlIAo+IHdyb25nIG5vZGUgaXMgc2xvdywgdGhl
cmUncyB1bmxpa2VseSB0byBiZSBtdWNoIHlvdSBjYW4gZG8gYWJvdXQgdGhhdCAKPiBvdGhlciB0
aGFuIHRoZSBnbG9iYWwgImdvIGZhc3RlciIga25vYnMgKGlvbW11LnN0cmljdCBhbmQgCj4gaW9t
bXUucGFzc3Rocm91Z2gpIHdpdGggdGhlaXIgYXNzb2NpYXRlZCBjb21wcm9taXNlcy4KClRoZXJl
IHdhcyBhbHNvIHRoZSBkaXNhYmxlX21zaXBvbGxpbmcgb3B0aW9uOgoKaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUv
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyNuNDIKCkJ1dCBJIGFt
IG5vdCBzdXJlIGlmIHRoYXQgcGxhdGZvcm0gZXZlbiBzdXBwb3J0cyBNU0kgcG9sbGluZyAob3Ig
aGFzIApzbW11IHYzKS4KCllvdSBjb3VsZCBhbHNvIHRyeSBpb21tdS5mb3JjZWRhYz0xIGNtZGxp
bmUgb3B0aW9uLiBCdXQgSSBkb3VidCBpdCB3aWxsIApoZWxwIHNpbmNlIHRoZSBpc3N1ZSB3YXMg
bWVudGlvbmVkIHRvIGJlIE5VTUEgcmVsYXRlZC4KCj4gCj4gUm9iaW4uCj4gCj4+IFsxXSBmaW8g
dGVzdCAmIHJlc3VsdHMKPj4KPj4gMSkgZmlvIHRlc3QgcmVzdWx0Ogo+Pgo+PiAtIHJ1biBmaW8g
b24gbG9jYWwgQ1BVCj4+IHRhc2tzZXQgLWMgMCB+L2dpdC90b29scy90ZXN0L252bWUvaW9fdXJp
bmcgMTAgMSAvZGV2L252bWUxbjEgNGsKPj4gKyBmaW8gLS1icz00ayAtLWlvZW5naW5lPWlvX3Vy
aW5nIC0tZml4ZWRidWZzIC0tcmVnaXN0ZXJmaWxlcyAtLWhpcHJpIAo+PiAtLWlvZGVwdGg9NjQg
LS1pb2RlcHRoX2JhdGNoX3N1Ym1pdD0xNiAtLWlvZGVwdGhfYmF0Y2hfY29tcGxldGVfbWluPTE2
IAo+PiAtLWZpbGVuYW1lPS9kZXYvbnZtZTFuMSAtLWRpcmVjdD0xIC0tcnVudGltZT0xMCAtLW51
bWpvYnM9MSAKPj4gLS1ydz1yYW5kcmVhZCAtLW5hbWU9dGVzdCAtLWdyb3VwX3JlcG9ydGluZwo+
Pgo+PiBJT1BTOiAzMjdLCj4+IGF2ZyBsYXRlbmN5IG9mIGlvbW11X2RtYV91bm1hcF9zZygpOiAx
MTExIG5zZWNzCj4+Cj4+Cj4+IC0gcnVuIGZpbyBvbiByZW1vdGUgQ1BVCj4+IHRhc2tzZXQgLWMg
ODAgfi9naXQvdG9vbHMvdGVzdC9udm1lL2lvX3VyaW5nIDEwIDEgL2Rldi9udm1lMW4xIDRrCj4+
ICsgZmlvIC0tYnM9NGsgLS1pb2VuZ2luZT1pb191cmluZyAtLWZpeGVkYnVmcyAtLXJlZ2lzdGVy
ZmlsZXMgLS1oaXByaSAKPj4gLS1pb2RlcHRoPTY0IC0taW9kZXB0aF9iYXRjaF9zdWJtaXQ9MTYg
LS1pb2RlcHRoX2JhdGNoX2NvbXBsZXRlX21pbj0xNiAKPj4gLS1maWxlbmFtZT0vZGV2L252bWUx
bjEgLS1kaXJlY3Q9MSAtLXJ1bnRpbWU9MTAgLS1udW1qb2JzPTEgCj4+IC0tcnc9cmFuZHJlYWQg
LS1uYW1lPXRlc3QgLS1ncm91cF9yZXBvcnRpbmcKPj4KPj4gSU9QUzogMzQuOUsKPj4gYXZnIGxh
dGVuY3kgb2YgaW9tbXVfZG1hX3VubWFwX3NnKCk6IDI1NDM3IG5zZWNzCj4+Cj4+IDIpIHN5c3Rl
bSBpbmZvCj4+IFtyb290QGFtcGVyZS1tdGphZGUtMDQgfl0jIGxzY3B1IHwgZ3JlcCBOVU1BCj4+
IE5VTUEgbm9kZShzKTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyCj4+
IE5VTUEgbm9kZTAgQ1BVKHMpOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMC03OQo+PiBO
VU1BIG5vZGUxIENQVShzKTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDgwLTE1OQo+Pgo+
PiBsc3BjaSB8IGdyZXAgTlZNZQo+PiAwMDAzOjAxOjAwLjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBj
b250cm9sbGVyOiBTYW1zdW5nIEVsZWN0cm9uaWNzIENvIAo+PiBMdGQgTlZNZSBTU0QgQ29udHJv
bGxlciBTTTk4MS9QTTk4MS9QTTk4Mwo+Pgo+PiBbcm9vdEBhbXBlcmUtbXRqYWRlLTA0IH5dIyBj
YXQgL3N5cy9ibG9jay9udm1lMW4xL2RldmljZS9kZXZpY2UvbnVtYV9ub2RlIAoKU2luY2UgaXQn
cyBhbXBlcmUsIEkgZ3Vlc3MgaXQncyBzbW11IHYzLgoKQlRXLCBpZiB5b3UgcmVtZW1iZXIsIEkg
ZGlkIHJhaXNlIGEgcGVyZm9ybWFuY2UgaXNzdWUgb2Ygc21tdXYzIHdpdGggCk5WTWUgYmVmb3Jl
OgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS9iMmE2ZTI2ZC02ZDBkLTdmMGQt
ZjIyMi01ODk4MTJmNzAxZDJAaHVhd2VpLmNvbS8KCkkgZGlkIGhhdmUgdGhpcyBzZXJpZXMgdG8g
aW1wcm92ZSBwZXJmb3JtYW5jZSBmb3Igc3lzdGVtcyB3aXRoIGxvdHMgb2YgCkNQVXMsIGxpa2Ug
YWJvdmUsIGJ1dCBub3QgYWNjZXB0ZWQ6Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlv
bW11LzE1OTgwMTgwNjItMTc1NjA4LTEtZ2l0LXNlbmQtZW1haWwtam9obi5nYXJyeUBodWF3ZWku
Y29tLwoKVGhhbmtzLApKb2huCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=

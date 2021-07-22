Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4B8C6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 17:40:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472BA611C1
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 17:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472BA611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zj9EPfw9HxS+wg6+xbrNUkfHikcE1TZFa5ZLcCFnuSA=; b=G38cK1NSSDJc0c7t+3cT+MJIyj
	4ryYY7G7FcNuBkULfl/wULxc9Knt0YyaMHTwqAQTXtv6AhHtvUK6X5tPq/KgwziKwptQ95ftAxsl5
	cdiJ4AdjS8t5/m4yYWuYqdkJeVTlgL78alfy4BJocOMAEHadxAsx8nhyi29iPekoLHH+2UkdA8ESs
	RgXOHn83lhwgZolCdjp48yqmx23hyrZnG9bGvTEn9U3nfOgIrfPm+ysMSZZhqjpIDEwNQuA/F4lN8
	vjzijq/HZwctBCBhAOxIoyM+hCy+Nehih12PCbIW0QR2pw4ziuAM2jZ6l6NWoPSwb0HjSZW6oAmqH
	gDflVFcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6cga-002KYF-NT; Thu, 22 Jul 2021 17:40:40 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6cgN-002KWt-1t; Thu, 22 Jul 2021 17:40:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42693106F;
 Thu, 22 Jul 2021 10:40:24 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 120373F694;
 Thu, 22 Jul 2021 10:40:22 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com> <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
Date: Thu, 22 Jul 2021 18:40:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPmUoBk9u+tU2rbS@T590>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_104027_188007_DD8C874C 
X-CRM114-Status: GOOD (  17.17  )
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

T24gMjAyMS0wNy0yMiAxNjo1NCwgTWluZyBMZWkgd3JvdGU6ClsuLi5dCj4+IElmIHlvdSBhcmUg
c3RpbGwga2VlbiB0byBpbnZlc3RpZ2F0ZSBtb3JlLCB0aGVuIGNhbiB0cnkgZWl0aGVyIG9mIHRo
ZXNlOgo+Pgo+PiAtIGFkZCBpb21tdS5zdHJpY3Q9MCB0byB0aGUgY21kbGluZQo+Pgo+PiAtIHVz
ZSBwZXJmIHJlY29yZCthbm5vdGF0ZSB0byBmaW5kIHRoZSBob3RzcG90Cj4+ICAgIC0gRm9yIHRo
aXMgeW91IG5lZWQgdG8gZW5hYmxlIHBzdWVkby1OTUkgd2l0aCAyeCBzdGVwczoKPj4gICAgICBD
T05GSUdfQVJNNjRfUFNFVURPX05NST15IGluIGRlZmNvbmZpZwo+PiAgICAgIEFkZCBpcnFjaGlw
LmdpY3YzX3BzZXVkb19ubWk9MQo+Pgo+PiAgICAgIFNlZSBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9hcmNoL2Fy
bTY0L0tjb25maWcjbjE3NDUKPj4gICAgICBZb3VyIGtlcm5lbCBsb2cgc2hvdWxkIHNob3c6Cj4+
ICAgICAgWyAgICAwLjAwMDAwMF0gR0lDdjM6IFBzZXVkby1OTUlzIGVuYWJsZWQgdXNpbmcgZm9y
Y2VkIElDQ19QTVJfRUwxCj4+IHN5bmNocm9uaXNhdGlvbgo+IAo+IE9LLCB3aWxsIHRyeSB0aGUg
YWJvdmUgdG9tb3Jyb3cuCgpUaGFua3MsIEkgd2FzIGFsc28gZ29pbmcgdG8gc3VnZ2VzdCB0aGUg
bGF0dGVyLCBzaW5jZSBpdCdzIHdoYXQgCmFybV9zbW11X2NtZHFfaXNzdWVfY21kbGlzdCgpIGRv
ZXMgd2l0aCBJUlFzIG1hc2tlZCB0aGF0IHNob3VsZCBiZSBtb3N0IAppbmRpY2F0aXZlIG9mIHdo
ZXJlIHRoZSBzbG93bmVzcyBtb3N0IGxpa2VseSBzdGVtcyBmcm9tLgoKRldJVyBJIHdvdWxkIGV4
cGVjdCBpb21tdS5zdHJpY3Q9MCB0byBnaXZlIGEgcHJvcG9ydGlvbmFsIHJlZHVjdGlvbiBpbiAK
U01NVSBvdmVyaGVhZCBmb3IgYm90aCBjYXNlcyBzaW5jZSBpdCBzaG91bGQgZWZmZWN0aXZlbHkg
bWVhbiBvbmx5IDEvMjU2IAphcyBtYW55IGludmFsaWRhdGlvbnMgYXJlIGlzc3VlZC4KCkNvdWxk
IHlvdSBhbHNvIGNoZWNrIHdoZXRoZXIgdGhlIFNNTVUgcGxhdGZvcm0gZGV2aWNlcyBoYXZlICJu
dW1hX25vZGUiIApwcm9wZXJ0aWVzIGV4cG9zZWQgaW4gc3lzZnMgKGFuZCBpZiBzbyB3aGV0aGVy
IHRoZSB2YWx1ZXMgbG9vayByaWdodCksIAphbmQgc2hhcmUgYWxsIHRoZSBTTU1VIG91dHB1dCBm
cm9tIHRoZSBib290IGxvZz8KCkkgc3RpbGwgc3VzcGVjdCB0aGF0IHRoZSBtb3N0IHNpZ25pZmlj
YW50IGJvdHRsZW5lY2sgaXMgbGlrZWx5IHRvIGJlIApNTUlPIGFjY2VzcyBhY3Jvc3MgY2hpcHMs
IGluY3VycmluZyB0aGUgQ01ML0NDSVggbGF0ZW5jeSB0d2ljZSBmb3IgZXZlcnkgCnNpbmdsZSBy
ZWFkLCBidXQgaXQncyBhbHNvIHBvc3NpYmxlIHRoYXQgdGhlIHBlcmZvcm1hbmNlIG9mIHRoZSBT
TU1VIAppdHNlbGYgY291bGQgYmUgcmVkdWNlZCBpZiBpdHMgTlVNQSBhZmZpbml0eSBpcyBub3Qg
ZGVzY3JpYmVkIGFuZCB3ZSBlbmQgCnVwIGFsbG9jYXRpbmcgc3R1ZmYgbGlrZSBwYWdldGFibGVz
IG9uIHRoZSB3cm9uZyBub2RlIGFzIHdlbGwuCgo+PiBCdXQgbXkgaW1wcmVzc2lvbiBpcyB0aGF0
IHRoaXMgbWF5IGJlIGEgSFcgaW1wbGVtZW50YXRpb24gaXNzdWUsIGNvbnNpZGVyaW5nCj4+IHdl
IGRvbid0IHNlZSBzdWNoIGEgaHVnZSBkcm9wIG9mZiBvbiBvdXIgSFcuCj4gCj4gRXhjZXB0IGZv
ciBtcGVyZS1tdGphZGUsIHdlIHNhdyBiYWQgbnZtZSBwZXJmb3JtYW5jZSBvbiBUaHVuZGVyWDLC
riBDTjk5WFggdG9vLAo+IGJ1dCBJIGRvbid0IGdldCBvbmUgQ045OVhYIHN5c3RlbSB0byBjaGVj
ayBpZiB0aGUgaXNzdWUgaXMgc2FtZSB3aXRoCj4gdGhpcyBvbmUuCgpJIGtub3cgQ2F2aXVtJ3Mg
U01NVSBpbXBsZW1lbnRhdGlvbiBkaWRuJ3Qgc3VwcG9ydCBNU0lzLCBzbyB0aGF0IGNhc2UgCndv
dWxkIHF1aXRlIHBvc3NpYmx5IGxlYW4gdG93YXJkcyB0aGUgTU1JTyBwb2xsaW5nIGFuZ2xlIGFz
IHdlbGwgKGFsYmVpdCAKd2l0aCBhIHZlcnkgZGlmZmVyZW50IGludGVyY29ubmVjdCkuCgpSb2Jp
bi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

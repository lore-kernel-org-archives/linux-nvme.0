Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15882C4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:46:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AD623A79
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AD623A79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KorpHJHoWNhDOSfkH7MyQEj4WG86jHChEChizoJaFuQ=; b=rXCdBHr/eTjERjjKJL1JjAcgp
	YlreVzRypx7VBF0bbFL2d/tGv5dqPiQU28dp9Z8/zwXJajCFUS+XFMz9Dy5w1vn8r62rlzhviuhAK
	JIfpkjJd7UwuvhYL9ytvRVm2MkuLP+LM0MRwBIezNj2pJcfCgemSqYKo66FFHI39zuaYRd7lGSnUf
	rmBs9fUk4gMsqbAes4SH7Lt/2HksR9tvCbMLKu4lcBCM/M3GCwF/brHFx02RKYzbTh4NEvXWujcVE
	BdLAJSkZnwJNcnQNA03HLfKOaMd2/W+IPr21PNv4Gl93ev4LcB8my2F8VWpa3PQ4D9uskqgbSJT/k
	xmotPAIzw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmg7k-0006AF-0I; Tue, 08 Dec 2020 16:46:00 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmg7g-00068m-MW
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 16:45:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 95A7CAD21;
 Tue,  8 Dec 2020 16:45:53 +0000 (UTC)
Subject: Re: [PATCH 2/6] block: remove the NULL bdev check in bdev_read_only
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201208162829.2424563-1-hch@lst.de>
 <20201208162829.2424563-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5adf02c7-9f53-4162-2655-8063c118ce8f@suse.de>
Date: Tue, 8 Dec 2020 17:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208162829.2424563-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_114557_194459_9BC35F64 
X-CRM114-Status: GOOD (  22.54  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvOC8yMCA1OjI4IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbmx5IGEgc2lu
Z2xlIGNhbGxlciBjYW4gZW5kIHVwIGluIGJkZXZfcmVhZF9vbmx5LCBzbyBtb3ZlIHRoZSBjaGVj
awo+IHRoZXJlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPgo+IFJldmlld2VkLWJ5OiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4KPiBSZXZp
ZXdlZC1ieTogTWFydGluIEsuIFBldGVyc2VuIDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4K
PiAtLS0KPiAgIGJsb2NrL2dlbmhkLmMgfCAzIC0tLQo+ICAgZnMvc3VwZXIuYyAgICB8IDMgKyst
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvYmxvY2svZ2VuaGQuYyBiL2Jsb2NrL2dlbmhkLmMKPiBpbmRleCBiODRi
ODY3MWU2MjcwYS4uOGYyYjg5ZDExNjE4MTMgMTAwNjQ0Cj4gLS0tIGEvYmxvY2svZ2VuaGQuYwo+
ICsrKyBiL2Jsb2NrL2dlbmhkLmMKPiBAQCAtMTY1MiwxMSArMTY1Miw4IEBAIEVYUE9SVF9TWU1C
T0woc2V0X2Rpc2tfcm8pOwo+ICAgCj4gICBpbnQgYmRldl9yZWFkX29ubHkoc3RydWN0IGJsb2Nr
X2RldmljZSAqYmRldikKPiAgIHsKPiAtCWlmICghYmRldikKPiAtCQlyZXR1cm4gMDsKPiAgIAly
ZXR1cm4gYmRldi0+YmRfcmVhZF9vbmx5Owo+ICAgfQo+IC0KPiAgIEVYUE9SVF9TWU1CT0woYmRl
dl9yZWFkX29ubHkpOwo+ICAgCj4gICAvKgo+IGRpZmYgLS1naXQgYS9mcy9zdXBlci5jIGIvZnMv
c3VwZXIuYwo+IGluZGV4IDJjNmNkZWEyYWIyZDllLi41YTFmMzg0ZmZjNzRmNiAxMDA2NDQKPiAt
LS0gYS9mcy9zdXBlci5jCj4gKysrIGIvZnMvc3VwZXIuYwo+IEBAIC04NjUsNyArODY1LDggQEAg
aW50IHJlY29uZmlndXJlX3N1cGVyKHN0cnVjdCBmc19jb250ZXh0ICpmYykKPiAgIAo+ICAgCWlm
IChmYy0+c2JfZmxhZ3NfbWFzayAmIFNCX1JET05MWSkgewo+ICAgI2lmZGVmIENPTkZJR19CTE9D
Swo+IC0JCWlmICghKGZjLT5zYl9mbGFncyAmIFNCX1JET05MWSkgJiYgYmRldl9yZWFkX29ubHko
c2ItPnNfYmRldikpCj4gKwkJaWYgKCEoZmMtPnNiX2ZsYWdzICYgU0JfUkRPTkxZKSAmJiBzYi0+
c19iZGV2ICYmCj4gKwkJICAgIGJkZXZfcmVhZF9vbmx5KHNiLT5zX2JkZXYpKQo+ICAgCQkJcmV0
dXJuIC1FQUNDRVM7Cj4gICAjZW5kaWYKPiAgIAo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5l
Y2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVj
a2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

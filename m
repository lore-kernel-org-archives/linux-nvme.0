Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC7C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:19:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50D864ED0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50D864ED0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=85gzTX0n5WshJV1XX6HhxCbRUgY3rV22NvFuXoxKcn4=; b=kfeDgzSZ2/XP4FTuxcxnl4Lkm
	ly1c2U2xM5PIEYNmxcciWU2M5vdFmN8TE/5brnqzz5+ThbXH4Ukfu4TpXaN1/rTZCz3zpS+eOxBlr
	9Irvim9xPjIlIzYjTj+BQOx4drjm9S6obJL1IkwT45eTZFojLfwne2V14AkgE1vXZBt7MC3oypmNd
	/b6BtAp9v4uHuL0uWhQzIAOq/h8byFPdKJBsxb5rRgSuN+h2ft+tK3pOB4Vz43TQZLFdNuqV6nqJk
	U0wVxQNZ/bwOUkYWxm1KDvCb5aHewm3HTtfVuNIYxBvxGIf2lu7pqGNtBgIdmRdqBR971Cy2yKNS5
	hp9ERHBcw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHXxc-006OSQ-9O; Wed, 03 Mar 2021 20:19:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT5T-005IkH-TA
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:06:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=7KeLXbWr2cTi+bg8Vjvu8NQD/kAo60I8HlACkPn786M=; b=WSMZNij+Fb6boBwGgD6BDkGTFi
 AsOkXn/xSsoIMbiGlw/mZcg8k+bgMSjhhkM0mhDoh+1mttHN/SjiXBJqgQwfamm6tPIC/NBLNwLJV
 8FTawufY6kc8A4PqscDxE8M4LVw3TfXWA4kP4ui529RsBmtV1aRT9f0nMjeVm/H/1aKtYJu0wH0kN
 0uHfH4jCK9mb4l3sB9pF9TafhOE2lAjhbnrk6p7bar2zgZ6xTJIYGisZ5oRk6Nqn6F9+Au8f9Xv/F
 tMNxIWXy8HzeRmL9Vm0wkeq/h59C0Dgtb/lyUs9QD0S+MLFdABfzlpUzjvOEzd4Tov74UV8tCTFj1
 HpSzf9LQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHQCQ-002TEE-Nc
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 12:01:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E96B6AD29;
 Wed,  3 Mar 2021 12:01:50 +0000 (UTC)
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-2-hare@suse.de> <20210303084210.GB9898@lst.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvme: fixup kato deadlock
Message-ID: <fee91925-6e3f-69b3-2d9e-2561789425a6@suse.de>
Date: Wed, 3 Mar 2021 13:01:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303084210.GB9898@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_120155_334238_4BC1792F 
X-CRM114-Status: GOOD (  22.87  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8zLzIxIDk6NDIgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFR1ZSwgTWFy
IDAyLCAyMDIxIGF0IDEwOjI2OjQyQU0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4g
KwlpZiAodGVzdF9hbmRfc2V0X2JpdChOVk1FX0NUUkxfS0FUT19SVU5OSU5HLCAmY3RybC0+Zmxh
Z3MpKQo+PiArCQlyZXR1cm4gMDsKPj4gKwo+PiAgCXJxID0gbnZtZV9hbGxvY19yZXF1ZXN0KGN0
cmwtPmFkbWluX3EsICZjdHJsLT5rYV9jbWQsCj4+IC0JCQlCTEtfTVFfUkVRX1JFU0VSVkVEKTsK
Pj4gLQlpZiAoSVNfRVJSKHJxKSkKPj4gKwkJCUJMS19NUV9SRVFfUkVTRVJWRUQgfCBCTEtfTVFf
UkVRX05PV0FJVCk7Cj4+ICsJaWYgKElTX0VSUihycSkpIHsKPj4gKwkJY2xlYXJfYml0KE5WTUVf
Q1RSTF9LQVRPX1JVTk5JTkcsICZjdHJsLT5mbGFncyk7Cj4+ICAJCXJldHVybiBQVFJfRVJSKHJx
KTsKPj4gKwl9Cj4gCj4gQWRkaW5nIEJMS19NUV9SRVFfTk9XQUlUIHNob3VsZCBiZSBhIHNlcGFy
YXRlIHByZXAgcGF0Y2gsIHRvZ2V0aGVyIHdpdGgKPiByZWR1Y2luZyB0aGUgbnVtYmVyIG9mIHJl
c2VydmVkIHRhZ3MuCj4gCk9rYXkuCkJ1dCB3aHkgd291bGQgd2UgbmVlZCB0byByZWR1Y2UgdGhl
IG51bWJlciBvZiB0YWdzPyBJdCdzIG5vdCB0aGF0IHdlJ3JlCmNoYW5naW5nIGFueXRoaW5nIHdp
dGggdGhlIGFsbG9jYXRpb24sIHdlJ3JlIGp1c3QgZ3VhcmFudGVlZCB0byBmYWlsIGlmCmZvciBz
b21lIHJlYXNvbiB0aGUgc3RhY2sgbWVzc2VzIHVwLgoKPiBBbHNvIHdoeSBkbyB3ZSBzdGlsbCBu
ZWVkIHRoZSBleHRyYSB0ZXN0X2FuZF9zZXRfYml0IHdpdGggdGhlCj4gTk9XQUlUIGFsbG9jYXRp
b24/Cj4gClRoaXMgaXMgZXNzZW50aWFsbHkgYSBzYWZlZ3VhcmQ7IHRoZXJlIGlzIG5vdGhpbmcg
aW4gdGhlIGN1cnJlbnQgY29kZQp0ZWxsaW5nIHVzIGlmIGEgS0FUTyBjb21tYW5kIGlzIGluIGZs
aWdodCBvciBub3QuCkFuZCBJIHJlYWxseSBkbyBoYXRlIGRvaW5nIHBvaW50bGVzcyB3b3JrIChs
aWtlIGFsbG9jYXRpbmcpIGNvbW1hbmRzIGlmCndlIGRvbid0IG5lZWQgdG8uCgpQbHVzIGl0J2xs
IGRpZmZlcmVudGlhdGUgYmV0d2VlbiBsZWdpdCBjYWxsZXJzIG9mCm52bWVfc3RhcnRfa2VlcF9h
bGl2ZSgpICh3aGljaCBjYW4gYmUgY2FsbGVkIGF0IGFueSB0aW1lLCBhbmQgaGVuY2UKbWlnaHQg
YmUgYWRkaW5nIHRoZSBrYV93b3JrIGVsZW1lbnQganVzdCBhZnRlciB0aGUgcHJldmlvdXMgb25l
IGhhZApzdWJtaXR0ZWQgdGhlIEtBVE8gY29tbWFuZCksIGFuZCByZWFsIGZhaWx1cmVzIGxpa2Ug
ZmFpbGluZyB0byBhbGxvY2F0ZQp0aGUgS0FUTyBjb21tYW5kIGl0c2VsZiwgd2hpY2ggcG9pbnRz
IHRvIGEgcmVhbCBpc3N1ZSBpbiB0aGUgc3RhY2sgYXMKbm9ybWFsbHkgdGhlcmUgc2hvdWxkIGJl
IGVub3VnaCByZXNlcnZlZCBjb21tYW5kcy4KCkJ1dCB5ZWFoLCBJJ2xsIHNwbGl0IGlmIG9mZiBp
biB0d28gcGF0Y2hlcy4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJ
ICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2Vy
bWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBO
w7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==

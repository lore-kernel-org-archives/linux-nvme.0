Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AC1C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:28:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF3F2395A
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF3F2395A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZMrfH4GrGHfbbpi1ZMdnui9URpfWjki3sj6XiIbppZA=; b=0i3Dxw74e8JTAzH1NajDpoMFm
	y6jcmRw2cegcKySbwIjwf8L5qwLDSXd+FjYWX7JBn3tneDvdAhwopHbTCuaQkXR5LZ7SdEdC02Ok1
	s1QsMyTtGMt9ic4M7zsZFMLqShRyTyBCNcrw/1kIrZg0Nvlxvb/BVjeG2yy0o85naTK9nQFDDbhbP
	jKg1CSTi63G4kCUNHRMShcog5vOBMlwWa6b539I7XBfNQ3G3xWfZBYFe5WzfGWLH4IoICrx7LhVHz
	F1cNAbhWiq9UxaoySU3OWuZlcUFFU3PzhpLLQf35IbcNgT8RuiGaOxbYYX2Llw1ulOoHZGNKDdsbD
	kmcEf7vmg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2WG3-0006GS-7q; Thu, 21 Jan 2021 09:28:03 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2WG0-0006Fj-JT
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 09:28:01 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D3A52B96F;
 Thu, 21 Jan 2021 09:27:57 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] nvme-fabrics: avoid double request completion for
 nvmf_fail_nonready_command
To: Christoph Hellwig <hch@lst.de>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-4-lengchao@huawei.com>
 <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
 <20210121090012.GA27342@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <467a43b0-82cc-69b7-460a-413ddc8cf574@suse.de>
Date: Thu, 21 Jan 2021 10:27:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210121090012.GA27342@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_042800_756268_B3B39D8F 
X-CRM114-Status: GOOD (  21.93  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, Chao Leng <lengchao@huawei.com>,
 kbusch@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yMS8yMSAxMDowMCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVGh1LCBK
YW4gMjEsIDIwMjEgYXQgMDk6NTg6MzdBTSArMDEwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+
PiBPbiAxLzIxLzIxIDg6MDMgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4+IFdoZW4gcmVjb25uZWN0
LCB0aGUgcmVxdWVzdCBtYXkgYmUgY29tcGxldGVkIHdpdGggTlZNRV9TQ19IT1NUX1BBVEhfRVJS
T1IKPj4+IGluIG52bWZfZmFpbF9ub25yZWFkeV9jb21tYW5kLiBUaGUgc3RhdGUgb2YgcmVxdWVz
dCB3aWxsIGJlIGNoYW5nZWQgdG8KPj4+IE1RX1JRX0lOX0ZMSUdIVCBiZWZvcmUgY2FsbCBudm1l
X2NvbXBsZXRlX3JxLiBJZiBmcmVlIHRoZSByZXF1ZXN0Cj4+PiBhc3luY2hyb25vdXNseSBzdWNo
IGFzIGluIG52bWVfc3VibWl0X3VzZXJfY21kLCBpbiBleHRyZW1lIHNjZW5hcmlvCj4+PiB0aGUg
cmVxdWVzdCBtYXkgYmUgY29tcGxldGVkIGFnYWluIGluIHRlYXIgZG93biBwcm9jZXNzLgo+Pj4g
bnZtZl9mYWlsX25vbnJlYWR5X2NvbW1hbmQgZG8gbm90IG5lZWQgY2FsbGluZyBibGtfbXFfc3Rh
cnRfcmVxdWVzdAo+Pj4gYmVmb3JlIGNvbXBsZXRlIHRoZSByZXF1ZXN0LiBudm1mX2ZhaWxfbm9u
cmVhZHlfY29tbWFuZCBzaG91bGQgc2V0Cj4+PiB0aGUgc3RhdGUgb2YgcmVxdWVzdCB0byBNUV9S
UV9DT01QTEVURSBiZWZvcmUgY29tcGxldGUgdGhlIHJlcXVlc3QuCj4+Pgo+Pgo+PiBTbyB3aGF0
IHlvdSBhcmUgc2F5aW5nIGlzIHRoYXQgdGhlcmUgaXMgYSByYWNlIGNvbmRpdGlvbiBiZXR3ZWVu
Cj4+IGJsa19tcV9zdGFydF9yZXF1ZXN0KCkKPj4gYW5kCj4+IG52bWVfY29tcGxldGVfcmVxdWVz
dCgpCj4gCj4gQmV0d2VlbiB0aG9zZSB0byBhIHRlYXJkb3duIHRoYXQgY2FuY2VscyBhbGwgcmVx
dWVzdHMgY2FuIGNvbWUgaW4uCj4gCkRvZXNuJ3QgbnZtZV9jb21wbGV0ZV9yZXF1ZXN0KCkgaW5z
dWxhdGUgYWdhaW5zdCBhIGRvdWJsZSBjb21wbGV0aW9uPwpJIHNlZW0gdG8gcmVtZW1iZXIgd2Un
dmUgZ29uZSB0aHJvdWdoIGdyZWF0IGxlbmd0aHMgZW5zdXJpbmcgdGhhdC4KCkFuZCBpZiB0aGlz
IGlzIGp1c3QgYWJvdXQgc2V0dGluZyB0aGUgY29ycmVjdCBlcnJvciBjb2RlIG9uIGNvbXBsZXRp
b24gCkknZCByZWFsbHkgcHJlZmVyIHRvIHN0aWNrIHdpdGggdGhlIGN1cnJlbnQgY29kZS4gTW92
aW5nIHRoYXQgaW50byBhIApoZWxwZXIgaXMgZmluZSwgYnV0IEknZCByYXRoZXIgbm90IGludHJv
ZHVjZSBvdXIgb3duIGNvZGUgbW9kaWZ5aW5nIApyZXF1ZXN0IHN0YXRlLgoKSWYgdGhlcmUgcmVh
bGx5IGlzIGEgcmFjZSBjb25kaXRpb24gdGhpcyBmZWVscyBsaWtlIGEgbW9yZSBnZW5lcmljIApw
cm9ibGVtOyBjYWxsaW5nIGJsa19tcV9zdGFydF9yZXF1ZXN0KCkgZm9sbG93ZWQgYnkgYmxrX21x
X2VuZF9yZXF1ZXN0KCkgCmlzIGEgcXVpdGUgY29tbW9uIHBhdHRlcm4sIGFuZCBmcm9tIG15IGlt
cHJlc3Npb24gdGhlIHJlY29tbWVuZGVkIHdheS4KU28gaWYgdGhlcmUgaXMgYW4gaXNzdWUgaXQg
d291bGQgbmVlZCB0byBiZSBhZGRyZXNzZWQgZm9yIGFsbCBkcml2ZXJzLCAKbm90IGp1c3Qgc29t
ZSBudm1lLXNwZWNpZmljIHdheS4KUGx1cyBJJ2QgbGlrZSB0byBoYXZlIEplbnMnIG9waW5pb24g
aGVyZS4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAg
ICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5i
ZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

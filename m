Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167FCC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:30:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB35220678
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SRfPaD8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB35220678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l+6acoXaM8Pnl68ERV5FweJ+8srygeXx6FGw2ZlVlTw=; b=SRfPaD8SSHkmmuBZXxI9ONdeR
	GOpi5g5IWGSK4ywT6vp0EEQ80oDONJ8foAxSSjAXNTNOhpzL2vms8bCg8XgCh3xf1hEnNTlF20AMn
	C4CwXxrPxhmmhq9r9kE1Bbb7qRDHdPjbj9CG2SksWMGgKon8u/TAv8cXSYoYTH0BcWciIFX96QQ7U
	vMKAcfrJblH3QMrk9lz6leHvZG+o9VqmbmqMNf8EDfWW1YPK9qX25DkUMihwTlSRaLsc/c4MdnHdY
	yrc/V4nSMCk3TuIf6B8EZ9wdeC1bANSinoQMMQrTB0d9KdgrzLsIOV/6Dd9LAsKZHW0dIi7O65mEH
	CpkCUJa7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK1nn-0003P9-Sy; Thu, 02 Apr 2020 15:30:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK1nk-0003NZ-2G
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 15:30:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DCBCFAC91;
 Thu,  2 Apr 2020 15:30:35 +0000 (UTC)
Subject: Re: nvme deadlock with ANA
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <5e38c566-3f26-288d-1004-161d1084b468@grimberg.me>
 <20200402151854.GA11784@lst.de>
 <7fce512e-deb6-2357-d627-d1a698a8269b@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4ec0c3ba-398d-0922-87f4-4b0a99a79abb@suse.de>
Date: Thu, 2 Apr 2020 17:30:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7fce512e-deb6-2357-d627-d1a698a8269b@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_083040_255190_674FADD6 
X-CRM114-Status: GOOD (  19.89  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8yLzIwIDU6MjQgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+PiBJIHdhbnQgdG8g
Y29uc3VsdCB3aXRoIHlvdSBndXlzIG9uIGEgZGVhZGxvY2sgY29uZGl0aW9uIEknbSBhYmxlIHRv
Cj4+PiBoaXQgd2l0aCBhIHRlc3QgdGhhdCBpbmNvcnBvcmF0ZSBjb250cm9sbGVyIHJlY29ubmVj
dCwgYW5hIHVwZGF0ZXMKPj4+IGFuZCBsaXZlIEkvTyB3aXRoIHRpbWVvdXRzLgo+Pj4KPj4+IFRo
aXMgaXMgdHJ1ZSBmb3IgTlZNZS9UQ1AsIGJ1dCBjYW4gYWxzbyBoYXBwZW4gaW4gcmRtYSBvciBw
Y2kgZHJpdmVycyBhcwo+Pj4gd2VsbC4KPj4+Cj4+PiBUaGUgZGVhZGxvY2sgY29tYmluZXMgNCBm
bG93cyBpbiBwYXJhbGxlbDoKPj4+IC0gbnMgc2Nhbm5pbmcgKHRyaWdnZXJlZCBmcm9tIHJlY29u
bmVjdCkKPj4+IC0gcmVxdWVzdCB0aW1lb3V0Cj4+PiAtIEFOQSB1cGRhdGUgKHRyaWdnZXJlZCBm
cm9tIHJlY29ubmVjdCkKPj4+IC0gRlMgSS9PIGNvbWluZyBpbnRvIHRoZSBtcGF0aCBkZXZpY2UK
Pj4+Cj4+PiAoMSkgbnMgc2Nhbm5pbmcgdHJpZ2dlcnMgZGlzayByZXZhbGlkYXRpb24gLT4gdXBk
YXRlIGRpc2sgaW5mbyAtPgo+Pj4gwqDCoMKgwqAgZnJlZXplIHF1ZXVlIC0+IGJ1dCBibG9ja2Vk
LCB3aHk/Cj4+Cj4+IFdoYXQgZG9lcyAtPiBidXQgYmxvY2tlZCBtZWFuPwo+IAo+IEl0IGlzIGJs
b2NrZWQgYW5kIGNhbm5vdCBjb21wbGV0ZSwgYmVjYXVzZSBvZiAoMikKPiAKPj4+ICgyKSB0aW1l
b3V0IGhhbmRsZXIgcmVmZXJlbmNlIHRoZSBnX3VzYWdlX2NvdW50ZXIgLSA+IGJ1dCBibG9ja3Mg
aW4KPj4+IMKgwqDCoMKgIHRoZSB0aW1lb3V0IGhhbmRsZXIsIHdoeT8KPj4KPj4gVGhlIHRpbWVv
dXQgaGFuZGxlciBvYnZpb3VzbHkgbmVlZHMgdG8ga2VlcCB0aGUgcXVldWUgYWxpdmUgd2hpbGUK
Pj4gcnVubmluZy7CoCBXZSBjb3VsZCB0aGluayBvZiBkb2luZyBhIHRyeV9nZXQsIHRob3VnaD8K
PiAKPiBJdCBpcyBrZWVwaW5nIHRoZSBxdWV1ZSBhbGl2ZSwgdGhhdCBpcyBub3QgdGhlIGlzc3Vl
LiBpdCBpcyBibG9ja2VkIGluCj4gdGhlIGRyaXZlciAudGltZW91dCgpIGhhbmRsZXIgKGkuZS4g
bnZtZV90Y3BfdGltZW91dCkuCj4gCj4gVGhlIHJlYXNvbiB0aGF0IGl0IGJsb2NrZWQgYW5kIGNh
bm5vdCBtYWtlIGZvcndhcmQgcHJvZ3Jlc3MgaXMgYmVjYXVzZQo+IHRoZSBkcml2ZXIgdGltZW91
dCBoYW5kbGVyIHdpbGwgY2FsbCBudm1lX3N0b3BfcXVldWVzKCksIHdoaWNoIGlzCj4gYmxvY2tl
ZCBhcyB0aGlzIHRha2VzIG5hbWVzcGFjZXNfcndzZW0uLi4KPiAKPiBUaGVyZSBpcyBhIGNoYWlu
IG9mIGRlcGVuZGVuY3kgdGhhdCBpcyBkZWFkbG9ja2luZyB3aXRoIGNpcmN1bGFyCj4gZGVwZW5k
ZW5jeS4KCkNhbid0IHlvdSBzaW1wbHkgY2FsbCAnbnZtZV9yZXNldF9jdHJsKCknID8KU2VlbXMg
dG8gd29yayByZWFzb25hYmx5IHdlbGwgb24gdGhlIGZjIHNpZGUsIHNvIEkgd29uZGVyIHdoYXQn
cyAKZGlmZmVyZW50IGZvciB0Y3AgLi4uCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UgICAgICAgICAgICBUZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1
c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VT
RSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJn
CkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5k
w7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

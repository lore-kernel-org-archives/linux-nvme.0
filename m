Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02FCC43461
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 16:03:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C3761154
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 16:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C3761154
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b+lP7zjXhf7K7J5IdsM7VXTAarzyd8nJQC2E2hl/dys=; b=Szh1OPzXPLcAxjcOWM1iYxQ4X
	Pnm+vGmi85Te6BWyma3aHDlWN8N2OkHvZvWjAltBDLuoG7KwIRHag50ooSnFdKe/X+DQ/klOlrEvP
	XJyBp/l1SEjFIoM0jRwyxZQe+TpyvYgwmSVeWJL0RlECBX3JUTYqxmfeWa4cwZPwl9CAQFhlxTslQ
	powilMKGqXcieLQqM+Oy/qzLsoI1pTAyWSVMsKv7ZS4UdZCgDfpFZw/7+8PfXQ7FSWBSTJAMCkWyO
	nJwAHV1t6Jjp0+w8rn4nIE64t0StEMKrTsKaVyr4bTOk+TugfjMpcteAhV7yfU9Cxew4m0iqyqkj1
	qvcY/IRSQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1legMr-004htt-Ep; Thu, 06 May 2021 15:56:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leg3K-004bLs-Ri
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 15:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
 :Cc:To:Sender:Reply-To:Content-ID:Content-Description;
 bh=euF9wU7s7gBAWEzNAQoHy3j6A1vaFHinMh9q43u1If0=; b=X6ILHxixYcB4jHsPpppHTJ/bIZ
 BiLqa23v9a7Hnq+Co3BqHjam5dVxhAQxG8LGypkBtWsuJJVZEAhA78ZNhWvfb1slR3SX42FPiZF6r
 fyrayWgw6ly5sJD+VDMT5NmpIyOKtzduNyibzC/UmJQFsLYbZVClEgd4/haWTv/SbBW98GSpE7Drl
 fAbDa18aOvw5fN9X+a7eIe6wZVrKSCAYRFnIysxgjjf17zTBi/q+DIL/ocs9/1cnpHalVKQGSoc5b
 uH5U+9eSwlAF3cMiKjagdZOxbYSaUKCU2LRTE/ixjmCp/kM7QtPU3LCvZw0bFiaYVfUpKG2B1C3Tl
 YPsgD3+Q==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leg3H-006ADf-Vv
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 15:36:37 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 398A7AC36;
 Thu,  6 May 2021 15:36:33 +0000 (UTC)
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: "Ewan D. Milne" <emilne@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
Date: Thu, 6 May 2021 17:36:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_083636_337442_C1423CCC 
X-CRM114-Status: GOOD (  27.65  )
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

T24gNC8xLzIxIDEyOjM3IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4+PiBJdCBpcywg
YnV0IGluIHRoaXMgc2l0dWF0aW9uLCB0aGUgY29udHJvbGxlciBpcyBzZW5kaW5nIGEgc2Vjb25k
Cj4+Pj4+IGNvbXBsZXRpb24gdGhhdCByZXN1bHRzIGluIGEgdXNlLWFmdGVyLWZyZWUsIHdoaWNo
IG1ha2VzIHRoZQo+Pj4+PiB0cmFuc3BvcnQgaXJyZWxldmFudC4gVW5sZXNzIHRoZXJlIGlzIHNv
bWUgb3RoZXIgZmxvdyAod2hpY2ggaXMKPj4+Pj4gdW5jbGVhcgo+Pj4+PiB0byBtZSkgdGhhdCBj
YXVzZXMgdGhpcyB3aGljaCBpcyBhIGJ1ZyB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkIHJhdGhlcgo+
Pj4+PiB0aGFuIGhpZGRlbiB3aXRoIGEgc2FmZWd1YXJkLgo+Pj4+Pgo+Pj4+Cj4+Pj4gVGhlIGtl
cm5lbCBzaG91bGQgbm90IGNyYXNoIHJlZ2FyZGxlc3Mgb2YgYW55IG5ldHdvcmsgdHJhZmZpYyB0
aGF0IGlzCj4+Pj4gc2VudCB0byB0aGUgc3lzdGVtLsKgIEl0IHNob3VsZCBub3QgYmUgcG9zc2li
bGUgdG8gZWl0aGVyIGludGVudGlvbmFsbHkKPj4+PiBvZiBtaXN0YWtlbmx5IGNvbnRydWN0IHBh
Y2tldHMgdGhhdCB3aWxsIGRlbnkgc2VydmljZSBpbiB0aGlzIHdheS4KPj4+Cj4+PiBUaGlzIGlz
IG5vdCBzcGVjaWZpYyB0byBudm1lLXRjcC4gSSBjYW4gYnVpbGQgYW4gcmRtYSBvciBwY2kgY29u
dHJvbGxlcgo+Pj4gdGhhdCBjYW4gdHJpZ2dlciB0aGUgc2FtZSBjcmFzaC4uLiBJIHNhdyBhIHNp
bWlsYXIgcGF0Y2ggZnJvbSBIYW5uZXMKPj4+IGltcGxlbWVudGVkIGluIHRoZSBzY3NpIGxldmVs
LCBhbmQgbm90IHRoZSBpbmRpdmlkdWFsIHNjc2kgdHJhbnNwb3J0cy4uCj4+Cj4+IElmIHNjc2kg
d2FudHMgdGhpcyB0b28sIHRoaXMgY291bGQgYmUgbWFkZSBnZW5lcmljIGF0IHRoZSBibGstbXEg
bGV2ZWwuCj4+IFdlIGp1c3QgbmVlZCB0byBtYWtlIHNvbWV0aGluZyBsaWtlIGJsa19tcV90YWdf
dG9fcnEoKSwgYnV0IHJldHVybiBOVUxMCj4+IGlmIHRoZSByZXF1ZXN0IGlzbid0IHN0YXJ0ZWQu
Cj4gCj4gTWFrZXMgc2Vuc2UuLi4KPiAKPj4+IEkgd291bGQgYWxzbyBtZW50aW9uLCB0aGF0IGEg
Y3Jhc2ggaXMgbm90IGV2ZW4gdGhlIHNjYXJpZXN0IGlzc3VlIHRoYXQKPj4+IHdlIGNhbiBzZWUg
aGVyZSwgYmVjYXVzZSBpZiB0aGUgcmVxdWVzdCBoYXBwZW5lZCB0byBiZSByZXVzZWQgd2UgYXJl
Cj4+PiBpbiB0aGUgc2lsZW50IGRhdGEgY29ycnVwdGlvbiByZWFsbS4uLgo+Pgo+PiBJZiB0aGlz
IGRvZXMgaGFwcGVuLCBJIHRoaW5rIHdlIGhhdmUgdG8gY29tZSB1cCB3aXRoIHNvbWUgd2F5IHRv
Cj4+IG1pdGlnYXRlIGl0LiBXZSdyZSBub3QgdXRpbGl6aW5nIHRoZSBmdWxsIDE2IGJpdHMgb2Yg
dGhlIGNvbW1hbmRfaWQsIHNvCj4+IG1heWJlIHdlIGNhbiBhcHBlbmQgc29tZXRoaW5nIGxpa2Ug
YSBnZW5lcmF0aW9uIHNlcXVlbmNlIG51bWJlciB0aGF0IGNhbgo+PiBiZSBjaGVja2VkIGZvciB2
YWxpZGl0eS4KPiAKPiBUaGF0J3MgYWN0dWFsbHkgYSBncmVhdCBpZGVhLiBzY3NpIG5lZWRzIHVu
aXF1ZSB0YWdzIHNvIGl0IGVuY29kZXMgdGhlCj4gaHdxIGluIHRoZSB1cHBlciAxNiBiaXRzIGdp
dmluZyB0aGUgYWN0dWFsIHRhZyB0aGUgbG93ZXIgMTYgYml0cyB3aGljaAo+IGlzIG1vcmUgdGhh
biBlbm91Z2ggZm9yIGEgc2luZ2xlIHF1ZXVlLiBXZSBjYW4gZG8gdGhlIHNhbWUgd2l0aAo+IGEg
Z2VuY250IHRoYXQgd2lsbCBpbmNyZW1lbnQgaW4gYm90aCBzdWJtaXNzaW9uIGFuZCBjb21wbGV0
aW9uIGFuZCB3ZQo+IGNhbiB2YWxpZGF0ZSBhZ2FpbnN0IGl0Lgo+IAo+IFRoaXMgd2lsbCBiZSB1
c2VmdWwgZm9yIGFsbCB0cmFuc3BvcnRzLCBzbyBtYWludGFpbmluZyBpdCBpbgo+IG52bWVfcmVx
KHJxKS0+Z2VuY3RyIGFuZCBpbnRyb2R1Y2luZyBhIGhlbHBlciBsaWtlOgo+IHJxID0gbnZtZV9m
aW5kX3RhZyh0YWdzZXQsIGNxZS0+Y29tbWFuZF9pZCkKPiBUaGF0IHdpbGwgZmlsdGVyIGdlbmN0
ciwgbG9jYXRlIHRoZSByZXF1ZXN0Lgo+IAo+IEFsc286Cj4gbnZtZV92YWxpZGF0ZV9yZXF1ZXN0
X2dlbihycSwgY3FlLT5jb21tYW5kX2lkKSB0aGF0IHdvdWxkCj4gY29tcGFyZSBhZ2FpbnN0IGl0
Lgo+IAo+IAo+IEFuZCB0aGVuIGEgaGVscGVyIHRvIHNldCB0aGUgY29tbWFuZF9pZCBsaWtlOgo+
IGNtZC0+Y29tbW9uLmNvbW1hbmRfaWQgPSBudm1lX3JlcXVlc3RfY29tbWFuZF9pZChycSkKPiB0
aGF0IHdpbGwgYm90aCBpbmNyZW1lbnQgdGhlIGdlbmN0ciBhbmQgYnVpbGQgYSBjb21tYW5kX2lk
Cj4gZnJvbSBpdC4KPiAKPiBUaG91Z2h0cz8KPiAKCldlbGwsIHRoYXQgd291bGQgcmVxdWlyZSBh
IG1vZGlmaWNhdGlvbiB0byB0aGUgQ1FFIHNwZWNpZmljYXRpb24sIG5vPwpmbWRzIHdhcyBub3Qg
YW11c2VkIHdoZW4gSSBwcm9wb3NlZCB0aGF0IDotKAoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4g
SGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1
c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVy
LCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK

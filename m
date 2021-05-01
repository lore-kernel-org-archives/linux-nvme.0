Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C628C433ED
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 11:58:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD53613F8
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 11:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD53613F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O7E3foXCpceHdLWLaJvpGaka0mDJMqZD8O2fupf2IVA=; b=bW+wGo2yJzEr8wZNTEcaUVblP
	X0rC2Ie42ckiqu1ZJNkJpi8B3VDWhn9Vk6NupVm178ffcWr6eFS66x+3HNrtGdKNhciOoUvB//Ggv
	KnIoxbfkN8DpJHsHtZ0BGg2Jm0UrIINchYJDjToR+UqWLtEuZO8bvU9Mg0y6i/fItODcu7LN2Pdiu
	OIonUqjZq4356jXTBVERJ8g2R2RpDPhUcZtuYIDiO3C26ZCE39ZuJpK3V9gsV+jmeci/VDHbLvez5
	cUkHhUOh6s3LK+aFOmq8UmNIMKAAUC3ordd+CX8LIje6Ax/uj/EdjY+U9rfIbigP0sH8a7gPzY+7V
	xqmadomww==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcoGD-009zio-D1; Sat, 01 May 2021 11:58:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcoG7-009zid-1a
 for linux-nvme@desiato.infradead.org; Sat, 01 May 2021 11:58:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=JMlaVfME4xNaCewW/YRBbJnll8Xf9RO3eQUEQZ6GnyU=; b=kb/NWiBl8KVus1XIJINTcC9SmP
 EAFPNWxtUrjG4KFLzkh2P7iejOznuXFLDA2+3u6JlkDIYqMLaRDyL3CJzpesuDc7EfRkcEPC5vp2i
 K9aoVygvE0WEZFiwT0rcmQ8bg2kJ6JSqg4KiMe+qmp4YPclyQoIuOMCGLpSozXIGMAetNe7jDRZcY
 fq143Aaqfy4xWbuh/lE5q57uOAXMhLncCo7NOLNYVTRdOO29BmcsKKLndQR2Wwm1FoI84vU3FgIzm
 F1BdO5vrbUbICFHasuVkrzm7zzYe05Tx6+pBxJGozOFkfA3kPsYkurHMrDNJswubHbTv+VMfrIjmI
 gN/UnQCA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcoG4-001yH1-5U
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 11:58:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9486AB1B1;
 Sat,  1 May 2021 11:58:01 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to work
 well with dm-multipath
To: Laurence Oberman <loberman@redhat.com>, Mike Snitzer
 <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210420093720.GA28874@lst.de> <20210420143852.GB14523@redhat.com>
 <6a22337b0d15830d9117640bd227711ba8c8aef8.camel@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f2df22ef-583e-1d80-6ea7-2edfe61b9b53@suse.de>
Date: Sat, 1 May 2021 13:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6a22337b0d15830d9117640bd227711ba8c8aef8.camel@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_045804_381312_1D14B137 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8yMC8yMSA1OjQ2IFBNLCBMYXVyZW5jZSBPYmVybWFuIHdyb3RlOgpbIC4uIF0KPiAKPiBM
ZXQgbWUgYWRkIHNvbWUgcmVhc29ucyB3aHkgYXMgcHJpbWFyaWx5IGEgc3VwcG9ydCBwZXJzb24g
dGhhdCB0aGlzIGlzCj4gaW1wb3J0YW50IGFuZCB0cnkgYXZvaWQgYW5vdGhlciBjb21iYXRpdmUg
c2l0dWF0aW9uLgo+IAo+IEN1c3RvbWVycyBkZXBlbmQgb24gbWFuYWdpbmcgZGV2aWNlLW1hcHBl
ci1tdWx0aXBhdGggdGhlIHdheSBpdCBpcyBub3cKPiBldmVuIHdpdGggdGhlIGFkdmVudCBvZiBu
dm1lLW92ZXItRi9DLiBZZWFycyBvZiBhZG1pbmlzdHJhdGlvbiBhbmQKPiBtYW5hZ2VtZW50IGZv
ciBtdWx0aXBsZSBFbnRlcnByaXNlIE8vUyB2ZW5kb3IgY3VzdG9tZXJzIChTdXNlL1JlZCBIYXQs
Cj4gT3JhY2xlKSBhbGwgZGVwZW5kIG9uIG1hbmFnaW5nIG11bHRpcGF0aCBhY2Nlc3MgaW4gYSB0
cmFuc3BhcmVudCB3YXkuCj4gCj4gSSByZXNwZWN0IGV2ZXJ5Ym9keSdzIHBvaW50IG9mIHZpZXcg
aGVyZSBidXQgbmF0aXZlIGRvZXMgY2hhbmdlIGxvZwo+IGFsZXJ0aW5nIGFuZCByZWNvdmVyeSBh
bmQgdGhhdCBpcyB3aGF0IHdpbGwgdGFrZSB0aW1lIGZvciBjdXN0b21lcnMgdG8KPiBhZG9wdC4K
PiAKPiBJdCBpcyBnb2luZyB0byB0YWtlIHRpbWUgZm9yIEVudGVycHJpc2UgY3VzdG9tZXJzIHRv
IHRyYW5zaXRpb24gc28gYWxsCj4gd2Ugd2FudCBpcyBhbiBvcHRpb24gZm9yIHRoZW0uIEF0IHNv
bWUgcG9pbnQgdGhleSB3aWxsIG1vdmUgdG8gbmF0aXZlCj4gYnV0IHdlIGFsd2F5cyBsaWtlIHRv
IGtlZXAgaW4gc3RlcCB3aXRoIHVwc3RyZWFtIGFzIG11Y2ggYXMgcG9zc2libGUuCj4gCj4gT2Yg
Y291cnNlIHdlIGNvdWxkIGxpdmUgd2l0aCBSSEVMLW9ubHkgZm9yIHdoaWxlIGJ1dCB0aGF0IGRl
ZmVhdHMgb3VyCj4gaW50ZW50aW9uIHRvIGJlIGFzIGNsb3NlIHRvIHVwc3RyZWFtIGFzIHBvc3Np
YmxlLgo+IAo+IElmIHdlIGNvdWxkIGhhdmUgdGhpcyBhY2NlcHRlZCB1cHN0cmVhbSBmb3Igbm93
IHBlcmhhcHMgd2hlbiBjdXN0b21lcnMKPiBhcmUgcmVhZHkgdG8gbW92ZSB0byBuYXRpdmUgb25s
eSB3ZSBjb3VsZCBwaGFzZSB0aGlzIG91dC4KPiAKPiBBbnkgdGVjaG5pY2FsIHJlYXNvbiB3aHkg
dGhpcyB3b3VsZCBub3QgZmx5IGlzIG9mIGNvdXJzZSBpbXBvcnRhbnQgdG8KPiBjb25zaWRlciBi
dXQgcGVyaGFwcyBmb3Igbm93IHdlIGhhdmUgYSBwYXJhbGxlbCBvcHRpb24gdW50aWwgd2UgZG9u
dC4KPiAKQ3VyaW91c2x5LCB3ZSAoYXMgaW4gd2UgYXMgU0xFUyBkZXZlbG9wZXJzKSBoYXZlIGZv
dW5kIGp1c3QgdGhlIG9wcG9zaXRlLgpOVk1lIGlzIGEgbmV3IHRlY2hub2xvZ3ksIGFuZCBvdXQg
b2YgbmVjZXNzaXR5IHRoZXJlIHdpbGwgbm90IGJlIGFueSAKZXhpc3RpbmcgaW5zdGFsbGF0aW9u
cyB3aGVyZSB3ZSBoYXZlIHRvIGJlIGNvbXBhdGlibGUgd2l0aC4KV2UgaGF2ZSBzd2l0Y2hlZCB0
byBuYXRpdmUgTlZNZSBtdWx0aXBhdGhpbmcgd2l0aCBTTEUxNSwgYW5kIGRlY2lkZWQgdG8gCmVk
dWNhdGUgY3VzdG9tZXJzIHRoYXQgTlZNZSBpcyBhIGRpZmZlcmVudCBjb25jZXB0IHRoYW4gU0NT
SSwgYW5kIG9uZSAKc2hvdWxkbid0IHRyeSB0cmVhdCBib3RoIHRoZSBzYW1lIHdheS4gVGhpcyB3
YXMgaGVscGVkIGJ5IHRoZSBmYWN0IHRoZSAKU0xFMTUgaXMgYSBuZXcgcmVsZWFzZSwgc28gY3Vz
dG9tZXJzIHdlcmUgYWNjdXN0b21lZCB0byBoYXZpbmcgdG8gY2hhbmdlIApiaXRzIGFuZCBwaWVj
ZXMgaW4gdGhlaXIgaW5mcmFzdHJ1Y3R1cmUgdG8gc3VwcG9ydCBuZXcgcmVsZWFzZXMuCgpPdmVy
YWxsIGl0IHdvcmtlZCByZWFzb25hYmx5IHdlbGw7IHdlIHN1cmUgZm91bmQgcGxlbnR5IG9mIGJ1
Z3MsIGJ1dCAKdGhhdCB3YXMga2luZCBvZiBleHBlY3RlZCwgYW5kIGZvciBiYWQgb3Igd29yc2Ug
bmVhcmx5IGFsbCBvZiB0aGVtIAp0dXJuZWQgb3V0IHRvIGJlIHVwc3RyZWFtIGlzc3Vlcy4gV2hp
Y2ggd2FzIGdvb2QgZm9yIHVzIChub3RoaW5nIGJlYXRzIApiZWluZyBhYmxlIHRvIGJsYW1lIHRo
aW5ncyBvbiB1cHN0cmVhbSwgaWYgb25lIGlzIGNhcmVmdWwgdG8gbm90IGxpbmdlciAKdG9vIG11
Y2ggb24gdGhlIGZhY3QgdGhhdCBvbmUgaXMgcGFydCBvZiB1cHN0cmVhbSk7IGFuZCB1cHN0cmVh
bSB0aGVzZSAKdGhpbmdzIHdpbGwgbmVlZCB0byBiZSBmaXhlZCBhbnl3YXkuClNvIHdlIGhhZCBh
IGJpdCBvZiBhIG1peGVkIGV4cGVyaWVuY2UsIGJ1dCBjdXN0b21lcnMgc2VlbWVkIHRvIGJlIGhh
cHB5IAplbm91Z2ggd2l0aCB0aGlzIHN0ZXAuCgpTb3JyeSBhYm91dCB0aGF0IDotKQoKQ2hlZXJz
LAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBT
dG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxk
c3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOk
ZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==

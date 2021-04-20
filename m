Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376ADC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 16:22:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646A4613C8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 16:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646A4613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VUjaK5mJAK70oWq3xtoYapnxbG+Vdo1PCieXyyyKDlY=; b=kpQiN4huSH7lC6Jceg4LkJ8+u
	jBBz+aiFkObRtnsne6/5EIrVyan64EbDcWRhIDYMj8/Vb3DNZgHA3FYgM9SuVq894/8kAaKt50nVj
	pEobaPQQDEaeHspI++j4tJA8TP49HT0WqIhhRM+obNEyfrAa6XzEGtlItpqOiAWHgvQbGcLZ4KMqE
	5wujZXUhVH66SwH000aiIlsDdrLnjcEC2MwnGLyIZtMI39T0gmOB6oV/9X5huUwGes6PIyX+N4ICh
	jbjUOh2/ThT/PqKbZsKfLTFJFy3WFpiHVf9bHZdvgiv70ASfufuv4Xh0gWzXng2UAGOexUxoaehGD
	QrEgAIETA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYt8a-00CZ2h-4u; Tue, 20 Apr 2021 16:22:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYt8Y-00CZ2R-3z
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 16:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=A5qpGtH4fr/PLaIVgYZZXU+MM+QezW4r676kfFzrRU8=; b=0xwzQ1bqCkG0Z3rwccqAFrJZSB
 2iVvR9MSx30H/vZKmptwJUudDPYtpsOUKa1filVRxW0JSqwmLCiJltgdiH3O5OUSsz/RHvoP9T1bH
 VcKU6RdAxtO579vNmXw1ZSKyDAwjPTqX23uTwG4Qv6+nzifKGNYh4VeOa6jmfy/QWXOO5pt7vUL31
 FUYZOPu487OvQwM5zQgLVPJtYcK1+rFnrRRO/4nVoT/A5aDQIqf6dbQZla2EATNYapxfqWiR3ByH6
 WR2o/esTakHKHt+EKYcLy+R66u6ZFs9pmH1TCxss1dk3R54sr+giBQC8EgjLfwebAKDYEecZBdP/N
 wZVZ73Pw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYt8V-00CGnG-Eb
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 16:22:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 99587B504;
 Tue, 20 Apr 2021 16:22:00 +0000 (UTC)
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Daniel Wagner <daniel.wagner@suse.de>
References: <20210416062411.47958-1-hare@suse.de>
 <20210420080527.GA21651@lst.de>
 <b5dc2cdf-fcb0-8ffc-8ea9-c77d32561043@suse.de>
 <20210420141436.GA14300@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5cc5da66-e2aa-3c97-ddbc-70eeb4b5a8ea@suse.de>
Date: Tue, 20 Apr 2021 18:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210420141436.GA14300@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_092203_653331_74E6B8D3 
X-CRM114-Status: GOOD (  21.55  )
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

T24gNC8yMC8yMSA0OjE0IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBUdWUsIEFwciAyMCwg
MjAyMSBhdCAwMzoxOToxMFBNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDQv
MjAvMjEgMTA6MDUgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4gT24gRnJpLCBBcHIg
MTYsIDIwMjEgYXQgMDg6MjQ6MTFBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4+
IFdpdGggdGhlIHByb3Bvc2VkIHBhdGNoLCB0aGUgZm9sbG93aW5nIG1lc3NhZ2VzIGFwcGVhcjoK
Pj4+Pgo+Pj4+ICAgIFsgIDIyNy41MTY4MDddIG1kL3JhaWQxOm1kMDogRGlzayBmYWlsdXJlIG9u
IG52bWUzbjEsIGRpc2FibGluZyBkZXZpY2UuCj4+Pj4gICAgWyAgMjI3LjUxNjgwN10gbWQvcmFp
ZDE6bWQwOiBPcGVyYXRpb24gY29udGludWluZyBvbiAxIGRldmljZXMuCj4+Pgo+Pj4gU28gaG93
IGlzIHRoaXMgZ29pbmcgdG8gd29yayBmb3IgZS5nLiBhIGNhc2Ugd2hlcmUgdGhlIGRldmljZQo+
Pj4gZGlzYXBwZWFyIGR1ZSB0byByZXNldHMgb3IgZmFicmljcyBjb25uZWN0aW9uIHByb2JsZW1z
PyAgVGhpcyBub3cKPj4+IGRpcmVjdGx5IHRlYXJkcyBkb3duIHRoZSBkZXZpY2UuCj4+Pgo+PiBZ
ZXMsIHRoYXQgaXMgY29ycmVjdDsgdGhlIG5zaGVhZCB3aWxsIGJlIHJlbW92ZWQgb25jZSB0aGUg
bGFzdCBwYXRoIGlzCj4+IF9yZW1vdmVkXy4KPiAKPiBUaGUgZW5kIHJlc3VsdCBpcyBhbHNvIGhv
dyBub24tbXVsdGlwYXRoIG52bWUgYmVoYXZlcywgc28gSSB0aGluayB0aGF0J3MKPiB3aGF0IHVz
ZXJzIGhhdmUgY29tZSB0byBleHBlY3QuCj4gCk5vcGUuIEl0IGRvZXNuJ3QuCgpUaGlzIHBhdGNo
IHByZWNpc2VseSBfYWxpZ25zXyB0aGUgYmVoYXZpb3VyIGJldHdlZW4gbXVsdGlwYXRoZWQgKG9y
LCB0byAKYmUgcHJlY2lzZSwgbmFtZXNwYWNlcyB3aXRoIENNSUMgIT0gMCkgYW5kIG5vbi1tdWx0
aXBhdGhlZCBvbmVzLgoKV2hlbiBDTUlDID09IDAgdGhpcyBwYXRjaCBkb2Vzbid0IGNoYW5nZSB0
aGUgYmVoYXZpb3VyIGF0IGFsbC4KCj4+IEJ1dCBrZXkgcG9pbnQgaGVyZSBpcyB0aGF0IG9uY2Ug
dGhlIHN5c3RlbSBmaW5kcyBpdHNlbGYgaW4gdGhhdAo+PiBzaXR1YXRpb24gaXQncyBpbXBvc3Np
YmxlIHRvIHJlY292ZXIsIGFzIHRoZSByZWZjb3VudHMgYXJlIG1lc3NlZC4KPj4gRXZlbiBhIG1h
bnVhbCBjb25uZWN0IGNhbGwgd2l0aCB0aGUgc2FtZSBwYXJhbWV0ZXIgd2lsbCBfbm90XyByZXN0
b3JlCj4+IG9wZXJhdGlvbiwgYnV0IHJhdGhlciByZXN1bHQgaW4gYSBuZXcgbmFtZXNwYWNlLgo+
IAo+IEkgaGF2ZW4ndCBsb29rZWQgYXQgdGhpcyB5ZXQsIGJ1dCBpcyBpdCByZWFsbHkgbm90IHBv
c3NpYmxlIHRvIHJlc3RvcmUKPiB0aGUgb3JpZ2luYWwgbmFtZXNwYWNlIHVwb24gdGhlIHJlZXN0
YWJsaXNoZWQgY29ubmVjdGlvbj8KPiAKCk5vLiBBcyBtZW50aW9uZWQsIHJlZmNvdW50IGlzIG1l
c3NlZCB1cC4KCldpdGggdGhlIGN1cnJlbnQgYmVoYXZpb3VyLCBvbmNlIHRoZSBsYXN0IHBhdGgg
ZHJvcHMsIHRoZSBuYW1lc3BhY2Ugd2lsbCAKX3ZhbmlzaF8gZnJvbSB0aGUgbGlzdCBvZiBuYW1l
c3BhY2VzLgpPbmNlIHlvdSByZWNvbm5lY3QgdGhlIG9yaWdpbmFsIG5hbWVzcGFjZSAnbWFnaWNh
bGx5JyByZWFwcGVhcnMgaW4gJ252bWUgCmxpc3QnLCBidXQgd2l0aCBzaXplICcwJywgX2FuZF8g
dGhlIG5ldyBuYW1lc3BhY2UgYmVzaWRlIGl0OgoKTmVlZGxlc3MgdG8gc2F5LCB0aGUgY3VycmVu
dCBvcGVuZXIgKG1vdW50LCBNRCwgeW91IG5hbWUgaXQpIHN0aWxsIHJlZmVyIAp0byB0aGUgb3Jp
Z2luYWwgbmFtZXNwYWNlLCBhbmQgeW91IGNhbid0IGNvcnJlY3QgdGhlIHNpdHVhdGlvbiBhcyBJ
L08gaXMgCnN0aWxsIHBlbmRpbmcgeW91IGhhdmUgbm8gd2F5IHRvIGFib3J0IGl0LgoKKEZ1bm55
LCB0aG91Z2g7IGl0IHdhcyB5b3Ugd2hvIHN1Z2dlc3RlZCB0aGUgcGF0Y2ggaW4gdGhlIGZpcnN0
IHBsYWNlOyAKZmVlbHMga2luZGEgc3RyYW5nZSB0byBleHBsYWluIHRoZSBwYXRjaCB0byBpdHMg
YXV0aG9yIC4uLikKCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAg
ICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1
dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcg
TsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

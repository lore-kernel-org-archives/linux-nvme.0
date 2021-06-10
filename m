Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D0CC47094
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 05:49:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C1F613FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 05:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C1F613FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vNszsWfQo0PZFj1mymhCz5urj2Y4fBkAiIl2npDs+m8=; b=HfqGoZeBE2aPVd+oUUxRGtlGS1
	3TrI3PWbb0xB2O2iw7HbzQaOQEAysei1q70fhbT1kPz2a1ug/zUryNiVMm09d5kZfiDoN+N471QoS
	OAjyFwPVUPZ73WBmWMOHYA1DH943fXp/3OGrLm680uSXh/02gUTE/CiN1aJxCjYWNoFEgnRRpYny3
	pDNWpWAgOof16BxP9wYF06MlJFr9h96MPBj5VjfdIuKArk+KhmyPGN/omj6Y82r9dxNw7liIOTDZM
	v3kQYMLIhnrIZZZj589Tk89FWQpjfrq6ELAKxR5RcNSddi0pdf2283aIRqdefYQSACs0vzLoIKGW6
	kQc/TdAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrDZP-00H1iJ-Uh; Thu, 10 Jun 2021 05:49:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrDZ7-00H1hq-GA
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 05:49:19 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A17C219A4;
 Thu, 10 Jun 2021 05:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623304155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szkljEzgCRdiHyAjgWdsyJCWn5descVJMM5wdYasVZc=;
 b=pzUivnuGijG3apDNfz9DY3puqkeIciuB40Qu+jm5HTJXrzFwQFUwd+0W/VrqjgN6yUO2wd
 RsojuFbHuti5cNrooNi98+8HmsXzdDpgBMuxZi/mF44FIEmklSKrP7fEIU4F4ZwtaHdJY7
 OpN8zLgAd9UhTOltI+DB1lmAWDcbsfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623304155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szkljEzgCRdiHyAjgWdsyJCWn5descVJMM5wdYasVZc=;
 b=0/1aLJsQwxN0CJJMbM+Zw7fyNCiBrG8DQd22FtuY56fj7caCogAx09Ct4PJCUqC6hMNiWR
 rdVdWTZ2BsoLFCCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 5F81D118DD;
 Thu, 10 Jun 2021 05:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623304155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szkljEzgCRdiHyAjgWdsyJCWn5descVJMM5wdYasVZc=;
 b=pzUivnuGijG3apDNfz9DY3puqkeIciuB40Qu+jm5HTJXrzFwQFUwd+0W/VrqjgN6yUO2wd
 RsojuFbHuti5cNrooNi98+8HmsXzdDpgBMuxZi/mF44FIEmklSKrP7fEIU4F4ZwtaHdJY7
 OpN8zLgAd9UhTOltI+DB1lmAWDcbsfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623304155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szkljEzgCRdiHyAjgWdsyJCWn5descVJMM5wdYasVZc=;
 b=0/1aLJsQwxN0CJJMbM+Zw7fyNCiBrG8DQd22FtuY56fj7caCogAx09Ct4PJCUqC6hMNiWR
 rdVdWTZ2BsoLFCCQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id jws+FtunwWBCTgAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 05:49:15 +0000
Subject: Re: [LSF/MM/BPF TOPIC] block namespaces
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <a189ec50-4c11-9ee9-0b9e-b492507adc1e@suse.de>
 <485837f392401bf35fb7fc8231d7a051f47b53d7.camel@HansenPartnership.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <539b35c6-34f7-62e0-4d93-6d27145bb78f@suse.de>
Date: Thu, 10 Jun 2021 07:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <485837f392401bf35fb7fc8231d7a051f47b53d7.camel@HansenPartnership.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_224917_719223_08B60B49 
X-CRM114-Status: GOOD (  36.63  )
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

T24gNi85LzIxIDg6MzYgUE0sIEphbWVzIEJvdHRvbWxleSB3cm90ZToKPiBPbiBUaHUsIDIwMjEt
MDUtMjcgYXQgMTA6MDEgKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gSGkgYWxsLAo+
Pgo+PiBJIGd1ZXNzIGl0J3MgdGltZSB0byB0aWNrIG9mZiB5ZXQgYW5vdGhlciBpdGVtIG9uIG15
IGxvbmctdGVybSB0by1kbwo+PiBsaXN0Ogo+Pgo+PiBCbG9jayBuYW1lc3BhY2VzCj4+IC0tLS0t
LS0tLS0tLS0tLS0KPj4KPj4gSWRlYSBpcyBzaW1pbGFyIHRvIHdoYXQgbmV0d29yayBhbHJlYWR5
IGRvZXM6IGFsbG93aW5nIGVhY2ggdXNlcgo+PiBuYW1lc3BhY2UgdG8gaGF2ZSBhIGRpZmZlcmVu
dCAndmlldycgb24gdGhlIGV4aXN0aW5nIGJsb2NrIGRldmljZXMuCj4+IEVHIGlmIHRoZSBhZG1p
biBjcmVhdGVzIGEgcmFtZGlzayBpbiBvbmUgbmFtZXNwYWNlIHRoaXMgZGV2aWNlIHNob3VsZAo+
PiBub3QgYmUgdmlzaWJsZSB0byBvdGhlciBuYW1lc3BhY2VzLgo+PiBCdXQgZm9yIG1lIHRoZSBt
b3N0IGltcG9ydGFudCB1c2UtY2FzZSB3b3VsZCBiZSBxZW11OyBjdXJyZW50bHkgdGhlCj4+IGRl
dmljZXMgbmVlZCB0byBiZSBzZXQgdXAgaW4gdGhlIGhvc3QsIGV2ZW4gdGhvdWdoIHRoZSBob3N0
IGhhcyBubwo+PiBidXNpbmVzcyB0b3VjaGluZyBpdCBhcyB0aGV5IHJlYWxseSBiZWxvbmcgdG8g
dGhlIHFlbXUgaW5zdGFuY2UuIFRoaXMKPj4gaXMgY2F1c2luZyBxdWl0ZSBzb21lIGlycml0YXRp
b24gZWcgd2hlbiB0aGlzIGRldmljZSBoYXMgTFZNIG9yIE1ECj4+IG1ldGFkYXRhIGFuZCB1ZGV2
IGlzIHRyeWluZyB0byBhY3RpdmF0ZSBpdCBvbiB0aGUgaG9zdC4KPiAKPiBJIHN1cHBvc2UgdGhl
IGZpcnN0IHF1ZXN0aW9uIGlzICJ3aHkgYmxvY2sgb25seT8iICBUaGVyZSBhcmUgc2V2ZXJhbAo+
IGV4aXN0aW5nIGRldmljZSBuYW1lc3BhY2UgcHJvcG9zYWxzIHdoaWNoIHdvdWxkIGJlIG1vcmUg
Z2VuZXJpYy4KPiAKCldlbGw7IEknbSBtb3JlIG9mIGEgc3RvcmFnZSBwZXJzb24sIGFuZCBkbyBr
bm93IHRoZSBuZWVkcyBhbmQgCnNob3J0Y29taW5ncyBpbiB0aGF0IGFyZWEuIExlc3Mgd2VsbCBz
byBpbiBvdGhlciBhcmVhcy4uLgoKPj4gT3ZlcmFsbCBwbGFuIGlzIHRvIHJlc3RyaWN0IHZpZXdz
IG9mICcvZGV2JywgJy9zeXMvZGV2L2Jsb2NrJyBhbmQKPj4gJy9zeXMvYmxvY2snIHRvIG9ubHkg
cHJlc2VudCB0aGUgZGV2aWNlcyAndmlzaWJsZScgZm9yIHRoaXMKPj4gbmFtZXNwYWNlLgo+IAo+
IFdlIGFjdHVhbGx5IGFscmVhZHkgaGF2ZSBhIGRldmljZXMgY2dyb3VwIHRoYXQgZG9lcyBzb21l
IG9mIHRoaXM6Cj4gCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvRG9jdW1lbnRhdGlvbi9j
Z3JvdXAtdjEvZGV2aWNlcy50eHQKPiAKSSBrbm93LiBCdXQgdGhpcyBlc3NlbnRpYWxseSBpcyBh
IGZpbHRlciBvbiAnL2Rldicgb25seSwgYW5kIG5lZWRzIHRvIGJlIApjb25maWd1cmVkLiBXaGlj
aCBtYWtlcyBpdCB2ZXJ5IHVud2llbGR5IHRvIHVzZS4KQW5kIHRoZSBjb250ZW50cyBvZiBzeXNm
cyBhcmUgbm90IG1vZGlmaWVkLCBzbyB0aGVyZSdzIGEgbWlzbWF0Y2ggCmJldHdlZW4gY29udGVu
dHMgaW4gL2RldiBhbmQgL3N5cy4KV2hpY2ggbWlnaHQgY2F1c2UgaXNzdWVzIHdpdGggbW9uaXRv
cmluZyB0b29scy4KCj4gSG93ZXZlciwgdmlzaWJpbGl0eSBpc24ndCB0aGUgb25seSBwcm9ibGVt
LCBmb3IgZGlyZWN0IHBhc3N0aHJvdWdoCj4gdGhlcmUncyBhbHNvIHVldmVudCBoYW5kbGluZyBh
bmQgcGVvcGxlIGhhdmUgZXZlbiBhc2tlZCBhYm91dCBtb2R1bGUKPiBsb2FkaW5nLgo+IApJIGFt
IGF3YXJlLCBhbmQgdGhhdCdzIGFub3RoZXIgcmVhc29uIHdoeSBkZXZpY2UgY2dyb3VwIGRvZXNu
J3QgY3V0IGl0LgoKPj4gICBJbml0aWFsbHkgdGhlIGRyaXZlcnMgd291bGQga2VlcCB0aGVpciBn
bG9iYWwgZW51bWVyYXRpb24sIGJ1dCBwbGFuCj4+IGlzIHRvIG1ha2UgdGhlIGRyaXZlcnMgbmFt
ZXNwYWNlLWF3YXJlLCB0b28sIHN1Y2ggdGhhdCBlYWNoIG5hbWVzcGFjZQo+PiBjb3VsZCBoYXZl
IGl0cyBvd24gZHJpdmVyLXNwZWNpZmljIGRldmljZSBlbnVtZXJhdGlvbi4KPiAKPiBJIHJlYWxs
eSB3b3VsZG4ndCBkbyB0aGlzLiAgTmFtZXNwYWNlL0Nncm91cCBzZXBhcmF0aW9uIHNob3VsZCBi
ZSBrZXB0Cj4gYXMgaGlnaCBhcyBwb3NzaWJsZS4gIElmIGl0IGxlYWtzIGludG8gdGhlIGRyaXZl
cnMgaXQgd2lsbCBiZWNvbWUKPiB1bm1haW50YWluYWJsZS4gIFdoeSBkbyB5b3UgdGhpbmsgeW91
IG5lZWQgdGhlIGRyaXZlcnMgdG8gYmUgYXdhcmU/ICBJZgo+IGl0J3MganVzdCBlbnVtZXJhdGlv
biwgdGhhdCBzaG91bGQgYWxsIGJlIGRvYWJsZSB3aXRoIHRoZSB2aXNpYmlsaXR5Cj4gZHJpdmVy
IHVubGVzcyB5b3Ugd2FudCB0byBkbyB0aGluZ3MgbGlrZSBjb21wYWN0IG51bWJlcmluZz8KPiAK
V2hpY2ggaXMgcHJlY2lzZWx5IHdoeSBJIG1lbnRpb25lZCBkZXZpY2UgbW9kaWZpY2F0aW9ucy4K
T24gYSBnZW5lcmljIGxldmVsIHdlIGNhbiBpbmZsdWVuY2UgdGhlIHZpc2liaWxpdHkgb2YgZGV2
aWNlcyBpbiAKcmVsYXRpb24gdG8gbmFtZXNwYWNlcywgd2UgY2Fubm90IGluZmx1ZW5jZSB0aGUg
ZGV2aWNlcyB0aGVtc2VsdmVzLgpUaGlzIHdpbGwgbGVhZCB0byBuYW1lc3BhY2VzIHNlZWluZyBk
aXNqdW5jdCBkZXZpY2UgbnVtYmVycyAoaWUgODowIGFuZCAKODo4IG9uIG5zIDEsIDg6NCBvbiBu
cyAyKS4gTm90IHRoYXQgSSB0aGluayB0aGF0IHdpbGwgYmUgYW4gaXNzdWUsIGJ1dCAKY2VydGFp
bmx5IGEgY2hhbmdlIGluIGJlaGF2aW91ci4KCj4+IEdvYWwgb2YgdGhpcyB0b3BpYyBpcyB0byBn
ZXQgYSBjb25zZW5zdXMgb24gd2hldGhlciBibG9jayBuYW1lc3BhY2VzCj4+IGFyZSBhIGZlYXR1
cmUgd2hpY2ggd291bGQgZmluZCBpbnRlcmVzdCwgYW5kIGFsc28gdG8gZGlzY3VzcyBzb21lCj4+
IGRlc2lnbiBkZXRhaWxzIGhlcmU6Cj4+IC0gT25seSBpbiBjZXJ0YWluIGNhc2VzIGNhbiBhIG5h
bWVzcGFjZSBiZSBhc3NpZ25lZCAoZWcgYnkgY2FsbGluZwo+PiAnbW9kcHJvYmUnLCBzdGFydGlu
ZyBpc2NzaWFkbSwgb3IgY2FsbGluZyBudm1lLWNsaSk7IGhvdyBkbyB3ZSBoYW5kbGUKPj4gZGV2
aWNlcyBmb3Igd2hpY2ggbm8gbmFtZXNwYWNlIGNhbiBiZSBpZGVudGlmaWVkPwo+PiAtIFNoYWxs
IHdlIGFsbG93IGZvciBkaWZmZXJlbnQgZGV2aWNlIGVudW1lcmF0aW9uIHBlciBuYW1lc3BhY2U/
Cj4+IC0gSW50byB3aGljaCBsZXZlbCBzaG91bGQgd2UgZ28gd2l0aCBoaWRpbmcgc3lzZnMgc3Ry
dWN0dXJlcz8KPj4gICAgSXMgYmxhbmtpbmcgb3V0IHRoZSBoaWdoZXItbGV2ZWwgaW50ZXJmYWNl
cyBpbiAvZGV2IGFuZCAvc3lzL2Jsb2NrCj4+ICAgIGVub3VnaD8KPiAKPiBGaXJzdCBxdWVzdGlv
biBpcyBkb2VzIHRoZSBkZXZpY2UgY2dyb3VwIGRvIGVub3VnaCBmb3IgeW91IGFuZCBpZiBub3QK
PiB3aGF0J3MgbWlzc2luZz8KPiAKU2VlIGFib3ZlLiBzeXNmcyBtb2RpZmljYXRpb25zIGFuZCB1
ZXZlbnQgZmlsdGVyaW5nIGFyZSBtaXNzaW5nLgpUaGlzIGluZnJhc3RydWN0dXJlIGZvciB0aGF0
IGlzIGFscmVhZHkgaW4gcGxhY2UgdGhhbmtzIHRvIG5ldHdvcmsgCm5hbWVzcGFjZXMsIHdlICdq
dXN0JyBuZWVkIHRvIG1ha2UgdXNlIG9mIGl0LgpBZGRpdGlvbmFsIGRyYXdiYWNrIGlzIHRoZSBt
YW51YWwgY29uZmlndXJhdGlvbiBvZiBkZXZpY2UtY2dyb3VwLgoKQ2hlZXJzLAoKSGFubmVzCi0t
IApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hp
dGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0
MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQw
OSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjog
RmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==

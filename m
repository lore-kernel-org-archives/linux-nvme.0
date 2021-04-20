Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F66AC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 17:03:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49681613AE
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 17:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49681613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+3PBJLiRnavWYCx4Umd8pzk7aDesxsSf72okH+5hvIU=; b=pwgXTVuDGC6RH7Et6QQZp+Il8
	mEEcNnZg3JCczio7txwM3q3XUOPSRHFEKAUtUpwItjcslFC6odezkvcwSCzUwdfCtQLqA7cy1WFBO
	tco1n+86ihW8f8B63hIV7TCsnsXU0XQEvIyBSqDS06DPCOdimYGI/UUXmzig2p2Bw1MgcUuRWxnrL
	NHC07O6Vs0xWDr6TdackGjuGAKJUADa1B3uVH/WH8BlPfS1YZNcg4xKgXSZLOre1P7cYALdwxRGl9
	WblDexjoHoJQ1yuy2nd5rPzS+DunR/CBqyky9GO5Asn5dpOSpnovAZx/hz3oSWaMRe63GcpAndLfY
	b5XVqHmYQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYtlq-00CfMs-F9; Tue, 20 Apr 2021 17:02:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYtlm-00CfMF-Gr
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 17:02:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=TXDz68jA0lV8HgkIuo0mEKHNOgqa7Z4n54dycAu2Uls=; b=4fQutKhDYoUDJw1emJvMuHCULv
 Ye94l5xICbG/REX5JJszPOs1zcBH36BrI4qghmlORX3J3ppHk4N3TPlqAjcTZof9eAlxr76LBPGlh
 AAIdGK0U3klDQoPyIDxbB+KQojGueTzD5EtrEn8f7Z8gQxrB70GcEvxKzJ0QYYKg1x/jCiAizTati
 fWil16Klg2PLOGgjqZ6zxsxwHtjGohacXKRajBJlvX5UxRovbamcEXerbVyvRDEkZo1VzbSkvwH4N
 TKKVwoT3ejUSRRLyCKrDX2CFEDE7vftyOok21CD1LxXwQm68vrRjf5Efgm9FM+RKbJzDsSTAptDYz
 VCjQ8phA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYtlj-00CIXW-Fs
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 17:02:37 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2451CAE5C;
 Tue, 20 Apr 2021 17:02:34 +0000 (UTC)
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Daniel Wagner <daniel.wagner@suse.de>
References: <20210416062411.47958-1-hare@suse.de>
 <20210420080527.GA21651@lst.de>
 <b5dc2cdf-fcb0-8ffc-8ea9-c77d32561043@suse.de>
 <20210420141436.GA14300@redsun51.ssa.fujisawa.hgst.com>
 <20210420143906.GA19417@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <73f1a5df-7d40-41ce-e6c5-42fd9fd3a2f1@suse.de>
Date: Tue, 20 Apr 2021 19:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210420143906.GA19417@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_100235_840131_E3C5A1C8 
X-CRM114-Status: GOOD (  28.27  )
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

T24gNC8yMC8yMSA0OjM5IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBUdWUsIEFw
ciAyMCwgMjAyMSBhdCAxMToxNDozNlBNICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4gT24g
VHVlLCBBcHIgMjAsIDIwMjEgYXQgMDM6MTk6MTBQTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdy
b3RlOgo+Pj4gT24gNC8yMC8yMSAxMDowNSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+
Pj4gT24gRnJpLCBBcHIgMTYsIDIwMjEgYXQgMDg6MjQ6MTFBTSArMDIwMCwgSGFubmVzIFJlaW5l
Y2tlIHdyb3RlOgo+Pj4+PiBXaXRoIHRoZSBwcm9wb3NlZCBwYXRjaCwgdGhlIGZvbGxvd2luZyBt
ZXNzYWdlcyBhcHBlYXI6Cj4+Pj4+Cj4+Pj4+ICAgIFsgIDIyNy41MTY4MDddIG1kL3JhaWQxOm1k
MDogRGlzayBmYWlsdXJlIG9uIG52bWUzbjEsIGRpc2FibGluZyBkZXZpY2UuCj4+Pj4+ICAgIFsg
IDIyNy41MTY4MDddIG1kL3JhaWQxOm1kMDogT3BlcmF0aW9uIGNvbnRpbnVpbmcgb24gMSBkZXZp
Y2VzLgo+Pj4+Cj4+Pj4gU28gaG93IGlzIHRoaXMgZ29pbmcgdG8gd29yayBmb3IgZS5nLiBhIGNh
c2Ugd2hlcmUgdGhlIGRldmljZQo+Pj4+IGRpc2FwcGVhciBkdWUgdG8gcmVzZXRzIG9yIGZhYnJp
Y3MgY29ubmVjdGlvbiBwcm9ibGVtcz8gIFRoaXMgbm93Cj4+Pj4gZGlyZWN0bHkgdGVhcmRzIGRv
d24gdGhlIGRldmljZS4KPj4+Pgo+Pj4gWWVzLCB0aGF0IGlzIGNvcnJlY3Q7IHRoZSBuc2hlYWQg
d2lsbCBiZSByZW1vdmVkIG9uY2UgdGhlIGxhc3QgcGF0aCBpcwo+Pj4gX3JlbW92ZWRfLgo+Pgo+
PiBUaGUgZW5kIHJlc3VsdCBpcyBhbHNvIGhvdyBub24tbXVsdGlwYXRoIG52bWUgYmVoYXZlcywg
c28gSSB0aGluayB0aGF0J3MKPj4gd2hhdCB1c2VycyBoYXZlIGNvbWUgdG8gZXhwZWN0Lgo+IAo+
IEknbSBub3Qgc3VyZSB0aGF0IGlzIHdoYXQgdXNlcnMgZXhwZWN0LiAgQXQgbGVhc3QgdGhlIFND
U0kgbXVsdGlwYXRoCj4gc2V0dXBzIEkndmUgd29ya2VkIGRvIG5vdCBleHBlY3QgaXQgYW5kIGVu
c3VyZSB0aGUgcXVldWVfaWZfbm9fcGF0aAo+IG9wdGlvbiBpcyBzZXQuCj4gClllcywgc3VyZS4g
QW5kIGFzIEkgc2FpZCwgSSdtIGhhcHB5IHRvIGltcGxlbWVudCB0aGlzIG9wdGlvbiBmb3IgTlZN
ZSwgdG9vLgpCdXQgdGhhdCBpcyBfbm90XyB3aGF0IHRoaXMgcGF0Y2ggaXMgYWJvdXQuCgpOVk1l
IHNpbmNlIGRheSBvbmUgaGFzIF9yZW1vdmVkXyB0aGUgbmFtZXNwYWNlIGlmIHRoZSBjb250cm9s
bGVyIGdvZXMgCmF3YXkgKGllIGlmIHlvdSBkbyBhIFBDSSBob3RwbHVnKS4gU28gY3VzdG9tZXIg
cmlnaHRseSBleHBlY3RzIHRoaXMgCmJlaGF2aW91ciB0byBjb250aW51ZS4KCkFuZCB0aGlzIGlz
IHdoYXQgdGhlIHBhdGNoIGRvZXM7IF9hbGlnbmluZ18gdGhlIGJlaGF2aW91ciBmcm9tIAptdWx0
aXBhdGhlZCB0byBub24tbXVsdGlwYXRoZWQgY29udHJvbGxlcnMgd2hlbiB0aGUgbGFzdCBwYXRo
IGlzIGdvbmUuCgpOb24tbXVsdGlwYXRoZWQgKGllIENNSUM9PTApIGNvbnRyb2xsZXJzIHdpbGwg
cmVtb3ZlIHRoZSBuYW1lc3BhY2Ugb25jZSAKdGhlIGxhc3QgX3JlZmVyZW5jZV8gdG8gdGhhdCBu
YW1lc3BhY2UgZHJvcHMgKGllIHRoZSBQQ0kgaG90cGx1ZyBjYXNlKS4KTXVsdGlwYXRoZWQgKGll
IENNSUMhPTApIGNvbnRyb2xsZXJzIHdpbGwgcmVtb3ZlIHRoZSBuYW1lc3BhY2Ugb25jZSB0aGUg
Cmxhc3QgX29wZW5lcl8gZ29lcyBhd2F5LgpUaGUgcmVmY291bnQgaXMgbG9uZyBnb25lIGJ5IHRo
YXQgdGltZS4KCj4+PiBCdXQga2V5IHBvaW50IGhlcmUgaXMgdGhhdCBvbmNlIHRoZSBzeXN0ZW0g
ZmluZHMgaXRzZWxmIGluIHRoYXQKPj4+IHNpdHVhdGlvbiBpdCdzIGltcG9zc2libGUgdG8gcmVj
b3ZlciwgYXMgdGhlIHJlZmNvdW50cyBhcmUgbWVzc2VkLgo+Pj4gRXZlbiBhIG1hbnVhbCBjb25u
ZWN0IGNhbGwgd2l0aCB0aGUgc2FtZSBwYXJhbWV0ZXIgd2lsbCBfbm90XyByZXN0b3JlCj4+PiBv
cGVyYXRpb24sIGJ1dCByYXRoZXIgcmVzdWx0IGluIGEgbmV3IG5hbWVzcGFjZS4KPj4KPj4gSSBo
YXZlbid0IGxvb2tlZCBhdCB0aGlzIHlldCwgYnV0IGlzIGl0IHJlYWxseSBub3QgcG9zc2libGUg
dG8gcmVzdG9yZQo+PiB0aGUgb3JpZ2luYWwgbmFtZXNwYWNlIHVwb24gdGhlIHJlZXN0YWJsaXNo
ZWQgY29ubmVjdGlvbj8KPiAKPiBJdCBpcyBwb3NzaWJsZSwgYW5kIGluIGZhY3QgaXMgd2hhdCB3
ZSBkby4KPiAKSXQgaXMgX25vdF8gb25jZSB0aGUgbmFtZXNwYWNlIGlzIG1vdW50ZWQuCk9yIE1E
IGhhcyBjbGFpbWVkIHRoZSBkZXZpY2UuCkFuZCB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSByZWZj
b3VudCBhbHJlYWR5IF9pc18gemVybywgc28gd2UgYXJlIAphbHJlYWR5IGluIHRlYXJkb3duLiBX
ZSdyZSBqdXN0IHdhaXRpbmcgZm9yIHRoZSByZWZlcmVuY2UgdG8gdGhlIGdlbmRpc2sgCnRvIGRy
b3AuCldoaWNoIGlzIG5ldmVyIHdpbGwsIGFzIHdlIHdvdWxkIGhhdmUgdG8gdW1vdW50IChvciBk
ZXRhY2gpIHRoZSBkZXZpY2UgCmZvciB0aGF0LCBidXQgSS9PIGlzIHN0aWxsIHBlbmRpbmcgd2hp
Y2ggY2Fubm90IGJlIGZsdXNoZWQsIHNvIHRoYXQnbGwgZmFpbC4KQW5kIGlmIHdlIHRyeSB0byBj
b25uZWN0IHRoZSBzYW1lIG5hbWVzcGFjZSBhZ2FpbiwgbnZtZV9maW5kX25zX2hlYWQoKSAKd2ls
bCBub3QgcmV0dXJuIHRoZSBleGlzdGluZyBuc19oZWFkIGFzIHRoZSByZWZjb3VudCBpcyB6ZXJv
LgpDYXVzaW5nIGEgbmV3IG5zX2hlYWQgdG8gYmUgY3JlYXRlZC4KCklmIHlvdSBtYW5hZ2UgdG8g
Z2V0IHRoaXMgd29ya2luZyB3aXRoIHRoZSBjdXJyZW50IGNvZGUgcGxlYXNlIHNob3cgbWUgCmZy
b20gdGhlIHRlc3RjYXNlIGluIHRoZSBkZXNjcmlwdGlvbiB3aGF0IHdlIHNob3VsZCBoYXZlIGRv
bmUgZGlmZmVyZW50bHkuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2Ug
ICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkg
KEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D1AC4743C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:06:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC5461153
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC5461153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=knownhost.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5JlGaBXTS8HVxwd3ajo0Qaoh2EVyr2v9iKLUo1tKbc=; b=U3kfy0XeSB8Flku0TlKJUYPsxl
	txJqxK20RnecxZxZNAtAoycIsX36ncG21Rd7EtOirMQKvsUBx01B78JmIuRv/N+kMuxLQBh5yoo6L
	5w/Gtok/BTdUWbUN5WOSuhTF+31oxWukFvv49DCVK84LUOzw64FNzD/prKRnXeDwH5G2lYFCzDjgN
	R7ezMtOfMg6tsek2i+5TqSDflqfAG740UtzbL3bocD0w5iP4wDV/OyN+t6gXHjoQn0ZZIUXqUS4TC
	IHIsllVLYDXVyJqiz2uBmHMxFhaAZhTouiXJ4e8+6tSH0kewtlta0CZ2fO/hWFSY05Uk5OPdOrlPg
	lIfO+WPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvMRS-0041g8-K5; Mon, 21 Jun 2021 16:06:30 +0000
Received: from core.knownhost.net ([67.222.0.2])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvMRP-0041eo-6Y
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 16:06:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=knownhost.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8lw7gMrb7LQeidTCBzazxvMkB5tTzKlUbAnsmCc4m8I=; b=Ckk5niNFio0lOEuIcOgm8c8CuJ
 331BucEMSGLoJCnJ3KbcAPSqhdGCLAT9cSp3TTWWHA4esEDoZChIbKXLSqobnmtXJj3IHND7SWIom
 uOp7/jawz1oJZN6MzJi8p7sS9LpzsMc2ceWdEZkH1ZxMLRe/FXWUebXkEhOMtKonOrFvYkArWmgnu
 DFvjICh0pky2ArFOCR6lA/hRSVDro+ZC/z9jP9vvcZvtBUxHfdzgdnyKVoBSPCWhVsDp6/tRCh7NE
 7qO3hHLj0YN/mShZIfIQc4yq8KpjPCtX5kzN3WHZBJydrF/AK7CEXpbwfRo3WJsQyYr+zWjuA4z53
 HdRN8RIQ==;
Received: from [192.251.128.16] (port=63544
 helo=jon-office.noc.al.privatesystems.net)
 by core.knownhost.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <jonathan@knownhost.com>)
 id 1lvMRO-0002Wt-K2; Mon, 21 Jun 2021 12:06:26 -0400
Subject: Re: nvmeof Issues with Zen 3/Ryzen 5000 Initiator
From: Jonathan Wright <jonathan@knownhost.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shiraz Saleem <shiraz.saleem@intel.com>, tatyana.e.nikolova@intel.com,
 mustafa.ismail@intel.com
References: <ffae89d5-05d8-e0a4-ca71-b3db18f70286@knownhost.com>
 <39fabb5d-537c-febf-a538-ff6215777da5@grimberg.me>
 <69f0c4b6-c890-ef25-ddae-6d15d38881e0@knownhost.com>
 <06ac1cd6-a53d-a976-5779-07647c043e8b@knownhost.com>
Message-ID: <f2d12959-3d03-83a6-4c4c-2603e4a7b612@knownhost.com>
Date: Mon, 21 Jun 2021 11:06:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <06ac1cd6-a53d-a976-5779-07647c043e8b@knownhost.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - core.knownhost.net
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - knownhost.com
X-Get-Message-Sender-Via: core.knownhost.net: authenticated_id:
 jonathan@knownhost.com
X-Authenticated-Sender: core.knownhost.net: jonathan@knownhost.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_090627_350326_BF4C712B 
X-CRM114-Status: GOOD (  16.05  )
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

QWRkaW5nIE5pa29sb3ZhLCBUYXR5YW5hIEUgYW5kIElzbWFpbCwgTXVzdGFmYSB0byBDQyBwZXIg
YXV0by1yZXNwb25kZXIgCmZyb20gQFNoaXJhei4KCk9uIDYvMjEvMjEgMTE6MDQgQU0sIEpvbmF0
aGFuIFdyaWdodCB3cm90ZToKPgo+IE9uIDYvMy8yMSAxMTo1NyBBTSwgSm9uYXRoYW4gV3JpZ2h0
IHdyb3RlOgo+Pgo+Pj4+IEkndmUgYmVlbiB0ZXN0aW5nIE5WTWUgb3ZlciBGYWJyaWNzIGZvciB0
aGUgcGFzdCBmZXcgd2Vla3MgYW5kIHRoZSAKPj4+PiBwZXJmb3JtYW5jZSBoYXMgYmVlbiBub3Ro
aW5nIHNob3J0IG9mIGluY3JlZGlibGUsIHRob3VnaCBJJ20gCj4+Pj4gcnVubmluZyBpbnRvIHNv
bWUgbWFqb3IgaXNzdWVzIHRoYXQgc2VlbXMgdG8gYmUgc3BlY2lmaWNhbGx5IAo+Pj4+IHJlbGF0
ZWQgdG8gQU1EIFplbiAzIFJ5emVuIGNoaXBzIChpbiBteSBjYXNlIEknbSB0ZXN0aW5nIHdpdGgg
NTkwMHgpLgo+Pj4+Cj4+Pj4gVGFyZ2V0Ogo+Pj4+IFN1cGVybWljcm8gWDEwIGJvYXJkCj4+Pj4g
WGVvbiBFNS0yNjIwdjQKPj4+PiBJbnRlbCBFODEwIE5JQwo+Pj4+Cj4+Pj4gUHJvYmxlbWF0aWMg
Q2xpZW50L2luaXRpYXRvcjoKPj4+PiBBU1JvY2sgWDU3MCBib2FyZAo+Pj4+IFJ5emVuIDkgNTkw
MHgKPj4+PiBJbnRlbCBFODEwIE5JQwo+Pj4+Cj4+Pj4gU3RhYmxlIENsaWVudC9pbml0aWF0b3I6
Cj4+Pj4gU3VwZXJtaWNybyBYMTAgYm9hcmQKPj4+PiBYZW9uIEU1LTI2MjB2NAo+Pj4+IEludGVs
IEU4MTAgTklDCj4+Pj4KPj4+PiBJJ20gdXNpbmcgdGhlIHNhbWUgMiBFODEwIE5JQ3MgYW5kIHBh
aXIgb2YgMjVHIERBQ3MgaW4gYm90aCBjYXNlcy7CoCAKPj4+PiBUaGUgTklDcyBhcmUgZGlyZWN0
bHkgY29ubmVjdGVkIHdpdGggdGhlIERBQ3MgYW5kIHRoZXJlIGlzIG5vIAo+Pj4+IHN3aXRjaCBp
biB0aGUgZXF1YXRpb24uwqAgVG8gdHJpZ2dlciB0aGUgaXNzdWUgSSdtIHNpbXBseSB1c2luZyBG
SU8gCj4+Pj4gc2ltaWxhciB0byB0aGlzOgo+Pj4+Cj4+Pj4gZmlvIC0tcmFuZHJlcGVhdD0xIC0t
aW9lbmdpbmU9bGliYWlvIC0tZGlyZWN0PTEgLS1ndG9kX3JlZHVjZT0xIAo+Pj4+IC0tbmFtZT10
ZXN0IC0tZmlsZW5hbWU9L2Rldi9udm1lMG4xIC0tYnM9NGsgLS1pb2RlcHRoPTY0IC0tc2l6ZT0x
MEcgCj4+Pj4gLS1yZWFkd3JpdGU9cmFuZHJlYWQgLS10aW1lX2Jhc2VkIC0tcnVudGltZT0xMjAw
Cj4+Pj4KPj4+PiBJJ20gcHJpbWFyaWx5IHVzaW5nIFJETUEvaVdBUlAgcmlnaHQgbm93IGJ1dCBJ
J3ZlIGFsc28gdGVzdGVkIFJvQ0UyIAo+Pj4+IHdoaWNoIHByZXNlbnRzIHRoZSBzYW1lIGlzc3Vl
cy9zeW1wdG9tcy4gUHJpbWFyeSB0ZXN0aW5nIGhhcyBiZWVuIAo+Pj4+IGRvbmUgd2l0aCBVYnVu
dHUgMjAuMDQuMiB3aXRoIENlbnRPUyA4IGluIHRoZSBtaXggYXMgd2VsbCBqdXN0IHRvIAo+Pj4+
IHRyeSBhbmQgcnVsZSBvdXQgYSB3ZWlyZCBkaXN0cm8tc3BlY2lmaWMgaXNzdWUuIEFsbCB0ZXN0
cyB1c2VkIHRoZSAKPj4+PiBsYXRlc3QgaWNlL2lyZG1hIGRyaXZlcnMgZnJvbSBJbnRlbCAoMS41
LjggYW5kIDEuNS4yIHJlc3BlY3RpdmVseSkKPj4+Cj4+PiBDQ2luZyBTaGlyYXogU2FsZWVtIHdo
byBtYWludGFpbnMgaXJkbWEuCj4+Cj4+IFRoYW5rcy7CoCBJJ3ZlIGRvbmUgc29tZSB0ZXN0aW5n
IG5vdyB3aXRoIE1lbGxhbm94IENvbm5lY3RYLTQgY2FyZHMgCj4+IHdpdGggWmVuIDMgYW5kIHRo
ZSBpc3N1ZSBkb2VzIG5vdCBleGlzdC7CoCBUaGlzIHNlZW1zIHRvIHBvaW50IHRoZSAKPj4gZmlu
Z2VyIHRvIHNvbWV0aGluZyBzcGVjaWZpYyBiZXR3ZWVuIGlyZG1hIGFuZCBaZW4gMi8zIHNpbmNl
IAo+PiBpcmRtYS9FODEwIHdvcmtzIGZpbmUgb24gYWxsLUludGVsIGhhcmR3YXJlLsKgIEkgdGVz
dGVkIHRoZSBNZWxsYW5veCAKPj4gb24gYm90aCBVYnVudHUgMjAuMDQgc3RvY2sga2VybmVsICg1
LjQpIGFuZCBDZW50T1MgOC4zIChzdG9jayBrZXJuZWwgCj4+IDQuMTgpIGFzIEkgdGVzdGVkIHRo
ZSBFODEwIG9uIHRoZXNlIGNvbWJpbmF0aW9ucy4KPj4KPj4gRnVydGhlciBJIHRlc3RlZCBhbiBB
TUQgdGFyZ2V0IHdpdGggYW4gSW50ZWwgaW5pdGlhdG9yIGFuZCB0aGUgaXNzdWUgCj4+IHN0aWxs
IGV4aXN0cyBzbyBpdCBkb2Vzbid0IHNlZW0gdG8gbWF0dGVyIHdoaWNoIGVuZCB0aGUgWmVuIDMg
KGFuZC9vciAKPj4gWmVuMikgY2hpcCBpcyBvbiB3aGVuIHBhaXJlZCB3aXRoIGFuIEU4MTAvaXJk
bWEuCj4+Cj4+IFRoZSBpc3N1ZSBhbHNvIGV4aXN0cyB3aXRoIFplbiAyIChSeXplbiAzNjAwKS4K
Pj4KPj4gQFNocmlheiBzaW5jZSBJIGd1ZXNzIHRoaXMgaXNuJ3QgYSBjb21tb24gc2V0dXAgcmln
aHQgbm93IGxldCBtZSBrbm93IAo+PiBpZiBJIGNhbiBiZSBvZiBhbnkgYXNzaXN0YW5jZSB3aXRo
IGdldHRpbmcgdG8gdGhlIGJvdHRvbSBvZiB0aGlzIAo+PiBzZWVtaW5nIGluY29tcGF0aWJpbGl0
eS4KPgo+IEBJbnRlbCBpcyB0aGVyZSBhbnkgZGVzaXJlIHRvIGZpeCB0aGlzIGN1cnJlbnRseT/C
oCBJJ2xsIGJlIHNlbmRpbmcgCj4gdGhpcyBjdXJyZW50IGxhYiBlcXVpcG1lbnQgd2l0aCB0aGUg
WmVuMyBzeXN0ZW1zIHRvIG90aGVyIHRhc2tzIHNvb24gCj4gYW5kIHdpbGwgbm8gbG9uZ2VyIGJl
IGFibGUgdG8gaGVscCB0cm91Ymxlc2hvb3Qgb3IgdGVzdC4gV2l0aG91dCBhIGZpeCAKPiB3ZSds
bCBoYXZlIHRvIGxvb2sgaW50byBvdGhlciB2ZW5kb3JzIGZvciBmYWJyaWMgc2V0dXBzLgo+Ci0t
IApKb25hdGhhbiBXcmlnaHQKS25vd25Ib3N0LCBMTEMKaHR0cHM6Ly93d3cua25vd25ob3N0LmNv
bQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

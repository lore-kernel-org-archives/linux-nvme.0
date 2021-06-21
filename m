Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9326FC4743C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0D760724
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0D760724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=knownhost.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w0S/JsfGT6SnXy6Z3DKptCNa+PQ/aoIQ89SYLxp4cR8=; b=UdtSt5NPdC8agwOVnxJdWYWpPs
	aKp4oYcspUeKaeoBB7K1+7BNtAW2aTm1joYw+LPFnZl9T6wuqQ7N0ZWD/7TJWSIRazlHSN/GAC1ch
	5i1euSRsZk5MxH4JeKHQQ8d+lW3CW5xCtg0ZjcpPgFcvUqPLJ2zcC+zQNcct7q+ysh6tsTqNQfOYI
	KHWi4IuVnkqZMBvY8JB9S5tnQ1VnM1M4rrWYuZJbtAXGqZtGr8Xjhz0MHEmtZxOv+Vm6f6hAoys+w
	u7qqkljAPO5FGIgOOE83WrDfFPnfT8GpZnE475G5yQCPt+VeQPFSJ6Jyzi/usw0GF688AXGgf4KPW
	Wy2ewfGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvMPf-0041FE-56; Mon, 21 Jun 2021 16:04:39 +0000
Received: from core.knownhost.net ([67.222.0.2])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvMPd-0041Cs-02
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 16:04:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=knownhost.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7TTBkq7+PlhS7+7RNIDv/wrRXDV2adbLaAK0WnyIFgk=; b=tlh6/sRKU9B/eAxoFHTfbCNuLl
 20DDRAYYQCvsQPgMQnfc5LJMXkApTuGteOBN0XFT2Vc3aADN76j14PbqbECg601YlMosWZBpiXaxg
 DOlOjo7LwNDWq2T4MNBrg3JXtxW1GF5npqGXnvaFnivRX1xvll4YtdkyzrlCLQLSQNuNmMiQXvnmb
 OfMfVl/9ypVayDZu8e9ePwruZl6+FQ9k8j+LmBXXVjbln1sdUigaOzDe1m5clUUj68nQUb3yVJ2SL
 KRLsqyq50ARTtvPNXEvAT+xBAOVMtgsOnLWhkKe/U8lWZ4YHK14WmSnqF4wYVt31JFeoWXwadf8Nn
 Qla7NmWA==;
Received: from [192.251.128.16] (port=50020
 helo=jon-office.noc.al.privatesystems.net)
 by core.knownhost.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <jonathan@knownhost.com>)
 id 1lvMPZ-0002M5-D3; Mon, 21 Jun 2021 12:04:33 -0400
Subject: Re: nvmeof Issues with Zen 3/Ryzen 5000 Initiator
From: Jonathan Wright <jonathan@knownhost.com>
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shiraz Saleem <shiraz.saleem@intel.com>
References: <ffae89d5-05d8-e0a4-ca71-b3db18f70286@knownhost.com>
 <39fabb5d-537c-febf-a538-ff6215777da5@grimberg.me>
 <69f0c4b6-c890-ef25-ddae-6d15d38881e0@knownhost.com>
Message-ID: <06ac1cd6-a53d-a976-5779-07647c043e8b@knownhost.com>
Date: Mon, 21 Jun 2021 11:04:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <69f0c4b6-c890-ef25-ddae-6d15d38881e0@knownhost.com>
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
X-CRM114-CacheID: sfid-20210621_090437_148270_3E86511B 
X-CRM114-Status: GOOD (  17.31  )
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

Ck9uIDYvMy8yMSAxMTo1NyBBTSwgSm9uYXRoYW4gV3JpZ2h0IHdyb3RlOgo+Cj4+PiBJJ3ZlIGJl
ZW4gdGVzdGluZyBOVk1lIG92ZXIgRmFicmljcyBmb3IgdGhlIHBhc3QgZmV3IHdlZWtzIGFuZCB0
aGUgCj4+PiBwZXJmb3JtYW5jZSBoYXMgYmVlbiBub3RoaW5nIHNob3J0IG9mIGluY3JlZGlibGUs
IHRob3VnaCBJJ20gcnVubmluZyAKPj4+IGludG8gc29tZSBtYWpvciBpc3N1ZXMgdGhhdCBzZWVt
cyB0byBiZSBzcGVjaWZpY2FsbHkgcmVsYXRlZCB0byBBTUQgCj4+PiBaZW4gMyBSeXplbiBjaGlw
cyAoaW4gbXkgY2FzZSBJJ20gdGVzdGluZyB3aXRoIDU5MDB4KS4KPj4+Cj4+PiBUYXJnZXQ6Cj4+
PiBTdXBlcm1pY3JvIFgxMCBib2FyZAo+Pj4gWGVvbiBFNS0yNjIwdjQKPj4+IEludGVsIEU4MTAg
TklDCj4+Pgo+Pj4gUHJvYmxlbWF0aWMgQ2xpZW50L2luaXRpYXRvcjoKPj4+IEFTUm9jayBYNTcw
IGJvYXJkCj4+PiBSeXplbiA5IDU5MDB4Cj4+PiBJbnRlbCBFODEwIE5JQwo+Pj4KPj4+IFN0YWJs
ZSBDbGllbnQvaW5pdGlhdG9yOgo+Pj4gU3VwZXJtaWNybyBYMTAgYm9hcmQKPj4+IFhlb24gRTUt
MjYyMHY0Cj4+PiBJbnRlbCBFODEwIE5JQwo+Pj4KPj4+IEknbSB1c2luZyB0aGUgc2FtZSAyIEU4
MTAgTklDcyBhbmQgcGFpciBvZiAyNUcgREFDcyBpbiBib3RoIGNhc2VzLsKgIAo+Pj4gVGhlIE5J
Q3MgYXJlIGRpcmVjdGx5IGNvbm5lY3RlZCB3aXRoIHRoZSBEQUNzIGFuZCB0aGVyZSBpcyBubyBz
d2l0Y2ggCj4+PiBpbiB0aGUgZXF1YXRpb24uwqAgVG8gdHJpZ2dlciB0aGUgaXNzdWUgSSdtIHNp
bXBseSB1c2luZyBGSU8gc2ltaWxhciAKPj4+IHRvIHRoaXM6Cj4+Pgo+Pj4gZmlvIC0tcmFuZHJl
cGVhdD0xIC0taW9lbmdpbmU9bGliYWlvIC0tZGlyZWN0PTEgLS1ndG9kX3JlZHVjZT0xIAo+Pj4g
LS1uYW1lPXRlc3QgLS1maWxlbmFtZT0vZGV2L252bWUwbjEgLS1icz00ayAtLWlvZGVwdGg9NjQg
LS1zaXplPTEwRyAKPj4+IC0tcmVhZHdyaXRlPXJhbmRyZWFkIC0tdGltZV9iYXNlZCAtLXJ1bnRp
bWU9MTIwMAo+Pj4KPj4+IEknbSBwcmltYXJpbHkgdXNpbmcgUkRNQS9pV0FSUCByaWdodCBub3cg
YnV0IEkndmUgYWxzbyB0ZXN0ZWQgUm9DRTIgCj4+PiB3aGljaCBwcmVzZW50cyB0aGUgc2FtZSBp
c3N1ZXMvc3ltcHRvbXMuwqAgUHJpbWFyeSB0ZXN0aW5nIGhhcyBiZWVuIAo+Pj4gZG9uZSB3aXRo
IFVidW50dSAyMC4wNC4yIHdpdGggQ2VudE9TIDggaW4gdGhlIG1peCBhcyB3ZWxsIGp1c3QgdG8g
Cj4+PiB0cnkgYW5kIHJ1bGUgb3V0IGEgd2VpcmQgZGlzdHJvLXNwZWNpZmljIGlzc3VlLiBBbGwg
dGVzdHMgdXNlZCB0aGUgCj4+PiBsYXRlc3QgaWNlL2lyZG1hIGRyaXZlcnMgZnJvbSBJbnRlbCAo
MS41LjggYW5kIDEuNS4yIHJlc3BlY3RpdmVseSkKPj4KPj4gQ0NpbmcgU2hpcmF6IFNhbGVlbSB3
aG8gbWFpbnRhaW5zIGlyZG1hLgo+Cj4gVGhhbmtzLsKgIEkndmUgZG9uZSBzb21lIHRlc3Rpbmcg
bm93IHdpdGggTWVsbGFub3ggQ29ubmVjdFgtNCBjYXJkcyAKPiB3aXRoIFplbiAzIGFuZCB0aGUg
aXNzdWUgZG9lcyBub3QgZXhpc3QuwqAgVGhpcyBzZWVtcyB0byBwb2ludCB0aGUgCj4gZmluZ2Vy
IHRvIHNvbWV0aGluZyBzcGVjaWZpYyBiZXR3ZWVuIGlyZG1hIGFuZCBaZW4gMi8zIHNpbmNlIAo+
IGlyZG1hL0U4MTAgd29ya3MgZmluZSBvbiBhbGwtSW50ZWwgaGFyZHdhcmUuwqAgSSB0ZXN0ZWQg
dGhlIE1lbGxhbm94IG9uIAo+IGJvdGggVWJ1bnR1IDIwLjA0IHN0b2NrIGtlcm5lbCAoNS40KSBh
bmQgQ2VudE9TIDguMyAoc3RvY2sga2VybmVsIAo+IDQuMTgpIGFzIEkgdGVzdGVkIHRoZSBFODEw
IG9uIHRoZXNlIGNvbWJpbmF0aW9ucy4KPgo+IEZ1cnRoZXIgSSB0ZXN0ZWQgYW4gQU1EIHRhcmdl
dCB3aXRoIGFuIEludGVsIGluaXRpYXRvciBhbmQgdGhlIGlzc3VlIAo+IHN0aWxsIGV4aXN0cyBz
byBpdCBkb2Vzbid0IHNlZW0gdG8gbWF0dGVyIHdoaWNoIGVuZCB0aGUgWmVuIDMgKGFuZC9vciAK
PiBaZW4yKSBjaGlwIGlzIG9uIHdoZW4gcGFpcmVkIHdpdGggYW4gRTgxMC9pcmRtYS4KPgo+IFRo
ZSBpc3N1ZSBhbHNvIGV4aXN0cyB3aXRoIFplbiAyIChSeXplbiAzNjAwKS4KPgo+IEBTaHJpYXog
c2luY2UgSSBndWVzcyB0aGlzIGlzbid0IGEgY29tbW9uIHNldHVwIHJpZ2h0IG5vdyBsZXQgbWUg
a25vdyAKPiBpZiBJIGNhbiBiZSBvZiBhbnkgYXNzaXN0YW5jZSB3aXRoIGdldHRpbmcgdG8gdGhl
IGJvdHRvbSBvZiB0aGlzIAo+IHNlZW1pbmcgaW5jb21wYXRpYmlsaXR5LgoKQEludGVsIGlzIHRo
ZXJlIGFueSBkZXNpcmUgdG8gZml4IHRoaXMgY3VycmVudGx5P8KgIEknbGwgYmUgc2VuZGluZyB0
aGlzIApjdXJyZW50IGxhYiBlcXVpcG1lbnQgd2l0aCB0aGUgWmVuMyBzeXN0ZW1zIHRvIG90aGVy
IHRhc2tzIHNvb24gYW5kIHdpbGwgCm5vIGxvbmdlciBiZSBhYmxlIHRvIGhlbHAgdHJvdWJsZXNo
b290IG9yIHRlc3QuwqAgV2l0aG91dCBhIGZpeCB3ZSdsbCAKaGF2ZSB0byBsb29rIGludG8gb3Ro
ZXIgdmVuZG9ycyBmb3IgZmFicmljIHNldHVwcy4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==

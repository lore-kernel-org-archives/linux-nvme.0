Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2367C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 03:02:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2B561100
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 03:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E2B561100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oaPLSTuUw2uW16105xSpEgu8sx8W1cwVhQBJXXmgy6c=; b=VAGJTBTWyVkoJZ
	8uFMfnQcEDKjEuHArv8yqVlS5zzW402L4ngQp4VlTNzDxTYriwakg7wYmitXXNZFHLvh+6LlKXcoL
	EtiskLod2pLujLfy72GjmblvUqQwa3H1i31EL/Z8iDx8zdUCBpC8rNT+zEGV5cMG7lBw6IKu1SOrK
	vlJxak/K6EpsqwB+8Od8psqN46dgZJTIZpo2Ey326aRmH2yETFKSAPUlc3GY6sDwLBoO4vn7jhfPo
	Quj4Vf1IHQOSizvWeIRh4TbuNbiSHG0o0ORK5o2xGd5yq7U0GehIlDSP7s2NEQtDyR4QFmvBTZQrw
	7cmElkV0zk2NtVa3qQbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTxxB-00G2Bz-Gy; Sat, 25 Sep 2021 03:02:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTxx8-00G2Bf-9O
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 03:02:15 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B258610F7;
 Sat, 25 Sep 2021 03:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632538933;
 bh=3PfLjJcrU+N5TIWxBbDCx4xiSZdcU3zGcOvxWtEf+TE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fFjQO/5U5KOZwJUQlk6qyVG/DDOjBzItYFa+wJuuvBzERCkpFaJuXBmIudLDGwb6U
 sn43zJTqarg/0N+lw+y9bKujxDCgoTnKFCjBK0IkBVMWZXsHZH+OSqIw7I1NDUYprp
 IZy/LBn0R93z/bsg4ESOIf7LjRcPRdW4/fN3eruF6GZKS6kJdU4SlEA3dem2a/Em73
 1ii2EnNEqb/lUaIlHCk+wEA62XkwLu/OT1/zlsD2/PmBQpLwsIGFPPrks4FFQuCfFg
 wFUUZWKpat1SjDfHD8WZ+Wjkl7uAZiGAtHJkNptaU8b2YVaWcMGGkyKSM5r2y1LEjv
 hDEddNO+cROAA==
Date: Sat, 25 Sep 2021 12:02:07 +0900
From: Keith Busch <kbusch@kernel.org>
To: Andrey Nikitin <nikitina@amazon.com>
Cc: linux-nvme@lists.infradead.org, benh@kernel.crashing.org,
 davebuch@amazon.com
Subject: Re: [RFC PATCH 0/3] nvme sq associations
Message-ID: <20210925030207.GA20848@redsun51.ssa.fujisawa.hgst.com>
References: <20210924210809.14536-1-nikitina@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210924210809.14536-1-nikitina@amazon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210924_200214_367242_D049EBE0 
X-CRM114-Status: GOOD (  16.42  )
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

T24gRnJpLCBTZXAgMjQsIDIwMjEgYXQgMDk6MDg6MDZQTSArMDAwMCwgQW5kcmV5IE5pa2l0aW4g
d3JvdGU6Cj4gVGhlIE5WTWUgc3BlY2lmaWNhdGlvbiBhbGxvd3MgZm9yIG5hbWVzcGFjZXMgd2l0
aCBkaWZmZXJlbnQgcGVyZm9ybWFuY2UKPiBjaGFyYWN0ZXJpc3RpY3MsIGFzIHdlbGwgYXMgYWxs
b3dpbmcgSU9zIHN1Ym1pc3Npb25zIHRvIGFueSBuYW1lc3BhY2UgdmlhCj4gYW55IG5vbi1lbXB0
eSBzdWJtaXNzaW9uIHF1ZXVlLiBIb3dldmVyLCBzaGFyaW5nIHF1ZXVlIHJlc291cmNlcyBiZXR3
ZWVuCj4gbmFtZXNwYWNlcyB3aXRoIGRpZmZlcmVudCBwZXJmb3JtYW5jZSBjaGFyYWN0ZXJpc3Rp
Y3MgY2FuIGNhdXNlIHVuZGVzaXJlZAo+IGJlaGF2aW9yIChlLmcuIGhlYWQtb2YtbGluZS1ibG9j
a2luZyBmb3IgSU9zIHRoYXQgdGFyZ2V0IGEgaGlnaC1wZXJmb3JtYW5jZQo+IG5hbWVzcGFjZSBi
ZWhpbmQgSU9zIHRoYXQgdGFyZ2V0IGEgbG93IHBlcmZvcm1hbmNlIG5hbWVzcGFjZSB2aWEgdGhl
IHNhbWUKPiBxdWV1ZSkuIEluIGFkZGl0aW9uLCB0aGUgbGFjayBvZiBoYXJkd2FyZSBxdWV1ZSBp
c29sYXRpb24gc3VwcG9ydCBjYW4gY2F1c2UKPiDigJxub2lzeSBuZWlnaGJvcuKAnSB0eXBlIHBy
b2JsZW1zIGZvciBhcHBsaWNhdGlvbnMgaXNzdWluZyBJT3MgdG8gZGlmZmVyZW50Cj4gbmFtZXNw
YWNlcyBvZiB0aGUgc2FtZSBjb250cm9sbGVyLiBUaGlzIHByb2JsZW0gbWF5IGJlIGVzcGVjaWFs
bHkgcHJvbm91bmNlZAo+IGluIG11bHRpLXRlbmFudCBlbnZpcm9ubWVudHMgc3VjaCBhcyB0aGUg
b25lcyBwcm92aWRlZCBieSBjbG91ZCBzZXJ2aWNlcy4KPiAKPiBUaGUgTlZNZSAxLjQgc3BlY2lm
aWNhdGlvbiBoYXMgaW50cm9kdWNlZCBzb21lIG9wdGlvbmFsIGZlYXR1cmVzIChOVk0gc2V0cwo+
IGFuZCBTUSBhc3NvY2lhdGlvbnMpIHRoYXQgY2FuIGJlIHV0aWxpemVkIHRvIGltcHJvdmUgdGhp
cyBzaXR1YXRpb24gcHJvdmlkZWQKPiB0aGVzZSBmZWF0dXJlcyBhcmUgc3VwcG9ydGVkIGJ5IGJv
dGggY29udHJvbGxlcnMgYW5kIGhvc3QgZHJpdmVycy4gTmFtZXNwYWNlcwo+IGNhbiBiZSBhc3Np
Z25lZCB0byBOVk0gc2V0cyAoYnkgcGVyZm9ybWFuY2UgY2hhcmFjdGVyaXN0aWNzLCBmb3IgZXhh
bXBsZSkKPiB3aGljaCBlYWNoIE5WTSBzZXQgaGF2aW5nIGl0cyBvd24gc2V0IG9mIGFzc29jaWF0
ZWQgcXVldWVzLgo+IAo+IFRoaXMgcGF0Y2ggc2VyaWVzIHByb3Bvc2VzIGEgc2ltcGxlIGltcGxl
bWVudGF0aW9uIG9mIE5WTSBzZXRzIGFuZAo+IFNRIGFzc29jaWF0aW9ucyBmb3IgdGhlIE5WTWUg
aG9zdCBQQ0kgbW9kdWxlLiAgQSBjb250cm9sbGVyIHRoYXQgc3VwcG9ydHMKPiB0aGVzZSBmZWF0
dXJlcywgYWxvbmcgd2l0aCBhIHN1ZmZpY2llbnQgbnVtYmVyIG9mIHF1ZXVlIHBhaXJzIChhdCBs
ZWFzdAo+IG9uZSBwZXIgTlZNIHNldCksIHdpbGwgaGF2ZSB0aGUgYXZhaWxhYmxlIHF1ZXVlIHBh
aXJzIGFzc29jaWF0ZWQgdW5pZm9ybWx5Cj4gYWNyb3NzIGVhY2ggTlZNIHNldC4gSU8gcmVxdWVz
dHMgZGlyZWN0ZWQgYXQgdGhlIGNvbnRyb2xsZXIgd2lsbCBob25vcgo+IHRoZSBuYW1lc3BhY2Uv
TlZNIHNldC9xdWV1ZSBhc3NvY2lhdGlvbiBieSB2aXJ0dWUgb2YgZWFjaCBOVk0gc2V0IGhhdmlu
Zwo+IGl0cyBvd24gYmxrLW1xIHRhZ3NldCBhc3NvY2lhdGVkIHdpdGggaXQuCgpEaWZmZXJlbnQg
c3VibWlzc2lvbiBxdWV1ZSBncm91cHMgcGVyIE5WTSBTZXQgc291bmRzIHJpZ2h0IGZvciB0aGlz
CmZlYXR1cmUsIGJ1dCBJJ20gbm90IHN1cmUgaXQgbWFrZXMgc2Vuc2UgZm9yIHRoZXNlIHRvIGhh
dmUgdGhlaXIgb3duCmNvbXBsZXRpb24gcXVldWVzOiBjb21wbGV0aW9ucyBmcm9tIGRpZmZlcmVu
dCBzZXRzIHdvdWxkIHRyeSB0byBzY2hlZHVsZQpvbiB0aGUgc2FtZSBDUFUuIEkgdGhpbmsgaXQg
c2hvdWxkIGJlIG1vcmUgZWZmaWNpZW50IHRvIGJyZWFrIHRoZSAxOjEKU1E6Q1EgcGFpcmluZywg
YW5kIGluc3RlYWQgaGF2ZSBhbGwgdGhlIFNRcyB3aXRoIHRoZSBzYW1lIENQVSBhZmZpbml0eQpz
aGFyZSBhIHNpbmdsZSBDUSBzbyB0aGF0IGNvbXBsZXRpb25zIGZyb20gZGlmZmVyZW50IG5hbWVz
cGFjZXMgY291bGQgYmUKaGFuZGxlZCBpbiBhIHNpbmdsZSBpbnRlcnJ1cHQuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

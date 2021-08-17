Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D236C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 17:02:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2CE60EB5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 17:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA2CE60EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GSw9uLlovdpQiqXRIPQf9I3LznAVJ20ie1OsE6wwFLw=; b=adm9OiQaJ0Kp3k
	/2kaYQrEM7QXVqSF98Ozu9KYSe+QR3QPw2CWw+rH6QW85QUSM9oRD82WV0MLPAbRSFcq3Rj8jtv/O
	FpyD2LIubedQ4LU8owgyVij6L9i6Qs7PoVH/ys6MvOk83xcOmA2sYIuA6/Et+LXg6hhvSXnWox7Mx
	zVLH1d0JHcGHvCqEu/9N9ASnDV6io11ipYtxTD6R/PpaMl6o3JoARdvfg6ProUEfUh28iLHcZrq3n
	n88L9GNpAX9XbUo39kzFxc13cq3enpz6rVjJ6igz9+zDd8BWgo2wi6e9LTMuCxbxQP+mywRXwvj8f
	+LbTTEVZgCfa9QQftluw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG2Tt-0035En-RI; Tue, 17 Aug 2021 17:02:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG2Tp-0035DD-Tj
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 17:02:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51C8460EB5;
 Tue, 17 Aug 2021 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629219744;
 bh=iMXJ2ZuXkc0VvET6phdIHtfJVRrX7KNyRwOMYfQWSjY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pG90qLWM0y3+P/nvw2oTT/2jkCLE14uE0ZVtMs9HeEI1ZUEZNOQIOaz9BP75jxaWe
 LbgBsEL7G5CnNSPwbXVI/aDgU6mTgGQwv5Vxx67JwvD2fHNBxL4rpgMqPykqC1mxjm
 GWTKZJ1nalVWGu94xKYBxzy8Wg16evZbx4Mk40DfAFQdRfNyMDOXw30zChhtC84F6p
 krDZeXE5xGXVWIT0fQmeRwa+m0NMWl9qDWrz6Biz+PPZ0j3Tpsq0x4nhwwHE6X5121
 VC60XyBeDWbyh4DaPd7Gc1TjOti1vnol0V+EiIUi4JA0y9w4wHEVtZ3km+yu6QSbHC
 hk7mggZAtsVmA==
Date: Tue, 17 Aug 2021 10:02:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
Message-ID: <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
 <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_100226_037423_087866ED 
X-CRM114-Status: GOOD (  20.78  )
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

T24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMDY6NTM6MTVQTSArMDIwMCwgUGF1bCBNZW56ZWwgd3Jv
dGU6Cj4gW2NjOiArRGVsbC5DbGllbnQuS2VybmVsQGRlbGwuY29tIGFzIGl04oCZcyBhIERlbGwg
ZGV2aWNlXQo+IEFtIDE3LjA4LjIxIHVtIDE4OjE2IHNjaHJpZWIgS2VpdGggQnVzY2g6Cj4gPiBP
biBUdWUsIEF1ZyAxNywgMjAyMSBhdCAwNToxMDo0MFBNICswMjAwLCBQYXVsIE1lbnplbCB3cm90
ZToKPiA+ID4gT24gYSBEZWxsIE9wdGlQbGV4IDc3ODAgQUlPLzA0RzQ3VyAoQklPUyAxLjYuMyAw
My8wOC8yMDIxKSBMaW51eCA1LjEwLjQ3Cj4gPiA+IHNob3dzIHRoZSB3YXJuaW5nIGJlbG93Ogo+
ID4gPiAKPiA+ID4gICAgICAkIGRtZXNnIHwgZ3JlcCBudm1lCj4gPiA+ICAgICAgWyAgICAzLjAx
NTM5Ml0gbnZtZSAwMDAwOjAyOjAwLjA6IHBsYXRmb3JtIHF1aXJrOiBzZXR0aW5nIHNpbXBsZSBz
dXNwZW5kCj4gPiA+ICAgICAgWyAgICAzLjAyMTg2MV0gbnZtZSBudm1lMDogcGNpIGZ1bmN0aW9u
IDAwMDA6MDI6MDAuMAo+ID4gPiAgICAgIFsgICAgMy4wMjY1OTNdIGFoY2kgMDAwMDowMDoxNy4w
OiB2ZXJzaW9uIDMuMAo+ID4gPiAgICAgIFsgICAgMy4wMjY5MjJdIGFoY2kgMDAwMDowMDoxNy4w
OiBBSENJIDAwMDEuMDMwMSAzMiBzbG90cyAxIHBvcnRzIDYgR2JwcyAweDEgaW1wbCBTQVRBIG1v
ZGUKPiA+ID4gICAgICBbICAgIDMuMDM1MDIwXSBhaGNpIDAwMDA6MDA6MTcuMDogZmxhZ3M6IDY0
Yml0IG5jcSBzbnRmIHBtIGNsbyBvbmx5IHBpbyBzbHVtIHBhcnQgZW1zIGRlc28gc2FkbSBzZHMg
YXBzdAo+ID4gPiAgICAgIFsgICAgMy4wMzUyMTldIG52bWUgbnZtZTA6IG1pc3Npbmcgb3IgaW52
YWxpZCBTVUJOUU4gZmllbGQuCj4gPiA+ICAgICAgWyAgICAzLjA0NDUxOF0gc2NzaSBob3N0MDog
YWhjaQo+ID4gPiAgICAgIFsgICAgMy4wNTE2MzJdIG52bWUgbnZtZTA6IDEyLzAvMCBkZWZhdWx0
L3JlYWQvcG9sbCBxdWV1ZXMKPiA+ID4gICAgICBbICAgIDMuMDUyNTkwXSBhdGExOiBTQVRBIG1h
eCBVRE1BLzEzMyBhYmFyIG0yMDQ4QDB4ZDEzMzkwMDAgcG9ydCAweGQxMzM5MTAwIGlycSAxMjUK
PiA+ID4gICAgICBbICAgIDMuMDU4NTM4XSAgbnZtZTBuMTogcDEgcDIgcDMKPiA+ID4gCj4gPiA+
IFNob3VsZCBpdCBiZSBhZGRlZCB0byB0aGUgcXVpcmsgbGlzdCBpbiBgZHJpdmVycy9udm1lL2hv
c3QvcGNpLmNgIG9yIGlzIGl0IGEKPiA+ID4gcmVhbCBpc3N1ZXMsIHRoZSBtYW51ZmFjdHVyZXIg
c2hvdWxkIGZpeD8gSWYgc28sIGRvIHlvdSBoYXZlIFNLIEh5bml4Cj4gPiA+IGNvbnRhY3RzPwo+
ID4gCj4gPiBJdCB3b3VsZCBiZSBncmVhdCBpZiBkZXZpY2UgbWFrZXJzIHdvdWxkIGJlIHNwZWMg
Y29tcGxpYW50LCBidXQgdGhlCj4gPiBkcml2ZXIgd2lsbCBjb250aW51ZSB0byB3b3JrIHdpdGgg
dGhlIGRldmljZSB0aGUgc2FtZSB3aGV0aGVyIHlvdSBhZGQKPiA+IHRoZSBxdWlyayBvciBub3Qu
Cj4gCj4gQ291bGQgeW91IHBsZWFzZSBwb2ludCBtZSB0byB0aGUgTlZNZSBzcGVjaWZpY2F0aW9u
IHNlY3Rpb24sIHNvIEkgY2FuIHJlZmVyCj4gdG8gaXQsIHdoZW4gY29udGFjdGluZyB0aGUgbWFu
dWZhY3R1cmVyPwoKSW4gdGhlIHNlY3Rpb24gZm9yICJJZGVudGlmeSBDb250cm9sbGVyIERhdGEg
U3RydWN0dXJlIiAoc2VjdGlvbgo1LjE3LjIuMSwgZmlndXJlIDI1NyBpbiBzcGVjIHZlcnNpb24g
Mi4wKSwgdGhlIE5RTiBkZWZpbml0aW9uIHNheXM6CgogICJTdXBwb3J0IGZvciB0aGlzIGZpZWxk
IGlzIG1hbmRhdG9yeSBpZiB0aGUgY29udHJvbGxlciBzdXBwb3J0cyByZXZpc2lvbgogIDEuMi4x
IG9yIGxhdGVyIgoKVGhlIGRyaXZlciBkb2VzIGNvbmZpcm0gdGhlIGNvbnRyb2xsZXIncyByZXBv
cnRlZCByZXZpc2lvbiBtZWV0cyB0aGlzCnJlcXVpcmVtZW50IGJlZm9yZSBlbWl0dGluZyB0aGUg
d2FybmluZy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

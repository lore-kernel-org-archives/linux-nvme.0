Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3D2C49EA6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 09:24:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8091D613F1
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 09:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8091D613F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9vf78twAE8Oes7VbyCOetmjUxpWiyhVzods/XJbGjuI=; b=ZtsJyygHv07OdbCQcsV/+KxF5I
	3qPIJCT87FymnIOThsSiiwpjqZRoVfxbiqmhVZ5VIEQ7lJp3bIZrOBc113T/1C6PDbh0rPbnS0Xnv
	XeKyvn/+xL7CvXB7G2sagkgjMtflV+yaH49ONgi78tMiEeRRyVKiAiIP9Kdwdjz+R8nwQ57P2Glih
	OKd007VX78UMzXCeKI2SW/A0nprZ84U/o0w90Gf87X6CXcV247XCojFpSQKehujkpD1xnD87D54BL
	Wl++driX/NLjaE/rDvmKO8CZTP9sa2JQHPiMG813kGcdzC0Y5BO8Oy2V9WBV54y5Bz2vq7N9tW/rp
	aAn+TGqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwLb6-00DhEt-Ez; Thu, 24 Jun 2021 09:24:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwLb3-00DhDV-6v
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 09:24:31 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D48A421923;
 Thu, 24 Jun 2021 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624526667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=il0/cwUtgiAD5jaqXCBVRaOIoH20XDAXjZdXMAfwrnc=;
 b=dd1FQ/2wfsim+6JwpUX45Tb9p//E/WE/Q0+MjqRzmuzpoAKsuu3vXUya+UtVP4Uuf6XfHb
 BvoYaA7fHO12kEWQryNc9LefuchyIsXMd2Wc35+P4DP+CCGeyMDGUrKlJJ3ow++sXsb0Wn
 gcqBctD+00RqOSydTV2iWxQjtiTbWx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624526667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=il0/cwUtgiAD5jaqXCBVRaOIoH20XDAXjZdXMAfwrnc=;
 b=gv37xlS3BOOpuz7rxWbWXF1RGJiwzMQCRuFsmp6f4csPSmIGr4NOIK2/sPnqjCcsjJQrS3
 ZWTM3cu9CM3U+nBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id C2C7A11A97;
 Thu, 24 Jun 2021 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624526667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=il0/cwUtgiAD5jaqXCBVRaOIoH20XDAXjZdXMAfwrnc=;
 b=dd1FQ/2wfsim+6JwpUX45Tb9p//E/WE/Q0+MjqRzmuzpoAKsuu3vXUya+UtVP4Uuf6XfHb
 BvoYaA7fHO12kEWQryNc9LefuchyIsXMd2Wc35+P4DP+CCGeyMDGUrKlJJ3ow++sXsb0Wn
 gcqBctD+00RqOSydTV2iWxQjtiTbWx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624526667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=il0/cwUtgiAD5jaqXCBVRaOIoH20XDAXjZdXMAfwrnc=;
 b=gv37xlS3BOOpuz7rxWbWXF1RGJiwzMQCRuFsmp6f4csPSmIGr4NOIK2/sPnqjCcsjJQrS3
 ZWTM3cu9CM3U+nBQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id TT5WL0tP1GBSQAAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 24 Jun 2021 09:24:27 +0000
Subject: Re: [LSF/MM/BPF Topic] Towards more useful nvme-passthrough
To: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, javier@javigon.com,
 anuj20.g@samsung.com, joshiiitr@gmail.com
References: <CGME20210609105347epcas5p42ab916655fca311157a38d54f79f95e7@epcas5p4.samsung.com>
 <20210609105050.127009-1-joshi.k@samsung.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d9e6e3cc-fedb-eb45-7a3e-5df24e67455b@suse.de>
Date: Thu, 24 Jun 2021 11:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210609105050.127009-1-joshi.k@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_022429_466730_86320510 
X-CRM114-Status: GOOD (  27.95  )
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

T24gNi85LzIxIDEyOjUwIFBNLCBLYW5jaGFuIEpvc2hpIHdyb3RlOgo+IEJhY2tncm91bmQgJiBv
YmplY3RpdmVzOgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IAo+IFRoZSBOVk1lIHBhc3N0
aHJvdWdoIGludGVyZmFjZQo+IAo+IEdvb2QgcGFydDogYWxsb3dzIG5ldyBkZXZpY2UtZmVhdHVy
ZXMgdG8gYmUgdXNhYmxlIChhdCBsZWFzdCBpbiByYXcKPiBmb3JtKSB3aXRob3V0IGhhdmluZyB0
byBidWlsZCBibG9jay1nZW5lcmljIGNtZHMsIGluLWtlcm5lbCB1c2VycywKPiBlbXVsYXRpb25z
IGFuZCBmaWxlLWdlbmVyaWMgdXNlci1pbnRlcmZhY2VzIC0gYWxsIHRoaXMgdGFrZSBzb21lIHRp
bWUgdG8KPiBldm9sdmUuCj4gCj4gQmFkIHBhcnQ6IHBhc3N0aHJvdWdoIGludGVyZmFjZSBoYXMg
cmVtYWluIHRpZWQgdG8gc3luY2hyb25vdXMgaW9jdGwsCj4gd2hpY2ggaXMgYSBibG9ja2VyIGZv
ciBwZXJmb3JtYW5jZS1jZW50cmljIHVzYWdlIHNjZW5hcmlvcy4gVXNlci1zcGFjZQo+IGNhbiB0
YWtlIHRoZSBwYWluIG9mIGltcGxlbWVudGluZyBhc3luYy1vdmVyLXN5bmMgb24gaXRzIG93biBi
dXQgaXQgZG9lcwo+IG5vdCBtYWtlIG11Y2ggc2Vuc2UgaW4gYSB3b3JsZCB0aGF0IGFscmVhZHkg
aGFzIGlvX3VyaW5nLgo+IAo+IFBhc3N0aHJvdWdoIGlzIGxlYW4gaW4gdGhlIHNlbnNlIGl0IGN1
dHMgdGhyb3VnaCBsYXllcnMgb2YgYWJzdHJhY3Rpb25zCj4gYW5kIHJlYWNoZXMgdG8gTlZNZSBm
YXN0LiBPbmUgb2YgdGhlIG9iamVjdGl2ZSBoZXJlIGlzIHRvIGJ1aWxkIGEKPiBzY2FsYWJsZSBw
YXNzLXRocm91Z2ggdGhhdCBjYW4gYmUgcmVhZGlseSB1c2VkIHRvIHBsYXkgd2l0aCBuZXcvZW1l
cmdpbmcKPiBOVk1lIGZlYXR1cmVzLiAgQW5vdGhlciBpcyB0byBzdXJwYXNzL21hdGNoIGV4aXN0
aW5nIHJhdy9kaXJlY3QgYmxvY2sKPiBJL08gcGVyZm9ybWFuY2Ugd2l0aCB0aGlzIG5ldyBpbi1r
ZXJuZWwgcGF0aC4KPiAKPiBSZWNlbnQgZGV2ZWxvcG1lbnRzOgo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gLSBOVk1lIG5vdyBoYXMgYSBwZXItbmFtZXNwYWNlIGNoYXIgaW50ZXJmYWNlIHRoYXQg
cmVtYWlucyBhdmFpbGFibGUvdXNhYmxlCj4gICBldmVuIGZvciB1bnN1cHBvcnRlZCBmZWF0dXJl
cyBhbmQgZm9yIG5ldyBjb21tYW5kLXNldHMgWzFdLgo+IAo+IC0gSmVucyBoYXMgcHJvcG9zZWQg
YXN5bmMtaW9jdGwgbGlrZSBmYWNpbGl0eSAndXJpbmdfY21kJyBpbiBpb191cmluZy4gVGhpcwo+
ICAgaW50cm9kdWNlcyBuZXcgcG9zc2liaWxpdGllcyAoYmV5b25kIHN0b3JhZ2UpOyBhc3luYy1w
YXNzdGhyb3VnaCBpcyBvbmUgb2YKPiB0aG9zZS4gTGFzdCBwb3N0ZWQgdmVyc2lvbiBpcyBWNCBb
Ml0uCj4gCj4gLSBJIGhhdmUgcG9zdGVkIHdvcmsgb24gYXN5bmMgbnZtZSBwYXNzdGhyb3VnaCBv
dmVyIGJsb2NrLWRldiBbM10uIFBvc3RlZCB3b3JrCj4gICBpcyBpbiBWNCAoaW4gc3luYyB3aXRo
IHRoZSBpbmZyYSBvZiBbMl0pLgo+IAo+IEVhcmx5IHBlcmZvcm1hbmNlIG51bWJlcnM6Cj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBmaW8sIHJhbmRyZWFkLCA0ayBicywgMSBqb2IKPiBL
aW9wcywgd2l0aCB2YXJ5aW5nIFFEOgo+IAo+IFFEICAgICAgU3luYy1QVCAgICAgICAgIGlvX3Vy
aW5nICAgICAgICBBc3luYy1QVAo+IDEgICAgICAgICAxMC44ICAgICAgICAgICAgMTAuNiAgICAg
ICAgICAgIDEwLjYKPiAyICAgICAgICAgMTAuOSAgICAgICAgICAgIDI0LjUgICAgICAgICAgICAy
NAo+IDQgICAgICAgICAxMC42ICAgICAgICAgICAgNDUgICAgICAgICAgICAgIDQ2Cj4gOCAgICAg
ICAgIDEwLjkgICAgICAgICAgICA5MCAgICAgICAgICAgICAgODkKPiAxNiAgICAgICAgMTEuMCAg
ICAgICAgICAgIDE2OSAgICAgICAgICAgICAxNzAKPiAzMiAgICAgICAgMTAuNiAgICAgICAgICAg
IDMwOCAgICAgICAgICAgICAzMDcKPiA2NCAgICAgICAgMTAuOCAgICAgICAgICAgIDUwMyAgICAg
ICAgICAgICA1MDYKPiAxMjggICAgICAgMTAuOSAgICAgICAgICAgIDU5MiAgICAgICAgICAgICA1
OTYKPiAKPiBGdXJ0aGVyIHN0ZXBzL2Rpc2N1c3Npb24gcG9pbnRzOgo+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gMS5Bc3luYy1wYXNzdGhyb3VnaCBvdmVyIG52bWUgY2hhci1k
ZXYKPiBJdCBpcyBpbiBhIHNoYXBlIHRvIHJlY2VpdmUgZmVlZGJhY2ssIGJ1dCBJIGFtIG5vdCBz
dXJlIGlmIGNvbW11bml0eQo+IHdvdWxkIGxpa2UgdG8gdGFrZSBhIGxvb2sgYXQgdGhhdCBiZWZv
cmUgc2V0dGxpbmcgb24gdXJpbmctY21kIGluZnJhLgo+IAo+IDIuT25jZSBhYm92ZSBnZXRzIGlu
IHNoYXBlLCBicmluZyBvdGhlciBwZXJmLWNlbnRyaWMgZmVhdHVyZXMgb2YgaW9fdXJpbmcgdG8K
PiB0aGlzIHBhdGggLQo+IEEuIFNRUG9sbCBhbmQgcmVnaXN0ZXItZmlsZTogYWxyZWFkeSBmdW5j
dGlvbmFsLgo+IEIuIFBhc3N0aHJvdWdoIHBvbGxpbmc6IFRoaXMgY2FuIGJlIGVuYWJsZWQgZm9y
IGJsb2NrIGFuZCBsb29rcyBmZWFzaWJsZSBmb3IKPiBjaGFyLWludGVyZmFjZSBhcyB3ZWxsLiAg
S2VpdGggcmVjZW50bHkgcG9zdGVkIGVuYWJsaW5nIHBvbGxpbmcgZm9yIHVzZXIKPiBwYXNzLXRo
cm91Z2ggWzRdCj4gQy4gUHJlLW1hcHBlZCBidWZmZXJzOiBFYXJseSB0aG91Z2h0IGlzIHRvIGxl
dCB0aGUgYnVmZmVycyByZWdpc3RlcmVkIGJ5Cj4gaW9fdXJpbmcsIGFuZCBhZGQgYSBuZXcgcGFz
c3Rocm91Z2ggaW9jdGwvdXJpbmdfY21kIGluIGRyaXZlciB3aGljaCBkb2VzCj4gZXZlcnl0aGlu
ZyB0aGF0IHBhc3N0aHJvdWdoIGRvZXMgZXhjZXB0IHBpbm5pbmcvdW5waW5uaW5nIHRoZSBwYWdl
cy4KPiAKPiAzLiBBcmUgdGhlcmUgbW9yZSB0aGluZ3MgaW4gdGhlICJpb191cmluZy0+bnZtZS0+
W2Jsb2NrLWxheWVyXS0+bnZtZSIgcGF0aAo+IHdoaWNoIGNhbiBiZSBvcHRpbWl6ZWQuCj4gCj4g
SWRlYWxseSBJJ2QgbGlrZSB0byBjb3ZlciBnb29kIGRlYWwgb2YgZ3JvdW5kIGJlZm9yZSBEZWMu
IEJ1dCB0aGVyZSBzZWVtcwo+IHBsZW50eSBvZiBwb3NzaWJpbGl0aWVzIG9uIHRoaXMgcGF0aC4g
IERpc2N1c3Npb24gd291bGQgaGVscCBpbiBob3cgYmVzdCB0bwo+IG1vdmUgZm9yd2FyZCwgYW5k
IGNlbWVudCB0aGUgaWRlYXMuCj4gCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW52bWUvMjAyMTA0MjEwNzQ1MDQuNTc3NTAtMS1taW53b28uaW0uZGV2QGdtYWlsLmNvbS8KPiBb
Ml0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS8yMDIxMDMxNzIyMTAyNy4zNjY3
ODAtMS1heGJvZUBrZXJuZWwuZGsvCj4gWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW52bWUvMjAyMTAzMjUxNzA1NDAuNTk2MTktMS1qb3NoaS5rQHNhbXN1bmcuY29tLwo+IFs0XSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay8yMDIxMDUxNzE3MTQ0My5HQjI3MDkz
OTFAZGhjcC0xMC0xMDAtMTQ1LTE4MC53ZGMuY29tLyN0Cj4gCkkgZG8gbGlrZSB0aGUgaWRlYS4K
CldoYXQgSSB3b3VsZCBsaWtlIHRvIHNlZSBpcyB0byBtYWtlIHRoZSBpb3JpbmdfY21kIGluZnJh
c3RydWN0dXJlCmdlbmVyYWxseSBhdmFpbGFibGUsIHN1Y2ggdGhhdCB3ZSBjYW4gcG9ydCB0aGUg
U0NTSSBzZyBhc3luY2hyb25vdXMKaW50ZXJmYWNlIG92ZXIgdG8gdGhpcy4KRG91ZyBHaWxiZXJ0
IGhhcyBiZWVuIGZpZ2h0aW5nIGEgbG9uZSBiYXR0bGUgdG8gaW1wcm92ZSB0aGUgc2cKYXN5bmNo
cm9ub3VzIGludGVyZmFjZSwgYXMgdGhlIGN1cnJlbnQgb25lIGlzIGRlZW1lZCBhIHNlY3VyaXR5
IGhhemFyZC4KQnV0IGluIHRoZSBhYnNlbmNlIG9mIGEgZ2VuZXJpYyBpbnRlcmZhY2UgaGUgaGFk
IHRvIGRlc2lnbiBoaXMgb3duCmlvY3Rscywgd2l0aCBhbGwgdGhlIGV4cGVjdGVkIHB1c2hiYWNr
LgpQbHVzIHRoZXJlIGFyZSBvbmx5IHNvIG1hbnkgcGVvcGxlIHdobyBjYXJlIGFib3V0IHNnIGlu
dGVybmFscyA6LSgKCkJlaW5nIGFibGUgdG8gdXNlIGlvcmluZ19jbWQgd291bGQgYmUgYSBuZWF0
IHdheSBvdXQgb2YgdGhpcy4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNr
ZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAg
ICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChB
RyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

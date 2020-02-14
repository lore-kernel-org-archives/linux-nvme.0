Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A76C2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 07:33:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D132222C2
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 07:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mgF1SzJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D132222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yM9KGTRWa0ZJGo5lfskltCezZ7Wl5bcwbNpPLdkGh/Q=; b=mgF1SzJHRiqnl4
	/hFaOUzAi2mgFz8dta1jxNxt6NCC1OuUh7UXAUEFM49mM1OPjk1F6Jk1xMG7YZz217owH/w/rix0j
	xRCupBOwp1JJhwyPJ5XXp/NS2W2JADKGbH7N+xrnrmCxfVFMIQW5e1yEImLV4YhcETTTGQdbJbdis
	WfAN5c32+BAxW6V5am37C4EJsBF67yPGa/PaGNE/Q0A1Ty4GOaDT6dznFvGb5kFPpRwUCe5Um09ec
	Md6gX8GRLH1DotBXfPMt+PhOGMR8n9xLv2ZSOj7PdNDv1d9q6Ot5Mk/5+tn5kWRM+NDe3ieK3BfKw
	+sJBAjU1Mt9QjBvmSIIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2VTE-0005jJ-CO; Fri, 14 Feb 2020 07:33:04 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2VTB-0005b6-R3
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 07:33:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1CA16AC4B;
 Fri, 14 Feb 2020 07:32:58 +0000 (UTC)
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Tim Walker <tim.t.walker@seagate.com>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
Date: Fri, 14 Feb 2020 08:32:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <yq1r1yzqfyb.fsf@oracle.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200213_233302_171227_0F68659E 
X-CRM114-Status: GOOD (  15.66  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xMy8yMCA1OjE3IEFNLCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3JvdGU6Cj4gCj4gVGltLAo+
IAo+PiBTQVMgY3VycmVudGx5IHN1cHBvcnRzIFFEMjU2LCBidXQgdGhlIGdlbmVyYWwgY29uc2Vu
c3VzIGlzIHRoYXQgbW9zdAo+PiBjdXN0b21lcnMgZG9uJ3QgcnVuIGFueXdoZXJlIG5lYXIgdGhh
dCBkZWVwLiBEb2VzIGl0IGhlbHAgdGhlIHN5c3RlbQo+PiBmb3IgdGhlIEhEIHRvIHJlcG9ydCBh
IGxpbWl0ZWQgKDI1NikgbWF4IHF1ZXVlIGRlcHRoLCBvciBpcyBpdCByZWFsbHkKPj4gdXAgdG8g
dGhlIHN5c3RlbSB0byBkZWNpZGUgbWFueSBjb21tYW5kcyB0byBxdWV1ZT8KPiAKPiBQZW9wbGUg
b2Z0ZW4gYXJ0aWZpY2lhbGx5IGxvd2VyIHRoZSBxdWV1ZSBkZXB0aCB0byBhdm9pZCB0aW1lb3V0
cy4gVGhlCj4gZGVmYXVsdCB0aW1lb3V0IGlzIDMwIHNlY29uZHMgZnJvbSBhbiBJL08gaXMgcXVl
dWVkLiBIb3dldmVyLCBtYW55Cj4gZW50ZXJwcmlzZSBhcHBsaWNhdGlvbnMgc2V0IHRoZSB0aW1l
b3V0IHRvIDMtNSBzZWNvbmRzLiBXaGljaCBtZWFucyB0aGF0Cj4gd2l0aCBkZWVwIHF1ZXVlcyB5
b3UnbGwgcXVpY2tseSBzdGFydCBzZWVpbmcgdGltZW91dHMgaWYgYSBkcml2ZQo+IHRlbXBvcmFy
aWx5IGlzIGhhdmluZyBpc3N1ZXMga2VlcGluZyB1cCAobWVkaWEgZXJyb3JzLCBleGNlc3NpdmUg
c3BhcmUKPiB0cmFjayBzZWVrcywgZXRjLikuCj4gCj4gV2VsbC1iZWhhdmVkIGRldmljZXMgd2ls
bCByZXR1cm4gUUYvVFNGIGlmIHRoZXkgaGF2ZSB0cmFuc2llbnQgcmVzb3VyY2UKPiBzdGFydmF0
aW9uIG9yIGV4Y2VlZCBpbnRlcm5hbCBRb1MgbGltaXRzLiBRRiB3aWxsIGNhdXNlIHRoZSBTQ1NJ
IHN0YWNrCj4gdG8gcmVkdWNlIHRoZSBudW1iZXIgb2YgSS9PcyBpbiBmbGlnaHQuIFRoaXMgYWxs
b3dzIHRoZSBkcml2ZSB0byByZWNvdmVyCj4gZnJvbSBpdHMgY29uZ2VzdGVkIHN0YXRlIGFuZCBy
ZWR1Y2VzIHRoZSBwb3RlbnRpYWwgb2YgYXBwbGljYXRpb24gYW5kCj4gZmlsZXN5c3RlbSB0aW1l
b3V0cy4KPiAKVGhpcyBtYXkgZXZlbiBiZSBhIGNoYW5jZSB0byByZXZpc2l0IFFvUyAvIHF1ZXVl
IGJ1c3kgaGFuZGxpbmcuCk5WTWUgaGFzIHRoaXMgU1EgaGVhZCBwb2ludGVyIG1lY2hhbmlzbSB3
aGljaCB3YXMgc3VwcG9zZWQgdG8gaGFuZGxlCnRoaXMga2luZCBvZiBzaXR1YXRpb25zLCBidXQg
dG8gbXkga25vd2xlZGdlIG5vLW9uZSBoYXMgYmVlbgppbXBsZW1lbnRpbmcgaXQuCk1pZ2h0IGJl
IHdvcnRod2hpbGUgcmV2aXNpdGluZyBpdDsgZ3Vlc3MgTlZNZSBIRERzIHdvdWxkIHByb2ZpdCBm
cm9tIHRoYXQuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAg
ICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAg
ICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkg
R21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5i
ZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=

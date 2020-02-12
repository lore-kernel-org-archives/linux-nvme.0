Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE37C352A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 22:03:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38762168B
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 22:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z70dwgyw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0T7PsSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38762168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5mnCE0v6Lf24t26vg++FcTX58PSLZgN7+ATlsmIwbpg=; b=Z70dwgyw8oac3y
	gO/3hKQFxztFcJIvrjljYNQN2LVZnSygkGE0AIKsLz9CLG3A0bXwYc5ymcyQtFJykXwRPFKxvk8WF
	va+nQUyQKka+/yCjsnET0OLPIHoBs4+QNIxuWbzoVTnHR2ry3AdCK106ILQgxyn+k7LjAbNXQs+Rl
	1O1ffx9+IBxcDVRqfl/TaBCMhfXsvPa8UQCKG/b0Ew7YJ2DWF5FAJko80QKJMwlfP7M0t/kLgw4xz
	LePbP4xKilung0CaLqddogkNYWqw0rrhO9SXyCHDG2Hy45hM4B4/SVM3OF4DCqyVuYFd8Z8+ZwfBX
	umYeBiw33835k3FmewBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j206k-00031L-VP; Wed, 12 Feb 2020 22:03:46 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j206h-00030C-JM
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 22:03:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581545021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8jRtKLNTMzQ9F4ovRApdC2gkFDizflEZtluJFlDclQ=;
 b=J0T7PsSRNP9NSwLTbZh/KFIrcyqpiHD3lCfxki4Y6r2bhwtTY4YdMcvvgUDrrrFK09n8OD
 At/alrw83kSOvht1OmUz7HoMW+sG3/4fz4iqFbyh3kcTMdbGkDJdWFSbWyfaSEvXbkauzy
 GQ6mVfpUqh3CCHlZCHg9wlzyT2JJh/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-lyrdfM_wMwaDWqk7cPTnxw-1; Wed, 12 Feb 2020 17:03:39 -0500
X-MC-Unique: lyrdfM_wMwaDWqk7cPTnxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38ED08017CC;
 Wed, 12 Feb 2020 22:03:38 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A89FB90069;
 Wed, 12 Feb 2020 22:03:32 +0000 (UTC)
Date: Thu, 13 Feb 2020 06:03:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Message-ID: <20200212220328.GB25314@ming.t460p>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_140343_713024_5974ED10 
X-CRM114-Status: GOOD (  26.01  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Tim Walker <tim.t.walker@seagate.com>, linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBGZWIgMTIsIDIwMjAgYXQgMDE6NDc6NTNBTSArMDAwMCwgRGFtaWVuIExlIE1vYWwg
d3JvdGU6Cj4gT24gMjAyMC8wMi8xMiA0OjAxLCBUaW0gV2Fsa2VyIHdyb3RlOgo+ID4gT24gVHVl
LCBGZWIgMTEsIDIwMjAgYXQgNzoyOCBBTSBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPj4KPiA+PiBPbiBNb24sIEZlYiAxMCwgMjAyMCBhdCAwMjoyMDoxMFBNIC0wNTAw
LCBUaW0gV2Fsa2VyIHdyb3RlOgo+ID4+PiBCYWNrZ3JvdW5kOgo+ID4+Pgo+ID4+PiBOVk1lIHNw
ZWNpZmljYXRpb24gaGFzIGhhcmRlbmVkIG92ZXIgdGhlIGRlY2FkZSBhbmQgbm93IE5WTWUgZGV2
aWNlcwo+ID4+PiBhcmUgd2VsbCBpbnRlZ3JhdGVkIGludG8gb3VyIGN1c3RvbWVyc+KAmSBzeXN0
ZW1zLiBBcyB3ZSBsb29rIGZvcndhcmQsCj4gPj4+IG1vdmluZyBIRERzIHRvIHRoZSBOVk1lIGNv
bW1hbmQgc2V0IGVsaW1pbmF0ZXMgdGhlIFNBUyBJT0MgYW5kIGRyaXZlcgo+ID4+PiBzdGFjaywg
Y29uc29saWRhdGluZyBvbiBhIHNpbmdsZSBhY2Nlc3MgbWV0aG9kIGZvciByb3RhdGlvbmFsIGFu
ZAo+ID4+PiBzdGF0aWMgc3RvcmFnZSB0ZWNobm9sb2dpZXMuIFBDSWUtTlZNZSBvZmZlcnMgbmVh
ci1TQVRBIGludGVyZmFjZQo+ID4+PiBjb3N0cywgZmVhdHVyZXMgYW5kIHBlcmZvcm1hbmNlIHN1
aXRhYmxlIGZvciBoaWdoLWNhcCBIRERzLCBhbmQKPiA+Pj4gb3B0aW1hbCBpbnRlcm9wZXJhYmls
aXR5IGZvciBzdG9yYWdlIGF1dG9tYXRpb24sIHRpZXJpbmcsIGFuZAo+ID4+PiBtYW5hZ2VtZW50
LiBXZSB3aWxsIHNoYXJlIHNvbWUgZWFybHkgY29uY2VwdHVhbCByZXN1bHRzIGFuZCBwcm9wb3Nl
ZAo+ID4+PiBzYWxpZW50IGRlc2lnbiBnb2FscyBhbmQgY2hhbGxlbmdlcyBzdXJyb3VuZGluZyBh
biBOVk1lIEhERC4KPiA+Pgo+ID4+IEhERC4gcGVyZm9ybWFuY2UgaXMgdmVyeSBzZW5zaXRpdmUg
dG8gSU8gb3JkZXIuIENvdWxkIHlvdSBwcm92aWRlIHNvbWUKPiA+PiBiYWNrZ3JvdW5kIGluZm8g
YWJvdXQgTlZNZSBIREQ/IFN1Y2ggYXM6Cj4gPj4KPiA+PiAtIG51bWJlciBvZiBodyBxdWV1ZXMK
PiA+PiAtIGh3IHF1ZXVlIGRlcHRoCj4gPj4gLSB3aWxsIE5WTWUgc29ydC9tZXJnZSBJTyBhbW9u
ZyBhbGwgU1FzIG9yIG5vdD8KPiA+Pgo+ID4+Pgo+ID4+Pgo+ID4+PiBEaXNjdXNzaW9uIFByb3Bv
c2FsOgo+ID4+Pgo+ID4+PiBXZeKAmWQgbGlrZSB0byBzaGFyZSBvdXIgdmlld3MgYW5kIHNvbGlj
aXQgaW5wdXQgb246Cj4gPj4+Cj4gPj4+IC1XaGF0IExpbnV4IHN0b3JhZ2Ugc3RhY2sgYXNzdW1w
dGlvbnMgZG8gd2UgbmVlZCB0byBiZSBhd2FyZSBvZiBhcyB3ZQo+ID4+PiBkZXZlbG9wIHRoZXNl
IGRldmljZXMgd2l0aCBkcmFzdGljYWxseSBkaWZmZXJlbnQgcGVyZm9ybWFuY2UKPiA+Pj4gY2hh
cmFjdGVyaXN0aWNzIHRoYW4gdHJhZGl0aW9uYWwgTkFORD8gRm9yIGV4YW1wbGUsIHdoYXQgc2No
ZWR1bGFyIG9yCj4gPj4+IGRldmljZSBkcml2ZXIgbGV2ZWwgY2hhbmdlcyB3aWxsIGJlIG5lZWRl
ZCB0byBpbnRlZ3JhdGUgTlZNZSBIRERzPwo+ID4+Cj4gPj4gSU8gbWVyZ2UgaXMgb2Z0ZW4gaW1w
b3J0YW50IGZvciBIREQuIElPIG1lcmdlIGlzIHVzdWFsbHkgdHJpZ2dlcmVkIHdoZW4KPiA+PiAu
cXVldWVfcnEoKSByZXR1cm5zIFNUU19SRVNPVVJDRSwgc28gZmFyIHRoaXMgY29uZGl0aW9uIHdv
bid0IGJlCj4gPj4gdHJpZ2dlcmVkIGZvciBOVk1lIFNTRC4KPiA+Pgo+ID4+IEFsc28gYmxrLW1x
IGtpbGxzIEJESSBxdWV1ZSBjb25nZXN0aW9uIGFuZCBpb2MgYmF0Y2hpbmcsIGFuZCBjYXVzZXMK
PiA+PiB3cml0ZWJhY2sgcGVyZm9ybWFuY2UgcmVncmVzc2lvblsxXVsyXS4KPiA+Pgo+ID4+IFdo
YXQgSSBhbSB0aGlua2luZyBpcyB0aGF0IGlmIHdlIG5lZWQgdG8gc3dpdGNoIHRvIHVzZSBpbmRl
cGVuZGVudCBJTwo+ID4+IHBhdGggZm9yIGhhbmRsaW5nIFNTRCBhbmQgSERELiBJTywgZ2l2ZW4g
dGhlIHR3byBtZWRpdW1zIGFyZSBzbwo+ID4+IGRpZmZlcmVudCBmcm9tIHBlcmZvcm1hbmNlIHZp
ZXdwb2ludC4KPiA+Pgo+ID4+IFsxXSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20v
djIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19saW51eC0yRHNjc2lfUGluZS5MTlgu
NC40NEwwLjE5MDkxODEyMTMxNDEuMTUwNy0yRDEwMDAwMC00MGlvbGFudGhlLnJvd2xhbmQub3Jn
XyZkPUR3SUZhUSZjPUlHRGxnMGxEMGItbmVibUpKMEtwOEEmcj1OVzFYMHlSSE5ORWx1WjhzT0dY
QnhDYlFKWlBXY0lrUFQwVXkzeW5Wc0ZVJm09cFNuSHB0X3VRUTczSlY0VklRZzFDX1BWQWNMdnFC
QnRteXhRSHdXakdTTSZzPXRzbkZQOGJRSUFxN0c2NkI3NUxUZTN2bzRLMTRIYkw5SkpLc3hsX0xQ
QXcmZT0KPiA+PiBbMl0gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91
PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdfbGludXgtMkRzY3NpXzIwMTkxMjI2MDgzNzA2LkdB
MTc5NzQtNDBtaW5nLnQ0NjBwXyZkPUR3SUZhUSZjPUlHRGxnMGxEMGItbmVibUpKMEtwOEEmcj1O
VzFYMHlSSE5ORWx1WjhzT0dYQnhDYlFKWlBXY0lrUFQwVXkzeW5Wc0ZVJm09cFNuSHB0X3VRUTcz
SlY0VklRZzFDX1BWQWNMdnFCQnRteXhRSHdXakdTTSZzPUdKd1N4WHRjX3FaSEtuclRxU2J5dFVq
dVJyclFnWnB2VjNieFpZRkRIZTQmZT0KPiA+Pgo+ID4+Cj4gPj4gVGhhbmtzLAo+ID4+IE1pbmcK
PiA+Pgo+ID4gCj4gPiBJIHdvdWxkIGV4cGVjdCB0aGUgZHJpdmUgd291bGQgc3VwcG9ydCBhIHJl
YXNvbmFibGUgbnVtYmVyIG9mIHF1ZXVlcwo+ID4gYW5kIGEgcmVsYXRpdmVseSBkZWVwIHF1ZXVl
IGRlcHRoLCBtb3JlIGluIGxpbmUgd2l0aCBOVk1lIHByYWN0aWNlcwo+ID4gdGhhbiBTQVMgSERE
J3MgdHlwaWNhbCAxMjguIEJ1dCBpdCBwcm9iYWJseSBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8KPiA+
IHF1ZXVlIHVwIHRob3VzYW5kcyBvZiBjb21tYW5kcyBvbiBzb21ldGhpbmcgYXMgc2xvdyBhcyBh
biBIREQsIGFuZAo+ID4gbWFueSBjdXN0b21lcnMga2VlcCBxdWV1ZXMgPCAzMiBmb3IgbGF0ZW5j
eSBtYW5hZ2VtZW50Lgo+IAo+IEV4cG9zaW5nIGFuIEhERCB0aHJvdWdoIG11bHRpcGxlLXF1ZXVl
cyBlYWNoIHdpdGggYSBoaWdoIHF1ZXVlIGRlcHRoIGlzCj4gc2ltcGx5IGFza2luZyBmb3IgdHJv
dWJsZXMuIENvbW1hbmRzIHdpbGwgZW5kIHVwIHNwZW5kaW5nIHNvIG11Y2ggdGltZQo+IHNpdHRp
bmcgaW4gdGhlIHF1ZXVlcyB0aGF0IHRoZXkgd2lsbCB0aW1lb3V0LiBUaGlzIGNhbiBhbHJlYWR5
IGJlIG9ic2VydmVkCj4gd2l0aCB0aGUgc21hcnRwcWkgU0FTIEhCQSB3aGljaCBleHBvc2VzIHNp
bmdsZSBkcml2ZXMgYXMgbXVsdGlxdWV1ZSBibG9jawo+IGRldmljZXMgd2l0aCBoaWdoIHF1ZXVl
IGRlcHRoLiBFeGVyY2lzaW5nIHRoZXNlIGRyaXZlcyBoZWF2aWx5IGxlYWRzIHRvCj4gdGhvdXNh
bmRzIG9mIGNvbW1hbmRzIGJlaW5nIHF1ZXVlZCBhbmQgdG8gdGltZW91dHMuIEl0IGlzIGZhaXJs
eSBlYXN5IHRvCj4gdHJpZ2dlciB0aGlzIHdpdGhvdXQgYSBtYW51YWwgY2hhbmdlIHRvIHRoZSBR
RC4gVGhpcyBpcyBvbiBteSB0by1kbyBsaXN0IG9mCj4gZml4ZXMgZm9yIHNvbWUgdGltZSBub3cg
KGxhY2tpbmcgdGltZSB0byBkbyBpdCkuCgpKdXN0IHdvbmRlcmluZyB3aHkgc21hcnRwcWkgU0FT
IHdvbid0IHNldCBvbmUgcHJvcGVyIC5jbWRfcGVyX2x1biBmb3IKYXZvaWRpbmcgdGhlIGlzc3Vl
LCBsb29rcyB0aGUgZHJpdmVyIHNpbXBseSBhc3NpZ25zIC5jYW5fcXVldWUgdG8gaXQsCnRoZW4g
aXQgaXNuJ3Qgc3RyYW5nZSB0byBzZWUgdGhlIHRpbWVvdXQgaXNzdWUuIElmIC5jYW5fcXVldWUg
aXMgYSBiaXQKYmlnLCBIREQuIGlzIGVhc2lseSBzYXR1cmF0ZWQgdG9vIGxvbmcuCgo+IAo+IE5W
TWUgSEREcyBuZWVkIHRvIGhhdmUgYW4gaW50ZXJmYWNlIHNldHVwIHRoYXQgbWF0Y2ggdGhlaXIg
c3BlZWQsIHRoYXQgaXMsCj4gc29tZXRoaW5nIGxpa2UgYSBTQVMgaW50ZXJmYWNlOiAqc2luZ2xl
KiBxdWV1ZSBwYWlyIHdpdGggYSBtYXggUUQgb2YgMjU2IG9yCj4gbGVzcyBkZXBlbmRpbmcgb24g
d2hhdCB0aGUgZHJpdmUgY2FuIHRha2UuIFRoZWlyIGlzIG5vIFRBU0tfU0VUX0ZVTEwKPiBub3Rp
ZmljYXRpb24gb24gTlZNZSwgc28gdGhyb3R0bGluZyBoYXMgdG8gY29tZSBmcm9tIHRoZSBtYXgg
UUQgb2YgdGhlIFNRLAo+IHdoaWNoIHRoZSBkcml2ZSB3aWxsIGFkdmVydGlzZSB0byB0aGUgaG9z
dC4KPiAKPiA+IE1lcmdlIGFuZCBlbGV2YXRvciBhcmUgaW1wb3J0YW50IHRvIEhERCBwZXJmb3Jt
YW5jZS4gSSBkb24ndCBiZWxpZXZlCj4gPiBOVk1lIHNob3VsZCBhdHRlbXB0IHRvIG1lcmdlL3Nv
cnQgYWNyb3NzIFNRcy4gQ2FuIE5WTWUgbWVyZ2Uvc29ydAo+ID4gd2l0aGluIGEgU1Egd2l0aG91
dCBkcml2aW5nIGxhcmdlIGRpZmZlcmVuY2VzIGJldHdlZW4gU1NEICYgSEREIGRhdGEKPiA+IHBh
dGhzPwo+IAo+IEFzIGZhciBhcyBJIGtub3csIHRoZXJlIGlzIG5vIG1lcmdpbmcgZ29pbmcgb24g
b25jZSByZXF1ZXN0cyBhcmUgcGFzc2VkIHRvCj4gdGhlIGRyaXZlciBhbmQgYWRkZWQgdG8gYW4g
U1EuIFNvIHRoaXMgaXMgYmVzaWRlIHRoZSBwb2ludC4KPiBUaGUgY3VycmVudCBkZWZhdWx0IGJs
b2NrIHNjaGVkdWxlciBmb3IgTlZNZSBTU0RzIGlzICJub25lIi4gVGhpcyBpcwo+IGRlY2lkZWQg
YmFzZWQgb24gdGhlIG51bWJlciBvZiBxdWV1ZXMgb2YgdGhlIGRldmljZS4gRm9yIE5WTWUgZHJp
dmVzIHRoYXQKPiBoYXZlIG9ubHkgYSBzaW5nbGUgcXVldWUgKkFORCogdGhlIFFVRVVFX0ZMQUdf
Tk9OUk9UIGZsYWcgY2xlYXJlZCBpbiB0aGVpcgo+IHJlcXVlc3QgcXVldWUgd2lsbCBjYW4gZmFs
bGJhY2sgdG8gdGhlIGRlZmF1bHQgc3Bpbm5pbmcgcnVzdCBtcS1kZWFkbGluZQo+IGVsZXZhdG9y
LiBUaGF0IHdpbGwgYWNoaWV2ZSBjb21tYW5kIG1lcmdpbmcgYW5kIExCQSBvcmRlcmluZyBuZWVk
ZWQgZm9yCj4gZ29vZCBwZXJmb3JtYW5jZSBvbiBIRERzLgoKbXEtZGVhZGxpbmUgYmFzaWNhbGx5
IHdvbid0IG1lcmdlIElPIGlmIFNUU19SRVNPVVJDRSBpc24ndCByZXR1cm5lZCBmcm9tCi5xdWV1
ZV9ycSgpLCBvciBibGtfbXFfZ2V0X2Rpc3BhdGNoX2J1ZGdldCBhbHdheXMgcmV0dXJuIHRydWUu
IE5WTWUncwoucXVldWVfcnEoKSBiYXNpY2FsbHkgYWx3YXlzIHJldHVybnMgU1RTX09LLgoKClRo
YW5rcywgCk1pbmcKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==

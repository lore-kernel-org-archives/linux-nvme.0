Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94412C352A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 21:54:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA9C206DB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 21:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R8bPMoIU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2VMJhcHC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXsSbdEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA9C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AV5W7uFGndmaYwAydu0bgGmfK+PfbxUTNqVC7gGqMEI=; b=R8bPMoIUy+H1Ov
	O9suW1ROFRURbDBBWAA7CEBMmnALlRyT5F/8AODtwc+ih2ll8D99KU699X8jf2K5S7Sp3kHBSe/Z8
	4feTk8y6kLZADCH559lAVbCAxZRJDkhI5guXqF/PKTKK92AlFZBRYaB2JdnmMJ+bVy1irG4VZ2mt1
	Jsf4hYGwO37tdhGkTjxzpPkaT7KVb395KjvlsQt1yGby5VF/MGtv7oNVw6F87ODs/zu7geeUm2xLT
	vRDdd5sEFHN1QdXegGLqz3Yet7VbipXKwbVI5lyJip3ysatV61R07PtelkgiqXrmnoE4STRygXBNl
	JmjJhrSyDcg0F8DaSOsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1zxD-00067Q-Kb; Wed, 12 Feb 2020 21:53:55 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1zxB-00067B-4s
 for linux-nvme@bombadil.infradead.org; Wed, 12 Feb 2020 21:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:In-Reply-To:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=uUNF4mFLDeL4hFAUJm3ZVfVA2T7sNbN4BswQ0XSOhjI=; b=2VMJhcHC5ABGjpp5JPX0uiSi5W
 eVUSkxakY2c/7AIieM8sHUhX2xL8ciTg2DazecOhYxMTtpUP7sPrf/cpevlUFGX/Y5DhGa+ZWYiJU
 bt43ieTisE44AnKZnhwLsREzyP1ihwcHoaWIjiYvOTyi6Kg7YVKqJP6Fo60yd5soQEMpTV179va3C
 JZYXcwjIRsTSld8EKCTrForz4EQeJBSin3EZkB/0yDBeoVcrlH0Sep4HJfcXkqmIg1fswPfSbflcK
 k+nrt4uIBSG0WkrCsuFTye7j1JDwEl8TGDXJpz1Qb9g0i8dyBCa7/IOD0hRldeBp7E0BLKaboYxMe
 o1knGe7A==;
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1zx8-000320-OX
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 21:53:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581544386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUNF4mFLDeL4hFAUJm3ZVfVA2T7sNbN4BswQ0XSOhjI=;
 b=DXsSbdEtougTt+7IaC8BAvtObhkn1ZLRhMZSjBPIl3tq0ZXZiFyirkf/bgfECt0gf6F9sA
 pNP+ag+oXtBUpQ9jn1/NKZyKinpkU7Riy8okS/beL6Hz/F11P9ShTz7Qum9hvXpGVkA4Od
 1zLu9hmjB/UWZYxWcByfiEsxQ0ucOtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-f9KzPxWqMUykbjOQIliW3w-1; Wed, 12 Feb 2020 16:53:03 -0500
X-MC-Unique: f9KzPxWqMUykbjOQIliW3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42634107ACCA;
 Wed, 12 Feb 2020 21:53:02 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 424D05C12E;
 Wed, 12 Feb 2020 21:52:55 +0000 (UTC)
Date: Thu, 13 Feb 2020 05:52:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tim Walker <tim.t.walker@seagate.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Message-ID: <20200212215251.GA25314@ming.t460p>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBGZWIgMTEsIDIwMjAgYXQgMDI6MDE6MThQTSAtMDUwMCwgVGltIFdhbGtlciB3cm90
ZToKPiBPbiBUdWUsIEZlYiAxMSwgMjAyMCBhdCA3OjI4IEFNIE1pbmcgTGVpIDxtaW5nLmxlaUBy
ZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEZlYiAxMCwgMjAyMCBhdCAwMjoyMDox
MFBNIC0wNTAwLCBUaW0gV2Fsa2VyIHdyb3RlOgo+ID4gPiBCYWNrZ3JvdW5kOgo+ID4gPgo+ID4g
PiBOVk1lIHNwZWNpZmljYXRpb24gaGFzIGhhcmRlbmVkIG92ZXIgdGhlIGRlY2FkZSBhbmQgbm93
IE5WTWUgZGV2aWNlcwo+ID4gPiBhcmUgd2VsbCBpbnRlZ3JhdGVkIGludG8gb3VyIGN1c3RvbWVy
c+KAmSBzeXN0ZW1zLiBBcyB3ZSBsb29rIGZvcndhcmQsCj4gPiA+IG1vdmluZyBIRERzIHRvIHRo
ZSBOVk1lIGNvbW1hbmQgc2V0IGVsaW1pbmF0ZXMgdGhlIFNBUyBJT0MgYW5kIGRyaXZlcgo+ID4g
PiBzdGFjaywgY29uc29saWRhdGluZyBvbiBhIHNpbmdsZSBhY2Nlc3MgbWV0aG9kIGZvciByb3Rh
dGlvbmFsIGFuZAo+ID4gPiBzdGF0aWMgc3RvcmFnZSB0ZWNobm9sb2dpZXMuIFBDSWUtTlZNZSBv
ZmZlcnMgbmVhci1TQVRBIGludGVyZmFjZQo+ID4gPiBjb3N0cywgZmVhdHVyZXMgYW5kIHBlcmZv
cm1hbmNlIHN1aXRhYmxlIGZvciBoaWdoLWNhcCBIRERzLCBhbmQKPiA+ID4gb3B0aW1hbCBpbnRl
cm9wZXJhYmlsaXR5IGZvciBzdG9yYWdlIGF1dG9tYXRpb24sIHRpZXJpbmcsIGFuZAo+ID4gPiBt
YW5hZ2VtZW50LiBXZSB3aWxsIHNoYXJlIHNvbWUgZWFybHkgY29uY2VwdHVhbCByZXN1bHRzIGFu
ZCBwcm9wb3NlZAo+ID4gPiBzYWxpZW50IGRlc2lnbiBnb2FscyBhbmQgY2hhbGxlbmdlcyBzdXJy
b3VuZGluZyBhbiBOVk1lIEhERC4KPiA+Cj4gPiBIREQuIHBlcmZvcm1hbmNlIGlzIHZlcnkgc2Vu
c2l0aXZlIHRvIElPIG9yZGVyLiBDb3VsZCB5b3UgcHJvdmlkZSBzb21lCj4gPiBiYWNrZ3JvdW5k
IGluZm8gYWJvdXQgTlZNZSBIREQ/IFN1Y2ggYXM6Cj4gPgo+ID4gLSBudW1iZXIgb2YgaHcgcXVl
dWVzCj4gPiAtIGh3IHF1ZXVlIGRlcHRoCj4gPiAtIHdpbGwgTlZNZSBzb3J0L21lcmdlIElPIGFt
b25nIGFsbCBTUXMgb3Igbm90Pwo+ID4KPiA+ID4KPiA+ID4KPiA+ID4gRGlzY3Vzc2lvbiBQcm9w
b3NhbDoKPiA+ID4KPiA+ID4gV2XigJlkIGxpa2UgdG8gc2hhcmUgb3VyIHZpZXdzIGFuZCBzb2xp
Y2l0IGlucHV0IG9uOgo+ID4gPgo+ID4gPiAtV2hhdCBMaW51eCBzdG9yYWdlIHN0YWNrIGFzc3Vt
cHRpb25zIGRvIHdlIG5lZWQgdG8gYmUgYXdhcmUgb2YgYXMgd2UKPiA+ID4gZGV2ZWxvcCB0aGVz
ZSBkZXZpY2VzIHdpdGggZHJhc3RpY2FsbHkgZGlmZmVyZW50IHBlcmZvcm1hbmNlCj4gPiA+IGNo
YXJhY3RlcmlzdGljcyB0aGFuIHRyYWRpdGlvbmFsIE5BTkQ/IEZvciBleGFtcGxlLCB3aGF0IHNj
aGVkdWxhciBvcgo+ID4gPiBkZXZpY2UgZHJpdmVyIGxldmVsIGNoYW5nZXMgd2lsbCBiZSBuZWVk
ZWQgdG8gaW50ZWdyYXRlIE5WTWUgSEREcz8KPiA+Cj4gPiBJTyBtZXJnZSBpcyBvZnRlbiBpbXBv
cnRhbnQgZm9yIEhERC4gSU8gbWVyZ2UgaXMgdXN1YWxseSB0cmlnZ2VyZWQgd2hlbgo+ID4gLnF1
ZXVlX3JxKCkgcmV0dXJucyBTVFNfUkVTT1VSQ0UsIHNvIGZhciB0aGlzIGNvbmRpdGlvbiB3b24n
dCBiZQo+ID4gdHJpZ2dlcmVkIGZvciBOVk1lIFNTRC4KPiA+Cj4gPiBBbHNvIGJsay1tcSBraWxs
cyBCREkgcXVldWUgY29uZ2VzdGlvbiBhbmQgaW9jIGJhdGNoaW5nLCBhbmQgY2F1c2VzCj4gPiB3
cml0ZWJhY2sgcGVyZm9ybWFuY2UgcmVncmVzc2lvblsxXVsyXS4KPiA+Cj4gPiBXaGF0IEkgYW0g
dGhpbmtpbmcgaXMgdGhhdCBpZiB3ZSBuZWVkIHRvIHN3aXRjaCB0byB1c2UgaW5kZXBlbmRlbnQg
SU8KPiA+IHBhdGggZm9yIGhhbmRsaW5nIFNTRCBhbmQgSERELiBJTywgZ2l2ZW4gdGhlIHR3byBt
ZWRpdW1zIGFyZSBzbwo+ID4gZGlmZmVyZW50IGZyb20gcGVyZm9ybWFuY2Ugdmlld3BvaW50Lgo+
ID4KPiA+IFsxXSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0
cHMtM0FfX2xvcmUua2VybmVsLm9yZ19saW51eC0yRHNjc2lfUGluZS5MTlguNC40NEwwLjE5MDkx
ODEyMTMxNDEuMTUwNy0yRDEwMDAwMC00MGlvbGFudGhlLnJvd2xhbmQub3JnXyZkPUR3SUZhUSZj
PUlHRGxnMGxEMGItbmVibUpKMEtwOEEmcj1OVzFYMHlSSE5ORWx1WjhzT0dYQnhDYlFKWlBXY0lr
UFQwVXkzeW5Wc0ZVJm09cFNuSHB0X3VRUTczSlY0VklRZzFDX1BWQWNMdnFCQnRteXhRSHdXakdT
TSZzPXRzbkZQOGJRSUFxN0c2NkI3NUxUZTN2bzRLMTRIYkw5SkpLc3hsX0xQQXcmZT0KPiA+IFsy
XSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xv
cmUua2VybmVsLm9yZ19saW51eC0yRHNjc2lfMjAxOTEyMjYwODM3MDYuR0ExNzk3NC00MG1pbmcu
dDQ2MHBfJmQ9RHdJRmFRJmM9SUdEbGcwbEQwYi1uZWJtSkowS3A4QSZyPU5XMVgweVJITk5FbHVa
OHNPR1hCeENiUUpaUFdjSWtQVDBVeTN5blZzRlUmbT1wU25IcHRfdVFRNzNKVjRWSVFnMUNfUFZB
Y0x2cUJCdG15eFFId1dqR1NNJnM9R0p3U3hYdGNfcVpIS25yVHFTYnl0VWp1UnJyUWdacHZWM2J4
WllGREhlNCZlPQo+ID4KPiA+Cj4gPiBUaGFua3MsCj4gPiBNaW5nCj4gPgo+IAo+IEkgd291bGQg
ZXhwZWN0IHRoZSBkcml2ZSB3b3VsZCBzdXBwb3J0IGEgcmVhc29uYWJsZSBudW1iZXIgb2YgcXVl
dWVzCj4gYW5kIGEgcmVsYXRpdmVseSBkZWVwIHF1ZXVlIGRlcHRoLCBtb3JlIGluIGxpbmUgd2l0
aCBOVk1lIHByYWN0aWNlcwo+IHRoYW4gU0FTIEhERCdzIHR5cGljYWwgMTI4LiBCdXQgaXQgcHJv
YmFibHkgZG9lc24ndCBtYWtlIHNlbnNlIHRvCj4gcXVldWUgdXAgdGhvdXNhbmRzIG9mIGNvbW1h
bmRzIG9uIHNvbWV0aGluZyBhcyBzbG93IGFzIGFuIEhERCwgYW5kCj4gbWFueSBjdXN0b21lcnMg
a2VlcCBxdWV1ZXMgPCAzMiBmb3IgbGF0ZW5jeSBtYW5hZ2VtZW50LgoKTVEgJiBkZWVwIHF1ZXVl
IGRlcHRoIHdpbGwgY2F1c2UgdHJvdWJsZSBmb3IgSERELiwgYXMgRGFtaWVuIG1lbnRpb25lZCwg
CklPIHRpbWVvdXQgbWF5IGJlIGNhdXNlZC4gVGhlbiBsb29rcyB5b3UgbmVlZCB0byBhZGQgcGVy
LW5zIHF1ZXVlIGRlcHRoLApqdXN0IGxpa2Ugd2hhdCBzZGV2LT5kZXZpY2VfYnVzeSBkb2VzIGZv
ciBhdm9pZGluZyBJTyB0aW1lb3V0LiBPbiB0aGUKb3RoZXIgaGFuZCwgd2l0aCBwZXItbnMgcXVl
dWUgZGVwdGgsIHlvdSBtYXkgcHJldmVudCBJTyBzdWJtaXR0ZWQgdG8gTlZNZQp3aGVuIHRoaXMg
bnMgaXMgc2F0dXJhdGVkLCB0aGVuIGJsb2NrIGxheWVyJ3MgSU8gbWVyZ2UgY2FuIGJlIHRyaWdn
ZXJlZC4KCj4gCj4gTWVyZ2UgYW5kIGVsZXZhdG9yIGFyZSBpbXBvcnRhbnQgdG8gSEREIHBlcmZv
cm1hbmNlLiBJIGRvbid0IGJlbGlldmUKPiBOVk1lIHNob3VsZCBhdHRlbXB0IHRvIG1lcmdlL3Nv
cnQgYWNyb3NzIFNRcy4gQ2FuIE5WTWUgbWVyZ2Uvc29ydAo+IHdpdGhpbiBhIFNRIHdpdGhvdXQg
ZHJpdmluZyBsYXJnZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIFNTRCAmIEhERCBkYXRhCj4gcGF0aHM/
CgpJZiBOVk1lIGRvZXNuJ3Qgc29ydC9tZXJnZSBhY3Jvc3MgU1FzLCBpdCBzaG91bGQgYmUgYmV0
dGVyIHRvIGp1c3QgdXNlCnNpbmdsZSBxdWV1ZSBmb3IgSERELiBPdGhlcndpc2UsIGl0IGlzIGVh
c3kgdG8gYnJlYWsgSU8gb3JkZXIgJiBtZXJnZS4KCkV2ZW4gc29tZW9uZSBjb21wbGFpbnMgdGhh
dCBzZXF1ZW50aWFsIElPIGJlY29tZXMgZGlzLWNvbnRpbnVvdXMgb24KTlZNZShTU0QpIHdoZW4g
YXJiaXRyYXRpb24gYnVyc3QgaXMgbGVzcyB0aGFuIElPIHF1ZXVlIGRlcHRoLiBJdCBpcyBzYWlk
CmZpbyBwZXJmb3JtYW5jZSBpcyBodXJ0LCBidXQgSSBkb24ndCB1bmRlcnN0YW5kIGhvdyB0aGF0
IGNhbiBoYXBwZW4gb24KU1NELgoKClRoYW5rcywKTWluZwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

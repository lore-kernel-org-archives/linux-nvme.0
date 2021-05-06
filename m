Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6906C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 06:14:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C99611CB
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 06:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C99611CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ntvx7gLi/Oup+W+uqvXA2A372tVyUgep+drMJHAjPVU=; b=hMDV4to7gdbj8YX2kfFU/3uLw
	WBRK63zng+a4OdpYtWOARVzaRMYuQkhQWSFr2iZZHmBESbgLjASE2TkPZ0ZnOCgv4CgflfivLqP5B
	l/lVqEhAC0cL/Qb9XoYpDK4x2035qGUPWDMBo0DDS2f1GxoCCYQ6mzoWELiBEczL/g9g+XgKoFlVb
	cTdjUNO156ryu0+UAuu82OWKOjBVy70pUXO7BcAn/AW71wORcIb5qdNxIZ/WFCas0dk9ma0M6mbUO
	y7gKuOHkbaHayVw7VIvmWN8IFOb0y5qhVR2fo3Ij63Pww/y/XazsStpLEdxSSnbJKUp85mW0LG9N8
	GvL7hctiQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leXGq-003KFo-FG; Thu, 06 May 2021 06:14:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leXGn-003KEx-8Y
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 06:13:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=FL2UumW3ZmshNPp11uT2r0OXcoOcizUuoebyxBLKCh8=; b=nEPK8a23NLNLULwBbtxPpDeEC0
 XOohddKQWYyV7fpe7X5Xp1T62MfLluS5HbW3aYRxAq8aphmH92lG/SBe564hRXRixBo8TpfJ97rbh
 q3tl2AqDnVcD1HIA9DHtRhqXwzm1W1X2EEah8zURIcfx4vQj4mo8Hp5fclhBbaShRzfUHZMs1S7D1
 /R5R69FP6IwzYAGh7gL4YMWuotjgFXQdNgDnYzwFaf4p07KSlUml/Lf8XKata3d6hFXbGnpCmEqVp
 Wii0q6usgDlltDlplRkto424bTO2i2BM9QfwPjb2bGEpLfWqnMPHXYHn4Sjl0RbcZ7VgBTYlECgC2
 64Fjzt2w==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leXGk-005d0j-3j
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 06:13:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C34F7B19A;
 Thu,  6 May 2021 06:13:52 +0000 (UTC)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210505152659.GB912679@dhcp-10-100-145-180.wdc.com>
 <6a43fe69-e73a-07f8-f050-8116add83074@suse.de>
 <8a274c79-6db8-a21b-e60e-4e73a9d139b5@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2260f3ca-2e27-b2ad-d1c0-6747897e9557@suse.de>
Date: Thu, 6 May 2021 08:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <8a274c79-6db8-a21b-e60e-4e73a9d139b5@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_231354_465379_29541FCC 
X-CRM114-Status: GOOD (  26.32  )
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

T24gNS81LzIxIDEwOjQwIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4+Pj4gQXMgc3Rh
dGVkIGluIHRoZSB2MyByZXZpZXcgdGhpcyBpcyBhbiBpbmNvbXBhdGlibGUgY2hhbmdlLsKgIFdl
J2xsIAo+Pj4+Pj4gbmVlZAo+Pj4+Pj4gdGhlIHF1ZXVlX2lmX25vX3BhdGggYXR0cmlidXRlIGZp
cnN0LCBhbmQgZGVmYXVsdCBpdCB0byBvbiB0byBrZWVwCj4+Pj4+PiBjb21wYXRhYmlsaXR5Lgo+
Pj4+Pj4KPj4+Pj4KPj4+Pj4gVGhhdCBpcyB3aGF0IEkgdHJpZWQgdGhlIGxhc3QgdGltZSwgYnV0
IHRoZSBkaXJlY3Rpb24gSSBnb3Qgd2FzIHRvIAo+Pj4+PiB0cmVhdAo+Pj4+PiBib3RoLCBOVk1l
LVBDSSBhbmQgTlZNZS1vRiBpZGVudGljYWxseToKPj4+Pj4gKGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LW52bWUvMzRlNWMxNzgtOGJjNC02OGQzLTgzNzQtZmJjMWI0NTFiNmU4QGdyaW1i
ZXJnLm1lLykgCj4+Pj4+Cj4+Pj4KPj4+PiBZZXMsIEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQg
eW91ciBjb21tZW50IENocmlzdG9waC4gVGhpcyAKPj4+PiBhZGRyZXNzZXMgYW4KPj4+PiBpc3N1
ZSB3aXRoIG1kcmFpZCB3aGVyZSBob3QgdW5wbHVnK3JlcGx1ZyBkb2VzIG5vdCByZXN0b3JlIHRo
ZSAKPj4+PiBkZXZpY2UgdG8KPj4+PiB0aGUgcmFpZCBncm91cCAocGNpIGFuZCBmYWJyaWNzIGFs
aWtlKSwgd2hlcmUgYmVmb3JlIG11bHRpcGF0aCB0aGlzIAo+Pj4+IHVzZWQKPj4+PiB0byB3b3Jr
Lgo+Pj4+Cj4+Pj4gcXVldWVfaWZfbm9fcGF0aCBpcyBhIGRtLW11bHRpcGF0aCBmZWF0dXJlIHNv
IEknbSBub3QgZW50aXJlbHkgY2xlYXIKPj4+PiB3aGF0IGlzIHRoZSBjb25jZXJuPyBtZHJhaWQg
b24gbnZtZSAocGNpL2ZhYnJpY3MpIHVzZWQgdG8gd29yayBhIAo+Pj4+IGNlcnRhaW4KPj4+PiB3
YXksIHdpdGggdGhlIGludHJvZHVjdGlvbiBvZiBudm1lLW1wYXRoIHRoZSBiZWhhdmlvciB3YXMg
YnJva2VuIChhcyAKPj4+PiBmYXIKPj4+PiBhcyBJIHVuZGVyc3RhbmQgZnJvbSBIYW5uZXMpLgo+
Pj4+Cj4+Pj4gTXkgdGhpbmtpbmcgaXMgdGhhdCBpZiB3ZSB3YW50IHF1ZXVlX2lmX25vX3BhdGgg
ZnVuY3Rpb25hbGl0eSBpbiBudm1lCj4+Pj4gbXBhdGggd2Ugc2hvdWxkIGhhdmUgaXQgZXhwbGlj
aXRseSBzdGF0ZWQgcHJvcGVybHkgc3VjaCB0aGF0IHBlb3BsZQo+Pj4+IHRoYXQgYWN0dWFsbHkg
bmVlZCBpdCB3aWxsIHVzZSBpdCBhbmQgaGF2ZSBtZHJhaWQgZnVuY3Rpb24gY29ycmVjdGx5Cj4+
Pj4gYWdhaW4uIEFsc28sIHF1ZXVlX2lmX25vX3BhdGggYXBwbGllcyByZWFsbHkgaWYgYWxsIHRo
ZSBwYXRocyBhcmUKPj4+PiBnb25lIGluIHRoZSBzZW5zZSB0aGV5IGFyZSBjb21wbGV0ZWx5IHJl
bW92ZWQsIGFuZCBkb2Vzbid0IGFwcGx5Cj4+Pj4gdG8gY29udHJvbGxlciByZXNldC9yZWNvbm5l
Y3QuCj4+Pj4KPj4+PiBJIGFncmVlIHdlIHNob3VsZCBwcm9iYWJseSBoYXZlIHF1ZXVlX2lmX25v
X3BhdGggYXR0cmlidXRlIG9uIHRoZQo+Pj4+IG1wYXRoIGRldmljZSwgYnV0IGl0IGRvZXNuJ3Qg
c291bmQgcmlnaHQgdG8gZGVmYXVsdCBpdCB0byB0cnVlIGdpdmVuCj4+Pj4gdGhhdCBpdCBicmVh
a3MgbWRyYWlkIHN0YWNraW5nIG9uIHRvcCBvZiBpdC4uCj4+Pgo+Pj4gSWYgeW91IHdhbnQgInF1
ZXVlX2lmX25vX3BhdGgiIGJlaGF2aW9yLCBjYW4ndCB5b3UganVzdCBzZXQgcmVhbGx5IGhpZ2gK
Pj4+IHJlY29ubmVjdF9kZWxheSBhbmQgY3RybF9sb3NzX3RtbyB2YWx1ZXM/IFRoYXQgcHJldmVu
dHMgdGhlIHBhdGggZnJvbQo+Pj4gYmVpbmcgZGVsZXRlZCB3aGlsZSBpdCBpcyB1bnJlYWNoYWJs
ZSwgdGhlbiByZXN0YXJ0IElPIG9uIHRoZSBleGlzdGluZwo+Pj4gcGF0aCBvbmNlIGNvbm5lY3Rp
b24gaXMgcmUtZXN0YWJsaXNoZWQuCj4+Pgo+PiBQcmVjaXNlbHkgbXkgdGhpbmtpbmcuCj4+IFdl
IF9jb3VsZF8gYWRkIGEgcXVldWVfaWZfbm9fcGF0aCBhdHRyaWJ1dGUsIGJ1dCB3ZSBjYW4gYWxz
byBhY2hpZXZlIHRoZQo+PiBzYW1lIGJlaGF2aW91ciBieSBzZXR0aW5nIHRoZSBjdHJsX2xvc3Nf
dG1vIHZhbHVlIHRvIGluZmluaXR5Lgo+PiBQcm92aWRlZCB3ZSBjYW4gY2hhbmdlIGl0IG9uIHRo
ZSBmbHksIHRob3VnaDsgYnV0IGl0IG5vdCB0aGF0J3MgZWFzaWx5Cj4+IGZpeGVkLgo+Pgo+PiBJ
biBmYWN0LCB0aGF0J3Mgd2hhdCB3ZSByZWNvbW1lbmQgdG8gb3VyIGN1c3RvbWVycyB0byBhdm9p
ZCB0aGUgYnVnCj4+IGZpeGVkIGJ5IHRoaXMgcGF0Y2guCj4gCj4gWW91IGNhbiBjaGFuZ2UgY3Ry
bF9sb3NzX3RtbyBvbiB0aGUgZmx5LiBIb3cgZG9lcyB0aGF0IGFkZHJlc3MgdGhlCj4gaXNzdWU/
IHRoZSBvcmlnaW5hbCBpc3N1ZSBpcyBjdHJsX2xvc3NfdG1vIGV4cGlyZXMgZm9yIGZhYnJpY3M/
IG9yCj4gcGNpIHVucGx1ZyAod2hpY2ggY3RybF9sb3NzX3RtbyBkb2VzIG5vdCBhcHBseSB0byBp
dCk/CgpZZXMuIEl0IGJlY29tZXMgcGFydGljdWxhcmx5IG5vdGljZWFibGUgaW4gVENQIGZhYnJp
Y3Mgd2hlcmUgdGhlIGxpbmsgCmNhbiBnbyBkb3duIGZvciBhbiBleHRlbmRlZCB0aW1lLgpUaGUg
c3lzdGVtIHdpbGwgdHJ5IHRvIHJlY29ubmVjdCB1bnRpbCBjdHJsX2xvc3NfdG1vIGtpY2tzIGlu
OyBpZiB0aGUgCmxpbmsgZ2V0cyByZWVzdGFibGlzaGVkIGFmdGVyIHRoYXQgdGltZSB5b3VyIHN5
c3RlbSBpcyBob3NlZC4KCldpdGggdGhpcyBwYXRjaCBJL08gaXMgc3RpbGwga2lsbGVkLCBidXQg
YXQgbGVhc3QgeW91IGNhbiB0aGVuIApyZS1lc3RhYmxpc2ggdGhlIGNvbm5lY3Rpb24gYnkganVz
dCBjYWxsaW5nCgpudm1lIGNvbm5lY3QKCmFuZCB0aGUgbnZtZSBkZXZpY2Ugd2lsbCBiZSByZWNv
bm5lY3RlZCBzdWNoIHRoYXQgeW91IGNhbiBjYWxsCgptZGFkbSAtLXJlLWFkZAoKdG8gcmVzeW5j
IHRoZSBkZXZpY2UuCldpdGggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24geW91IGFyZSBvdXQg
b2YgbHVjayBhcyBJL08gaXMgcGVuZGluZyBvbiAKdGhlIGRpc2Nvbm5lY3RlZCBvcmlnaW5hbCBu
dm1lIGRldmljZSwgYW5kIHlvdSBoYXZlIG5vIGNoYW5jZSB0byBmbHVzaCAKdGhhdC4gQ29uc2Vx
dWVudGx5IHlvdSBjYW4ndCBkZXRhY2ggaXQgZnJvbSB0aGUgTUQgYXJyYXksIGFuZCwgYWdhaW4s
IAp5b3VyIHN5c3RlbSBpcyBob3NlZC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBS
ZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNl
LmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhS
QiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7Zy
ZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

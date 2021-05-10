Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783CEC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 14:49:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D47560FDA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 14:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D47560FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CkhatKZDTAuCJ109S9b4fyXkMhnYVxJpdV8VmrDkzgg=; b=gj2vYHoVpfP71BBe0IH+3hxTt
	kKPQq/nRS94mPjHMF+YdGFYN+M24JcC4To2CxEvc2XQLUnpS6yQsVaTeCQiS9ibBzPp45glaIlJEh
	bFvC1L4UqVXJS3Zf2NFNR2+cnVQudaeGxQeAjWQ9EMmaWm7R2I72CiYats7RSYncdxdFaQOexgsYw
	BuDBo++TIaEbKrn3Wgs6QZyXX4eAnLJB/cN34S517A0qfh+civ+ychDZwI7wReeDu/RHETHiaLIPw
	8M3O3qzi1jOCCJLmR/Gm3CWxgafbTChSvLi0Hc8OWiAtCOFsx/w5fBRr/exCfw1Vv4PNRswQNwNXX
	62wcC3duQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lg7DB-00EgA0-SZ; Mon, 10 May 2021 14:48:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg7D7-00Eg8j-QK
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 14:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=BrW5ou1JiwVO6WgGzEZgbdTkAdKkCy6VYrdBOPsLzQ0=; b=bJ2Pi8oKWaOTAaEVjiF4a8OUcQ
 nyHYYIVTTNQxF9kukT5MX8SJowJbka5cx98uvUyalo1SO8l9RK9s1+S2scxe1kMPTiZ5W6CQbzOGV
 OzovBhhDjszJQr/774/K/1+mUOOutSJcKui7rrybQKei7uLdf2BN4MRvRLS/fQw/AJ1tpJ6uPfRQv
 SmYbWBZ19h6f/ADpf5K0RF3qjuNIhMOsdUDyRib35jLqgvnSLs/mmX8KEygFbsrUjVXfVsayNOnDs
 RvhS+hds3fw29bUQeZWhkLwJPkMSWD75vuEC8q4aezFg0g9X2TbpxkWo83eZx8xD0S81AcA7nu3RP
 chGcZCfA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg7D4-008pOH-WA
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 14:48:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9D042B148;
 Mon, 10 May 2021 14:48:37 +0000 (UTC)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <daniel.wagner@suse.de>
References: <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
 <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
 <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
 <20210506120855.GA1546@lst.de> <7cd891d9-6aa0-fd98-cbc5-1df2eabbe31d@suse.de>
 <20210507064656.GA24437@lst.de>
 <4fd33328-9060-6e95-dd26-ab013e44c07a@suse.de>
 <20210510062346.GA30116@lst.de>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <deb2beb3-5aec-b439-3ce3-6c04f7badc45@suse.de>
Date: Mon, 10 May 2021 16:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210510062346.GA30116@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_074839_199578_98164631 
X-CRM114-Status: GOOD (  19.01  )
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

T24gNS8xMC8yMSA4OjIzIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBGcmksIE1h
eSAwNywgMjAyMSBhdCAwNzowMjo1MlBNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IE9uIDUvNy8yMSA4OjQ2IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+IE9uIFRodSwg
TWF5IDA2LCAyMDIxIGF0IDA1OjU0OjI5UE0gKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToK
Pj4+PiBQQ0kgYW5kIGZhYnJpY3MgaGF2ZSBkaWZmZXJlbnQgZGVmYXVsdHM7IGZvciBQQ0kgdGhl
IGRldmljZSBnb2VzIGF3YXkgaWYKPj4+PiB0aGUgbGFzdCBwYXRoIChpZSB0aGUgY29udHJvbGxl
cikgZ29lcyBhd2F5LCBmb3IgZmFicmljcyBpdCBkb2Vzbid0IGlmIHRoZQo+Pj4+IGRldmljZSBp
cyBtb3VudGVkLgo+Pj4KPj4+IEVyciwgbm8uICBGb3IgZmFicmljcyB3ZSByZWNvbm5lY3QgYSB3
aGlsZSwgYnV0IG90aGVyd2lzZSB0aGUgYmVoYXZpb3IKPj4+IGlzIHRoZSBzYW1lIHJpZ2h0IG5v
dy4KPj4+Cj4+IE5vLCB0aGF0IGlzIG5vdCB0aGUgY2FzZS4KPj4KPj4gV2hlbiBhIFBDSSBudm1l
IGRldmljZSB3aXRoIENNSUM9MCBpcyByZW1vdmVkICh2aWEgcGNpIGhvdHBsdWcsIHNheSksIHRo
ZSAKPj4gbnZtZSBkZXZpY2UgaXMgY29tcGxldGVseSByZW1vdmVkLCBpcnJlc3BlY3RpdmUgb24g
d2hldGhlciBpdCdzIG1vdW50ZWQgb3IgCj4+IG5vdC4KPj4gV2hlbiB0aGUgX3NhbWVfIFBDSSBk
ZXZpY2Ugd2l0aCBDTUlDPTEgaXMgcmVtb3ZlZCwgdGhlIG52bWUgZGV2aWNlIChpZSB0aGUgCj4+
IG5zbmhlYWQpIHdpbGwgX3N0YXlfIHdoZW4gbW91bnRlZCAoYXMgdGhlIHJlZmNvdW50IGlzIG5v
dCB6ZXJvKS4KPiAKPiBZZXMuICBCdXQgdGhhdCBoYXMgbm90aGluZyB0byBkbyB3aXRoIGZhYnJp
Y3MgYXMgeW91IGNsYWltZWQgYWJvdmUsIGJ1dAo+IHdpdGggdGhlIGZhY3QgaWYgdGhlIHN1YnN5
c3RlbSBzdXBwb3J0cyBtdWx0aXBsZSBjb250cm9sbGVyIChhbmQgdGh1cwo+IHNoYXJlZCBuYW1l
c3BhY2VzKSBvciBub3QuCj4gClNvLCBJIHNlZW0gdG8gaGF2ZSByZXByb2R1Y2VkIHRoZSBpc3N1
ZSB3aXRoIGxhdGVzdCBudm1lLTUuMTMuClRoZSBmYWlsdXJlIHBhdHRlcm4gaXMgc2xpZ2h0bHkg
ZGlmZmVyZW50LCBzbyBJIHRoaW5rIEkndmUgYmVlbiBhYmxlIHRvCnNvbHZlIGlzIGluIGEgc2xp
Z2h0bHkgbGVzcyBjb250cm92ZXJzaWFsIG1hbm5lci4KClBhdGNoIHRvIGZvbGxvdy4KCkNoZWVy
cywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJuZWwgU3RvcmFn
ZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2
ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBOw7xybmJlcmcK
R0Y6IEYuIEltZW5kw7ZyZmZlciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

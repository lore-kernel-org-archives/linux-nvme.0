Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CD2C4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:33:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBD223B84
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBD223B84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4oWWcXTDuf5EUD4DMu2GnmsgkdDtXOnK2loSWjnxX+8=; b=gmHmNx9X34nVdT/c4abL91RCx
	l9tsN/cQZRzQIXL7/OUep8PzsuZt3rXhTeT7MzKV2XfCTe01r3Dg9duyhSSrSFVD/txVou2pO5WzC
	Pccve0K5wNJ49dfoY3DNrM3zA6xIgeL21tddhCZfjCrGu4w9VkVbTadROWXqjLuYklEPBSbi9cIoY
	KPrgxVYvExOLuwTAwimBFSHd2FL1mANr18Nkxsk1gIKE+Oaw1WbwC5DAR1OjVW+s6I4aYoIntX7IH
	jTtjnG8NeCy33ScQqCJliBuyY/+yexnZnnkq2Yy4PKmj50qdUZNbwzqehC1p7V6Bhh0xGjbvap7iD
	QUkXslxZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmtyH-0002li-GN; Wed, 09 Dec 2020 07:33:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmtyF-0002l8-Gl
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 07:33:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DD08E68B02; Wed,  9 Dec 2020 08:33:03 +0100 (CET)
Date: Wed, 9 Dec 2020 08:33:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a
Message-ID: <20201209073303.GA10205@lst.de>
References: <20201204161657.16421-1-gtiwari@redhat.com>
 <20201207140428.GA31159@lst.de>
 <989787074.23631599.1607434099327.JavaMail.zimbra@redhat.com>
 <20201208132951.GA847@lst.de>
 <1239878028.23633387.1607434514444.JavaMail.zimbra@redhat.com>
 <20201208135401.GA1238@lst.de>
 <20201208191152.GD27155@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208191152.GD27155@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_023307_676958_C17FC76B 
X-CRM114-Status: GOOD (  16.67  )
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
Cc: Gopal Tiwari <gtiwari@redhat.com>, dmilburn@redhat.com,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDQ6MTE6NTJBTSArMDkwMCwgS2VpdGggQnVzY2ggd3Jv
dGU6Cj4gT24gVHVlLCBEZWMgMDgsIDIwMjAgYXQgMDI6NTQ6MDFQTSArMDEwMCwgQ2hyaXN0b3Bo
IEhlbGx3aWcgd3JvdGU6Cj4gPiBPbiBUdWUsIERlYyAwOCwgMjAyMCBhdCAwODozNToxNEFNIC0w
NTAwLCBHb3BhbCBUaXdhcmkgd3JvdGU6Cj4gPiA+IFRoZXNlIGFyZSB0d28gZGlmZmVyZW50IGRl
dmljZXMuIE9ubHkgb25lIG9mIHRoZSB0d28gTlZNRSBkZXZpY2VzIGlzIHNlZW4uIFRoZSBvdGhl
ciBkZXZpY2UgaXMgcmVqZWN0ZWQgIGR1ZSB0byDigJxEdXBsaWNhdGUgY250bGlk4oCdLiAKPiA+
IAo+ID4gU28gdHdvIGNhcmQgd2l0aCBvbmUgY29udHJvbGxlciBlYWNoLCBhbmQgYm90aCBoYXZl
IHRoZSBzYW1lIHN1Ym5xbi4KPiA+IE9rLiAgSSBndWVzcyB0aGUgcXVpcmsgaXMgZXhhY3RseSBy
aWdodCBpbiB0aGlzIGNhc2UsIGFsdGhvdWdoIEkgd291bGQKPiA+IG5vdCBoYXZlIGV4cGVjdGVk
IHRoaXMgYnVnIGZyb20gYW4gZW50ZXJwcmlzZSBkcml2ZSBmcm9tIGEgc29tZXdoYXQKPiA+IHJl
cHV0YWJsZSB2ZW5kb3IuCj4gCj4gQW5kIGl0IGhhcyBDTUlDIGNhcGFiaWxpdGllcyEgVGhlIHF1
aXJrIG1lYW5zIHdlJ3JlIHVzaW5nIGRyaXZlcgo+IGdlbmVyYXRlZCBucW4ncyBmb3IgbXVsdGlw
YXRoIGRldGVjdGlvbiwgc28gaXQgd29uJ3Qgd29yayB3aXRoCj4gbXVsdGlwYXRoOiB0aGUgZmFr
ZSBucW4gdXNlcyB0aGUgY29udHJvbGxlciBzZXJpYWwgbnVtYmVyLCBzbyBhbGwgdGhlCj4gY29u
dHJvbGxlcnMgaW4gdGhlIHN1YnN5c3RlbSB3aWxsIGdldCBkaWZmZXJlbnQgbnFuJ3MuCgpTTiBp
cyB1bmlxdWV1ZSBmb3IgdGhlIHdob2xlIHN1YnN5c3RlbToKCiJDb250YWlucyB0aGUgc2VyaWFs
IG51bWJlciBmb3IgdGhlIE5WTSBzdWJzeXN0ZW0gdGhhdCBpc+6AgGFzc2lnbmVkIGJ5IHRoZQog
dmVuZG9yIGFzIGFuIEFTQ0lJIHN0cmluZy4iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==

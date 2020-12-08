Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD58C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 19:12:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5CE23B6C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 19:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5CE23B6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H3AftDW/FbeAg4FBMYWyBS1cHAFjp73SAzT3R3t/cTw=; b=vQ1EIN1xT482vHOrYIxJrWy3z
	mCmc5bjYEZow2n9hErYTOmVGtAiACHke78kUQuGG1sKMsdw7pO0W7CrIu02Ofwt4GouWgL738zhwI
	ebdfIIOxaUoohTtGvyTF+EJJy80qtZT/D/gos45CBFBplDg7g3Yj9LtyD0YjXrYYWCmKKlnUGzuOR
	cdTiXxabP6arkBHPe27nXr3DaTimqMTv2zaxJb9ECrc3njismtL+fG4TMd4yShnpmg5N0GdOaq5Bn
	Zyxk5MedtJL9fwNFCkmiKJdefip1ysm4ggVvCSiSTiLAsdYolRO/K9odsBt9pLYbjMi5aGEL1WHEH
	0tgQ8lKDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmiP0-0005Io-Jq; Tue, 08 Dec 2020 19:11:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmiOx-0005IF-Q6
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 19:11:56 +0000
Date: Wed, 9 Dec 2020 04:11:52 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607454715;
 bh=luUbCO5QcY0pL9t/IHkb9xSDk9OLhRiDZM43ADwUJHA=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=eMHP2tkbgqWTIVnBHRi8TQQeLryamChf2Y2lLPCOF3Y8LN5zX2pj+ICTANhs+aEYT
 FgmlKyHDOaZMvfoSkeyF5Fk1qeiN33GCUOCtIB/O0cE/q9EPs+KQQPDYbVl/IpN5Iy
 81oOSRO+RfNatEmeyIArKTriqECbbbyxgi0Z05jrWmZ5BA2xFCxM9bzd5BjJuOf7Uv
 xbFb78uq8PbA73KSgLDJ0o40aSGILOHhYhUOHfRkgGnuQFHYRzmtiyydU42QoPsFKP
 iLKNSwmZnk3CDCbXo9a+Ic8ELP/1oubWt5xZtHA9PPtEqsM/q4I6mO2II/TGwVJ/cL
 oTr/hayQsN31A==
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a
Message-ID: <20201208191152.GD27155@redsun51.ssa.fujisawa.hgst.com>
References: <20201204161657.16421-1-gtiwari@redhat.com>
 <20201207140428.GA31159@lst.de>
 <989787074.23631599.1607434099327.JavaMail.zimbra@redhat.com>
 <20201208132951.GA847@lst.de>
 <1239878028.23633387.1607434514444.JavaMail.zimbra@redhat.com>
 <20201208135401.GA1238@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208135401.GA1238@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_141155_932557_E569CB03 
X-CRM114-Status: GOOD (  12.84  )
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
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBEZWMgMDgsIDIwMjAgYXQgMDI6NTQ6MDFQTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6Cj4gT24gVHVlLCBEZWMgMDgsIDIwMjAgYXQgMDg6MzU6MTRBTSAtMDUwMCwgR29w
YWwgVGl3YXJpIHdyb3RlOgo+ID4gVGhlc2UgYXJlIHR3byBkaWZmZXJlbnQgZGV2aWNlcy4gT25s
eSBvbmUgb2YgdGhlIHR3byBOVk1FIGRldmljZXMgaXMgc2Vlbi4gVGhlIG90aGVyIGRldmljZSBp
cyByZWplY3RlZCAgZHVlIHRvIOKAnER1cGxpY2F0ZSBjbnRsaWTigJ0uIAo+IAo+IFNvIHR3byBj
YXJkIHdpdGggb25lIGNvbnRyb2xsZXIgZWFjaCwgYW5kIGJvdGggaGF2ZSB0aGUgc2FtZSBzdWJu
cW4uCj4gT2suICBJIGd1ZXNzIHRoZSBxdWlyayBpcyBleGFjdGx5IHJpZ2h0IGluIHRoaXMgY2Fz
ZSwgYWx0aG91Z2ggSSB3b3VsZAo+IG5vdCBoYXZlIGV4cGVjdGVkIHRoaXMgYnVnIGZyb20gYW4g
ZW50ZXJwcmlzZSBkcml2ZSBmcm9tIGEgc29tZXdoYXQKPiByZXB1dGFibGUgdmVuZG9yLgoKQW5k
IGl0IGhhcyBDTUlDIGNhcGFiaWxpdGllcyEgVGhlIHF1aXJrIG1lYW5zIHdlJ3JlIHVzaW5nIGRy
aXZlcgpnZW5lcmF0ZWQgbnFuJ3MgZm9yIG11bHRpcGF0aCBkZXRlY3Rpb24sIHNvIGl0IHdvbid0
IHdvcmsgd2l0aAptdWx0aXBhdGg6IHRoZSBmYWtlIG5xbiB1c2VzIHRoZSBjb250cm9sbGVyIHNl
cmlhbCBudW1iZXIsIHNvIGFsbCB0aGUKY29udHJvbGxlcnMgaW4gdGhlIHN1YnN5c3RlbSB3aWxs
IGdldCBkaWZmZXJlbnQgbnFuJ3MuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==

Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BDDC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:37:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3A622242
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3A622242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s3fXgtr8BcqZ36a0uMAata8/DfAGXk9H01BWlhrxmM8=; b=bciZNHNBwzP0ZAdHrTAzdHS7N
	1egBeG5A2tEydUhaTSai5hI5DgesXwEvEMdAeoa6L7qnDhef/MyOcsA76KwShvrBjI1MUJl28A+5p
	4fN7ifLjS9oH22vXLkety/yS/cY6lVbVR2uoiooDtEEqgc260c6Bn9bh+VfLoVBUnyGsOoEnVniMX
	ykS10NKKKtob8yXYB6A3KUVOD4drWWAbiTbhFCv5WEm6D5T+X74ASPN1n+naXz4LZbBuFfpp1ovoH
	aNp0ZZBuL9Zd6iQioG9Uq3XRhxpImgCjrSb2kXytOc/E9quwkiX05fsOiI1k+3XwdODgqvYuU4eSG
	zwXZXLyXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmdAw-0006rl-Mj; Tue, 08 Dec 2020 13:37:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmdAs-0006pn-PS
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 13:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607434622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/e4xQJTlmuw4YEaYh47Qwk2fE/wdtXz9kAlco4S+AA=;
 b=EEuF8ydgTMWqwWOF2DkEW73TsOkH+iaPFgzu3lxMXpzBCxROkNf/jazOqcB3C9MyCpPnt8
 3QdNY11UnLmuFGklMmVe7dFVttnF5eM/vBbSVI6XCAKvaSqhWYJzPHZ3lDzw8I8h+oiVEX
 fgXjD84++HHC4ZwzylVVzXXZcT6+0UI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-vGRY3FG3M_C2gr5IKOUnUw-1; Tue, 08 Dec 2020 08:35:45 -0500
X-MC-Unique: vGRY3FG3M_C2gr5IKOUnUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD4F68B0664;
 Tue,  8 Dec 2020 13:35:14 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4A7560877;
 Tue,  8 Dec 2020 13:35:14 +0000 (UTC)
Received: from zmail20.collab.prod.int.phx2.redhat.com
 (zmail20.collab.prod.int.phx2.redhat.com [10.5.83.23])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id AA8424BB40;
 Tue,  8 Dec 2020 13:35:14 +0000 (UTC)
Date: Tue, 8 Dec 2020 08:35:14 -0500 (EST)
From: Gopal Tiwari <gtiwari@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <1239878028.23633387.1607434514444.JavaMail.zimbra@redhat.com>
In-Reply-To: <20201208132951.GA847@lst.de>
References: <20201204161657.16421-1-gtiwari@redhat.com>
 <20201207140428.GA31159@lst.de>
 <989787074.23631599.1607434099327.JavaMail.zimbra@redhat.com>
 <20201208132951.GA847@lst.de>
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a
MIME-Version: 1.0
X-Originating-IP: [10.64.242.69, 10.4.195.10]
Thread-Topic: nvme: Added QUIRK for Samsung PM1725a
Thread-Index: L4fN6S0WK1UaM6gNKkULPJu1uXAmiw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_083702_987280_954F6CA1 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: kbusch@kernel.org, dmilburn@redhat.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhlc2UgYXJlIHR3byBkaWZmZXJlbnQgZGV2aWNlcy4gT25seSBvbmUgb2YgdGhlIHR3byBOVk1F
IGRldmljZXMgaXMgc2Vlbi4gVGhlIG90aGVyIGRldmljZSBpcyByZWplY3RlZCAgZHVlIHRvIOKA
nER1cGxpY2F0ZSBjbnRsaWTigJ0uIAoKVGhhbmtzIApHb3BhbCAKCi0tLS0tIE9yaWdpbmFsIE1l
c3NhZ2UgLS0tLS0KRnJvbTogIkNocmlzdG9waCBIZWxsd2lnIiA8aGNoQGxzdC5kZT4KVG86ICJH
b3BhbCBUaXdhcmkiIDxndGl3YXJpQHJlZGhhdC5jb20+CkNjOiAiQ2hyaXN0b3BoIEhlbGx3aWci
IDxoY2hAbHN0LmRlPiwga2J1c2NoQGtlcm5lbC5vcmcsIGRtaWxidXJuQHJlZGhhdC5jb20sIGxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpTZW50OiBUdWVzZGF5LCBEZWNlbWJlciA4LCAy
MDIwIDY6NTk6NTEgUE0KU3ViamVjdDogUmU6IFtQQVRDSF0gbnZtZTogQWRkZWQgUVVJUksgZm9y
IFNhbXN1bmcgUE0xNzI1YQoKT24gVHVlLCBEZWMgMDgsIDIwMjAgYXQgMDg6Mjg6MTlBTSAtMDUw
MCwgR29wYWwgVGl3YXJpIHdyb3RlOgo+IEhpIENocmlzdG9waCwKPiAKPiBQbGVhc2UgZmluZCBv
dXRwdXQgZm9yIGJvdGggdGhlIGRldmljZSAuLiAKClNvIGl0IGNsYWltcyAxLjIuMSBjb21wbGlh
bmNlLCBhbmQgdGhlIE5RTiBsb29rcyBsaWtlIGEgdmFsaWQgb25lLgpBbmQgdGhhdCBOUU4gaXMg
dGhlIHNhbWUgZm9yIG11bHRpcGxlIGRldmljZXM/ICBPciBpcyB0aGlzIG9uZSBQQ0llCmRldmlj
ZSB3aXRoIG11bHRpcGxlIGZ1bmN0aW9ucyB0aGF0IHJlcG9ydCB0aGUgc2FtZSBjb250cm9sbGVy
IElEPwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

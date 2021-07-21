Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFEDC07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 02:47:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA2560FE7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 02:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA2560FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strugglers.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KOhvUxzgpn/dAn1bBbbwRbwY7txsPySuJ+8H8RLCsZw=; b=slW3ELbM1NIJHm
	qXGoYv9iFAmjiru9I7RBtxyxvvBcqvOQYMkuc4C8gVJenkaDOYPfZqsWbG8GOCiZp0g4xlAfGq61W
	JbPsxuF4BbHXJXvGInaCW4lzK7SomMEMpCBnWshzqAlQBFoPOPrn6q+AQKMO3lS7lCGz63SwCAdXD
	ZArq8DhfwjOC9Z9BjzQRj7XyMlIANJA0Wvp5T/N0V7AjjNxTo0YzPk1lEPEu6byX5OetU9R1YOyoc
	rdLFMSZF44pE483rkzSmM6i3VDip8pfm+FS7kiaTgy7BJKC1XltMde8mfyCrK0jIRDcQFH2g52tuU
	2QtLRwjjeiVQaT2qmS3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m62Gg-00ELnB-Gt; Wed, 21 Jul 2021 02:47:30 +0000
Received: from mail.bitfolk.com ([2001:ba8:1f1:f019::25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m62Gd-00ELmH-AT
 for Linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 02:47:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
 ; s=alpha;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xuLU2qfW5jmsLdDZtNgGBrhJb4Gkobs3NfmJEsquj4s=; b=3yizJgm0qCV+HMo+QZLfZP9J+H
 i7E/RP4G3kp/9y9SujkMImvQVT/B8vbaspvQUQufblQbGmEmw8FtirZfxzsjEbIpwZD/Zofdj+OEp
 bCD2u3Dk9wNIorK5n18g2or8xSqUZV4e+4b1701+EycQAzH6ai/7qF1cegGttYuynMNBRGKe33TfA
 4AbqkH7+GM2NhYwflJtZs2tAV85hrhiF/kmSNa/6/by8zhIUbXh5rvjeZrRG2JcLNGncus4b1v86+
 dF1T0T10yG36odTtdWwXM33aMxDbdj1X96sxJA+2CGNQGvxhoc3jynmNbkliNRpZ2y9FX00eP9TLp
 GiTLGqZA==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
 (envelope-from <andy@strugglers.net>)
 id 1m62Gb-0002fF-MB; Wed, 21 Jul 2021 02:47:25 +0000
Date: Wed, 21 Jul 2021 02:47:25 +0000
From: Andy Smith <andy@strugglers.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Linux-nvme@lists.infradead.org
Subject: Re: 5.10.40-1 - Invalid SGL for payload:131072 nents:13
Message-ID: <20210721024725.igwl5zyh2gcuav4c@bitfolk.com>
References: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
 <20210721003434.GC2005888@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210721003434.GC2005888@dhcp-10-100-145-180.wdc.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_194727_566646_70195C6F 
X-CRM114-Status: GOOD (  17.57  )
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

SGkgS2VpdGgsCgpPbiBUdWUsIEp1bCAyMCwgMjAyMSBhdCAwNTozNDozNFBNIC0wNzAwLCBLZWl0
aCBCdXNjaCB3cm90ZToKPiBBcmUgeW91IHVzaW5nIHN3aW90bGI/CgpJJ3ZlIGp1c3QgcmVhbGlz
ZWQgdGhhdCB0aGVyZSB3YXMgYW5vdGhlciBjaGFuZ2UgdG8gbXkgY29uZmlnCmJlc2lkZXMgdGhl
IGtlcm5lbCB2ZXJzaW9uOiBJIGluY3JlYXNlZCB0aGUgYW1vdW50IG9mIG1lbW9yeQphbGxvY2F0
ZWQgdG8gZG9tMCBmcm9tIDNHaUIgdG8gOEdpQi4KCklmIEkgdW5kZXJzdGFuZCB0aGluZ3MgY29y
cmVjdGx5IHN3aW90bGIgaXMgbm90IHVzZWQgd2hlbiBtZW1vcnkgaXMKPCA0R2lCLCBzbyBJIHBy
ZXZpb3VzbHkgd291bGQgbm90IGhhdmUgYmVlbiB1c2luZyBzd2lvdGxiIGJ1dCBub3cKd2lsbCBi
ZS4KCldoYXQncyB0aGUgbGVhc3QgaW52YXNpdmUgd2F5IG9mIGRpc2FibGluZyBzd2lvdGxiPyBX
b3VsZCBpdCBiZQoKICAgIHN3aW90bGI9bm9mb3JjZQoKT3IKCiAgICBpb21tdT1vZmYKCk9yIG1h
eWJlCgogICAgc3dpb3RsYj0xCgp0byByZWR1Y2UgaXQgdG8gYW4gYW1vdW50IHRoYXQgd291bGQg
bmV2ZXIgYmUgdXNlZD8KCihHb2luZyBieSBrZXJuZWwgcGFyYW1ldGVycyBhdmFpbGFibGUgaW4g
NS4xMC40MCkKClRoaXMgaXMgYW4gSW50ZWwgc3lzdGVtIGFuZCBJIHNlZSB0aGUgdmFyaW91cyBp
bnRlbF9pb21tdSBwYXJhbWV0ZXJzCmJ1dCBkb24ndCBrbm93IGlmIGFueSBvZiB0aGVtIHdvdWxk
IGJlIG1vcmUgYXBwcm9wcmlhdGUuCgo+IElmIHNvLCB0aGlzIHJlY2VudCBwYXRjaCBzb3VuZHMg
bGlrZSBpdCBzaG91bGQgZml4IG9mZnNldCBpc3N1ZXM6CgpBcyBJIGRvbid0IGhhdmUgYW4gZWFz
eSB3YXkgdG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIG9uIGRlbWFuZCBJCnRoaW5rIEkgd291bGQg
bGlrZSB0byBmaXJzdCB0cnkgZ29pbmcgYmFjayB0byBhIHNpdHVhdGlvbiB3aGVyZQpzd2lvdGxi
IGlzIG5vdCB1c2VkLCB0byBzZWUgaWYgdGhlIHByb2JsZW0gZ29lcyBhd2F5IGluIHRoYXQgY2Fz
ZS4KSGFwcHkgdG8gZG8gbW9yZSBleHBlcmltZW50YXRpb24gbGF0ZXLigKYKClRoYW5rcyEKQW5k
eQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

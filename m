Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BF2C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF4220663
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q25V2ESE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xBFTeAe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF4220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hQBLRBQcIM1tgwJP8DXPWQd31vJeFmMoa0EAmcfF5EA=; b=q25V2ESEOUFzBu+SjNu1ny87dC
	TBkRF2k697VJaVUx/14lIoF0LOY65ecPb7ybvprQiryQFkpnpSI5WFJK0LfMeQhVII42Ues7axdih
	nUn0UA04LgC6pRgx68+NPgveJDZnvIRBUytZJ2miCP4xkNjXGR8OoQ++3ccQG/5WSqrjfSCxWcuNx
	+w6MiMBkz6YW4wyIzsQpSvVo5COgdqvYw1TQdGMisG9/4WkXzPwHzYwBiQg7eePCwBU6KwKjjliHC
	S4dqoI9vBLSTvTe7fSKDrDzv+p9LjtIM4dPHq0DahcC+vcHLWoJcyEdYtouaA7A38lhNPDzFiWIFV
	GpamfL7A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpz79-0006pn-Os; Mon, 29 Jun 2020 19:06:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpz77-0006pL-N2
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 19:06:46 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 90B452064B;
 Mon, 29 Jun 2020 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593457605;
 bh=lYKOELODA4KiSILqoskDg8YT5iR81f5zJokRkkWKqsI=;
 h=From:To:Cc:Subject:Date:From;
 b=xBFTeAe+lRqxcnZRTxt/1w8+lzYOx77dMiFTvagG2i0jmJ/zKb9koYrdz0s3NnD6o
 lW9I0+mJCeYUY5YVFSMRb59TZKAl4wfFMRT1ZCvjQG7gMCzxjtbyztXghNeQJGf9wl
 hffM2Ra3JB4V5h7vU29H7lZVftorPfhRyHXXULrQ=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org
Subject: [PATCHv4 0/5] nvme support for zoned namespace command set
Date: Mon, 29 Jun 2020 12:06:36 -0700
Message-Id: <20200629190641.1986462-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Q2hhbmdlcyBzaW5jZSB2MzoKCiAgUmVwbGFjZWQgb2xkZXIgSUQgY29udHJvbGxlciBkZWZpbml0
aW9uIHdpdGggdGhlIHVwZGF0ZWQgb25lIGZyb20gdGhlCiAgcmF0aWZpZWQgc3BlYyAoemFtZHMg
LT4gemFzbCkuCgogIFZlcmlmeSBwb3dlciBvZiAyIHpvbmUgc2l6ZSAoaW50ZXJuYWwgdGVzdCkK
CiAgQ2hlY2sgZm9yIHZhbGlkIGNhcGFjaXR5IGZvciByZXBvcnQgem9uZXM7IGEgbmFtZXNwYWNl
IGRlbGV0aW9uIGV2ZW50CiAgc2V0cyB0aGUgY2FwYWNpdHkgdG8gMC4gSWYgem9uZSByZXZhbGlk
YXRpb24gaGFwcGVucyBhcm91bmQgdGhlIHNhbWUKICB0aW1lLCB3ZSdkIG5vdCBmaWxsIGluIGFu
eSB6b25lcyBhbmQgaGl0IGEgQlVHKCkgbGF0ZXIgaW4gdGhlCiAgYmxrX3pvbmVfcmV2YWxpZGF0
ZV9kaXNrX3pvbmVzKCkuIChpbnRlcm5hbCB0ZXN0aW5nKQoKICBGaXh1cCBmb3IgaWRlbnRpZnkg
bmFtZXNwYWNlIGRlc2NyaXB0b3JzIHRvIGhpZGUgcmV0cnlhYmxlIGVycm9ycwogIChTYWdpLCBO
aWthbHM7IHJlcXVpcmVzIGEgY3VycmVudGx5IHVuaW5jb3Jwb3JhdGVkIHBhdGNoIGZyb20gU2Fn
aSkKCiAgUmVtb3ZlZCB1bm5lY2Vzc2FyeSBfX0dGUF9aRVJPIChKb2hhbm5lcykKCiAgRW5kaWFu
IGNvbnZlcnNpb24gdHlwbyAoSm9oYW5uZXMpCgogIEFkZGVkIHdhcm5pbmdzIHdoZW4gYSB6b25l
ZCBuYW1lc3BhY2UgY2FuJ3QgYmUgYWRkZWQgKEtsYXVzLCBNYXRpYXMpCgogIEFkZGVkIHJlY2Vp
dmVkIHJldmlld3MKCkJhY2tncm91bmQ6CgpUaGUgTlZNIEV4cHJlc3Mgd29ya2dyb3VwIGhhcyBy
YXRpZmllZCB0ZWNobmljYWwgcHJvcG9zYWxzIGVuYWJsaW5nIG5ldwpjb21tYW5kIHNldHMuIFRo
ZSBzcGVjaWZpY2F0aW9ucyBtYXkgYmUgdmlld2VkIGZyb20gdGhlIGZvbGxvd2luZyBsaW5rOgoK
ICBodHRwczovL252bWV4cHJlc3Mub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy9OVk0tRXhwcmVzcy0x
LjQtUmF0aWZpZWQtVFBzLnppcAoKVGhpcyBzZXJpZXMgaW1wbGVtZW50cyBzdXBwb3J0IGZvciB0
aGUgWm9uZWQgTmFtZXNwYWNlIChaTlMpIENvbW1hbmQgU2V0CmRlZmluZWQgaW4gVFA0MDUzLCBh
bmQgdGhlIE5hbWVzcGFjZSBUeXBlcyBiYXNlIHN1cHBvcnQgaXQgZGVwZW5kcyBvbgpmcm9tIFRQ
NDA1Ni4gQXMgdGhpcyBzZXJpZXMgZGVwZW5kcyBvbiB0aGUgYmxvY2sgbGF5ZXIncyBhcHBlbmQg
c3VwcG9ydAppbmZyYXN0cnVjdHVyZSwgYXBwZW5kLWNhcGFibGUgWk5TIGRldmljZXMgYXJlIHJl
cXVpcmVkIGZvciB0aGlzIHBhdGNoCnNldHMgZW5hYmxpbmcuCgpUaGUgYmxvY2sgbGF5ZXIgaXMg
dXBkYXRlZCB0byBpbmNsdWRlIHRoZSBuZXcgem9uZSB3cml0ZWFibGUgY2FwYWNpdHkKZmVhdHVy
ZSBmcm9tIFpOUywgYW5kIGV4aXN0aW5nIHpvbmUgYmxvY2sgZGV2aWNlIGRyaXZlcnMgYXJlIHVw
ZGF0ZWQgdG8KaW5jb3Jwb3JhdGUgdGhpcyBmZWF0dXJlLgoKQXJhdmluZCBSYW1lc2ggKDEpOgog
IG51bGxfYmxrOiBpbnRyb2R1Y2Ugem9uZSBjYXBhY2l0eSBmb3Igem9uZWQgZGV2aWNlCgpLZWl0
aCBCdXNjaCAoMik6CiAgbnZtZTogc3VwcG9ydCBmb3IgbXVsdGktY29tbWFuZCBzZXQgZWZmZWN0
cwogIG52bWU6IHN1cHBvcnQgZm9yIHpvbmVkIG5hbWVzcGFjZXMKCk1hdGlhcyBCasO4cmxpbmcg
KDEpOgogIGJsb2NrOiBhZGQgY2FwYWNpdHkgZmllbGQgdG8gem9uZSBkZXNjcmlwdG9ycwoKTmlr
bGFzIENhc3NlbCAoMSk6CiAgbnZtZTogaW1wbGVtZW50IEkvTyBDb21tYW5kIFNldHMgQ29tbWFu
ZCBTZXQgc3VwcG9ydAoKIGJsb2NrL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAgNSArLQog
YmxvY2svYmxrLXpvbmVkLmMgICAgICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMvYmxvY2svbnVs
bF9ibGsuaCAgICAgICB8ICAgMSArCiBkcml2ZXJzL2Jsb2NrL251bGxfYmxrX21haW4uYyAgfCAg
MTAgKy0KIGRyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYyB8ICAxNiArKy0KIGRyaXZlcnMv
bnZtZS9ob3N0L01ha2VmaWxlICAgICB8ICAgMSArCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMg
ICAgICAgfCAyMjcgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KIGRyaXZlcnMvbnZtZS9o
b3N0L2h3bW9uLmMgICAgICB8ICAgMiArLQogZHJpdmVycy9udm1lL2hvc3QvbGlnaHRudm0uYyAg
IHwgICA0ICstCiBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyAgfCAgIDIgKy0KIGRyaXZl
cnMvbnZtZS9ob3N0L252bWUuaCAgICAgICB8ICA1MCArKysrKystCiBkcml2ZXJzL252bWUvaG9z
dC96bnMuYyAgICAgICAgfCAyNTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBk
cml2ZXJzL3Njc2kvc2RfemJjLmMgICAgICAgICAgfCAgIDEgKwogaW5jbHVkZS9saW51eC9udm1l
LmggICAgICAgICAgIHwgMTM0ICsrKysrKysrKysrKysrKystCiBpbmNsdWRlL3VhcGkvbGludXgv
Ymxrem9uZWQuaCAgfCAgMTUgKy0KIDE1IGZpbGVzIGNoYW5nZWQsIDY2NyBpbnNlcnRpb25zKCsp
LCA1NSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL252bWUvaG9zdC96
bnMuYwoKLS0gCjIuMjQuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK

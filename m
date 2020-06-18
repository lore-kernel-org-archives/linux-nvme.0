Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EE6C433E3
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1996208C3
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MSoh/HnG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0kqBnJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1996208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3DSOGaxqgUUrdgcBtmNagBAskmXhgDnIm6XM3esLdxc=; b=MSoh/HnG61D8+E
	smFo1J9U3+fwT9BmOk9YzozPr/8T1wC5mUSzFLHiFcCMCMTHOv0lOCcJHxqODdo1dLkYTAJxGHju6
	/coyWMWFaGT3BQV4dwYi4n9N0y3357rO2Mif//LdRrfXYDue5Y8uqATtz+MqNfwWsn8vXb3T9HEoh
	h05yMLVSlqEF9nY6p8KwS0AOOqXUL7KdjvrIrXxP93v52j/QY1F/JRGYRv0x8zy1z8GhQecnOyuN8
	ywEDULFkI1TWVxpDl+6USnaXsUKmXd0Da5HYSS89r7mH3gfMjLRbK8Qhj3vW/MJz78vIo0WVbzEc5
	BpBk1JfOHjHhc9ae/Bzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlvvc-0003Rc-42; Thu, 18 Jun 2020 14:54:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlvvZ-0003On-Ax
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 14:54:06 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7992D20739;
 Thu, 18 Jun 2020 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592492044;
 bh=tTWJjq+muqQxQ0SwSnC1nZeb0snxpyNIOwFazK0TuiI=;
 h=From:To:Cc:Subject:Date:From;
 b=b0kqBnJpK7uAna+CdAsmLxbkeIuWx+Oz4Vc6Ghh/zSWOP7ZVIQIrwvdyeauToBrYx
 hTDK2lLtGuyUD9X9o4mQNCIyDvm4/r58TCMmeocokBhMewkTgOysj1vZRxxsCkyQhO
 hzM3GxJeuD2uxGpftdAU9XufPeLFAt0CUeJtpfWs=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCHv2 0/5] nvme support for zoned namespace command set
Date: Thu, 18 Jun 2020 07:53:49 -0700
Message-Id: <20200618145354.1139350-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_075405_395494_9F8342D8 
X-CRM114-Status: GOOD (  11.00  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

djEtPnYyOgoKICBBZGRyZXNzZWQgc3R5bGUvbml0cy9uYW1pbmcgKENoYWl0YW55YSwgTWFydGlu
LCBEYW5pZWwsIEphdmllcikKCiAgQWRkZWQgWk5TIHRvIHRoZSBLY29uZmlnIGluZm8gZm9yIENP
TkZJR19CTEtfREVWX1pPTkVEIChOaWtsYXMpCgogIFJlbW92ZWQgdW5uZWNlc3NhcnkgbnMgZGVz
Y3JpcHRvcidzICdpZicgY2hlY2sgKE1hcnRpbiwgTmlrbGFzKQoKICBBZGRlZCByZWNlaXZlZCBy
ZXZpZXdzICh0aGFuayB5b3UsIGV2ZXJ5b25lKQoKQmFja2dyb3VuZDoKClRoZSBOVk0gRXhwcmVz
cyB3b3JrZ3JvdXAgaGFzIHJhdGlmaWVkIHRlY2huaWNhbCBwcm9wb3NhbHMgZW5hYmxpbmcgbmV3
CmNvbW1hbmQgc2V0cy4gVGhlIHNwZWNpZmljYXRpb25zIG1heSBiZSB2aWV3ZWQgZnJvbSB0aGUg
Zm9sbG93aW5nIGxpbms6CgogIGh0dHBzOi8vbnZtZXhwcmVzcy5vcmcvd3AtY29udGVudC91cGxv
YWRzL05WTS1FeHByZXNzLTEuNC1SYXRpZmllZC1UUHMuemlwCgpUaGlzIHNlcmllcyBpbXBsZW1l
bnRzIHN1cHBvcnQgZm9yIHRoZSBab25lZCBOYW1lc3BhY2UgKFpOUykgQ29tbWFuZCBTZXQKZGVm
aW5lZCBpbiBUUDQwNTMsIGFuZCB0aGUgTmFtZXNwYWNlIFR5cGVzIGJhc2Ugc3VwcG9ydCBpdCBk
ZXBlbmRzIG9uCmZyb20gVFA0MDU2LiBBcyB0aGlzIHNlcmllcyBkZXBlbmRzIG9uIHRoZSBibG9j
ayBsYXllcidzIGFwcGVuZCBzdXBwb3J0CmluZnJhc3RydWN0dXJlLCBhcHBlbmQtY2FwYWJsZSBa
TlMgZGV2aWNlcyBhcmUgcmVxdWlyZWQgZm9yIHRoaXMgcGF0Y2gKc2V0cyBlbmFibGluZy4KClRo
ZSBibG9jayBsYXllciBpcyB1cGRhdGVkIHRvIGluY2x1ZGUgdGhlIG5ldyB6b25lIHdyaXRlYWJs
ZSBjYXBhY2l0eQpmZWF0dXJlIGZyb20gWk5TLCBhbmQgZXhpc3Rpbmcgem9uZSBibG9jayBkZXZp
Y2UgZHJpdmVycyBhcmUgdXBkYXRlZCB0bwppbmNvcnBvcmF0ZSB0aGlzIGZlYXR1cmUuCgpBcmF2
aW5kIFJhbWVzaCAoMSk6CiAgbnVsbF9ibGs6IGludHJvZHVjZSB6b25lIGNhcGFjaXR5IGZvciB6
b25lZCBkZXZpY2UKCktlaXRoIEJ1c2NoICgyKToKICBudm1lOiBzdXBwb3J0IGZvciBtdWx0aS1j
b21tYW5kIHNldCBlZmZlY3RzCiAgbnZtZTogc3VwcG9ydCBmb3Igem9uZWQgbmFtZXNwYWNlcwoK
TWF0aWFzIEJqw7hybGluZyAoMSk6CiAgYmxvY2s6IGFkZCBjYXBhY2l0eSBmaWVsZCB0byB6b25l
IGRlc2NyaXB0b3JzCgpOaWtsYXMgQ2Fzc2VsICgxKToKICBudm1lOiBpbXBsZW1lbnQgSS9PIENv
bW1hbmQgU2V0cyBDb21tYW5kIFNldCBzdXBwb3J0CgogYmxvY2svS2NvbmZpZyAgICAgICAgICAg
ICAgICAgIHwgICA1ICstCiBibG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICAgfCAgIDEgKwog
ZHJpdmVycy9ibG9jay9udWxsX2Jsay5oICAgICAgIHwgICAxICsKIGRyaXZlcnMvYmxvY2svbnVs
bF9ibGtfbWFpbi5jICB8ICAxMCArLQogZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jIHwg
IDE2ICsrLQogZHJpdmVycy9udm1lL2hvc3QvTWFrZWZpbGUgICAgIHwgICAxICsKIGRyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyAgICAgICB8IDIxOCArKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0KIGRyaXZlcnMvbnZtZS9ob3N0L2h3bW9uLmMgICAgICB8ICAgMiArLQogZHJpdmVycy9udm1l
L2hvc3QvbGlnaHRudm0uYyAgIHwgICA0ICstCiBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGgu
YyAgfCAgIDIgKy0KIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCAgICAgICB8ICA1MSArKysrKyst
CiBkcml2ZXJzL252bWUvaG9zdC96bnMuYyAgICAgICAgfCAyMzggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiBkcml2ZXJzL3Njc2kvc2RfemJjLmMgICAgICAgICAgfCAgIDEgKwog
aW5jbHVkZS9saW51eC9udm1lLmggICAgICAgICAgIHwgMTM3ICsrKysrKysrKysrKysrKysrKy0K
IGluY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oICB8ICAxNSArKy0KIDE1IGZpbGVzIGNoYW5n
ZWQsIDY0OCBpbnNlcnRpb25zKCspLCA1NCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL252bWUvaG9zdC96bnMuYwoKLS0gCjIuMjQuMQoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0Cmxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

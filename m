Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A25C43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 07:22:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B507420726
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 07:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GbpvVad2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KlmUEJw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B507420726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6zNTuSZLj64hM1UIZAwT9Uyzf5cl8Qn+NhXV9ry9hpw=; b=GbpvVad2sFuwfJ
	dkVLTkRhxzjvnrMJ0fVep17PBRM6qT75DOSio4tqHaNeq88qLDHqlB9v2r/8gMy7DJcQD1V3fMfhJ
	6ijhZsHtJCrcAF2mZsqbGH1TcGC2n9o1PSfihaF+k1l8TbFfSreU5fLzZxtOqCt23gmB72vjftE5D
	yBB8ayn7F9wbby5EEePyxvV31D0NZKJs9DIBzU07WbPBk9pSzi6LwahSsWwc5qijP8qIm7RjMVs7U
	eYh0+D96NiRgZ5Ux/3F68g4OfIgo0Hg7AJvWdgn738OIXSBpWtCewMZoiTjYIl+yTCkaeQwR+AsIg
	s2RoA8MVcmj0c6vQhmUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieZqS-0006p2-J5; Tue, 10 Dec 2019 07:22:08 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieZqP-0006l9-LU
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 07:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575962526; x=1607498526;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=doqq867jbB1XlN5M3KhiMchqqvZwRuKH+L3ZdhAzOxo=;
 b=KlmUEJw8s0ozadVly6Fwbwb147x+ETQtQKq9i3iWWr4J1EjwSE3daBwD
 KURd0lSq9HWOBWr4r37CGLM7bnPYLLOhtNG/Ts5B+1XwykyOv0CgV1tbh
 PlYpsthqAHC6qAVowtsz+h90JBcyKB8TiCLVRWoHJ9EXP28e8uFmVS2VZ
 MTWk7xfAwJN8VVwX3jjYL6qX7GiTCc1TrUrcuRvS545q5FGPwTFKTFMfZ
 3kflNQuYz/0RzNRGCIMLOEfZr+/LypK0+fvtgTrIJxYZAU/kRElfJ62yz
 MJE2rNUO+0Fv8R6ZwR6AKtNW+TQXtjQquMlYc30plnhe84m7Fsiq0htYr g==;
IronPort-SDR: XXCLbW5pP56rfbXBJxJZhIxOnLl/GyYecbVUwUOliVQQLZA9NI+6hnqlwU8ew3mrriFIF2DxIc
 DiHwy3lCo5ij+KytUNBJeX/gDkFbcMZBkhmLgCpeT6ARXI8qF9my/qQpElQ7QsnWEM12tEpE63
 Aop5pWgR/sMpwyenFODF92aXDCEojQbSymZFKExu7t+WWJUmWiStOpIaBtW5lJtyTuPEJcMPMi
 ppjeI3AqhlK7HxYroVfm8pAUAnjFgZ5mhzTSCZ02ZobhgP74fBjOMTfdKJbdxYvAcHQwshHqJT
 Z5A=
X-IronPort-AV: E=Sophos;i="5.69,298,1571673600"; d="scan'208";a="125757226"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 15:22:05 +0800
IronPort-SDR: 5NHACC2jHoP2EfCL977+pjO4ur/mFI/F55FoUQmriYRR1pJCF218dRd1XlTqOOgLx3kSJA8kXK
 wgBLTtJ7n0Mz5fLsoDnxwtfQWl+Cor9+IMwekagSvN4Khweo0nY4ZubHoWNgS9Y3J/Hrm78Mcc
 fb1IeuWXpy1DFbiC0x46S9vK/zXTVu3qAzzGRXGnnM+C0Jp5vvkPB7/AHpZKZqu6j/1n5UT3b+
 MQDF3uvnyj+LCIDqlhw/oy3jUAq0ib0GIQxCpTifm86M/opjvqCe3LrcTPB9UfQva6sItaQbvp
 5g9lNErYtSNx0tz4VzCEDoSk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 23:16:20 -0800
IronPort-SDR: MrAYEUTe+wSVmzO6TvoQiZCa+03ATxylKXzS4QUY73umvO/N2Q9vAaFhmH5+YdWYKZMw47PHHb
 1PQIIJ0QzVFVHy4+F9d5ETBc1FX1+BKWMkbfUy6DeIgSj9E7zSBFS3F1O8aYtoNbPjzRZlpCAT
 NLIQL+r4aJ0Gb/91GzbgfMPZjdtiIbr7vvdilFUe6h/KhcsqJAcTcka0SbBWgoH5Ol0guUv8Fd
 U99fV2OgVVNgsHXK9OqL61I9414gTWkcksmPNF8WlOuF1uz8K2UWPW0c3wTus9dXqI0CfsY7Mg
 pl8=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 23:22:05 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: fix per feat data len for get_feature
Date: Mon,  9 Dec 2019 23:22:01 -0800
Message-Id: <20191210072201.9631-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191209_232205_735033_71BE8DD6 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Amit Engel <amit.engel@dell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogQW1pdCBFbmdlbCA8YW1pdC5lbmdlbEBkZWxsLmNvbT4KCkZyb206IEFtaXQgRW5nZWwg
PGFtaXQuZW5nZWxAZGVsbC5jb20+CgpUaGUgZXhpc3RpbmcgaW1wbGVtZW50YXRpb24gZm9yIHRo
ZSBnZXRfZmVhdHVyZSBhZG1pbi1jbWQgZG9lcyBub3QKdXNlIHBlci1mZWF0dXJlIGRhdGEgbGVu
LiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBuZXcgaGVscGVyIGZ1bmN0aW9uCm52bWV0X2ZlYXRf
ZGF0YV9sZW4oKSwgd2hpY2ggaXMgdXNlZCB0byBjYWxjdWxhdGUgcGVyIGZlYXR1cmUgZGF0YSBs
ZW4uClJpZ2h0IG5vdyB3ZSBvbmx5IHNldCBkYXRhIGxlbiBmb3IgZmlkIDB4ODEgKE5WTUVfRkVB
VF9IT1NUX0lEKS4KCkZpeGVzOiBjb21taXQgZTkwNjFjMzk3ODM5ICgibnZtZXQ6IFJlbW92ZSB0
aGUgZGF0YV9sZW4gZmllbGQgZnJvbSB0aGUgbnZtZXRfcmVxIHN0cnVjdCIpCgpTaWduZWQtb2Zm
LWJ5OiBBbWl0IEVuZ2VsIDxhbWl0LmVuZ2VsQGRlbGwuY29tPgpbY2hhaXRhbnlhLmt1bGthcm5p
QHdkYy5jb206CiAxLiBEb24ndCByZS1jYWxjdWxhdGUgY2R3MTAgbnZtZXRfZ2V0X2ZlYXR1cmUo
KSwgdGhhdCBhbHNvIGZpeGVzIHRoZQogICAgZW5kaWFubmVzcy4KwqAzLiBSZW5hbWUgbnZtZXRf
ZmVhdHVyZV9kYXRhX2xlbigpIC0+IG52bWV0X2ZlYXRfZGF0YV9sZW4oKS4KIDQuIEdldCByaWQg
b2YgdGhlIGV4dHJhIHZhcmlhYmxlIGZlYXR1cmUgaW4gbnZtZXRfZmVhdF9kYXRhX2xlbigpLgrC
oDUuIE1hcmsgbnZtZXRfZmVhdF9kYXRhX2xlbigpIHN0YWljIHNpbmNlIHdlIGFyZSB0aGUgb25s
eSB1c2VyLgogNi4gS2VybmVsIHBhdGNoIHN0eWxlIGZpeGVzLgpdClNpZ25lZC1vZmYtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5jb20+Ci0tLQpIaSwKClRo
aXMgcGF0Y2ggaXMgb3JpZ2luYWxseSBwb3N0ZWQgYnkgQW1pdC4gSSd2ZSBmaXhlZCBzb21lIG9m
IHRoZSBpc3N1ZXMKSSBmb3VuZCBkdXJpbmcgdGhlIHJldmlldywgbGlzdGVkIGluIHRoZSBjb21t
aXQgbG9nLgoKUmVnYXJkcywKQ2hhaXRhbnlhCi0tLQogZHJpdmVycy9udm1lL3RhcmdldC9hZG1p
bi1jbWQuYyB8IDEyICsrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWlu
LWNtZC5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwppbmRleCA1NmMyMWI1MDEx
ODUuLjcyYTdlNDFmMzAxOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1j
bWQuYworKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCkBAIC0yNCw2ICsyNCwx
NiBAQCB1MzIgbnZtZXRfZ2V0X2xvZ19wYWdlX2xlbihzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQp
CiAJcmV0dXJuIGxlbjsKIH0KIAorc3RhdGljIHUzMiBudm1ldF9mZWF0X2RhdGFfbGVuKHN0cnVj
dCBudm1ldF9yZXEgKnJlcSwgdTMyIGNkdzEwKQoreworCXN3aXRjaCAoY2R3MTAgJiAweGZmKSB7
CisJY2FzZSBOVk1FX0ZFQVRfSE9TVF9JRDoKKwkJcmV0dXJuIHNpemVvZihyZXEtPnNxLT5jdHJs
LT5ob3N0aWQpOworCWRlZmF1bHQ6CisJCXJldHVybiAwOworCX0KK30KKwogdTY0IG52bWV0X2dl
dF9sb2dfcGFnZV9vZmZzZXQoc3RydWN0IG52bWVfY29tbWFuZCAqY21kKQogewogCXJldHVybiBs
ZTY0X3RvX2NwdShjbWQtPmdldF9sb2dfcGFnZS5scG8pOwpAQCAtNzc4LDcgKzc4OCw3IEBAIHN0
YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfZ2V0X2ZlYXR1cmVzKHN0cnVjdCBudm1ldF9yZXEgKnJl
cSkKIAl1MzIgY2R3MTAgPSBsZTMyX3RvX2NwdShyZXEtPmNtZC0+Y29tbW9uLmNkdzEwKTsKIAl1
MTYgc3RhdHVzID0gMDsKIAotCWlmICghbnZtZXRfY2hlY2tfZGF0YV9sZW4ocmVxLCAwKSkKKwlp
ZiAoIW52bWV0X2NoZWNrX2RhdGFfbGVuKHJlcSwgbnZtZXRfZmVhdF9kYXRhX2xlbihyZXEsIGNk
dzEwKSkpCiAJCXJldHVybjsKIAogCXN3aXRjaCAoY2R3MTAgJiAweGZmKSB7Ci0tIAoyLjIyLjEK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1u
dm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

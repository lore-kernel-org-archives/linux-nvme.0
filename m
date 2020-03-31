Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE97C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 10:37:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EDF20772
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 10:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HvehZZa8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="CzqQ64UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EDF20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VYpJ0iRQIzBaH8KoX0/vzSfNeYQ0RYQAddoW7Fp/oqc=; b=HvehZZa8P7YIcU
	ZokGBNAvfrdEfu0I7IWlZZmD3eW/6LugMO79EecCpIWM9jm1EhLZbAqU5vNFosnt8OhZxfGgOneCt
	/pxCBrzLIuVq3wpe1l2yrIpUISc2fHsJSLcaomn2RuBX5K5sCd8LFMNY9I+btqx/Gez+tIhRh46AW
	mEKxzPoSSMr5BL4G+K8vIpbjLKhv6rn/4JTirm9tfx6AT2J2QH93rPa3vYOWkfW3eikFDmgsSFdnA
	kFPnlQzepWesy5ujrFRF6oLmmwgyAeSV4Z04XwUmlqpfw24J1YSvJsEOjtEzoI77aUve11hWMfDsv
	Wai5UiqzjORWcfuW98bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJEGx-0004Gb-RG; Tue, 31 Mar 2020 10:37:31 +0000
Received: from forward100p.mail.yandex.net ([77.88.28.100])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJEGt-0004FL-MW
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 10:37:30 +0000
Received: from mxback17g.mail.yandex.net (mxback17g.mail.yandex.net
 [IPv6:2a02:6b8:0:1472:2741:0:8b7:317])
 by forward100p.mail.yandex.net (Yandex) with ESMTP id E3D2459800D5;
 Tue, 31 Mar 2020 13:37:17 +0300 (MSK)
Received: from sas1-5ebd8269dbc4.qloud-c.yandex.net
 (sas1-5ebd8269dbc4.qloud-c.yandex.net [2a02:6b8:c14:3611:0:640:5ebd:8269])
 by mxback17g.mail.yandex.net (mxback/Yandex) with ESMTP id PYUQBnmyq3-bHwGoI85;
 Tue, 31 Mar 2020 13:37:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1585651037; bh=FoPOsMmy5sCv8tAjbGh7geJCv5PdqIiR4AUbZL/AuLo=;
 h=In-Reply-To:Cc:From:Date:References:To:Subject:Message-ID;
 b=CzqQ64UKL1gyz7DLBzDjRQjolVhtSMXFBNB3aus+rSOBddpPMxxm/yHwsdYOf7YuI
 QYSDgM4zUT+E6TgxKHIYx/qr0S9h5oOOXjqLPZrlAP6eyTtcNGCWZnijwlvCoY5Z8f
 ILBXyHlPY9LYDOqPJX0wYjkVSYfpp9aWU1qCMBvQ=
Authentication-Results: mxback17g.mail.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by sas1-5ebd8269dbc4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id GgmG7FpGfL-bGWm67d3; Tue, 31 Mar 2020 13:37:16 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Subject: Re: nvme: Duplicate cntlid error
To: linux-nvme <linux-nvme@lists.infradead.org>
References: <3cfc539a-07ba-3757-073e-dc81f9c0c824@yandex.ru>
 <2d02e844-5700-64e9-26dc-50b3958d2ab5@grimberg.me>
From: Alex Talker <alextalker@yandex.ru>
Autocrypt: addr=alextalker@yandex.ru; keydata=
 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
 yQTUMqxFHn/a+cp+b7wLpLIJSg==
Message-ID: <00875be1-c0bd-9b25-efa3-4236421678b7@yandex.ru>
Date: Tue, 31 Mar 2020 13:37:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2d02e844-5700-64e9-26dc-50b3958d2ab5@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_033728_238867_3D8DC6FA 
X-CRM114-Status: GOOD (  10.25  )
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
Cc: maxg@mellanox.com, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CjMvMzEvMjAyMCA5OjQ1IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IFVzaW5nIEZlZG9y
YSAzMSBhcyBhIGhvc3QgSSdtIHRyeWluZyB0byBjb25uZWN0IHRvIDIgbm9kZXMgdGhhdCBob3N0
Cj4+IHN1YnN5c3RlbSB3aXRoIG9uZSBhbmQgdGhlIHNhbWUgTlFOLgo+PiBTbyB3aGVuIEkgY2Fs
bDoKPj4gwqAgbnZtZSBjb25uZWN0IC10IHJkbWEgLWEgMTAuMjEuMC4xIC1uCj4+IG5xbi4yMDIw
LTAzLmNvbS5leGFtcGxlOnN1YnN5c3RlbTAKPj4gwqAgZGV2aWNlIG52bWUwIHN1Y2Nlc3NmdWxs
eSBhbGxvY2F0ZWQgYnV0IHdoZW4gdGhlbiBJIGNhbGw6Cj4+IMKgIG52bWUgY29ubmVjdCAtdCBy
ZG1hIC1hIDEwLjIwLjAuMSAtbgo+PiBucW4uMjAyMC0wMy5jb20uZXhhbXBsZTpzdWJzeXN0ZW0w
Cj4+IMKgIEkgZ2V0IGFuIGVycm9yOgo+PiDCoCBbMjM5MzU1LjY2MTUyN10gbnZtZSBudm1lMTog
RHVwbGljYXRlIGNudGxpZCAxIHdpdGggbnZtZTAsIHJlamVjdGluZwo+PiDCoCB3aGF0IGNvdWxk
IGJlIHRoZSBwcm9ibGVtPwo+PiBGZXcgbW9udGhzIGJlZm9yZSBJIGNoZWNrZWQgY29ubmVjdGlv
biB0byBhIHNpbmdsZSBub2RlIHZpYSBmZXcgcG9ydHMKPj4gYW5kIGl0IHdvcmtlZCBvdXQganVz
dCBmaW5lCj4+IGJ1dCBhdHRlbXB0IG9mIEguQS4gc2V0dXAgZmFpbHMgaGVyZS4KPgo+IFlvdXIg
c3Vic3lzdGVtIHByZXNlbnQgdHdvIGNvbnRyb2xsZXJzIHdpdGggdGhlIHNhbWUgY29udHJvbGxl
ciBpZCwgdGhhdAo+IGlzIGEgdmlvbGF0aW9uIG9mIHRoZSBzcGVjLCBhbmQgd2UgcHJvcGVybHkg
cmVqZWN0IHN1Y2ggY29udHJvbGxlcnMuCj4KPiBJbiB1cHN0cmVhbSBjb2RlLCB5b3UgY2FuIHNw
ZWNpZnkgYSBjbnRsaWQgbWluL21heCByYW5nZSBzdWNoIHRoYXQgaWYKPiB5b3UgYXJlIHRyeWlu
ZyB0byBwbGF5IGdhbWVzIHdpdGggZGlmZmVyZW50IGxpbnV4IHRhcmdldHMgYXMgYSBzaW5nbGUK
PiBzdWJzeXN0ZW0geW91IHdvbid0IHZpb2xhdGUgdGhlIHNwZWMuCgpUbyBzdW1tYXJpemUgcHJv
YmxlbSBpcyB0aGF0IGNudGxpZCBpcyBhdXRvbWF0aWNhbGx5IGFsbG9jYXRlZCBpbnNpZGUKdGhl
IHRhcmdldCBkcml2ZXIKCnBlci1jb25uZWN0aW9uIGJ1dCBzaW5jZSB0aGVyZSdzIG5vIHN5bmNo
cm9uaXphdGlvbiBiZXR3ZWVuIHRoZSBub2RlcywKZWFjaCBub2RlIGNvdW50cyBzZXBhcmF0ZWx5
CgphbmQgdGhhdCdzIHdoeSB0aGUgbnVtYmVycyBtYXkgY2xhc2gsIHJpZ2h0PwoKSSd2ZSBjaGVj
a2VkIGFuZCB0aGUgcGF0Y2gKaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1p
dC85NGEzOWQ2MWY4MGZjZDY3OWRlYmRhMTFlMWNhMDJiODhkOTBlNjdlCmlzIGluIGZhY3QgYXZh
aWxhYmxlIG9ubHkgdXBzdHJlYW0KCmJ1dCBub3QgaW4gYW55IE1MTlggT0ZFRCBkcml2ZXIgYmFj
ay1wb3J0LiBEb2VzIE1lbGxhbm94IGhhcyBwbGFucyB0bwppbmNsdWRlIHRoaXMgZmVhdHVyZSBp
biBuZXh0IHJlbGVhc2U/CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK

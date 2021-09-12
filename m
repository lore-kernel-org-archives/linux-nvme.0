Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D03C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 14:07:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CC3610CE
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 14:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21CC3610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QUIJsUatAwp2yLnU001C/KyuTFXgJ73o/47VInsoufA=; b=WC6hlzTPKuDPMm
	O4uGtERyASBF4TWYphh77Etm7j4IgMMZN/5DRhLZpecQLMa7zMAMO9ixKqbTBm1VWs4U63I528ONY
	LLdrEGGyczpVKstUShjaAYQfW2hez4a94SAM0NEUMHyt7lriFzZpcV9V4KGw8uIexhb2TsHQ6LuWV
	o+bSMIzApbQ0C/ZeOUNrkRdGmpDZXfz6QdqaDToT6P5/+JwEu2GpOQ4wF9SUf1J72wBJ4LURMinJR
	2Snl2h/8rudxYgy+yXsueR8SRtjmn4twKF/GmR4aVCFh749iExL4CtWZkbNhQ26umzF4k5sqZFk3H
	Q3sPQJmBkFFK+kDiCwzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPQ8I-00GWHE-3H; Sun, 12 Sep 2021 14:06:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPQ8E-00GWGa-2v
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 14:06:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631455609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rnLyluRx1yvPWVXP9r/aIXvYN3Wcw9A5saWWud/56Ik=;
 b=bv31prG9bSKWfgyaMIb6CTlsMoJjrQA5DlPP+54wNT1WDCloP1kVV2gmxQdm7pF3qCGtAv
 g0WTLuYYg/380kD9hoSkIMEjgQDNuoV1hW7FOd2xXhrevakOM+r5LOaWlDIaaZZQRwMEKh
 /ux7heBbNw0+nIrpzd/N/qYJw6iu370=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-9F2wCUNLPeWwqFS9vSpNJg-1; Sun, 12 Sep 2021 10:06:32 -0400
X-MC-Unique: 9F2wCUNLPeWwqFS9vSpNJg-1
Received: by mail-yb1-f200.google.com with SMTP id
 a23-20020a25ae17000000b005ad73346312so2131296ybj.18
 for <linux-nvme@lists.infradead.org>; Sun, 12 Sep 2021 07:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=rnLyluRx1yvPWVXP9r/aIXvYN3Wcw9A5saWWud/56Ik=;
 b=2AXNTSXcRmnJOrrDOyDnYE6I5vBcLmG+hdoSIWnOhacZglM440cpzTN7hb1UBCNsU+
 dGBQNOg7hhFATt+gYwdtXz5Vz0EW11F13mML9svZi5jWrBgmAjjhWQlgz0/4/6drdgbE
 YblhxCKMauBBuAxr7/4PLO/PN/7W9aVzStX08XoZ/aI+WoBmthrILRWN4ooFUV0vozil
 OFirQKRa4hU6LA8uRXwNlNgwKhblD4xYh8ZDiilyXgMhlDHUj8Y8Zf2VRQe2DDHv4xpk
 jm+Rvc8QXFypHCeegBkoPiKevUmENdzh+xLpKGMV+bzaQq7EKeNfXPnv1CzPaE6rWdHN
 t7zA==
X-Gm-Message-State: AOAM531Iz08K/ia6I2jzq7vvq7shleTa9KbnSZgSgp/21I9Dq0C9N/kw
 +4yAD3ltIsKD8NhaZyA+0O+Z/PKDx4j1GQI2f0dcxG/PGPXMYyJPRrIF55DuEdQVKcVSK6ZZRkk
 gNCPa/f0jdaSAuIOt9ovB3RfLUrralc7RkumHqyCnf4o=
X-Received: by 2002:a25:6b4d:: with SMTP id o13mr8876322ybm.241.1631455592145; 
 Sun, 12 Sep 2021 07:06:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKnObZrmA4iA8UelzE8o4nhCUwSaoGaZZNw8zNZ/q2hfSOq0GRBPWP6pIhMuEmuoU3tq7gazvml+56ZE6jVVo=
X-Received: by 2002:a25:6b4d:: with SMTP id o13mr8876299ybm.241.1631455591859; 
 Sun, 12 Sep 2021 07:06:31 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 12 Sep 2021 22:06:20 +0800
Message-ID: <CAHj4cs94pDUfSSfij=ENQxL-2PaGrHJSnhn_mHTC+hqSvPzBTQ@mail.gmail.com>
Subject: [bug report] nvme0n1 node still exists after blktests nvme-tcp/014 on
 5.13.16-rc1
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: stable@vger.kernel.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210912_070654_428163_CA38DE9B 
X-CRM114-Status: GOOD (  13.20  )
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

SGVsbG8KSSBmb3VuZCB0aGlzIGZhaWx1cmUgb24gc3RhYmxlIDUuMTMuMTYtcmMxWzFdIGFuZCBj
YW5ub3QgcmVwcm9kdWNlIGl0Cm9uIDUuMTQsIHNlZW1zIHdlIGFyZSBtaXNzaW5nIGNvbW1pdFsy
XSBvbiA1LjEzLnksIGNvdWxkIGFueW9uZSBoZWxwCmNoZWNrIGl0PwoKWzFdCiMgbnZtZV90cnR5
cGU9dGNwIC4vY2hlY2sgbnZtZS8wMTQKbnZtZS8wMTQgKGZsdXNoIGEgTlZNZU9GIGJsb2NrIGRl
dmljZS1iYWNrZWQgbnMpICAgICAgICAgICAgIFtwYXNzZWRdCiAgICBydW50aW1lICAzMC43NDVz
ICAuLi4gIDIyLjExMHMKIyBsc2JsawpOQU1FICAgIE1BSjpNSU4gUk0gICBTSVpFIFJPIFRZUEUg
TU9VTlRQT0lOVApzZGEgICAgICAgODowICAgIDAgNDY1LjhHICAwIGRpc2sK4pSc4pSAc2RhMSAg
ICA4OjEgICAgMCAgICAgMUcgIDAgcGFydCAvYm9vdArilJzilIBzZGEyICAgIDg6MiAgICAwICAg
IDE2RyAgMCBwYXJ0IC9tbnQvZG10ZXN0L2RhdGEK4pSc4pSAc2RhMyAgICA4OjMgICAgMCAgICAx
NUcgIDAgcGFydCAvbW50L3hmc3Rlc3RzL21udDEK4pSc4pSAc2RhNCAgICA4OjQgICAgMCAgICAg
MUsgIDAgcGFydArilJzilIBzZGE1ICAgIDg6NSAgICAwICAgIDE1RyAgMCBwYXJ0IC9tbnQveGZz
dGVzdHMvbW50MgrilJzilIBzZGE2ICAgIDg6NiAgICAwICAgNy45RyAgMCBwYXJ0IFtTV0FQXQri
lJzilIBzZGE3ICAgIDg6NyAgICAwICAgICA1RyAgMCBwYXJ0IC9tbnQveGZzdGVzdHMvbG9nd3Jp
dGVzCuKUnOKUgHNkYTggICAgODo4ICAgIDAgICAgIDFHICAwIHBhcnQgL21udC9kbXRlc3QvbWV0
YWRhdGEK4pSU4pSAc2RhOSAgICA4OjkgICAgMCA0MDQuOUcgIDAgcGFydCAvCnpyYW0wICAgMjUy
OjAgICAgMCAgICAgOEcgIDAgZGlzayBbU1dBUF0KbnZtZTBuMSAyNTk6MyAgICAwICAgICAxRyAg
MCBkaXNrCgpbICAxMzMuNzkxNTA3XSBydW4gYmxrdGVzdHMgbnZtZS8wMTQgYXQgMjAyMS0wOS0x
MiAwODowODoxNwpbICAxMzMuOTA4NzUwXSBsb29wMDogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdl
IGZyb20gMCB0byAyMDk3MTUyClsgIDEzMy45Mjc1NTFdIG52bWV0OiBhZGRpbmcgbnNpZCAxIHRv
IHN1YnN5c3RlbSBibGt0ZXN0cy1zdWJzeXN0ZW0tMQpbICAxMzMuOTQyNTE4XSBudm1ldF90Y3A6
IGVuYWJsaW5nIHBvcnQgMCAoMTI3LjAuMC4xOjQ0MjApClsgIDEzMy45Nzc3NDZdIG52bWV0OiBj
cmVhdGluZyBjb250cm9sbGVyIDEgZm9yIHN1YnN5c3RlbQpibGt0ZXN0cy1zdWJzeXN0ZW0tMSBm
b3IgTlFOCm5xbi4yMDE0LTA4Lm9yZy5udm1leHByZXNzOnV1aWQ6YzRjNTAyM2U5YmNkNGNiNTg4
OWU5NTEwNjIyZWI4OGMuClsgIDEzMy45OTQxNzBdIG52bWUgbnZtZTA6IGNyZWF0aW5nIDQgSS9P
IHF1ZXVlcy4KWyAgMTMzLjk5OTg4MV0gbnZtZSBudm1lMDogbWFwcGVkIDQvMC8wIGRlZmF1bHQv
cmVhZC9wb2xsIHF1ZXVlcy4KWyAgMTM0LjAwODY4M10gbnZtZSBudm1lMDogbmV3IGN0cmw6IE5R
TiAiYmxrdGVzdHMtc3Vic3lzdGVtLTEiLCBhZGRyCjEyNy4wLjAuMTo0NDIwClsgIDE1MS4yMjMw
NDldIG52bWUgbnZtZTA6IHVzaW5nIGRlcHJlY2F0ZWQgTlZNRV9JT0NUTF9JT19DTUQgaW9jdGwg
b24KdGhlIGNoYXIgZGV2aWNlIQpbICAxNTUuNjc1NjM0XSBudm1lIG52bWUwOiBSZW1vdmluZyBj
dHJsOiBOUU4gImJsa3Rlc3RzLXN1YnN5c3RlbS0xIgpbICAxNTUuNjgyOTAyXSBibG9jayBudm1l
MG4xOiBubyBhdmFpbGFibGUgcGF0aCAtIGZhaWxpbmcgSS9PClsgIDE1NS42ODkxMzddIGJsb2Nr
IG52bWUwbjE6IG5vIGF2YWlsYWJsZSBwYXRoIC0gZmFpbGluZyBJL08KWyAgMTU1LjY5NTI5NV0g
QnVmZmVyIEkvTyBlcnJvciBvbiBkZXYgbnZtZTBuMSwgbG9naWNhbCBibG9jayAzMiwKYXN5bmMg
cGFnZSByZWFkCgpbMl0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9NTM5NmZkYWM1NmQ4N2QwNGU3NWU1
MDY4YzBjOTJkMzM2MjVmNTFlNwo1Mzk2ZmRhYzU2ZDggbnZtZTogZml4IHJlZmNvdW50aW5nIGlt
YmFsYW5jZSB3aGVuIGFsbCBwYXRocyBhcmUgZG93bgoKCi0tIApCZXN0IFJlZ2FyZHMsCiAgWWkg
WmhhbmcKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

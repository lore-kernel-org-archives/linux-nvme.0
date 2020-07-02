Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B7C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E399920702
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hPnOlerc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jdUUOzes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E399920702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0JJonH10BcJ+Ukl5hSlNJTKbNDDHK/tSP5BimDxY95s=; b=hPnOlercX+e58BEZ3KlO6PQPYu
	OnMwS7ajpzFv0z2Kgabw0yzJvnmjVxeNXRRP9TfpI2oToIedPYsxJS+j654jziFuP1bXcsm9e1yD4
	kOAT1LUyZJANIfZXx7/S55wRZsMR9+2ymbQjhrN69ZoGZ5UQSYuW5EWi+l0ylFybODUbMdGFF6TAx
	GK7JBGxJhgGUtRDqz+Sff8ia0lysetGQWZqPwz03JA9DitMoDOjfWJv/6Crz8AbWKuFYyOqO5IDWy
	JaLjdcLDAR93qeq2Vd+GHKAemiCBvz15uivO85C2GzYgrJBMYCl5tKOB9OhGwIihZrZzlegtQCK9B
	MwgIAl+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqvT6-0008LH-MG; Thu, 02 Jul 2020 09:25:20 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqvT3-0008K7-VY
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 09:25:18 +0000
Received: by mail-ed1-x543.google.com with SMTP id h28so22903127edz.0
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dh0cAN0tCAhAhB/CRVYwfSOkE6VN85xMjc2R7od/DSU=;
 b=jdUUOzes/8whsQdIjZxLbY4pNmZtGSNLcWl6sQbTXJvHixYZjuuWnsVs1nnXRPTpRJ
 +HZxIvyfmGTF3G2tT7ULo2iN3AM/jKg4kYU4xx3dtJfgfekTYh/t+FqYCwNbaW5/maC1
 wzEyBD+g/2R/DiA5Yb8qwQ/mpMHxTCeaXcz6nGB8LGG2hfHYbfPIudueKdJBcmHk3t7y
 jfH3V+eFH4bLdUF+CXgZ4mvhJ7HW5qxYI9CoCkU2OQGLyTEN9Eh2JQioB3vFDr14REsI
 Gp3BMM3bydRPQm2S0XxUWxpB3slNy4Xp63xif7a7wE930dOruAQnuei1WZIUhFB+Bxjo
 KX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dh0cAN0tCAhAhB/CRVYwfSOkE6VN85xMjc2R7od/DSU=;
 b=ISGysulOG+TrUvMEUnkw0eiifVkdTEcr2TcH/NViWmDcPHLEET/7pWsMCM1Mq7d+gp
 5cnVCZj0RuP7E3uNYAJfLGbHlpFBMfD6qox8Dma1jAbDzB7ImwocD9R1kW5/myj5yBCj
 F9A/OAHT5IqhR0sMwuD1fHzN3tAyLa4F7ux/MLngZsKHLH48CM4uDMXut2aUktuuxqiY
 fx/bsq52kSmn0LsCrd49hVhIWheLrIvEozq9lauQ5IS0DvSkxCD2G0DxzHD/zT8N6jbA
 6xB11cjsZUq2uatattXEB4pA21TpQ06cnjLh88lORGRpf9DRFmCgT3RgJqMoOVg3V4wo
 JTOA==
X-Gm-Message-State: AOAM5323ViP3GbiH/fk8UOApIJ9RzEI8q2dd0riWUmBp8AgmjxsyEQIF
 GQ4iApQ4kMTkLuejC2+e1nvOtWA7YPqQJb/W
X-Google-Smtp-Source: ABdhPJwbUgBlqWZ8Bv+GRN6+E17pyzzFdFFYXKVD+gNN8hPiigqPcpUUHUAmw4q0d7PyejHCnJ6XKw==
X-Received: by 2002:a05:6402:1687:: with SMTP id
 a7mr33297542edv.358.1593681915998; 
 Thu, 02 Jul 2020 02:25:15 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id b18sm6569464ejl.52.2020.07.02.02.25.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:25:15 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/4]  ZNS: Extra features for current patches
Date: Thu,  2 Jul 2020 11:24:34 +0200
Message-Id: <20200702092438.63717-1-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_052518_063414_8419EE3C 
X-CRM114-Status: GOOD (  17.43  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com, sagi@grimberg.me,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, mb@lightnvm.io,
 hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpUaGlzIHBh
dGNoc2V0IGV4dGVuZHMgem9uZWQgZGV2aWNlIGZ1bmN0aW9uYWxpdHkgb24gdG9wIG9mIHRoZSBl
eGlzdGluZwpaTlMgcGF0Y2hzZXQgdGhhdCBLZWl0aCBzZW50LgoKQ2hhbmdlcyBzaW5jZSBWMgog
IC0gUmVtb3ZlIGRlYnVnIGNvZGUgYWRkZWQgYnkgbWlzdGFrZQogIC0gQWRkcmVzcyByZXR1cm4g
dmFsdWUgYW5kIGNvbnN0YW50IG5hbWluZyBieSBEYW1pZW4KICAtIExlYXZlIHJlc3Qgb2YgdGhl
IGNvbW1lbnRzIGZvciBhIFY0LCBhZnRlciBkaXNjdXNzaW9uIGluIHRoZSBtYWlsaW5nCiAgICBs
aXN0CgpDaGFuZ2VzIHNpbmNlIFYxCiAgLSBSZW1vdmUgbmV3IElPQ1RMcyBmb3Igem9uZSBtYW5h
Z2VtZW50IGFuZCB6b25lIHZhbHVlcy4gSSBiZWxpZXZlIHdlCiAgICB3aWxsIG5lZWQgdGhlIHpv
bmUgbWFuYWdlbWVudCBJT0NUTCB0byBzdXBwb3J0IG5ldyBaTlMgZmVhdHVyZXMgaW4KICAgIHRo
ZSBuZWFyIGZ1dHVyZSwgYnV0IHdlIHdpbGwgd2FpdCB1bnRpbCB3ZSB1cHN0cmVhbSB0aGVzZSB0
b28uIEluCiAgICB0aGUgbWVhbnRpbWUsIGZlZWRiYWNrIG9uIHRoZSBJT0NUTCBpcyB3ZWxjb21l
LiBXZSBkcm9wIHRoZSB6b25lCiAgICB2YWx1ZXMgSU9DVEwgY29tcGxldGVseSAtIE5pa2xhcyBz
ZW5kIGEgcGF0Y2ggdG8gZXhwb3NlIG1hciAvIG1vcgogICAgdGhyb3VnaCBzeXNmcyBhbHJlYWR5
IC0gd2Ugd2lsbCBleHRlbmQgb24gdGhpcyBpZiBuZWVkZWQuCgogIC0gUmVpbXBsZW1lbnQgem9u
ZSBvZmZsaW5lIHRyYW5zaXRpb24gdG8gYmUgYSBJT0NUTCBpbiBpdHNlbGYsIGFzIHRoZQogICAg
cmVzdCBvZiB0aGUgZXhpc3Rpbmcgem9uZSB0cmFuc2l0aW9ucy4gSW4gdGhlIHByb2Nlc3MsIGlt
cGxlbWVudCBhCiAgICB3YXkgZm9yIGRyaXZlcnMgdG8gcmVwb3J0IHpvbmUgZmVhdHVyZSBzdXBw
b3J0IGluIHRoZSBuZXdseSBhZGRlZAogICAgZmVhdHVyZSBmbGFncy4gUmVmYWN0b3Igc3VwcG9y
dCBmb3IgY2FwYWNpdHkgdG8gYWRvcHQgdGhpcyBtb2RlbC4KICAgIEhlcmUsIG5vdGUgdGhhdCB3
ZSBoYXZlIG1haW50YWluZWQgYmVoYXZpb3VyIGZvciB0aGUgc2NzaSBkcml2ZXIsCiAgICBldmVu
IHRob3VnaCB6b25lX3NpemUgPT0gem9uZV9jYXBhY2l0eQoKICAtIFJlaW1wbGVtZW50IHRoZSB6
b25lIGNvdW50IGNvbnNpc3RlbmN5IGNoZWNrIHRvIGRvIGEgY29ycmVjdCB6b25lCiAgICBjYWxj
dWxhdGlvbi4gTW92ZSB0aGlzIGxvZ2ljIHRvIHRoZSBpbml0aWFsaXphdGlvbiBsb2dpYywgaW5z
dGVhZCBvZgogICAgZG9pbmcgaXQgZWFjaCB0aW1lIHdlIHJlcG9ydCB6b25lcy4KClRoYW5rcywK
SmF2aWVyCgotLS0gVjEgY292ZXIgbGV0dGVyIC0tLQoKUGF0Y2hlcyAxLTUgYXJlIHpvbmVkIGJs
b2NrIGludGVyZmFjZSBhbmQgSU9DVEwgYWRkaXRpb25zIHRvIGV4cG9zZSBaTlMKdmFsdWVzIHRv
IHVzZXItc3BhY2UuIE9uZSBtYWpvciBjaGFuZ2UgaXMgdGhlIGFkZGl0aW9uIG9mIGEgbmV3IHpv
bmUKbWFuYWdlbWVudCBJT0NUTCB0aGF0IGFsbG93cyB0byBleHRlbmQgem9uZSBtYW5hZ2VtZW50
IGNvbW1hbmRzIHdpdGgKZmxhZ3MuIEkgcmVjYWxsIGEgY29udmVyc2F0aW9uIGluIHRoZSBtYWls
aW5nIGxpc3QgZnJvbSBlYXJseSB0aGlzIHllYXIKd2hlcmUgYSBzaW1pbGFyIGFwcHJvYWNoIHdh
cyBwcm9wb3NlZCBieSBNYXRpYXMsIGJ1dCBuZXZlciBtYWRlIGl0CnVwc3RyZWFtLiBXZSBleHRl
bmRlZCB0aGUgSU9DVEwgaGVyZSB0byBhbGlnbiB3aXRoIHRoZSBjb21tZW50cyBpbiB0aGF0CnRo
cmVhZC4gSGVyZSwgd2UgYXJlIGhhcHB5IHRvIGdldCBzaWduLW9mZnMgYnkgYW55b25lIHRoYXQg
Y29udHJpYnV0ZWQKdG8gdGhlIHRocmVhZCAtIGp1c3QgY29tbWVudCBoZXJlIG9yIG9uIHRoZSBw
YXRjaC4KClBhdGNoIDYgaXMgbnZtZS1vbmx5IGFuZCBhZGRzIGFuIGV4dHJhIGNoZWNrIHRvIHRo
ZSBaTlMgcmVwb3J0IGNvZGUgdG8KZW5zdXJlIGNvbnNpc3RlbmN5IG9uIHRoZSB6b25lIGNvdW50
LgoKVGhlIHBhdGNoZXMgYXBwbHkgb24gdG9wIG9mIEplbnMnIGJsb2NrLTUuOCArIEtlaXRoJ3Mg
VjMgWk5TIHBhdGNoZXMuCgpUaGFua3MsCkphdmllcgoKCgpKYXZpZXIgR29uesOhbGV6ICg0KToK
ICBibG9jazogQWRkIHpvbmUgZmxhZ3MgdG8gcXVldWUgem9uZSBwcm9wLgogIGJsb2NrOiBhZGQg
c3VwcG9ydCBmb3Igem9uZSBvZmZsaW5lIHRyYW5zaXRpb24KICBudm1lOiBBZGQgY29uc2lzdGVu
Y3kgY2hlY2sgZm9yIHpvbmUgY291bnQKICBibG9jazogYWRkIGF0dHJpYnV0ZXMgdG8gem9uZSBy
ZXBvcnQKCiBibG9jay9ibGstY29yZS5jICAgICAgICAgICAgICAgfCAgMiArKwogYmxvY2svYmxr
LXpvbmVkLmMgICAgICAgICAgICAgIHwgMTEgKysrKysrKy0tCiBkcml2ZXJzL2Jsb2NrL251bGxf
YmxrX3pvbmVkLmMgfCAgMiArKwogZHJpdmVycy9udm1lL2hvc3QvY29yZS5jICAgICAgIHwgIDUg
KysrKy0KIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCAgICAgICB8ICA2ICsrKy0tCiBkcml2ZXJz
L252bWUvaG9zdC96bnMuYyAgICAgICAgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystCiBkcml2ZXJzL3Njc2kvc2QuYyAgICAgICAgICAgICAgfCAgMiArKwogZHJpdmVycy9z
Y3NpL3NkX3piYy5jICAgICAgICAgIHwgIDggKysrKystLQogaW5jbHVkZS9saW51eC9ibGtfdHlw
ZXMuaCAgICAgIHwgIDMgKysrCiBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oICAgICAgICAgfCAgNCAr
KystCiBpbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaCAgfCAzMiArKysrKysrKysrKysrKysr
KysrKysrKysrLQogMTEgZmlsZXMgY2hhbmdlZCwgMTA2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0
aW9ucygtKQoKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK

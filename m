Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8905C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:57:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2A760230
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB2A760230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e0XhMxAO1XXNqx/SRQkcq6vdS81Pcnnhz0a5c9p6Itg=; b=PPd78Q0HMeBj3K
	HfA4tg/XZBTJxr8f9kiXXYacLngEUptD+LK9VRXido2xOIZdp7/ztGxc2MZ09PinnFhzIq/tUK6kj
	gFH3bk4GpYnLUA1CUd4dd91R51YRiajaDW2uB99rBbLblzzoOH4XX9qcblbwpnrHokQOT2e873LY3
	FskcKmxHurxRWwM1xqu8QTgXqloZefEyt0c4y2dyKvxXEF+BxjV2J/2xH/a50/1YCR0nf8QagNi8o
	frQo95z9nXGHzECpCWI2KM08jbRclyzIMsjdKi2JMdSQek0jkvEVDKC79tx+eTOygT3wbA1Yd8fqY
	4Asw4DRJSDvaRS8dRBgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSrVh-006ZyB-NB; Wed, 22 Sep 2021 01:57:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSrVc-006Zwq-NE
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 01:57:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632275831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j6djLJEaztg2vBhD4227udwI4Sryl491/dHXwza1acI=;
 b=EWiebVe6nWIs32RsuDWQ95fehCB3SFLYbRZY0PzR6+w2GDAjANjdW4YySIpK7sHoGsRIIo
 0NF1TovFPlZ+tXE2Ol3eaQOkNgwwoGCtQZRJeRCzHL/FxeUEf82o2UM0fI31417eQ8Tb4v
 t+OYxXPhZjI3g4nnG+j0zzAib4kmKuo=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-6ROz-kSDMoGyYHp-qpqR1g-1; Tue, 21 Sep 2021 21:57:10 -0400
X-MC-Unique: 6ROz-kSDMoGyYHp-qpqR1g-1
Received: by mail-oo1-f71.google.com with SMTP id
 j26-20020a4a92da000000b002a80a30e964so601131ooh.13
 for <linux-nvme@lists.infradead.org>; Tue, 21 Sep 2021 18:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=j6djLJEaztg2vBhD4227udwI4Sryl491/dHXwza1acI=;
 b=l3U6jFjJ3ujDLPKOVG0vhIZW9sK3K0ZT81AxV46X6ZCC8Pe17ROB7fMjBtlHXwlnYp
 fMcdoIltUZqnuk0TMFDFPMNaZpHxEXH4Mbhd1/Bif5uD3GOtv1BjVbzDEaMUpMwuX+4s
 q1E5GyFxBYbffttoJmUcyHg7CPuTHT5VmA1vQ5Zusey4m6atmEhyMjVHFWLlJF2dbed/
 VIVv3ZvQvdDWSOSKtmklTYcSy25Z7blvDzkTVwAPGfToM29LgRZrrRvK4zEHTcZMV4Im
 P7voeTT+fUoRJL+dOu1FAbn+tiCnmPeZItAIAZLOvLyPpaHpEFKVbaaAE/IqTxc9j3u2
 m2lg==
X-Gm-Message-State: AOAM533HXCXPBKPQENbNIIhf441bV7xah2aOla/J2uVdPjElgTynNURX
 33rBiWcu1M61H8m2M4EUK8v8jwgqkHwN89Saz+KVDnmKGIOJt1qLs8wIdOPguLG82Cr0QnLYGdz
 SAVLhJ3+SEC8e2rNtnM9pVLKeDkdR5zXKtFvLaIfUBdo=
X-Received: by 2002:a4a:c80b:: with SMTP id s11mr11616182ooq.65.1632275829953; 
 Tue, 21 Sep 2021 18:57:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLvS46ZzkUXGMxwp7Dw9NgefrPru5tj5JpY9QixPX8wykWX1RWXE/LIc7dPCH4sLgoqEUD4fQLMwtq4ZndhjU=
X-Received: by 2002:a05:6902:56d:: with SMTP id
 a13mr42594547ybt.512.1632275818834; 
 Tue, 21 Sep 2021 18:56:58 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 22 Sep 2021 09:56:47 +0800
Message-ID: <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
Subject: [bug report] nvme removing after probe failed with pci rescan after
 nvme sysfs removal
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_185716_981061_D9DA285D 
X-CRM114-Status: GOOD (  10.77  )
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

SGVsbG8KCkkgZm91bmQgdGhpcyBpc3N1ZSBkdXJpbmcgdGhlIG52bWUgcmVtb3ZhbCB0ZXN0LCBJ
IGRpZCBzb21lIGRlYnVnIGNvZGUKZm91bmQgaXQgd2FzIGZhaWxlZCBkdXJpbmcgbnZtZSAiQ1NU
UyDigJMgQ29udHJvbGxlciBTdGF0dXMiIHJlYWQsIGNvdWxkCmFueW9uZSBoZWxwIGNoZWNrIGlm
IHRoaXMgaXMgb25lIEhXIG9yIFNXIGlzc3VlPwoKCiMgbnZtZSBsaXN0Ck5vZGUgICAgICAgICAg
ICAgICAgICBTTiAgICAgICAgICAgICAgICAgICBNb2RlbAogICAgICAgICAgICAgTmFtZXNwYWNl
IFVzYWdlICAgICAgICAgICAgICAgICAgICAgIEZvcm1hdCAgICAgICAgICAgRlcKUmV2Ci0tLS0t
LS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSAtLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tCi9kZXYvbnZtZTBuMSAgICAgICAgICBTNDhDTkMw
TjQwMDk3MkIgICAgICBTYW1zdW5nIFNTRCA5ODMgRENUIDk2MEdCCiAgICAgICAgICAgICAxICAg
ICAgICAgICA0LjEwICBrQiAvIDk2MC4yMCAgR0IgICAgNTEyICAgQiArICAwIEIKRURBNTMwMlEK
IyBsc3BjaSAtcyA4NzowMC4wIC12Cjg3OjAwLjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBjb250cm9s
bGVyOiBTYW1zdW5nIEVsZWN0cm9uaWNzIENvIEx0ZApOVk1lIFNTRCBDb250cm9sbGVyIFNNOTgx
L1BNOTgxL1BNOTgzIChwcm9nLWlmIDAyIFtOVk0gRXhwcmVzc10pCkRldmljZU5hbWU6IFBDSWUg
U1NEIGluIFNsb3QgMjMgQmF5IDEKU3Vic3lzdGVtOiBTYW1zdW5nIEVsZWN0cm9uaWNzIENvIEx0
ZCBEZXZpY2UgYTgwMQpQaHlzaWNhbCBTbG90OiA3CkZsYWdzOiBidXMgbWFzdGVyLCBmYXN0IGRl
dnNlbCwgbGF0ZW5jeSAwLCBJUlEgNDYsIE5VTUEgbm9kZSAxCk1lbW9yeSBhdCBjODYwMDAwMCAo
NjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNktdCkV4cGFuc2lvbiBST00gYXQgYzg2
MTAwMDAgW2Rpc2FibGVkXSBbc2l6ZT02NEtdCkNhcGFiaWxpdGllczogWzQwXSBQb3dlciBNYW5h
Z2VtZW50IHZlcnNpb24gMwpDYXBhYmlsaXRpZXM6IFs1MF0gTVNJOiBFbmFibGUtIENvdW50PTEv
MzIgTWFza2FibGUtIDY0Yml0KwpDYXBhYmlsaXRpZXM6IFs3MF0gRXhwcmVzcyBFbmRwb2ludCwg
TVNJIDAwCkNhcGFiaWxpdGllczogW2IwXSBNU0ktWDogRW5hYmxlKyBDb3VudD0zMyBNYXNrZWQt
CkNhcGFiaWxpdGllczogWzEwMF0gQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nCkNhcGFiaWxpdGll
czogWzE0OF0gRGV2aWNlIFNlcmlhbCBOdW1iZXIgMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAKQ2Fw
YWJpbGl0aWVzOiBbMTU4XSBQb3dlciBCdWRnZXRpbmcgPD8+CkNhcGFiaWxpdGllczogWzE2OF0g
U2Vjb25kYXJ5IFBDSSBFeHByZXNzCkNhcGFiaWxpdGllczogWzE4OF0gTGF0ZW5jeSBUb2xlcmFu
Y2UgUmVwb3J0aW5nCkNhcGFiaWxpdGllczogWzE5MF0gTDEgUE0gU3Vic3RhdGVzCktlcm5lbCBk
cml2ZXIgaW4gdXNlOiBudm1lCktlcm5lbCBtb2R1bGVzOiBudm1lCgojIGVjaG8gMSA+L3N5cy9i
dXMvcGNpL2RldmljZXMvMDAwMFw6ODdcOjAwLjAvcmVtb3ZlCiMgZWNobyAxID4vc3lzL2J1cy9w
Y2kvcmVzY2FuCiMgZG1lc2cKWyAgMjUxLjg2NDI1NF0gcGNpIDAwMDA6ODc6MDAuMDogWzE0NGQ6
YTgwOF0gdHlwZSAwMCBjbGFzcyAweDAxMDgwMgpbICAyNTEuODY0Mjg2XSBwY2kgMDAwMDo4Nzow
MC4wOiByZWcgMHgxMDogW21lbSAweGM4NjAwMDAwLTB4Yzg2MDNmZmYgNjRiaXRdClsgIDI1MS44
NjQzMzddIHBjaSAwMDAwOjg3OjAwLjA6IHJlZyAweDMwOiBbbWVtIDB4ZmZmZjAwMDAtMHhmZmZm
ZmZmZiBwcmVmXQpbICAyNTEuODg5MTk2XSBwY2kgMDAwMDo4NzowMC4wOiBCQVIgNjogYXNzaWdu
ZWQgW21lbQoweGM4NjAwMDAwLTB4Yzg2MGZmZmYgcHJlZl0KWyAgMjUxLjg4OTIwNl0gcGNpIDAw
MDA6ODc6MDAuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0KMHhjODYxMDAwMC0weGM4NjEzZmZmIDY0
Yml0XQpbICAyNTEuODg5Nzc3XSBudm1lIG52bWUwOiBwY2kgZnVuY3Rpb24gMDAwMDo4NzowMC4w
ClsgIDI1MS44ODk4ODhdIG52bWUgbnZtZTA6IHJlYWRsKGRldi0+YmFyICsgTlZNRV9SRUdfQ1NU
UykgPT0gLTEsCnJldHVybiAtIEVOT0RFVgpbICAyNTEuODk4MDU3XSBudm1lIG52bWUwOiBudm1l
X3BjaV9lbmFibGU6IC0xOQpbICAyNTEuOTAyODIxXSBudm1lIG52bWUwOiBSZW1vdmluZyBhZnRl
ciBwcm9iZSBmYWlsdXJlIHN0YXR1czogLTE5CgoKLS0gCkJlc3QgUmVnYXJkcywKICBZaSBaaGFu
ZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

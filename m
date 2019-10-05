Return-Path: <SRS0=LrAE=X6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02668C47404
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 21:58:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DDE222C0
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 21:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IpQQnbyK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4wuP4xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DDE222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FtzojcF4YL6KKxcJzrpaXZgHeqTTKx0Z1rK8BfeXQB4=; b=IpQQnbyKV92/gt
	dglbJfbnnLcFXqQVIC7W0f4e85C0sMvzA1OWKqvMwnf9yp+7pN+cJZ1Pj3wQjw3LR3Gd7KyqydaQy
	eSQJmPp4f7aa/uAz78LTcx7qVXDy+N5FtCTZWFilqeR0Ba4mcvDBR0m1W71je3SwdNJ0E0MVq0Bol
	kVxRH9evPsJj8mPYKAeWKtmzteCLEwGhyLPCqQDubDtIrHewT8oJ6lNNxOAqhPAMQzb3jmsQ5kgR7
	FbVTmcYHXQ9FPOI9dtKlYD3+6KqODcqrj65BvVdjg/AWl7I4I/s7HcvMAVrkU7kqHlSdhj1Gn+8gW
	WedzR730gN9rD2RPeAxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iGs4C-0008Sc-69; Sat, 05 Oct 2019 21:58:20 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGs48-0008RG-8w
 for linux-nvme@lists.infradead.org; Sat, 05 Oct 2019 21:58:17 +0000
Received: by mail-io1-xd42.google.com with SMTP id c25so20898781iot.12
 for <linux-nvme@lists.infradead.org>; Sat, 05 Oct 2019 14:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G3GiBa1jUTyLkRA1lkNHAhMtxcRwrlIdapCLYa7uKjU=;
 b=r4wuP4xvj41CIb0744foDaOX+cmTo+WKgHTlLTYy+YlLTYIS8wfbTtSgjBfmQhTEzc
 HA+igB0G72DNBpejdeq2ZkSD5D9FHM5uKVXPp6MVInV4fqcSCxHQMjqGmkijai9P8Brm
 m989hcO2OeWQss7TrXXCM5JWIYPV5uQPAGbRsH0koB/wUiUhp+Cs1UChXA6jd7dQUORa
 5C8ZkuCjPLNAJyptUHEbVsJZ75GsJJjZWTeq7xr+W1kF2YELje1JfmqRBgLmV2nfgYTR
 MMElMGLn50uyIFBCihMhGR5t/FInrJhPc07SUuRcz3REtOihSghZ8FdYn1dbWyFWh0vG
 Mqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G3GiBa1jUTyLkRA1lkNHAhMtxcRwrlIdapCLYa7uKjU=;
 b=Xzzq4i3tD47NTQ+BgyX+jpBAfRvYWreZuYF5rIFETtmQFAC7E7XA7Kg5pD8uYjZsn6
 Pe2V+gkKuVUvT5jJIMwfqtpq2VBqh9CvTQRV/oxSFkBZn9Ak155cLqBna9FgWdFDmkSX
 PO4i8o1ZsU+zu/KCuG2QJOTZsw8g6obY3CcR3APAVdXk7sDI/NBhk9lMWiX71gYKjSWI
 2ESL9BFkiufL/5357ftEHCl/F13eeWy3Kx3uwrw1HF4ACB9qCoPsgmLkbt8DlKG0jeyg
 EAf+ttCQKLPUMc9vifAu5iJo3PUSZ+xMF+h+7L2OSrmPgRWsrYDmfRqzL+yfqnktTGWa
 zICA==
X-Gm-Message-State: APjAAAWR5ZHRG53W8k3QCxKI8HEPIJoHRuIUBtut+guhOuNoEWZAObjF
 SlP2xHxR+TfQgIklcrJjmPeI0ckGBmGBenHw7Do=
X-Google-Smtp-Source: APXvYqz44vCH9BONx7KQjbv9AZGFNrvMgpEkN/sLzw2EiiujFbKRVZiMg2lpFGS6CB5F6TBc6jSrFM1Nu//i50jwAtg=
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr9251832ilq.4.1570312693821;
 Sat, 05 Oct 2019 14:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191003191354.GA4481@Serenity>
 <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
 <e0edf48eb84fe038c2912328b28e931900684de2.camel@amazon.com>
In-Reply-To: <e0edf48eb84fe038c2912328b28e931900684de2.camel@amazon.com>
From: Tyler Ramer <tyaramer@gmail.com>
Date: Sat, 5 Oct 2019 17:58:52 -0400
Message-ID: <CAKcoMVBjzM6dq33DaTYBK6U32U3NQaR5mf6ppGr6iTKRuZ2KNg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
To: "Singh, Balbir" <sblbir@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191005_145816_319442_5508072C 
X-CRM114-Status: UNSURE (   6.09  )
X-CRM114-Notice: Please train this message.
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiBXaGF0IGlzIHRoZSBiYWQgQ1NUUyBiaXQ/IENTVFMuUkRZPwoKVGhlIHJlc2V0IHdpbGwgYmUg
dHJpZ2dlcmVkIGJ5IHRoZSByZXN1bHQgb2YgbnZtZV9zaG91bGRfcmVzZXQoKToKCjExOTYgc3Rh
dGljIGJvb2wgbnZtZV9zaG91bGRfcmVzZXQoc3RydWN0IG52bWVfZGV2ICpkZXYsIHUzMiBjc3Rz
KQoxMTk3IHsKMTE5OAoxMTk5IOKHpSAgICAgICAvKiBJZiB0cnVlLCBpbmRpY2F0ZXMgbG9zcyBv
ZiBhZGFwdGVyIGNvbW11bmljYXRpb24sIHBvc3NpYmx5IGJ5IGEKMTIwMCDih6UgICAgICAgICog
TlZNZSBTdWJzeXN0ZW0gcmVzZXQuCjEyMDEg4oelICAgICAgICAqLwoxMjAyIOKHpSAgICAgICBi
b29sIG5zc3JvID0gZGV2LT5zdWJzeXN0ZW0gJiYgKGNzdHMgJiBOVk1FX0NTVFNfTlNTUk8pOwoK
VGhpcyBjc3RzIHZhbHVlIGlzIHNldCBpbiBudm1lX3RpbWVvdXQ6CgoxMjQwIHN0YXRpYyBlbnVt
IGJsa19laF90aW1lcl9yZXR1cm4gbnZtZV90aW1lb3V0KHN0cnVjdCByZXF1ZXN0ICpyZXEsCmJv
b2wgcmVzZXJ2ZWQpCjEyNDEgewouLi4KMTI0NyDih6UgICAgICAgdTMyIGNzdHMgPSByZWFkbChk
ZXYtPmJhciArIE5WTUVfUkVHX0NTVFMpOwouLi4KMTI1NiDih6UgICAgICAgLyoKMTI1NyDih6Ug
ICAgICAgICogUmVzZXQgaW1tZWRpYXRlbHkgaWYgdGhlIGNvbnRyb2xsZXIgaXMgZmFpbGVkCjEy
NTgg4oelICAgICAgICAqLwoxMjU5IOKHpSAgICAgICBpZiAobnZtZV9zaG91bGRfcmVzZXQoZGV2
LCBjc3RzKSkgewoxMjYwIOKHpSAgICAgICDih6UgICAgICAgbnZtZV93YXJuX3Jlc2V0KGRldiwg
Y3N0cyk7CjEyNjEg4oelICAgICAgIOKHpSAgICAgICBudm1lX2Rldl9kaXNhYmxlKGRldiwgZmFs
c2UpOwoxMjYyIOKHpSAgICAgICDih6UgICAgICAgbnZtZV9yZXNldF9jdHJsKCZkZXYtPmN0cmwp
OwoKCkFnYWluLCBoZXJlJ3MgdGhlIG1lc3NhZ2UgcHJpbnRlZCBieSBudm1lX3dhcm5fcmVzZXQ6
CgpBdWcgMjYgMTU6MDE6MjcgdGVzdGhvc3Qga2VybmVsOiBudm1lIG52bWU0OiBjb250cm9sbGVy
IGlzIGRvd247IHdpbGwKcmVzZXQ6IENTVFM9MHgzLCBQQ0lfU1RBVFVTPTB4MTAKCkZyb20gIGlu
Y2x1ZGUvbGludXgvbnZtZS5oOgogMTA1IOKHpSAgICAgICBOVk1FX1JFR19DU1RT4oelICA9IDB4
MDAxYyzih6UgICAgICAvKiBDb250cm9sbGVyIFN0YXR1cyAqLwoKLSBUeWxlcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

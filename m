Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EF9C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 12:26:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2C32078B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 12:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YJDk99AR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="kBOQDam2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2C32078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9MUNMQWIJ6QUrqVmfOtyLjqo3GbBAFA0Blp6Qqa5n9U=; b=YJDk99AREBAIqs1sULPoj69qSp
	SBBzjpph785JjhHSfQ8NqnUhfzs5nI6NgA6JTjqIyMqmiXfhiUoWSRJahVxk4vp9CTGQCrVdwqLa0
	5S/owGpVNkcxZE9WyuQc+0v5kFlGCBTtClpZhFTmKaSsByMPorP+mVH+uaSMkNnHTVvZIfV23MlYo
	Jrir4bFdg9CjkVGz3ZfjBLqKLxTyyEqVnxkE9P9/pEy4zBSfQGbQP/KSPNDZJBNGC5IA5Uzpvxny5
	JlYFiV7ihIB6KLfd1dsLriNLdus36H6fE+FRNqbadDKT9lQBuj8rP0LMwLH+1AtG364gnH9vkcW1L
	QcJTInzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb0pI-0002NJ-Vg; Fri, 06 Nov 2020 12:26:45 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb0pG-0002MN-Sl
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 12:26:44 +0000
Received: by mail-ej1-x642.google.com with SMTP id k3so1625575ejj.10
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 04:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YIGJ8K38G0NcFaq9vrbXPNVjJZE6jTk755NCJrgov6k=;
 b=kBOQDam2SDeTp5A57yul8Lcj+br9Me3BkS/bOb0XoeeHyw51YOiJ/o+OTBpAX5WcDK
 v19lNbDIpkNk8m5J23wDwmensyG39lqD5oJ1HMJBkDY2OgAP4gW/1DtZ6uwiSM5AOcny
 HQvEldNONAMqnAT9Z1lDACNFB3Ug9ql2JTDMUfs3dhqozTZsLOUt1axcF89kXIOjHqEG
 0K9VFQUaKIsytV4r8BuscG9jwQOz0SlSrpOA/eTX86h29RcnFQfEhYbsqnYsXLFMCT1o
 HJe3E9hOUhZtkEo0679K881daHSn7e37HtiuuYf66uR7CerOhv3vDGXoDTLElKCcHYQ8
 IlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YIGJ8K38G0NcFaq9vrbXPNVjJZE6jTk755NCJrgov6k=;
 b=CNpm+9qc8vMBPQzEhGFIoQqc9bgiH3J1cBSFM/xGB0qPVBEvFICJHJTO7o/5XHi20b
 HSTldxBWQM5DcRMJCXJknunTzPEY4Ql6osZgdd9uzHgWWFso3PLW96Mt1Pej8r4fDnwM
 IouKbM6qh6DJk+RPETYYNnjxfN5dysGn0q3NYJFQcUwJZY4ggBTR+zAc1TJEAb/jkjyt
 qhgNSI2sYivpAIh3Bb/aY02EldC9ZzLVpOearhJA64jP13rXOLvhSOM10L7JUTyapz3X
 7bqqyTxZwm5ScIsbapM+5KDNUdOjvOsIEvffwHWZJpUXaYAeOZQMPh1kHQ/r0azS6XGe
 TfyA==
X-Gm-Message-State: AOAM530VCQ8fFIa1UbTNnIlVhRlzXjN+tXioRskzgPvgvtsDcLCsYHl7
 tATrgj48RtR0jePg2WzgfyzQIllBfAfkcPYb8PI=
X-Google-Smtp-Source: ABdhPJwJwfBl+eOyT7n2doy7RET7Fo0993F+2mOmqD7XoNIWZw0Vmx9j4258IZnJda5tbT2Cbyx5YQ==
X-Received: by 2002:a17:906:66c9:: with SMTP id
 k9mr1880683ejp.204.1604665599978; 
 Fri, 06 Nov 2020 04:26:39 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.126.247.cgn.fibianet.dk.
 [5.186.126.247])
 by smtp.gmail.com with ESMTPSA id dn16sm936224edb.19.2020.11.06.04.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 04:26:39 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?=
 <javier.gonz@samsung.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: enable ro namespace for ZNS without append
Date: Fri,  6 Nov 2020 13:26:37 +0100
Message-Id: <20201106122637.14490-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_072643_052342_CA858EA4 
X-CRM114-Status: GOOD (  20.03  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-block@vger.kernel.org,
 kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QWxsb3cgWk5TIE5WTWUgU1NEcyB0byBwcmVzZW50IGEgcmVhZC1vbmx5IG5hbWVzcGFjZSB3aGVu
IGFwcGVuZCBpcyBub3QKc3VwcG9ydGVkLCBpbnN0ZWFkIG9mIHJlamVjdGluZyB0aGUgbmFtZXNw
YWNlIGRpcmVjdGx5LgoKVGhpcyBhbGxvd3MgKGkpIHRoZSBuYW1lc3BhY2UgdG8gYmUgdXNlZCBp
biByZWFkLW9ubHkgbW9kZSwgd2hpY2ggaXMgbm90CmEgcHJvYmxlbSBhcyB0aGUgYXBwZW5kIGNv
bW1hbmQgb25seSBhZmZlY3RzIHRoZSB3cml0ZSBwYXRoLCBhbmQgKGlpKSB0bwp1c2Ugc3RhbmRh
cmQgbWFuYWdlbWVudCB0b29scyBzdWNoIGFzIG52bWUtY2xpIHRvIGNob29zZSBhIGRpZmZlcmVu
dApmb3JtYXQgb3IgZmlybXdhcmUgc2xvdCB0aGF0IGlzIGNvbXBhdGlibGUgd2l0aCB0aGUgTGlu
dXggem9uZWQgYmxvY2sKZGV2aWNlLgoKVGhpcyBwYXRjaCBpbmNsdWRlcyBjb21tZW50cyBmcm9t
IENocmlzdG9waCwgTmlrbGFzIGFuZCBLZWl0aCB0aGF0CmFwcGxpZWQgdG8gYSBkaWZmZXJlbnQg
YXBwcm9hY2ggc2V0dGluZyBjYXBhY2l0eSB0byAwCiAgaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQv
bGlzdHMvbGludXgtYmxvY2svbXNnNjA3NDcuaHRtbAoKVGhlIHJlbWluZGVyIG9mIHRoZSBvcmln
aW5hbCBwYXRjaCB3aWxsIGJlIHN1Ym1pdHRlZCBzZXBhcmF0ZWx5LgoKU2lnbmVkLW9mZi1ieTog
SmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Ci0tLQogZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jIHwgIDUgKysrKysKIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8ICAx
ICsKIGRyaXZlcnMvbnZtZS9ob3N0L3pucy5jICB8IDIwICsrKysrKysrKysrKy0tLS0tLS0tCiAz
IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
CmluZGV4IGMxOTBjNTZiZjcwMi4uODk2N2FiOTA4OWIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCkBAIC0yMDM2LDYg
KzIwMzYsMTEgQEAgc3RhdGljIHZvaWQgbnZtZV91cGRhdGVfZGlza19pbmZvKHN0cnVjdCBnZW5k
aXNrICpkaXNrLAogCWVsc2UKIAkJc2V0X2Rpc2tfcm8oZGlzaywgZmFsc2UpOwogCisjaWZkZWYg
Q09ORklHX0JMS19ERVZfWk9ORUQKKwlpZiAoYmxrX3F1ZXVlX2lzX3pvbmVkKGRpc2stPnF1ZXVl
KSAmJiAhbnMtPnpvbmVkX25zX3N1cHApCisJCXNldF9kaXNrX3JvKGRpc2ssIHRydWUpOworI2Vu
ZGlmCisKIAlibGtfbXFfdW5mcmVlemVfcXVldWUoZGlzay0+cXVldWUpOwogfQogCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgK
aW5kZXggODc3MzdmYTMyMzYwLi5mZjRmZTY0NWFiOWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L252bWUuaAorKysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKQEAgLTQ0Myw2ICs0
NDMsNyBAQCBzdHJ1Y3QgbnZtZV9ucyB7CiAJdTggcGlfdHlwZTsKICNpZmRlZiBDT05GSUdfQkxL
X0RFVl9aT05FRAogCXU2NCB6c3plOworCWJvb2wgem9uZWRfbnNfc3VwcDsKICNlbmRpZgogCXVu
c2lnbmVkIGxvbmcgZmVhdHVyZXM7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKaW5kZXgg
NTdjZmQ3ODczMWZiLi40ZDAwNTEzMmFiOTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L3pucy5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCkBAIC00MiwyMiArNDIsMjUgQEAg
aW50IG52bWVfdXBkYXRlX3pvbmVfaW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0IG52
bWVfbnMgKm5zLAogCXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxID0gZGlzay0+cXVldWU7CiAJc3Ry
dWN0IG52bWVfY29tbWFuZCBjID0geyB9OwogCXN0cnVjdCBudm1lX2lkX25zX3pucyAqaWQ7CisJ
Ym9vbCB6b25lZF9uc19zdXBwID0gdHJ1ZTsKIAlpbnQgc3RhdHVzOwogCiAJLyogRHJpdmVyIHJl
cXVpcmVzIHpvbmUgYXBwZW5kIHN1cHBvcnQgKi8KIAlpZiAoIShsZTMyX3RvX2NwdShsb2ctPmlv
Y3NbbnZtZV9jbWRfem9uZV9hcHBlbmRdKSAmCiAJCQlOVk1FX0NNRF9FRkZFQ1RTX0NTVVBQKSkg
eworCQl6b25lZF9uc19zdXBwID0gZmFsc2U7CiAJCWRldl93YXJuKG5zLT5jdHJsLT5kZXZpY2Us
CiAJCQkiYXBwZW5kIG5vdCBzdXBwb3J0ZWQgZm9yIHpvbmVkIG5hbWVzcGFjZTolZFxuIiwKIAkJ
CW5zLT5oZWFkLT5uc19pZCk7Ci0JCXJldHVybiAtRUlOVkFMOwotCX0KLQotCS8qIExhemlseSBx
dWVyeSBjb250cm9sbGVyIGFwcGVuZCBsaW1pdCBmb3IgdGhlIGZpcnN0IHpvbmVkIG5hbWVzcGFj
ZSAqLwotCWlmICghbnMtPmN0cmwtPm1heF96b25lX2FwcGVuZCkgewotCQlzdGF0dXMgPSBudm1l
X3NldF9tYXhfYXBwZW5kKG5zLT5jdHJsKTsKLQkJaWYgKHN0YXR1cykKLQkJCXJldHVybiBzdGF0
dXM7CisJfSBlbHNlIHsKKwkJLyogTGF6aWx5IHF1ZXJ5IGNvbnRyb2xsZXIgYXBwZW5kIGxpbWl0
IGZvciB0aGUgZmlyc3QKKwkJICogem9uZWQgbmFtZXNwYWNlCisJCSAqLworCQlpZiAoIW5zLT5j
dHJsLT5tYXhfem9uZV9hcHBlbmQpIHsKKwkJCXN0YXR1cyA9IG52bWVfc2V0X21heF9hcHBlbmQo
bnMtPmN0cmwpOworCQkJaWYgKHN0YXR1cykKKwkJCQlyZXR1cm4gc3RhdHVzOworCQl9CiAJfQog
CiAJaWQgPSBremFsbG9jKHNpemVvZigqaWQpLCBHRlBfS0VSTkVMKTsKQEAgLTk1LDYgKzk4LDcg
QEAgaW50IG52bWVfdXBkYXRlX3pvbmVfaW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0
IG52bWVfbnMgKm5zLAogCX0KIAogCXEtPmxpbWl0cy56b25lZCA9IEJMS19aT05FRF9ITTsKKwlu
cy0+em9uZWRfbnNfc3VwcCA9IHpvbmVkX25zX3N1cHA7CiAJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFV
RVVFX0ZMQUdfWk9ORV9SRVNFVEFMTCwgcSk7CiAJYmxrX3F1ZXVlX21heF9vcGVuX3pvbmVzKHEs
IGxlMzJfdG9fY3B1KGlkLT5tb3IpICsgMSk7CiAJYmxrX3F1ZXVlX21heF9hY3RpdmVfem9uZXMo
cSwgbGUzMl90b19jcHUoaWQtPm1hcikgKyAxKTsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

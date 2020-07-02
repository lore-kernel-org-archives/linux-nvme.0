Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEAAC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77F42067D
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xvg7/93x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="iSI69gI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77F42067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ViFYrITga/8wi0oNMZriIjAB/QrnW556ZyT88vK4Qxk=; b=xvg7/93xyHesmC9EcsV29W9Xy
	YUTmCe57xcOhCvQT8iGY58mC+Yghwx0MKW3pOFjp88bhaZVF4QnR80+qOg9PJufr8Kt5e15eHy+10
	6NCbUUJqFVf91d6Iv8qfsTU/hrL0SJNUHvOZOapLPqPtUlr6wMvHBZqK0Yi/dtuw8wRGfvgLjkVFW
	l/OO1wDJBD8c42w8ZZ/MD9d/cr8O2sHWGZAbkR87ijPsiD6BWzoh+GioJrNyWHGA7DxEkLcgGATx0
	p4fYwx/W7vqhRRsHYqKwKy8661Nb3x+phm8EO1pY29IHPAgfKHGeDKkgSHAQzPJ0p6u+2LU5DFgFk
	F3Hbk+qDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqt88-0000E0-5f; Thu, 02 Jul 2020 06:55:32 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqt7l-0008Or-VV
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 06:55:11 +0000
Received: by mail-ej1-x643.google.com with SMTP id n26so14001764ejx.0
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KE1I2nGLyS8CRjZ/jic6a8RSadPgihMjPPFDgHjzHMg=;
 b=iSI69gI878xIDoelv9gFlLnZhYRwvAVY9q1JBjG2Qjd8i71nqsGwzLotgrgunzDkox
 AnhhPvj1drlVlMWWh7QHjdSH/9DRhJvTJo7/nsVISDJX/mTllv+2gF13q9z/zjxcsxQr
 6iLwiKFBIsNkMcsTOA1Bz9DZQr/CLy7bSqd5/L7MSl7MprYvmVDOKDUFLJjqQf7fj8bB
 7Jl+a6Ms8XOf8rBjVkQotXVRRmjG7tQaXN51yNyemj8lXcYrvJbVzTcJLRUhGQ+wXI5d
 l30oBMN/s2kQsa8ZvShhwoRQ6RsYRUHJKJ8o9F42zv88xiol012lmWmBE68vYqImRbjm
 /D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KE1I2nGLyS8CRjZ/jic6a8RSadPgihMjPPFDgHjzHMg=;
 b=ND/9u3TnMMK+OySJacwsOwjN8FWJzRNki5XAlqvOycD/FTsfkDyZIS3tprIA1VKknP
 diyTnkrPMMLjouB58jcxq15ZruPwp19HdCe8pMANRK59g7C1LEbCGgvVH4ZKycxGZJOs
 sXW+odYu0jthq54RRolsC9DHQc2AH2Jn1jngBMFK/dUaSpeE30AWmFoUGVX7XoiUjfPN
 ao3Ag4IZRcKDvCrn8rW58X1tD6xA5oyYKyFdIxw/ipr39z4VzaxWoRPwKX4qjr2bi2+z
 mk/ZqKtHxeWxQT5cb1qFhcd+QNHEyA2HZZzOxVEKz/OnOZACPxFLdppm4ZYNTEprHZMw
 KkIQ==
X-Gm-Message-State: AOAM531ikHPD2qoZ/Cbe+a4f3/jm6R7n1PQu12tRX20Q013wWa1RfL/T
 zibnlUKquWaRzB7ENftUgAIAwTwohIIThgVw
X-Google-Smtp-Source: ABdhPJwJG3y7TU8m5PYTa437Kd8cPSYym48DCfQUbSzji2cGVF6r8In6Ka+RH/eoCSwz0o1tdjAZmA==
X-Received: by 2002:a17:906:3e13:: with SMTP id
 k19mr25715216eji.476.1593672907887; 
 Wed, 01 Jul 2020 23:55:07 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id cz2sm7912769edb.82.2020.07.01.23.55.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 23:55:07 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] block: add attributes to zone report
Date: Thu,  2 Jul 2020 08:54:38 +0200
Message-Id: <20200702065438.46350-5-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702065438.46350-1-javier@javigon.com>
References: <20200702065438.46350-1-javier@javigon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_025510_092101_3936B6CA 
X-CRM114-Status: GOOD (  16.52  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, mb@lightnvm.io,
 hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpBZGQgem9u
ZSBhdHRyaWJ1dGVzIGZpZWxkIHRvIHRoZSBibGtfem9uZSBzdHJ1Y3R1cmUuIFVzZSBaTlMgYXR0
cmlidXRlcwphcyBiYXNlIGZvciB6b25lZCBibG9jayBkZXZpY2VzIGFuZCBhZGQgdGhlIGN1cnJl
bnQgYXRyaWJ1dGVzIGluClpBQy9aQkMuCgpTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KU2lnbmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxz
ZWx2YWt1bWEuczFAc2Ftc3VuZy5jb20+ClNpZ25lZC1vZmYtYnk6IEthbmNoYW4gSm9zaGkgPGpv
c2hpLmtAc2Ftc3VuZy5jb20+ClNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5qLnNoZXR0
eUBzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC96bnMuYyAgICAgICB8ICAzICsr
LQogZHJpdmVycy9zY3NpL3NkLmMgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9zY3NpL3Nk
X3piYy5jICAgICAgICAgfCAgOCArKysrKystLQogaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVk
LmggfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrLQogNCBmaWxlcyBjaGFuZ2VkLCAzNCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9o
b3N0L3pucy5jIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKaW5kZXggZDc4NWQxNzlhMzQzLi43
NDkzODJhMTQ5NjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCisrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3pucy5jCkBAIC0xMTgsNyArMTE4LDcgQEAgaW50IG52bWVfdXBkYXRl
X3pvbmVfaW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0IG52bWVfbnMgKm5zLAogCX0K
IAogCXEtPmxpbWl0cy56b25lZCA9IEJMS19aT05FRF9ITTsKLQlxLT56b25lX2ZsYWdzID0gQkxL
X1pPTkVfUkVQX0NBUEFDSVRZIHwgQkxLX1pPTkVfUkVQX09GRkxJTkU7CisJcS0+em9uZV9mbGFn
cyA9IEJMS19aT05FX1JFUF9DQVBBQ0lUWSB8IEJMS19aT05FX1JFUF9DQVBBQ0lUWSB8IEJMS19a
T05FX1JFUF9PRkZMSU5FOwogCWJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX1pPTkVfUkVT
RVRBTEwsIHEpOwogZnJlZV9kYXRhOgogCWtmcmVlKGlkKTsKQEAgLTE5Nyw2ICsxOTcsNyBAQCBz
dGF0aWMgaW50IG52bWVfem9uZV9wYXJzZV9lbnRyeShzdHJ1Y3QgbnZtZV9ucyAqbnMsCiAJem9u
ZS5jYXBhY2l0eSA9IG52bWVfbGJhX3RvX3NlY3QobnMsIGxlNjRfdG9fY3B1KGVudHJ5LT56Y2Fw
KSk7CiAJem9uZS5zdGFydCA9IG52bWVfbGJhX3RvX3NlY3QobnMsIGxlNjRfdG9fY3B1KGVudHJ5
LT56c2xiYSkpOwogCXpvbmUud3AgPSBudm1lX2xiYV90b19zZWN0KG5zLCBsZTY0X3RvX2NwdShl
bnRyeS0+d3ApKTsKKwl6b25lLmF0dHIgPSBlbnRyeS0+emE7CiAKIAlyZXR1cm4gY2IoJnpvbmUs
IGlkeCwgZGF0YSk7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvc2QuYyBiL2RyaXZlcnMv
c2NzaS9zZC5jCmluZGV4IGI5YzkyMGJhY2UyOC4uNjMyNzA1OThhYTc2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3Njc2kvc2QuYworKysgYi9kcml2ZXJzL3Njc2kvc2QuYwpAQCAtMjk2Nyw3ICsyOTY3
LDcgQEAgc3RhdGljIHZvaWQgc2RfcmVhZF9ibG9ja19jaGFyYWN0ZXJpc3RpY3Moc3RydWN0IHNj
c2lfZGlzayAqc2RrcCkKIAlpZiAoc2RrcC0+ZGV2aWNlLT50eXBlID09IFRZUEVfWkJDKSB7CiAJ
CS8qIEhvc3QtbWFuYWdlZCAqLwogCQlxLT5saW1pdHMuem9uZWQgPSBCTEtfWk9ORURfSE07Ci0J
CXEtPnpvbmVfZmxhZ3MgPSBCTEtfWk9ORV9SRVBfQ0FQQUNJVFk7CisJCXEtPnpvbmVfZmxhZ3Mg
PSBCTEtfWk9ORV9SRVBfQ0FQQUNJVFkgfCBCTEtfWk9ORV9SRVBfQVRUUjsKIAl9IGVsc2Ugewog
CQlzZGtwLT56b25lZCA9IChidWZmZXJbOF0gPj4gNCkgJiAzOwogCQlpZiAoc2RrcC0+em9uZWQg
PT0gMSAmJiAhZGlza19oYXNfcGFydGl0aW9ucyhzZGtwLT5kaXNrKSkgewpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zY3NpL3NkX3piYy5jIGIvZHJpdmVycy9zY3NpL3NkX3piYy5jCmluZGV4IDE4M2Ey
MDcyMGRhOS4uNTFjN2Y4MmI1OWM1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvc2RfemJjLmMK
KysrIGIvZHJpdmVycy9zY3NpL3NkX3piYy5jCkBAIC01MywxMCArNTMsMTQgQEAgc3RhdGljIGlu
dCBzZF96YmNfcGFyc2VfcmVwb3J0KHN0cnVjdCBzY3NpX2Rpc2sgKnNka3AsIHU4ICpidWYsCiAK
IAl6b25lLnR5cGUgPSBidWZbMF0gJiAweDBmOwogCXpvbmUuY29uZCA9IChidWZbMV0gPj4gNCkg
JiAweGY7Ci0JaWYgKGJ1ZlsxXSAmIDB4MDEpCisJaWYgKGJ1ZlsxXSAmIDB4MDEpIHsKKwkJem9u
ZS5hdHRyIHw9IEJMS19aT05FX0FUVFJfTlJXOwogCQl6b25lLnJlc2V0ID0gMTsKLQlpZiAoYnVm
WzFdICYgMHgwMikKKwl9CisJaWYgKGJ1ZlsxXSAmIDB4MDIpIHsKKwkJem9uZS5hdHRyIHw9IEJM
S19aT05FX0FUVFJfTlNROwogCQl6b25lLm5vbl9zZXEgPSAxOworCX0KIAogCXpvbmUubGVuID0g
bG9naWNhbF90b19zZWN0b3JzKHNkcCwgZ2V0X3VuYWxpZ25lZF9iZTY0KCZidWZbOF0pKTsKIAl6
b25lLmNhcGFjaXR5ID0gem9uZS5sZW47CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgv
Ymxrem9uZWQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCmluZGV4IGU1YWRmNGE5
ZjRiMC4uMzE1NjE3ODI3YWNkIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9u
ZWQuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaApAQCAtNzgsMTAgKzc4LDMz
IEBAIGVudW0gYmxrX3pvbmVfY29uZCB7CiAgKgogICogQEJMS19aT05FX1JFUF9DQVBBQ0lUWTog
Wm9uZSBkZXNjcmlwdG9yIGhhcyBjYXBhY2l0eSBmaWVsZC4KICAqIEBCTEtfWk9ORV9SRVBfT0ZG
TElORSA6IFpvbmUgZGV2aWNlIHN1cHBvcnRzIG9mZmxpbmUgdHJhbnNpdGlvbi4KKyAqIEBCTEtf
Wk9ORV9SRVBfQVRUUjogWm9uZSBhdHRyaWJ1dGVzIHJlcG9ydGVkLgogICovCiBlbnVtIGJsa196
b25lX3JlcG9ydF9mbGFncyB7CiAJQkxLX1pPTkVfUkVQX0NBUEFDSVRZCT0gKDEgPDwgMCksCiAJ
QkxLX1pPTkVfUkVQX09GRkxJTkUJPSAoMSA8PCAxKSwKKwlCTEtfWk9ORV9SRVBfQVRUUgk9ICgx
IDw8IDIpLAorfTsKKworLyoqCisgKiBlbnVtIGJsa196b25lX2F0dHIgLSBab25lIEF0dHJpYnV0
ZXMKKyAqCisgKiBBdHRyaWJ1dGVzIG9mIHRoZSB6b25lLiBSZXBvcnRlZCBpbiBzdHJ1Y3QgYmxr
X3pvbmUgLT4gYXR0cgorICoKKyAqIEBCTEtfWk9ORV9BVFRSX1pGQzogWm9uZSBGaW5pc2hlZCBi
eSBDb250cm9sbGVyIGR1ZSB0byBhIHpvbmUgYWN0aXZlIGV4Y3Vyc2lvbgorICogQEJMS19aT05F
X0FUVFJfRlpSOiBGaW5pc2ggWm9uZSBSZWNvbW1lbmRlZCByZXF1aXJlZCBieSBjb250cm9sbGVy
CisgKiBAQkxLX1pPTkVfQVRUUl9SWlI6IFJlc2V0IFpvbmUgUmVjb21tZW5kZWQgcmVxdWlyZWQg
YnkgY29udHJvbGxlcgorICogQEJMS19aT05FX0FUVFJfTlNROiBOb24gU2VxdWVudGlhbCB6b25l
CisgKiBAQkxLX1pPTkVfQVRUUl9OUlc6IE5lZWQgUmVzZXQgV3JpdGUgUG9pbnRlciByZXF1aXJl
ZCBieSBjb250cm9sbGVyCisgKiBAQkxLX1pPTkVfQVRUUl9aREVWOiBab25lIERlc2NyaXB0b3Ig
RXh0ZW5zaW9uIFZhbGlkIGluIHpvbmUgcmVwb3J0CisgKi8KK2VudW0gYmxrX3pvbmVfYXR0ciB7
CisJQkxLX1pPTkVfQVRUUl9aRkMJPSAxIDw8IDAsCisJQkxLX1pPTkVfQVRUUl9GWlIJPSAxIDw8
IDEsCisJQkxLX1pPTkVfQVRUUl9SWlIJPSAxIDw8IDIsCisJQkxLX1pPTkVfQVRUUl9OU1EJPSAx
IDw8IDMsCisJQkxLX1pPTkVfQVRUUl9OUlcJPSAxIDw8IDQsCisJQkxLX1pPTkVfQVRUUl9aREVW
CT0gMSA8PCA3LAogfTsKIAogLyoqCkBAIC0xMTAsNyArMTMzLDggQEAgc3RydWN0IGJsa196b25l
IHsKIAlfX3U4CWNvbmQ7CQkvKiBab25lIGNvbmRpdGlvbiAqLwogCV9fdTgJbm9uX3NlcTsJLyog
Tm9uLXNlcXVlbnRpYWwgd3JpdGUgcmVzb3VyY2VzIGFjdGl2ZSAqLwogCV9fdTgJcmVzZXQ7CQkv
KiBSZXNldCB3cml0ZSBwb2ludGVyIHJlY29tbWVuZGVkICovCi0JX191OAlyZXN2WzRdOworCV9f
dTgJYXR0cjsJCS8qIFpvbmUgYXR0cmlidXRlcyAqLworCV9fdTgJcmVzdlszXTsKIAlfX3U2NAlj
YXBhY2l0eTsJLyogWm9uZSBjYXBhY2l0eSBpbiBudW1iZXIgb2Ygc2VjdG9ycyAqLwogCV9fdTgJ
cmVzZXJ2ZWRbMjRdOwogfTsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK

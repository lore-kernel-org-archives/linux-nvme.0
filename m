Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFBFC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 20:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xhtK1H81XGHNzPDAr5NMD+XLzKVhyxaevdQetYEydps=; b=nKmyCIXKjDb5kcZcGuXMyWSOhi
	l2XywvfobJTkNjbO/oelHLXMObxWOd3RHQWBN5b4zIHgO8mgPIf5+xZXdLZ9hpmydvm6j//6Rd4Um
	zVzqQlVqerzlsJMwhJDMKOmew31bOk+ncnLtpDd8AQ+1krKnmgUdSnrr7GYo67EXo/9iBB56Lpk3h
	cUAuY17w1EjrJoSwi5ZoE14zxdJGviMp93ocxhkZlkdmZiILQseFScgWyplJdGRXkgGvLhMniJVAp
	+Enc/l4mAVrkRCrnSoyACMzIMCidhrKlpzU+/Kynx1591J+vFF6CoEpcsigQWLSXnUvzNtaKUmJPk
	SO/H/ssA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1D3h-00B6r6-SP; Tue, 14 Jun 2022 20:22:41 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1D3d-00B6pj-F4
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 20:22:39 +0000
Received: by mail-ej1-x632.google.com with SMTP id me5so19378957ejb.2
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jun 2022 13:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xhtK1H81XGHNzPDAr5NMD+XLzKVhyxaevdQetYEydps=;
        b=T1x8K+7Q2Jk8OFlRClccQVWWQ83DF0fLnV/O4xmOzQeLUW2mLvwnixZrTl1z7RJci6
         tR1CPkSzy8DJ/Gq+RPqMkWBIwPkje+vcO9Fxp5TMRLQ1AgUaIGsTyU0neBvEv+MdQJnq
         LbgXWxQjkSaWY6s9OBcXTsKprJaYoSBzHOGn/zGwhpxfYLXc3Xzlv6bJf1VTKpp6+s1q
         K22LN8W6VC5vcJQofILwqeA4Wm8R7+lKLvg6yU3ZjNlz5W4YjdmmQmSEJWOSPG/d5jqS
         VhEZei0ZWm+hYY4EfSUdK/1mUWaDxFTd6wj+INbL1eN/ac1ad8MlU/kf+zIXAjJgH4uO
         rOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xhtK1H81XGHNzPDAr5NMD+XLzKVhyxaevdQetYEydps=;
        b=QyPNVZHZxRVOvCblHzk0y4UrNVg1Gl6f9I253SCWBg4of9L+yc+iMC0ylC2asMYu4s
         HxXk/23pURuWjtspA7AJyYoW156Nv+9PtFxxH8pKOzQO0oD4lT0nsBU7mRT0VsOf+MYT
         dwjarxzgOuux1hsU3BhFt19gx/sIV8NvxnJuaB/gZZ7Hk96U2HIbP4SiwQTsLMgA/5Jy
         fvHgueE5NUjSrNxcfVFlsH4+Gkb3QjsZod39K6CmEfT72ExyS23gdPHeiDmEvfBSSnwE
         8DdheFwqiHHKOnoT/w00vK4renI7gWrie9+u5OkZgnCm1sEo+BwI2w21nozw8Cf4BpK2
         GvLg==
X-Gm-Message-State: AJIora8uVBgb3c+UmFh+pXqvq2h4jOV5ITKi9xkkWS3TjPVnsBQuHDuK
	3TOWYrvUPnRSQH00NlCwpD+aHK9IKHWLC20sYtcXovQ=
X-Google-Smtp-Source: ABdhPJwBcR8OsUJv5w1Z8zrPauUBpO0CBb5Id3BTBEKEdTUbOscw/MChUJAXEzGiGGD7z++0U3tfS7m+0v1+9y0zuVI=
X-Received: by 2002:a17:907:160c:b0:711:3b56:dc7 with SMTP id
 hb12-20020a170907160c00b007113b560dc7mr5912392ejc.587.1655238146068; Tue, 14
 Jun 2022 13:22:26 -0700 (PDT)
MIME-Version: 1.0
From: Karsten Elfenbein <karsten.elfenbein@gmail.com>
Date: Tue, 14 Jun 2022 22:22:15 +0200
Message-ID: <CADzy1LZqrb0HOX5jaDOet7nMK=X5tJ9XfO9jtk=XZg54t9nOtA@mail.gmail.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Phison E16
To: linux-nvme@lists.infradead.org
Content-Type: multipart/mixed; boundary="000000000000b7289505e16e2960"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_132237_550556_08F3AC53 
X-CRM114-Status: UNSURE (   8.55  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--000000000000b7289505e16e2960
Content-Type: text/plain; charset="UTF-8"

My two devices report identical eui64 values (looks random) and
identical ngui values (all 0).

Best regards,
Karsten

--000000000000b7289505e16e2960
Content-Type: text/x-patch; charset="US-ASCII"; name="phison.diff"
Content-Disposition: attachment; filename="phison.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l4elw8wp0>
X-Attachment-Id: f_l4elw8wp0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
cGNpLmMKaW5kZXggNDhmNGY2ZWI4NzdiLi5kNjBkMWU1MWVmZmEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L3BjaS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCkBAIC0zNDM4
LDcgKzM0MzgsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbnZtZV9pZF90
YWJsZVtdID0gewogCQkJCU5WTUVfUVVJUktfRElTQUJMRV9XUklURV9aRVJPRVN8CiAJCQkJTlZN
RV9RVUlSS19JR05PUkVfREVWX1NVQk5RTiwgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxOTg3LCAweDUw
MTYpLAkvKiBQaGlzb24gRTE2ICovCi0JCS5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfSUdOT1JF
X0RFVl9TVUJOUU4sIH0sCisJCS5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfSUdOT1JFX0RFVl9T
VUJOUU4gfAorCQkJCU5WTUVfUVVJUktfQk9HVVNfTklELCB9LAogCXsgUENJX0RFVklDRSgweDFi
NGIsIDB4MTA5MiksCS8qIExleGFyIDI1NiBHQiBTU0QgKi8KIAkJLmRyaXZlcl9kYXRhID0gTlZN
RV9RVUlSS19OT19OU19ERVNDX0xJU1QgfAogCQkJCU5WTUVfUVVJUktfSUdOT1JFX0RFVl9TVUJO
UU4sIH0sCg==
--000000000000b7289505e16e2960--


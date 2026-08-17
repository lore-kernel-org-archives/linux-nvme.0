Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7470CC5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3y6CjxXHHdeM8tnL2wfghlsb88M2o9mGw/auke1rZrg=; b=VgnNsRP4WV+WuaYC9Cey+sLZUk
	HgsQAFLSNoF/0s2+BVNGxPG8dMoIEmJ3alJY08atJN1EhBh2vAQysNajyiEifLcugKfLmMwplzpZa
	q3Do2ICCb6nypmxGiJR/LBEnqm8tOv1iZ46oHHkvfHukcbSG0Lruc5f+CwBF5aK2z7n/gGRY7XA7v
	PQQ7uY9zPx6oLb92Yt+G1Vdlluaf7kKikBc/h9y2saFzLQbgyB67lKYRUnv6RkhZK8YYgQcFNwePy
	YGnteMmpbpFROUJ+/2aLn9pkXfuV7ke3B9NlrPdcDsb1193y4whxQP/Fbf0Mnem6+VhiG0cLvuBuT
	S9caFFlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww1Kx-00000006cDN-1aSi;
	Mon, 17 Aug 2026 17:41:27 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww1Kv-00000006cCi-1PBB
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 17:41:26 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so5019072a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 10:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786988483; cv=none;
        d=google.com; s=arc-20260327;
        b=VHdbn8jlSYjXcdIm/WGp/8AV3efvsJCXp7w3OLCgI2qkCkzduWywheKr8mfi9CFY0A
         XEtDSduTClW5pv4IYYJIyYDD75y+sw4itBWezb4dY7SUl+bxngOE9yzvw4b2ggWG3INl
         FxGxNySkLCkyMy2Ic9oud7BvAh/Clhz2Euqb5IVTSDHFSaKoMBjw5Kl0BmKNuzHDN/NP
         FYZkJ5b7mD7q6smwuDzdE+VSVKRWPtMq55Hi3mxpOkWoZUrP2cS22NWhLU0bwn0I8p1W
         KfmhdeGmknYZoAzcJD2kwHe+MXaWHuhKwJ4U1NHdOjVXy5wXzO2jwUvzf6VxTD/1Con7
         9wtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3y6CjxXHHdeM8tnL2wfghlsb88M2o9mGw/auke1rZrg=;
        fh=cPxf/vG0+HVt0jbfRtEdvTU6HeJGD+7yJ2TlVPYgDJo=;
        b=kJghJTqiWA10s7rp+yt0oZeO84S7UOfCT7K0pkDANwca1836n17XFoBrcroz3pKp2q
         7SxhfXJYc9AJ+dzOpsTuxz/Jl8EU81Y1Ta5ljjtPRDkZKPCvZq/1sdMTxsvTU+hG1jOE
         x3TIUzkTXl2goRTgswIt2BYeVCGRpPnmIPYUDmt6lQAI8+FU83ocvsBTl1HwJ45ED6Bu
         dXaJWaFBIeWpQ4dE+0TxZleU13yG0fF7UQEZdvmTNGFXEm5SNIYhpOiGxrtTqD9RAyF3
         SGMss3ImYY6vT40YhjJaKD+V/8pRl9h1WFG+BXoM/q/tRo6aT8si4pRVCcN+jUJziStc
         +D7Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786988483; x=1787593283; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3y6CjxXHHdeM8tnL2wfghlsb88M2o9mGw/auke1rZrg=;
        b=qApITgCaH31RH3XFjDJY1MLD6DpQaVpYVpDAVJQW4Jwfu8YidaqXFKy5hVRqNb79Ps
         i1UZ3i5pIv/fImTsX3e8kRziakMpi2SU1T/tyRZz+12o0bul1FXidqh33WO6sRMGFtBZ
         VQQITWxEnUugdk1E7MI7G1m+a7z3ACTQJK3f+NLH0Jz8nRgEg5ZkR2fmcq3XHfNgCCcz
         pvFChmVWkRpsEvqFTNMZAZpzNyqbTPwWE+ZbXCkVOebO+CeznHF8l4FhPl0coGLt7eYy
         XtYUynl/Zdyccbh3kQiPg1FVs4PBmvs8tgs1qdTFI+V29sxq9nracl2+heOEj8KIlNjs
         /7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988483; x=1787593283;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3y6CjxXHHdeM8tnL2wfghlsb88M2o9mGw/auke1rZrg=;
        b=BeAl4JbXg2EkBFVb+pk2rZzwAbekkXenvtwKnh+3NlAkSLrxlsxIW8kqs8vIsbwaKN
         jnywFQwIzCddRZXvLuyDjqSR6ArCPwxZIMNmNnCIksYjsF81krHN54GU1DJZ2GXIoH0D
         1pWOS4GJxrD/S1QsvhybVm6tZm6JMz2pkUUHTM0eSyifq5A33rUvazoW65LExYL7+7e5
         ohdXl0w0GgSTSIlSXfNvPpLTCcyIhMTkwbrvlVAlBuec9QavZgUURGBNjWbJG/wuyASd
         xQ2yPm7bIUUopWELSamQc3gWZ3oYCUugAbegUp3aEZcVmUcGBl6aNS9aIg598RNWY6vY
         nbRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJwuvkjtCaax3pMzRgt+2gFN2gCN10ea6NV0Y/8+Ba9KKbrlg4ZHlFTQNNccoc37/jfvLkJFyZN91S@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5Wq97rkxy4Yj3zqAhcE2i5x5iSEiT2Kn0A6qMUEjC3CSf6uy/
	HmPvHxwpRFe3n6dY0XqMlWrCutO0xe7LIIAF0mtUJ8avnhheh+sEb66e06UwT+i2g8ubXHk1cEY
	Euny06ELHZ5qcndicG7W5nweq4VQTnsE=
X-Gm-Gg: AR+sD11ProsoNQlcVPbrh/IoWv+XzZpcYkqiqdC5qepAw10yKZFRphOvXQpmA04U1M+
	7aXben4bJCvltd6/p1q35W03qc9pMeJRbbxYJ+2YlVS6Itizc/cQX4XhrtWCTUuWZYFR1MTXsT9
	/AYdAhPpQZExmUYOIcnqFEg/w2O8ipcYy9m79R2/dytwcwAdOh6bcgaD04lu7T0RuDgUQ5PJAJ2
	j1IuJ7+q+JeSrR+YNBPL9uZNkFI8wKfU7TDy8YYbDA/9tBqzzPwIctHXQC7C17TP4ITPtxx+P4Q
	/C+1tG9eyAy7Fsm6kwMEnl0SwZWJxBMVanXZFre5v1Rbi9ZlcDI+us4=
X-Received: by 2002:a05:6402:4583:b0:6a1:ab16:5c05 with SMTP id
 4fb4d7f45d1cf-6a38a9a4799mr12641988a12.19.1786988483274; Mon, 17 Aug 2026
 10:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260816191729.2865523-1-coshi036@gmail.com> <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
In-Reply-To: <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
From: Chris S <coshi036@gmail.com>
Date: Mon, 17 Aug 2026 13:41:12 -0400
X-Gm-Features: AcwNN1UQbko-W5cGmUo5i4jil-CtTZTZ078Uketb8Up8FXe3EKGlTDeM64H-iXc
Message-ID: <CACd_6n3jTkxohh6joJ=HxsVtMwU3X8o863jn47gYyuh2Q-vOUw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, 
	joshi.k@samsung.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_104125_425848_20AA2C0E 
X-CRM114-Status: GOOD (  10.41  )
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

Hi Damien,

Thanks for taking a look.

Christoph already answered this, and I agree with him: the split return
is deliberate and a common pattern in the nvme driver, because some
callers do need to tell a controller-reported status apart from a local
errno.  This function is one of them: it opens with "ret =
nvme_identify_ns(...); if (ret) return ret;", and nvme_validate_ns()
then only removes the namespace on "ret > 0 && (ret & NVME_STATUS_DNR)",
which it could not do if the status had been folded into an errno.

So I kept the fix at the call site rather than changing the calling
convention.

Thanks,
Chao


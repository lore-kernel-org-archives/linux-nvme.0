Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8CAEE801B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=akxfCcmVWOAThRjkWXcwRKyLt46htCQWEcCKHjEM+Qw=; b=xc1X6N30n7ldgQut/ftmANisYa
	lqNIBIWNDVBVWj0rPYeEcT86AqicBUv6rDQSGTSE2tQFGyTXQ/gqKIjcHGvRVMSzlWQjCy4S6q5pB
	Xx8BMkTA4BCpeLtoiRh9TcZNJ2i4PyO+l4n3vBWJalqfZu+MqwgeGYlIqZPTaYAm9qSCIYobHF/mL
	OMDF44SHK8rU60D3mqkaU7ABQFmPf5n5XGmubco4m14gtz/q6J4MTFYpmf6oduxyjx2WYyPR/vfGI
	IdFp0tqfDseWmIAM+4apTXeSbVCAFitov7EEQHq7qGPp+7OcujFCFXGLN42HmmXaJXDXObdaRhHOB
	CSmjmsKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qee10-00E3Dz-0m;
	Fri, 08 Sep 2023 16:07:26 +0000
Received: from mail.archlinux.org ([95.216.189.61])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qee0x-00E3DT-1A
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 16:07:24 +0000
Message-ID: <f80e9412-eaec-467f-8b18-b128df31ae17@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1694189241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=akxfCcmVWOAThRjkWXcwRKyLt46htCQWEcCKHjEM+Qw=;
	b=Fey+7dWIOREqVm3fbtlWNz8lBJkeaX9Tfco7s+XIJdWmzY1tGUXX8DeuCIUT58pHTe3vUw
	LrPQRGH8YlicpZn8Sk+PjnSre6kYJ0GOdrdT2S6yhgr5yqxx0y7PcJgrTpRIR4Iw8N2G2E
	sdAw25OKmjjpDexKr1pv0JoMvy2KmXaeYrmMCZYtRPXL7aswMXgfiTTE2SoPWA63eJ+xOa
	+mQQo8PV1Cb8ep2do1i0XQytKwjEHtFryRCdsWfaxU0f4+4l6m62nExFpa1xrs3dVkBz7E
	foW2CyY5QFSVh8jz8yCtzwO7k5b8k8espi48qR04c4mSrK4wZa6CxD61yv4S3m5lxbwvr4
	n5+qjbfjz177yJ5IPAs8OoEx6fFHSnkQGishk5+Eywqousbjt2Wt/vY2RNqhiA5HpjgVhX
	Wq9z30iB0AnhHX6EnAh1l7az/6eNTtgITyy3vHaD9ZZvzfElvrs4dWkSSxaR2lJD+Lz3kT
	8WlJQB2C7xvmzKrlJtv7T33VdztHoN45yX+BbdZwPv5LhEnltc5NxvJ0aZUzkkyk5aOerJ
	qQ/Nx6OlhphM3vU11NdQDmmD3WvVDrflXQCqpP0hS5++SfU9ZD7R9DrFw7X2SrQ/VLo23b
	Gmmdci9eKZG4ZmOLAtSOcmAeeGQ84b5gS0+jnrM5Gd9qsCak2WgB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1694189241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=akxfCcmVWOAThRjkWXcwRKyLt46htCQWEcCKHjEM+Qw=;
	b=qB5wnyN6mwLXmWF9V+EdnECY4PViagJXgrKvq03AW83VJQgrAGgZT6eC2c/z6MfKGM6HEq
	dkF8VzJrJGFme6Bw==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date: Fri, 8 Sep 2023 19:07:15 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for
 MAXIO MAP1602
To: kbusch@kernel.org, highenthalpyh@gmail.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: xuwd1@hotmail.com
References: <20230907183605.631347-1-felixonmars@archlinux.org>
Content-Language: en-US-large
From: Felix Yan <felixonmars@archlinux.org>
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
In-Reply-To: <20230907183605.631347-1-felixonmars@archlinux.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CSfclF7EPJQL7bG0d56Qnto7"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_090723_702691_44140CB4 
X-CRM114-Status: UNSURE (   9.40  )
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CSfclF7EPJQL7bG0d56Qnto7
Content-Type: multipart/mixed; boundary="------------fjSE9OOIINBA0DifworhVasJ";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: kbusch@kernel.org, highenthalpyh@gmail.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: xuwd1@hotmail.com
Message-ID: <f80e9412-eaec-467f-8b18-b128df31ae17@archlinux.org>
Subject: Re: [PATCH v2] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for
 MAXIO MAP1602
References: <20230907183605.631347-1-felixonmars@archlinux.org>
In-Reply-To: <20230907183605.631347-1-felixonmars@archlinux.org>

--------------fjSE9OOIINBA0DifworhVasJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgdGhpbmsgSSBoYXZlIGZvdW5kIGEgYmV0dGVyIHNvbHV0aW9uLiBJbnN0ZWFk
IG9mIGFkZGluZyBxdWlya3MsIHRoZSANCk5WTUVfQ1JUT19DUldNVCB2YWx1ZSBpcyBub3Qg
cmVhbGx5IHRydXN0d29ydGh5IHdoZW4gQ1JUTyBpcyB6ZXJvZWQuIA0KTHVja2lseSB0aGUg
TlZNRSAyLjAgc3BlYyBkb2VzIGhhdmUgd29yZCBvbiB0aGlzIHNpdHVhdGlvbjogIlNvZnR3
YXJlIA0Kc2hvdWxkIG5vdCByZWx5IG9uIDBoIGJlaW5nIHJldHVybmVkIi4NCg0KSSBoYXZl
IHB1dCB0b2dldGhlciBhbm90aGVyIHBhdGNoIHRvIHN1cGVyc2VkZSB0aGlzIG9uZSBpbg0K
W1BBVENIXSBudm1lLXBjaTogaWdub3JlIGJvZ3VzIENSVE8gYWNjb3JkaW5nIHRvIE5WTUUg
Mi4wIHNwZWMNCg0KKFRoaXMgaXMgc3RpbGwgbXkgZmlyc3QgdGltZSBrZXJuZWwgY29udHJp
YnV0aW9uLiBQbGVhc2UgZG8gY29ycmVjdCBtZSANCmlmIEkgYW0gZG9pbmcgYW55dGhpbmcg
d3JvbmcuIFRoYW5rcyEpDQoNCi0tIA0KUmVnYXJkcywNCkZlbGl4IFlhbg0KDQo=

--------------fjSE9OOIINBA0DifworhVasJ--

--------------CSfclF7EPJQL7bG0d56Qnto7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmT7RrMFAwAAAAAACgkQeGxj8zDXy5LS
6w/8DqX+N6pQhsu9CrOZvtA8yhEhQIhlNaDQvuKlCUIDgJTXohM1r1tgNaNtCneYb7KqKgr33xYC
CjTNqt3scHxJSe+YnSKAALlWnIOq7D3/sSHA/navfXI+NDgDsezujm4mv8GbnN+2ug5CG2U4yprA
Lx2RkM7+WppuQrtDFLbCj8bUHznP0MbF+9cmlLyTzgg0/g5PPkMz8t7qMzccZr6j+AwkLfmI89Hk
CkQ0EFtTuySgH26BPpQcCBV53fQCS4Oz+zjCX74yfDBA3TCuFJmdG8fSJbLS88Qdr5mx5sNCBccC
/oW8nJKP/t5rrl4Yh3P2Tc96+6RKdBrJexW7jK1OPQTqom7Cd3l1Cjx0QdHWEP3LTcrRUlXXnrmi
1aaI3SX+ecI7aI4zcwpDXyE1BNxkaAPOX3+UlB2aQctKh7jbHcF2Y0Bx1ISs9RnLZ1ZOuAzq163W
0khTNk3A8KCk+7ahBrdQfk5IKaoNDCAAtZKTStNgDy2pkulwvuf/IdsgE+qDtX4SjhseG6+ofr9A
a3W1IN4Q+1DxIpN5qNMM7iW5Kshyg908+oQ6umbTcGHvEuwTMOv/heJXx+u0dGgQjPJRKCbCDn98
7SotFkSaKEvNpaq++qqbVsBwjOQUiqrn0QeP3KaTun32VO5ZE7RzR1Hqkv703smjTQgtfa40sSe9
qQs=
=tLLK
-----END PGP SIGNATURE-----

--------------CSfclF7EPJQL7bG0d56Qnto7--


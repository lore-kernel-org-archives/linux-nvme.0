Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F6CC52D6F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 10:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=kmuMFyIlL9x0Ka7SclEeFFqfwMDOxadLsFa2y+ppyVg=; b=QnIszOobRk5A6/erouGSxe2PGj
	DlnAt1lxr2Wb1cTo33RtX9z3sYRna+TFE6LXP6IjExOjkO9t08gKyNJdTycOL5R2GIG6mghR7l12d
	QezgWudnarSkGFHPKDKLgW3JnNK4LLFFIJbzP9k/vOzbgGHZONpmJiReaQ+lXiXdPiXIktOgjyH1h
	2TuuaKQoO+BLcbTxHaq0Ofi5Mj+UQk6QLNcS+7s8TV89Z6PfZsMkr/awnB2g4cEUkrEf62UB07DO7
	VNXHT23db+9c5/upknMIVYvH+4Sp+IvTfqTZnZQEd9eCSHV5EujQB7TI4OLBlPfh9o16XwNYWh7SY
	CxyeJTxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgiQ5-00000008OHQ-2Uxv;
	Wed, 21 Aug 2024 10:18:25 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgiQ3-00000008OGX-0biU
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 10:18:24 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 906DA240101
	for <linux-nvme@lists.infradead.org>; Wed, 21 Aug 2024 12:18:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1724235497; bh=3JZ7hvIkY2BOxMgYfbeJ1+m4fpi90bJQSLmajCq/Vd0=;
	h=Message-ID:Subject:From:To:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=piwGOF44+Ylfrh0uAi7f3lEbgJ0Y7pvLTtJ+Swihr4sD0geCAMfBJadXsfOrWEytC
	 emZDQj6mkfpYAMfY2RzTIQ5S4Imx4t0LGTjnpOwqACvR+ZIr5QuWDnC2S10Eq36ktC
	 Cz1iAJT4X+mMbA9s4cYIxKblG2L/ni5N48p7pO2inm2SPrkzQL9Zfq1bXbiPDI7tG7
	 /Y8zRvOYqtvnjonBFzDyR5W4Wr6NHaIIv7GPKxNC8zOjJCsaUD6CyBga/A+QPwyojG
	 o759DljWjBnrpMZMRy9Pj+ovqSsD8SXJlPPSf+v5tX1XQ3jXo+/VPfcX/bQdMwTwEg
	 UdLTI7PPfD5mg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Wpj2w6x8Pz6tm4
	for <linux-nvme@lists.infradead.org>; Wed, 21 Aug 2024 12:18:16 +0200 (CEST)
Message-ID: <f82b4614b95be6f826da4350fb39c4eb8daafbfd.camel@posteo.net>
Subject: Re: Re: [PATCH 3/9] nvme: add nvme_auth_generate_digest()
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-nvme@lists.infradead.org
Date: Wed, 21 Aug 2024 10:18:15 +0000
In-Reply-To: <20240813111512.135634-4-hare@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_031823_352875_5CA46970 
X-CRM114-Status: UNSURE (   5.83  )
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


+	hmac_name =3D nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algoritm %d\n",
algoritm should be algorithm.
This typo is also present in other patches.


+	ret =3D base64_encode(digest, digest_len, hmac);
+	if (ret < hmac_len)
+		ret =3D -ENOKEY;
+	*ret_digest =3D hmac;
+	ret =3D 0;
The value assigned to ret in the if statement will be overwritten.
It looks like a goto is missing.=C2=A0

Regards,
Mark


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71370D20681
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=dtpu2FHUO9j0qVj0V66vAjX5Qf1+qJtx7V8eJm53wVA=; b=RgsmMQgX4sLCzZihg6K7Fi4YIT
	N5ZEJeznVdDf29n3jBp7BRE0J5QGklY8qqSJItFbogchb89px7NTg9wqS2B0fevBZl/VwgvTqAaKA
	T+aLz9EvszYZPqAHfrR16HNMh7euYj057TeuEsMLPcYXtBCHtLSxdW281HGload6IQJ9QL9BoLjeJ
	riXp8jI1WUDDOyppc+HKXBFH6q2KKqE6fTekWo2LQas/PZ49adGf01NbE5S3ydhyDqTIHFX0qZ3dV
	mZ/buSz4Tmsuwud6wbVl7/DczvToBOCHlcx2eAhzED/5c2kpUxAEtbSWSEgoi9Od8fk6ALO/ksIiM
	stx/BqGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0q47-00000009nyI-1M6W;
	Tue, 15 Oct 2024 22:30:55 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0q44-00000009nxT-1m5k
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 22:30:53 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 83F8C240027
	for <linux-nvme@lists.infradead.org>; Wed, 16 Oct 2024 00:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1729031447; bh=ZkkevOv7CfWQayKO0/1pV+Q9ccSYj8YpxDLA6WEVnRI=;
	h=Message-ID:Subject:From:To:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=eSAxcUPo6NnjACpbUgRqE4eOHTV3o6i5WXySyyMEDm7jWKQ/xKhrcTwztFQBRjS3L
	 E5naDwcf7+CBTIE4w8Kg7doH+HKbFS86/3Xvs6sI20939h7aJRHBup4MuWrerzU50b
	 WUmzyQ8eoihhS9QaX/inCux5GdEUMYWVZeiYMCZ46pQAXBz2ScYZ5kChYjtE8leRR7
	 zS5blzAw17vRHHzz70aKOv39PI0U71Vq8+YzEm//DCaKJLSMDu8gdvCJC709qYD4rv
	 nB89sicwPTPaV94n0lVid20gbxAWaatLxslc2+Mapy53t8M8iC0jm6QtK9eQBYJvDc
	 qgv26OQB6FxPQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4XSphk3dh0z9rxF
	for <linux-nvme@lists.infradead.org>; Wed, 16 Oct 2024 00:30:46 +0200 (CEST)
Message-ID: <59e426f4069a3326353a22193be3740e041c4303.camel@posteo.net>
Subject: Re: Re: [PATCH 6/9] nvme-tcp: request secure channel concatenation
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-nvme@lists.infradead.org
Date: Tue, 15 Oct 2024 22:30:45 +0000
In-Reply-To: <20241011155430.43450-7-hare@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_153052_628671_3F0D8C13 
X-CRM114-Status: UNSURE (   5.25  )
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

> +	tls_key =3D nvme_tls_psk_refresh(ctrl->opts->keyring, ctrl-
> >opts->host->nqn,
> +				       ctrl->opts->subsysnqn, chap-
> >hash_id,
> +				       tls_psk, psk_len, digest);
> +	if (IS_ERR(tls_key)) {
> +		ret =3D PTR_ERR(tls_key);
> +		dev_warn(ctrl->device,
> +			 "%s: qid %d failed to insert generated key,
> error %d\n",
> +			 __func__, chap->qid, ret);
> +		tls_key =3D NULL;
> +		kfree_sensitive(tls_psk);
> +	}

Should tls_psk be freed in the successful case also?

That is what happens in a similar situation in integrity_load_x509()


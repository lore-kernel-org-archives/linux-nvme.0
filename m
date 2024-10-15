Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A636D20682
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=7D22KBkyjSReAYRCVMS/Wpsvl0YKdhCXv+y3yN8gJ+Q=; b=P3G3+zcSx2FOFEP31zgGsIHgTw
	8YQ7f5utBqOfscrjuT5BTqN/62YFbvuyxPJe0EwOuJyLMh76DA5a5R5C6Z+d2irjQnil9ugIFa8om
	pkyfFQepz3UQKA+7+PsqgUMpiF4bJ52GZCdZM9zpp8b3xfSAlg3raXgeyLckWNvPPOgNYKNz6jVDU
	Ez6vNTJiI0xODchbGxI8AXFkxa94CsU8jVgPDq8ykriUFZLVgBlPIfxuwzyb4PuRaupUGkz7IsD6v
	ncDtwt9FV1OXtK6kMPA3i5YKTXSTDl6H2XFOhCFfGRPlPEaBrYPEMeuyLPguMJgOXr1cjZSqbuB43
	KLp8sMew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0qWs-00000009rX3-38u3;
	Tue, 15 Oct 2024 23:00:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0pMK-00000009iRa-2VPl
	for linux-nvme@bombadil.infradead.org;
	Tue, 15 Oct 2024 21:45:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:References;
	bh=7D22KBkyjSReAYRCVMS/Wpsvl0YKdhCXv+y3yN8gJ+Q=; b=ZPLMiEJBHvV/iSr5ZvEe3ewqoP
	vt83u3l9TmlQQXAg+X6nRx7FP9hVoo0o2+hfGy9Azzr8HzdUsPxViyT9u1ESSbN3bwUNREhMsGQSr
	7pf6FqNniDSu25CT1Qq+OBjvNxjdPvQtlaoEFEp6CYICjJl9+Ijbs4L/fgRE9SW9DbJo08C7VM3wY
	aXGWqWQlyCJWgHUOfj1/VrJGCQ6B1lgACbroWz8aNE3ifoqG1Fh1KOMuwUjIyQCqdnRHEkvEAMmoU
	t3r/2CJtyHrGiRS+GfzhMITB0sdy/bo1UsbxSlLAA2OIBPI8Wb5FMeuLt5mRajwv8lRap8xAbf91h
	rYIpVmBw==;
Received: from mout02.posteo.de ([185.67.36.66])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0pMF-00000006fFk-0zmG
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 21:45:39 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B96CF240101
	for <linux-nvme@lists.infradead.org>; Tue, 15 Oct 2024 23:45:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1729028721; bh=Vev+tIKtwihqpaTxdI9pbmKSqFumMTy2zv/kRWJ3xYs=;
	h=Message-ID:Subject:From:To:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=DXzy6mZFyfABWig2TlmIIJ/j7bn80YDqrAh3Fw6hUeTkYVe7xHe78yJRzbs0qP877
	 YltnIMeQkC8le6Geu4HEyhCSMnf8AadulPaz1bFyDOLPFRFE2sNwFH33YpgA1tzWls
	 xb6GJPupbRI3S6cjTJWc0Ct+oCO7NYuIiQiuvKdIkrB1N9RWkrJ2C4ZXGJWid7PFPE
	 9W8WwZwGgg63RM9JrGcmQEShJ14L9FVQRBfQFEQflun2GBzRTSAC81rNklnqbJHD2K
	 1NwwzSqrOblbLIBYnaqBQF4Vk+qdid7aW2T7WvZKyrecCPvS53NIhVwQrc/u9vMY8I
	 q+1RqUVFdxmwg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4XSnhJ4v0Qz9rxD
	for <linux-nvme@lists.infradead.org>; Tue, 15 Oct 2024 23:45:19 +0200 (CEST)
Message-ID: <f97b0a0bdc863a8ad0af4fb3c4315853e326bf0b.camel@posteo.net>
Subject: Re: Re: [PATCH 3/9] nvme: add nvme_auth_generate_digest()
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-nvme@lists.infradead.org
Date: Tue, 15 Oct 2024 21:45:19 +0000
In-Reply-To: <f82b4614b95be6f826da4350fb39c4eb8daafbfd.camel@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_224537_702412_105FEE50 
X-CRM114-Status: UNSURE (   4.37  )
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

>		pr_warn("%s: invalid hash algoritm %d\n",

algoritm -> algorithm  (also present in other patches)


>	if (ret < hmac_len)
>		ret =3D -ENOKEY;
>	*ret_digest =3D hmac;
>	ret =3D 0;

Setting ret to -ENOKEY has no effect as it gets set to 0 after.


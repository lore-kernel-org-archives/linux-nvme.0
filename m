Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2923EC6FD35
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 08:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2URNaV+So08jD62OZYouRt8wnCVQmMTL9F/ovqhZr4=; b=y0h3okfep1to0jWBaRl0rx4EJd
	+Ap+RyAJTByntc8ub+T0zZZfpN+nfpZqWqX1dDhTarIklFYD2SjV0pKHhkmw4DcxbPSvtuua6zlr1
	mxbB7UPPDiZFwEPaFlgBklhxn/ikQrS3S+tGHqnjouY5NAVyActwhscRLQmiaJ6kkZ5u2SX+HDYsu
	iFAyMAblo9o0mq3PtmyYl7iWUBJAMniFL9wzzyGAXwEjcEVuvix29I8v15IwlXZ6FGbkuanSbIdX6
	P9hjobu6a4m92iyuDZFiGKIYX7OBhXWJsnC57MCvwvOyIMIDDJuzSr2bWJwp7AYcdRXv9+3MxjKes
	lum9Sg1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjaHa-0000000169d-2V68;
	Thu, 29 Aug 2024 08:13:30 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjaHX-0000000168m-1WKd
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 08:13:28 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 75A3E240029
	for <linux-nvme@lists.infradead.org>; Thu, 29 Aug 2024 10:13:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1724919202; bh=o2URNaV+So08jD62OZYouRt8wnCVQmMTL9F/ovqhZr4=;
	h=Message-ID:Subject:From:To:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=XpCldlyL4JtxF3ZlOZqB9XAcvT8SWxcUVtQ98uuYP31JW2mW16m289QMSRd9qNmx3
	 +OTp3tYhRzLvRcD8yiDcyp/cPs6LK0x0BWNIByGz93KgsmoaECgY27CgYUwdnZZMmJ
	 sLNK+dKBHmYFCGA08Xn7Ezu7B2P0V6FmP37ho8r18YhKHkQOQ+Bv7FC6f5xPtcBqru
	 tjN1Lf4bDOkhz/iGYwJdKmw1QVPLYBrmJrJIOcZmt86BYmQ18Zpoc5vR95INxyUhkQ
	 YtUZY+iY4z3usAaYhS63Hqtw6g1fUZsIMomVOS1uJ5ihKRVSoeWb20pvvOvEg1xyoB
	 9QJ79ZkPwswLw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WvYv46wl8z9rxT;
	Thu, 29 Aug 2024 10:13:20 +0200 (CEST)
Message-ID: <618b2e2dfd1366b0f0e911522529811cdfccec19.camel@posteo.net>
Subject: Re: [PATCH 3/9] nvme: add nvme_auth_generate_digest()
From: Mark O'Donovan <shiftee@posteo.net>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Date: Thu, 29 Aug 2024 08:13:20 +0000
In-Reply-To: <35c9bea6-0898-428c-ba23-04c7444494de@grimberg.me>
References: <f82b4614b95be6f826da4350fb39c4eb8daafbfd.camel@posteo.net>
	 <35c9bea6-0898-428c-ba23-04c7444494de@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_011327_567151_21C46A28 
X-CRM114-Status: GOOD (  17.01  )
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

Sorry, it is not a patch. It is a section of Hannes' patch.
I used the In-Reply-To / Reply-To / mailto header from the web archive
as I am not currently subscribed to the list.
I guess I should have added the > indent characters manually.

Ar Domh, 2024-08-25 ag 11:55 +0300, Sagi Grimberg scr=C3=ADobh:
> > Your patch is not formatted correctly.
> > Please create a proper patch and use git-send-email to send it to
> > the mailing list.
> >=20
> >=20
> > On 21/08/2024 13:18, Mark O'Donovan wrote:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hmac_name =3D nvme_auth_=
hmac_name(hmac_id);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!hmac_name) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_warn("%s: invalid hash algoritm %d\n",
> > > > algoritm should be algorithm.
> > > > This typo is also present in other patches.
> > > >=20
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D base64_encode(di=
gest, digest_len, hmac);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < hmac_len)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -ENOKEY;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*ret_digest =3D hmac;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D 0;
> > > > The value assigned to ret in the if statement will be
> > > > overwritten.
> > > > It looks like a goto is missing.
> > > >=20
> > > > Regards,
> > > > Mark
> > > >=20
> >=20




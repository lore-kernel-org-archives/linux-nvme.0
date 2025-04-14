Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EC5C369B5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 09:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t6n2IcrnYRPHiaTT+p8d2DcPEIY7YVEyk4gXThm7cmY=; b=iXV44vet3u3BGSoB0hZYyjKm7S
	dl8Nd3nhitR1GXRAOMhMKsqJVWLAcpV1OrhURy9tRaeN4dajw/y1hNbQdGzZQndKfMQYNY5ZuWI1E
	s9QVqsPvd2gPH3R+za1JI2HEMnZ7d2rwQT7dRn7VxEj+VMc/2lvNLkd2I4T3C/S+3xGwVl9XSIi4D
	jKAbjcyxX+8HIvy3xkPtR9OrcT+OCljaaB1XuthM6QDN06ciMZQ+rJN7x1qIn1/IF7TO5GyKXKLOM
	XCxWp7jra3l3eYNQ5Um71GWFc70y02Ym2SSN2u1qHj+bi3d/Slkf44k+7EuADEOPdMl9YIOqBfmYa
	h0HUBkBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FmT-00000001DXd-1ar1;
	Mon, 14 Apr 2025 09:07:05 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FY1-00000001AyS-0WAO
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 08:52:10 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9451A298566;
	Mon, 14 Apr 2025 10:51:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id c48ViGCIJwrB; Mon, 14 Apr 2025 10:51:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 135FF298580;
	Mon, 14 Apr 2025 10:51:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XwYOrSqftQB2; Mon, 14 Apr 2025 10:51:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id EDD34298566;
	Mon, 14 Apr 2025 10:51:56 +0200 (CEST)
Date: Mon, 14 Apr 2025 10:51:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Daniel Wagner <wagi@monom.org>
Message-ID: <258294513.285206781.1744620716750.JavaMail.zimbra@nod.at>
In-Reply-To: <D968D3MNPIMN.2HE3VWOAF5BVI@bsdbackstore.eu>
References: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at> <D968D3MNPIMN.2HE3VWOAF5BVI@bsdbackstore.eu>
Subject: Re: nvmetcli creates tilde directories
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF136 (Linux)/8.8.12_GA_3809)
Thread-Topic: nvmetcli creates tilde directories
Thread-Index: 2kjeWw7zjNsaZVmJeTm9L1Jw7rCFuA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_015209_312342_E1F29E07 
X-CRM114-Status: UNSURE (   3.70  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
>> After playing with nvmetcli, I noticed that my home directory was sprink=
led
>> with directories named "~".
>> It seems like configshell used by nvmetcli does not resolve "~" to my ho=
me
>> directory.
>>
>=20
> I released configshell version v2.0.2, it should fix this bug.

Nice, thx!
Let's hope distros will pickup the fix soon.

Thanks,
//richard


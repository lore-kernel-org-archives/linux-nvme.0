Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8875C369A1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=az8S3WRUHVy5rng2WzVnHfKVEsBwbdkXczmANbzQnfk=; b=En7SoYPQVpFmWPQvxaHZMTsSng
	IxycCzZzP5Es63rTdZcOR+X3MNM0s5dGLlIwfPESY0MxrbIRgkf0oMDDyAc/6evpv7o2gTm5ZL5K3
	ix/mUn1ONXpzAKNOMKEBwMvv3oTCmHaxkWfVi2CFLe/MTPqLqRYckDfHSRVD8yXKia8EcGtseP3tG
	YrvTUI9H0ErKYBLnzJ8SKbFL3qQ8PRI3DfXTEI0xhZWLrZXJkn12hQPhMasHfo50ZYMOChroKQV8q
	ovOzXV6/FSEpG6Er1uorV35TD3W/E1li/UJgyyTGpYubDDPHjX2DqDu6GiT7qDdR/gQCatx1uh/C+
	p89KlDzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TfI-000000070cx-2Fmr;
	Wed, 09 Apr 2025 11:32:20 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TfF-000000070bu-1z3f
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 11:32:19 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7323F294730;
	Wed,  9 Apr 2025 13:32:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ntsEDm8UWpyT; Wed,  9 Apr 2025 13:32:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1FBF3298569;
	Wed,  9 Apr 2025 13:32:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 65NahnhCWy24; Wed,  9 Apr 2025 13:32:14 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0BC32294730;
	Wed,  9 Apr 2025 13:32:14 +0200 (CEST)
Date: Wed, 9 Apr 2025 13:32:13 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Daniel Wagner <wagi@monom.org>
Message-ID: <1089727754.260822789.1744198333874.JavaMail.zimbra@nod.at>
In-Reply-To: <D91ZEKL37IT1.1KQCRPYZJ6J16@bsdbackstore.eu>
References: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at> <D91YFPG2AMZG.1QFEKLMBO5J9Q@bsdbackstore.eu> <821291480.260286905.1744188830524.JavaMail.zimbra@nod.at> <D91ZEKL37IT1.1KQCRPYZJ6J16@bsdbackstore.eu>
Subject: Re: nvmetcli creates tilde directories
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF136 (Linux)/8.8.12_GA_3809)
Thread-Topic: nvmetcli creates tilde directories
Thread-Index: 3SczLnqLhjmJoM9XcIMrVgUuux5ujg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_043217_649863_2AF27485 
X-CRM114-Status: UNSURE (   2.71  )
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
> A patch is gonna be pushed soon.

Where is your git tree located?
I'm a but puzzled where to look for the most recent nvmetcli sources.

Thanks,
//richard


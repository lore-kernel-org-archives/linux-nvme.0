Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD26C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxPUYpvgTEDlkKQCxxq48TaYIGf9KE6cEk5khF3gzeY=; b=oNcDy9V6Aywr+HB6JNDF9Mqa8l
	Zl9uSL2WmeJ83dyiHdarjz3BSMEDlBoHOUlnVBEDZA9MovHZD7erSKl550S/68zjaowI5n8VNmuzl
	CtJRnWTbxy/zqeaezGhvp6T1UD13uFz3QY7R29DPnHBgeRIjS5ACcLziqIywWjcC+V8HnhVthh4+D
	5JVyN24tZQiHNMAbRb0iF/sam46POq/L7pgPXU5N+pf1An8d2A7J+U1+9pQ8K5HR7+sbuSKdNlcF3
	CAObe5IVNEcY8wi5957pxNlE0E09LeJRGH1/v9WDMdOyGhSqd7mPkurhyXMn0oMLXHX8jOSv7bPuK
	KnbsHHaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RC9-00000006dup-1Ohm;
	Wed, 09 Apr 2025 08:54:05 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RC5-00000006dtD-3kfZ
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 08:54:03 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 26401294730;
	Wed,  9 Apr 2025 10:53:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zyHPc_-wWPF8; Wed,  9 Apr 2025 10:53:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C1B40298569;
	Wed,  9 Apr 2025 10:53:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W2gnXHp-M6tk; Wed,  9 Apr 2025 10:53:50 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9EEE9294730;
	Wed,  9 Apr 2025 10:53:50 +0200 (CEST)
Date: Wed, 9 Apr 2025 10:53:50 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Daniel Wagner <wagi@monom.org>
Message-ID: <821291480.260286905.1744188830524.JavaMail.zimbra@nod.at>
In-Reply-To: <D91YFPG2AMZG.1QFEKLMBO5J9Q@bsdbackstore.eu>
References: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at> <D91YFPG2AMZG.1QFEKLMBO5J9Q@bsdbackstore.eu>
Subject: Re: nvmetcli creates tilde directories
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF136 (Linux)/8.8.12_GA_3809)
Thread-Topic: nvmetcli creates tilde directories
Thread-Index: 63CSeY6NRRNU/vovfCpTpgqvPdo0Ew==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_015402_079779_3F80F725 
X-CRM114-Status: UNSURE (   5.06  )
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

Maurizio,

----- Urspr=C3=BCngliche Mail -----
> Is this a regression? Which version of configshell is Tumbleweed
> running?

Dunno. It was the very first time I used nvmetcli.
Tumbleweed shipps configshell-fb 2.0.0.
=20
> There were some large changes to configshell upstream recently so I am
> wondering if something has been broken.

This would make sense.

Thanks,
//richard


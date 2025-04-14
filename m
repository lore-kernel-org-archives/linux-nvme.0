Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32818C369B5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 09:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=482LE4+vnApY7zsaAAEq+ysJuOIBEqCmraG9X9kvFeY=; b=D++sZS9FSn4ayMuz1Z+74XCPDh
	MNb0V1LY3EHsa6gU+ylyATPbCnt6MzveAj1GdOnLMn3sOvCwKqDoIJljPh4oYXeK6pBUs8zw0q/C/
	Nd68WJQQxNQv4K3eGuavKQhnQuH24ISH1UexsSy2cbEysoiwYsJlpjew3jpndILze9/qMs1/mkTTV
	621zGP6PcgKBJCPP2dOwtmqzHyhtIfF775Nn9dHUV0EdOlBO0v84MagUmNG2UlEmjHX915CKBtpFP
	WSD6xn4GlRKdjFJpfy4RI6qWZi1SnHA3OCN8jlPqwhGnfQxVoEXx5LnsL1AZqeVbeiC4mdhanauea
	t6Q2pJyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FmL-00000001DRc-1iJx;
	Mon, 14 Apr 2025 09:06:57 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FUr-00000001ARE-242P
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 08:48:55 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 0c4435d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 10:48:51 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Apr 2025 10:48:51 +0200
Message-Id: <D968D3MNPIMN.2HE3VWOAF5BVI@bsdbackstore.eu>
Subject: Re: nvmetcli creates tilde directories
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Richard Weinberger" <richard@nod.at>, "linux-nvme"
 <linux-nvme@lists.infradead.org>
Cc: "Daniel Wagner" <wagi@monom.org>
X-Mailer: aerc
References: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at>
In-Reply-To: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_014853_892747_34D9198C 
X-CRM114-Status: UNSURE (   5.29  )
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

On Wed Apr 9, 2025 at 9:43 AM CEST, Richard Weinberger wrote:
> Hi!
>
> After playing with nvmetcli, I noticed that my home directory was sprinkl=
ed
> with directories named "~".
> It seems like configshell used by nvmetcli does not resolve "~" to my hom=
e directory.
>

I released configshell version v2.0.2, it should fix this bug.

Thanks,
Maurizio



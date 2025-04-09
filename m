Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FABC369A1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5R0GHnwvqjlKq+KRjotTinFcLOIy1ko5x40Scnmq6XQ=; b=xChqq5QCEypH/e3j76ctZVzLO0
	C4qwrfnKlwpAkqamSRYOipv2pc/lDQ2nGpCMg3oAt2fq2AadGV1cIRMRCJciyqclBCscLOkyuBWWC
	tL5GgvO7oq+Axk2Zt7s4pH7nDbz6qQqV/DavAWuyPqfjW3KBDvaqaQ4r3mLMS77Azo7awbZJVm/hE
	rBH6Nd1bUyE6NCHXNfpSOINGn9GBKL4Pyp+RVFnsctY3ztgVPBHzGcrMGiTzfm5F+ik+vFUKnv3/l
	auB2q5AsXSf8nvkT7YjVctDWiI3w66ZUIrtPmOl4pW1MSlQLF7pjneOa9iIwyAqanVju9shm2vW6+
	Zn/JG4Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Qfo-00000006Yhd-0MEz;
	Wed, 09 Apr 2025 08:20:40 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2QWw-00000006XIW-16Qp
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 08:11:31 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id b33b5249 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Apr 2025 10:11:25 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Apr 2025 10:11:24 +0200
Message-Id: <D91YFPG2AMZG.1QFEKLMBO5J9Q@bsdbackstore.eu>
Cc: "Daniel Wagner" <wagi@monom.org>
Subject: Re: nvmetcli creates tilde directories
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Richard Weinberger" <richard@nod.at>, "linux-nvme"
 <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at>
In-Reply-To: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_011130_634104_E1DBFD7E 
X-CRM114-Status: UNSURE (   6.18  )
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

Is this a regression? Which version of configshell is Tumbleweed
running?

There were some large changes to configshell upstream recently so I am
wondering if something has been broken.

Maurizio


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A9EC36010
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 14:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GBrnXt5W94TgeLiXXzBYrd6qWWjrzLkKT1v/hTJZtbs=; b=TqdsO3/drzcwWo24clAU4zBZlT
	14rZ4CfOZ0Nb6aHkuOufY5VVMIbvmobv5XZcPpeWCek+P7Jh99NLloxGpQ1yTP6Niv0muSZ7o+hbm
	cxzGiHfNKxV0WP+E/7BctZ4vhrkNZMUfWKxJOPlZ6YofVA/DfFQ38N82QGAcT4MxsvJCtQXmTEmk8
	qe824cP0HjmBSs58ty5JmNEdYTQl+pi4lGlmQsDmh02A+N7Hz2AdTIve/peqtc3Ru4ALbM4Jtszhl
	PvHVjsnQUZf36F2wNDWKxTHPxUJTe1aC2N09wYFKvmwzLNSlPlkn1Vh7VGw1yqKhxP+RGOoCMKERO
	8QVHpoAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3FDT-0000000E3rb-3wxB;
	Fri, 11 Apr 2025 14:18:47 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3Eml-0000000DzU8-42Lh
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 13:51:13 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id e110ab2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 15:51:10 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 15:51:09 +0200
Message-Id: <D93UWXK7696X.2QHJV38V6Z0NJ@bsdbackstore.eu>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>, "Daniel Wagner"
 <wagi@monom.org>
Subject: Re: nvmetcli creates tilde directories
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "Richard Weinberger"
 <richard@nod.at>
X-Mailer: aerc
References: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at>
 <D91YFPG2AMZG.1QFEKLMBO5J9Q@bsdbackstore.eu>
 <821291480.260286905.1744188830524.JavaMail.zimbra@nod.at>
 <D91ZEKL37IT1.1KQCRPYZJ6J16@bsdbackstore.eu>
In-Reply-To: <D91ZEKL37IT1.1KQCRPYZJ6J16@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250411_065112_359014_B13DCCE6 
X-CRM114-Status: UNSURE (   5.37  )
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

On Wed Apr 9, 2025 at 10:56 AM CEST, Maurizio Lombardi wrote:
>
> Ok, 2.0.0 switched to Pathlib library and
> I see where the bug is now.
>
> A patch is gonna be pushed soon.
>

FYI, I merged a patch in configshell that should
fix this bug.

https://github.com/open-iscsi/configshell-fb/pull/84

Thanks,
Maurizio



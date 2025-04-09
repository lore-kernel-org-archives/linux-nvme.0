Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A5C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 08:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4zOLyoubLlya9i4x7un8ShesvLBDcw/v58VdzL+Iek=; b=wqQvRH/i/GZF3EVSolcS8EDKXP
	bDj1pzSIsBfPGrUZRcvGRIU1IMz7BgvSOwdDNVVEJnB8+4rszJ2eLuxrmM1m3Gca6O7lwQLyRThiC
	wwon25yKnCmTGRNg6uHjxvAvR5CaNjIpA2cztUcv97qFyGDL6yDQmhW+o7wm0aStgoAufHZ3ixwif
	WJYSjfQhIcEpBpSucTW9YL2Z1fqQ1R21Tky4XHtiiQJh7BLrt70DbchRG8BjXQU3lTe+D0n50Zp02
	U23CpLRPdzNx4k7xypfOC1nyNTeEIjWmSIMvJeALvnvcker/vs3nx4yAhpzbHW6Sg89Zl1uGvAF1G
	28jOfjbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RF1-00000006eNF-3RSV;
	Wed, 09 Apr 2025 08:57:03 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2REy-00000006eLd-0eSu
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 08:57:01 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id f5f799e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Apr 2025 10:56:58 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Apr 2025 10:56:56 +0200
Message-Id: <D91ZEKL37IT1.1KQCRPYZJ6J16@bsdbackstore.eu>
To: "Richard Weinberger" <richard@nod.at>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>, "Daniel Wagner"
 <wagi@monom.org>
Subject: Re: nvmetcli creates tilde directories
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
X-Mailer: aerc
References: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at>
 <D91YFPG2AMZG.1QFEKLMBO5J9Q@bsdbackstore.eu>
 <821291480.260286905.1744188830524.JavaMail.zimbra@nod.at>
In-Reply-To: <821291480.260286905.1744188830524.JavaMail.zimbra@nod.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_015700_521391_977FDFAF 
X-CRM114-Status: UNSURE (   5.64  )
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

On Wed Apr 9, 2025 at 10:53 AM CEST, Richard Weinberger wrote:
> Maurizio,
>
> ----- Urspr=C3=BCngliche Mail -----
>> Is this a regression? Which version of configshell is Tumbleweed
>> running?
>
> Dunno. It was the very first time I used nvmetcli.
> Tumbleweed shipps configshell-fb 2.0.0.
>

Ok, 2.0.0 switched to Pathlib library and
I see where the bug is now.

A patch is gonna be pushed soon.

Thanks,
Maurizio



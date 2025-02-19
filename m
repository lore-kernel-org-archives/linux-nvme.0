Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35601C021B1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2025 09:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=; b=Masz+mt6BGFmd7OroRd/DlLiCI
	AJahjFBEawh4SneX2gUs4EQGdoDuscCGcWSyHnhMYWQv6/IcMzwITqvVUD0K85JUMH4JG+tL6AtkR
	OQaXwZFrxdjqa+8Sz4wjs22+QjxSqJVYKvm7sM0t3iqFMfw3At3+hAenAZzlPlQQ8hjHcmaHQCcoJ
	hRjX0zYJDL0ZYg0esN/ow1ZnPH0bZpyBdQtw/IhIG+pTZe3Qu1K/9GBPqwlf7uG9Sg8K6+/uR8/6H
	9VoetGVg9YSVm0SiqO1PnZvBzUHpz2RrVfSRV7Q/yPZLLW+QWflKMIc1T8QaOpgW/2PZerW2dSpvl
	Z+tRIdUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkgXc-0000000BvCE-0ENn;
	Wed, 19 Feb 2025 09:38:52 +0000
Received: from mail.corporix.pl ([151.80.59.204])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkgGL-0000000BoZz-1iTm
	for linux-nvme@lists.infradead.org;
	Wed, 19 Feb 2025 09:21:02 +0000
Received: by mail.corporix.pl (Postfix, from userid 1002)
	id 5267423878; Wed, 19 Feb 2025 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corporix.pl; s=mail;
	t=1739956281; bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=;
	h=Date:From:To:Subject:From;
	b=AHCO9h2O/8rKFSLKfVzwlgWlJ8oT6uLNkQ3NX2huOmEAZ6AhE5mLC+17tfMkZB7I0
	 Q3Wah2nbEqrwfswkwmcK+L6yGRicoMYzreYB3DF3Mxfcvw14t41MWzJG0BgzIecYDj
	 72JbghWRTOmmF7QMwEtN62TjO7NJcSO1HuyHwdcI36/7JwQGGzHeFrLabXwE7AusLq
	 /J+UtFW51qwkd0Kp+A5WtHbpGKSposAUC8WSfrVNG9j2Ri900ebMsNTgDDbbDOKKjy
	 vvhO1icxPSzekLea9pre6wCF3McPxuzrLG/Rv9LpYiwVZQJnTAvxhCFvDmrgabuwj9
	 8pMGZ8TO4ba+w==
Received: by mail.corporix.pl for <linux-nvme@lists.infradead.org>; Wed, 19 Feb 2025 09:10:43 GMT
Message-ID: <20250219074500-0.1.h.4f7i.0.u6xplcn7vp@corporix.pl>
Date: Wed, 19 Feb 2025 09:10:43 GMT
From: "Patryk Wysocki" <patryk.wysocki@corporix.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.corporix.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_012101_586199_9CEEEDC3 
X-CRM114-Status: UNSURE (   2.88  )
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

Dzie=C5=84 dobry,

Pozwoli=C5=82em sobie na kontakt, poniewa=C5=BC jestem zainteresowany wer=
yfikacj=C4=85 mo=C5=BCliwo=C5=9Bci nawi=C4=85zania wsp=C3=B3=C5=82pracy.

Wspieramy firmy w pozyskiwaniu nowych klient=C3=B3w biznesowych.

Czy mo=C5=BCemy porozmawia=C4=87 w celu przedstawienia szczeg=C3=B3=C5=82=
owych informacji?=20


Pozdrawiam
Patryk Wysocki


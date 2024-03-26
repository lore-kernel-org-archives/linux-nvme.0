Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BEAC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 08:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AcyyYFN8iyWvsWVimXMkrJHZr/2N8OWRbRUdoGMkW3A=; b=2eqTqDr5iPhZG0NF5fpe1WbWm7
	o0T16RbM5tmVd9gC/ONlacmhaiuLAW5SY7TgkFq3XH7Nbmfu5w6tta4c8YYcqI5ZkZY5+x3PU28EU
	0V+stVrEwegT3Q72BHa/bcr4lKtOMsitTSlu0EKFiAMpeW2hDmCfDdjUOzB3Xi9HRwqh9dfeTS/lK
	cICEzNfdxxrktyOkn6x6vGIrbQAxzIW0tL/HsEHHea4og3/bqwdyaHOozrHOhkZUjxyZmy74aP++o
	MyoxkWN2K+EzgOgaj3uGB+PZd7XQu3vT0VgrsP6Pr24e+v2VnlZzbaXk/f/p7UDn31Pc4Y3YLdpAK
	CCuVJ+vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp2b1-00000003gxz-3KAh;
	Tue, 26 Mar 2024 08:55:51 +0000
Received: from mail.vexlyvector.com ([141.95.160.218])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp2ax-00000003gx3-1Xhz
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 08:55:49 +0000
Received: by mail.vexlyvector.com (Postfix, from userid 1002)
	id 1221DA2E5C; Tue, 26 Mar 2024 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vexlyvector.com;
	s=mail; t=1711443341;
	bh=AcyyYFN8iyWvsWVimXMkrJHZr/2N8OWRbRUdoGMkW3A=;
	h=Date:From:To:Subject:From;
	b=N+TCrsaePXwpaMCAzTyhPSEBOsIYM5GXY0rN42xH8MM040sLIcVIvHZm68nb2Eit0
	 Iaq3u72q1mDWzfty3g1+RKNiceHVq3jN2k84OoLa7KUWN/1WL1R6MRWtJ9hScSSpLX
	 D48TefII1mAtgTI4S4QE4Y449FysIn1MUKswSJqFZWsPpOoJz265p0BIjKnRNxHbb6
	 RjzFZ4g6HEPDyejdD0ITFd8oxF12I1yrQ6DN/uVhMEzvaSFVQfK+h/uA/WRJSiCdCT
	 pNV4Yd2/m5hTA22pbtB3zSLXWvMU4jXr8RGTbFX2p1vFTt9Ls2FEOLDSKoVZ0H7elT
	 o9kcp6NmU3z4w==
Received: by mail.vexlyvector.com for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 08:55:35 GMT
Message-ID: <20240326074500-0.1.ct.s952.0.fqfsfl0mi3@vexlyvector.com>
Date: Tue, 26 Mar 2024 08:55:35 GMT
From: "Ray Galt" <ray.galt@vexlyvector.com>
To: <linux-nvme@lists.infradead.org>
Subject: Specialist for your IT team
X-Mailer: mail.vexlyvector.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_015548_113277_6BEC51BE 
X-CRM114-Status: UNSURE (   1.75  )
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

Hi,

We are a dynamically growing technology company based in Poland.

We have established our position as one of the leading digital agencies i=
n Europe. Over the past two decades, we have collaborated with many compa=
nies from various industries, solving their most complex problems.

Together with a large team of specialists from various IT fields, we are =
responsible for ensuring the reliable operation of infrastructure, system=
s, and data security while simultaneously reducing the costs of maintaini=
ng the IT department.

If you need a dedicated team of professionals for your software developme=
nt projects, we are ready to provide proven specialists.

Are you interested in a brief conversation or presentation this week?


Best regards
Ray Galt


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFADC54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=; b=09KiRNar0Vdjrs/Z2HKuzsI6YQ
	bIwV/U0fSqBB2g+OpZlZW8JWs4boEQ7jrnRwpOR3E094JfaUbjymI3RZpzXfH1WAbGzGsw357oBQh
	NrGlFVHyTaO7Jw1Y2TqAzjyQaxHjIsutvO9jn2y0TsCLiILtoLQVZphAApIxAz/zLSQ6rRAFMIQcW
	naVV6HsQTtynR+y1IK6T4XuAnL17zm0qF4taKovP3uKTdyq8Bp1CWT28aPApbAeBt5hIEUlOWdvpl
	bh73Uw5vYQdsWhMVrxbjKV358jfEmECQ4mZy7WvOlX/1KoGe6z90HdlL6x8ZpKQThl6TTrbghJPt6
	yQUhpwlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnE0R-00000002MB0-1E5m;
	Thu, 21 Mar 2024 08:42:35 +0000
Received: from mail.haughton.pl ([195.231.81.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnE0M-00000002M9p-3va4
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 08:42:33 +0000
Received: by mail.haughton.pl (Postfix, from userid 1002)
	id 4EAF882E6F; Thu, 21 Mar 2024 09:42:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=haughton.pl; s=mail;
	t=1711010546; bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=;
	h=Date:From:To:Subject:From;
	b=alMMtibDsyCedviZF/O+jwsesCc6DjQFPWA9keyGSHA+KAf2yRnCfKukbjsYoBe/J
	 Y0UzCNDtWpsS5gRLyqqTm4cxkcIsGPfCd1wVsdXAiCAGLfX9opfHnOkssI7LuPKfz3
	 yRO9dsZ6yYpSfdga5djkooTD/oYV6rdf7fjL2eqakkONeIr95rI2qHG1oOO9ZY3Z9/
	 N6lOCtpikXydBsruHeeVPVNF+ph60LYgi9He6tFllJhaS/gbjxXH/GnIUteezJazMm
	 tH9B1QUjOdkYcomFZgQ89zzWXqrAgbIN3RscYnS0R1ay1gI3KDxQwEkiSCh4gOMta3
	 wkUfkh0WS6ehw==
Received: by mail.haughton.pl for <linux-nvme@lists.infradead.org>; Thu, 21 Mar 2024 08:41:03 GMT
Message-ID: <20240321084500-0.1.16.bpig.0.5jiq9n4noh@haughton.pl>
Date: Thu, 21 Mar 2024 08:41:03 GMT
From: "Patryk Wysocki" <patryk.wysocki@haughton.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.haughton.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_014231_722947_C81C13A3 
X-CRM114-Status: UNSURE (   2.50  )
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


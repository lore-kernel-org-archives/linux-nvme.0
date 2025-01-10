Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C706AE7719C
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=; b=TPu0V6ddDbl+7E4uarVBZVpWG9
	AiSCkSHkSd8blfSxn3OhmBx29rrrk2Zx9LCpxlKNAubyD3VSzAZCe1++mQ+Hv34jCgPfrsUGpLWRl
	+h5/+EjUQ04p+T+A3HFrvkAF3wdLzpLwL9LRzDJ8jl1TqieuZexj7qdEbcd9cRy+UrOvJjCuqYZut
	MfgWBRdHJBsjNTHdHwNxfBjh7hG7WFzJ6EvwxQipvwLr3O31NwOXGyLrpCjXSS2l/pcvhIj6qAHrA
	RvfAg18kqmwrapenm9uIUadRmJZ1AekAug9kjmXTY5PrECABUqbF0oG+XjyRlnXVnC5N9eBdnBeLn
	2bNuyw6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWB5W-0000000Ee1T-3h9f;
	Fri, 10 Jan 2025 09:13:54 +0000
Received: from [217.61.0.75] (helo=mail.taskinium.pl)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWB4t-0000000EdwJ-3LFU
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 09:13:16 +0000
Received: by mail.taskinium.pl (Postfix, from userid 1002)
	id DF3BB84BB1; Fri, 10 Jan 2025 10:01:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taskinium.pl; s=mail;
	t=1736499703; bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=;
	h=Date:From:To:Subject:From;
	b=FHGAduXUU7iIw8Zt94Lgg63fnbZWNHVCTMMWrwATt549m1kH/sNqp8BsbIqovbHp+
	 HYdouySkYJ8TaIi8f52pw8F5DaEzw8z7oi2n2L/D1odsttAiHucmufQPGFJyPO7RBo
	 ypd6ktGThTwBCRp0SWDHmR5D44NvdQ4OKb4LvL5QXfqfp/IlEtlO3kk6GMrsthWwBP
	 E3IEM9URWa5njoxjQe4ZmZAowRMKyDi2dEu6aj7fiCdJFxuO+5SdWniYUBHc8QN/YH
	 aPmdiKxBn+Wnj3GU+Grm/jDP96ktsI3ysWjY8umQogEtSP1Nq11uKMg80KP+W9+NTA
	 kk8ldrc0RrwCA==
Received: by mail.taskinium.pl for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2025 09:00:38 GMT
Message-ID: <20250110084501-0.1.d.1r7t.0.r8r2te5ii0@taskinium.pl>
Date: Fri, 10 Jan 2025 09:00:38 GMT
From: "Patryk Wysocki" <patryk.wysocki@taskinium.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.taskinium.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_011315_964457_7C9FA4C1 
X-CRM114-Status: UNSURE (   2.89  )
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


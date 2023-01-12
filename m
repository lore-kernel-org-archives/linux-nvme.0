Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDC0C54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2S0GQFScndXkBEK4sqdoOhOYLqsB2sEH8Q5XQfVvKpo=; b=4Glw/99Y9JgY7+pRdILmlNP+B9
	+0eAH6MPDMCIE1HvY2NCcXjrL9N8a6RjzvF4WEkclWXPIicWjfgvntHJcTaN0Tv7O03spmjMGoJ/X
	E4ljDsNNTJUaCX/KN9stL+TNpO+Cd7qoIGtj0199aq90rX7hxLbmj5Y+U8y4ndye5IjuNzbhEmNZg
	H8Jpc/KBhzZkNHaiaJsbAg6nZ9m/rlNsOrm8ax8ebaUondPtTpGMObrtnO7NfS6WSodGtQb02d4Om
	D/nO09XiQt1XHumohjskrdXgI6pe1VYGTFoL/QHmXyK7IOSgobaWQ1kmqSxQly2bPebZK5IwO5NKx
	/pdU/L5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFszW-00E6UM-0u; Thu, 12 Jan 2023 08:31:18 +0000
Received: from mail.glencoeaur.com ([217.61.97.113])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFszR-00E6SO-Mj
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 08:31:16 +0000
Received: by mail.glencoeaur.com (Postfix, from userid 1001)
	id 3B3CB81F3F; Thu, 12 Jan 2023 08:31:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=glencoeaur.com;
	s=mail; t=1673512264;
	bh=2S0GQFScndXkBEK4sqdoOhOYLqsB2sEH8Q5XQfVvKpo=;
	h=Date:From:To:Subject:From;
	b=MMB607SHSHKx+x4VddHYncUFZ1nISj/M/gZ9i67a5O3vHLjf9yz2JiBM78hnhoJ0s
	 ++nhDK7P1I675M1Tp0cLHLeqW2MOYpR5j94usBe1c0sx28w0H83vZFH+SzwdprU2rf
	 Lq+eh+RvtNU79aKZjqKffIpCyd3KzXD6nqpMXF1BbPxb3SAgZ8dr6pYmzh2y/blEOM
	 4DC5DZTYd3HgZm2nnkd6vCuILy9i4BVSqi3F35kwTWymbjI6nBdJIH+LUI5a24lMp6
	 QCZPIgRmHMpN+qeaTFFs4j9P2y3uDsRnKBkl/jrEvqqxgpWV4kxxMTYxkesNw5mGAr
	 ZyaJ1wW404ZqA==
Received: by mail.glencoeaur.com for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 08:31:00 GMT
Message-ID: <20230112074500-0.1.z.3eyc.0.j90coaex89@glencoeaur.com>
Date: Thu, 12 Jan 2023 08:31:00 GMT
From: "Zbynek Spacek" <zbynek.spacek@glencoeaur.com>
To: <linux-nvme@lists.infradead.org>
Subject: Silikonmischungen
X-Mailer: mail.glencoeaur.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_003114_505684_6989343B 
X-CRM114-Status: UNSURE (   2.26  )
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

Good morning,

do you need intermediates for processing, plastics (e.g. rubber) or silic=
one mixtures?

We provide a wide range of silicone rubbers with various properties, sili=
cone mixtures from renowned manufacturers such as Wacker, Elastosil LR an=
d dyes, stabilizers, primers and anti-adhesive additives.

We also produce technical silicone compounds with increased resistance to=
 oils, resistant to high temperatures and water vapor, conductive and man=
y more.

We provide fast order fulfillment, timely deliveries and cost optimizatio=
n.

Can I introduce what we can offer you?


Best regards
Zbynek Spacek


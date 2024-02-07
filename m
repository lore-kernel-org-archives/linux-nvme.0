Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57EBC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eW5gIlR7FSYcaqimTTOOjNJ2mqePZQlFF2wPW8N1JT4=; b=nE+qlmpyi0HcSs7GqPnimL+uSK
	LEaFhf+jY/oUUlN6kN8jadhamK3LQjqbIHoWH2oDHKArrnOrEL5TCEDT97P72VeEFI1azerWJXJDS
	oEzIPLO+rb4BmUb5Mc+jRi92FPv4aB9aVeMNWVO20sJqKnla8qAC6j58NBaYAonLG6plrOWGPFK88
	2wTPfP7xkd8JeuAeao14cXEvKAsnXlvzrJimudl2OvIcbSKhdRDMR1CaxENdRl8cUJAzbUOSPYAPr
	RFDj/d6A/qWMamwEuAeKDEaS3p1H6RvKNsIY+PdAQf29hc9bPkKsjz9wVmEU8a1asMxyxa5ZMPpEY
	xo/YGB4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmqv-0000000BUn2-1eKE;
	Wed, 07 Feb 2024 18:40:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmqs-0000000BUmJ-1okH
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 18:40:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E92B3619D7;
	Wed,  7 Feb 2024 18:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C1C433C7;
	Wed,  7 Feb 2024 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707331253;
	bh=eW5gIlR7FSYcaqimTTOOjNJ2mqePZQlFF2wPW8N1JT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9cBovkCy4qDLFka2XRvRCbncPDlbsFJ3nbGRUYOQJTZQiWxeZ8q4KbXS1IAfYPxU
	 6wSgzUGb1CgEUoS6N6FDUYJ8wdDbSGeaZuTRPvFMmrEdLxq+2CctAho/BeNFl0RJ3n
	 rZyr+0dFpyWNqfIxnxu49sT0Jc808Kn7RJgSSqfCeo294pE/lT5o1UFZTH2nEhRggP
	 nQ877zqlK3roKcHM8CelhFVyt1yf631k5akzWUrIwxx0K5HdiwgInKWb3g0iHQklkI
	 YfvVtAfsARDzphzMFgvDOw+TaMZVrkQoSkrnQKa/6YSdJkHC8r39HUsapaMll2lUSi
	 5ndH7DQEigiyQ==
Date: Wed, 7 Feb 2024 10:40:51 -0800
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: move passthrough logging attribute to head
Message-ID: <ZcPOs5g6RPIA6gPq@kbusch-mbp>
References: <20240206175040.553999-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206175040.553999-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_104054_530520_09737C98 
X-CRM114-Status: UNSURE (   4.44  )
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

Applied to nvme-6.8.


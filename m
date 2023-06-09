Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DC1C7EE29
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WX6Q3krLeXnyU1ErGKnaGEj0J5rvRDqnfROl5WFYUIc=; b=LbZn+v2zkzXlCB4IbpsEAFYhka
	WDWaPmELtWqO5b/3jPWv/Kx8q2BBSGai8pLuXMexUIVj1ZSIdCPhoIaK2l9pj4QCgvEjj4zHLspPl
	sLPHkMBMY9J1q1kG99yO4y0cNH8HMO8FUHvJi9aZaLPeaJ8WD4IMnXuuJYgUsHd7nPuwqUgH1AW9L
	mqIsYoWs1fqWUpUAzA0VRF+DqyCSlodeU1uSbw+9Q7S60HUYGQO1aqVhgjt0yapKmMWegIaCP7p08
	v+I9v0W9E5cb+zDpFWUoNwKK30RUTf0BvNA5FIcMtu3m9ZvG5zLQerxTsFmRSIWlhUQLq0+brygHQ
	IM4EjaRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7eLx-00DVSD-0x;
	Fri, 09 Jun 2023 15:48:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7eLv-00DVRe-0x
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 15:48:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CFA9A6588C;
	Fri,  9 Jun 2023 15:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1C2C433EF;
	Fri,  9 Jun 2023 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686325718;
	bh=WX6Q3krLeXnyU1ErGKnaGEj0J5rvRDqnfROl5WFYUIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXToGuuBjfpmadxzXsA3qNSs9Uctw/JjB3k4BOeQ1ePcRbZDIZrMFXgjk0FLI5+6N
	 xLXzs+TlhVRxgpXkok6zOvszXWTi0iZ0XajKxqnuPlijuRWuziKlezMR4q+yRTdiMM
	 88F1Pd2w/QBnYigXElc7Kb66IzSEfjEuCdozLtmQJkGWqzI3dqU2+k/KBBUOjuNL1n
	 Lv5h0GyXn81iJlVnAcDq2ikylVnzy3lzrvCXOXZYhrZP+1696l/tXwV9hf0QA9QwWK
	 CwLAWydyCUDVB0CmGTq0PzfggYlK9h4uf+myx0dm9X+kd1JQLURB8QpTYOTl6FYYQQ
	 wehKAaEZ+oLbA==
Date: Fri, 9 Jun 2023 09:48:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 1/1] nvmet-fcloop: Do not wait on completion when
 unregister fails
Message-ID: <ZINJ03uCTFyRItpw@kbusch-mbp>
References: <20230606122411.7972-1-dwagner@suse.de>
 <20230606122411.7972-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606122411.7972-2-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_084839_379200_2913DE78 
X-CRM114-Status: UNSURE (   7.41  )
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

Thanks, applied for nvme-6.5.


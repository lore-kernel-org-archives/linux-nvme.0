Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F62CDB482
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8rl19Hsan9G+isYwbg0X7W+HtqVBvA1Jzhjz+f+AYJY=; b=q9RbAtoRYK5rPXQvDxpj0FK6kF
	lziDWgG7Uuj/UQrXN+8JOnC2mbH/SiMtMfgiI4YujUTqjqolmTMUOVcRvuWYGxsq0yyJBxU/mmLpA
	ZZqyiwdv2gv1T1mzGR2lUPfL3d9Lf7ex4bEB7fIzNSC9OsoKVE1UZ27C1iTnZLtUJx7xIn9JtQwdW
	W3ZNIAmjeJAjc6NfrTnHxQDVLtes/0E3LNDeV6P4qwtFGC8H5Nhcv/NPE5UcTNDe6D4eG2zxmiBbx
	VNYYkYSABVkokMhFUNoCiXZvjNCiC9SN6/xe16H9ahutGEJ1X3PvLY2SU+eNEgdQbLrBq1QPF+Xm9
	g1yhsotw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrJFw-003bJk-01;
	Fri, 13 Oct 2023 14:35:12 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrJFs-003bJE-2c
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 14:35:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 06BF5CE3145;
	Fri, 13 Oct 2023 14:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE177C433C7;
	Fri, 13 Oct 2023 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697207706;
	bh=8rl19Hsan9G+isYwbg0X7W+HtqVBvA1Jzhjz+f+AYJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwzObp2agvDq9aEPDOh/OmerHCiTy1GDASBiwVSEZMHoZtVatVMXiAIdWUwdZKCYq
	 RUOCHpD2TgjBTVDM63cfUXuScpeELskwU9gkx/KBmBJCEvvNAuW2yJ9/5VVLC9a3Fl
	 nA6NkghwkdcIXjBlXcaKtYIZhZtWMIUi5kASuqpuzBJY9FTD11ns3Hk7XjfkWgQJAz
	 q7eefMOskfmDERunZ1Dl3gL/EkVQLls3Odx374OvHhdETQQnGXnWIM7d3UWJhovBCs
	 tfcBbOy6Gw0lTjw/8SosxsFytNLWA/XUjGvqis0Sa2Ggd/leRprlpOg5mqALlINIdO
	 xmuQjBfvaYYCg==
Date: Fri, 13 Oct 2023 08:35:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: use 'spin_lock_bh' for state_lock()
Message-ID: <ZSlVmG3ju2xnZwt8@kbusch-mbp>
References: <20231012125954.58709-1-hare@suse.de>
 <ZSgMH3uNeccez5Gf@kbusch-mbp.dhcp.thefacebook.com>
 <787c2581-d9b0-404e-ac2d-764324af3fc9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787c2581-d9b0-404e-ac2d-764324af3fc9@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_073509_024789_81C9C068 
X-CRM114-Status: UNSURE (   5.28  )
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

Applied to nvme-6.7, thanks!


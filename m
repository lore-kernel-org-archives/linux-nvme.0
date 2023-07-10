Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422C8EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=xyqpyn6HYjRBOSrIXf6hQf0kyX
	ZKClD0+XsjfbXzvfTbKrRIHE8CvUw3B8akxsdCy9eo8OM1mTxmMEWDQ0MvavrSg0TbxAznVPAFwHf
	cJgPCGJNhC7EH+iOtilESL/EfWteYThM4eCu4bWO3cp3l+CVDBpb8z7BbA6kbnsdibNwFX8q32nA6
	2kADx49iQzgjzrwdOQAUOYGum1itzAWw8M2C8vteca4nq8ZaOkbMd/WaXN6LOdcZ9KK6nqYwjYkHh
	1UFEl98xb/iSnreAhxp5iTgAkQw7AlJRnUU9w9jR41gy4V9jBA40CnN5AKNLmCuX73ddotSHn8eGy
	PQKhIbUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qItVh-00CA18-2B;
	Mon, 10 Jul 2023 16:13:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qItVf-00CA0b-0S
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 16:13:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC8E61068;
	Mon, 10 Jul 2023 16:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568D0C433C7;
	Mon, 10 Jul 2023 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689005589;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psQtN0ZsYX9Aoq1lySdpf1XQ2OTwRtvlBJqJteyiL6aMyOxVkq58LxKmHgrjinDh0
	 97gtdYpnACHGnTaiFNPti8k/zV5gT/0L1W2TQK5uLCWNTNPaeV1jfEUCi0G7Y4nAUK
	 quneG7UERsLFK4TfZ+fRbfR/z1qYiWAY8r6nhBYQ+enZj3yA4BbDnOtkCbsIZ2/rjV
	 7TPZkk8Lj9LqF8DwFU6IcPZQY700E7lsXIDX/uYzEwxHN/Dh7wC8FM2M2P0dzk0PmH
	 CHmAdlqn0QvqlurLhtm+p7kQf3j5TYWo1q4K+Xc+Fk05fk3uY+aGNnzDotYiySq5RE
	 nGUlWZe6/J49Q==
Date: Mon, 10 Jul 2023 10:13:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ankit Kumar <ankit.kumar@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	gost.dev@samsung.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme:fix the NVME_ID_NS_NVM_STS_MASK definition
Message-ID: <ZKwuE5z0poI9IZ3U@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230623071848epcas5p10d8edb4c9c8673ba612f4b81119ed2fb@epcas5p1.samsung.com>
 <20230623123806.78451-1-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623123806.78451-1-ankit.kumar@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_091311_223869_0C6DF88D 
X-CRM114-Status: UNSURE (   8.10  )
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

Thanks, applied.


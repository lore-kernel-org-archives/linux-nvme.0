Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3952C001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=; b=FVfDsNBkYrByX9ZzlcjhWVcDw3
	GDBRAgWAeP848IKnVe13qsX661Pufda2RucS+Yg08Wae1gsrepd0vEZJppBhkqeevJpA+PjTd674f
	nr8yXSAaWYcDOcZBqIvOkcgN+6PBU+B9gTeGd3tnzS/U+PFlCK9zT6KSe8Qkquc0kM3Oia+UqIxRE
	i8kF0YWYYX7rjUH1XQjQSU0r7aKS1tVKKh4xtvedinFzV0S+29ZLAqZs5QTyeLSSPucxz+lpctcIe
	8ppPiEKOOr5tbwIbvdrddLeHlegQzG1LsN2LfTLSWv3Y8goXOMEJxw+K6R2903D4t30KDR+UDU6uW
	4vmeTPTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJy6C-003jNq-0Y;
	Thu, 13 Jul 2023 15:19:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJy69-003jMU-1u
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 15:19:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E266961087;
	Thu, 13 Jul 2023 15:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00204C433C8;
	Thu, 13 Jul 2023 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689261556;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHOFEY2mrsWwvkEAH36j7H99siqCFu89QsCEQoM9HOyJqirbbumaIJRjL8xEe2UX+
	 XFYA4u3KHa3GxcbfNTbDuPPRsYyFIq1hTko/TGFWD4FfuZLnv+70YOAiN/jsN2QCIO
	 vf7cBe94drWnS8f0h4fdtd2wdNekBYV0xBe2AlNtuPhOlc+0k2bClCC5q0jN4oDczq
	 oHJc4VpaW/QzSsyCKHk0jZCx7FXPtuHH2LY7yjJ4mCgNuGHGbwqGGPhWOxOvudV2jX
	 XrHr82K9gQ+9h7LizTfama4x+x0+UPRbong7U5RQNs2l/z+bwsBV5cnekSySMHG/S9
	 6HmAM61LVPjhA==
Date: Thu, 13 Jul 2023 09:19:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Guangwu Zhang <guazhang@redhat.com>
Subject: Re: [PATCH] nvme-pci: fix DMA direction of unmapping integrity data
Message-ID: <ZLAV8acB4fa1uqMw@kbusch-mbp.dhcp.thefacebook.com>
References: <20230713092620.2076742-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713092620.2076742-1-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_081917_669399_7A3FB4B7 
X-CRM114-Status: UNSURE (   7.17  )
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

Applied, thanks!


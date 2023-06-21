Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF26EB64D8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qwexmAUOaJQk1xMPFBixAAVJIA7OieXLmr3MjP5KX58=; b=zOTT8E3f+kK27FaU2XoKcD2fQ/
	iRyqNt/WG3SApNQJ19A/5mAn8LCVxp3bf9BnzxhI/XXUKp8cZrsCkyWZQJH6TE0Tyw9DZIhErmzp/
	vcvNvHiS50rBJxrgLlcxPTikQfUXWGBXWi/m1HBKaSJ/GnMZhGrN+RhfnZMs7dwsFa0OaiX30jbkU
	GQlqW+LBmMBlgLiObbphyfgKUgDla5jUpE5fo1w4rThv0fooQCUW+tGkz2T7PGI3Bdn3emOBKEU/m
	qXNFSb6MTogjC3gmuArVs4fsMmKAaID8w1n/KDbSQ5ArL9iyaq0W/5w8nXUJY+T8GDHCG3c6jxcef
	dkcdLEkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qC1Zq-00FDat-2t;
	Wed, 21 Jun 2023 17:25:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qC1Zo-00FDa9-0F
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 17:25:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9B4DF6162F;
	Wed, 21 Jun 2023 17:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E765C433C0;
	Wed, 21 Jun 2023 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687368303;
	bh=qwexmAUOaJQk1xMPFBixAAVJIA7OieXLmr3MjP5KX58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUEgtSKJKmuAWANAigfU1mSRB7nu2IOJkKdntxaObqwOMKqCVfE3bke8/VGGM6lsY
	 E+N/PvtPxYMozJ67TMm354pi/IBHw2DCQMpD9AN70iDZApcRoCu4nC+M6T8bK2mDYY
	 nIGqlK1CmwOAwiFJQMZgf7rAlZeoCZ1ke62Tv5bhLWlWb6QBaw2wMeH6P/3GGquwbx
	 g1WuQWLvr9nxvD9v50OAm1wBrLLg+i9p0vdOPBKrvYkq8DmaMfgvvOHYCuM9ZUbzLI
	 9UfJXqvieFRuvFKaX1VHvZIx/UBUQcpyTFVp6Gj6MHafuKVAKEKjdGddMMZ7ZCBIoV
	 BhS2npbNHXRpQ==
Date: Wed, 21 Jun 2023 11:25:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Message-ID: <ZJMybNvd/ENxSDBq@kbusch-mbp.dhcp.thefacebook.com>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
 <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
 <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
 <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
 <ZJHJlrfysHJUQvXC@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJHJlrfysHJUQvXC@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_102504_162674_1097E251 
X-CRM114-Status: UNSURE (   6.32  )
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

Queued up now for nvme-6.5.


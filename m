Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048CDC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OLCSibMyzPJyDMrC13IEe5TSwMOpnh1gXITCNgapoEU=; b=qxQ2cWRcbDcevGGFnMkpYQImWo
	1jzmRec1GXb6np0Yzq4WqO569WXPRaLVhrguECAf3UxCsDroRugzWOuXXDbIOi8LI913UV4tfH7OU
	ymFbCC1p1rM/N67keO2OWb/ikq1+5sBed43ywpy+wVasIwCl591H3WhFVbnPj1CJUlCDIg3WPfLtj
	4M3y7IlAppammHePSisGMp8UEW85I3L2zCwDHlermrVUFtHgJfvtllQl3N0Aef7lLZkMk4EhWuCT/
	92DUSQuSf/Fs1ATyMLgcDxn66FVZyKOaY2U+oFuN1ChkeoMtH6vQ6yYO5IP68RKxh7Q/0awVN1vbM
	PmxOnDyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBHjY-00DSxE-2k;
	Thu, 07 Dec 2023 17:00:20 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBHjW-00DSwp-2m
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 17:00:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C7F52CE229F;
	Thu,  7 Dec 2023 17:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5EDC433C7;
	Thu,  7 Dec 2023 17:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701968416;
	bh=OLCSibMyzPJyDMrC13IEe5TSwMOpnh1gXITCNgapoEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KUUoG6fG9mLK1UFSbZrdcTkR+0Wx+SUw8Q+NFi7WnYvDWNmVVFkoxsQhgiBtTADca
	 WXL9SpxVhqMQs6vGYgRK6kfC20KGyCWfTSEL3PyBNWQHdCJleLujmfVoeLAs2LG8T4
	 HI4P3k8BFjiwhYsrjRtieYSvGhLMhkp/oUGZlzHcU7fegu0QxSlfw9GLQ8pVPsfIRr
	 Lehjo9Wvmjfpk3uS9/b9lo7/RSbadoBZ7IPJ0Ktfw1RyQ9kMhiYrRydOTazW+ulXlA
	 iBfyn5syAEPhvMuZ7ngHhLs7wzVSg7uDEtKjVACZS7ypJ46ZO+QXFfxDEhCp7oj7L3
	 7gueV4J4yaE5A==
Date: Thu, 7 Dec 2023 10:00:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Message-ID: <ZXH6HOpgBoUlnxFu@kbusch-mbp>
References: <20230920085210.22573-1-wse@tuxedocomputers.com>
 <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
 <20231206092420.GA27348@lst.de>
 <c930e543-7dab-4559-95d2-270b8df38f3b@tuxedocomputers.com>
 <20231207152048.GA20561@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207152048.GA20561@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_090019_072132_22B1B5F9 
X-CRM114-Status: UNSURE (   6.18  )
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

Thanks, applied for nvme-6.7


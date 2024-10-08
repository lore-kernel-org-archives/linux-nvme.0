Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67098CF0423
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 21:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=; b=yo1y+JSpEdVdDsSiQGdlOGIJlC
	uwhyOJ5n6KnAU/83InM51yFnCNgoNNT5zHM4SF38oWEd/LBDdtTck9yb34VRbq16ZDIUigPG9qcr5
	XopaKBWJCcjm6Tl9SHbgc2f2jg08bscVklVlNZZyZMvAs+DzQqqL7RfBBOAzyfBK/pnHz87cpcPEC
	LNFa/I2Iw5O45CINwdAC0drezw+SDT3mUzZZnFCrmY/G9AdhYKJmx5S+N4Yi2ENPY8QwXGkdyYetO
	nB+phzaGLwt4OlrWZmeFtWZa4MmhCpgo3EILdNRejUGK2rP5ItSpV/NGfVKenTEq7Bv3hyaFWQrjA
	7/25z5Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syHZy-000000079X3-0Qlt;
	Tue, 08 Oct 2024 21:17:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syHYi-000000079QW-3Jtr
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 21:15:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EB4025C5757;
	Tue,  8 Oct 2024 21:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87D2C4CEC7;
	Tue,  8 Oct 2024 21:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728422155;
	bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0twxUdpWfgoJ7ROf7lPIKwQSrjtN03c0UA353tKW3Rcq7+dFl6qQnjySPoj5u1bq
	 xoJC5AhIhEfA9SESavB/Kp88QRCJjnf7q8r4H78sQriFSKvZxBGzTOjqzLB9R1uu6V
	 TbSQv22NxaiEs4c5voKeO7bEQWHF1r7f+8cGLrpobJzB9JOyjMhYdfI5FEuOo54S3/
	 FNRBjBrSF77dD8+iI31VBNhSeWETZ6J/BH7FPzUXIsn1PZOrfZ3cBxLhJSPh/CBR6A
	 rZEB3Lasp73J9Icb+JL3KE0QIjgmhV5m69lPCWye1O0bTiQhkdAVfSbYOwrZ86rgXz
	 97njaaf6St/1g==
Date: Tue, 8 Oct 2024 15:15:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: delete unnecessary fallthru comment
Message-ID: <ZwWhCSDHgsT8EaB9@kbusch-mbp>
References: <20241005113036.12181-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005113036.12181-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_141556_907436_992E4093 
X-CRM114-Status: UNSURE (   4.93  )
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

Applied, thanks.


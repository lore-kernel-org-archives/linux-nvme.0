Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3BDC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqsJBTu2ftsVjpVWeJEf1PZwP+2Qf2EssDTWmNxvgn8=; b=fGA9EYcstMYO/1hSHeEhyyT4ho
	B2uB3EPAqCv7WX3TECyvrfEgNFsCeom38n2WvDdIwBzCVl+f33zn967yauBPnlH1WOXmvhrHFIBqS
	eqcRg3r5LSM2PWo7wfyLsO6wb33ZCKxAfSeV8xk9D/WghnRXrFVfDTqevUfo1+j3QpT90xlJ5szEa
	cSgykc5PHVQGAPSW+aWkHGQ4VGvWRSRGHkusgCbJdPdDoDeG1lRWvwThqKY/MRmc3mIisBPYImsR6
	5eUNbxhBIvxySDN/8cF2r6/BjtRsBzJVizGrStpc4dlYZQGZCs/5mYwv5C/EZqXy2eTEqa2XTXbLk
	X7QgEBWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfAU-003whi-05;
	Wed, 24 Jan 2024 15:27:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfAQ-003wen-1h
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 15:27:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0FC3A60FDB;
	Wed, 24 Jan 2024 15:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400B0C433F1;
	Wed, 24 Jan 2024 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706110072;
	bh=fqsJBTu2ftsVjpVWeJEf1PZwP+2Qf2EssDTWmNxvgn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSVtLPD5znnSt4/l7UNT0EjehQRcvaJ7+yTs0y+VjxRXu4jy8+lO46MQmKSv8PlA7
	 RA2gchQCG4Q9/6irqZD+BynCde1kS2zVKz2PUBvV1R9Ktg6rjdPAJJw4rv0+mem/BO
	 LEpOp1xl9Y5vmOxWJWqCuY/Hsdr7HA1gwRKM3wwHc9dDx1y85Q6XgAXdn2pA4i+IVu
	 LC9lkF6+Ao+0V4X8WYs3cKBbkUsCjVB346FsCAoDTxEzO0rMIRN7GxMuT6sxiqiCqp
	 Bdt1m3Kr8CRUQ/P64AAcGd7WAEuNcLPGHEcdt8W/Frk963mpS6/FtBeFZkqRfSyvhg
	 8RIQ0gxD/47lg==
Date: Wed, 24 Jan 2024 08:27:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, james.smart@broadcom.com,
	sagi@grimberg.me
Subject: Re: [PATCH V2 1/2] nvme: add module description to stop warnings
Message-ID: <ZbEsduvSsfVQLiIX@kbusch-mbp.dhcp.thefacebook.com>
References: <20240123221341.7902-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123221341.7902-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_072754_625879_712AB366 
X-CRM114-Status: UNSURE (   5.31  )
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

Thanks, series applied to nvme-6.8.


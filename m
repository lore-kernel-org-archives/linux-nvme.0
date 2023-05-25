Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FC0C77B7E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WX6Q3krLeXnyU1ErGKnaGEj0J5rvRDqnfROl5WFYUIc=; b=GVNaA39cGFQ54Pg95v886JQg8x
	4TbGZdYkqIx1HkqLeiq7frBHtF1lxMSYREyx0n2dRfs3WhdWJds8syBi2ujVsSWRGFM7JcJwOm/K7
	VdvQEGmxi/8q2CNvm1FfTo0zNsMhzc3sbnqOqHoj7N647jAVFIJJDN2DUUQpWSdDPEilWUp69vgMD
	D1D3UGwSz8zLkZsQlZxnPeFmRiwpPPiabZE2wMY63EFuUvEpIIdvKODiL4zMaj8BGScNkkktlpxP3
	CV8iSBLE3OU+QpJ75gHmdRU6YMQTXY8WF677jCHKeQwqNWM2EZn4s/jbAshQAKxJjtwkIFBcG55oH
	aTI7lnSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FHf-00HJpR-0z;
	Thu, 25 May 2023 18:01:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FHc-00HJot-1G
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:01:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D9A1F6480B;
	Thu, 25 May 2023 18:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA35C433D2;
	Thu, 25 May 2023 18:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685037711;
	bh=WX6Q3krLeXnyU1ErGKnaGEj0J5rvRDqnfROl5WFYUIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfNb1D9ZNGgqc4/wa6K4Cy0ukOtZdjh2DHy/qoNPYYHHRRBEz3wa6O/n36lab6mrc
	 HHDGtRNESwJ4De2Cciy1IUNdbMaX+j12/MoE+TLn9s6YTcEnC7WZxnKn2Karja4/L4
	 9BHqbM1rP87GqjB/ckalnrRfYcR6a/OL6XL9WOWSDOxW2ujjvKhdHYrk89iNSeyIoD
	 XPtN26yNH+5QgpZPZjTW8nWU5eDeYZ4C9crdSzQ4ddlVhr7rosocdChMSgeBEivqSM
	 125X7Z1tXg5jqSXeVwXXJWkBPxXrzCKRiTLbxsAsQsMpS8oii8gwpHN3ByoXF++CiK
	 3ezx1k+jCzxDQ==
Date: Thu, 25 May 2023 12:01:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: irvin cote <irvincoteg@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci : redundancies in nvme_alloc_queue and
 nvme_init_queue
Message-ID: <ZG+ijL9OwY2ahkuR@kbusch-mbp.dhcp.thefacebook.com>
References: <20230521024618.103138-1-irvincoteg@gmail.com>
 <CALL+9ehvM3GxGS9Y-KVyyK+HyO14yRmGZFEPjD6pmEUMX3VNzw@mail.gmail.com>
 <ZG+AY7/lheC7Hsbn@kbusch-mbp.dhcp.thefacebook.com>
 <CALL+9ehUZx8ae0ZD2EUZNB8ru-XHU1Lkb_miKO+_0j4HvDUFsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALL+9ehUZx8ae0ZD2EUZNB8ru-XHU1Lkb_miKO+_0j4HvDUFsQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_110152_490069_A118A7E4 
X-CRM114-Status: UNSURE (   7.09  )
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


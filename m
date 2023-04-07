Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A019C76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 07:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aB9dHGAe7xjaLxfUGgvmBR/y+2VgPKJ5Rj/78Yp3I5A=; b=ckTuAhDL+uYR01fR/XwidCawfR
	bFQjuQaICXN8t9fTGr1xFay7JwAg/ZEA4KtJIPlI9bV8ccTclaFMsILadrfceXuBNeyMHfEok6F1T
	ChiZbMTfE7yGyR/lyZ9HV/aissDmRpJ+y8T6CtJ75EDJoL15++pe64cLoOp75PcpT8RC5gMsm7wn1
	zI9b+bcc1mSO4ToSkswwNwkDU97Q+yky4GJ0UKs7IPsG3kXGpKA786wGPpir+OtRpPgRqOqvFbMBn
	0SApf2sVj4sva6bv8BHw9KypU5hoTImA4RdEJE9m2jbZfU1xD3JNUCAAQw262Yxav7Quq2PRzGapR
	QMaiDcpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkgpf-009PZY-0L;
	Fri, 07 Apr 2023 07:48:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkgpb-009PZA-2u
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 07:48:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC62D68BFE; Fri,  7 Apr 2023 09:48:18 +0200 (CEST)
Date: Fri, 7 Apr 2023 09:48:18 +0200
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [RFC v4 1/1] nvme: add passthrough admin error logging opt-in
Message-ID: <20230407074818.GA9335@lst.de>
References: <20230406215544.113127-1-alan.adamson@oracle.com> <20230406215544.113127-2-alan.adamson@oracle.com> <4ad89897-f4a7-59a4-e7d0-e0f79f4cb1f6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ad89897-f4a7-59a4-e7d0-e0f79f4cb1f6@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_004824_087193_CB6F548B 
X-CRM114-Status: UNSURE (   9.64  )
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

On Fri, Apr 07, 2023 at 04:45:59AM +0000, Chaitanya Kulkarni wrote:
> +       const char *device_name = dev_name(nr->ctrl->device);
> 
> +       if (ns)
> +               device_name = ns->disk ? ns->disk->disk_name : "?";

I don't see how ns->disk could ever be NULL here.  So this could
be a simple

	ns ? ns->disk->disk->name : dev_name(nr->ctrl->device)

in the parameter list.  We'd still need to also call
nvme_get_admin_opcode_str to get the actual command name as well.



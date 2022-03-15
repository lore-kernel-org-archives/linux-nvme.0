Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882C2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 06:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hO+hlGjWjKPIqTZFJ8hwHcVMpU0F4PbtlZrwMRCVNDU=; b=S0wAQivaKgES2HEPbbVL3ZmFGN
	inCov/xSDEhcC3NIBp6DTHNd1OIEk7Xy5vMckP83QOFDH6Oc+8T3MAX9Pfr22ZgcN+HCXpFc8qYMz
	QlBLerUjChoq/4siqkhGy1PGvo8BvvkIQZGvnAXTtCaGS+TroHjVC8RBLLpYc9ayt2UselGJ66BI8
	D970AxH1/HRFbF25w2Y1IaQqRljmmSMqDScq/pJmrQkFxJCD5TT/YQltHTWM0O+k7ucH4BhGaiuxR
	uFz6Kx3JcFWskizm5jA2+VRfNb7dCSu23+LZjiWcfDSSGYEeqDeh27w43UptpRNUQT49E1WFt570v
	b6toN3Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU0i4-007zIn-TC; Tue, 15 Mar 2022 06:31:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU0hy-007zIO-UG
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 06:31:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B057268AFE; Tue, 15 Mar 2022 07:30:55 +0100 (CET)
Date: Tue, 15 Mar 2022 07:30:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvmet: nvme_excute_get_feat() cleanup
Message-ID: <20220315063055.GA1166@lst.de>
References: <20220309174308.41832-1-kch@nvidia.com>
 <20220314074249.GB4570@lst.de>
 <cc10b52a-00fe-43ff-07cb-fa9cd3a4bbf9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc10b52a-00fe-43ff-07cb-fa9cd3a4bbf9@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_233103_166797_1D19B7FE 
X-CRM114-Status: UNSURE (   8.66  )
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

I had to drop it again as it caused compile failures.  These helpers
are also used in discovery.c.


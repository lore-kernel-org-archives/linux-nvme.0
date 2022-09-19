Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1F4ECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=oZLU39ei5S1tUwkkAP4eaCXTEi
	vZwuKjESYETOB24q6Rl6N9VjbOqo1wd9+CqD36Ly4oqAi4NIeSLqqY67YlA7r1asmJc8xFyzGVpC/
	1TIfoJaeLfZ2IDAHamoSw8uLhLTEW3kzRJ3C9ExyUlCOeleAR3YCyh/+OaL8RyK0gUnF90etdR/hy
	3gpUVmzbUDrxg5qFi2J/xQYJJAyHMdv9AxnKIv0kz+Bn8mIZLzL41NfYKeXyPWiuTuotsxsm9lwmQ
	G+Qqt28m0v5inr3LeyZndJvytnND/cy0ANDJDqja2r1Kuzq0IXY+5hsOKymYeKbZNRxIvPV8BuwUI
	HAl5gzSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaIzH-00Cd27-4b; Mon, 19 Sep 2022 15:47:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaItB-00CZik-Tk
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 15:40:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3A6768BEB; Mon, 19 Sep 2022 17:40:48 +0200 (CEST)
Date: Mon, 19 Sep 2022 17:40:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	James Smart <james.smart@broadcom.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Venkataramanan Anirudh <anirudh.venkataramanan@intel.com>,
	linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] nvmet-tcp: Don't map pages which can't come from
 HIGHMEM
Message-ID: <20220919154048.GA477@lst.de>
References: <20220830220533.17777-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830220533.17777-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_084054_141194_E693985A 
X-CRM114-Status: UNSURE (   9.38  )
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

Thanks,

applied to nvme-6.1.


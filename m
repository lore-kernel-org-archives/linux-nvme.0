Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED794C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 22:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sSn83pUnq1YJuMLuMSdWcUwGAtFEN/wEsHxd2GhCeFg=; b=joirF9is21udoyDDzEJ9NkNxCf
	SdGPimhR5NvVbmj4a8ZcXojtp0yGdCzyQNRowc4x54/jIcJKTmSHAb3bWc3HaGrpKbmkkKxdn6T9+
	4kIRlnEEi5tdAmmv0eB6+Acd3YaL69/gvER6L+L9+Kh5iXdctuVDpQsCq+KdJGJt91IfNV83HTyId
	RifLi9cOOgTQb0k7gaIF5oiidQ2PlFO/ta26Ohi33OFMzwg36BLu1RvVT4WCCzpVblyJXgW/rZjV7
	axPZSihCvmumcNy3Lo9CS9ZqOknDAJXm5CDQ+qsSZcbvm4ZUY/NFlr7TcJJ5RmnkqlIAwV1gxT82E
	nW/a4stw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr697-00GAs5-Bq; Tue, 17 May 2022 22:58:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr694-00GAqs-Ru
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 22:58:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 58C8B61423;
 Tue, 17 May 2022 22:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952DCC34113;
 Tue, 17 May 2022 22:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652828306;
 bh=VrRBXCnhnnbjCE1ETEb03pWsATv0ZlxNSYdsxG00E2A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o1FUCTuM0roOGkSByneBLvxgdB5zacAKA1eLrOzkkgANg13YdfGNW9j2Y1zo7mbkR
 DAn26wPdOOUehj9Z0fqYzoW2LjMSprQ4+RVcV5ZQCj5VX+RvU6xt9bAqNhV4H6zJTR
 vCR4XMbX7bTZG7dYJuY3HCCb01lscDiZG1wfxXzyoH85+B9qHMmZqj++E54VHyaAMy
 MinogFJUvCYxzxXV5oR7Cjv7PqHCr4iKc+yv7B2HsI4Bi363vN5D6Nr/ShOOqrUA88
 l4LveBs/yRDstKKBfUF1rN8yrxd++jXIz1XvjFFxRFUp/XncRIB366qe76BNfoGmvT
 +PHwtAxn3+vHg==
Date: Tue, 17 May 2022 16:58:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme: set non-mdts limits at I/O queue creation
Message-ID: <YoQojhSp3AuKCQW9@kbusch-mbp.dhcp.thefacebook.com>
References: <20220517055312.50331-1-kch@nvidia.com>
 <dd46fded-d213-6956-8f0a-69a70e0107d5@grimberg.me>
 <955bc8aa-dc88-68a9-c656-51e52fe589f6@nvidia.com>
 <YoQlXXvNCQIRT3yc@kbusch-mbp.dhcp.thefacebook.com>
 <04b837d9-fbd1-ed80-9225-e452a95a1594@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b837d9-fbd1-ed80-9225-e452a95a1594@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_155826_975029_32038A3C 
X-CRM114-Status: GOOD (  14.10  )
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

On Tue, May 17, 2022 at 10:49:21PM +0000, Chaitanya Kulkarni wrote:
> On 5/17/22 15:44, Keith Busch wrote:
> > On Tue, May 17, 2022 at 10:41:54PM +0000, Chaitanya Kulkarni wrote:
> >> Also, this patch groups reading ctrl non-mdts limits right before I/O
> >> queue allocation for each transport, since these limits are only
> >> used for I/O queue allocation.
> > 
> > Maybe just check that 'ctrl->cntrltype == NVME_CTRL_IO' instead?
> 
> I did that initially, but if I remember correctly versions prior to
> 1.4 don't necessarily report a valid ctrl type.

I guess we could assume IO controller if < 1.4 since those are the only type
that could have existed.

Otherwise, I really don't like having this all be transport specific. It sounds
like updating the non_mdts limits could safely be done in scan_work since it
requires an IO tagset.


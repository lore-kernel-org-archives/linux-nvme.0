Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0866AC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Mar 2023 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dgaZo/jfVNTHZDWiTQNmrCHfa/svIWlXlpmi9jC7y2Q=; b=E10HP58IzXu4J/eOWDQBOUboRl
	x2WijHdLLu++hEyAxDJnqHjb9L/x08OpiJDrph2MUP9oXDBRcYiGg/RSnkZzdXX1Rri0yixX1imNl
	CtduV0kls0ODhTzY4gedf129PqZ/T3A8sDNS6oPiOYLi6+SXp0DbokjIbjT73Seppav/bGoxgwvoG
	OYOX3wB/jYEOvhZk8E6gQ0+q8Xx3+v04mLZH5GnF5nAZMSD8CkRJTugsro7sUfxJlAUaSrmGl7SIi
	t9Xbh8YhXX0nJ8i7b6YViU9hvNB0iOGjwJmAVcgwhgNsD8p7b9iMEkSmmAsdEuADTZ5i/KM5QYwe7
	Bvdq1BvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8DH-00AxqE-2K;
	Tue, 14 Mar 2023 17:13:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8DF-00AxpE-0J
	for linux-nvme@lists.infradead.org;
	Tue, 14 Mar 2023 17:13:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5220A68B05; Tue, 14 Mar 2023 18:13:22 +0100 (CET)
Date: Tue, 14 Mar 2023 18:13:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v4 09/18] nvme: Move pr code to it's own file
Message-ID: <20230314171322.GE6780@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-10-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224174502.321490-10-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_101325_277585_BA3B9F73 
X-CRM114-Status: GOOD (  10.38  )
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

> +++ b/drivers/nvme/host/pr.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0

I'd feel much more comfortable if we had a copyright notice code
here.  This code was written by Keith, maybe he can help to fill
in what the proper notice should be?

Otherwise this looks good to me.


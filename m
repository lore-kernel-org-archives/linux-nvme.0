Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FF5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AwyGTtApC2vV68cXzHx++I+d4YbLzt8PA5j/J/qrnok=; b=KEqSdYlXRmcf3ODIFcxaPSwKOl
	QZ5+auBO0Ood2Vlpksk63j/GagHjlUuznTXp0r2HqybD/uphnVwKab0IUqtYGQCQIZZUyZ6Bk8PfD
	pUdhwXfvr5s5QyJh2xSQ9E12zE3U2OAxv2bC3Mw+aM389pZrJzCw8jGl2zh6nLRkabLQkhFfD97bV
	1jdm+NzbNhvnv7I49l3zInktylUmIz4+t+rFT02Pm7prRNwpfdCnenUzMC/+xYxzjukGfctrGQCVU
	eHX03L5dNbTh/xHFZqEctAk/Yr6mMWfcIuxIfn7R74WEcNWbPlMP+ME0v82Nx4PYf/IcESoRWyH8Q
	1vSKv7PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHhlj-00GXFf-Ja; Wed, 09 Feb 2022 07:52:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHhlh-00GXET-6r
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 07:52:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 82ED168AFE; Wed,  9 Feb 2022 08:51:58 +0100 (CET)
Date: Wed, 9 Feb 2022 08:51:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Alan Adamson <alan.adamson@oracle.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH V7 1/1] nvme-core: Add verbose error logging
Message-ID: <20220209075158.GA9647@lst.de>
References: <20220203081153.162956-1-chaitanyak@nvidia.com>
 <20220203081153.162956-2-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203081153.162956-2-chaitanyak@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_235201_416984_42FA5D35 
X-CRM114-Status: UNSURE (   7.86  )
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

Alan, does this good for your with the author line fixed up?


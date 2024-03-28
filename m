Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3D9C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79A4vPC7IKhMuCXB9c32n2behpL+E5/jbfaPmIyR7Vc=; b=0Z2D7kJU1e7DY8XLqlzT8K92/+
	E5IhEPheBNmhQru3XBnNdmHio1yD7DXccRwf05DcQbfC/CzkBLQHSfNbfaGaM/vT03DdYe9Iwome6
	Nx+HxzKSHJJFRUNq1YjeEnglVkGrrOTPj2fsf72jt+cEKdYzv/NYrQAZ0Y1Uy9eKMsVx8HOEI9dky
	seJubMA53DPWgdKEUxoKrSzsvR02WnhfnwDyT621IEhXtPzLtZsoy8eNR4m7QEGjI+j1/bUnGcIeI
	CbaHThyLKq414beLtTJECPAMvNfbdyltT+wgYeevHq+dh5zk30W8LQwpVhWpY9++nvm9Vi552fxs2
	TActMQkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpj9y-0000000Chd1-2lDl;
	Thu, 28 Mar 2024 06:22:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpj9v-0000000ChcJ-2Fvt
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:22:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 120BF68B05; Thu, 28 Mar 2024 07:22:38 +0100 (CET)
Date: Thu, 28 Mar 2024 07:22:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
Message-ID: <20240328062237.GA17225@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-10-dlemoal@kernel.org> <20240328043016.GA13701@lst.de> <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org> <20240328054652.GA16237@lst.de> <7d8f3ec4-c416-445f-92db-7d2b60726821@kernel.org> <20240328060357.GA16819@lst.de> <ca3fe7b0-7e27-4ac9-b669-5263c3cec550@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca3fe7b0-7e27-4ac9-b669-5263c3cec550@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_232243_748443_C8103BB9 
X-CRM114-Status: GOOD (  14.20  )
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

On Thu, Mar 28, 2024 at 03:18:46PM +0900, Damien Le Moal wrote:
> > Yes, bt it can use kfree_rcu which doesn't need the rcu_head in the
> > zwplug.
> 
> Unfortunately, it does. kfree_rcu() is a 2 argument macro: address and rcu head
> to use... The only thing we could drop from the plug struct is the gendisk pointer.

It used to have a one argument version.  Oh, that recently got renamed
to kfree_rcu_mightsleep.  Which seems like a somewhat odd name, but
it's still there and what i meant.



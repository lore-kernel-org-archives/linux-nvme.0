Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5975AC2D0CE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 06:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1EGjSaAkB1YQJOO1prnZTUFPyCHdfm5b919dIp24FJE=; b=xvLRYDsaana7ME4gTiv0mSnKxe
	kGmv3ITLZXE2Aa3F8weOVoDwRAdUz/AbRHrWeuJZ/HRNdHDjQjh7Q6VV0REwpNXw/0ATD8BdVhoDv
	lbU0at6sVbp/yWgGjchnOxqhalO6xMEcVdBuV3rd73y6tEiL0czoy3GYF6xPV2ROKWh8xyGS/TWv9
	f4pKQcTXy9xinM+se0muCq2vxW6u+6kRGYY3Xes2AvitZ7AHF8rtHeDqX0kaou/Qlpl/vd4r365nX
	3m1zZucud1XKq+3Cjv8pHoj3RL0q30YVaClBlo/iM75hnFt58HCHLl+b4Ki65PUcH5qCWAuPOWlE3
	nluvhOhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKXrh-00000007zAT-0377;
	Fri, 21 Jun 2024 06:35:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKNYX-00000006TXh-3295
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 19:34:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EA5F362265;
	Thu, 20 Jun 2024 19:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A067CC2BD10;
	Thu, 20 Jun 2024 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718912088;
	bh=1EGjSaAkB1YQJOO1prnZTUFPyCHdfm5b919dIp24FJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRKfXkgc9QX7uPw61LGjpNWTKFSnEvisLeeJ/jTuz3AlgVK5rZj+f416vTlxlfL4R
	 8ZSA11NPqYTmf9X3HqhH6dY0k0UxNjhydixn/yvQwm4+aMmjIjJQ4KXiSe/4HY9irT
	 b1ZiQexo81F8+3U2t+EFK3YFI0lIJkCeLxowhtsozJTc04q7pOeft0I4MtfmZb6uWF
	 B2iv5exJ7Su7K4Q4Irly6yi7k8d8oap8EScPr7QKh59iZnxxgG+sFjpgmidsuvxvhn
	 94jqdu7GWPELvtUwzkEr1NeeES/MNOCbtLW5CX1dNx0PtrRd9ea7rmP8n/MqZaPGYM
	 iK0FJ/Nhozd4g==
Date: Thu, 20 Jun 2024 13:34:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	djwong@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [Patch v9 05/10] block: Add core atomic write support
Message-ID: <ZnSEVDIvcf-T-VhF@kbusch-mbp.dhcp.thefacebook.com>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
 <20240620125359.2684798-6-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620125359.2684798-6-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_123449_821955_1B5E1580 
X-CRM114-Status: UNSURE (   6.70  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 20 Jun 2024 23:35:15 -0700
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

On Thu, Jun 20, 2024 at 12:53:54PM +0000, John Garry wrote:
> Add atomic write support, as follows:
> - add helper functions to get request_queue atomic write limits
> - report request_queue atomic write support limits to sysfs and update Doc
> - support to safely merge atomic writes
> - deal with splitting atomic writes
> - misc helper functions
> - add a per-request atomic write flag

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9545FCF34A9
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=13t2FQP0Ub/NYL4Y5bKZ5M3VdtKW/+EstcVT9OLQCMc=; b=VsYtF15pVzcBH1GY8jzppyyx+L
	5q6KaIoD9FdiOLINoRQR1UD6bCCIyvICcD4OmkkBdOmOicYXqXIE3YfyLLGsWy/8+wrnlQ0voEmAr
	fWCvkwjJYiC/OTXGb6z4G8sOupMu8RHVNqT2SqiFytHLYx5SQFY7CCIzyUkh0mX6minMlxCRPvkUq
	cvAQhHV9WcFUOKO321YAlSyEzeA0gXLf/Zqc+HZXYXrP2i0AYODnS6Wy1VtrGnMAp/KXfunM94XYz
	7YIFek74Bt7f+qpdW1N+QJB5bMmO1T+W6RAdVx2qt1E4AvU7q1+ZvQhk+Ne5VU01IWoxTZKkU9LYC
	tu0yk94g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swLOG-000000095LW-1U6I;
	Thu, 03 Oct 2024 12:57:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swLMx-0000000954R-3Twp
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 12:55:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42C94227A88; Thu,  3 Oct 2024 14:55:45 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:55:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v7 1/3] nvme: enable FDP support
Message-ID: <20241003125544.GD17031@lst.de>
References: <20240930181305.17286-1-joshi.k@samsung.com> <CGME20240930182056epcas5p33f823c00caadf9388b509bafcad86f3d@epcas5p3.samsung.com> <20240930181305.17286-2-joshi.k@samsung.com> <38daf18f-7637-4c27-9a43-67ad39dc15c0@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38daf18f-7637-4c27-9a43-67ad39dc15c0@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_055548_091744_2E8C2746 
X-CRM114-Status: GOOD (  10.92  )
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

On Wed, Oct 02, 2024 at 11:37:11AM -0700, Bart Van Assche wrote:
> Is the description of this patch correct? The above description suggests
> that FDP information is similar in nature to SCSI data lifetime
> information. I don't think that's correct.

As you correctly point out, it is entirely incorrect.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7611EB64DA
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jul 2023 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=teYxkEgmJw65LaP0VLqbYjRdgqHGntA5XFxi/KG4CoY=; b=qovhWonffc+ezcHlE3uptS9Rb+
	sf4Z+O8E0h9A4AiRZiWqmsz3/SH0+qBqrPMGNKvP/U9mg8vxfVbdkUjNjWE4g0whvJ6AB4Li1TBYd
	5pZvfQVU+PFRgwt70djVte49Kn0SB+OuA6NQ0vL5KYGZWSyrkI3xXOYd6jU7VLEVwqoUzwn1WjK3N
	TV41ZfdKDiDbulXA6Jplzu1rPoYn0sBBCM3EmMiz1y+b9ubPlxl+m8UgYCVrNIgjoBpWcQYBSkejY
	BeJngiBl5ZyunZEU0UKdsYZPpkwSoUNDHW9/v+fDZ2JzJj948DFVfCnrvX2QQ5Dy7fhF6DkGbIoud
	jML/bDIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMOYq-00ADBx-0g;
	Thu, 20 Jul 2023 07:58:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMOYn-00ADAs-1d
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jul 2023 07:58:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E80268B05; Thu, 20 Jul 2023 09:58:50 +0200 (CEST)
Date: Thu, 20 Jul 2023 09:58:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, willy@infradead.org, hare@suse.de,
	djwong@kernel.org, bvanassche@acm.org, ming.lei@redhat.com,
	dlemoal@kernel.org, nitheshshetty@gmail.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 1/9] block: Introduce queue limits for copy-offload
 support
Message-ID: <20230720075849.GA6246@lst.de>
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184000epcas5p1c7cb01eb1c70bc5a19f76ce21f2ec3f8@epcas5p1.samsung.com> <20230627183629.26571-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-2-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_005853_686461_F7EBEA62 
X-CRM114-Status: GOOD (  14.22  )
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

> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..dff56813f95a 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,9 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/* maximum copy offload length, this is set to 128MB based on current testing */
> +#define COPY_MAX_BYTES	(1 << 27)

This should not be in the UAPI.  It is a totally arbitrary internal
limit.



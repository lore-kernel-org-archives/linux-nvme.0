Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E7FC05027
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Mar 2023 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yUaWz7AZPwjvyQSpvDoK2VmDV1nM46VtaCpE4djp3js=; b=reqD82M0YV2jzuRz/qLesHoyAI
	KQWCNlGzQJSdbZtV87/NPQfbsgmJ5BKo/jT1eKHB1TViEWqu55Ha8S49QIzKAVPNg5jhOdUR96Rew
	TmQcDTdyRBEYxVGP3valI2kX+DM9AEN+Vo1TSM2LErJWMYOCO2Aik6Runije6nWtOkJ/y4EyVNpH2
	54zvhIGFr3LcK2C5raDGQNsYtcsJjN1I/21Ua7dZjg8zN/uep/EE9V8awrHR7JNCrVEVFVCAUqf/M
	tvikigX2LcoJe8SMqMDEWF4YUv6Dj+ULyNwEYSgFFJKHtrsOVZG7KUU4CvIUazcXczrbi89feH0Gm
	3MlkjlfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8Gj-00Ayoc-2W;
	Tue, 14 Mar 2023 17:17:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8Gh-00AynP-0w
	for linux-nvme@lists.infradead.org;
	Tue, 14 Mar 2023 17:17:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 60CDA68BFE; Tue, 14 Mar 2023 18:16:56 +0100 (CET)
Date: Tue, 14 Mar 2023 18:16:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH v4 11/18] nvme: Add pr_ops read_keys support
Message-ID: <20230314171656.GH6780@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-12-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224174502.321490-12-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_101659_473921_26A2F705 
X-CRM114-Status: GOOD (  13.07  )
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

On Fri, Feb 24, 2023 at 11:44:55AM -0600, Mike Christie wrote:
> +	/*
> +	 * Assume we are using 128-bit host IDs and allocate a buffer large
> +	 * enough to get enough keys to fill the return keys buffer.
> +	 */
> +	rs_len = sizeof(*rs) +
> +			num_keys * sizeof(struct nvme_registered_ctrl_ext);

Any reason not to use struct_size() here?  Or does the union prevent
us from doing so?

Otherwise this looks good to me.


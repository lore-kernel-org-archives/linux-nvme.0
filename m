Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDFDC19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=paOB0ZLXATVLHDqN/F2jJYbvk+XatpmLuDIQrT0jQsI=; b=0Seen34fm8oA6HY3+R6Y3o+1UG
	9u/Cm4x2YmFjr+JALTy5xFbAJTQgfZP0HI3OTF1PAJ6Omw+eazm5+s7pkjSTdBfewQl4OrbJWPtk4
	gIGU/kKvWO20l08OuoRB0n7iMAiumbAmBn+Ad4C3jaTHE8nRzQSHJbz8gG7GmLrkdR1ryC/9jlth3
	KJXdWoKsFCInGb2xvnS1eda/p4dR1Y3lwQYOQ5qaUjD2Ev/6MWisvhwlp5k2Dn98hSBUi8hfGjI63
	tdJv9mHlYN3xv/qvb1DcqdvCzpv9BIF3hAm1sIyDeGxS3QODe/LGegNSAyDGaAg0BahekHvJZdFvP
	SCySPFMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJYx-002Ktr-6k; Tue, 09 Aug 2022 07:22:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJYs-002Kqg-3p
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 07:22:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 330FA68C7B; Tue,  9 Aug 2022 09:21:55 +0200 (CEST)
Date: Tue, 9 Aug 2022 09:21:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 12/20] block,nvme,scsi,dm: Add blk_status to pr_ops
 callouts.
Message-ID: <20220809072155.GF11161@lst.de>
References: <20220809000419.10674-1-michael.christie@oracle.com> <20220809000419.10674-13-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809000419.10674-13-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_002158_373046_3CB554F5 
X-CRM114-Status: GOOD (  15.44  )
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

On Mon, Aug 08, 2022 at 07:04:11PM -0500, Mike Christie wrote:
> To handle both cases, this patch adds a blk_status_t arg to the pr_ops
> callouts. The lower levels will convert their device specific error to
> the blk_status_t then the upper levels can easily check that code
> without knowing the device type. It also allows us to keep userspace
> compat where it expects a negative -Exyz error code if the command fails
> before it's sent to the device or a device/tranport specific value if the
> error is > 0.

Why do we need two return values here?


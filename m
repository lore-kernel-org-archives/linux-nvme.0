Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D9DECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WIsf64wg6EWrLhNbLmgfJrZKOnXM55UH5dnvPZ66hyo=; b=dkHG8PjAqp+G2diThw9yllIT6a
	c0zmrJ+zlJRKZjnbbD4b4ongEzFLOfiZ3oP6wmuLEe9ceZntdeC8T5VNSJnFkBbU6ka1e1wZ226o2
	HcKOHiqw8eD7rVqKCdKqpUUbpOs/P8rOHpVR99ebvVyQMqC96/09ETDbRrnx4KsI7LLoCe3HzLMOz
	eoa2VWPI9jQF31tBj/6G2Q6xX/2vF9yuPkKDQp4DMVMejDy/SikGAm2Ljb4ymJ6JNAq3GVCrE93g3
	BcHHD9RkJvgoGlijgX8wjVMmaaijGxQv1PcqhveffLzvC49cG6bkqVXTof1AtnW8iI6cTFDGMRQIk
	3VGzWsXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6LU-00EIUK-JE; Thu, 27 Oct 2022 17:07:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6LR-00EISz-Tw
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 17:07:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6F514B82714;
	Thu, 27 Oct 2022 17:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200B8C433B5;
	Thu, 27 Oct 2022 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666890422;
	bh=PS6+Xi/4jP1uyGFN6iRSyMDmBVsZ3ROt6Z9c9whqU28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7HPxRtgyv56qGLw+D7Urga1D00PFks4xYl9Ly59kDGb3L5exeEIIvSbtbR3zspkZ
	 rpwST8eS9vg9UyApO4onunkcq9RuLXGXWbqWdBWdNj7Sw5u/nz6HM+P2gn1L7IdWuz
	 FXg2Uu+R1MZbCgLeg1lz3MQ/3IVgG09W7chzjSyT/s+QqngkXPyysYQN9LJMyleQIV
	 iZtRM/OOB33xrNsqr/ifqUh7zp1n8FRlXl5nOS1aCf6F0yy8/3Y7Sl6RSAdoyztBDV
	 1TWUlzMdcnGjgW2z8R43OYSarj8GxS7S0W7n4pqSzf8I1FieDPaGrkj1yx6ck0XiPw
	 M2wBGSTzfmTRg==
Date: Thu, 27 Oct 2022 11:06:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 08/19] nvme: Move pr code to it's own file
Message-ID: <Y1q6so/3Hx9GZmTz@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-9-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026231945.6609-9-michael.christie@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_100706_125323_A5D7BF95 
X-CRM114-Status: GOOD (  10.55  )
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

On Wed, Oct 26, 2022 at 06:19:34PM -0500, Mike Christie wrote:
> This patch moves the pr code to it's own file because I'm going to be
> adding more functions and core.c is getting bigger.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Good idea. The nvme core file is getting a bit too big and too diverse
in its responsibilities.

Reviewed-by: Keith Busch <kbusch@kernel.org>


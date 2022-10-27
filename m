Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68F1FA3744
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1eqkURSiUHK8kTMGZoBEFCBA0LyMLk80TFqde8K/qNw=; b=X+jgzuVRP0W0D660AbuTjqLafX
	p2J7mwfOZnfFmX8UEHhPEzxm0BpXYpMyDCpNbAg6VE6WWvf16gjxG91xzKsj+0AiMABcNQTRpnxhO
	+G0QSt1tiv/sr3WlRWE1TCdZ7IvcqKeZ50wsTlS1DLuCPgrT2inigEPRoSL+fTeL2mgITkwwSS0/j
	YqnT7znzyZ8GCnZMM1IwOgMcj8mVirYEhsR5sYibWa2sBpqPgY5lEQfJHSfLEhrwTCtoLINZNwwKo
	cu68jSGa4REk5fPWjZB9Y2DgZYSpmiGsXgpKU3GaKPMk0CQZFksNt765+pKADXp3HnATy53TuBjCN
	CbNoxnoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6JN-00EIAE-RL; Thu, 27 Oct 2022 17:04:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6JL-00EI9e-7k
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 17:04:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 69C6A623F7;
	Thu, 27 Oct 2022 17:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC5C433C1;
	Thu, 27 Oct 2022 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666890294;
	bh=A8LdF2tGHUEAm/4didZpC5DSvR31YfIaG7z1pihdEXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6USWytVrptYSj/qv2yDplVsny321+kt4+q8m8QOvwNs1xF+Wor2WcndO3fwlPHUq
	 Eh/y5VtMvWfmkWcAkCIxT3bvkt5IhrbjFr9TGSYhmdZ8nApZOydHWQyDKkwZIOUL8/
	 /CsAf/+icHjY64MWBmXjAS0f27yd/1MReBJkO9bbEZ4EHTVhmJAPxgaSI8sL69K+4G
	 iA8fCeliHU/BIDzAYEiAWsXQUZA/VwZHA6mQ78Z7dJhmt1PO27TSqmVgQxZka9Sdg0
	 JD9iyy6k2x5lpA5qSs0e0O5Vaoc2L0KVu05+wmAyqI8J4PSeHUMkd4NgcBSeeFJnfz
	 UFDq2FuNJzU3A==
Date: Thu, 27 Oct 2022 11:04:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 06/19] nvme: Fix reservation status related structs
Message-ID: <Y1q6Mh2yx/F9/3+Q@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-7-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026231945.6609-7-michael.christie@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_100455_332013_567F1617 
X-CRM114-Status: GOOD (  12.00  )
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

On Wed, Oct 26, 2022 at 06:19:32PM -0500, Mike Christie wrote:
> This fixes the following issues with the reservation status structs:
> 
> 1. resv10 is bytes 23:10 so it should be 14 bytes.
> 2. regctl_ds only supports 64 bit host IDs.
> 
> These are not currently used, but will be in this patchset which adds
> support for the reservation report command.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>


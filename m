Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB123C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Mar 2023 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=phNjaUBIzJJvvVlKvNBu57ElsITzi2SKYrpCrcDntdQ=; b=UK50PGv0mM7WEa3MhY+sv2tWD2
	ZI5uW32uz7CsjP5qgg6APUizxY9aS7JhCa3KJMB4jLOt1aTOFyhWJvRquW6RiePo0VoZErWHV38IA
	xnh9VQmnmRt3aEV1ckCH05lhDolDZwHdvZm/Rt2Nkhi+tNf2AggJPE9FarHx7hTE4b/CNmAZ4LTis
	774bqy6Kk6+r714UI26Alhv0Ap+GmFxkL8jzCo5x8NS9NSqJHixs1WavTb8W4kYvTSyjvsV5I8dtv
	ZLzdEfb2anVFsCLGGE6AcOYvCAlr5BHq/D9C+TrLT/jqSWZI04Eb1WezDsgH/DaCgN28E6D9Nhc2K
	XukY01+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8UM-00B1Gc-2c;
	Tue, 14 Mar 2023 17:31:06 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8UK-00B1Fv-31
	for linux-nvme@lists.infradead.org;
	Tue, 14 Mar 2023 17:31:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 722B4B81AA0;
	Tue, 14 Mar 2023 17:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BF9C4339B;
	Tue, 14 Mar 2023 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678815062;
	bh=TCw/AN/Un6bpx1N00J+z/9cj1Si2ZLC5bXYvaaXHbJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RT336Dqro1Vvp6z3vHVDTOzldVLFQhP9GHbt6GCR9ohPrJ/T171dOczOyvFvLBU8P
	 QSR9sZcYLdEaaLnQVT0UTtAd3coc7EaaBd11pXeq2jTqQFZPLHQa2iKE8VlBW0lSgw
	 Nb53Rx/qZoqcFAO7rkFy8zoDogPkI1i9CgHCZPVIuzaUaMu7myIk6TzPMj83EW4AUd
	 tYI3vMBp30Yl106WwXWZ/kIaj8DbyOajqUNwCyzDXhjjRQoElRjWqje5bUpAWQuwqg
	 zrORMZ1564WqDhbrrZidfw9s5xpsDXQqhDKvHncDPKfYyICvrkZKE6QaPEHiNUDEqD
	 oW4FX4kd2HW4A==
Date: Tue, 14 Mar 2023 11:30:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
	target-devel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v4 09/18] nvme: Move pr code to it's own file
Message-ID: <ZBCvU0ldBvvTqz+y@kbusch-mbp.dhcp.thefacebook.com>
References: <20230224174502.321490-1-michael.christie@oracle.com>
 <20230224174502.321490-10-michael.christie@oracle.com>
 <20230314171322.GE6780@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314171322.GE6780@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_103105_112575_7FCAF201 
X-CRM114-Status: GOOD (  13.34  )
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

On Tue, Mar 14, 2023 at 06:13:22PM +0100, Christoph Hellwig wrote:
> > +++ b/drivers/nvme/host/pr.c
> > @@ -0,0 +1,155 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> I'd feel much more comfortable if we had a copyright notice code
> here.  This code was written by Keith, maybe he can help to fill
> in what the proper notice should be?

Okay, this was initially introduced with 1d277a637a711a while employed with
Intel, so let's add for the history:

/*
 * Copyright (c) 2015 Intel Corporation 
 *	Keith Busch <kbusch@kernel.org>
 */


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BD0ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/8guIjtfEkPLY7tbvoFkPJcoqfBmKbyJLHgwv+3sIb4=; b=sLB0jXFjoFNOcpNshc3nuK5i44
	AvyOu5jhwfBSTdC1/nQ4MhSh6EVhU0RvXOmRqt9twwuroBUhsvZkrM4EcbY4ljJY6vFDZyAm+qvLb
	ewtBQwCDQE1Kr5u2XxxTCmG9pw3yUmlpi47hRgO4UPP4Vf+e7NRHVW2/lNEb+WDdfP4J/lj8wsSnb
	/DkJvQHKvCKVz0BgfHTjpKalreQSfn7nndF7fRmaDyUiRF7i5sRmBqp122+U4tmG5aH2LtFEXd36C
	HBkvSJCL68xvOF6Q6itYhoZgoGHz8MaEUHLQnTRns55vmbVQU5KeErVr6suHAHXngqELa8Q9vwpGo
	WuwY/xTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooSNY-000xOc-M1; Fri, 28 Oct 2022 16:38:44 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooSNW-000xN1-CD
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 16:38:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 01AC2B82B81;
	Fri, 28 Oct 2022 16:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3087C433D6;
	Fri, 28 Oct 2022 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666975119;
	bh=HXelviQ+MhpOhcX5RBLW3YOkJdCOHX0A2A4aYPoP8MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dbs2sNTixTdBY62ULqMxeRkkpymOcnd/LbZG3/XDhQF3HY55RukqG5APWzkmspOmt
	 3ZOyoo79HUEJkjwxXVRtXXVhf3rqYMRfVy+oSlvBsxCrFpuVNBM3vuDCfrid0YwHpG
	 Nyqm1GD3g0gmH7OGgGueG4EXYKk2ZkyfDklJli3DH8orwxFZui+CL/ZCq1Lug0TK/Y
	 uRUEyxPyZ1SMBfTyNSpcG428UBaIMq551VTv276oO4n5eB2nwwVP85ozJrfxtdTT3m
	 /YPO0Uei8MPnswq/ljK9+FRvQ3gxk9j4+F+sBB5+qBFHtcqqc18ZJic9QyxJqz4lnE
	 IhNegMQKpiXeA==
Date: Fri, 28 Oct 2022 10:38:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 08/19] nvme: Move pr code to it's own file
Message-ID: <Y1wFjHzza1QYTzdG@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-9-michael.christie@oracle.com>
 <Y1q6so/3Hx9GZmTz@kbusch-mbp.dhcp.thefacebook.com>
 <370e66bd-81d0-5451-850e-50a4172ed64f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370e66bd-81d0-5451-850e-50a4172ed64f@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_093842_603506_FC512069 
X-CRM114-Status: GOOD (  17.09  )
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

On Fri, Oct 28, 2022 at 11:06:29AM -0500, Mike Christie wrote:
> On 10/27/22 12:06 PM, Keith Busch wrote:
> > On Wed, Oct 26, 2022 at 06:19:34PM -0500, Mike Christie wrote:
> >> This patch moves the pr code to it's own file because I'm going to be
> >> adding more functions and core.c is getting bigger.
> >>
> >> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > 
> > Good idea.
> 
> Credit goes to Chaitanya.
> 
> One question for you. I wasn't sure about the copyright. I saw
> you added the pr_ops code in 2015 when you were at Intel. Do you
> want me to add:
> 
> Copyright (c) 2015, Intel Corporation.
> 
> to the new pr.c file?

I think I was just the last person to touch the code, but it was mostly
developed elsewhere. So "no", don't bother propagating the (c).


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86660C05027
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Mar 2023 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PN3SueNKpb8lH9gKv0SyjpSq5WMP25T7FrngTyTCuTc=; b=ey+m3d+udUbrh7CHa1WljwRN8W
	HaTcAt2YtClgz4EAp+60tufgj2/8I84qAIqs/VY7oy7GATMzTHTvgkpxJMoCltGsU4R57x3p97ZkB
	EbiZxYtGLAJYTZgLrAsTIzvryUL08RfaEbden7ekQFxM5kfz0E4krZKALVqBvgyVYoXICxKqIcqLA
	dPpsiybKRLjo5p1r7ktLRthCTr+yBa11w6HPX2J06fP9XGu1mqPu3QlhEakGRtA+iW/2fj35+0rOQ
	/T1WqXRTEXSmf8qIbPC3cfjjOhPirdG8cS5qv1PTCQGfsRjt1irK1EXtc0K5KDIwkFwNql4tk2qPI
	h/fK7z/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8Kj-00AzeX-1z;
	Tue, 14 Mar 2023 17:21:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8Kg-00Azdr-1R
	for linux-nvme@lists.infradead.org;
	Tue, 14 Mar 2023 17:21:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20C4B68AA6; Tue, 14 Mar 2023 18:21:01 +0100 (CET)
Date: Tue, 14 Mar 2023 18:21:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH v4 13/18] nvme: Add pr_ops read_reservation support
Message-ID: <20230314172100.GA7909@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-14-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224174502.321490-14-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_102106_628089_619A8CE4 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
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

Same comment on struct_size() as two patches earlier, but otherwise
this looks good to me.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BADAC47DA2
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mBsCDU9amg1y2J7SZXa1OA2kUWANoE/tPQb8ew9OZWM=; b=zS1QwUzHG/PDAr/71IyQ6KvAoB
	v4ym6Cp+qENUVvsA9zVQ1wxqqXUTmLxVwKSrv+pDesdA0GtSp61k3K4JkbmlMHU5X88D3UQ77AZHZ
	XttXCF3AZBGyNKAVm7WYF6q95G1NkLzN8qkAvbNgTcAXbavRhoyVldKF5jiVQxHVSVW3a4hVd1DxU
	80itXKQrCxdZ5/NsXM2L8PBmfDg49WFjJTZREcD3+wj5izo+GdDpk6XFUPfrcAH2HApPdn25YtjkC
	maCftPpEW+AP1+L1nMi5tqeGSqGe3e5DA0lTf/XC+JdI0GScL2R+enTtbe2RMtMzsMXM0a5eMzdHZ
	aSfTM6Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7Qf-00HMRe-1J;
	Wed, 17 Jan 2024 15:02:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7Qc-00HMQN-18
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 15:02:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4135968C7B; Wed, 17 Jan 2024 16:02:01 +0100 (CET)
Date: Wed, 17 Jan 2024 16:02:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240117150200.GA30112@lst.de>
References: <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com> <20231221121925.GB17956@lst.de> <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com> <20231221125713.GA24013@lst.de> <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com> <20231221132236.GB26817@lst.de> <6135eab3-50ce-4669-a692-b4221773bb20@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6135eab3-50ce-4669-a692-b4221773bb20@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_070206_534802_14AD9FD8 
X-CRM114-Status: GOOD (  14.89  )
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

On Tue, Jan 16, 2024 at 11:35:47AM +0000, John Garry wrote:
> As such, we then need to set atomic write unit max = min(queue max 
> segments, BIO_MAX_VECS) * LBS. That would mean atomic write unit max 256 * 
> 512 = 128K (for 512B LBS). For a DMA controller of max segments 64, for 
> example, then we would have 32K. These seem too low.

I don't see how this would work if support multiple sectors.

>
> Alternative I'm thinking that we should just limit to 1x iovec always, and 
> then atomic write unit max = (min(queue max segments, BIO_MAX_VECS) - 1) * 
> PAGE_SIZE [ignoring first/last iovec contents]. It also makes support for 
> non-enterprise NVMe drives more straightforward. If someone wants, they can 
> introduce support for multi-iovec later, but it would prob require some 
> more iovec length/alignment rules.

Supporting just a single iovec initially is fine with me, as extending
that is pretty easy.  Just talk to your potential users that they can
live with it.

I'd probably still advertise the limits even if it currently always is 1.



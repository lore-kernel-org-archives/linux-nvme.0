Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA56D42B85
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gYO7wAxx1ibdOe02U5GJ7rOmx4rbbNwpmy0GoAfZung=; b=yqagZrIM9zFRTwf7vCJi9KuIN4
	R1x30Lj4xSJzsXm3dl7++Rxom6/rBtZYw9zLrlK/9tVQuDlN0Sj/AgiBhkBqiIm9NRPbkOCOQSppt
	wi9al02UjhjuKHd24HUKEeYRFKFlofTq7MGI0IBTZLmHgy+y8MdN/Njyt5l6TNENubhKF4a0vZ7oS
	q0vQe9w3BW/RQG2zM0wQN0eSSqL9uRsefEQ0pTVS/fu+xlK0dgwRCmRbSGj00JmYWLzDqjEIOOB+K
	Mk7cdLBI8V76POQclu7LBM9qC/OV0O3pH1bshwn1C+uXEgOpwJsOResPEfi0MYNAxWLUOlxtH8t/0
	D8HLEnHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tArqs-00000003kPO-1rJo;
	Tue, 12 Nov 2024 14:26:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tArq2-00000003kGK-0DXB
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 14:25:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A0FC5C4CF0;
	Tue, 12 Nov 2024 14:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F4AC4CECD;
	Tue, 12 Nov 2024 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421549;
	bh=FqK6AvBbok3agYaXcwWnCFMmVIqq7T/f8WTFeYDo4R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePHLU2/hD6U7PnMMH7nbItnFIAQtapvtYXrLfgEyRh4w1ARIGASKPWGmKV1vKvybR
	 1EKZvr1QfDBPgUlscNmxhahhmpFrR3vrFkx6aHUnAlH8kwxALSJmqUYcE+nu8SOmbI
	 0iG1helEUWOdLRfC5PTBSCRxJyBvCiTLDIMgCSMjafxj4k9HZkfNZsC0Vv3ljeJ9bB
	 WnjjK5n7Lf5wK1OKCGlRUM3O72GrzsH/kTenZhQlJRdHDLPKxdHKLVsR8CdDgENc8k
	 1C8WcFReORB9mUGjtybP4t6kITOXEr2pwCHcyHlb11/JfLm4+za1LevRJd/DT/tMpN
	 1I5gvWqlJLpBg==
Date: Tue, 12 Nov 2024 07:25:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, axboe@kernel.dk,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	javier.gonz@samsung.com
Subject: Re: [PATCHv11 0/9] write hints with nvme fdp and scsi streams
Message-ID: <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com>
References: <20241108193629.3817619-1-kbusch@meta.com>
 <CGME20241111103051epcas5p341a23ed677f2dfd6bc6d4e5c4826327b@epcas5p3.samsung.com>
 <20241111102914.GA27870@lst.de>
 <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com>
 <20241112133439.GA4164@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112133439.GA4164@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_062550_151581_CC4660F6 
X-CRM114-Status: GOOD (  15.29  )
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

On Tue, Nov 12, 2024 at 02:34:39PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2024 at 06:56:25PM +0530, Kanchan Joshi wrote:
> > IMO, passthrough propagation of hints/streams should continue to remain 
> > the default behavior as it applies on multiple filesystems. And more 
> > active placement by FS should rather be enabled by some opt in (e.g., 
> > mount option). Such opt in will anyway be needed for other reasons (like 
> > regression avoidance on a broken device).
> 
> I feel like banging my head against the wall.  No, passing through write
> streams is simply not acceptable without the file system being in
> control.  I've said and explained this in detail about a dozend times
> and the file system actually needing to do data separation for it's own
> purpose doesn't go away by ignoring it.

But that's just an ideological decision that doesn't jive with how
people use these. The applications know how they use their data better
than the filesystem, so putting the filesystem in the way to force
streams look like zones is just a unnecessary layer of indirection
getting in the way.


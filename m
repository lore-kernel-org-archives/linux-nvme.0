Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C66CC47258
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jkwarm5DpHDFsyYgiYQsfxjChtXkaV+MJAHY1naVkW8=; b=NAs6JsooitehFrFacCQ5w5L4B4
	5buCgQhNT2JSbpkt9RAVTYHrqEL+ejrbf+CjbVsfuySmGbOtf1P7KLrl1/uCmA3q4DAoWk4qMXZtM
	bCkFWRGe84qWpKK5McBzOH4BTiZq78l8OJe1ky9evfUwOm7PNRTR3KqHKtARWTj5UavIDdaPLEWFL
	x5BA1tV62GcZtXxLO+7xM/7mMn+OPZcpNwVNDF9fG0+CMmAONLLOpnGaZdsl2Ys0IHBcmf2BvyyOz
	rldJZUda56PVdURwGEp4K7rCuz8FLxzRWTVSnbqtSvfqq/ZzXJJRPrA+3LWlBn0H/K+aACYCcPCH9
	SpLm6rQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNxiO-000Yge-11;
	Thu, 11 Jan 2024 16:15:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNxiL-000Yg6-1Y
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 16:15:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8034F68CFE; Thu, 11 Jan 2024 17:15:22 +0100 (CET)
Date: Thu, 11 Jan 2024 17:15:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, axboe@kernel.dk,
	kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com, bvanassche@acm.org,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240111161522.GB16626@lst.de>
References: <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com> <ZZ3Q4GPrKYo91NQ0@dread.disaster.area> <20240110091929.GA31003@lst.de> <20240111014056.GL722975@frogsfrogsfrogs> <20240111050257.GA4457@lst.de> <d5db2291-36b4-4b22-89f2-1d9e7d30f0f1@oracle.com> <20240111144537.GA9295@lst.de> <71063aee-8ba9-4a02-8c09-9b3a9982f6e0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71063aee-8ba9-4a02-8c09-9b3a9982f6e0@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_081529_662213_B27B5B76 
X-CRM114-Status: GOOD (  12.21  )
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

On Thu, Jan 11, 2024 at 04:11:38PM +0000, John Garry wrote:
> Could we just error the SETXATTR ioctl when FS_XFLAG_FORCEALIGN is not set 
> (and it is required)? The problem is that ioctl reports -EINVAL for any 
> such errors, so hard for the user to know the issue...

Sure.  Pick a good unique error code, though.


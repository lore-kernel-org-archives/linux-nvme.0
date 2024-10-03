Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46053CF34A4
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4O11UMporc2r4YukucYBQo6nKduMw9gSM7FQ0fF7Qk=; b=q2ZlQ7yCglSx46kuc+QToVH0m3
	DA1ppML6u+sxoqCsvu3JmvpQibluQUYKRmTa0RSO2rmNDbpJhRdJHOI43Y57OBMuC/8uApFJKu1L+
	q4XqtKx3N6LHAsgIZ/1oYLTAICnxUaSx+dyUbUUExWU1nNhKIvibWRoLomYg2Px6OihnBzZiDA3Y+
	ckJbwSe5reF+hdkEC/DB5ukQFg2DXCiXz+tsC3ugiILbIQKxJUMBIRoCoU2HiAWvg+V0FczxjJW4h
	t0TrsMEpKBY+RLyaba4APpFdUAeBKJCFgpj6obu6S/peAg5GlEwhYQIMvxgQVxYVudw8H4EEAzFns
	F2rtSYYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swLBV-000000093As-1vUC;
	Thu, 03 Oct 2024 12:43:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swLBS-000000093AL-2Rhs
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 12:43:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB276227A88; Thu,  3 Oct 2024 14:43:45 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:43:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Joyce <gjoyce@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me, hare@suse.de,
	dwagner@suse.de, msuchanek@suse.de, jonathan.derrick@linux.dev,
	okozina@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH 1/1] nvme: retry security commands if media not ready
Message-ID: <20241003124345.GA16754@lst.de>
References: <20240930164845.8406-1-gjoyce@linux.ibm.com> <20240930164845.8406-2-gjoyce@linux.ibm.com> <20241002081633.GA22436@lst.de> <dbfd87e4900bea3a28ac46f5abcfb39ef2c13fc1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfd87e4900bea3a28ac46f5abcfb39ef2c13fc1.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_054354_785161_3187178F 
X-CRM114-Status: GOOD (  20.60  )
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

On Wed, Oct 02, 2024 at 11:51:56AM -0500, Greg Joyce wrote:
> If we cache the timeout value(s) in nvme_ctrl then it may be possible
> to just eliminate nvme_get_timeout() entirely. Is this the approach
> that you were thinking?

Yes.

> I'm a little confused about what you're saying about the timeout.
> nvme_enable_ctrl() does determine the correct timeout value and passes
> it to nvme_wait_ready() but NVME_CSTS_RDY is set well before the media
> is ready (if CC.CRIME is set). Unfortunately there doesn't seem to be
> any controller status that indicates when the media is ready. I thought
> about having nvme_wait_ready() wait the whole timeout if CC.CRIME is
> set, but I think that is contrary to intent of CC.CRIME. And on the SSD
> that I'm looking at the timeout is 15 seconds which would be a pretty
> big hit to boot time.

What I mean is to simply set a timer for the controller ready timeout,
fire it when we set CC.EN and then the time sets a new media ready
flag in ctrl->flags.  Then only retry when this flag is not set.



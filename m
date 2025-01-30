Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EDDC0218A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qsthqpO7eT/PN4h6zfRCZRC0k8LPYXxQFOt5Xt6pPl8=; b=miqPQ8VgKfQZKRCS2paZW1gdBX
	VLamNByJU6kbFTyKet21XeAX/NwEIjlrsCEk9/CV6a+PJBzdBhrQDAR50Ph4pgx5Tr0qb0JFMDCXR
	PhLOadxtGaEODRLHHe9slvIwfUu9kFp2CrkF1iQu3tOST2ZaCSIAyQxA6+Jg/fPLRktEOg9UKPVfC
	FczO3YDYGADuInuTiGsszFHngn0L7IdCfClyUz22GtfU4YN+TNNS7yvQFvgZJpZecJePXIt/mgl7o
	q6NRkLHeGecFsgeGKZyY/vj1ilQhS0BYb8jDFH1LaMzbOSI6Zj8LJ9Klp64gN1HRWEx8px95R/2k1
	Ri1hgNgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdVXU-00000008ywr-24nZ;
	Thu, 30 Jan 2025 14:29:04 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdVXS-00000008ywB-1IKd
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 14:29:03 +0000
Received: from macsyma.thunk.org ([12.221.73.181])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50UESvQI005998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738247341; bh=qsthqpO7eT/PN4h6zfRCZRC0k8LPYXxQFOt5Xt6pPl8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=L59Kx8DF9Ed5Y2eTvdXfoE/6o8wmClyKDv+ynISKDMYdJvTiGCf5SwK9vP8TtFcjR
	 WOA+q+/DMs6ngERetvncxFYIvZtCmnkzEz+v+GI7l4LGPN0A8F9G//O3IUx/T68N9a
	 tnTlWQmplKXqq+Spsb0PGzkJIshxphZkfmF1wj+iLHTtgvH2BBGcTqx0Q4e45tLtEd
	 oICFQ+Apmxkny8WRh7ZKQbYDygSz8m2LMTabL3utUTeWHDChwCutrvflMkBt6jeO/6
	 F+o4GDxFWHf2fXs+oLbhZ5G9OHnOio1+RQ9aYy84/0mQwOi1EKDp9sMPyym2of0jPk
	 Rs9z+Az+1jz3Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0C9853404C7; Thu, 30 Jan 2025 06:28:57 -0800 (PST)
Date: Thu, 30 Jan 2025 06:28:57 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <20250130142857.GB401886@mit.edu>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130091545.66573-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_062902_506874_FACF0FEB 
X-CRM114-Status: GOOD (  18.40  )
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

On Thu, Jan 30, 2025 at 02:45:45PM +0530, Kanchan Joshi wrote:
> I would like to propose a discussion on employing checksum offload in
> filesystems.
> It would be good to co-locate this with the storage track, as the
> finer details lie in the block layer and NVMe driver.

I wouldn't call this "file system offload".  Enabling the data
integrity feature or whatever you want to call it is really a block
layer issue.  The file system doesn't need to get involved at all.
Indeed, looking the patch, the only reason why the file system is
getting involved is because (a) you've added a mount option, and (b)
the mount option flips a bit in the bio that gets sent to the block
layer.

But this could also be done by adding a queue specific flag, at which
point the file system doesn't need to be involved at all.  Why would
you want to enable the data ingregity feature on a per block I/O
basis, if the device supports it?

We can debate whether it should be defaulted to on if the device
supports it, or whether the needs to be explicitly enabled.  It's true
that relative to not doing checksumming at all, it it's not "free".
The CPU has to calculate the checksum, so there are power, CPU, and
memory bandwidth costs.  I'd still tend to lean towards defaulting it
to on, so that the user doesn't need do anything special if they have
hardware is capable of supporting the data integrity feature.

It would be enlightening to measure the performance and power using
some file system benchmark with and without the block layer data
integrity enabled, with no other changes in the file system.  If
there's no difference, then enabling it queue-wide, for any file
system, would be a no-brainer.  If we discover that there is a
downside to enabling it, then we might decide how we want to enable
it.

Cheers,

					- Ted


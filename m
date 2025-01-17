Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC092C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 20:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/L8MRY0/vPoz9eHiXq00hDLXdCi+6zZIgUQcWl7yjBI=; b=kFlWvgcbcTlOeXs2JCH+h66A0b
	JZZ/B6Hyz9Pt1hFG3vC0rb/CNGK0xDKN+KMgsap+B2rjyg2Tomvfjh3YY8jewYFZ+o1eeSmxHW7xz
	h8qaYMXnkkNxD5Sg7gHpnPXaelh/WjkPNzqddAFUT+a7K+lJllNmt5C7qnndoxRLxWacGnFdsPxtp
	CPizrp0r6pVURqUgPxVUNe/j+TwnszJlldAxpCvpPjmtkqydIpVd4Q1+VHtPQGgQTmyoLWXPlksSL
	PwmEKUis1A0m2VI8pXjHTp/uhlTOLsgXLo3EuqOIkzuA8EJSHu3FPkVp1DdOXHFXWDPoUBZaV0U1i
	YYOyBm1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYseb-00000001IJB-1Cn3;
	Fri, 17 Jan 2025 20:09:17 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYseZ-00000001IIk-0Jrh
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 20:09:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AD5DDA433FF;
	Fri, 17 Jan 2025 20:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A208C4CEDD;
	Fri, 17 Jan 2025 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737144552;
	bh=M+JxruSgX1bYg5LhmKqbq37EhevWGWaB3pvY8VSU974=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoSc3/9PdTyxgzGZJb88SFSIRNlqMsIjv6lU2ke9g2OVCnv2VetyQC8oq4WRP/Dyv
	 wLHvZvT1wvJiI9INv1XYRILbMrR1Kit+THZ8vyHJPUjmQn9eobwCdmVqAXqTqWOY5K
	 ERmned9Nqif/X8GX9BQrP8YAwWxjwrX9r8zz2HnaoRqKQRAJpPCLC3b4df9AleO6kI
	 ompcgioW5wpvz3kqDFR5Nm6ouEDalP7lBYZNfXqP6jdEUguVA1JBRpE0UYgnuBB88c
	 HRnGVpL8Umje47Y7QI6bPrKUXVluOb71k9bKAPisP+DkYEyZUyVx+4nFw3q8bXox3u
	 9B2k8Vq1qn+WQ==
Date: Fri, 17 Jan 2025 15:09:10 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	mpatocka@redhat.com
Cc: axboe@kernel.dk, agk@redhat.com, hch@lst.de, song@kernel.org,
	yukuai3@huawei.com, kbusch@kernel.org, sagi@grimberg.me,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/8] device mapper atomic write support
Message-ID: <Z4q45sjEih8vIC-V@kernel.org>
References: <20250116170301.474130-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116170301.474130-1-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_120915_180092_C540A82D 
X-CRM114-Status: GOOD (  13.07  )
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

On Thu, Jan 16, 2025 at 05:02:53PM +0000, John Garry wrote:
> This series introduces initial device mapper atomic write support.
> 
> Since we already support stacking atomic writes limits, it's quite
> straightforward to support.
> 
> Personalities dm-linear, dm-stripe, and dm-raid1 are supported here, and
> more personalities could be supported in future.
> 
> This is still an RFC as I would like to test further.
> 
> Based on 3d9a9e9a77c5 (block/for-6.14/block) block: limit disk max
> sectors to (LLONG_MAX >> 9)
> 
> Changes to v1:
> - Generic block layer atomic writes enable flag and dm-table rework
> - Add dm-stripe and dm-raid1 support
> - Add bio_trim() patch

This all looks good.

Mikulas, we need Jens to pick up patches 1 and 2.  I wouldn't be
opposed to him taking the entire set but I did notice the DM core
(ioctl) version and the 3 DM targets that have had atomic support
added need their version numbers bumped.  Given that, likely best for
you (Mikulas) to pick up patches 3-8 after rebasing on Jens' latest
for-6.14/block branch (once Jens picks up patches 1 and 2).

Jens, you cool with picking up patches 1+2 for 6.14?  Or too late and
we circle back to this for 6.15?

Either way, for the series:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


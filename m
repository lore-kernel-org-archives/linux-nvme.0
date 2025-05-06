Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A564C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=03dXOM8DfHQTUMTTD3vdOwWdVLfIwqpkutIqiYI9evM=; b=jXFuaZVfhHDDsd6Jw2l8rsUF46
	Sv9D9aEL0fehKzRxgO8T7SRIqfjXTE1r/nlbwdY3oxSM9EBjwiUUX9jyQii2CtlGpox36CQxMTwTl
	sG3yYri9TNATADxVHrWgDUKP1Fm6oliRa9oHrRSPK+f8favWUyIzxfLlaIuVOsevhY0OqLm8pDGel
	a3VUERd3SyUINTyaT+xIOM2Gv3aPZc1Win2cj0AWyqAiwR6qcLnEEMkLxCqKe+7RnDJiJryQ6zjlo
	dPIoK7Hbj1rFP3SZ6tOz4xUABcZ8FtDZ0NdpBO91qDtfsu9vrOJYxt7VTZx5489oKAKoxrbeMPezE
	nw862xHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRqF-0000000DhPY-2L5S;
	Tue, 06 May 2025 23:36:51 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCNZi-0000000DBU0-20vo
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 19:03:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9512CA4D698;
	Tue,  6 May 2025 19:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBD8C4CEE4;
	Tue,  6 May 2025 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746558209;
	bh=44pu7eUj4ufXPS2ZipmpBRbiPVL1b0+oi3A4kSLu/AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASHKxj7cvlUzwZFYOyy4+DgMlGHNXyr3RPltSBsJ8qRX+rwh0KbL34lvU6xCdh+x8
	 iAzeHf39m+LP+rNNG3dpdmBJxzHZoCIHRVvK3DEpm+aNBbB+zYXMajlz0j3XwJPV0R
	 be0uAeBet12HzhfKXghjUGRzSttFiC3WU5gjUF6Ak02WYJpAAYDF3w/TkzvWTRx401
	 1L+uyvxchRq+Ew9/Rf2Z1uo+79K0cfvdGC7GBkqC29GJUgt74NZphJnfHIqsgVBIMv
	 Z+Z4cw9uM6Nqkvqk3syx/iDhxpm3osSG7HLKARpfbgdQDM7eeIpbcJPGZ/JAmiCm4p
	 MH3fvFJax/K7A==
Date: Tue, 6 May 2025 13:03:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	asml.silence@gmail.com, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v16 10/11] nvme: register fdp parameters with the block
 layer
Message-ID: <aBpc_RX3HC_zSpaI@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20250506122651epcas5p4100fd5435ce6e6686318265b414c1176@epcas5p4.samsung.com>
 <20250506121732.8211-1-joshi.k@samsung.com>
 <20250506121732.8211-11-joshi.k@samsung.com>
 <CADUfDZqqqQVHqMpVaMWre1=GZfu42_SOQ5W9m0vhSZYyp1BBUA@mail.gmail.com>
 <aBo4OiOOY3tCh_02@kbusch-mbp.dhcp.thefacebook.com>
 <CA+1E3rJx3Ch2POT_t4DWiqb2nJiX7bHPrGVMW_ZviJ_b0o9UvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+1E3rJx3Ch2POT_t4DWiqb2nJiX7bHPrGVMW_ZviJ_b0o9UvQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_120330_579955_C2B715B2 
X-CRM114-Status: GOOD (  12.77  )
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

On Tue, May 06, 2025 at 11:44:27PM +0530, Kanchan Joshi wrote:
> On Tue, May 6, 2025 at 9:56 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > You're right, should have been min. Because "runs" is a u64 and the
> > queue_limit is a u32, so U32_MAX is the upper limit, but it's not
> > supposed to exceed "runs".
> 
> Would it be better to change write_stream_granularity to "long
> unsigned int" so that it matches with what is possible in nvme?

That type is still 4 bytes on many 32-bit archs, but I know what you
mean (unsigned long long). I didn't think we'd see reclaim units
approach 4GB, but if you think it's possible, may as well have the
queue_limit type be large enough to report it.


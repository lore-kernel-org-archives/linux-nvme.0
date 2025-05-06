Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6191AC3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 06:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3bNl3mF8o0QOd9a28cbgFxo5QaDZkzW2TofdWEO6Ww=; b=LUv67iUJQLjmtfDteNh4P7w/sW
	WrmPhla5tqkoMRjxFP5zvBmmr7GGH4wG12dXxsJbNEC5rRKKm2yrUyBJD+BPEHtTEuvSIm/4h/8bV
	RMvtE9c4wp4uvA+lYUNPmtpSomTfYx2B+aBnnixE5dTF/tlvG8TP3BJA0SVGEQI90dtmqU89/7R2M
	AQePu4N95UFg2v1l+Xx+dkv6NdxxKi1Ism72c1+6l5i6iDhuSVkSCTLtOITpos5D6zdszEj4oFZ5d
	XI4tPNf689IeVc4fIFEK6pK/FDAkY9tmCJypTdR7mv3JrFIadfBCgKQ+0xdd4HSsPa68dujdXeHat
	LcHPD7Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBel-0000000Adzb-2U9N;
	Tue, 06 May 2025 06:19:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCAS4-0000000ALRm-3yh1
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 05:02:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C5A767373; Tue,  6 May 2025 07:02:39 +0200 (CEST)
Date: Tue, 6 May 2025 07:02:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@huaweicloud.com>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506050239.GA27687@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505142945.GJ1035866@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_220245_126621_7FFEE2F3 
X-CRM114-Status: GOOD (  12.74  )
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

On Mon, May 05, 2025 at 07:29:45AM -0700, Darrick J. Wong wrote:
> attributes_mask contains attribute flags known to the filesystem,
> whereas attributes contains flags actually set on the file.
> "known_attributes" would have been a better name, but that's water under
> the bridge. :P

Oooh.  I think I was very confused at what this patch does, and what
it does seems confused as well.

The patch adds a new flag to the STATX_ATTR_* namespace, which
historically was used for persistent on-disk flags like immutable,
not the STATX_* namespace where I assumed it, and which has no
support mask.  Which seems really odd for a pure kernel feature.
Then again it seems to follow STATX_ATTR_WRITE_ATOMIC which seems
just as wrongly place unless I'm missing something?



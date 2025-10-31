Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3163CCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U4qy/1PX8SVLQSFp19YC7/P0JzBIbm/6H8gkbzmLBCc=; b=jay582zBaqwjs8Et+dgzk9zEVD
	T9YEqou65kqHV8lt74Ekj9DrsVkydyn75YIQR28+85gQu1dHP2IMUWnJ20cbG2rexPWsEfdgKBwcE
	zgZSKvAhKa3N3ZpdHsSpidLMsgpRJRCXTNI1fHI+ivrHWjvaG8PC+RbZYtRXkMS9LECFEGr8U3VkR
	A6B9fS4/hfxh3wmALosqRQnWsiqO4EQT9MywbHxvdGitPHZYKFS24cksNQw43yOoEX7AqDTZP4ojQ
	N90AaxOqra21MQj4hfZqqvzDxsHvXanisp1bh1v1nmT85l0WUoUt+XfhEt8VAwG4grG3+HZAkJtaI
	r3VrlI8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEplF-00000006CbZ-0k0I;
	Fri, 31 Oct 2025 14:05:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEplC-00000006CaJ-2TGZ
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 14:05:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B336227A88; Fri, 31 Oct 2025 15:05:42 +0100 (CET)
Date: Fri, 31 Oct 2025 15:05:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Message-ID: <20251031140541.GB17006@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-4-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030035114.16840-4-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_070546_784142_36D3C8ED 
X-CRM114-Status: GOOD (  14.14  )
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

On Thu, Oct 30, 2025 at 01:51:14PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing the queue ID to te sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> 
> Note that only QID 0 (admin queue) is supported.

Why pass the queue ID then instead of a boolean value?

> +static ssize_t nvme_sysfs_replace_psk(struct device *dev,
> +				      struct device_attribute *attr, const char *buf,
> +				      size_t count)

Overly long line.  And very inefficient annoyoing to modify indentation
compared to:

static ssize_t nvme_sysfs_replace_psk(struct device *dev,
		struct device_attribute *attr, const char *buf, size_t count)

> +	rc = kstrtoint(buf, 10, &qid);
> +	if (rc)
> +		return rc;

Nitpick, but nvme style is to use the slightly more descriptive
error and not "rc" which doesn't mean much in general.



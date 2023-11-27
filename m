Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F658C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AYtUg/cFFxqhm1ONB7t9JxStlhJEhz1i+uOIk3ajFKc=; b=x4FT94hEMvxXsYq+qmFrjB4MHJ
	UOHw6brZPv1EFUGc/+hqJKtzLBNT+20jKkzbGFgU+Hxnk+AptDxINL8kns9HoGZipSOKAMVlmDLcW
	ulueJnW1OAYURIQNXm4QRehAXrwYBAS4iP3jUEL5rt6nqdNGFJfg5klSHq3EzTwPylI8Kqzhfi1iE
	PCYesdgAyQOeW3/5RoeaSKpx06B2exvij2S44gM0EBeo2++HC3r9K3yDAwy1xBuMZuF9fneScWmhv
	WgrR8Ew3Xy8Xu1Mo4FsuxMtGO0pHx3kltGBIcMVkAIoVjIYoyey4BTZez6JRfWesIhEk6uJIuPZWj
	ZLAWdxIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7dnJ-002rOB-09;
	Mon, 27 Nov 2023 15:45:09 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7dnF-002rM9-1X
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 15:45:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E96F4CE10B9;
	Mon, 27 Nov 2023 15:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B9BC433C8;
	Mon, 27 Nov 2023 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701099895;
	bh=gvIJxTodTVCzgI7+DCND4759lIJLFTQk3aIMqIUYV+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAbOfEmf9G1gGLkJt3Y5A0jNlDZHEvGgGrNrCOotLf5Frk67z4tI6hhL/0f9dSUUV
	 zjG1M/pbvAT4Mdl7X5gPeIyzi7CsTPpbvodP87CXI4wZwUbHX7VAYO/MJs/6stz7gH
	 S2ULbgZnt8VepBsg1NEHiALEbzfFu9jJ/8pZPORUjJeF455exQQ57haCUydSQdAK5P
	 idI0DvN32TrI+4v3Sfpw9Ourig+8tbTXpEYdOQT4lKtnKmW18/+UStn5SXBSDPboMy
	 CWEJAZN7BF6+Mw6sStSCFTGVoGvxIm1xkAraG4fUqYYeljwxonDwcBfnaT/58ArMWZ
	 fgmFqRdRqwNeg==
Date: Mon, 27 Nov 2023 08:44:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127141857.GA25833@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_074505_744514_F1D52F5C 
X-CRM114-Status: GOOD (  12.19  )
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

On Mon, Nov 27, 2023 at 03:18:57PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 11:32:08AM +0100, Daniel Wagner wrote:
> > +static ssize_t lba_ms_show(struct device *dev, struct device_attribute *attr,
> > +		char *buf)
> > +{
> > +	struct nvme_ns *ns = dev_to_nvme_ns(dev);
> > +
> > +	return sysfs_emit(buf, "%d\n", ns->ms);
> > +}
> > +static DEVICE_ATTR_RO(lba_ms);
> 
> I'd probably spell out metadata_size, or probably even better
> metadata_bytes to match the unit postfixes elsewhere in the block code.

Should this even be an nvme specific attribute? I thought we should have
blk-integrity.c report its 'tuple_size' attribute instead. That should
work as long as we're not dealing with extended metadata at least, but
that's kind of a special format that doesn't have block layer support.


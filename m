Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4AEC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:38:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52DF60FED
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C52DF60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v3QFRVzgZYVwqnwEFtrnTuoOStODrP6XidgExrJ7Zww=; b=AlJdzCt8jwb82I
	93IDWatmvPRsg4JMKbNWnleO1pnqsQBqPEMO+0Yiq3HgaFZBLKNOxLema8wlbqWG9Ihcw9CxQCHe2
	G6HgOh+w8okaLvJbAjIfizuEGCWxlv6xRmv53D1JP9Pg6nJ5uU64ModmNgWMnGs5CRdewz87akllx
	PjRXKt9q5fjrxIcQC9gQxNDWyJ0pX3sfMx8GF973mX8jMMMrv0GZJs9pmIqaimsolVIFL/9pl9i7a
	o8/0S4wEmGA72w+/z+7LVj+1iDEu6BlxBnErqYN7JXDXy7Q1etUUgqpZvVXfntK69SH9STllFecCi
	g3HaDasu6icmpKHi8gXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUzGc-004hvG-5l; Mon, 27 Sep 2021 22:38:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUysA-004ZUT-0T
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 22:13:19 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 014C460F94;
 Mon, 27 Sep 2021 22:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632780797;
 bh=aUkvMSo84Ts+2hyfPmGVIgM4abSwV67b0JY7DU1pVzk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CR3ThJMTzNN7IxGCoQ9SihnqkQkkv3F41YJaAr67klqD8ay7cRcSeppUUhh/8+7PQ
 DFxOyaBzoI962F2usbjfziq1easTinlTyXoLnTwCKEIgdylqvj9h8QEVuaeDIXyhCf
 8pRA7I8t7831enPRtpE/358VVKwNsUwrPG5b/lRH5qyH1IXU821Yn+C1LYzW65TQiM
 Kr2pNyLsYwmCCd+A88QwrYslEh5QjuzWUx1TBVYz6/tBtiRBBMVllLOKUI3Il17WX7
 FhuTQ1Q9A8S1JL3ILSV0TNBfSOS3l81jmsFCnMM1Pvg1VT7bDaBh2KmwsWKeTC3U9m
 OIVZBum14ZcHw==
Date: Mon, 27 Sep 2021 15:13:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, colyli@suse.de, kent.overstreet@gmail.com,
 sagi@grimberg.me, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
 konrad.wilk@oracle.com, roger.pau@citrix.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
 xen-devel@lists.xenproject.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] nvme-multipath: add error handling support for
 add_disk()
Message-ID: <20210927221312.GD387558@dhcp-10-100-145-180.wdc.com>
References: <20210927220039.1064193-1-mcgrof@kernel.org>
 <20210927220039.1064193-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210927220039.1064193-4-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_151318_116290_38C1B033 
X-CRM114-Status: GOOD (  10.54  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 27, 2021 at 03:00:32PM -0700, Luis Chamberlain wrote:
> +	/*
> +	 * test_and_set_bit() is used because it is protecting against two nvme
> +	 * paths simultaneously calling device_add_disk() on the same namespace
> +	 * head.
> +	 */
>  	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> -		device_add_disk(&head->subsys->dev, head->disk,
> -				nvme_ns_id_attr_groups);
> +		rc = device_add_disk(&head->subsys->dev, head->disk,
> +				     nvme_ns_id_attr_groups);
> +		if (rc)
> +			return;
> +		set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);

No need to set_bit() here since the test_and_set_bit() already took care
of that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

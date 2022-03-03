Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593C4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m379gCVj+UPxCHE/h4n3uXpgnQR774H9Czd3GNXwQSs=; b=M4fhQG6n+WvMEAiMLjFcy6uS0u
	13d9M/ZurzPC5Ps6wKU9mL7RU1ReV1bfdj62nnydCHQ0sS+msI4ko8HyqNJYL5AmmQ3urzRD5I71y
	EmKfjhASW8YzJ0MZQrJd+VwUneQfaJIdfSuCLiIMkD5yeY15o2hnuT7B0ekbiAV1fdasJNa3SJroh
	RX/ga5MQPzfF0RRvyzt8jSKrt1XLHp6LMqrv6dzhb5Ftyuje93kEXRE8gFwQfLzNJGmmpVhQQNgbp
	O+9bzqy9LWnCB1WC/8PGMeIGqNQq3GnvOJBUaO5bUvU37L9+lF1zmLMe/Se79OJt+gw+hq0437bXa
	ZNNsmNxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPmel-006fWF-W3; Thu, 03 Mar 2022 14:42:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPmei-006fVJ-NO
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 14:42:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1E15861BF5;
 Thu,  3 Mar 2022 14:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30481C004E1;
 Thu,  3 Mar 2022 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646318530;
 bh=bepX4h64/sZkQNqgQxZ6yAnB9i6gMX0UPcHAyE3e2K4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UsKuJISWmZgVUJB+/wQPC53+FU62oIUsoggk6P2XmrcjbmrqdFVNgz2EvgHFiD+Vd
 YruJsG9psda/fbQko78hHLk0HbuTpHfiPVmEQfqFJAzahL7GZMuHHO8c51jGDICV4o
 F/9ylSGUPEqitWHaUnC1YACr5BDx1pYhoy/2Zg4oSNLbTCPikWj+0nh1TsyapUY5Kw
 MYXMkNqMLc0mtMlFN2+nvtn7qRdDfK5N42qWRMQg7HdnlGAqHWTmwUFrMYNo+qZhtg
 9o1EcIRt2QhV5Cey4rumCBNMPg5Jz4Ffp7qMgZr4GEGghOhNv6E30OjgW1F0tLayQo
 aZyTZsD5yUSZw==
Date: Thu, 3 Mar 2022 06:42:08 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: remove support or stream based temperature hint
Message-ID: <20220303144208.GA2367645@dhcp-10-100-145-180.wdc.com>
References: <20220303105049.315987-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303105049.315987-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_064212_831192_700CC252 
X-CRM114-Status: GOOD (  12.08  )
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

On Thu, Mar 03, 2022 at 01:50:49PM +0300, Christoph Hellwig wrote:
> This support was added for RocksDB, but RocksDB ended up not using it.
> At the same time drives on the open marked (vs those build for OEMs
> for non-Linux support) that actually support streams are extremly
> rare.  Don't bloat the nvme driver for it.

Fine with me. It looks like the early interest in streams never really
materialized, so it's unlikely we'll hear any complaints. 

You can remove nr_streams from 'struct nvme_ctrl' while you're at it.

Reviewed-by: Keith Busch <kbusch@kernel.org>

And without nvme, there doesn't appear to be a real user for the
write_hint anymore. All you can really do with it now is prevent
merging, which doesn't seem useful.


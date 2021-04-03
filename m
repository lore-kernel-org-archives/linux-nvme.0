Return-Path: <SRS0=UR7E=JA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F5C433B4
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Apr 2021 06:10:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C606120A
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Apr 2021 06:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C606120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Beg1HbFD7yxsdv8DnoqxZjz+03JgX+pOiEQHADnzY2o=; b=WgvlJS0w00aPJsJV71UdnWiuO
	xfRGMgvEhU0xKG66qKzF4hNjhkDUwmKiba3c1TUGq3uMVL0j12T8l4c9IW0f6Emwb7SC5nNuRX7nY
	U2WZhv5z77kZcW2B1RLo7nmKUepTFrHKNN0TQW5yQAfd/sJbuZ3EOp1PnN4YqpYfS+tivRhT5Ppg6
	DDk8PSKGJjTN5VIwRs+q3xToPnRZHo6sedhsh0wape21JU6+ILHoth2G0osIcsvnhC2oglva34FXt
	CTJ7x+rg0CJL7r2zNPrNO8TGx3NVabql+QjLOXKd8RVFgbgoOAjMYeoO7qgd5j2wNJMD9Br7QvMtQ
	wowkQJVIQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSZUa-00ELJ8-SQ; Sat, 03 Apr 2021 06:10:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSZUW-00ELIX-Oz
 for linux-nvme@lists.infradead.org; Sat, 03 Apr 2021 06:10:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05DBF6120A;
 Sat,  3 Apr 2021 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1617430236;
 bh=LyjJ30TVeTf/HFNxs8PCWYYFIPWpoaUvJ50Oqbh1lNY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kDCc0GNar/b7x94TboxXAobz4xaKO0rEWJA7pky/MWdvg1747vnt4jjdfx5hbKv/G
 r3T8/FEU1UI8Nyj95B5WBBBGv/iFbglbct4hCtER9cbVZ8jzJUnsOOluuqbRu5BJjW
 3y4PTEgxw8hFMqYwVQT6maHZ3gPSSqUOTL0XgLVE=
Date: Sat, 3 Apr 2021 08:10:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH stable/5.4..5.8] nvme-mpath: replace direct_make_request
 with generic_make_request
Message-ID: <YGgG2TAA9TNqM9S6@kroah.com>
References: <20210402200841.347696-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210402200841.347696-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210403_071041_042477_AD2C84B1 
X-CRM114-Status: GOOD (  22.97  )
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

On Fri, Apr 02, 2021 at 01:08:41PM -0700, Sagi Grimberg wrote:
> The below patches caused a regression in a multipath setup:
> Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> 
> These patches on their own are correct because they fixed a controller reset
> regression.
> 
> When we reset/teardown a controller, we must freeze and quiesce the namespaces
> request queues to make sure that we safely stop inflight I/O submissions.
> Freeze is mandatory because if our hctx map changed between reconnects,
> blk_mq_update_nr_hw_queues will immediately attempt to freeze the queue, and
> if it still has pending submissions (that are still quiesced) it will hang.
> This is what the above patches fixed.
> 
> However, by freezing the namespaces request queues, and only unfreezing them
> when we successfully reconnect, inflight submissions that are running
> concurrently can now block grabbing the nshead srcu until either we successfully
> reconnect or ctrl_loss_tmo expired (or the user explicitly disconnected).
> 
> This caused a deadlock [1] when a different controller (different path on the
> same subsystem) became live (i.e. optimized/non-optimized). This is because
> nvme_mpath_set_live needs to synchronize the nshead srcu before requeueing I/O
> in order to make sure that current_path is visible to future (re)submisions.
> However the srcu lock is taken by a blocked submission on a frozen request
> queue, and we have a deadlock.
> 
> In recent kernels (v5.9+) direct_make_request was replaced by submit_bio_noacct
> which does not have this issue because it bio_list will be active when
> nvme-mpath calls submit_bio_noacct on the bottom device (because it was
> populated when submit_bio was triggered on it.
> 
> Hence, we need to fix all the kernels that were before submit_bio_noacct was
> introduced.

Why can we not just add submit_bio_noacct to the 5.4 kernel to correct
this?  What commit id is that?

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

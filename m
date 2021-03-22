Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952D8C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 15:31:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263AF61984
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 15:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263AF61984
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rm9eqlup4ZFOKvraKOJuzN7i1r/8uxxh0UnSpV8oQxo=; b=hoCdN25J0UkZs7+OU3D0PiFR/
	rDcqT8Muni8t4BN5muPzhdj6eJbkri/Ck+fGA7zkEpzBMZ3b5BUxjDu+nJMjltplNiZbJzitbHLvx
	oUIeLNr5ti+8XuNzwMrL4tfifi6wYLQGQ2nujf4mu4LQjMZgxUwR/dmkXvp9HkegTShIZfRFqNWLd
	ZuMhCHvFed7LkEtahvDuvyQeeH9mbJv7BXepoYf+4hI0+gwH/JPbhgCvry5+gUlUB5Gbgwxm0EC5Q
	Q3iZkTSF0dr4aCF/+53kQgmQpoqV+FyhQV+xwvu3A8SAOpXViMtDj0CAWX+Lqyqu5j2iH3RWU+PHk
	zbjKwxKHQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOMWM-00Btvw-GE; Mon, 22 Mar 2021 15:31:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOMWH-00BtvD-JX
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 15:31:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5526861984;
 Mon, 22 Mar 2021 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616427064;
 bh=zK5KKi4ATr3SmNmxLp2wyzhdt5icF3UWhPn8KlBQl/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DqJJnLrGTbKUp5bBsjDtKRY8LZtCMl+gjyDUCDvSH92FowEtQTQeRqWkDl+xNNuKF
 35qmMs/1A0BYa9MZ5yiXeJCp+d/Dk0LvGcDlF9nLML9mUhEQfQilN6/6LB1o5dEPpV
 hQKuXFJHEWSXfNzT5JbNzL+Xw0x0zrhsKtuBVViOdm8jKXLYiWK4orhsjmHajlCBVy
 pXr4jzV9/iO5MGGgyLQCFFA010gqghiLgBGV5HKFWTOeeAL1behlRN+jmlvi+jX47U
 ADKWzeoLZc/CVJveUccAWtA3Z5q49PjuL4VRpdJeVhr5YeY5jheZXARV46fH2lYP5i
 3AYaJTzz+08TA==
Date: Tue, 23 Mar 2021 00:31:01 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210322153101.GB17311@redsun51.ssa.fujisawa.hgst.com>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210322073726.788347-3-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_153107_184924_4BD3F25A 
X-CRM114-Status: GOOD (  17.68  )
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

On Mon, Mar 22, 2021 at 08:37:26AM +0100, Christoph Hellwig wrote:
> When we reset/teardown a controller, we must freeze and quiesce the
> namespaces request queues to make sure that we safely stop inflight I/O
> submissions. Freeze is mandatory because if our hctx map changed between
> reconnects, blk_mq_update_nr_hw_queues will immediately attempt to freeze
> the queue, and if it still has pending submissions (that are still
> quiesced) it will hang.
> 
> However, by freezing the namespaces request queues, and only unfreezing
> them when we successfully reconnect, inflight submissions that are
> running concurrently can now block grabbing the nshead srcu until either
> we successfully reconnect or ctrl_loss_tmo expired (or the user
> explicitly disconnected).
> 
> This caused a deadlock when a different controller (different path on the
> same subsystem) became live (i.e. optimized/non-optimized). This is
> because nvme_mpath_set_live needs to synchronize the nshead srcu before
> requeueing I/O in order to make sure that current_path is visible to
> future (re-)submisions. However the srcu lock is taken by a blocked
> submission on a frozen request queue, and we have a deadlock.
> 
> In order to fix this use the blk_mq_submit_bio_direct API to submit the
> bio to the low-level driver, which does not block on the queue free
> but instead allows nvme-multipath to pick another path or queue up the
> bio.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

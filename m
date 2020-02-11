Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09938C35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 20:27:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D788E20842
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 20:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qvSVdEti";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwWkZ903"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D788E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yoES8BrOw1I5hoUn/4c/fa76WZ6JDX9T2jrmuSbDt0E=; b=qvSVdEtic98Wyh
	6PRndtqWctWheDht4gY+KJjVSKf7nunXZ2Cl787wECISjeVcXkwXtVdFst9OLW1L1JnljHv0NICKP
	LWfgC4ewL0FsV4wvnYgmNJaKc9Ow4cJofjovZlCD2P1mpaCscmpkeb5woqAveFTdmhCMzNvIT0dP1
	GIb88ShdD8A6BxVQtBkTpZTBv6CKps6yRZa621BrIZ9pYtr3jpfTUkymZePnTGT7+0ml+T5OuO5Hc
	u/8y9HTdLI+F0awb/6JvlfAW6hGZqXFSDjlQECucZeNINK/Y8kYP1MJfOBvz78BcKZqLZSFDb5MlU
	VuyoqIuohDr98Y+trjSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1c8O-0005I1-1I; Tue, 11 Feb 2020 20:27:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1c8L-0005HO-Ac
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 20:27:50 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 17E1D20714;
 Tue, 11 Feb 2020 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581452869;
 bh=SYeFjNKVYAlILc7ZybWeJr4fddLcEhkbrTP12gmkvLI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TwWkZ903wyel2NgHFTM3ykNc4Gm4yqbRlHEpTxaI83wu6aQPRgquUbApQxvTayhNY
 jql60JFMO9bR2jDi9VAY/MUGFcrMVYJ5yuJm1EsZrcCmer9S0ii5gIMHgATEaaoHMP
 1qElbTxxWYpUQxmYL5mhSlOxBDgIgiUzfqN8GQZI=
Date: Wed, 12 Feb 2020 05:27:45 +0900
From: Keith Busch <kbusch@kernel.org>
To: Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH] nvme/tcp: fix bug on double requeue when send fails
Message-ID: <20200211202745.GB19458@redsun51.ssa.fujisawa.hgst.com>
References: <20200210183719.32410-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200210183719.32410-1-anton@lightbitslabs.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_122749_389870_0FF8FC9F 
X-CRM114-Status: UNSURE (   9.90  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, hare@suse.de, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 10, 2020 at 10:37:18AM -0800, Anton Eidelman wrote:
> When nvme_tcp_io_work() fails to send to socket due to
> connection close/reset, error_recovery work is triggered
> from nvme_tcp_state_change() socket callback.
> This cancels all the active requests in the tagset,
> which requeues them.
> 
> The failed request, however, was ended and thus requeued
> individually as well unless send returned -EPIPE.
> Another return code to be treated the same way is -ECONNRESET.
> 
> Double requeue caused BUG_ON(blk_queued_rq(rq))
> in blk_mq_requeue_request() from either the individual requeue
> of the failed request or the bulk requeue from
> blk_mq_tagset_busy_iter(, nvme_cancel_request, );
> 
> Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>

Thanks, applied to nvme-5.6-rc

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

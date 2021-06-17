Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B8FC2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 08:11:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C0261159
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 08:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C0261159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MOAd7N23OZQ3oKpLHmuLMSWUfJyNqadoXZHMMMQ+1Ac=; b=FQ/hCQmrTvdiId
	xYcfKn/9xjT86pLvvhCKCCT96BY4W7QYxe4zxaPudDRPD7WVUH1rP3710DNg5a1nJIn/AxSnOM1WN
	heeiHd3dehIoAuYvC+TB2IJZAEe7RXE1a0GY8PzkJzxN0yiG8Su9LvAvpHGKJEgj8bIBc0EdceGPL
	Vc+PKcy9/Ja7ZZA23iWeXqCKwz6qxF1L+P5JXxA+U8xxONejQ89OQKrwjoxS8tbYzGcrEJwTV+pa9
	NZLYT1rccg04K4pYvBGJKmvVBNgICUqZ2YM8c06qLWoWZ4Oub6lDyUL6Rqeze0UWupJl9mxkTHCM9
	45H9hW+telCYC9MMV5yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltn7c-009ROK-8E; Thu, 17 Jun 2021 08:11:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltn7X-009RNd-4o
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 08:11:31 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B536921AEF;
 Thu, 17 Jun 2021 08:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623917485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oJJ0CO5Q1FGyG3YtbMnt0bCNSE58UBDtdtEIINkqL4=;
 b=epjzBqnjqDwWPpbyeetBF6YZlowatzr3WNPLuLYgdLB9QVAGuZddnQxUcUvuA6p/0vpksA
 aeIfgUH27+KN5UgSZhdlFL9tgYdPH2ctwC+EJWhIDQLKZM07bFtD4Wy6wrIvfe7fFQaYSw
 ckoxvlr0i22adkM07y4KGYr9Xg2JIog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623917485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oJJ0CO5Q1FGyG3YtbMnt0bCNSE58UBDtdtEIINkqL4=;
 b=fxdXJbar6rfMfZFKHhP1k57/F/RqP8MSeoQimBnFgiBl1IuYnu0LoFyO+fzCC+VRv5FfU+
 VQlI9F13avM59xAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 9AE66118DD;
 Thu, 17 Jun 2021 08:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623917485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oJJ0CO5Q1FGyG3YtbMnt0bCNSE58UBDtdtEIINkqL4=;
 b=epjzBqnjqDwWPpbyeetBF6YZlowatzr3WNPLuLYgdLB9QVAGuZddnQxUcUvuA6p/0vpksA
 aeIfgUH27+KN5UgSZhdlFL9tgYdPH2ctwC+EJWhIDQLKZM07bFtD4Wy6wrIvfe7fFQaYSw
 ckoxvlr0i22adkM07y4KGYr9Xg2JIog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623917485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oJJ0CO5Q1FGyG3YtbMnt0bCNSE58UBDtdtEIINkqL4=;
 b=fxdXJbar6rfMfZFKHhP1k57/F/RqP8MSeoQimBnFgiBl1IuYnu0LoFyO+fzCC+VRv5FfU+
 VQlI9F13avM59xAw==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 0UnOJK0Dy2DGHQAALh3uQQ
 (envelope-from <dwagner@suse.de>); Thu, 17 Jun 2021 08:11:25 +0000
Date: Thu, 17 Jun 2021 10:11:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 3/4] nvme-tcp: don't check blk_mq_tag_to_rq when
 receiving pdu data
Message-ID: <20210617081125.ufn6ldgzzhzy6grn@beryllium.lan>
References: <20210616211936.451128-1-sagi@grimberg.me>
 <20210616211936.451128-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210616211936.451128-4-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210617_011127_375097_522224B4 
X-CRM114-Status: GOOD (  10.59  )
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

On Wed, Jun 16, 2021 at 02:19:35PM -0700, Sagi Grimberg wrote:
> We already validate it when receiving the c2hdata pdu header
> and this is not changing so this is a redundant check.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

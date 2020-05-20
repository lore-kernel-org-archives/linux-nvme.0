Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772E8C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 07:03:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D6220756
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 07:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gpqH2qNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D6220756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3IKB3oHoAI73m4tpMghyzuT7hShuh3RZOkvfMzKu2jM=; b=gpqH2qNOrTn9w2
	G4EFmYX98UiGc+HpnuwlXrpb/E+MzumWHsengtptkfasWI/eloaUJIiOIOxdpHX8w2kkJ8GPa7bPk
	3hXtAXqOCm10XXGiV7xBARe1W8dgHaAgj+3/842Fwkd1IEaA3CQF+04ne+3+Ofmb4Td2sSUPbbQxn
	py7m5QiQIBHbfOjvB2xmKh4SKP+uleVpNqSkDpX2LJlCbImGVmNNUTSRU0OQtmM+E2Kbk/0Hn4uCP
	0hVsLEYpSDe3XrCxUBuZETSbzjFTPTw68Kaxg/9XHsjNKQwh48cQ/G00rpc9ktVvQ3HkPxDgQQP6D
	1YktkpnaL8mxwQ1ADhyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbIlI-00077u-6M; Wed, 20 May 2020 07:03:32 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jbIlG-00077c-Qk; Wed, 20 May 2020 07:03:30 +0000
Date: Wed, 20 May 2020 00:03:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining
 aens in nvmet_async_events_free
Message-ID: <20200520070330.GA26871@infradead.org>
References: <1589828396-144513-1-git-send-email-dmilburn@redhat.com>
 <1589828396-144513-3-git-send-email-dmilburn@redhat.com>
 <388242d3-5ccc-d694-c7a0-ac489f63f26a@grimberg.me>
 <20200520061613.GA18308@infradead.org>
 <0018af56-e3f9-8730-3c57-c4f19e478014@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0018af56-e3f9-8730-3c57-c4f19e478014@grimberg.me>
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
Cc: Christoph Hellwig <hch@infradead.org>, David Milburn <dmilburn@redhat.com>,
 linux-nvme@lists.infradead.org, dwagner@suse.de, chaitanya.kulkarni@wdc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 19, 2020 at 11:59:25PM -0700, Sagi Grimberg wrote:
> > So when the host usually only has a single aen command outstanding (like
> > the Linux host) we might start having a pretty long list on the target
> > for a while until all the roundtrips to deliver them have been
> > completed, and if the admin queue gets shut down during that time we'll
> > need to free them.
> 
> That's fine, but why should it do that in the process loop?

This patch doesn't touch the process loop, it is the free loop when
destroying the admin queue.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B92C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:02:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF102078D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s7FvtDw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF102078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3MuMS/xuhZm0oMIi3Em7DVffXJwXBQaAMocKEQfV1qA=; b=s7FvtDw+IDc1qEzkb8dYEBt4k
	qET512kpuMEWzpSNL5AAY4OFPlL+eJnb0wFZa+PmX331jQf+AEWF3UMpmYqkuqs6bQuE8mXtoX6Ee
	FBQ6j7NBs88hyqKuY/HrNgQOXGJ161hQ27/+tZzllaeAY/52WTFNNgf1IYZZYfoQ/ESPi3kTUMEPx
	BJoiHUn7wWdQFpYf0vPuIqsE6qYBKJU8oADfCwTW8tSzO3wJKUx1frLoPIA6Mj6OltEsplamJDjf7
	oCzwg5ZqtnXf9OVfwJ0FD9Dpyj9sJmc4tPJjsxUafdCaZH/ghdwFCEb9JFAOoAFKI/3nRZuM7d+CG
	QwqUGG3hw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8deS-0002pR-L0; Thu, 20 Aug 2020 06:02:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8deF-0002jN-1o
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 06:02:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7685468BEB; Thu, 20 Aug 2020 08:02:00 +0200 (CEST)
Date: Thu, 20 Aug 2020 08:02:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 1/9] nvme-fabrics: don't check state NVME_CTRL_NEW
 for request acceptance
Message-ID: <20200820060200.GA6188@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200820053651.197057-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_020203_277454_63E5AA48 
X-CRM114-Status: GOOD (  12.76  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 10:36:43PM -0700, Sagi Grimberg wrote:
> NVME_CTRL_NEW should never see any I/O, because in order to start
> initialization it has to transition to NVME_CTRL_CONNECTING and from
> there it will never return to this state.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

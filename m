Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0268C3A5A7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 12:47:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720D721883
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 12:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cLcmudeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720D721883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pTN0XSdprwhcIF6cIwsLsQd3A8VWR72uXyMCCzl/fvU=; b=cLcmudegNfThPi
	dqjEa624wSelbVCVnnlMtJIcQIcsf/10GCRDmlbrgz204C6krl8c3akEWpH3cCeALyA3K6eZ9PhjR
	wMeTi+FoJ2NzykieW64fE6CE3ZqNVCpxG2W4FvmXsfqITSfs4xsAyyEn5hE3+nLGfQsE0gXBreWq3
	hV6ZRCRAicEujvUhAVufwfkUQ33QDG/610bB/6QcCjlCYJ0Pd1V9k62bM8YCh8q7oTN9Q2WyCibCH
	mOVQojc8b41c9HuGzdOhRAA0Dv193Fk5GXm5qNoo9RkzzJaTwoR2miqZ0tFkEksaQ4j+1jpv/9QHK
	Jzer+JvPqbaoObKDsAnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5Ugd-0003WS-7Q; Wed, 04 Sep 2019 12:46:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i5Uga-0003W1-UZ; Wed, 04 Sep 2019 12:46:56 +0000
Date: Wed, 4 Sep 2019 05:46:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v2] nvme: Treat discovery subsystems as unique subsystems
Message-ID: <20190904124656.GA13452@infradead.org>
References: <20190903212037.29705-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190903212037.29705-1-jsmart2021@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 02:20:37PM -0700, James Smart wrote:
> Current code matches subnqn and collapses all controllers to the
> same subnqn to a single subsystem structure. This is good for
> recognizing multiple controllers for the same subsystem. But with
> the well-known discovery subnqn, the subsystems aren't truly the
> same subsystem. As such, subsystem specific rules, such as no
> overlap of controller id, do not apply. With today's behavior, the
> check for overlap of controller id can fail, preventing the new
> discovery controller from being created.
> 
> When searching for like subsystem nqn, exclude the discovery nqn
> from matching. This will result in each discovery controller being
> attached to a unique subsystem structure.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

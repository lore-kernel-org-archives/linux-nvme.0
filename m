Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F9FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 08:07:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAA120679
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 08:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YcxjeJcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAA120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mx2DCQ1qGRenEo1Z0ECb3zqSyhxrACM30V/n4F807ak=; b=YcxjeJcBn9i1uw
	QIfIIfbOVcje/YnNtDHOkZi4hW19fOtxHIWbmEDPu2inZ6DeRBe7lTddUqMSGod6fFlXY88ETpM4L
	VA5vmXpuSVIBSCDs5Yti+hcGiEyZ+DW5WskwkNUkt5wQlx0Eh2tVkX7U4zA7w9KloINpGt0Hl/Jvs
	8+DxMwLPW5pasu9dH+RD1HPJzDqf2P/ttn0DmwEX1MM9K3I4ZsuoQgv+SRC4VgdKJZ8qZxwBh/KVt
	7j5aXKYBfOwUuz0EjBI3cA620VfDrof8Ssm5jopb5JMLkVIKPevYhwZiKOgqekbV1piFBULOL/5hx
	asobrKXAbzSYc2/93hOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlT6H-0005iz-Lz; Wed, 17 Jun 2020 08:07:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlT6B-0005g8-Tp
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 08:07:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E3F5368AEF; Wed, 17 Jun 2020 10:07:05 +0200 (CEST)
Date: Wed, 17 Jun 2020 10:07:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: use unsigned type for u64
Message-ID: <20200617080705.GC14863@lst.de>
References: <20200612011659.11247-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200612011659.11247-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200617_010708_119976_08A8DB1D 
X-CRM114-Status: UNSURE (   6.39  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 11, 2020 at 06:16:59PM -0700, Chaitanya Kulkarni wrote:
> In function nvmet_subsys_atte_version_show() which uses the NVME_XXX()
> macros related to version (of type u64) get rid of the int type cast
> when printing subsys version and use appropriate format specifier for
> u64.

Applied to nvme-5.9.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

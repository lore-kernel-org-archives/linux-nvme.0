Return-Path: <SRS0=aIMh=YK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6FCFA372A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 14:51:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CCD21848
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MbxQx+9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CCD21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JlRe79a1XwlHyX/tBz10lhpYSv7J/PiZumcTw4ksqVM=; b=MbxQx+9axYCVup
	25WtxCPHYnqBZf97Z+2FlqPq/jG7wrnyBWEIorYqVtucFD/uruGuaRp4m3mI//77/l8RgtJYPKG9V
	uU4d27WRigFU9CQ5WAqLIQa+3/DEgovaKQtKESVh/XB/Z2BFB+qGtlvZOqtU30yuO9rKhKzVEnbec
	oSiYAOuIjJS9hS8T7T5N9S8PUk7iFd4z4fldlu3BNdvYl7PG3tZ5li2Ew02XWKY9trlQcxwIdxX9B
	zWfPhiI8KMXNigjqNZGigy52NdEVhpXKC2MgT4uUogAL+V3OUWgYj6oazvKmNrRmMokYKChsEotE7
	NldEHoZrdOsygMHCGEgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iL77H-0001pZ-4D; Thu, 17 Oct 2019 14:51:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iL77D-0001oy-VW
 for linux-nvme@lists.infradead.org; Thu, 17 Oct 2019 14:51:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E845D68BE1; Thu, 17 Oct 2019 16:50:54 +0200 (CEST)
Date: Thu, 17 Oct 2019 16:50:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH] nvme: check for dynamic controller model before
 verifying cntlid
Message-ID: <20191017145054.GA8622@lst.de>
References: <1571257402-15747-1-git-send-email-dmilburn@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1571257402-15747-1-git-send-email-dmilburn@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191017_075100_166335_95B894AC 
X-CRM114-Status: UNSURE (   8.01  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 16, 2019 at 03:23:22PM -0500, David Milburn wrote:
> -		if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
> +		if (id->ctrattr && (ctrl->cntlid != le16_to_cpu(id->cntlid))) {

Where do get the all-Fs cntrlid?  Identify Controller should return
the actual controller id, and the fabrics setup code also sets it up
to the return value of the connect command, which shouldn't be all-Fs
either.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

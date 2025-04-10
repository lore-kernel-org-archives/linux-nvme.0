Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25839C369A4
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QRgwiTR9ajSt/Tn49SdBBnmH8V3/HKjFxElhbT0y5AE=; b=kMoJdX0nu8kGCK5AwnY6O44luk
	SZuFfDtSgkJTuY8IQ5rX77ZJ0kjqb6NPSePuIPPBWeNmM7aV3f3332rGRgAXfobkVt0rwzG+V7jXj
	4PWh1rqwUvQEHS+/SoOidHFgraMn53ef/2/upf+5rSObRAAahbTFhLGO5LVEt0qjmL8M+AIaO6dGv
	eqV6XV6sTYSYNejSCtBu3WbbqS2fL871ObhulO6bOXWOEqeyHYokZxAzHqpswxAjV4t2TAIc4P1og
	IV/FEyobZe7xPJEhHNpyJ+RJjbp6UDZ2GopUG9odM5UqKuRE34mcmUBE7yiHx05kXTI4cP0jUKw68
	TnybVgEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2njD-00000009px4-2ME1;
	Thu, 10 Apr 2025 08:57:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nKr-00000009lD2-3og1;
	Thu, 10 Apr 2025 08:32:33 +0000
Date: Thu, 10 Apr 2025 01:32:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
Message-ID: <Z_eCIQ5dtv9oKd9X@infradead.org>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
 <Z_Y4TFTqriOTxXsO@infradead.org>
 <23d2c5c3-0832-4b62-a151-74a021c63201@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d2c5c3-0832-4b62-a151-74a021c63201@nvidia.com>
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

On Thu, Apr 10, 2025 at 01:33:38AM +0000, Chaitanya Kulkarni wrote:
> if we stop supporting AWUPF and move to NAWUPF then will it break where
> exiting controller's that doesn't support NAWUPF but only supports
> controller wide AWUPF, IOW NSFEAT bit 1 == 0 meaning per-namespace
> atomic info is not valid ? [1]

Yes.

> Looking at the spec NAWUPF values can differ for namespaces attached
> to the same controller and those values can also differ from
> AWUPF ? [2]

That's the whole point of NAWUPF.

> Perhaps using the minimum of all AWUPF and rejecting any ctrl which are
> lower than the initial value is right fix ?

That's what I mean in my previous mail.



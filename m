Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A5FCD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oBU8bex7BwXKoigjEfRgzLAERNl2gZQHMt6lSYvFw6Y=; b=FQvbPxEIgjMJfoXSFK9Kt/+eW5
	vMEtetwa+d4iuAyPhLwh6GnJkfEuZ9HPTmkEYHkRPtb3m6z+SBL12jgKIqQagoWkMsYNOUOKCICxv
	LiH9AGG26gQeVCUUI8gomEqGBGr59+fZlwPG07mf0dSQad7uCwc5YkulK+SkaKgWXbu7UYDYBG6b+
	3sk/cBnCvD35+ixuzu5Afsn0ZOPkdQ2wa2HLrlB72MdNI+XhEpX7ZLgA3HLmlnmF5j8RojCjyLt/v
	g7WgUkj18CaAQoVhw+Oiy14SmD9s1UaK33oaSrtnDeHNMNMdAVa2x1520B8eIKKGw2nnKfS1dJkGv
	dHdPyT1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUM9t-0000000CkI4-2Z3d;
	Tue, 02 Jun 2026 10:15:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUM9r-0000000CkHh-1NcG
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 10:15:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F16B841753;
	Tue,  2 Jun 2026 10:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18551F00893;
	Tue,  2 Jun 2026 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395338;
	bh=oBU8bex7BwXKoigjEfRgzLAERNl2gZQHMt6lSYvFw6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lKiG/Svc5LXFn2OZLn+bdAliQuPbUcnIEhwlrj45+Qel4ZLEgkf9z4MwhOS5AJfRz
	 wtGmUTRMByg/y98JfzKELqLNNT49xD+mc1gWdaM0Ns5nOhZepS6h3sJoXcDVWIT+G2
	 +fhLaGhCq+Rpvx1ZxV/2QwHb8vJS0qMn9ynzs9auNnSz3SIi0SKmKcqXbea8q3sopZ
	 yUUp3cmOVJBh66Kdlx7vUe3EgF6LsKv2IIFz27ajdh/YmKnN5yya3PU/s0bjYNMn2g
	 9ezLbxalLy6IdhpXF1V0Z2GslhtdYVsQOTf1W7Evc4jUNqnzoi6cjzJYfGfVpVm7Tl
	 ZLWFp4El3RFtg==
Date: Tue, 2 Jun 2026 11:15:33 +0100
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: pass NS head to
 nvme_mpath_revalidate_paths()
Message-ID: <ah6tRc93diVuvc4O@kbusch-mbp>
References: <20260529095201.3803100-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529095201.3803100-1-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_031539_389493_D63819B5 
X-CRM114-Status: UNSURE (   9.83  )
X-CRM114-Notice: Please train this message.
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

On Fri, May 29, 2026 at 09:52:01AM +0000, John Garry wrote:
> In nvme_mpath_revalidate_paths(), we are passed a NS pointer and use that
> to lookup the NS head and then use that same NS pointer as an iter variable.
> 
> It makes more sense pass the NS head and use a local variable for the NS
> iter.

Thanks, applied to nvme-7.2.


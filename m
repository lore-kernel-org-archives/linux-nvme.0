Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9A6D74959
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 13:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=heyXYCVDOqAIVURkwnfWf9hDq+29vxEVXLgGfUjcSIE=; b=oiupj4sDbJORy2a/t5ztZ7sEWC
	OulsWRgbBVOMshqMViD0QO6NqMpG8fwI7oKQVmM2PzSY1bJaqutSeWb1na+XnIa0xFz3pJbeKJjt6
	0IYZi8kKDpyDOnU/v4XHDFmvP3EkteiZpFqEtynAJJQx1HhSUK32IbaCaXwZYLuEhG8Uu0+zFkYNE
	S0Xx9qYkShSI69gBUH4kyAtbWmqoSuQzV7SMES6HP8CG6uGPMRYU0qiUawIWHalAzlrpJaFfLenyd
	bKL/ffNduV9OL+w/5vTVcwdLY3XwC2T+VbddpYzPX1Er6EbtvXa0EUOrAgU+6dwtVtAm9itFAPOAb
	ebBjSumg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6UvM-00000003dTE-2zZX;
	Thu, 31 Oct 2024 13:09:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Uhn-00000003bin-1IIA
	for linux-nvme@bombadil.infradead.org;
	Thu, 31 Oct 2024 12:55:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=heyXYCVDOqAIVURkwnfWf9hDq+29vxEVXLgGfUjcSIE=; b=RH3t5sDCf80/hait4wZkuEdJ31
	RuyCqiu9jBFOunsUePi9r/nq9s8F9bBXYoQUksKLBJUWZfD0YvGFqPAnutockuxqJvyFLo2aLkbY6
	WqPdrw+ia4klwUXIvo2tDvP9m58Pojr2qvbTEhlNtS+TNoUWLuh7E5Tm6g6mThyyjSmZkA91VoXIp
	PDtubLYFNoSWy0cpPQE+y0PLTH4Qws6rb1WUtwxRgkq/Jn+YYJ6cIbC3j6JoNS7/9jHuP15ZdXhB6
	n2xNcya52F6IwoelV3fjwOSfP6ta8NVq2J5Ig8GDzNZg/Tzkmr9wZ+TWxKaE+tmlIbw84fv1HR0C5
	wRsWbnLg==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Uhk-0000000ASrp-0dSH
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 12:55:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 464C0227AAD; Thu, 31 Oct 2024 13:55:02 +0100 (CET)
Date: Thu, 31 Oct 2024 13:55:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: check at least one ns identification reported
Message-ID: <20241031125501.GA17520@lst.de>
References: <20241031103803.55219-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031103803.55219-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_125512_431221_0FED9062 
X-CRM114-Status: GOOD (  10.70  )
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

On Thu, Oct 31, 2024 at 06:38:03PM +0800, Guixin Liu wrote:
> Per 2.1 base NVMe spec:
>   At least one Namespace Identification Descriptor identifying the
>   namespace (i.e., NIDT field set to 1h, 2h, or 3h).
> Check there is at least one reported.

NVMe 1.0 didn't have any of these identifier, so it's unfortunate
but perfectly valid if devices don't have any.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C512CC4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pCd4lFCDaZ7PiW4wTVqQ114lN6MT9ckyByeLpH+GFAw=; b=3W8N7ZFZ4oCRfNlGW4xJHeyy19
	vn2YXjpHsQhW5iKK85th7RWgnsKyILbyooRwPhsyAi//e7HUTFpMJ6VaJSqZCWuiCEZMpICBxwUYT
	xpLiVEL3iLcrWuAWNKxZnrfubO1GaAR5K2tqsX5sDs85j7LLEG1W6FBOo6wcaYBz/jCxwJkjEA/eO
	yfgn062/eidqHML3+xng9H21ZlJaRb1aSR1CtnNB+IOf00pkQTiOHaurlZb/BhFhGVrm4btgcIm4D
	/S+X3Xr/rk6afSW5fXvsjekFe3Vs0Oxk0LR12NpWMgA91iPsHo5w8CH5JUJI24iwu3fTFShW0U3pL
	5zCBuwlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8pW9-00C33d-35;
	Thu, 30 Nov 2023 22:28:21 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8pW7-00C333-1w
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 22:28:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 2DEA8B84621;
	Thu, 30 Nov 2023 22:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1186CC433C9;
	Thu, 30 Nov 2023 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701383297;
	bh=pCd4lFCDaZ7PiW4wTVqQ114lN6MT9ckyByeLpH+GFAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AS7PKpoxuGooLU3MtdgH2+Ev7ToehwgZt0qBOOQByGtOGBmJFJ++fB7vmlRlERSiz
	 fKZdJsJhS7WefOPmAljGpHWBQPlS3ErIcfVOtscafQa77EAtcURW2/B6DKTstKDT6i
	 BKWnFfcIhIA1VZRMqGntHFSfbFziQa7yhV0CtYUIMa92dz38S4lyfzNXLIEtdEY/Os
	 tOTKwCQOuAnJn+fbRlUkc9a5SbrSOC2C5uKZxGg79hId7MwTptzEktgsBqDSNA9M8e
	 PZ1GNEQZzyzoPtLnxkkr4oitCvy66rCfF9MHZ0fzZpJF0PkQYprC0jknftxR3YXA0K
	 RONGnOK6Dq81g==
Date: Thu, 30 Nov 2023 15:28:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: sagi@grimberg.me, axboe@kernel.dk, hch@lst.de, kanie@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
Message-ID: <ZWkMfqF_VociudNB@kbusch-mbp.dhcp.thefacebook.com>
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
 <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_142819_794724_C392B3D5 
X-CRM114-Status: UNSURE (   8.28  )
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

On Thu, Nov 30, 2023 at 10:13:37AM +0800, Bitao Hu wrote:
> Fix by marking the ctrl with say NVME_CTRL_FROZEN flag set in
> nvme_start_freeze and cleared in nvme_unfreeze. Then the scan can check
> it before adding the new namespace (under the namespaces_rwsem).

Thanks for the detailed explanation. This looks good to me.

Reviewed-by: Keith Busch <kbsuch@kernel.org>


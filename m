Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E6CD5D689
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jT0Ck2inap7/eeTD4kBRnDW0NG6dYcWHqzKJI5qP70g=; b=op8yRWN+DN/clFDM60YgBQCskA
	Bs6egMApNNmiJB4rBfUIIeGGFlePaDQSelK8h+6g7YN2M/hJvsF4/uCtvGJaZCzK3JYzkz7KRjfKd
	fcjgGIUJ/5gnUssd+5EvKSlG4KTFba8jCyREZjsUDQ42SakoeonX3GgvC1Zn+jReFxkgcmAD2YkAD
	it9D1ecsWNLaFxlnHo3ZcNEdgr7wztzzzlK2Hc0o3jGiGNIBVmBE+Ezu16PKJauM2rN+kk1g3kglg
	F76HF1QjbcDcxN9IzK6YFVzwgilqXncQyZKZuVIMxEpvgJ5FGda8VVTpWcsc+sEAQPxw4z2qQ+sd3
	fcCklMaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t99FD-00000008GaR-1NUY;
	Thu, 07 Nov 2024 20:36:43 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t99FA-00000008GZd-03rg
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 20:36:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5E7BAA44AEC;
	Thu,  7 Nov 2024 20:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F519C4CECC;
	Thu,  7 Nov 2024 20:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011798;
	bh=pUEWBNk0QMyHT4XDwDxz52gT2AwKmMAH9IEJoyAd0F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEAbv3jyMcWY4wh1wsdT5LnVCt8LHbJxzO5I+Az9vZZPaYZ/22HoAlAHlhMz0VrTf
	 semcWRb3HO5dRteq9GX5T5DUXdmnZdysyPqYo0Ex1bz/sfh6dQXyrvtY/tI622GIxq
	 +1bSmk5rqs7I0uG3MFP/tqgMQCK4iZEgwqUcwSc4Py3qq3kPDETGwS+6bsEH4X9i15
	 rgyEj9bH3LyJuc0RDsFSQlbJYVIzEgAFQzXEOzADFPbmKFHhA1+KHMia7BUVdqz+g8
	 BSUJxfBVLOfWfLecJXwwlOes7EGYdpVaMYM2O/vFYn8LwH1zv2ZJJ/IzWAfbQZ7G3S
	 rAZUuj+bi4g7A==
Date: Thu, 7 Nov 2024 13:36:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <Zy0k06wK0ymPm4BV@kbusch-mbp>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241105155014.GA7310@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155014.GA7310@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_123640_137558_DFA68068 
X-CRM114-Status: GOOD (  10.80  )
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

On Tue, Nov 05, 2024 at 04:50:14PM +0100, Christoph Hellwig wrote:
> I've pushed my branch that tries to make this work with the XFS
> data separation here:
> 
> http://git.infradead.org/?p=users/hch/xfs.git;a=shortlog;h=refs/heads/xfs-zoned-streams

The zone block support all looks pretty neat, but I think you're making
this harder than necessary to support streams. You don't need to treat
these like a sequential write device. The controller side does its own
garbage collection, so no need to duplicate the effort on the host. And
it looks like the host side gc potentially merges multiple streams into
a single gc stream, so that's probably not desirable.


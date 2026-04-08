Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B801073CBA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJ14xyneL5A9/L/KrHb5BAjljVMrFlgO0kngOi7YGhg=; b=2mtPHl9eegt1Ztv/PnZYcBd5ip
	CBlR7MhJkV8I60bR6nOUKVoWoHJjDpIlo+0Q16+vBtDi+y2NZcVq6GER2g1aR2iPGw+O2TrFpM6AV
	WY9i/DWiJMXH9f60s3GXd2pvm3msBxiIu0DHndRCxWyTjYCECefV/0RuEAMKWX17sKMbVfZatxnFw
	NYe5ot92sZJk3BBmckZCMhPn+qJ02RYXDyZd3MQuFUbL2QobUGd4ysGV0Vh57IyWtbdJx8yAQyeKp
	8xbjkpfaQ+Is58eJxR591qYMZS45qwdRTUuZkORYItgrt3mdkaC84xYQoh0Iezc56s/iTYDMKh9V/
	lrWsOOUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wATPR-00000008xEg-0pwz;
	Wed, 08 Apr 2026 13:57:33 +0000
Received: from mail.ispras.ru ([83.149.199.84])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wATPO-00000008xD6-0ceJ;
	Wed, 08 Apr 2026 13:57:32 +0000
Received: from localhost (unknown [10.10.165.28])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6458F45F7982;
	Wed,  8 Apr 2026 13:57:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6458F45F7982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775656641;
	bh=qJ14xyneL5A9/L/KrHb5BAjljVMrFlgO0kngOi7YGhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmlW33VMXV1fxuMduQyfKd1YopPc90ric6gVZtN8/MtzyTmT7hA/12yHEKyW1oLlX
	 Rm/fW5KNwOotqi06xyokYUUgPvmrbux3uR0Fn4rPVOyeT5DnOezrLCrc+00EeTI9JC
	 m+75ccAjcoRNXJFQoVV4IwxZmYPhn0I4pBdPPMTE=
Date: Wed, 8 Apr 2026 16:57:21 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Heyne, Maximilian" <mheyne@amazon.de>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-apple: drop invalid put of admin queue reference
 count
Message-ID: <20260408165531-2a55fd1a87a2369d9a5bea2b-pchelkin@ispras>
References: <20260403202701.991276-1-pchelkin@ispras.ru>
 <8143e057-4c3b-4365-8780-003e897b9baf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8143e057-4c3b-4365-8780-003e897b9baf@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_065730_693427_A0342AB0 
X-CRM114-Status: GOOD (  10.38  )
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

On Mon, 06. Apr 20:20, Jens Axboe wrote:
> On 4/3/26 2:27 PM, Fedor Pchelkin wrote:
> > @@ -1269,8 +1269,6 @@ static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
> >  {
> >  	struct apple_nvme *anv = ctrl_to_apple_nvme(ctrl);
> >  
> > -	if (anv->ctrl.admin_q)
> > -		blk_put_queue(anv->ctrl.admin_q);
> >  	put_device(anv->dev);
> >  }
> 
> Could this just be:
> 
> static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
> {
> 	put_device(ctrl->dev);
> }
> 
> at this point?

Right, ctrl->dev and anv->dev point to the same device.  I'll simplify in v2.


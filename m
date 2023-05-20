Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E5EC77B7D
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 04:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSUeOTZAffF59T3jGSt/Qwrj01b3ZeGJAbfyxu27A9k=; b=T7V5I58b4e+SukvSgZPEwQxgZz
	YZ2AauvCD8nj+82VqxSwzL2DCCRdfyyKsy+xRppDtpbrqUhWVkdagnIBKDJCNQfelQlgMnzzas8mp
	EEROUJgvHXur2fRtUfcaGpSCFDzXwoL9Li7PzwCzsHnrG0dqxvCHitmq9hh5LBQApnJoTON8WHAJG
	nPvKh1jskES8XjycssNoDVPA/bw8wXZPPxMW9s53er227tpjfWU2Xo7aQhPqxEhO6fqj75oJHY+aX
	KQ5SVIk+zzXis2zlAqc5doqNGYDLF8kLxGsXsmP+6gamV/VZ4aNYO9YUah9S+PQ4FugkLA55n6iZJ
	6zy+7Keg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0EDC-000fsi-1g;
	Sat, 20 May 2023 04:28:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0ED8-000frE-2m
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 04:28:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71D1468CFE; Sat, 20 May 2023 06:28:51 +0200 (CEST)
Date: Sat, 20 May 2023 06:28:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/3] nvme: double KA polling frequency to avoid KATO
 with TBKAS on
Message-ID: <20230520042851.GD31780@lst.de>
References: <20230518183311.3224326-1-ushankar@purestorage.com> <20230518183311.3224326-2-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518183311.3224326-2-ushankar@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_212855_066587_228C41FD 
X-CRM114-Status: GOOD (  13.87  )
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

On Thu, May 18, 2023 at 12:33:09PM -0600, Uday Shankar wrote:
> + * 
> + * When TBKAS is on, we need to run nvme_keep_alive_work at twice this
> + * frequency, as one command completion can postpone sending a keep alive
> + * command by up to twice the delay between runs.
>   */
>  static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
>  {
> -	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
> +	unsigned long delay = (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
> +		ctrl->kato * HZ / 4 : ctrl->kato * HZ / 2;
> +	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);

Kernel coding style wants an empty line after the variable declarations.

I also find the style rather hard to read.  Why not:

	unsigned long delay = ctrl->kato * HZ / 2;

	/*
	 * When using Traffic Based Keep Alive, we need to run
	 * nvme_keep_alive_work at twice the normal frequency, as one command
	 * completion can postpone sending a keep alive command by up to
	 * twice the delay between runs.
	 */
	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
		delay /= 2;

	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);

That's not quite as dense, but relaly gets the point across to the
reader much better.



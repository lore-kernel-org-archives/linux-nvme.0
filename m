Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DDCCCD199
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 04:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PBj6uwlf3OxrHBQ51Ennq9FbfR969DR95xAKrSAVDk4=; b=tTkdBAK+0XzlEIYKvMLyUejn1r
	w+JHoya0Bkq7ekN/fiwmnCbeoZHggy6hdB1pTcTtTHbocuWPywJ2Hk6Rt9dhMIfNI/2smUBwtssr6
	JSJ31mDKXEebvF30zpagtJmQ1l4+SLaZAo8hz99nlzYpYI4S3FwCnlcaf5GoOs1O71Qcw+tQqMpG3
	9fQCDOeRA2PqcR+GwtbDq7cjUZ8IcVYxWNpnzvbD1zl5HbEIuLsFRwZCgVEkeQCoguR0K4vUqO3wh
	3JY4hP7Tp4p/mK1Qy1vDEkCSTIfbGD0R1LjpjDEj30iUKS0QHRloWHCUj9zCHtWgH8weGQ/sEEvxn
	T6sfKuFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c6O-00000006XcJ-2kNZ;
	Fri, 17 Oct 2025 04:30:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c6L-00000006XbW-31Pg
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 04:30:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAB54227A87; Fri, 17 Oct 2025 06:29:54 +0200 (CEST)
Date: Fri, 17 Oct 2025 06:29:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
Message-ID: <20251017042954.GA30271@lst.de>
References: <20251017042312.1271322-1-alistair.francis@wdc.com> <20251017042312.1271322-6-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017042312.1271322-6-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_213001_926410_163C085D 
X-CRM114-Status: GOOD (  20.41  )
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

On Fri, Oct 17, 2025 at 02:23:10PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
> on an KeyUpdate event.
> 
> If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
> 
> This patch allows us to handle the NVMe target sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

Totally independent of the current Link-tag flamewar, spec reference
should be in the free flowing commit text.

> +	if (result == -EKEYEXPIRED) {
> +		return -EKEYEXPIRED;
> +	} else if (result == -EAGAIN) {
> +		return -EAGAIN;
> +	} else if (result < 0) {

returns do not need and should not be followed by else statements.

>  		dev_err(queue->ctrl->ctrl.device,
>  			"receive failed:  %d\n", result);
>  		queue->rd_enabled = false;
>  		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +	}
>  
>  	return result < 0 ? result : (queue->nr_cqe = nr_cqe);

Also the overall flow here, but old and newly added feels really odd,
up to the point of intentional obfuscation in the last return line.

I'd expect this to be more something like:

	if (result < 0) {
		if (result != -EKEYEXPIRED && result != -EAGAIN) {
	 		dev_err(queue->ctrl->ctrl.device,
	 			"receive failed:  %d\n", result);
	 		queue->rd_enabled = false;
	  		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
		}
		return result;
	}

	queue->nr_cqe = nr_cqe;
	return nr_cqe;
}


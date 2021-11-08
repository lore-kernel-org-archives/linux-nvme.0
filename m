Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA96AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 16:45:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A796120A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 16:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93A796120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1vUPSTKlLkdU/pTPV1MbYUUsTvn0tPIgV83Bq2cIgs=; b=ESbQg49Hs+eX/ZgBwloD/E/5X/
	ywO0ogGK6HtmNjtp7UltoRE0bTCFspHHAUGkxT/p+KNapIDG0EAkQb1mzl7O2rtPnOS0dg3+c4Kt6
	IhWUUjU2Rt3URHES5C4kx39t8z4eScj+uaCErkcTz1q69m6OajV6cezXeu9nOwiEo+dONBFP5JYvJ
	ppkUmU3OY44/gwKpoX6ZAUJjaWsGP7sMtfe1kJ67XfCN9kotYIfgNUw3gY9oqIJJncsRs7waCVOfW
	gurqMK27SfIV/UFmtcS0gxdcbWSJZ2Te8dIVhJDskDTSPjcfz55tPAHUhGmy6bA1AuzuG1/FMKd+z
	OvZnkc+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk7mP-00GzrL-B1; Mon, 08 Nov 2021 16:45:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk7mM-00Gzq6-86
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 16:45:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EECEB6120A;
 Mon,  8 Nov 2021 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636389953;
 bh=l1vUPSTKlLkdU/pTPV1MbYUUsTvn0tPIgV83Bq2cIgs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ptLe6DICWAyFRnCDtYQ3q4wY8aeGfXLrrU7MbpfTId2kvKVFNQ0Pr0XwusWxo/9Qv
 ctmPNmrTDQ1sNiKye/7/tuJNYJZwJdap3i8twtoaldaUTi78atqgOrPb2mmbsCF49x
 jqBs+yDU2Ami6te0bxCpYaCPUszj5CSgZyLrEnOHXzkvk/09JankI+g+rBdSOY61Gc
 QAdGG3vPtMc8nd2eaKjbwR2giXh3NFxa0gI1r7PXKpqVOKHvrLpgYJL6cj/eTttIfH
 sEOy5ojgy1o6v7Qp4laSPywc8Ut7YQ+kvar5gdaGt6GpREGnrjU6UHBLlKXYc2mTmm
 C157lRyDT5qTA==
Date: Mon, 8 Nov 2021 08:45:50 -0800
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 4/4] nvme: wait until quiesce is done
Message-ID: <20211108164550.GB2660170@dhcp-10-100-145-180.wdc.com>
References: <20211103034305.3691555-1-ming.lei@redhat.com>
 <20211103034305.3691555-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103034305.3691555-5-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_084554_346947_8C8A187B 
X-CRM114-Status: UNSURE (   8.62  )
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

On Wed, Nov 03, 2021 at 11:43:05AM +0800, Ming Lei wrote:
> NVMe uses one atomic flag to check if quiesce is needed. If quiesce is
> started, the helper returns immediately. This way is wrong, since we
> have to wait until quiesce is done.

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>


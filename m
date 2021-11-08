Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EEC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 16:42:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACDA60F5A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 16:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6ACDA60F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2farPdFCDAhXUe81W2GyFhorqJQvvXLtFkVl5JzpXU4=; b=CdI5xGh6hfG1pQARJpB8c/7Meo
	5i4NNNrMlcE+o6ZbcqXao2V78a6uf+I+hqi19d676Ulmt0nlW1A6gTlqdcACWx0XR6e4Bzs80Mf4l
	BBqozWrxyQzqwP9ChVQceq9xSZXNsZqOsxRM+RZoQvW4eAIKJ8ur+rdpLLSPAFqmQXIqfiFN6ckE3
	DjvbPYjqTtgPjCAtBd81+nwSDVrsuoUj+6HREppCMxhfzMddUyMlrIz3Endx3womWXFWlrtqYIyWE
	+Nm9bgYOYch/1n57jQ39MRCKoc7V14SObx64jDYh06tCnQg3GlSaw8hRfDvPoU/PBoPeubVKknkyA
	ANOqSPuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk7ik-00GzP7-NS; Mon, 08 Nov 2021 16:42:10 +0000
Received: from bedivere.hansenpartnership.com ([96.44.175.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk7ih-00GzNy-Qy
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 16:42:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1636389723;
 bh=lpuLhbP5D8y7Rh++3/m1gJ/kmzDRQihOj3d0Ea3+naw=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=vGp3HXQPGECmrit0ElRfIxrq4UE5s9ccP2I5N4d1tx20bGxFJQirlcN25WzOorCX1
 c+hY1TzUrSDiD8rZK9oHTJNaB7MtpRngWZi0Yw52XwCWC8j5HeoFLrPIFwRqofowOL
 y6ommqbMLoQDxDhuGatF3WLs1OICVeJc/gIxOxHc=
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8F42112804CC;
 Mon,  8 Nov 2021 11:42:03 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id u_heyEEjYIWy; Mon,  8 Nov 2021 11:42:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1636389723;
 bh=lpuLhbP5D8y7Rh++3/m1gJ/kmzDRQihOj3d0Ea3+naw=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=vGp3HXQPGECmrit0ElRfIxrq4UE5s9ccP2I5N4d1tx20bGxFJQirlcN25WzOorCX1
 c+hY1TzUrSDiD8rZK9oHTJNaB7MtpRngWZi0Yw52XwCWC8j5HeoFLrPIFwRqofowOL
 y6ommqbMLoQDxDhuGatF3WLs1OICVeJc/gIxOxHc=
Received: from jarvis.int.hansenpartnership.com (unknown
 [IPv6:2601:5c4:4300:c551::527])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C56881280492;
 Mon,  8 Nov 2021 11:42:02 -0500 (EST)
Message-ID: <08f0e186093b0d5067347a1376228010cb4cc7f4.camel@HansenPartnership.com>
Subject: Re: [PATCH 3/4] scsi: make sure that request queue queiesce and
 unquiesce balanced
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Date: Mon, 08 Nov 2021 11:42:01 -0500
In-Reply-To: <20211103034305.3691555-4-ming.lei@redhat.com>
References: <20211103034305.3691555-1-ming.lei@redhat.com>
 <20211103034305.3691555-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_084207_916515_BA040939 
X-CRM114-Status: GOOD (  13.88  )
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

On Wed, 2021-11-03 at 11:43 +0800, Ming Lei wrote:
[...]
> +void scsi_start_queue(struct scsi_device *sdev)
> +{
> +	if (cmpxchg(&sdev->queue_stopped, 1, 0))
> +		blk_mq_unquiesce_queue(sdev->request_queue);
> +}
> +
> +static void scsi_stop_queue(struct scsi_device *sdev, bool nowait)
> +{
> +	if (!cmpxchg(&sdev->queue_stopped, 0, 1)) {
> +		if (nowait)
> +			blk_mq_quiesce_queue_nowait(sdev-
> >request_queue);
> +		else
> +			blk_mq_quiesce_queue(sdev->request_queue);
> +	} else {
> +		if (!nowait)
> +			blk_mq_wait_quiesce_done(sdev->request_queue);
> +	}
> +}

This looks counter intuitive.  I assume it's done so that if we call
scsi_stop_queue when the queue has already been stopped, it waits until
the queue is actually quiesced before returning so the behaviour is the
same in the !nowait case?  Some sort of comment explaining that would
be useful.

James





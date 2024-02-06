Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E281FC48297
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 13:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YrzT1BHKb2nGjzLlh+caPx0zndmplDTssuiNQNr+lVk=; b=QFGbzFxykdk4FeUE2+EHw5ir00
	OsH0+3EAQyx466uNS7P8PMBq20nPQIbB47vI6bQyjwU/NBshTrNXWh+ssz8j7SzzXUhUxUBrxj0J4
	CXpjJ2FYqfYenGntrm44JZqtBLEEFQ55YPOAoFOfEguVM3gYen8mLZ5u8Jkj97qQRC6Ic6YZlou3X
	tXXM+348+40w2LXa0XwjkI+5QaX6t7v7Wod7nE+1tLGbTJSPTl2nCv9zmude4RWWpPa95AEdj2V+K
	ShckflFAUuE6q3sACcv28eZ38fYgatvW7iWJ7CcZz4/5kWOMxMnHYeSwqhYx2WhFEjJ/EMBcyaBp5
	xYtMuS9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLCt-00000007fKF-3XLF;
	Tue, 06 Feb 2024 13:09:47 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLCq-00000007fIn-1Y8C
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 13:09:45 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a3122b70439so739730066b.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Feb 2024 05:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707224982; x=1707829782; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrzT1BHKb2nGjzLlh+caPx0zndmplDTssuiNQNr+lVk=;
        b=XHNl/Zqyaet5T3qrwTvEErlBg49aS1xaBNNWq3pwZMsMIxRL0ULomyXy4HaQS0IAgj
         TWiRM0eF7ekzR2THOO+q4eNRnigxvG366sFYKVUhavjgjFRNbkJAlOsvuZfl3NdH9YVm
         GW+bpe5uuU3sdI4N5Qwvtd8z3lMFJ+czWzuXP3plXkKX6VLrxvMaCoRZuCCrTtpjIM0Z
         EBaHEPb8LAnXC1O+yZal3k+KLDjfdNh6guVsiKAsre5yME4TkvUP6RTHE0Or1xozVD9n
         6zeK3IkBvDs3L5IIf7mpVF2uRfztL3ur506OdBMV8n4Ek5uqqoFpi5dP58vuuNdR58n2
         9REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224982; x=1707829782;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrzT1BHKb2nGjzLlh+caPx0zndmplDTssuiNQNr+lVk=;
        b=BwkZBjnrpCaUTtrqXolPDTcrMpvJtAJY+wi41/zHOGcS813vXvS3/xuOcrsm7SLZmx
         Ii4DrFgagRh4D5vV+oz16nY/mGHApZvvme4t8m92pVgIuhpzw3Xl4oHjCUKPJoYbnaHF
         DJX8QAWpKKxPn3+SgScAsRs6Q+w6tkvWhHrfQVv2NQA3o8m4LqOXEKDHvnJ9COYmBucf
         YlFxt/qRWRO3ApZY8xSFoAHpiNnUh2DbJYBdVGMAkVyv684YNQX3BA9JiOmNbPgTkchU
         T66ilHm37T8SEmrwpxJzZEToI/H4iW2rsx8pfb3pshPrMMn6L3Kjm1I9GmhyrzuIvngE
         3cMA==
X-Gm-Message-State: AOJu0YyYeHYBR4Se2vWD5ZKCKn+7Skuv9rY8YZCiJSOBMRkFykRcJDWe
	9xUxW3VvvZO0yXlBo0FpefyYIWI8hnA6TIQby/A95jAIbyo/xCqsobgsr4jYnszfED6lBrxTWP2
	U
X-Google-Smtp-Source: AGHT+IFX1eVDPVbsvPAuYatnVOCy0fRKXeJow1IGPVEIELHZiCtQh5XD4CLgFxaF25SVj2IKrmyo/g==
X-Received: by 2002:a17:906:3b8b:b0:a37:6303:18b8 with SMTP id u11-20020a1709063b8b00b00a37630318b8mr1648726ejf.54.1707224981728;
        Tue, 06 Feb 2024 05:09:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUHxQIDE4RnnGlFYvZ/yGTm0GW3XOEmsjHInPo08cFNNOH5G+k+Qn+elOR28vrLa4MFkbJ30gQbV1HnZ0yJMH4Acq5N5B7Hk1A=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id vh12-20020a170907d38c00b00a382478ccd2sm751089ejc.158.2024.02.06.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:09:41 -0800 (PST)
Date: Tue, 6 Feb 2024 16:09:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: jsmart2021@gmail.com
Cc: linux-nvme@lists.infradead.org
Subject: [bug report] nvmet-fc: track hostport handle for associations
Message-ID: <25cf5405-d4ba-45c5-8e20-2af6e33a7195@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_050944_431822_13D88EE2 
X-CRM114-Status: UNSURE (   9.20  )
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

Hello James Smart,

This warning is quite old but I don't think I've ever reported it
before.

The patch 58ab8ff9dca2: "nvmet-fc: track hostport handle for
associations" from Mar 31, 2020 (linux-next), leads to the following
Smatch static checker warning:

	drivers/nvme/target/fc.c:950 nvmet_fc_delete_target_queue()
	warn: sleeping in atomic context

The call tree this:

nvmet_fc_invalidate_host() <- disables preempt
-> nvmet_fc_tgt_a_put()
   -> nvmet_fc_target_assoc_free()
      -> nvmet_fc_delete_target_queue()

drivers/nvme/target/fc.c
  1546  void
  1547  nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
  1548                          void *hosthandle)
  1549  {
  1550          struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
  1551          struct nvmet_fc_tgt_assoc *assoc, *next;
  1552          unsigned long flags;
  1553          bool noassoc = true;
  1554  
  1555          spin_lock_irqsave(&tgtport->lock, flags);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Holding a spin lock.

  1556          list_for_each_entry_safe(assoc, next,
  1557                                  &tgtport->assoc_list, a_list) {
  1558                  if (assoc->hostport->hosthandle != hosthandle)
  1559                          continue;
  1560                  if (!nvmet_fc_tgt_a_get(assoc))
  1561                          continue;
  1562                  assoc->hostport->invalid = 1;
  1563                  noassoc = false;
  1564                  nvmet_fc_schedule_delete_assoc(assoc);
  1565                  nvmet_fc_tgt_a_put(assoc);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^
This will eventually sleep I think.

  1566          }
  1567          spin_unlock_irqrestore(&tgtport->lock, flags);
  1568  
  1569          /* if there's nothing to wait for - call the callback */
  1570          if (noassoc && tgtport->ops->host_release)
  1571                  tgtport->ops->host_release(hosthandle);
  1572  }

drivers/nvme/target/fc.c
    877 static void
    878 nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
    879 {
    880         struct nvmet_fc_tgtport *tgtport = queue->assoc->tgtport;
    881         struct nvmet_fc_fcp_iod *fod = queue->fod;
    882         struct nvmet_fc_defer_fcp_req *deferfcp, *tempptr;
    883         unsigned long flags;
    884         int i;
    885         bool disconnect;
    886 
    887         disconnect = atomic_xchg(&queue->connected, 0);
    888 
    889         /* if not connected, nothing to do */
    890         if (!disconnect)
    891                 return;
    892 
    893         spin_lock_irqsave(&queue->qlock, flags);
    894         /* abort outstanding io's */
    895         for (i = 0; i < queue->sqsize; fod++, i++) {
    896                 if (fod->active) {
    897                         spin_lock(&fod->flock);
    898                         fod->abort = true;
    899                         /*
    900                          * only call lldd abort routine if waiting for
    901                          * writedata. other outstanding ops should finish
    902                          * on their own.
    903                          */
    904                         if (fod->writedataactive) {
    905                                 fod->aborted = true;
    906                                 spin_unlock(&fod->flock);
    907                                 tgtport->ops->fcp_abort(
    908                                         &tgtport->fc_target_port, fod->fcpreq);
    909                         } else
    910                                 spin_unlock(&fod->flock);
    911                 }
    912         }
    913 
    914         /* Cleanup defer'ed IOs in queue */
    915         list_for_each_entry_safe(deferfcp, tempptr, &queue->avail_defer_list,
    916                                 req_list) {
    917                 list_del(&deferfcp->req_list);
    918                 kfree(deferfcp);
    919         }
    920 
    921         for (;;) {
    922                 deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
    923                                 struct nvmet_fc_defer_fcp_req, req_list);
    924                 if (!deferfcp)
    925                         break;
    926 
    927                 list_del(&deferfcp->req_list);
    928                 spin_unlock_irqrestore(&queue->qlock, flags);
    929 
    930                 tgtport->ops->defer_rcv(&tgtport->fc_target_port,
    931                                 deferfcp->fcp_req);
    932 
    933                 tgtport->ops->fcp_abort(&tgtport->fc_target_port,
    934                                 deferfcp->fcp_req);
    935 
    936                 tgtport->ops->fcp_req_release(&tgtport->fc_target_port,
    937                                 deferfcp->fcp_req);
    938 
    939                 /* release the queue lookup reference */
    940                 nvmet_fc_tgt_q_put(queue);
    941 
    942                 kfree(deferfcp);
    943 
    944                 spin_lock_irqsave(&queue->qlock, flags);
    945         }
    946         spin_unlock_irqrestore(&queue->qlock, flags);
    947 
    948         flush_workqueue(queue->work_q);
    949 
--> 950         nvmet_sq_destroy(&queue->nvme_sq);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Sleeps.

    951 
    952         nvmet_fc_tgt_q_put(queue);
    953 }

regards,
dan carpenter


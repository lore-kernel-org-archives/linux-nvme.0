Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F0AC48BCF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 08:55:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519AD6101A
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 08:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519AD6101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8QB4Hh6vqfpyFSJdXqI5vhAN7oSo/tfSbM9UF336hUA=; b=xGQQlDSlTA8QCiDD2jW3e+azxz
	fVMlpmXInUhzYgkLjcTsbyfkNU3yrG+s2jZkfVy/QT6QH6gbYhTuGbX//J4uflBIQnRmTwx/Y464r
	lbNLdz020NxYaDGVvVUJqQMYejAyLHDxcG3Dn+yNjUOp8jXJ7Th41s5QDraytHUT+B5MUX97eafW2
	rjaADK8j/iJqN8sRjV/plC2z1n7RDAA7SJzXcqORvSJBru8KBeG085e61cwvT9dyeSRsYZje0CCdZ
	4YzY0dJDkWVpLfl5FiLpdQeHIY3XyCLhyOkCPzNFqLL/Cp7N3uHm3G3NCqjzfLYuAzLFUJP/63PXO
	D5twatNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqtzO-00CVUl-3r; Wed, 09 Jun 2021 08:55:06 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqtCy-00CGyg-F2
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 08:05:05 +0000
Received: by mail-wr1-f46.google.com with SMTP id y7so19754700wrh.7
 for <linux-nvme@lists.infradead.org>; Wed, 09 Jun 2021 01:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HEWLXScTeIoTQWXDZb22kYj7FMG459jXqNiDEwOaP7c=;
 b=JwZ1HQ0ehuFJICxjUzirwMV0AHE13St00sgIVuDoDvsAg0LfdIDcWOkxm5lYMSCGti
 QBnJscLRekwQAEYEWJvWPqiaZ6rD2ZQv3jt6cfoZXx4i2fYPshprl1ygrkWFJbHjT7TJ
 vpHifcKzVa+dbDpKt7IhMjYsK1p017DiVZ+3PcfmXtCsQMaClu6JowqiF/QXsAACiisC
 9tRjpgFVhwgRSBtz1Da9ll/U4COgrwIp1msBEApvWT8SGd1eiE3xGp8/J6ZYi3XwoxTT
 VGXK0PUsm4Fg9OJh340/nnA46bONKzdAb+9Pwbgmw9nxH0llkZfCE2c3Gw6QCSADAIa4
 qzww==
X-Gm-Message-State: AOAM531ySgHYEaLNyYQyegWutUPvUGwjLJIhJYVi172XPubLqIHLnf+j
 80eEw8xe9EtZ6vPSLi1mCD+YtGCSLvk=
X-Google-Smtp-Source: ABdhPJzggEGq9FReBOVUaZXSKUVtUHmGR1zHw7gZDGA3TXGj9DewsVdMJHHlIX8dt/JtvRQ0MYNV9g==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr27290924wrs.298.1623225902647; 
 Wed, 09 Jun 2021 01:05:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:add4:fb94:3dc4:5c2e?
 ([2601:647:4802:9070:add4:fb94:3dc4:5c2e])
 by smtp.gmail.com with ESMTPSA id b15sm9446684wrr.27.2021.06.09.01.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 01:05:02 -0700 (PDT)
Subject: Re: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
 <CO1PR19MB48850B44ED23C179A4E4F541EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b9c7e6cc-fea5-b8ce-af07-7d004116e3e3@grimberg.me>
Date: Wed, 9 Jun 2021 01:04:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CO1PR19MB48850B44ED23C179A4E4F541EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_010504_563877_4493C2E9 
X-CRM114-Status: GOOD (  17.30  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi,
> 
> Indeed RHEL8.3 does not have the mutex protection on nvme_tcp_stop_queue
> However, in our case, based on the below back trace
> We don't get to __nvme_tcp_stop_queue from nvme_tcp_stop_queue
> We get to it from:
> nvme_tcp_reconnect_ctrl_work --> nvme_tcp_setup_ctrl --> nvme_tcp_start_queue  --> __nvme_tcp_stop_queue
> 
> so I'm not sure how this mutex protection will help in this case


Oh, well iirc we probably need the same mutex protection in start
failure case then?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 216d21a6a165..00dff3654e6f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1548,6 +1548,7 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl 
*nctrl, int qid)
  static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
  {
         struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+       struct nvme_tcp_queue *queue = &ctrl->queues[idx];
         int ret;

         if (idx)
@@ -1556,10 +1557,12 @@ static int nvme_tcp_start_queue(struct nvme_ctrl 
*nctrl, int idx)
                 ret = nvmf_connect_admin_queue(nctrl);

         if (!ret) {
-               set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
+               set_bit(NVME_TCP_Q_LIVE, &queue->flags);
         } else {
-               if (test_bit(NVME_TCP_Q_ALLOCATED, 
&ctrl->queues[idx].flags))
-                       __nvme_tcp_stop_queue(&ctrl->queues[idx]);
+               mutex_lock(&queue->queue_lock);
+               if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+                       __nvme_tcp_stop_queue(queue);
+               mutex_unlock(&queue->queue_lock);
                 dev_err(nctrl->device,
                         "failed to connect queue: %d ret=%d\n", idx, ret);
         }
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3345CC4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33FVYmnrNDtPpFi4JhpyR9b4nqV0CCPVAHBFrcx6Wlo=; b=xwV6ASAqRsiEvxfhJHV95NZaD3
	SCTxK3ADLVXMFHhPjGGs6PobSXANeMN1FqGbF04xtiSzaf7QpvHRBg1/EL3Ne0LfEcB7JUiEic/ed
	7IqKACl6CPG3WTqUXKclSZqYMpxFpphaMudR5+IOBsb37oIoJNqx3W/Qo9rqZYhfQ4tEXdTVFmhiO
	hBFd63+hjImsy88K1Ct8lFcFAVPvCvROb1VvYUOC4RmGh9dN1gpoiPv7oVA4Upb144JfNCYLhPl5X
	+egVRNDT+woVpRMpr1NF/A+WeJEz7nsHvvrJK7VNxByv8jOxQ6CtrYRKaVt+2vSX/RVoB/5BtbN8A
	wGmzlB9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAR8j-006hZ5-1n;
	Tue, 05 Dec 2023 08:50:49 +0000
Received: from mail-ot1-f52.google.com ([209.85.210.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAR8g-006hYh-2Y
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 08:50:48 +0000
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d7f68b059fso468341a34.1
        for <linux-nvme@lists.infradead.org>; Tue, 05 Dec 2023 00:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701766245; x=1702371045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33FVYmnrNDtPpFi4JhpyR9b4nqV0CCPVAHBFrcx6Wlo=;
        b=UqCvP0hFIc6k0EXpd5v9iFHUs9gjkWzaLaIcvJkLNM5Iib2i40EMBmcoHZkPU5SUp7
         3KN4evBD5D77lWoRQBvNOzI0rB1OT9oG/nl5sS/FjyRYawuDcZAVWSBTrVTuRKtD95rl
         +UcG9zTMAKTT62iiYDaRer8qmE+JkxKCfvM9sL82VhDSN5FWbq2C5S3CW/VKJYWGruGr
         gcSwzrEXkyWpOaUxBUygj1vi2lr6GIJ5780f4eZ5ExabHgFQRwAujg5+fnl+Ni3Yl+lc
         r6oNYLgR89AUjjm6DYgDJCQt/27StZYrCCqzbHjwvfa5qWAiqpwBFD3J7waMB0FW36n5
         JFCA==
X-Gm-Message-State: AOJu0Yz+a1Vf+GjdtwssIq9MIN/AQ57kD2sEgh5YQ6OxxAb0ztwKTk/W
	lJ771xSvdHlKugnbnCZTop+Iyf/u+Y4=
X-Google-Smtp-Source: AGHT+IH+6HTPfZvLB2+0RruwPC5bhig+KxUxg2HSQaXEl79VTnFc4n3jcP5rBIy/HkL5hopTNEJiwg==
X-Received: by 2002:a05:6808:1825:b0:3b8:b622:9815 with SMTP id bh37-20020a056808182500b003b8b6229815mr7968756oib.5.1701766244911;
        Tue, 05 Dec 2023 00:50:44 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bi32-20020a05620a31a000b0077d9f83e691sm4956130qkb.35.2023.12.05.00.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:50:44 -0800 (PST)
Message-ID: <08f2c221-cca7-4d34-ab78-157d4eae4f68@grimberg.me>
Date: Tue, 5 Dec 2023 10:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Jirong Feng <jirong.feng@easystack.cn>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <ZW6pJAm9wgqj1HEW@kbusch-mbp> <20231205044035.GA28685@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231205044035.GA28685@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_005046_892759_14B862CD 
X-CRM114-Status: GOOD (  16.65  )
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


>> So the controller through that path used to be able to access the
>> Namespace, then suddenly lost ability to do so, but some other path can
>> still access it if we retry on a failover/alternate path? I think your
>> target is returning the wrong error code. It should be SCT/SC 303h,
>> Asymmetric Access Persistent Loss (NVME_SC_ANA_TRANSITION), for what
>> you're describing.
> 
> Yes, assuming ANA is actually supported by the controllers..

Its a good point (should probably be ana inaccessible). But
semantically, this status is with respect to all the namespace in the
ana group. And the host will not see an updated ANA log page, which will
then override back the ns ana state?

The below can handle the return status, but its not clear what should
the behavior we want to have...
--
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e307a044b1a1..5fd5e74a41a8 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -726,6 +726,19 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
         NULL,
  };

+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
+{
+       struct config_item *ns_item;
+       char name[4] = {};
+
+       if (sprintf(name, "%u\n", nsid) <= 0)
+               return false;
+       mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
+       ns_item = config_group_find_item(&subsys->namespaces_group, name);
+       mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
+       return ns_item != NULL;
+}
+
  static void nvmet_ns_release(struct config_item *item)
  {
         struct nvmet_ns *ns = to_nvmet_ns(item);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165048e7..426ced914a21 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -425,11 +425,15 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl 
*ctrl)
  u16 nvmet_req_find_ns(struct nvmet_req *req)
  {
         u32 nsid = le32_to_cpu(req->cmd->common.nsid);
+       struct nvmet_subsys *subsys = nvmet_req_subsys(req);

-       req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
+       req->ns = xa_load(&subsys->namespaces, nsid);
         if (unlikely(!req->ns)) {
                 req->error_loc = offsetof(struct nvme_common_command, 
nsid);
-               return NVME_SC_INVALID_NS | NVME_SC_DNR;
+               if (nvmet_subsys_nsid_exists(subsys, nsid))
+                       return NVME_ANA_PERSISTENT_LOSS;
+               else
+                       return NVME_SC_INVALID_NS | NVME_SC_DNR;
         }

         percpu_ref_get(&req->ns->ref);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..477416abf85a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -542,6 +542,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys 
*subsys,
                 struct nvmet_host *host);
  void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
                 u8 event_info, u8 log_page);
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);

  #define NVMET_QUEUE_SIZE       1024
  #define NVMET_NR_QUEUES                128
--
--


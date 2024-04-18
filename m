Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BCAC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 08:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7yyq4JcQYlflL+FZ1X4bo8lffH1cwLm/D6jguKOYCo=; b=kRA8f1lzrU+MsU+PVuR8997M4D
	P5OEZwifZVJFheTqsklsdjPUlqZdwAbtnm7UqjL0Pxwl0MY/UbWArLwCQZ9iq9TNg7iV4mNkk4d8E
	Cixh4w/NQ6vjr+KLcHTK+nuRtdkZmIuoEqpQ+Y55N/HWEd7nGL8fen9h8xlVtuzpNMLHRZaoef6AK
	6vqkxfTRi0iQd8daZE36ZbygSdCU+7l3JdrgDtYlC02eOHFrNSHui5v4ojj7Y09VlTGlnle9TyrlH
	aXTJcJwhDSqvaTEygTeUpb3e71CziRpkbg66YzdTZuPn+ZPIj19gLHdXS2EkuvAy4M6C4I6rG9bkt
	x08sXxrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxMiU-00000001M92-1u5O;
	Thu, 18 Apr 2024 08:01:58 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxMiM-00000001M89-0UjM
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 08:01:56 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-346407b8c9aso147175f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 Apr 2024 01:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427306; x=1714032106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7yyq4JcQYlflL+FZ1X4bo8lffH1cwLm/D6jguKOYCo=;
        b=AI7l5dnXxGLD2ufM4U9Ccp+LrBPw1Mh9Ho1VGKk/KYyfRoCCBLAcVDOl7LD15+EMY3
         DV6LfP5RciQ3tNnKzXW/Db0pNINTo+dt40pp+MyhlabEHaL/kFRZDXlwEw5Ptoq8YLES
         KMrIJIRNLYKH6+N2pYLw6lNE560BI50pOiDK/C859Vum4Y34zIVMu1Pu5mS/RRtuX6Q7
         6XeyJCn//pqZwGVUKu1T6iPyVpEfT2cpnH3bUmSZ204TgJZ/zcz/IE31GmrtvSRpr41g
         GIeNOMp+YvfHnyb5hW9Q+QKEEPVjk/FEeZrctfNrm21nEM8y4YN0M6d9gfB+DqmT81Ui
         MgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa171TfC9mXMQ1HOrFjPNd2yiyA77zPfiJYQklknaNvy8S94CjLoJkilZf3nat79DDmbCX6S8haCvyyhJlNpyUdPFCRKjtWvCte+Pzyh0=
X-Gm-Message-State: AOJu0YxDelimHHViipy7ik75T7EQVggCu39QR72u2byBz3t614K0JIrX
	OeVThTaJNCk3F/4uVl1ip8raKGdl10gT0Ky9Gkpa6EPq5NvVZIL1
X-Google-Smtp-Source: AGHT+IG1P/OH0fi66bzoTkvhbQjT2SWrAgNCQlRybp6hcnR3iyZ2aoiiRIK8oTXppuxm1KCc32Zffg==
X-Received: by 2002:a05:600c:3b8d:b0:418:3d9b:b38e with SMTP id n13-20020a05600c3b8d00b004183d9bb38emr1332415wms.4.1713427305954;
        Thu, 18 Apr 2024 01:01:45 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm5580159wmo.5.2024.04.18.01.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:01:45 -0700 (PDT)
Message-ID: <8a52ce1e-3cdb-468a-87a5-3cf8a118cad6@grimberg.me>
Date: Thu, 18 Apr 2024 11:01:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240417153923.100342-1-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240417153923.100342-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_010150_179068_E043408D 
X-CRM114-Status: GOOD (  14.66  )
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



On 17/04/2024 18:39, Hannes Reinecke wrote:
> TLS requires a strict pdu pacing via MSG_EOR to signal the end
> of a record and subsequent encryption. If we do not set MSG_EOR
> at the end of a sequence the record won't be closed, encryption
> doesn't start, and we end up with a send stall as the message
> will never be passed on to the TCP layer.
> So do not check for the queue status when figuring out whether
> MSG_MORE should be set but rather make it dependent on the current
> command only.

How about making nvme_tcp_queue_more take into account nvme_tcp_tls()?
so we preserve the behavior without tls.

i.e. something like:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0ba62fc647b3..bbffc67f8a1e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -360,12 +360,18 @@ static inline void nvme_tcp_send_all(struct 
nvme_tcp_queue *queue)
         } while (ret > 0);
  }

-static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
  {
         return !list_empty(&queue->send_list) ||
                 !llist_empty(&queue->req_list);
  }

+static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+{
+       return !nvme_tcp_tls(queue->ctrl) &&
+               nvme_tcp_queue_has_pending(queue);
+}
+
  static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
                 bool sync, bool last)
  {
@@ -386,7 +392,7 @@ static inline void nvme_tcp_queue_request(struct 
nvme_tcp_request *req,
                 mutex_unlock(&queue->send_mutex);
         }

-       if (last && nvme_tcp_queue_more(queue))
+       if (last && nvme_tcp_queue_has_pending(queue))
                 queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
  }
--


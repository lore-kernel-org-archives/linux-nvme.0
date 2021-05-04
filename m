Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D22C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 19:30:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4D9611AB
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 19:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4D9611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dXYgn74KJ5gtYyEJ4y5899vSE4Red//bhCNH1EPBOr0=; b=mFCZaHsugpkHgTChsGuZzJ1qR
	No5BamrCXnieR8dELCHSSUeweJC9ddbYlSUjf3zzoRGcQrY/hcssyCy9u/sEptuVB5ddIkaHzxolV
	cWEwYGhgalGCWtuALdp5WuhugHf8a4wG2IVDqNbldp9/8Tz9f9rf33SeuqkEcSngl+6nc59fmjYNX
	iishE1A/Mnlx5ZoQgOPHH+9AEhJ/8ReY67HvAYQ1mDFDVsw3lSW0H/7vHO4RIpcxEoXZr7kWKVOuE
	IxZq6uXw6nHocGdO9wbvAppA3DJT1npRC2uD1IOSKJdTdh8HzAJLyFntHRgGDLp9NN3dgvQz0PLW6
	IP6eFGouA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le0jm-00Gtfz-2S; Tue, 04 May 2021 19:29:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le0jj-00Gtfj-3F
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 19:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=WY1vETDobql/B1GZTE7Fdg7CKR+IYzmVpWFGUOExM0Q=; b=OHQN9uIs5w5HUtFD5uhRbl38Mi
 L/vV6sMJ2fX66Mwkq0MZzHsgNfOGVVinwkkPkQQolrxnig3eK5gOyWBxV/lUexWeAE4rOuUA4YjYo
 R4rzKprsurMucMJ5BSe8ORBg+HzNgRv00XjgERx1okLHldGwCALKxGjpfg4t2QoOLYZx6ujxf5T3D
 2i/ClO2eJxxiW7EI8YUPzoTnbiGDvTi1JSlDPTOX47ttWicmu7gM6ZpUrxfsGMHpaPtF2wYI+2McP
 1SVWgP3LaGro5d+XMOPaAidBSMe5INo0RoQmzfX4I9Om10Jg8gC3oQ1JmC5z4d2vQGLo7+Pxq4MAi
 30bEMMEQ==;
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le0jg-004DcS-4u
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 19:29:37 +0000
Received: by mail-pl1-f174.google.com with SMTP id t21so5874449plo.2
 for <linux-nvme@lists.infradead.org>; Tue, 04 May 2021 12:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WY1vETDobql/B1GZTE7Fdg7CKR+IYzmVpWFGUOExM0Q=;
 b=n7wzH5Dcr5aWH2gDnmtl+6pK/ktt3V+pUdYLC3Sx02j3Xw430fPJo1xu2hHuqZnPgJ
 KKgnS7Mp3B00h6gaHYkmW9tUdjiEsUls3Bke9zdNWckxnA/ZI+7diSR2Js8bWftiQGg3
 O9GURi7VjusK58lhmprqyQ6z5ldr6WbrMTDUTLk8lwxTAhvAylpdHzyDqmyi2k1Rcvbb
 OjpPTaC44XD3ipdQj7ipWdlPTQinvJBnMnDlrlmF1bjzxjN4yYfRfVr8i6VvTrzQKvYx
 2z61ewRs8k1/7k4mSUDaQp2nIj8zIDdEefpms1USLhJtrKCcjnNGvFS6ECWjMHBU2B+x
 OUmg==
X-Gm-Message-State: AOAM531vrLPPxlWu1gsxmbt0gXJRS/BQGk/gxA5Pm/v/Rj+edIvd5iJb
 fUq8rDMrtrJn3Y4O20jtJKc=
X-Google-Smtp-Source: ABdhPJx2mu+ij9WZx+n1Tp5XKrTQETdu1jWMCSSYek89OGBWimzr0lpBeMJ51lYam+uioYg45JtfWA==
X-Received: by 2002:a17:902:b78b:b029:ed:5429:4c2c with SMTP id
 e11-20020a170902b78bb02900ed54294c2cmr28015405pls.4.1620156574891; 
 Tue, 04 May 2021 12:29:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:dee:5152:2348:42c1?
 ([2601:647:4802:9070:dee:5152:2348:42c1])
 by smtp.gmail.com with ESMTPSA id a7sm9445873pfo.211.2021.05.04.12.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 12:29:34 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
 <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
 <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
 <20210428180147.GB21854@redsun51.ssa.fujisawa.hgst.com>
 <500074cf-c0e8-807b-5b30-a3474d37700f@grimberg.me>
 <20210429033328.GC24074@redsun51.ssa.fujisawa.hgst.com>
 <bd3c39f9-3768-7494-e63b-7baf9ad9b615@grimberg.me>
 <20210503185121.GD910137@dhcp-10-100-145-180.wdc.com>
 <96afc178-f5db-dd56-59a6-467e032c619a@grimberg.me>
 <20210503202545.GB910455@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6bd4b93f-dddd-c40a-2e82-0027d84597a4@grimberg.me>
Date: Tue, 4 May 2021 12:29:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210503202545.GB910455@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_122936_225509_157C6A59 
X-CRM114-Status: GOOD (  29.17  )
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


>>>>> The driver tracepoints captured millions of IO's where everything
>>>>> happened as expected, so I really think something got confused and
>>>>> mucked with the wrong request. I've added more trace points to increase
>>>>> visibility because I frankly didn't find how that could happen just from
>>>>> code inspection. We will also incorporate your patch below for the next
>>>>> recreate.
>>>>
>>>> Keith, does the issue still happen with eliminating the network send
>>>> from .queue_rq() ?
>>>
>>> This patch is successful at resolving the observed r2t issues after the
>>> weekend test run, which is much longer than it could have run
>>> previously. I'm happy we're narrowing this down, but I'm not seeing how
>>> this addresses the problem. It looks like the mutex single threads the
>>> critical parts, but maybe I'm missing something. Any ideas?
>>
>> Not yet, but note that the send part is mutually exclusive but the
>> receive context is where we handle the r2t, validate length/offset
>> and (re)queue the request for sending a h2cdata pdu back to the
>> controller.
>>
>> The network send was an optimization for latency, and then I modified
>> the queueing in the driver such that a request would first go to llist
>> and then the sending context (either io_work or .queue_rq) would reap it
>> to a local send_list. This helps the driver get better understanding of
>> what is inflight such that it better set network msg flags for EOR/MORE.
>>
>> My assumption is that maybe somehow we send the the initial command
>> pdu to the controller from queue_rq, receive the r2t back before the
>> .queue_rq context has completed and something may not be coherent.
> 
> Interesting. The network traces look correct, so my thoughts jumped to
> possibly incorrect usage of PCIe relaxed ordering, but that appears to
> be disabled.. I'll keep looking for other possibilities.
> 
>> Side question, are you running with a fully preemptible kernel? or
>> less NVMe queues than cpus?
> 
> Voluntary preempt. This test is using the kernel config from Ubuntu
> 20.04.
> 
> There are 16 CPUs in this set up with just 7 IO queues.

Keith,

Maybe this can help to add some more information (compile tested only):
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a848b5b7f77b..9ce20b26c600 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -57,6 +57,7 @@ struct nvme_tcp_request {
         size_t                  data_sent;
         size_t                  data_received;
         enum nvme_tcp_send_state state;
+       bool                    got_r2t;
  };

  enum nvme_tcp_queue_flags {
@@ -622,10 +623,18 @@ static int nvme_tcp_handle_r2t(struct 
nvme_tcp_queue *queue,
         }
         req = blk_mq_rq_to_pdu(rq);

+       if (req->state != NVME_TCP_SEND_CMD_PDU) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d tag %#x req unexpected state %d 
got_r2t %d\n",
+                       nvme_tcp_queue_id(queue), rq->tag, req->state,
+                       req->got_r2t);
+       }
+
         ret = nvme_tcp_setup_h2c_data_pdu(req, pdu);
         if (unlikely(ret))
                 return ret;

+       req->got_r2t = true;
         req->state = NVME_TCP_SEND_H2C_PDU;
         req->offset = 0;

@@ -1083,6 +1092,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue 
*queue)
         }

         if (req->state == NVME_TCP_SEND_DATA) {
+               /* sending data not inline AND unsolicited? */
+               WARN_ON_ONCE(!nvme_tcp_has_inline_data(req) && 
!req->got_r2t);
                 ret = nvme_tcp_try_send_data(req);
                 if (ret <= 0)
                         goto done;
@@ -2275,6 +2286,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
nvme_ns *ns,
                 return ret;

         req->state = NVME_TCP_SEND_CMD_PDU;
+       req->got_r2t = false;
         req->offset = 0;
         req->data_sent = 0;
         req->data_received = 0;
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

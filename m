Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6A8C77B78
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uqTWUp53+bRwfsmTGL4xwInFrL3h6w2jQiIVDgqqklA=; b=scDtM8o96ubeVQL7ns8TT0q+SJ
	twCOo9GCQLiFdukGErp3CUwYfLuolqV9BvlbdzrtyJvMu3btspzTS++7x0rK9M/LkG6tvh9ZWU6bk
	qfoQ621MN8qMFK6zBlRXXIAFl7F+SprkZUCUwPWO1/iyCdWVdGnE56rfc7hxk4EuPjgwC/9xw0Kuc
	8GfxPXD3WfRtxgKUruRQFgHXRtUsW1pZhcYmQZijoJYoMIGM+t3h8AXtoprw37Ca+qDHonBETc/qF
	3f7m6iE42ReWRSH3bDt884gVurnVVOo1Y8w9RMBvMvW3v/IpdBwwerkUNRCnavW6KhLtRDwdIukOl
	Mh+IYvyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pub9g-008FyQ-38;
	Thu, 04 May 2023 15:46:04 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pub9e-008Fw2-03
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 15:46:03 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f3284dfe34so1172235e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 08:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215157; x=1685807157;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqTWUp53+bRwfsmTGL4xwInFrL3h6w2jQiIVDgqqklA=;
        b=EfNe2L3PDbuG8JuMQ//URE+wj9w0p/+iyaRH9lbJiE6Fbm2rTSNhKUy6Aoqei+nhum
         Lhqx6VrgqXXlVCMpN1hb0TKbxybM7pWaEuPdup4Fhzu6fI+g5fBnd9lBkvi5d4/EtAsv
         2s7pmllJjgHwtAa6H/1xB+UMs+muVvoEbors1JJi2/EK/A3H5YSntD95WJmWscqavTPo
         afc72VrZty82M9LMA8kTu1ooB7vLatgit68pGLhCY8+by4KhJ1O21vgjcALIIwDW8Ul8
         koGuBR/krw0J7xCA3VDGeAOIUoFfTau6XpDyt32DITWB9Lv1o1i4AU35r7nv6IwwOywF
         u44A==
X-Gm-Message-State: AC+VfDw7jqMW5t7oQRVwTkfBcrBsTfQ/oZt2N7crnuJGNxKv8GQOhtey
	jMvVIKUrsL7rQ63mZZXRDO/6faXjVTE=
X-Google-Smtp-Source: ACHHUZ5e+6xHqDTlmzpHX/TcLSHUd0LqfFEv/PsmXmD9Rf8Dnjko/R/o+8C7B3leT2+ElWoNDnwFBw==
X-Received: by 2002:a05:600c:4591:b0:3f1:7490:e58e with SMTP id r17-20020a05600c459100b003f17490e58emr7731122wmo.2.1683215157034;
        Thu, 04 May 2023 08:45:57 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c290100b003edf2dc7ca3sm5267525wmd.34.2023.05.04.08.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:45:56 -0700 (PDT)
Message-ID: <fb7aa5b2-cfe8-b3c8-fec7-228f0f56cda1@grimberg.me>
Date: Thu, 4 May 2023 18:45:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: slab-use-after-free in __ib_process_cq
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <d9da387d-b497-5120-5251-0c5d6a4adb71@acm.org>
 <bca0fb81-38ae-f022-1270-70c7e415ac41@grimberg.me>
 <4dad4f76-1270-f45a-882d-3b2ecce817e5@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4dad4f76-1270-f45a-882d-3b2ecce817e5@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_084602_053811_12B20517 
X-CRM114-Status: GOOD (  20.89  )
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


>>> Hi,
>>>
>>> While testing Jens' for-next branch I encountered a use-after-free
>>> issue, triggered by test nvmeof-mp/002. This is not the first time I see
>>> this issue - I had already observed this several weeks ago but I had not
>>> yet had the time to report this.
>>
>> That is surprising because this area did not change for quite a while 
>> now.
>>
>> CCing linux-rdma as well, I'm assuming that this is with rxe?
>> Does this happen with siw as well?
> 
> Hi Sagi,
> 
> This happened with the siw driver. I haven't tried the rxe driver for a 
> while.
> 
> The crash addresses correspond to the following source file and line:
> 
> (gdb) list *(__ib_process_cq+0x11c)
> 0x7f7c is in __ib_process_cq (drivers/infiniband/core/cq.c:110).
> 105                                             budget - completed), 
> wcs)) > 0) {
> 106                     for (i = 0; i < n; i++) {
> 107                             struct ib_wc *wc = &wcs[i];
> 108
> 109                             if (wc->wr_cqe)
> 110                                     wc->wr_cqe->done(cq, wc);
> 111                             else
> 112                                     WARN_ON_ONCE(wc->status == 
> IB_WC_SUCCESS);
> 113                     }
> 114
> 
> (gdb) list *(nvme_rdma_create_queue_ib+0x1a7)
> 0x3d47 is in nvme_rdma_create_queue_ib (drivers/nvme/host/rdma.c:219).
> 214     {
> 215             struct nvme_rdma_qe *ring;
> 216             int i;
> 217
> 218             ring = kcalloc(ib_queue_size, sizeof(struct 
> nvme_rdma_qe), GFP_KERNEL);
> 219             if (!ring)
> 220                     return NULL;
> 221
> 222             /*
> 223              * Bind the CQEs (post recv buffers) DMA mapping to the 
> RDMA queue
> 
> (gdb) list *(nvme_rdma_destroy_queue_ib+0x1b8)
> 0x2388 is in nvme_rdma_destroy_queue_ib (drivers/nvme/host/rdma.c:358).
> 353             kfree(ndev);
> 354     }
> 355
> 356     static void nvme_rdma_dev_put(struct nvme_rdma_device *dev)
> 357     {
> 358             kref_put(&dev->ref, nvme_rdma_free_dev);
> 359     }
> 360
> 361     static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
> 362     {
> 
> Shouldn't ib_drain_qp() be called before nvme_rdma_destroy_queue_ib() 
> destroys the QP?

Yes it absolutely should, and it is according to the code.
The only way that this can happen is something happens to
post a wr after the drain started, can't see how this happens though...


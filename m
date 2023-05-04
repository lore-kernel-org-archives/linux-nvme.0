Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56583C77B78
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u3KcQWfcEfuU8d7VvNaVbSISjQ65iS19k5Xlvsk0sOI=; b=cZCVqJiQO3/5U29gMi+uQxTAB0
	riuHwg5hr5aSukFo9RDkHGXguRtYRVGobrFasbZbCMjrzS5D8gsUabLjYW4WanBi/H+W9IJvOW/tF
	f525zFYoihpKbGchtD/z8HNW76aJsPW6cb9HXDhh8TObCBu/mWO6czUOCWCwfU4Gt09oaTyH8vuFS
	heWvsNAJidA9xkqWBwNV3STvBk5sWTVqxAdWBIaKUtQRZm1+y95y1i+hKiUxT3bTHoFvKQj2/RmGV
	I2yP8ZAyPygKTB4yit7cFaqyk70amk8QbtiX4ApP3dVbsgVkLdBBSvm0Y8wFA4WyrA0SjceShMGNj
	N2YXLNHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pub3c-008EwV-2G;
	Thu, 04 May 2023 15:39:48 +0000
Received: from mail-pf1-f179.google.com ([209.85.210.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pub3X-008EvT-34
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 15:39:47 +0000
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64115e652eeso13414947b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 08:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683214782; x=1685806782;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3KcQWfcEfuU8d7VvNaVbSISjQ65iS19k5Xlvsk0sOI=;
        b=fftUFNOUUNxwDjTdbMVCvHD7XcKxeDWbQMogxdWt9JvCD/1sZYueDtlsitgoocFo1w
         onblS+wOEfGTdPVbsno6U/0BS8slItZM9GKQz5quyIe0OHUVOM9eMSfX8ZbC7OZCWN8k
         AyJLAiNTn7Kywrvg9TDkN150WbgoqxcofOzpW5jS8XKAd+pVi68AfTN6vF+XPK7D91j2
         utVhgCW+3mRufnk1iBBlA2Z44QZZAeBCHyesW/UIVQBmjBpgeFghVOtQyTYO9hPg2Q2j
         m0jAYmiVa/G2ixEVE5fOuMoBJYR6AY7uUXLAB44thtJTpMWXTaH1UAiBitba4YVM4hNz
         oTYA==
X-Gm-Message-State: AC+VfDzjtH1zudjz/KV+PRBrFX11LKq450AAZqnzPLA2GcFUzo7M3cp6
	v/WjWUfVJURR4xPqfwMMkgfnMuQ6kkA=
X-Google-Smtp-Source: ACHHUZ6YiK4SWw3Hmpkp9xkkSu4AS58STttmsTfABq76o1JKdw+YET1KkR2bjo1A75L6xxKmC3pRjQ==
X-Received: by 2002:a17:903:22cf:b0:1a9:a032:3844 with SMTP id y15-20020a17090322cf00b001a9a0323844mr4594468plg.16.1683214781499;
        Thu, 04 May 2023 08:39:41 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902690c00b001a6a6169d45sm23734737plk.168.2023.05.04.08.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:39:41 -0700 (PDT)
Message-ID: <4dad4f76-1270-f45a-882d-3b2ecce817e5@acm.org>
Date: Thu, 4 May 2023 08:39:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: slab-use-after-free in __ib_process_cq
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <d9da387d-b497-5120-5251-0c5d6a4adb71@acm.org>
 <bca0fb81-38ae-f022-1270-70c7e415ac41@grimberg.me>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bca0fb81-38ae-f022-1270-70c7e415ac41@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_083943_989549_5A87F6E5 
X-CRM114-Status: GOOD (  18.50  )
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

On 5/4/23 01:32, Sagi Grimberg wrote:
> 
>> Hi,
>>
>> While testing Jens' for-next branch I encountered a use-after-free
>> issue, triggered by test nvmeof-mp/002. This is not the first time I see
>> this issue - I had already observed this several weeks ago but I had not
>> yet had the time to report this.
> 
> That is surprising because this area did not change for quite a while now.
> 
> CCing linux-rdma as well, I'm assuming that this is with rxe?
> Does this happen with siw as well?

Hi Sagi,

This happened with the siw driver. I haven't tried the rxe driver for a while.

The crash addresses correspond to the following source file and line:

(gdb) list *(__ib_process_cq+0x11c)
0x7f7c is in __ib_process_cq (drivers/infiniband/core/cq.c:110).
105                                             budget - completed), wcs)) > 0) {
106                     for (i = 0; i < n; i++) {
107                             struct ib_wc *wc = &wcs[i];
108
109                             if (wc->wr_cqe)
110                                     wc->wr_cqe->done(cq, wc);
111                             else
112                                     WARN_ON_ONCE(wc->status == IB_WC_SUCCESS);
113                     }
114

(gdb) list *(nvme_rdma_create_queue_ib+0x1a7)
0x3d47 is in nvme_rdma_create_queue_ib (drivers/nvme/host/rdma.c:219).
214     {
215             struct nvme_rdma_qe *ring;
216             int i;
217
218             ring = kcalloc(ib_queue_size, sizeof(struct nvme_rdma_qe), GFP_KERNEL);
219             if (!ring)
220                     return NULL;
221
222             /*
223              * Bind the CQEs (post recv buffers) DMA mapping to the RDMA queue

(gdb) list *(nvme_rdma_destroy_queue_ib+0x1b8)
0x2388 is in nvme_rdma_destroy_queue_ib (drivers/nvme/host/rdma.c:358).
353             kfree(ndev);
354     }
355
356     static void nvme_rdma_dev_put(struct nvme_rdma_device *dev)
357     {
358             kref_put(&dev->ref, nvme_rdma_free_dev);
359     }
360
361     static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
362     {

Shouldn't ib_drain_qp() be called before nvme_rdma_destroy_queue_ib() destroys the QP?

Thanks,

Bart.



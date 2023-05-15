Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A98BC77B7D
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vQz9PfKyXAXDhM0v2AXK8wfd5FHexOQ/lnJY7JhPaSc=; b=dv5APYnHlavyIda/YmdPqjkl8r
	/ZPVZMPmROeOLHYvjo80TcV5uRYfvSzVTipcxORVMkaC/MBwQLeeWdGJR4k2rmtlEIjAYpG8+oZKS
	UEv4YaZEMF1ZAclZBPPZUdakOpglQflWYhjY9whoDq7d1VkKoaIpPs1fnFCtpsEvNeCxvuH9mJiFM
	qvvN/LlYgvBev1T+K+6e1v+/7Re14LQgq7nA7yJAWJgUUr4lAcqFljQul2sjwkm7LZwyXvn6fj6k2
	mBCfLkzFylxN6Mg82j0hn1oZ9pupfNQkh4qFaQUZxV/ZK97wD/Y+Y8FySL3Bh6fVqP9AqBnCH5DJA
	c1QfWZVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyc0l-002wkQ-0E;
	Mon, 15 May 2023 17:29:27 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyc0i-002wjE-1F
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 17:29:25 +0000
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1aaf7067647so88996775ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 May 2023 10:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684171763; x=1686763763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQz9PfKyXAXDhM0v2AXK8wfd5FHexOQ/lnJY7JhPaSc=;
        b=DWXrTr3pxYpozYI7oqMYv3iGy+/0GTtrdeyQmgNR3qSOqcI9BmrBBlPTFK0Kd6bZbG
         4LZDzCHn3cMEjMyJWD0/2jD2SCxzaOrH5erO/yFR+xb5H8j3WxP6CEiN+ctstFt20HZW
         q1o7bNLVLWvNEQwLnwlUe50KDBzjhEro7TBSn9/xlKAPiHf4JdBiTz81Ch95MJW3Beiv
         gQ/5abRqNe54dGOPIhjp8PoDBjkBopF+QyVXga4r41IoEKF4NuCk9DeYQ4NeQkbSwigA
         38X5uy2uOBORP6i3wQwvGhQJayPY0zA6Nz7uY+y6WjTs5o/x4oixq4KU/H0A621gvYSB
         8Flw==
X-Gm-Message-State: AC+VfDzJXERa1gt3wiKQIE+/JssP6hmZmwUhVuCRGma9r7ZAUr3FkPfm
	PRDyHucK+DP2vvqCZiOuwyo=
X-Google-Smtp-Source: ACHHUZ7Ps6TW2iJaMIMLo1Fm9l0tL4mgarp+nGLiSgJeQ1If0O14LnwUJ7GzLawD28YUXhnUx0VYSQ==
X-Received: by 2002:a17:902:b405:b0:1a5:a1b:bbd8 with SMTP id x5-20020a170902b40500b001a50a1bbbd8mr33599793plr.45.1684171762601;
        Mon, 15 May 2023 10:29:22 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902820100b0019e60c645b1sm13841420pln.305.2023.05.15.10.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 10:29:22 -0700 (PDT)
Message-ID: <55b907dd-5fe4-965c-7b0a-8cbce73b9b28@acm.org>
Date: Mon, 15 May 2023 10:29:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet-rdma: Release connections synchronously
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
References: <20230511150321.103172-1-bvanassche@acm.org>
 <c7pbds22dwwpeozqqf3p5oqvyrkmo6nwhgtz67o6l2snll4mul@sb2el6jyif6w>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c7pbds22dwwpeozqqf3p5oqvyrkmo6nwhgtz67o6l2snll4mul@sb2el6jyif6w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_102924_421304_6A031226 
X-CRM114-Status: GOOD (  20.88  )
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

On 5/14/23 03:38, Shinichiro Kawasaki wrote:
> Bart, thanks for the v2 patch. I applied to kernel v6.3 and ran blktests nvme
> test group with siw transport. Unfortunately, I observed test process hang at
> nvme/003 [1]. The kernel reported lockdep WARN of id_priv->handler_mutex. The
> patch adds the "from_cm_handler" argument to __nvmet_rdma_queue_disconnect() to
> skip rdma_destroy_id() if the call is from CM handler. However,
> rdma_destroy_id() is still called in the call path below:
> 
> __nvmet_rdma_queue_disconnect()
>    nvmet_rdma_free_queue()
>      nvmet_rdma_destroy_queue_ib()
>        rdma_destroy_id()
> 
> So I think, the from_cm_handler should be added to nvmet_rdma_free_queue() and
> nvmet_rdma_destroy_queue_ib() also, so that from_cm_handler is propagated and
> rdma_destroy_id() is not called in nvmet_rdma_destroy_queue_ib(). I created a
> quick patch with this approach [2], and observed it avoids the process hang.
> 
> However, when I did further test using the v2 patch and the fix [1], I observed
> another process hang at nvme/009 [3]. This time, deadlock of subsys->lock
> happened in nvmet_ctrl_free(). I created a dirty patch to avoid it [4], but it
> caused lockdep WARN for possible deadlock between subsys->lock and
> id_priv->handler_mutex. I also observed hang at nvme/044 related
> nvmet_fatal_error_handler.

Hi Shinichiro,

We must be running different tests since the issues discovered by your 
tests did not show up in my tests. Anyway, I think this is a good time 
to ask for feedback from the NVMe maintainers. The only approach I see 
to suppress the lockdep complaints triggered by test nvme/003 about the 
NVMe RDMA transport driver is to something like patch [4]: track the 
owner of subsys->lock, find all code paths that could trigger recursive 
locking and make sure that recursive locking is not triggered. Does 
everyone agree with this approach?

Thanks,

Bart.


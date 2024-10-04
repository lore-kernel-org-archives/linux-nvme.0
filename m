Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C564CF34DC
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 02:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ymFwru73XfTHz1sVaFBcyx39mulsMFBjrH0H1o5NdvA=; b=VcQPPyeKXGbzdzcIAMW+a3DJyE
	l9lPDAOlkuyWQReIJQ1l6B87k9K3H3fBUlqAykfJBWArW5XDxCTT0q/U4HxZa2Kp8gl1YOq8skWgi
	YaT0Jzl04QZtZ2J0N5/OhtQnpf17v/SuTF2nWg5JLVR12h5JDkJgwIsiyWLeChvHUC+VDTlYvINZn
	ID7Ar5w9u55i5e9KfWODvODrelw+UbZMPhEjbMITujbU0KSQY8jMxrCfElDQAJaxamIlQ6fA4Sxg0
	NCL/cjNxBxx922bofqc8HarZGIKi+JA5Z59QuaB4J6KEooZBiLLn9/HvoU1o2uLuro+wJWhQxMEEd
	nEsDucww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swYAj-0000000Asr2-1nVM;
	Fri, 04 Oct 2024 02:36:01 +0000
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swYAf-0000000AsqR-3V7W
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 02:36:00 +0000
Message-ID: <734623a7-c8c3-46f9-a564-c2265fb79ff1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728009352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymFwru73XfTHz1sVaFBcyx39mulsMFBjrH0H1o5NdvA=;
	b=iApDyG15i7FbLMDIaZ0ZF8bgQoeL5WtU9qypE2SWWluHBERlWAX1PAeLeixqM3x2/vlLXz
	JmdkYvjWUHZ52QioGrHtACKhxMKA09aiMLw/gFN8fLM7S39gAXE/20uuPsb7b7dBYnauqq
	p/ll/LjrmZPnOGg1ZkIWU4d3hlYja9k=
Date: Fri, 4 Oct 2024 10:35:33 +0800
MIME-Version: 1.0
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_193558_388563_929B68AD 
X-CRM114-Status: GOOD (  18.43  )
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

在 2024/10/4 4:56, Bart Van Assche 写道:
> On 10/3/24 1:02 AM, Shinichiro Kawasaki wrote:
>> #3: srp/001,002,011,012,013,014,016
>>
>>     The seven test cases in srp test group failed due to the WARN
>>     "kmem_cache of name 'srpt-rsp-buf' already exists" [4]. The 
>> failures are
>>     recreated in stable manner. They need further debug effort.
> 
> Does the patch below help?

Hi, Bart

What is the root cause of this problem?

The following patch just allocates a new memory with a unique name. Can 
we make sure that the allocated memory is freed?

Does this will cause memory leak?

Thanks,
Zhu Yanjun

> 
> Thanks,
> 
> Bart.
> 
> 
> Subject: [PATCH] RDMA/srpt: Make kmem cache names unique
> 
> Make sure that the "srpt-rsp-buf" cache names are unique. An example of
> a unique name generated by this patch:
> 
> srpt-rsp-buf-fe80:0000:0000:0000:5054:00ff:fe5e:4708-enp1s0_siw-1
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ 
> ulp/srpt/ib_srpt.c
> index 9632afbd727b..c4feb39b3106 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2164,6 +2164,7 @@ static int srpt_cm_req_recv(struct srpt_device 
> *const sdev,
>       u32 it_iu_len;
>       int i, tag_num, tag_size, ret;
>       struct srpt_tpg *stpg;
> +    char *cache_name;
> 
>       WARN_ON_ONCE(irqs_disabled());
> 
> @@ -2245,8 +2246,13 @@ static int srpt_cm_req_recv(struct srpt_device 
> *const sdev,
>       INIT_LIST_HEAD(&ch->cmd_wait_list);
>       ch->max_rsp_size = ch->sport->port_attrib.srp_max_rsp_size;
> 
> -    ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", ch- 
>  >max_rsp_size,
> +    cache_name = kasprintf(GFP_KERNEL, "srpt-rsp-buf-%s-%s-%d", src_addr,
> +                   dev_name(&sport->sdev->device->dev), port_num);
> +    if (!cache_name)
> +        goto free_ch;
> +    ch->rsp_buf_cache = kmem_cache_create(cache_name, ch->max_rsp_size,
>                             512, 0, NULL);
> +    kfree(cache_name);
>       if (!ch->rsp_buf_cache)
>           goto free_ch;
> 
> 



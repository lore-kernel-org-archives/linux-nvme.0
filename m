Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52497C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Mar 2022 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FtjmnHvh0hCE1xqoneTwDb4xc241LUKfoEwOGLnvSqs=; b=q36uLOU88SdsMDQOlF32joiLh/
	HznQSSnTccFqgVeTJiL39ZI5cmkrfqsNl/wIzzi3FDAS+AJj3NJqfoftTFDh9VC/iiWypX6m3SuEt
	lfFxMSuPyZ8hobdtxUS+BSpnH1d2m0kUfjJNY2GChbFwTX8GSXztmdJsOJf3woHPT+5fp9VOk0OfQ
	4Hwb2xviGQGH1b0NKZeMTrdTCAbJqqGTXgEbZt5wgZ3GUu2Nl+M01dtpOf60bdboYPwPars5tzL4Q
	+2zGbwBtPx+ZLG3JkWx9/nmfGg3rEcFil8l/r5tQ30ars60xO5TCF+SWJxNXk71dku3YSpsi8KfsT
	vXQRf6rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXjHB-00264B-18; Fri, 25 Mar 2022 12:42:45 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXjH8-00263T-Vl
 for linux-nvme@lists.infradead.org; Fri, 25 Mar 2022 12:42:44 +0000
Received: by mail-wr1-f46.google.com with SMTP id r13so10697121wrr.9
 for <linux-nvme@lists.infradead.org>; Fri, 25 Mar 2022 05:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FtjmnHvh0hCE1xqoneTwDb4xc241LUKfoEwOGLnvSqs=;
 b=MuHEW7fFlpBJ8saapK56/z88mAWwaYsUm1Vlmwl7fYByC7OQKYt3dl7B0fHmDqeFWO
 wwOj7cbEeMHgh89XNsxQ303iaXj1qdRKmIAj10kKXu+hXMyt1DIK0dnFHfWuVhGbwo2l
 /blDwPm3AGvY7iQVUwdug0MJQ41gzcexvo2FznVJa00P4INIYD0PeY6fwC9+QiYleqLL
 JGtDYg6PfM7EQUBTVrAG/bX8v7Wo7lxy7JAbW4Q66vKEmFjPZLHxRlsz3jsLcCcZxOTn
 JNyizvT96J6Y9f53ZZXit0O7cm7BcmV2sh6Pup0mPpfo5Nie98RSa9HDOz4o/JzueE1t
 BN+A==
X-Gm-Message-State: AOAM531JXxdJqi2p3i3GeparGQeCQoWgTcY3v6N+6ZizVjSWZhZIWgnx
 T5qk8sVJgCyz/03EXgfISCw=
X-Google-Smtp-Source: ABdhPJwi5RTkQtYbPG4n3j9MLGwgl3WlXFiFKXsg5XNbFts9tQkwA5SHoOlmvcjrVTY0VaUOveB8Gw==
X-Received: by 2002:a05:6000:178d:b0:205:465d:8a0c with SMTP id
 e13-20020a056000178d00b00205465d8a0cmr9032776wrg.647.1648212160362; 
 Fri, 25 Mar 2022 05:42:40 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c12c800b0038cc2b67c97sm4117264wmd.19.2022.03.25.05.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Mar 2022 05:42:38 -0700 (PDT)
Message-ID: <28946544-111c-63eb-3b13-ad48113df4ec@grimberg.me>
Date: Fri, 25 Mar 2022 15:42:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] nvme: fix RCU hole that allowed for endless looping
 in multipath round robin
Content-Language: en-US
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: lengchao@huawei.com, dwagner@suse.de, hare@suse.de, mlombard@redhat.com,
 jmeneghi@redhat.com
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-4-cleech@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220321224304.955072-4-cleech@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220325_054243_058668_03A2EF15 
X-CRM114-Status: GOOD (  18.21  )
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



On 3/22/22 00:43, Chris Leech wrote:
> Make nvme_ns_remove match the assumptions elsewhere.
> 
> 1) !NVME_NS_READY needs to be srcu synchronized to make sure nothing is
>     running in __nvme_find_path or nvme_round_robin_path that will
>     re-assign this ns to current_path.
> 
> 2) Any matching current_path entries need to be cleared before removing
>     from the siblings list, to prevent calling nvme_round_robin_path with
>     an "old" ns that's off list.
> 
> 3) Finally the list_del_rcu can happen, and then synchronize again
>     before releasing any reference counts.
> ---
>   drivers/nvme/host/core.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fd4720d37cc0..20778dc9224c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3917,6 +3917,15 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	set_capacity(ns->disk, 0);
>   	nvme_fault_inject_fini(&ns->fault_inject);
>   
> +	/* ensure that !NVME_NS_READY is seen
> +	 * to prevent this ns going back in current_path
> +	 */
> +	synchronize_srcu(&ns->head->srcu);
> +
> +	/* wait for concurrent submissions */
> +	if (nvme_mpath_clear_current_path(ns))
> +		synchronize_srcu(&ns->head->srcu);

Can you describe how the unconditional srcu is protecting
something that is not protected with the one under clearing
the current_path?


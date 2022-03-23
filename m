Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942B4C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cvfO8yCrw9UQNR0Hs1Y6zpQpVFIG+6QXkkpxOqHXEHs=; b=kuYXVGGt3mNKyCSqjDjksDJgP2
	s8brq5S41kZ4YR+CwlqWFlPgAhSfYy99h3AxW9JJLZgRk4B0sVHFu1ScW7w2lBDCeze9nOdq1SweI
	is68opTNrtZ5kzQWpNwE4oUGra6Wi8vUTo5uiRrrTzrtoCEVE2uLg89Tf4O7csRott8vMVzD8CNPo
	YT+K9sIDX6WIx5iWjFhOs5ErZfIZURbfHxrECG1GYlqBt7T7Ui7802JJbD/lh+Q9IkMfRjUosbQpe
	V0LlCIZBPRLYrIIGjpqVeosORpOdxkSzkEiwCEnK/CtxihmUhGHKqvfA58x+BpR28phDU9OhtS/+c
	2WEIwIiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX2Ne-00DyDV-LQ; Wed, 23 Mar 2022 14:54:34 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX2Nb-00DyD2-NM
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 14:54:33 +0000
Received: by mail-wr1-f41.google.com with SMTP id u3so2516278wrg.3
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 07:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cvfO8yCrw9UQNR0Hs1Y6zpQpVFIG+6QXkkpxOqHXEHs=;
 b=OSn8Qo3lp4MwSbXBz6STsLRJHaAZBQw3OiVKZ65AxRExUTMkmQ+BxMVW2Gb5ro2qCm
 jOS781y6svFXghT0HvzvfY8OhcrmowG7XeAXPLHLe/bRv6eybX1LUsa4G4pSBpBqTKfp
 hxq4kxa8HaZx46z04kcYZ0oaByMZzppT2NMi1yJ/YXR7wV7Dyiz6Zqu8FYw+WY2/Kdey
 UwoIlUev9H1F/M7JjVjQ3pr/IdEa57fnNlHzzIBvWsPhyXm0lZPNQFrm6HED6GEAzizL
 edFy4pq7WAwVOftpoBFAKuTgDjB1AD76cmg62ZKdjD4zUbAcUKP64UfMmlbSBIvoefNE
 AN0g==
X-Gm-Message-State: AOAM530K7bCKgnpOs3kqYEDbKeDD0kkxOJ9NS76inQpCL9YpGj610L8L
 gRU+wPG37sLhw4qXcIkyCcI=
X-Google-Smtp-Source: ABdhPJwWaKZ03Nxe/lDSzYzKWJpMHO5kvY1XbrTkHwwpaIZm+EWBvIREEmoyFhQaEv3esxkCHkoQdg==
X-Received: by 2002:a5d:64a2:0:b0:205:8ab3:4fdc with SMTP id
 m2-20020a5d64a2000000b002058ab34fdcmr191810wrp.168.1648047269051; 
 Wed, 23 Mar 2022 07:54:29 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 g6-20020adfd1e6000000b0020581602ddfsm134921wrd.90.2022.03.23.07.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 07:54:28 -0700 (PDT)
Message-ID: <7d9771f2-d86c-25e5-5bee-504e33c5aae7@grimberg.me>
Date: Wed, 23 Mar 2022 16:54:26 +0200
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
X-CRM114-CacheID: sfid-20220323_075431_795799_2C7FA843 
X-CRM114-Status: GOOD (  19.14  )
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

Nothing prevents it from being reselected again.
This is what drove the placement of this after the
ns is removed from the head->list. But that was before
the selection looked into NVME_NS_READY flag...

This looks legit to me...


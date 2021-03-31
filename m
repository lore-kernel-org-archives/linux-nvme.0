Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E07DC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 23:41:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BC761006
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 23:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BC761006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3wgtrqr63+1qevJX0Vxttnv9/IQG3jv2G72vg/+9fLg=; b=nh1mZg75qQDLzJmqSZubBFs0z
	6OvQn4AWSyQVyO8te/iHMkssLgZ4AqQ3lLvnxhpppRprjoGvBcQwCNEGK0nl73Cf6b8B6PhWDDnZO
	7E/wD6QRFeetWZGSqi9T9p/tjalBngpyJWy46m4xFovjfv58QbQRY4qy3GrEBHmQhVqZ5odeB1ONQ
	lh2cMVchgkZgEbQttOUlzl/uGnfkcw5DsUtTZFKPos30EH43+Vsh5TToQ7TiA1POs5WJNQ0N4QXjK
	D3SVmasu3vNMtYGTa8p3RV3mX6ksnvtLVJrds/LBQBPniG1KkBcrElU6oSJYOWpuI6F8lyGdkY78q
	YTboZm/jQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRkSG-007ykW-LW; Wed, 31 Mar 2021 23:40:56 +0000
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRkSA-007yk4-9R
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 23:40:52 +0000
Received: by mail-pj1-f49.google.com with SMTP id gb6so136424pjb.0
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 16:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1SLik9xxcYS9hB+dsDYl+ldQsZJPJtDStF89KiAnJhA=;
 b=jw4L8kmHQWnj6Pqt4k0hly75RiQq7RZNl+w8EShBZe3LsbKe86THWJj2f8tDL88I28
 0Tv6rSzKTErkkCNiSdB7y9KAOrMgQ0jgI5UZgTEHFKvwGS/OSrI9r3nSH0tXVojgPRgH
 nTrNI+HORi7LqF0s3lRrs1uHjNR4WKzvClpur6B2XdIcg2X7++Uhu49OB3FUwrmO8+kW
 9HLDeg5NYIxhySF/VyexpjmuZgZxmGM2J1qiBUBYlL3FaKXNV3sOc98t5QfEQ4UZf19P
 xwUkTtvC0DSuPi1ZT0WrGJHOlMTvD407QVzVKVPxctSOS3/yYyCeoirPwKgMyrFPHyHR
 iYSg==
X-Gm-Message-State: AOAM533c7RJPHCMEGuoONwdjpBqaj4oPmvuGkXb4Gv4v9vw6UydcBdYV
 hDISB0h4ahkntNLIPJz6rVI=
X-Google-Smtp-Source: ABdhPJxGHIUqkTSmQQ1TcvrNI75/pZ2YsSTW0VS4h21LsL36T0O72iZQGfbderHR5lQTOyLMvz6VcA==
X-Received: by 2002:a17:90a:c249:: with SMTP id
 d9mr5931367pjx.104.1617234047498; 
 Wed, 31 Mar 2021 16:40:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc?
 ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
 by smtp.gmail.com with ESMTPSA id p17sm3257326pfn.62.2021.03.31.16.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 16:40:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-mpath: delete disk after last connection
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20210331145351.35926-1-hare@suse.de>
 <20210331145351.35926-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5f5ef773-8b53-9121-fec1-2f972962f3ad@grimberg.me>
Date: Wed, 31 Mar 2021 16:40:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331145351.35926-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_004050_443684_FC44D2EB 
X-CRM114-Status: GOOD (  31.23  )
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



On 3/31/21 7:53 AM, Hannes Reinecke wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The multipath code currently deletes the disk only after all references
> to it are dropped rather than when the last path to that disk is lost.
> This has been reported to cause problems with some usage, like MD RAID.
> 
> Delete the disk when the last path is gone. This is the same behavior we
> currently have with non-multipathed nvme devices.
> 
> The following is just a simple example that demonstrates what is currently
> observed using a simple nvme loop back (loop setup file not shown):
> 
>   # nvmetcli restore loop.json
>   [   31.156452] nvmet: adding nsid 1 to subsystem testnqn1
>   [   31.159140] nvmet: adding nsid 1 to subsystem testnqn2
> 
>   # nvme connect -t loop -n testnqn1 -q hostnqn
>   [   36.866302] nvmet: creating controller 1 for subsystem testnqn1 for NQN hostnqn.
>   [   36.872926] nvme nvme3: new ctrl: "testnqn1"
> 
>   # nvme connect -t loop -n testnqn1 -q hostnqn
>   [   38.227186] nvmet: creating controller 2 for subsystem testnqn1 for NQN hostnqn.
>   [   38.234450] nvme nvme4: new ctrl: "testnqn1"
> 
>   # nvme connect -t loop -n testnqn2 -q hostnqn
>   [   43.902761] nvmet: creating controller 3 for subsystem testnqn2 for NQN hostnqn.
>   [   43.907401] nvme nvme5: new ctrl: "testnqn2"
> 
>   # nvme connect -t loop -n testnqn2 -q hostnqn
>   [   44.627689] nvmet: creating controller 4 for subsystem testnqn2 for NQN hostnqn.
>   [   44.641773] nvme nvme6: new ctrl: "testnqn2"
> 
>   # mdadm --create /dev/md0 --level=mirror --raid-devices=2 /dev/nvme3n1 /dev/nvme5n1
>   [   53.497038] md/raid1:md0: active with 2 out of 2 mirrors
>   [   53.501717] md0: detected capacity change from 0 to 66060288
> 
>   # cat /proc/mdstat
>   Personalities : [raid1]
>   md0 : active raid1 nvme5n1[1] nvme3n1[0]
>         64512 blocks super 1.2 [2/2] [UU]
> 
> Now delete all paths to one of the namespaces:
> 
>   # echo 1 > /sys/class/nvme/nvme3/delete_controller
>   # echo 1 > /sys/class/nvme/nvme4/delete_controller
> 
> We have no path, but mdstat says:
> 
>   # cat /proc/mdstat
>   Personalities : [raid1]
>   md0 : active (auto-read-only) raid1 nvme5n1[1]
>         64512 blocks super 1.2 [2/1] [_U]
> 
> And this is reported to cause a problem.
> 
> With the proposed patch, the following messages appear:
> 
>   [  227.516807] md/raid1:md0: Disk failure on nvme3n1, disabling device.
>   [  227.516807] md/raid1:md0: Operation continuing on 1 devices.
> 
> And mdstat shows only the viable members:
> 
>   # cat /proc/mdstat
>   Personalities : [raid1]
>   md0 : active (auto-read-only) raid1 nvme5n1[1]
>         64512 blocks super 1.2 [2/1] [_U]
> 
> Reported-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c      | 5 ++++-
>   drivers/nvme/host/multipath.c | 1 -
>   drivers/nvme/host/nvme.h      | 2 +-
>   3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4..ee898c8da786 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -542,7 +542,10 @@ static void nvme_free_ns_head(struct kref *ref)
>   	struct nvme_ns_head *head =
>   		container_of(ref, struct nvme_ns_head, ref);
>   
> -	nvme_mpath_remove_disk(head);
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (head->disk)
> +		put_disk(head->disk);
> +#endif

Hannes, maybe make that nvme_mpath_put_disk(head) and place an empty
stab in nvme.h like we do for other mpath variants?

Other than that, patch looks good, so you can add to the respin
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

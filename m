Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DDDC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 10:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZ5NWPW8zD/DGE78gIkPjgDX1z8rK+EluUZKPvNMcPE=; b=XyMkivT1W1afg32LopK5IEj9M/
	0kp71mer9z9rA8ASCVWefTt1uCMUI3Y5rPrslRqNFOGQhd8aZDbTK4v/yE8NMa8CjbW0p1+X9Luts
	Gd+YGnnDYFo/LMZ0A6Srp/8hnaurmjV0T5sl4Zv7FBNVlbyCX7WA4bLvT6fY17x8exlEjGebIADXK
	+e7a+DKR5Z9wBYKAEqulej2MQiIL/8WmPig0q+Mv0VLN+xN41fSTzrFiwegsmai66bwIaqFm5jTO4
	iKk/EN5DeGF/VgUue6iVs13xFZH1YMaaXhlSOKGR+YUiP3flC4f55HGQi1E9bk9f0Bb5Qx5J6JMgs
	Ndogsytg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndrgh-008WiS-Mk; Mon, 11 Apr 2022 10:54:27 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndrge-008WfW-HW
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 10:54:26 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 ay36-20020a05600c1e2400b0038ebc885115so814629wmb.1
 for <linux-nvme@lists.infradead.org>; Mon, 11 Apr 2022 03:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HZ5NWPW8zD/DGE78gIkPjgDX1z8rK+EluUZKPvNMcPE=;
 b=yUIKJ+8zJf1f2UreoBgpdOR0X9LGckomo7Cq7u6ZoNziy4wrKjcW7e/3zTMruHUp9h
 /VcA9GFlajdALD/pSpx2erGEXazymOphq2q//ppkxx1HXPPmdseUaB+P06jC5sY1Lznl
 wzXc3QQi6sZkGOrsx3fYlvAC1EzO1txMiHJ4i/t5In/4mkRg/VZjsj4t9judILH4aYbz
 00gb88mKI9R9F4aUJuj3D3B7kUgfLelHhd3f6J71LbZCpP7ACRrNu9o5FwTMuPSjnWaV
 +VkPSXV4yyt/wg7ASyDAvN4UFX7o2I7MdHPLFFLjhtOjt79pBGRor2zVFSu5o0HiFno0
 ngeQ==
X-Gm-Message-State: AOAM532XPWgyHWP/L76UNLxRZFF2vJBcSlmclAaA+8AVnT4YDMK5g+Wz
 4ljf2Xzjcgr0bO1+SCCWJBk=
X-Google-Smtp-Source: ABdhPJzv0XT9yVgxvXVXoRrSrT3fLQuSmNDQHARlWvNg59e9/29zXvZ0mYc/XULg9bSxg3n7jZfnrQ==
X-Received: by 2002:a05:600c:1c24:b0:38e:a2c2:9f6f with SMTP id
 j36-20020a05600c1c2400b0038ea2c29f6fmr14627542wms.69.1649674460804; 
 Mon, 11 Apr 2022 03:54:20 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 t9-20020adfa2c9000000b002061561d4a7sm19536672wra.96.2022.04.11.03.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 03:54:20 -0700 (PDT)
Message-ID: <dddcb416-e4c8-b1d7-e893-416d819653dd@grimberg.me>
Date: Mon, 11 Apr 2022 13:54:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220408065930.123015-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_035424_650104_464B7EFB 
X-CRM114-Status: GOOD (  27.88  )
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


> When a per-port discovery subsystem is used we should include
> all configured ports in the discovery log page, not just that one
> through which the controller was connected.
> 
> - /
>    o- ports
>    | o- 1 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=8009]
>    | | o- subsystems
>    | |   o- nqn.discovery
>    | o- 2 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4420]
>    | | o- subsystems
>    | |   o- nqn.discovery
>    | |   o- nqn.io-1
>    | o- 3 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4421]
>    |   o- subsystems
>    |     o- nqn.io-2
>    o- subsystems
>      o- nqn.discovery
>      o- nqn.io-1
>      | o- namespaces
>      o- nqn.io-2
>        o- namespaces
> 
> A discovery on port 8009 will return information about
> - nqn.discovery at port 8009
> - nqn.discovery at port 4420
> - nqn.io-1 at port 4420
> A discovery on port 4420 will return the same information.
> A discovery on port 4421 will return information about
> - standard discovery subsystem on port 4421
> - nqn.io-2 on port 4421

This is a different functionality than supporting unique discovery
NQNs.

If I want in your example to use a unique discovery subsystem but to
report only on the port local I have to use two different unique
discovery subsystems. Which is different than the standard discovery
subsystem, why?

I'd submit to you that IMO unique discovery subsystems should not behave
differently than the standard discovery subsystem. Please explain why
do you think that unique discovery subsystems should behave differently
with respect to the content of the log page.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/discovery.c | 53 +++++++++++++++++++++++++++------
>   1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index 6b8aa6c4e752..ea8fce538342 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -149,6 +149,30 @@ static void nvmet_set_disc_traddr(struct nvmet_req *req, struct nvmet_port *port
>   		memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
>   }
>   
> +/*
> + * discovery_port_match - filter eligible ports for discovery log page
> + *
> + * If the port through which the controller is connected has no discovery
> + * subsystem linked, use the original behaviour of just including information
> + * about that port in the discovery log page.
> + * Otherwise include information about all ports into which the specified
> + * discovery subsystem is linked.
> + */
> +
> +static bool discovery_port_match(struct nvmet_req *req, struct nvmet_port *r)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +
> +	if (!req->port->disc_subsys) {
> +		if (r != req->port)
> +			return false;
> +	} else {
> +		if (ctrl->subsys != r->disc_subsys)
> +			return false;
> +	}
> +	return true;
> +}
> +
>   static size_t discovery_log_entries(struct nvmet_req *req)
>   {
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> @@ -159,10 +183,14 @@ static size_t discovery_log_entries(struct nvmet_req *req)
>   	if (!req->port->disc_subsys)
>   		entries++;
>   
> -	list_for_each_entry(p, &req->port->subsystems, entry) {
> -		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
> +	list_for_each_entry(r, nvmet_ports, global_entry) {
> +		if (!discovery_port_match(req, r))
>   			continue;
> -		entries++;
> +		list_for_each_entry(p, &r->subsystems, entry) {
> +			if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
> +				continue;
> +			entries++;
> +		}
>   	}
>   	list_for_each_entry(r, &req->port->referrals, entry)
>   		entries++;
> @@ -226,14 +254,21 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
>   		numrec++;
>   	}
>   
> -	list_for_each_entry(p, &req->port->subsystems, entry) {
> -		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
> +	list_for_each_entry(r, nvmet_ports, global_entry) {
> +		nvmet_set_disc_traddr(req, r, traddr);
> +
> +		if (!discovery_port_match(req, r))
>   			continue;
>   
> -		nvmet_format_discovery_entry(hdr, req->port,
> -				p->subsys->subsysnqn, traddr,
> -				p->subsys->type, numrec);
> -		numrec++;
> +		list_for_each_entry(p, &r->subsystems, entry) {
> +			if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
> +				continue;
> +
> +			nvmet_format_discovery_entry(hdr, r,
> +					p->subsys->subsysnqn, traddr,
> +					p->subsys->type, numrec);
> +			numrec++;
> +		}
>   	}
>   
>   	list_for_each_entry(r, &req->port->referrals, entry) {


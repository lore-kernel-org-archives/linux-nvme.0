Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C990FC04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:18:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A887613E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A887613E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mQvwn4R0cx0Zm4+C4HuuzJjg4BRoB03orCeHKQUZ+5s=; b=oPpeWruFABPicOqe3h2oDycGbG
	RlA2NrwQ7a5Bgi6Yq/28doVaJQFQP05A03Br9mJHDhZxmJwhBOPsVfHhVr71H4dsxWbqKLawaPKhC
	S9pNd27utx9BpMkrYPyCXN7Iyaus0Y9MrQQ8ZxYEVr5zR7v9vsZYtw2QJMrQ0a3pivdB42Te9Xa2x
	xAczTo0sAnJAcvBg1qoHyDJ4J8xdAzbr2RahR6P7e3ZRQ5sx0giDcqJAIMiYcyVyPIfpkiGRiFxzs
	1JbjFNCybzMYrgJFDm0J4UF0/2jpRTdWTzOLp61ZlNr6usN7dqaulc4IGrJTrSCkMcqnciT1CSbN+
	z04D+HyA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkBaa-0010Im-0f; Fri, 21 May 2021 20:17:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkBaX-0010IL-2K
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 20:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=izylh3x5eWU+SSVYhe6qhquo6gNaabEEd/H/fKITtiI=; b=FXGxaymDDp+u1AorumHp73MQP9
 LUXihki7AVfXwP9xQ0PPk++RsAKjHkdlqkATnszi5eGWQgmttAHKA0fkZu4kc71oe/qSWN5HXNOxM
 CkAnkxo6NQPLkSwtXDLU12+olQFv/m3QbcmnCMRMOt7Djj4NG5CEM/Nfo58525S0GVGpDK6NUy3U+
 aIOPBsqxg3v1+h1AjbTfP4fCYohUP6K0Be5De8ZJhK/FxJxDi59L5rHeBNwXnrHKwlTylKhLhp1Zk
 TjBliKyRNe0Vtd1iS4MZCdDA3BN6A+GmGPVVWKWQNPaivkgmM4Y3yTWaO6E0d7WT2cE1R868XPpZE
 NxWIh3BQ==;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkBaU-00HP3G-Lb
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 20:17:39 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 n17-20020a7bc5d10000b0290169edfadac9so8073570wmk.1
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 13:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=izylh3x5eWU+SSVYhe6qhquo6gNaabEEd/H/fKITtiI=;
 b=pl0KfHiiZbu98KCpwRkAb05K2dHl9tsH2YXJKqdlzj//6xL2V6MjYKbqveoGROCdTz
 Cf65Lv/gtLURXad4v+rRtbsU7fT96sJkzNwrWbnUNCCg94bXBnSx7pbNtGArMHHbNIEA
 gARSJ/2FrbiI8p1jfJAUeDSiYMt6w9hSPUP6oUnfimyrD8oYB08t8l+PRTkQWE46+Bp8
 Mj8hLqKcr8on6PhZzl5OAK1wiko7iHw5oXy1MWrOR8brDVeFQbzOhbYbJsfv+/MksEG8
 EldIA7hJWzY8NGW+6q5OUP7A8zYHk6ARv9Ju3ncwHWrQi6n7cIJWLf4i4NKlUjddsLnG
 7GCg==
X-Gm-Message-State: AOAM533ds4rV3miLP356MD4PVy9Us30vZKW7hrSvjnJUsvok6quRVk2T
 QJSahf5GSxLjF6SsKN4tT0PjEH5Ka9Y=
X-Google-Smtp-Source: ABdhPJxYcgwgPGdTBxRaJNmDkv+TIIKEzz4rgs00lbVyUeeoxMpdONRp7iEpfATiRNirYWTfKTzIuA==
X-Received: by 2002:a1c:2456:: with SMTP id k83mr10301334wmk.87.1621628255829; 
 Fri, 21 May 2021 13:17:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id m10sm3172489wrr.2.2021.05.21.13.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 13:17:35 -0700 (PDT)
Subject: Re: [PATCH] nvme/fc: Short-circuit reconnect retries
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, James Smart
 <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20210521082300.146648-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4348b2a1-0861-0020-e873-0680812c4849@grimberg.me>
Date: Fri, 21 May 2021 13:17:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521082300.146648-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_131738_735105_53071956 
X-CRM114-Status: GOOD (  12.81  )
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


>   	if (recon && nvmf_should_reconnect(&ctrl->ctrl)) {
> @@ -3286,12 +3290,17 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>   
>   		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
>   	} else {
> -		if (portptr->port_state == FC_OBJSTATE_ONLINE)
> -			dev_warn(ctrl->ctrl.device,
> -				"NVME-FC{%d}: Max reconnect attempts (%d) "
> -				"reached.\n",
> -				ctrl->cnum, ctrl->ctrl.nr_reconnects);
> -		else
> +		if (portptr->port_state == FC_OBJSTATE_ONLINE) {
> +			if (status > 0 && (status & NVME_SC_DNR))
> +				dev_warn(ctrl->ctrl.device,
> +					 "NVME-FC{%d}: reconnect failure\n",

Maybe worth to print the status here?

Otherwise looks good,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

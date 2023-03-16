Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6642DC6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 13:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nxyb17UdI6xsq79AP29b7rtQj9x0o3CwTtWs8Uu7Zqw=; b=ndzDQC4PYMoSEpNm8Zmhu6HOJp
	h4WGoMPJQXau+ISB9rK5rzQh6ua8vWEAdj02lbV8JOBdw2y/HT6akL3rzMi2OF9baeNH+IlftkfCm
	MsgJq6X76Flne75HSBabRbkk2rbt8OPSAT+jTvZZDFkpDzcWy1yTd2Jf61LJGzszm/6iDLbCgiyOQ
	bcM+aWg+BP5WoZqb3eas1cSCkFyCKaUhoIBgjib5U0Bi7cluRCKTH9tZrYkp+zCgIc9nDwFfiWlCN
	u5qSWqcwps85i8sFlTfuqAtfLAi/IPqA3/qx6oxbXS1G39kxZHNGyZ08YaHXgD8rM4MqrMF5uXWjM
	vv9ZbpBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcnFQ-00GT0N-34;
	Thu, 16 Mar 2023 13:02:24 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcnFN-00GSzN-1O
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 13:02:23 +0000
Received: by mail-pf1-x42b.google.com with SMTP id ce7so1063260pfb.9
        for <linux-nvme@lists.infradead.org>; Thu, 16 Mar 2023 06:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678971739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxyb17UdI6xsq79AP29b7rtQj9x0o3CwTtWs8Uu7Zqw=;
        b=bwPoUbGImBC+LtmWBPXAWRz5EqDgzPdDG+p76bRvSoZcwV3q4ohCoPJToGYMPZv4sl
         lvYz22B13g7dTHrkIQf9jAfSfehqkPeRuwh5FHmIrgU7XRaLMfGxoCOau1eBbeEpOUph
         OvUnwoFEw1NrGZbFwMYX3XcmdvWDbjF3pG/8RaOAWyxLdMJget+zWDAoNO2CrKqu4pmy
         4GtXOmOjdWIBSz96NJnuUDxCxF7/jF1aD5ScS5x3FwBVHVxPW39NOYLpYA5gcFyF4oSH
         99lpLftfDDPy+v8mZ5n3s14pphyOTKIULf9ss+yzGxwiCH+Ls5vdf6QhcbGLMf31FL5O
         SqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678971739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxyb17UdI6xsq79AP29b7rtQj9x0o3CwTtWs8Uu7Zqw=;
        b=2imSGee2pnu4Xux2OITDdobmgRaiIUjTh/Xffc68TNc9Z/SIn6q68RU20ZRD9S/TdO
         HX7ttUH4go6alOSx6VxVNYBxIL0IlcOK++Czdxmri2iDQa/UmH1TU7qDfOG9qkrjfTf/
         i1k6mTwTRfcx7T+qirliI1/2OkrVjffHQEJqONpVaxTGZ1vENONB8bQOQiaSgrka1fFu
         Ldahq0x9N5tCU9tKCUujs0m21AMAM+ey6X7QAgKeAIorarP9Ur3WGAGwG4eTzJ+eZJMz
         /AIFIjmsD+jxl5ZLk6AKg7ylr4d7IzYGEmphi77fgH7rN3leVHK/eAclHUbyGddjhL/i
         Mfjg==
X-Gm-Message-State: AO0yUKW7OvwPb8DZGctKW9HbxoMqkXohbIT43/VroCWjd+8cSW6/i8PS
	mpLhiCOerLOTjd5Q4h6Q/4k8Mw==
X-Google-Smtp-Source: AK7set+NMNwz9a+w8f6tmXPmK22sIr9yMwz7zwUIdvgLv+67s/GQCptUlD6XApVb3j5/UQjjlJ4xhA==
X-Received: by 2002:a05:6a00:32c7:b0:5db:aa2d:9ea0 with SMTP id cl7-20020a056a0032c700b005dbaa2d9ea0mr3667693pfb.2.1678971739345;
        Thu, 16 Mar 2023 06:02:19 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c8-20020aa78e08000000b005a9bf65b591sm5433589pfr.135.2023.03.16.06.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:02:18 -0700 (PDT)
Message-ID: <75ddafed-cc97-1414-2d61-9fa5fb7266f1@kernel.dk>
Date: Thu, 16 Mar 2023 07:02:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.3
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <ZBLMMaLFyRsgOvGp@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZBLMMaLFyRsgOvGp@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_060221_688240_2B9C6341 
X-CRM114-Status: GOOD (  12.33  )
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

On 3/16/23 1:58 AM, Christoph Hellwig wrote:
> The following changes since commit b6402014cab0481bdfd1ffff3e1dad714e8e1205:
> 
>   block: null_blk: cleanup null_queue_rq() (2023-03-15 06:50:24 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2022-03-16
> 
> for you to fetch changes up to 6173a77b7e9d3e202bdb9897b23f2a8afe7bf286:
> 
>   nvmet: avoid potential UAF in nvmet_req_complete() (2023-03-15 14:58:53 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - avoid potential UAF in nvmet_req_complete (Damien Le Moal)
>  - more quirks (Elmer Miroslav Mosher Golovin, Philipp Geulen)
>  - fix a memory leak in the nvme-pci probe teardown path (Irvin Cote)
>  - repair the MAINTAINERS entry (Lukas Bulwahn)
>  - fix handling single range discard request (Ming Lei)
>  - show more opcode names in trace events (Minwoo Im)
>  - fix nvme-tcp timeout reporting (Sagi Grimberg)

Pulled, thanks.

-- 
Jens Axboe




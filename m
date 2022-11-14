Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7E5C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IgOId39Xocm9Vje1a/ep3OwWov96m12G3JQ8Ar6j2js=; b=Hlkd7kbpvb2jf5zRe6gJa+2Zbt
	SUD4n9meL85TS9W8sgME/Cx/bldxk5zujKAXyxFb6yeZTY+MacePVBxRE3g+q1gfN0VVCcFy+8C2K
	jzYTsoVjnIE6CXnc6pFW8TtdecInvW1woFq4K7Ux44QqcyJTpvaGjW+t2k/q2UXy3id3pmMAeqm1M
	v416kS1ewlWnzgtnKcEAwth0DkiLIVfaUxIvlRg5afEA8rYnicgCi7XBnD00lDrCiDOezmtjIbOJI
	Y7K3Fcfv/7QoT2BDcwfuxhJJo/GyxuzWEwA+vzeu1bAhts1pyvmWJlyMtx/ayXB+NN0CbXG4Sx7k2
	6BDF8hUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oucTd-002mG3-Cc; Mon, 14 Nov 2022 16:38:29 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oucT3-002mCg-Jz
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 16:37:55 +0000
Received: by mail-qt1-x829.google.com with SMTP id a27so7077610qtw.10
        for <linux-nvme@lists.infradead.org>; Mon, 14 Nov 2022 08:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgOId39Xocm9Vje1a/ep3OwWov96m12G3JQ8Ar6j2js=;
        b=Qa0GsT/naRuPhIF14456ovieRdsJ6XhHibA8b+89NOw+mpNSYiGJk7qmuj4n1ZqVKX
         2Cen0kxU499y3PryQOrfNo2eAz6rHw0oTz8m/tRrEdSXhz5UBZoIIEPGzMcSO37IrJdY
         jxF8tN3DwETde2iItJ3zcfAEqahYTKwCcfatc40qIi2FcibQ8OcovAvYZbONiZg63arX
         GQxDgXXsQgNNYz7QAWqAmjjhMvzrjhsLM3rNAqXNqfsyvjBaUIi+r528SoPSE4hEDe/4
         Q0L4P3APqywasdFmVG3ykAtabAt2NIsYnxg+7X57cRG5UCD4YebtfhUJZOD12LfB4ilP
         b4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgOId39Xocm9Vje1a/ep3OwWov96m12G3JQ8Ar6j2js=;
        b=UXoVljeL4SI8hBW45OL2aIZvMtEy9FvAhWumiXfSD0oK3jGCJmqUNNXF58gWXVrl11
         Rv+xO9dKpsA2xE7mbzFq/k8gqpnJ9eFmvlnD7QNMJnAJTeufnrls6e3CsVWGPci0knfj
         FA46b84Lt8SbEx6KqyWNcQcqA2EL6QO6JgUV6cYU59CHYEkhwv21D4opbn6rxHl2vWFc
         snYoMYpyo/Xlb6k1gj/IGCaSnltghu92zePbsACV7HTG04olDhYQwgbrFn8/jIIKZbKc
         TTZ8ERn1XdUB8TMBDYw7/m7rQr/gC0WFx4IzI5xuppPmL2xmZe21pAX0D15mpv4T3hXO
         35dA==
X-Gm-Message-State: ANoB5pmlEPuP+xvJTA8BCQXQB+EESzvNXVoA++tSUaUD0i7wMQanwj6R
	EyNsO1/Lpnop1vzKlFQzlLCFE72nV70=
X-Google-Smtp-Source: AA0mqf7/arSHjVFS1kNgX1Efe4XIdrBRJm6BAMzr6Q8VwiwhFqT1+N9tnQyNPsPf4v4c0rfLijiRcQ==
X-Received: by 2002:a05:622a:1a1f:b0:3a5:42f9:de64 with SMTP id f31-20020a05622a1a1f00b003a542f9de64mr12853008qtb.685.1668443870917;
        Mon, 14 Nov 2022 08:37:50 -0800 (PST)
Received: from [192.168.50.208] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id he31-20020a05622a601f00b00397b1c60780sm5861555qtb.61.2022.11.14.08.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:37:50 -0800 (PST)
Message-ID: <8ff1226e-d38c-67ee-7c8f-771cad7f99d7@gmail.com>
Date: Mon, 14 Nov 2022 08:37:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/13] nvme: move OPAL setup from PCIe to core
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20221113161138.883195-1-hch@lst.de>
 <20221113161138.883195-3-hch@lst.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20221113161138.883195-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_083753_715145_FC0DD1E7 
X-CRM114-Status: GOOD (  13.45  )
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

On 11/13/2022 8:11 AM, Christoph Hellwig wrote:
> Nothing about the TCG Opal support is PCIe transport specific, so move it
> to the core code.  For this nvme_init_ctrl_finish grows a new
> was_suspended argument that allows the transport driver to tell the OPAL
> code if the controller came out of a suspend cycle.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
> ---
>   drivers/nvme/host/apple.c  |  2 +-
>   drivers/nvme/host/core.c   | 25 ++++++++++++++++++++++---
>   drivers/nvme/host/fc.c     |  2 +-
>   drivers/nvme/host/nvme.h   |  5 +----
>   drivers/nvme/host/pci.c    | 14 +-------------
>   drivers/nvme/host/rdma.c   |  2 +-
>   drivers/nvme/host/tcp.c    |  2 +-
>   drivers/nvme/target/loop.c |  2 +-
>   8 files changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 24e224c279a41..a85349a7e938c 100644

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



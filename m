Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2048CC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 19:31:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEB42065D
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 19:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ARffCUK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEB42065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KSTan4HAbW6hEhrzawieLI/Lis9yaGXXmQKx6KZJCpI=; b=ARffCUK0IV7lK2UQpA0U62Uq9
	+7dcObrOXyNUves6SxVLkYDAKIYesOjc3o87kviMKFHw9aJU3Kub8kseb5vDBaXFscCGR73LgdgHK
	1wMsQ0Mjns77j24KleRrNvdXxukrvDKxf/W8PJTaOrehjHXP588+wkdsI6c8OrnqoxkQra6pe2D3S
	0tnwmMvzZbJJyH+rA2eLbS6JN8A3KuUkvcwEVlOjTNpEjlfXcikEXjVZ531kwtZtqKuyxeALEKMy5
	eJ4qNgQTHbL6FgXcWqb8kTJz4CUK3R6AIvQMWUxa2JRnuhqBmvitW0V13D2F3fS8pW5q5Gqq0GCNk
	uKHE3ZiDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7kqx-0007kz-Bi; Mon, 17 Aug 2020 19:31:31 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7kqt-0007jk-WD
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 19:31:28 +0000
Received: by mail-pf1-f195.google.com with SMTP id y206so8701596pfb.10
 for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2020 12:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c53QhmLlxRrzxrQ70pdwTYbA3+YurmqoKqzW3THoDr4=;
 b=Z8UVy20z36uHOHpJwTK8baD+AtN0VsQmShDPnzlloYaZf5ta73D/yvMqSJlwbI3NBL
 HDKMr3oObkARfLJkacc/whlF91E/ctRKqpb/H2BdOV8X+RLvJ408AJ6HZVCYp8rklZzW
 vjAcQOLy+AmmlwwwyrUbCdavPb5T8KHh3ilK3HWJdekuZXQszB/ekquKM2k07I4PqqWw
 keLCbS+Mp4J2xTC9acVqpwJ/RjmN9462ASXR8A7YrbooqrLy+sYLaws2OTjDFOmtAl5P
 oMfeWuclpFAvezn1Umz8Bx3gwct3l+gV8Vc3Lv2+elfGMcZhwu79QDNER2ZkfnlJ8d7f
 Q6Kg==
X-Gm-Message-State: AOAM533SSPXdsBkqlxYRJEPKUjn4ejdlEa3LEmUK9BQI0d/aR+vLVvRm
 BVYtK06186OaQNre//PpRNM=
X-Google-Smtp-Source: ABdhPJxaXHqOnKTk9o3fM5ZUX4y/1KEXqz2cexV5xseUZmCnv3bBJpqgcU/uLPjUFddvOxws7+hioA==
X-Received: by 2002:a62:1b81:: with SMTP id
 b123mr12312671pfb.149.1597692686829; 
 Mon, 17 Aug 2020 12:31:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c8a:c3fd:4152:60d0?
 ([2601:647:4802:9070:c8a:c3fd:4152:60d0])
 by smtp.gmail.com with ESMTPSA id f20sm22077421pfk.36.2020.08.17.12.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 12:31:26 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme: just check the status code type in
 nvme_is_path_error
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200817081544.837699-1-hch@lst.de>
 <20200817081544.837699-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37dab7d8-fae2-0890-f2f0-e68008c1966d@grimberg.me>
Date: Mon, 17 Aug 2020 12:31:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817081544.837699-4-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_153128_096195_10036330 
X-CRM114-Status: GOOD (  18.84  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Check the SCT sub-field for a path related status instead of enumerating
> invididual status code.  As of NVMe 1.4 this adds "Internal Path Error"
> and "Controller Pathing Error" to the list, but it also future proofs for
> additional status codes added to the category.
> 
> Suggested-by: Chao Leng <lengchao@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/nvme.h | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index dfcdeb318f3ab6..11ee0176fc45f4 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -537,16 +537,7 @@ static inline bool nvme_is_ana_error(u16 status)
>   
>   static inline bool nvme_is_path_error(u16 status)
>   {
> -	switch (status & 0x7ff) {
> -	case NVME_SC_HOST_PATH_ERROR:
> -	case NVME_SC_HOST_ABORTED_CMD:
> -	case NVME_SC_ANA_TRANSITION:
> -	case NVME_SC_ANA_INACCESSIBLE:
> -	case NVME_SC_ANA_PERSISTENT_LOSS:
> -		return true;
> -	default:
> -		return false;
> -	}
> +	return (status & 0x700) == 0x300;

Nit - A little comment may help future readers of this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

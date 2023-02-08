Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D065C636D4
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/jZ1/5EheECfodTCiVo9ByoertjMGtTfyZGj9JFY6Q=; b=cf/sTVrAuGaiQ487TZxd3Sy8tf
	p/gRzrjw3foGeBdx6XvfCyLVMNzuPhDVpKEcI7hbVLfZHUayIoK/lPTEMLiXfg2CUmDLeQygUtCj5
	oSqFCxQkndiqj/WU9rEz996hF7ZFfI2LG/NUAF3NNilPEIfNv9Gvh+i0gD58wSrR+cOySaDQ2WsTU
	bAynNT1dwNjt1V4GeWqMob2g2ID2JcSljaNOU3JmbHzSd2fzQGZTm3CihsQFcgf0cIRPqNMFhIiNI
	N8Cvuy8zhfDk0LPfN0DPMFtcct+7YB/pNwhEtb4Dob1VzZk7aTTnYpajsMfJB60r6ZliT4jmwotuy
	A0znNSFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmPV-00G5fy-Nx; Wed, 08 Feb 2023 15:31:01 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmPS-00G5et-Gb
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 15:31:00 +0000
Received: by mail-pj1-x1032.google.com with SMTP id d2so15054010pjd.5
        for <linux-nvme@lists.infradead.org>; Wed, 08 Feb 2023 07:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/jZ1/5EheECfodTCiVo9ByoertjMGtTfyZGj9JFY6Q=;
        b=REAvBtgJWjQX7d76IJHIntHW8/q+c17oP6HoBVQgmO1OwYPHyE6P0dSqfh6AjQW6cY
         WtgblpxPO1N1cQTBy8PdbFjqcDzxj3Eh8iG2mG6AttrjNFxO6un/yKv4Ddbib32J15/m
         9UXzoeB5EI8DV9uARqfpxwtKvCbBQAuT56hyUps2sRtuAhh6+7NMPcEjr9tZQLmtevft
         tr8XUerhflkYrd2+tWE6BdClVAZSFr4nJKQ1Lh3VUWmz8n2L82+px14twRu6j/5flwqi
         IJNK7DFKIfoOU81JTYs9MS06VHvhxwoGCKWXhekkqlVNh2yyYIET7B+PQan3TMKVZP2H
         fymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/jZ1/5EheECfodTCiVo9ByoertjMGtTfyZGj9JFY6Q=;
        b=WqbyH9wPW4YMrnDb1CSAg6tEGvMNj3JgwqySrD3s/oqJPDsyRtdohvKlZqSa/mcP8S
         YwBBeIXT30dDzXrQBiEKKwAxUVTGAhWP0qebxTkD5CKrbbCABXm4upIZiQV3iu2MNf+Z
         xShbSOdo+GMXxPoZyVEv0uQhTxiWnpXLBpN137Y3D5+0iEmS88ALkL3TwpJ36Fu63n4n
         eAdtemVffbuHjlaolO/kWahPArS0/u0C3qU17WDbIyakiUZzNX+Jv80mtfz17oe4nRpR
         H/sFziw6yXygPuOYYvZZtFyKA2YZORR621yQpUxqfd6k3m/NufokYVDBGLIk5Povr7oQ
         dDDQ==
X-Gm-Message-State: AO0yUKUKx6iqSQ6aZp0VQSV6K1MLgO4ddtN0eUf1jVrN9wt42bJqAPLd
	58aG4WRo/uMaf76sb+Fpb2J8A6m44fxlUxkF
X-Google-Smtp-Source: AK7set+cMzA1CQbIvjDefb5Q2tYpB+jj1e6HxbFSe4UXKXScICFpNA94UqVADu3joKdjMOfjdNEaFw==
X-Received: by 2002:a17:902:d505:b0:198:e8c6:859a with SMTP id b5-20020a170902d50500b00198e8c6859amr7983253plg.0.1675870254890;
        Wed, 08 Feb 2023 07:30:54 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902c1d200b001992ae25843sm4064679plc.24.2023.02.08.07.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 07:30:54 -0800 (PST)
Message-ID: <4740c230-3ea1-a5f3-ed03-108400b70730@kernel.dk>
Date: Wed, 8 Feb 2023 08:30:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCHv2 0/3] nvme: rework __nvme_submit_sync_cmd()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20230208151720.109130-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230208151720.109130-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_073058_797099_6967DAE2 
X-CRM114-Status: GOOD (  16.89  )
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

On 2/8/23 8:17?AM, Hannes Reinecke wrote:
> Hi all,
> 
> as Jens and hch complained about the argument list to __nvme_submit_sync_cmd()
> getting too long, here's now a patchset to clean things up.
> The first patch is to split off __nvme_alloc_rq() from __nvme_submit_sync_cmd(),
> which serves to reduce the number of arguments; it's also a nice cleanup as this
> function can be utilized to replace some open-coded versions.
> The second patch is to introduce a 'retry' argument to __nvme_alloc_rq(), to
> indicate whether retries for this command should be allowd.
> And the third is another cleanup; the 'at_head' argument to __nvme_submit_sync_cmd()
> really should be a boolean, as it can take only two values, and it's being
> converted into a boolean within __nvme_submit_sync_cmd() anyway.

This looks WAY better than piling on to __nvme_submit_sync_cmd(). I
haven't taken a closer look yet, just a note that I'd reorder patch 2
and 3 so that you just have two prep patches and then the final patch is
what you really wanted to do. Doing cleanup, change, cleanup is a bit
odd.

-- 
Jens Axboe


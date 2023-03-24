Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AA2C76195
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 19:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4rtTUuCCRIIQVv6MF/hcet5LN6DayoTxhlaNVOhUyvs=; b=bZSvuJE6o8lKUuUx+ksYS955yH
	1KjpU76F3NLX2XJAHlfgZRPCWmT/X0lGUej+7X+4wpk5kQ5pScQRqNLDSEC4aIfaZARgchxVm138s
	qtayv+K/iyyGUly3g+T4lQ3d5rAfcoCGPXJINSWg7IA05MoggxKrProaNfkmKQN/eBQ55CHJit3GT
	iLTkYnq2BNo552yKn+n5pTWPr1lM6F/1db4mxyygWSOwhKI8RSpZH5Q3waj3YUndRiUXBvX1OVoFO
	V5n5m1/CsYHaPOg8OL1exyYM/C/m62g8kTotBzrbFPorBFP2tth1FM1sScN2QbZg0c2p10mkPFUmk
	q/YqOfxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfnN1-005Sfs-30;
	Fri, 24 Mar 2023 19:46:39 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfnMz-005Se6-06
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 19:46:38 +0000
Received: by mail-pl1-f180.google.com with SMTP id kc4so2795061plb.10
        for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 12:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rtTUuCCRIIQVv6MF/hcet5LN6DayoTxhlaNVOhUyvs=;
        b=d6nfw8SrJSASzfFEnu7LB71upIL4K07nL8dZrLMS8F4TXqZAy9RtrHeSpz6RQgnnY3
         SCJ4Gccbms6b1azEnFaxxCczvl0ht0CBfHd/RwvWtkqUuMrbOsy50gBmzz5aBFvEnKjV
         X6m0MqWh/Z5ulHVR8OSYoXh6d9J4cPQTWboujUeaIkGkVfi2yqEEovSVqq+3fJ0l+6Pq
         VUA2rxqvZV6C19Fh8UuJuzo0MtkNTlcbVF5sHHTKxvNtBxn23jDRbvoEV9grcm/q33T2
         6/8Ax5MTFY8XXDGCfYyPvwuI+FpCnRAXIFJQrWfPLhzw5mv9/lvLFZ/FvBXZQNvH3h/K
         w1iw==
X-Gm-Message-State: AAQBX9eNDw9us/uKgobyuF4jkc1DsMY76FUT5gIEzG6qC6Z0OKydktbc
	sddA4zT34OZjJcoPh+54hM8=
X-Google-Smtp-Source: AKy350bgGq1w2lPDZ+6ZO4UHtm4oCoBNhrnJso4ApZVq060T+JXgY5FqVxTJVceo/xOu2MYuXwm1OQ==
X-Received: by 2002:a17:903:1108:b0:1a1:e867:f2a7 with SMTP id n8-20020a170903110800b001a1e867f2a7mr4823486plh.22.1679687196486;
        Fri, 24 Mar 2023 12:46:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:386d:2249:7df8:ecf? ([2620:15c:211:201:386d:2249:7df8:ecf])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902b70200b0019e31e5f7f9sm14639920pls.71.2023.03.24.12.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 12:46:36 -0700 (PDT)
Message-ID: <96910cb2-2a87-420e-1ff5-7427c2971318@acm.org>
Date: Fri, 24 Mar 2023 12:46:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 03/18] scsi: Rename sd_pr_command
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20230324181741.13908-1-michael.christie@oracle.com>
 <20230324181741.13908-4-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230324181741.13908-4-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_124637_066140_659D2322 
X-CRM114-Status: UNSURE (   7.22  )
X-CRM114-Notice: Please train this message.
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

On 3/24/23 11:17, Mike Christie wrote:
> Rename sd_pr_command to sd_pr_out_command to match a
> sd_pr_in_command helper added in the next patches.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>



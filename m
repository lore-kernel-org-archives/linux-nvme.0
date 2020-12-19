Return-Path: <SRS0=BlPy=FX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB99C4361B
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Dec 2020 17:15:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92CA23A00
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Dec 2020 17:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92CA23A00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mCuCPkAHB6mEeVkqByCEYI5vFbOJj8rYEB62ujpxQMU=; b=PXCmARusalYdVzkVFF2uRa4af
	Bh/706QADzVENBWa4XofXEsh2FQBEDVfcWM4Duey+IFXNHY/p5d6UhCDtP/Hif15HKYSajd4O8HvZ
	qMFIK5WlEe2t981HLvWxmOjzfkBVNdJ0xwHmBYxyVnTL3GzyPdkoy+VAHZg/TI/PBrxdfqoNGYUIB
	4LQ+UbX3XiQtTAcDKKQP1wLU79/0nAMGipWY86hfWQwg5B921G1pUunjKMN/m7ISYOuvlxWdGR0Hm
	sZJ6yoRuc3uCoWHyTC3r1Q76+qN4VNXTdObAfW6YWLLGqD2LbFWKINCpDoo+G+HbFO4eYoXfi/JpC
	bzyIn7XDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kqfoy-0005gV-2J; Sat, 19 Dec 2020 17:15:08 +0000
Received: from [2601:1c0:6280:3f0::64ea]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kqfow-0005gC-8H; Sat, 19 Dec 2020 17:15:06 +0000
Subject: Re: [PATCH v5 16/16] scsi: Made changes in Kconfig to select
 BLK_CGROUP_FC_APPID
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de
References: <1608096586-21656-1-git-send-email-muneendra.kumar@broadcom.com>
 <1608096586-21656-17-git-send-email-muneendra.kumar@broadcom.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e60169fc-c973-da16-31c4-96b497aa6291@infradead.org>
Date: Sat, 19 Dec 2020 09:15:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608096586-21656-17-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

On 12/15/20 9:29 PM, Muneendra wrote:
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 701b61ec76ee..1c73c60e398f 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -235,6 +235,19 @@ config SCSI_FC_ATTRS
>  	  each attached FiberChannel device to sysfs, say Y.
>  	  Otherwise, say N.
>  
> +config FC_APPID
> +	bool "Enable support to track FC io Traffic"

	                                 IO  {or I/O}

> +	depends on BLOCK && BLK_CGROUP
> +	depends on SCSI
> +	select BLK_CGROUP_FC_APPID
> +	default y
> +	help
> +	  If you say Y here, it enables the support to track
> +	  FC IO traffic over fabric.It enables the Fabric and the

	                over fabric. It

> +	  storage targets to identify, monitor, and handle FC traffic
> +	  based on vm tags by inserting application specific

	           VM

> +	  identification into the FC frame

	                             frame.



-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

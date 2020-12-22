Return-Path: <SRS0=D3NM=F2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFCAC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 17:07:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8879C23103
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 17:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8879C23103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UN5jN2auF/068VIz5OPbxjxiHrGNGwfoINdzghmZvoU=; b=alBS3+yaohMZqmQniPGDUNJOj
	++uzTtCxrKgrwLXmB684rKI045mM3bqtVkgTiH6ze8xOZxQM8stGwrKPvFwjunmnDMNDoxH9CnDKg
	P5CfrjywV0KHhxbwujYbDroauPqeR6fZQSPUAG53+RRlqtlgRK5yDREpaeuhXQm4VCzQdb6TAjngA
	FTuRliwR8AsfNAVNVOqMRck3g3PgrFLn/PJk0M0eU/0O0mvHYVOmf3RKzeWccP+vFHHlMDeO926Ui
	i6DzoSQ0x7MzkGheWOwiLdDKJPUwzD3pjdPHuLXSWI5lzPtanMGtU5+46Ofom2iqBgVf75ykweAGQ
	j2ml6Ek6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krl8O-0005r5-Kp; Tue, 22 Dec 2020 17:07:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krl8M-0005qp-SD
 for linux-nvme@merlin.infradead.org; Tue, 22 Dec 2020 17:07:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=riOEXc9ElbQjYJ+LSbG5l4r+6AdwaK+XcQBz+FJDKIo=; b=MCRXC4+lzd3YiNC58MTAaMWs8a
 x2Gmwr4q8Cm6Kzif2VsAiMAGzcSPKA8zIW6qWnyQNZcxF1CcvAGLVXjYc7CG9oz6cQLaRqbZUD21O
 sb6WYilCWa9Zsk6Vu87EnVFOPZDdQF/0moukjcTYHLPZMN6+rNSFUW9Sof3B6LUWpixs57LOQbXL9
 eiPn8SLi0iuWv1GVnAYuW1DU5u8psL+g1UNgaHV4CeK2sqZl3CpF3QvptPs3ZXeSNAb5TRTi/Bit9
 C39ylmoGFLJNq/dB7KQtL4BaC2sIvdO6PThRojaoDZy+C6Ubdsw7BmMDm9kLBiFzQRck8auc07s8A
 q+KiFAFw==;
Received: from [2601:1c0:6280:3f0::64ea]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krl8L-00084C-RV; Tue, 22 Dec 2020 17:07:38 +0000
Subject: Re: [PATCH v6 16/16] scsi: Made changes in Kconfig to select
 BLK_CGROUP_FC_APPID
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de
References: <1608595918-21954-1-git-send-email-muneendra.kumar@broadcom.com>
 <1608595918-21954-17-git-send-email-muneendra.kumar@broadcom.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d1a1abdc-0bb7-d074-2e65-fd9655bf9c3c@infradead.org>
Date: Tue, 22 Dec 2020 09:07:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608595918-21954-17-git-send-email-muneendra.kumar@broadcom.com>
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

On 12/21/20 4:11 PM, Muneendra wrote:

> ---
>  drivers/scsi/Kconfig | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 701b61ec76ee..7b41fc3cb7f0 100644
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
> +	  FC I/O traffic over fabric. It enables the Fabric and the
> +	  storage targets to identify, monitor, and handle FC traffic
> +	  based on VM tags by inserting application specific
> +	  identification into the FC frame.
> +
>  config SCSI_ISCSI_ATTRS
>  	tristate "iSCSI Transport Attributes"
>  	depends on SCSI && NET
> 


-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

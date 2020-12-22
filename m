Return-Path: <SRS0=D3NM=F2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CDFC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 17:07:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BE723103
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 17:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BE723103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l8bcpa4kLUiblZ2baEe6Q+Zvio4jI33wgFV68xYKTZE=; b=RGOCrCbuzwiseB8k1CD0GKiCz
	SdJfIap6QJIaeubLv5kp4qloGkJsNnI3Rsbso+UZCmK/rQtEV6/KsTl9mu3nXfqFN81juAHfj6L2b
	8KuTkMrHsFhLDHE8/BZCpsJKy1GHt/WSyCAt4E6X8qoYU17wMBXkqLOnDa0EtglvrDXbCv0YgyNMh
	aF1To+S6W8wn+vYJ6w92XvZ5bgNbTwSXI9p2Jq+HuXrFuEcxmexa1gIol/erDFKmQg9CKXDkWHUaR
	xzaNhUdPUmv7K/UWkBHBqdXiYz/2yU7lFD/fMClqFPjrloupdvad+KMAT3orHXssv3p17WqB1MWhz
	KDd2Gra2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krl7e-0005o1-OQ; Tue, 22 Dec 2020 17:06:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krl7d-0005ns-3d
 for linux-nvme@merlin.infradead.org; Tue, 22 Dec 2020 17:06:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=28dBPJLT+UeFhB76QkjVxwba0elN7ioWbZEoNuAnC98=; b=hiuWrGsAEgxIiypyZOih+2UOn1
 0caGea3w+uR6dT/kLxnD1jPVV9+J1pUS+nj1KDJWZ7WStyPloKua7r17l/1UaNAHuuwtHidaWLo5T
 jb2tBCyPNxkCeyB+ILbNZJkM5tngWsdSPPxiYLzpjGsMPOZHSRH8wXX3QiD8gELFYDzqIKfHBm3Dq
 10HbgqHH0yJC/qtVObVVcEG44W1WQIb4lYzIUHFjIljXU2BccKuVMC+CBvU7tu0k4qk+NDfVaFUsS
 IvU4w58jjC41/UomW7WKc6ldhc5205jwCvpRPN++u98EOYfmkVlJ+PVGIAgNX3F/FWO+nJHYq9tPs
 9vNm62jw==;
Received: from [2601:1c0:6280:3f0::64ea]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krl7Z-00081h-Nu; Tue, 22 Dec 2020 17:06:49 +0000
Subject: Re: [PATCH v6 02/16] blkcg: Added a app identifier support for blkcg
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de
References: <1608595918-21954-1-git-send-email-muneendra.kumar@broadcom.com>
 <1608595918-21954-3-git-send-email-muneendra.kumar@broadcom.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <17bda03c-4eb4-2803-2274-1b7a8f122c32@infradead.org>
Date: Tue, 22 Dec 2020 09:06:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608595918-21954-3-git-send-email-muneendra.kumar@broadcom.com>
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
>  block/Kconfig              |  9 ++++++
>  include/linux/blk-cgroup.h | 56 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index a2297edfdde8..2ba6c27880e6 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -144,6 +144,15 @@ config BLK_CGROUP_IOLATENCY
>  
>  	Note, this is an experimental interface and could be changed someday.
>  
> +config BLK_CGROUP_FC_APPID
> +	bool "Enable support to track FC io Traffic across cgroup applications"

	                                 IO  {or I/O}

> +	depends on BLK_CGROUP=y
> +	help
> +	  Enabling this option enables the support to track FC io traffic across

	                                                       I/O

> +	  cgroup applications. It enables the Fabric and the storage targets to
> +	  identify, monitor, and handle FC traffic based on vm tags by inserting

	                                                    VM

> +	  application specific identification into the FC frame.
> +
>  config BLK_CGROUP_IOCOST
>  	bool "Enable support for cost model based cgroup IO controller"
>  	depends on BLK_CGROUP=y


-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

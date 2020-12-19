Return-Path: <SRS0=BlPy=FX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4853EC4361B
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Dec 2020 17:12:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DCD23A82
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Dec 2020 17:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DCD23A82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hQYa/z+/Q9BT9HXRRdyD2xouXbDwNlGgeI5cjMo/Fsk=; b=NJbGGOTo8S4MGFJG5WUpHa6jN
	2tA9qlkhSCWiHaEZtfNy0mJtSLFfKRDzF35GjslmJafhqqOH8dK+Dj1fhSDGutyoEP0alD2j18n8+
	odAaKnHugFqxV0MnXF8E6n4doh4Xep7aHx+jWmezk5idgHOhzr8lsmpmMilykH7wGNJf5jnzRSCuw
	d+HczW3IxYWk7zt2MnEFSTZdCSNrI9Hm7FCKs8Ywtafta692waipN/yFm5b4HogfRlTpuIkMUh+Rg
	37OwQlAygxzFcGmLHm9+g+/wYFE9mCqdLIasvxSaa2WBZkOtkX1gnWNTM3QC9prkenMB44sPKgeaR
	BknI038yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kqfmN-0005a3-LP; Sat, 19 Dec 2020 17:12:27 +0000
Received: from [2601:1c0:6280:3f0::64ea]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kqfmJ-0005Zq-Ch; Sat, 19 Dec 2020 17:12:23 +0000
Subject: Re: [PATCH v5 02/16] blkcg: Added a app identifier support for blkcg
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de
References: <1608096586-21656-1-git-send-email-muneendra.kumar@broadcom.com>
 <1608096586-21656-3-git-send-email-muneendra.kumar@broadcom.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b765fa4e-87ba-a9a4-6c8c-68f3b410129b@infradead.org>
Date: Sat, 19 Dec 2020 09:12:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608096586-21656-3-git-send-email-muneendra.kumar@broadcom.com>
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

On 12/15/20 9:29 PM, Muneendra wrote:

Hi--

> ---
>  block/Kconfig              |  9 ++++++
>  include/linux/blk-cgroup.h | 56 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index a2297edfdde8..1920388fb0e9 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -144,6 +144,15 @@ config BLK_CGROUP_IOLATENCY
>  
>  	Note, this is an experimental interface and could be changed someday.
>  
> +config BLK_CGROUP_FC_APPID
> +	bool "Enable support to track FC io Traffic across cgroup applications"
> +	depends on BLK_CGROUP=y
> +	help
> +	Enabling this option enables the support to track FC io traffic across
> +	cgroup applications.It enables the Fabric and the storage targets to
> +	identify, monitor, and handle FC traffic based on vm tags by inserting
> +	application specific identification into the FC frame.

Please follow coding-style for Kconfig files:

from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


thanks.
-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

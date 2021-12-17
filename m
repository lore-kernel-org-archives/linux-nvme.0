Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C08EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Dec 2021 22:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fBL+Ma55w7JQEJ2YRuqODS5A2otNh2gOdboadxynvtM=; b=a+fES6JmdxXAX3uBR29sf30vXm
	jmAWFgg9W3CUDy3I9YU9PbdOYo+EmDTv+kkxklcaRhTitiPkSaXFfsVo79gjGtS8PMyyMGQly00Mn
	ofcfHEW/W0w6w3D54XYe/0RXvi74QcUn87xrF/vxbLJ9Xo9ZvLGYh4WKcYK+YXh9mrbgsgTNFiTpW
	X9Zow8wKd2AbObuVZ/4bUoEIVUdBhw5SVKsIDm6+WX3GdU6PVc8ofbCvocHKv788KK0z0US3ccLQB
	DJrneAftyGHvkX0u4391wgJ4wpxE/QbCqQOvc9WZwWn0tm+qQ3fpR4YILq6ZhLkwVfAunoyPNWnN0
	stj3/1fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1myLNU-00CVUO-Mw; Fri, 17 Dec 2021 22:07:00 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1myLNR-00CVTa-6E
 for linux-nvme@lists.infradead.org; Fri, 17 Dec 2021 22:06:58 +0000
Received: by mail-pg1-x52d.google.com with SMTP id f125so3441332pgc.0
 for <linux-nvme@lists.infradead.org>; Fri, 17 Dec 2021 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=fBL+Ma55w7JQEJ2YRuqODS5A2otNh2gOdboadxynvtM=;
 b=ii8KOIKYxsOGt3o3dEHG3bg5qwniXiQd/ufxPbJ8SKbqgErLgW529rfqcyy9Nom5vv
 Y47sCmXtV4vZBiLglSzWsi12he9hFU5YytB+3aCIeADV5hPTKDRqFeJxWjWnvN8wY2xN
 YnaI5cLYwZ6KKiIV3m4ElBMhQIDhsHMqf6PBUEpQ75/Juu+hDkrZvjgAuZoDPwfv/dGj
 vXFWy61L3PqEWFZhqyY7QUdtwRdde8fFJFSNxLk4qlBRiGGg1ih3bRLYLlz7I9WHZi5r
 5PmjSv+dM22+b73lyPMb5uLOYAjkEzsoZD+z5baPxVnsTizW93PXIQ3dATBjf9Rnbk/3
 2ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fBL+Ma55w7JQEJ2YRuqODS5A2otNh2gOdboadxynvtM=;
 b=5n9hOOfJ1lWDs8I91UEeSgGPXYbd2AspbvnM7BAt24o2aLCz9YOuAxSm64duHFCpPn
 S9BSBbWnaegNbPuSF6u0NkTcPells8jfiqZ8ZA5NdVEYHY8ePhSM+N4NWZM06QlUeLZh
 Ia4PQCT8LsSSM8sYo9YiSXjjk6NPZDjoHh7Prx45u4y0H0++20kAIzZ4qbgIk7mWq1WY
 u/2SmXV0ylNa7HfLckU0U0qaFra1Q03KcKNFON6foJWEh/KMlme8FxyckkaplYc4ZbUJ
 t5J6ZbeBUVCyXPnXtBV0B/rD74vFQalvq1/XsaKzrCFjrCg/Prz8Y6xZaAiHOWpP0ju8
 LAfg==
X-Gm-Message-State: AOAM530+PBb0JYdagY73MELHDLORRPk8k8DnlBAiJryHsK9JSLNB3iVc
 guj816RALYjjJSRYSL/4Vfs=
X-Google-Smtp-Source: ABdhPJy4rpw+IQcUu6Lw/ATXBgnaI0higgFiSJGj9GEGN5XGSMRoCkkaG5JZ6igb6IJ7eU/ztQJ84A==
X-Received: by 2002:a63:e24:: with SMTP id d36mr4642852pgl.175.1639778812891; 
 Fri, 17 Dec 2021 14:06:52 -0800 (PST)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id 32sm8892282pgs.48.2021.12.17.14.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Dec 2021 14:06:52 -0800 (PST)
Message-ID: <f7290bba-c36c-0d2a-5b36-28d6fc6936b3@gmail.com>
Date: Fri, 17 Dec 2021 14:06:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme-cli: nvmf-connect@.service: Remove matching from
 default syntax
Content-Language: en-US
To: Martin Wilck <mwilck@suse.com>, linux-nvme@lists.infradead.org
References: <20211217193232.29034-1-jsmart2021@gmail.com>
 <b7bf62931bd6d45128595646a7eb637a89d216aa.camel@suse.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <b7bf62931bd6d45128595646a7eb637a89d216aa.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211217_140657_293737_00FE1CB5 
X-CRM114-Status: GOOD (  28.41  )
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

On 12/17/2021 12:43 PM, Martin Wilck wrote:
> On Fri, 2021-12-17 at 11:32 -0800, James Smart wrote:
>> commit 53aab69a0add added the "--matching" argument to the systemd
>> connect script that issues connect-all to a discovery controller.
>> When
>> this argument is used, only discovery log entries whose target port
>> traddr's match the traddr of the discovery controller will be
>> connected
>> to.  This eliminates the ability to do referrals by the discovery
>> controller.
>>
>> Revert the commit so that the "--matching" argument is not default
>> behavior.
> 
> Hm, I guess you have to do revert this if it breaks referrals.
> 
> The intention of my patch was not to suppress referrals. Unless I'm
> mistaken, a referral is a log page entry that lists another discovery
> controller, on which then another discovery is carried out. The "--
> matching" parameter was intended to ignore log page entries listing
> ordinary (non-discovery) subsystems on if their traddr didn't match the
> discovery controller's traddr.

Yes - I guess that is the definition of a referral. But there is no rule 
that state subsystems returned by a discovery controller must be behind 
the same transport target port (quite the contrary if one is not on fc).
So that's a rather larger restriction.

> 
> I still think connecting to those entries is wrong more often than not.
> In the environment I was testing in back then, IIRC there were 4
> discovery controllers, each listing every subsystem on every
> controller. The host would try to connect to every subsystem 4 times,
> resulting in error messages 3 out of 4 times. With --matching, these
> errors could be avoided.
> 
> I believe the correct solution would be to fix the way referrals are
> handled with --matching. If a discovery subsystem D1 refers to another
> discovery subsystem D2, then on D2 those entries that match the traddr
> of D2 should be considered "matching", and so on with additional
> referrals. Obviously, "--matching" would need to be ignored for the
> referral entries themselves.

I believe the devices are acting appropriately, and note, that is one 
particular implementation.

What is rudimentary is the linux implementation. Perhaps nvme-cli should 
be smarter about investigating, via sysfs, for the subsystem before 
initiating the connect request. It would need to look for subnqn and the 
target port address tuple data (more than just traddr, perhaps with 
per-transport rules).   Another thing to do is "lessen" the error 
notification. The corrects checks are in place in the kernel thus the 
messages, but perhaps we ought to make systemd less chatty by the style 
of error (or success) we return.

I'm ok with the matching argument - just not on by default. I also think 
this is yet another motivator for making transport/address/nqn vendor 
specific connect options table. This would allow us to turn on the 
option the vendor that was very verbose.

> 
> But as long as we haven't fixed this logic, I'm fine with your patch.
> 
> Martin
> 

Thanks

-- james




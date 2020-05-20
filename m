Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAC3C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 06:59:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8DA20756
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 06:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BvJ8NBy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8DA20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mxk1WbLw8Bt+9CXD6JqEcB7F+1yCnOO/FDHlsDRknsM=; b=BvJ8NBy8uoCv3fXVA2AEilidO
	W/z4fN98bDIdEVKI+3WSus20sQGeTZgA8d5X/D8ThVDc4J1neLP9yGrPI9/HthB2JLEGPLwuRaBFn
	3dyRGOE7otTYscS40oq0egUzSp24XE/LGkJ+qK8AL+i7fV5kP83fb3rtmp9PDaW0PnJLLbCFx8jFO
	h5uWzEWjtaOxBcZiiMd1Fa5Bdw2lqFg5/f6/jCl6xtrdUOLAYVIdVAo3xfZMRSVqZZrCwATZA3Kzw
	9XmgFsNEqZWZ5ZRufHNjnyyAQ+0pLkOmOwf2apyUFDpXT0/Ws3HSTCotS+1iIfuACmqxKcN5HrJ0r
	x8MdkHFAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbIhU-0003oF-PA; Wed, 20 May 2020 06:59:36 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbIhR-0003nX-Od
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 06:59:35 +0000
Received: by mail-wr1-f66.google.com with SMTP id l11so1998195wru.0
 for <linux-nvme@lists.infradead.org>; Tue, 19 May 2020 23:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iD0WL+yrgawtOqoETFXhv1spOHr7yBQhDVjxYEqmIiE=;
 b=aZ15epNuindi2nuJf0WXYJBwAjvElkXa8FS3kYnYkQlKFED2ySHqy35ODQUqwtmhOz
 XwXSSAfhPfGMYgODqwP7PMCqQRZGanyL9I8cGkb/iAmxmCRZxbPCFl8jYTBGPrxj3dnR
 g45m84GCybWjO/9+CYl1tsR3Cn/9u8Sy45kNLDI5/OTaQKPLvXAbf5FAnubyfQsSQLuX
 K0KePQZVxme0z3WRmkxnWlWIwBGEM+ZTy8SN3LibxBNnrntti9xWD4uySszkVeCovIaf
 6uUXOzwafzSA9ujFRjEpPN96V4Asyvz89+MnSmbxK9ca2wsy1Kuvu3hqaufcU0LFM+F/
 TZsA==
X-Gm-Message-State: AOAM530zk9m85QrO3RGrcexNnaS/eQGLArBJcpZ2M7auhXoigxbSoSgM
 UwXomZOXUgDM8rJVFMXZ+1m8fPob7l0=
X-Google-Smtp-Source: ABdhPJxXdtfs4Fuhb0tvv5KrluF3cH5Gb8fLJGeyRUxiix2W2OK9mTQlC8yspdcXDcu6w8/rmyLHaA==
X-Received: by 2002:adf:ec85:: with SMTP id z5mr2970558wrn.153.1589957972093; 
 Tue, 19 May 2020 23:59:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:91e2:91f6:e321:5d4d?
 ([2601:647:4802:9070:91e2:91f6:e321:5d4d])
 by smtp.gmail.com with ESMTPSA id h137sm7253029wme.0.2020.05.19.23.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 23:59:31 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining aens
 in nvmet_async_events_free
To: Christoph Hellwig <hch@infradead.org>
References: <1589828396-144513-1-git-send-email-dmilburn@redhat.com>
 <1589828396-144513-3-git-send-email-dmilburn@redhat.com>
 <388242d3-5ccc-d694-c7a0-ac489f63f26a@grimberg.me>
 <20200520061613.GA18308@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0018af56-e3f9-8730-3c57-c4f19e478014@grimberg.me>
Date: Tue, 19 May 2020 23:59:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520061613.GA18308@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_235933_802911_41C1D7DE 
X-CRM114-Status: GOOD (  16.14  )
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
Cc: David Milburn <dmilburn@redhat.com>, linux-nvme@lists.infradead.org,
 dwagner@suse.de, chaitanya.kulkarni@wdc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/19/20 11:16 PM, Christoph Hellwig wrote:
> On Tue, May 19, 2020 at 01:33:17AM -0700, Sagi Grimberg wrote:
>> Something here looks wrong to me... There is no reason to free aens here...
> 
> I think there is.  Remember we have two aen related resources:
> 
>   (1) the nvmet_req structures in ctrl->async_event_cmds.  One of these
>       exists for each command that the host has outstanding
>   (2) the nvmet_async_event strutures hanging off ctrl->async_events.
>       One of these is added for each event that the target generates.
> 
> So when the host usually only has a single aen command outstanding (like
> the Linux host) we might start having a pretty long list on the target
> for a while until all the roundtrips to deliver them have been
> completed, and if the admin queue gets shut down during that time we'll
> need to free them.

That's fine, but why should it do that in the process loop?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

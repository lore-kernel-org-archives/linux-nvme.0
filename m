Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8730DC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 16:45:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6F46108E
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 16:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6F46108E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kj30ysNFCUv3tj844s/KsbQaCcfTux3LfIEBz2xqOmA=; b=0br+2zxfqCAVCAdLdlbQvT1JUo
	DCJZHvztUvNXAoXaqifMfl1yr7UWMj1zDt+Ija6y6KK2JpXcK7US2cIyr0u2Bf+QZ0ov+WnqzZv+A
	/B6x1kkQEtbSLBhOGNV3bnTm5OoalK2EWHqxKbL5yDcsCxjQkOXWM5uixA5qHbG1RO4maMszrbCJS
	Ke5z+ckpsf49KeVnTSiJu7EIAIWQtyXskoPqt6Kog3mX1eBqARtuSUfbjuUQi8KAs5J42nPebTWzX
	NklvGtXm4wgqYamnfBx2OHD95TKS9sGxos4PidZ7ffN7eD3t7vnqXweBVtJhhpM+R/UVRIHHl89GD
	fCmI/qXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsphj-00FBtc-D3; Mon, 14 Jun 2021 16:44:51 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsphh-00FBsn-LN
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 16:44:50 +0000
Received: by mail-wr1-f48.google.com with SMTP id c9so15243790wrt.5
 for <linux-nvme@lists.infradead.org>; Mon, 14 Jun 2021 09:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L6Dz3mvfUCS4yCr2G2NAGAIX9UHRJzik+9FmnV68O3g=;
 b=gJqMXft01kunbIJrIROOwibBvS9M1fBNcZwShMXZ01YDyVYYBa3vMMFIl57tvNBmj4
 vjLrMPrODADVVDAqCDBxNFygAl09/f4VU/H1sGQ1wGV2JrlhlhBoomsD3jejsqM2NipZ
 twSx9Lhdvs/flwtLJ2oic2fBjIP4jsSv9t1476FVtqp7ZDFAdkoX7QPoarlh7fJUTnfg
 Pzt3TWR0b6BTFjBeuG+RafeLd04GGBqM+zkicHsZdMcDrwgwfqEx6KPS0hGW5omLwO65
 7b42tWLS2+srREj2CRmmxkrNPd04uSwinFQnePJb04Tzy6XpEeSVBkEIHoL0oG8a8c5B
 wFAQ==
X-Gm-Message-State: AOAM532BejzcRstig26rkJLhRjLrZTqlXZFYy1Q/ce37+fAgYVNUMT5O
 /8uafsOfn0RSTSmdsVLJe4M=
X-Google-Smtp-Source: ABdhPJwHcOxM30UplMyUmzjGwPFUtKyFXsANqwszxE8o5twGZiMp3/1Kf3jifB4X4Fv7mVi4SKw8dQ==
X-Received: by 2002:a5d:5104:: with SMTP id s4mr19632904wrt.306.1623689086237; 
 Mon, 14 Jun 2021 09:44:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2019:89fd:671:98c6?
 ([2601:647:4802:9070:2019:89fd:671:98c6])
 by smtp.gmail.com with ESMTPSA id m21sm9415wms.42.2021.06.14.09.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jun 2021 09:44:45 -0700 (PDT)
Subject: Re: [EXT] Re: BUG: scheduling while atomic when
 nvmet_rdma_queue_response fails in posting a request
To: Michal Kalderon <mkalderon@marvell.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shai Malin <smalin@marvell.com>, Ariel Elior <aelior@marvell.com>
References: <CH0PR18MB4129247C2B9AE092E3C59740A1209@CH0PR18MB4129.namprd18.prod.outlook.com>
 <e059fc90-81e7-dbe8-86f4-87b4bdbd5bb0@grimberg.me>
 <20210608184134.GA339600@dhcp-10-100-145-180.wdc.com>
 <4a031bc0-fba3-12d6-428f-a378aba1897e@grimberg.me>
 <CH0PR18MB412996A6716DE9AA114C09B0A1319@CH0PR18MB4129.namprd18.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4b77d39b-00ba-317a-658b-b00be6cb3e20@grimberg.me>
Date: Mon, 14 Jun 2021 09:44:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CH0PR18MB412996A6716DE9AA114C09B0A1319@CH0PR18MB4129.namprd18.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_094449_733802_34911DEA 
X-CRM114-Status: GOOD (  12.04  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> OK, it seems that the issue is that we are submitting I/O in atomic
>> context. This should be more appropriate...
> 
> Thanks Sagi, this seems to work. I'm still hitting some other issues where in some cases reconnect fails, but I'm
> Collecting more info.

Same type of failures?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

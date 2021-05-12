Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB4C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 20:52:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D26C61278
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 20:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D26C61278
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HluHBSCcC7+PTm4Ge+dCTscJPeiI3KpODASoeyn78Pg=; b=gq/7H0+8Ps2PSk3IaCDU4cEmV
	cwJFV4mtlffSxB03COMAaGP51xH8RPsOcTcw1SRtC1dwVzxv524QxSfyiM6g7Pet5tD4QhC5CnMge
	jotHVbpfX5tAkXfMP6E3EYo3nTqblqOpM7p9XfOv3D7He4208yO30wl0j4GDy1woKmNnfI0lUxQ4F
	/Q2eqo1yeEFju4Xv54Da2bBiMXeKlhCUHD3vr75KK2mosY5yaoxCbZXYXqiQTeZR6bGk3IjHHSVtX
	WSCdE1fXFJjcG0QstJTrGx4UXHSGEcAh3d/+yQ/NjPooGkH0S+JPwuJbl1EXS1PLX3AsD1LtrzDk3
	cOTCGeciQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgvpy-003xZt-7i; Wed, 12 May 2021 20:52:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgvpv-003xZe-9J
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 20:52:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=dW9jY5iDe6TdLoVw0iIbuhc+5YcGPLZpguFi6qHGBl0=; b=xEbBwMdb8PucoWG9P+wWxghWJJ
 SJ63AVopxMhSWQgAsHzU+Hj6RaOQF6CWn5puPZ+4UvpIdjpnEHNCK8mqN4DVIVwSntyblpYE3tcVN
 ynvGvvv19YP8DKgBLD465TJ9BUuqLwEIbtR81UBj1UA+euTqtHpo/IqKuBxSqjKSheaDQSqoitBpd
 LZj42vioav69thQ24/boEmOm7GsxuRtZO63xVBJxcSP1aHXhlmAID7sYptX26vaCFavV7+KubpfCa
 M5PSI2sUbIBSaD1pi1wZ9xUrCowMnfq13xGJh6wN8x6bsVFl14XtCrWQSUc0JVS7xi5wW497s+h77
 01oP1+xQ==;
Received: from mail-qt1-f178.google.com ([209.85.160.178])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgvpr-00AonN-Sm
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 20:52:05 +0000
Received: by mail-qt1-f178.google.com with SMTP id f8so14116088qth.6
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 13:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dW9jY5iDe6TdLoVw0iIbuhc+5YcGPLZpguFi6qHGBl0=;
 b=gh5f6ljKanCSDZOP405ZQ23vJ/ku3dvEHa4vXNYxBUxtbQHbs4cdD3VErnhay61NJo
 Uu9bLTD8BG8LWWza71DMC6tTu16rodRo7KUemj38A1/nTX0NgCC6zqYP1C0FO53sbIgm
 1mu0Y3Kb811uzuWbp5/w+N21XusIDsF+ELfGrLVwyRvVyrB/WHHE5WMlzN/hjjIR6psF
 8RpCVcf+0dhllPYp6EkQoTiJVOoj5n9v7q9wv4uz67J6eyk43r4SIJOZ5+/XfpvQq1eb
 ua5NBJ7AjcsjCRgT7b5IOUqslD64lTUh0Fn4OuQ9MlQFhjBH/fu6idofEHM8Vj0TrKm7
 FzGA==
X-Gm-Message-State: AOAM530Xmt/5hQAHudgAUHvLQh7a5p8npR8n04YcToINhu/j4WEN/6Vn
 o4WHeDDV0in9UseCorOUMh/if/HUYVk=
X-Google-Smtp-Source: ABdhPJyIYnUao/xAMgW8jgAfxTb6I4MB1+q4TE0IZtgUWrwiTIgnFJBcj594S6+uj/Dr4B5ghJMxMg==
X-Received: by 2002:ac8:5d0b:: with SMTP id f11mr36005243qtx.132.1620852721603; 
 Wed, 12 May 2021 13:52:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id f16sm818293qtv.82.2021.05.12.13.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 13:52:00 -0700 (PDT)
Subject: Re: [PATCH] nvme: allow to re-attach namespaces after all paths are
 down
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210510144906.8305-1-hare@suse.de>
 <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
 <d3f800eb-a917-d139-b430-b7b7976331de@grimberg.me>
 <20210511213741.GA1924433@dhcp-10-100-145-180.wdc.com>
 <75c0ab18-5dd5-a7a0-9e53-29f6200626ce@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3a7518a1-2929-dead-4f8a-937d5005fe34@grimberg.me>
Date: Wed, 12 May 2021 13:51:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <75c0ab18-5dd5-a7a0-9e53-29f6200626ce@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_135203_963993_BE3AEA5E 
X-CRM114-Status: GOOD (  25.86  )
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


>> On Mon, May 10, 2021 at 03:25:04PM -0700, Sagi Grimberg wrote:
>>> Hannes, you sent a patch like this before, my comment was that a nshead
>>> should be removed before the final reference (which who knows when it
>>> will ever arrive) as if a nsid were to be reused by the controller for
>>> a different namespace then we'd reject it so I'm not sure how this helps?
>>
>> Hm, you're considering something like if a user does namespace
>> management commands to delete one that is in-use (mounted, raid, etc),
>> then creates and attaches a new namespace that happens to be assigned
>> the same NSID.
>>
>> The new one may get different EUI/NGUID values, so this approach here
>> would prevent the namespace from being usable without additional user
>> intervention. I think we'd want the driver to allocate an entirely new
>> head in that case if we could detect that's what happened. There is also
>> a possibility that the controller recycles the same NGUID for the new
>> namespace, and that could be confusing for the application holding the
>> open reference on the old namespace.
>>
> ... and, of course, none of this would happen if we would _not_ keep the
> old nshead around. I'm still not sure _why_ this is considered
> important. After all, things work perfectly when the CMIC bit is not
> set; even device hot-removal and re-insertion (one of our IHVs tested
> the crap out of that one, and I can confidently state the nvme stack did
> not cause any issue there. Unlike other subsystems ...).
> 
> So I'm really curious which use-case we're trying to support with that;
> EIO is EIO, and the application couldn't care less if it's generated due
> to the nshead running out of paths or the nshead not existing...

I don't disagree with you Hannes, hence I think this should be the
default behavior. Christoph wants to see a queue_if_no_path behavior
that would be the existing functionality (although I don't think we
actually provide this type of functionality because we _do_ fail
the I/O as we don't have any paths).

So I'm on the camp of restoring the behavior that matches non-mpath
and then add queue_if_no_path properly as an opt-in.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

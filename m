Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE1BC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 17:08:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047526141B
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 17:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047526141B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B58jO99s5no5/eiu765WQRvkl0jnafXtB6cXZxIIh38=; b=nmY2K+NdrgpYHjD8V6MiY6+WY
	yBXBcKUiN/Ve9CI7BUlmlfc46gTDmP4pGzpOjWMDr0zZylE4bvu/BRtk+8HnzwetrSSS3Ft9CJrlD
	VsOdUX0sIvB08JBQis4QxBn0reZ9DRuc6h4ksxa3O+y5s/wFnhmNl77hTwPN3iKUbGZFV68g6d3UL
	vWR92HJUb8NkWYiGkYQPtJzVs3mPxSLaGpUILSuOTZQ/J6bJjPnJqnE705uHuvgKZdYOHGIngciOP
	3QLvZMahDREOL9+GH09wEouT2tcmHTBF6+DeqJb/qBkX1wNz60JfYHurrKy1jfCKK4VvBrM7uArEl
	ueJdTogSg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhEod-0062fX-Ce; Thu, 13 May 2021 17:08:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhEob-0062ev-8h
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 17:08:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=+pz+B7Vh/yB30QaZtxQETJtp46lqx44quP0JA5mjmsk=; b=aDNQGSQeXUxg5RIdrkCnb9qcvT
 U1yirfTbGAt+dYlgthttYmV4Gw2/Y+aXWhtWrvqdNTr5IRVlbWek22ggpxQeaEYd4PlZYloS0ty7X
 6RtgtVy/wChcrVMlyIFbakG4RiMn5HyOOSAFgWnASMby6M3WJoo0k2kJqBGwBE8JzrXAo7e7Z8Zlp
 umz/TT4sZR2Gdqd5/o8f6mfg1Y51T79bVHtlaGgrjX0SGnFbd2leYjOutyzWMHssEu4VNP0BaA/0P
 coKo/MuPHKrxagdf/oq6lEJ9SivHxap1h8cyheLDSqf0k6DEUdt1pfrfKwNjPcKS35xw+OA8yQFHo
 NP7d9yOg==;
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhEoY-00BPFc-Ij
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 17:08:00 +0000
Received: by mail-il1-x12f.google.com with SMTP id e14so23561540ils.12
 for <linux-nvme@lists.infradead.org>; Thu, 13 May 2021 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+pz+B7Vh/yB30QaZtxQETJtp46lqx44quP0JA5mjmsk=;
 b=Eu7an7LTNDAg6J7yaF6AmYS/ChuinUpzm0/YvN7E62kNV0mesWTYs4UACch6GUEk/Q
 nqaLJUU3MWzUYOA+05V8X56KEN8lbegg0RVwmTULAelRyuncNqoKJhX8fXGeRoRYxm+9
 2iRr2Gdg3S/ekgA1ga7Q+wnLLqrC4VRFWt3wpf0A26azz3jj4ewmM0Ica5ksItZC3uvq
 PRdDOPTssCA9Mi2g4wr9UrBS9sWftZDTK6tUS2KsLbaLaOP8BPdiKqqrMiivEC9Rmf2x
 6/Hm2ucrmOTAe0XHLbl33B+62c8xrZTYprSVWDGmnlFtPi6iQ8/lhBoutemkAOySTyZh
 xEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+pz+B7Vh/yB30QaZtxQETJtp46lqx44quP0JA5mjmsk=;
 b=jJcRePLuhsexG7jSrC3+Jyq5ylVXUJDKFrrTZVyXCno3XjxLrnLstyQ5PoIaUuaLgI
 /nl/7IFXYxTqEkfXrxi+hc3yglyRvFzzYtScpMAXoJQG45sU4MOsryZcxdM9niJzHbfK
 NLVKIyWgJO4N7iCoRxjTW+ucq42FedQoDsrSv28mpZAygsH3JQPhBO06skMU80i1vXPo
 QDQqDDg7nP6WuqzXD3NvlNFPGf1HebsLTqIqkmslrvpmUDEA7NFgj054Sk3QjXmrwAP1
 vA8tHrqAnAgrsOkUepZSiYsfYfL6CgfMtoDXZR5L1zZpm/pl7bd7SUQEbicF4AR3ax56
 48IA==
X-Gm-Message-State: AOAM530Jlwysew2Ehznmd+Uk2Vc6e5vQxzEGaOJ81UOGan1LQ3sMosP4
 H6jtKdI9K1i2L7RJDkfRl5fSov0bwmSo9A==
X-Google-Smtp-Source: ABdhPJw1kIBMmytzxogqo7fn3kFHFilpUhMsaq9CV7g1YAtfFJl3KzQz6GEcWdSY2PHE5ncGfhkp/w==
X-Received: by 2002:a92:cc02:: with SMTP id s2mr36177651ilp.101.1620925676783; 
 Thu, 13 May 2021 10:07:56 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id u7sm1400392iof.41.2021.05.13.10.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 10:07:56 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.13
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YJ1b7OeZpoR3j13K@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a9528930-b123-af71-794b-55b2b9bfeba0@kernel.dk>
Date: Thu, 13 May 2021 11:07:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJ1b7OeZpoR3j13K@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_100758_785744_1B15D2BC 
X-CRM114-Status: GOOD (  11.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/13/21 11:03 AM, Christoph Hellwig wrote:
> The following changes since commit efed9a3337e341bd0989161b97453b52567bc59d:
> 
>   kyber: fix out of bounds access when preempted (2021-05-11 08:12:14 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-13

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

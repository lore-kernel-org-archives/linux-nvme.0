Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC65C77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L/HKzMF9rbEM2xdVPx/iafURtJAczrvtIv/eIOdbyec=; b=kKDfkqjvd+agosO1PIuwd0twpo
	E7qHH47cFjwsgr6+cFwL8IGoSA4vC72GYjcMOkVKrfEwuVnI3NOaOF16T0d0RinEbUY/C3+3p7SrL
	HA7FW/vhQV4Kr2zsbk9e2GJXDVH5jRdK3awgs8k/DRY9eURFWQAS3FfdS2ZH319d+n/0svmAuj14Z
	/Gw4cvCIYTJoW5jgSKeKX0Wce3ON3zdHbSlnvpewvY++yyxSEWYaQro6ESZs5J1Unj9XG7AyzEvVr
	MXgo/Rf8GqWBMA9rhEbgP2EQ8OLdLrkY+zZRmVgd95PBrdwyNFB87Bg1vLrPlAk8wbdOKMnAZnts5
	IOpJHWMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppa3L-008sP2-0K;
	Thu, 20 Apr 2023 19:34:47 +0000
Received: from mail-qk1-x763.google.com ([2607:f8b0:4864:20::763])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppa3H-008sO5-2v
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 19:34:45 +0000
Received: by mail-qk1-x763.google.com with SMTP id af79cd13be357-74dd7f52f18so317350885a.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Apr 2023 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1682019282; x=1684611282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/HKzMF9rbEM2xdVPx/iafURtJAczrvtIv/eIOdbyec=;
        b=A7DVRAMRzKm09PfGA90M0MLgrxVkcdM8vQYQ7pOs4xeZgqFH+zf0AY8d9E4QCO0tOH
         5hnzb9s8RfQ/NqqA4bDRrEkZ6DMFv7S3rObLZyTaAY1TVmDSnYvHn3YhsSJ6DkYpapRT
         XlPuJTDBCBgCb2n9JH1WVERm1RbAs0RUzqSE4Y2XS7DH1Cgg7VeJgnOIvEVK3JDg9d64
         qqBgdF8uoa5GImsm2AtZk4ijt9/UvQLpS8f1F5rmeaQL7C6bl7H9A6gYIIwMz5mGRMBP
         ZmKZ1NggiV+Fzf4Kfxj1mSj9/xZLpAJAq2bDohGLFc9HZbSzQe+yEKTSAIR1605QdmlR
         /hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019282; x=1684611282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/HKzMF9rbEM2xdVPx/iafURtJAczrvtIv/eIOdbyec=;
        b=DQn09n/gGX+wiR8AgSSFctLykzwsz+EBddj2k9ppDQ0O3+zu/qRfzBTfUO1m/d8/fu
         ztOpSZa2q195Mdkxd85v6RvtYMTEz6+KkxOYzqOprDr9TtuMvGWy2hCQ9EnW1sGiQ0lN
         lBxxA6IAXcRLgqpQfPb1a5ykIUBGj1fvjG9a5KZW9M69/jHS/k3DOzMLmi5OOQGrHC5Z
         V9g1Vw5v3qvdsvwbJunXUxADds6RvbQBnwJ+hRXa2JEkYI/cIfhfUcoliT9UauKQ2obF
         MKbO3FxQZjFKGoSHH97UTvdbAxUry8gOKuvKl4hCYNbPxwGb5pA74HprbOI07K5Gdpg9
         nAKw==
X-Gm-Message-State: AAQBX9ezb3Js5MJWT/+93VFw0G2ZMZuomGvloN4/gTdaCPsSpKXsorDz
	/IH3TptwHX4c12xOBPAeD/jUpvEL0CQ1dmQuMOt5JXH4L/fNjgJanVDgoZr2+ZhgrA==
X-Google-Smtp-Source: AKy350a6FDQdJz4T0JnEXS3MAQo8PsEPZhAVlQZP67ZbmRdMgKyfnuC3elt2pGC/PLdyNDPNAuqBcAeCFIDL
X-Received: by 2002:a05:6214:1c0f:b0:5ac:d6e6:452b with SMTP id u15-20020a0562141c0f00b005acd6e6452bmr5549125qvc.24.1682019281863;
        Thu, 20 Apr 2023 12:34:41 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id y7-20020a0cec07000000b005dd8b74b9easm189733qvo.26.2023.04.20.12.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2023 12:34:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 2176920950;
	Thu, 20 Apr 2023 13:34:40 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 1CF00E42E74; Thu, 20 Apr 2023 13:34:40 -0600 (MDT)
Date: Thu, 20 Apr 2023 13:34:39 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: improve handling of long keep alives
Message-ID: <20230420193439.GA3766288@dev-ushankar.dev.purestorage.com>
References: <20230417225558.2890062-1-ushankar@purestorage.com>
 <20230417225558.2890062-4-ushankar@purestorage.com>
 <8c3c82ba-2551-487a-4593-b9369e5ccfb0@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3c82ba-2551-487a-4593-b9369e5ccfb0@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_123444_168717_66688708 
X-CRM114-Status: GOOD (  12.93  )
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

On Tue, Apr 18, 2023 at 07:59:51PM +0300, Sagi Grimberg wrote:
> Is this something that was met in reality?
> 
> it is surprising that host->ctrl is super fast and
> ctrl->host is super slow to the extent that this
> situation exists in reality...

We haven't seen this exact issue in reality, but we more generally have
observed significant delays in host-side keep alive processing with
controllers that do not support TBKA. This patch should help with that
issue.


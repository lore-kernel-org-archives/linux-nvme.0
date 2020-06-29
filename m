Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C47C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 14:39:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8DF23E1F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 14:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="euprNp/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8DF23E1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=euprNp/wuNvhRsu9U6uaFtwlF
	EKD0psTnUpaPWOf2R6hXFdS6xRE1KQ2U25+tH7cTfI/x9gTG7c/52xgD8gOECVa8q0WUf9fD4pBV9
	/7G130ancuHhtBBqeEMTjReXGaFn/FLN8YdrvK5dyHJcarsyBvVN6VwL13x55YZ9F/YB/jMvzvZoj
	sY7EAnyQH7f2w2CDUXmlXfR1xyj6d5ftWC365EbToEphT4XR7okh0y+lwzUelesRYjJd12k0sWB/R
	xafjZ/yKfnFi8jlj+Y9VDxuo/ykWmve2IVBUPfXUndJ6aJtcG6Ll2Fpiz053ZsLY7CO3Zx0nL/gNI
	WCGk/bWfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpuwa-0005bh-Rz; Mon, 29 Jun 2020 14:39:36 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpuwZ-0005bL-59
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 14:39:35 +0000
Received: by mail-pg1-f196.google.com with SMTP id e8so8402158pgc.5
 for <linux-nvme@lists.infradead.org>; Mon, 29 Jun 2020 07:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=qi6yneuk2on8shiQIy3ra58QPYQqpduiSruU+fW1GxRUjvCPPsdRxDFFPsSDzWhizH
 0Nnqo0gaEAPoSKxvNr6Xc9AlgsAjNFN4H+28tX8sKZ2cCxiXZg/u0QfYwdFsBZR1Ejhx
 JuGlW9zLWK76Hnul9HXDWsuKO6ohAej1wnfSDfs1bPHXj9I+5/HeOeE4j3AMGLoA5ueM
 PWv1rESITJfR0RyJ2VU1SvQP0W+13dU8XGQ/JucUBphuLWtxOvlvhiNIGEDmY+QFV+Vr
 OZJzVwPN9MMHOWubMVKQx1/LQ3xgK4vbsfyISDE8tnE42l8ywisF3se8H1AI77/iBLpF
 C+Hw==
X-Gm-Message-State: AOAM532baEbuqtDTbSVepXpQ4xOY5M4Gt1fomD9EU8gxaXsrrPx6FvUY
 lQLcB9izUF+hNvWdLfTkUzYXtPq6
X-Google-Smtp-Source: ABdhPJyp02oY02DCXKF6pkrmQu1wYpTxnQwpIN5C/8wGNpVWE/vGD3AAv2KJVgc+GOcU9mau5hk/6w==
X-Received: by 2002:a62:8782:: with SMTP id
 i124mr14672059pfe.267.1593441573343; 
 Mon, 29 Jun 2020 07:39:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:944d:12b0:5a40:4890?
 ([2601:647:4802:9070:944d:12b0:5a40:4890])
 by smtp.gmail.com with ESMTPSA id f132sm33115pfa.122.2020.06.29.07.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 07:39:32 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: fix a crash in nvme_mpath_add_disk
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
References: <20200629143422.2695541-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2c04e603-f95e-5871-028b-e641058bd38c@grimberg.me>
Date: Mon, 29 Jun 2020 07:39:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629143422.2695541-1-hch@lst.de>
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
Cc: Avinash M N <Avinash.M.N@wdc.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

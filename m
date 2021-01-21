Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F0C433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 12:42:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79B4239FF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 12:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79B4239FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D8Fzo7tBWNP48c1t6pYOoieCjdaq1xOqat2b4ehIKaw=; b=WSfk3vemA+5PilIHiUU5ljsJ3
	FTvAPr46NOGvIs4B/6kH5FslZ63Tn2wzj0Uh+itgVxCUj9agVDsv6DYkoz5bccQFVVvx2lItaJ0pn
	PfTjRhbDZwPYydwPGP4nuOMEKJtx6yxc+8aVi6ahkIxPzdm0KAYHrBxfjzb0/QSH8LU4DxHCyOzAy
	TmMlE5qiOxe7qMISFlHvgMHa4wyvSzyj4vNx74tzsNj5NnNtTAxh02G6oUKsGsaxdQ8WH0Io62KMs
	aiNdm6I1cHQ426oHI4t7IzRJF240/JA31tWT/HLIBjbflcIwww2dL2IDedYeVvSCl+Ur8MKirr6q3
	BsWfP4Idg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2ZHr-00080D-UN; Thu, 21 Jan 2021 12:42:07 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2ZHY-0007oh-Qn
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 12:41:54 +0000
Received: by mail-pl1-x62b.google.com with SMTP id e9so1235321plh.3
 for <linux-nvme@lists.infradead.org>; Thu, 21 Jan 2021 04:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y529FtFERDo7JDSKYw/bu/1ClbCa25CZp5yymZzYueE=;
 b=UptwjYHVCvrX0UGD6PP2MpbRR5snXxoMH+GBR5pTp9rjy40YSpO7/kHjGuC8ETa63P
 9cwW4FSNhH9npCnlEvrcFyCvA7dz2P5L3t9IO4Z3CzFGeN2bV0PQvVdXDrSW1eOJnxQl
 ZfQW4p585R4PMOsMV2fNqFu+jtaLlqfAu1n8YuaIh8kbZ1bxzOiiXONMlPdxD0I/1qmj
 kNCnv/zeMjrx6d2Ur66QVasi5aH6xA26/eHDae/L+N5BbULHBnIBzoAJt7qHgfH4Swg/
 aJFG/YFIPcIPt1WsQREXM+BVQDabiJ9qEtlwbY3TPr6Jv9fJEzeFEc+8d0SzgbJ0PfmR
 ARZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y529FtFERDo7JDSKYw/bu/1ClbCa25CZp5yymZzYueE=;
 b=HY4iV6fMBJ4tmus3w9gw9N8Q5XrcBIemfcn3HJiGPXUh3+/nXSAwU2AYgMgxWoonpW
 etMajYdZLk0TNqjiPJSkDFvmmrvLsswec9XgthfI/maWQUiw+K8wF4HxloZwzQf74VT3
 bOCWZ5ggHOEf9v+TyKfd3VFm8hpgi1EHHW94ozg8KQW014TDEyUtMfJya9oU8Brm0lTs
 TK2N9owuqxSfT2dqdgPRryxJ7kD9C78ioVaRnq60W7FKMo3l/k8B0pH/RJovpInsWTao
 0GfZaivyH3yu1lvANfwkeDm2R3L3UKWA1YMrHRq8BoLBzvYdRZn6gPTeN7MnDPj3cYEB
 pz/w==
X-Gm-Message-State: AOAM5323IvXA3XrszaBzSSZ5dbBqM1NE2OORtl9F3bFOFWeZzYnq55DX
 6SvdSdt5283lB00ukXeYNRQacluxB3J3Jg==
X-Google-Smtp-Source: ABdhPJxARoaLrWkgDZOaFzrATmKOLqafQTnAGhPT+1NN/SaNxtdaRYvHuglKXHI9hv0C4IguB6cxTQ==
X-Received: by 2002:a17:90a:7085:: with SMTP id
 g5mr11674367pjk.132.1611232904278; 
 Thu, 21 Jan 2021 04:41:44 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 lw17sm5192742pjb.11.2021.01.21.04.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jan 2021 04:41:43 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.11
To: Christoph Hellwig <hch@infradead.org>
References: <YAk8Kt/DRZ7T6WBl@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <24912e65-18c1-2b15-118b-854b9d9ba658@kernel.dk>
Date: Thu, 21 Jan 2021 05:41:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YAk8Kt/DRZ7T6WBl@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_074149_079934_DEBB1275 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/21/21 1:32 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.11-2020-01-21

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

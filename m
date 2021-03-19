Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF84C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 12:44:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1588564E60
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 12:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1588564E60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ocw90KspNXLtBz0pfxyd3n7Fb4IK5WCt5fBt0H8hh10=; b=KTjLH7X+aElpKkZUUytXwLvPN
	VbmSzOS1czwCRv9htrNPE7UOqVevNzf3be3+wlMPJYny5dtZCS0UyHQ/k/Pu15TWRBVdrf4RXlna5
	ylzD6dNY52UMpnWUsTJm4c1cvTWEc6RakQIYkqa8JFHr3oRrYG8eEGRRIlPZnmS9vRyfVplxJwwwG
	tZwwN15KZrOlAQBdCFZGDG+PfTdckJ/UJ5uu187IMKFXxF2hjD4E5K7qeN4sM/U7tT/5OOnheeXag
	SZQp64mb5vHt5m/8eBDnptqJ3kOKmRUufm93FMgqZBGAL0GCkyYqWSG7rjeA2mWNI4jXRdFLbnL12
	GlNKqzorg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNETX-007Pve-MW; Fri, 19 Mar 2021 12:43:35 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNERX-007Pro-BX
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 12:43:33 +0000
Received: by mail-pf1-x432.google.com with SMTP id l123so5814644pfl.8
 for <linux-nvme@lists.infradead.org>; Fri, 19 Mar 2021 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w0ZdVyANdr56S6dEpKoAB7XUWp8JxF+HTfgSoDwJ4L8=;
 b=amOvbcp2TUnXsfdboUSaCAK4AZ6DR+WkrKflVSmVnI6sYUkUw/l3nhiEEK/QL+TgN5
 q52JfZxcqHv2TV+Ez7IYIXKSO/3WQY2E/YilLo1J598SGBB6CE2mESV73ihvfSDHTfv6
 LqbxDjU6mOqCEMcHnxucftBEJGICQUxOrMLzs56hcUEeqL9DpojnwUlLrcMsoE7J1cpO
 RHku4Fol3sTWORgNOFMZoEGdchjGP4EaoHMlEVCitqibB5m6gTWtxP8Al2ETdmQK5aaZ
 o5Nyuq3g9y1Wbx1KgUataYMVv0qfhiFiW+48z9622b6JzmuGoC3GGWaIEmx3HcyhTdda
 HltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w0ZdVyANdr56S6dEpKoAB7XUWp8JxF+HTfgSoDwJ4L8=;
 b=KYdszCTawEfcIdCNSJBbS0Xt7x1Jd/dARGlRLOi/7wW61NA7P1R2OPpe6HTumq+8lO
 RRrNa/mbTSpyitOC1e+RI0gnfQ3UVCg8eWDQRISw78zgNpoRuTWar1Uh7cyZSSH54UW4
 XrSuo9PpqqPrHjRNUyb8r54VglJPNN0AjOH3jSGYK8+QOc2xFTHpKe+EZFRafUC5zYNL
 YxdM8mMySj5TlJwfsEO8OxIoHMLG5njHqRF1aNANoJRvzPifoodlNrtVdJNUHxseDAW3
 M6FfS9uQxsTt8j4ExsWlIHCjNe748IMqOp4CmiVBlIeKanCELPg8y/eQy3DEpixg6yaG
 R7MA==
X-Gm-Message-State: AOAM532KyvyyLM2nz4F8ipSpGaUvJdWYA7JSZfwHLUcPy0rSJTopa88n
 L6MK9nIymrd3nhfHtRzzNCow7ItLemziQQ==
X-Google-Smtp-Source: ABdhPJyHL+YkVkYDx5KBjTg47GdKiJEL7Ww3FNf3BBSpPxNBuU6T4GK5er6jHfIy+PvhhT9/jS8ivw==
X-Received: by 2002:a65:5bc6:: with SMTP id o6mr10956190pgr.127.1616157689633; 
 Fri, 19 Mar 2021 05:41:29 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id 143sm5722651pfx.144.2021.03.19.05.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Mar 2021 05:41:29 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YFRPRP/WLS/5FCSc@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <91e2de6d-b6a7-b3a4-8997-b43d58076017@kernel.dk>
Date: Fri, 19 Mar 2021 06:41:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFRPRP/WLS/5FCSc@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_124331_743035_53AC6DB6 
X-CRM114-Status: UNSURE (   9.29  )
X-CRM114-Notice: Please train this message.
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

On 3/19/21 1:14 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.12-20210319

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

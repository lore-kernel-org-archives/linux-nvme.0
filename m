Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0F8C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 17:50:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD6520872
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 17:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bhmn8TE8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qSY5F6BD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD6520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h/BzEDu7kAShjj2WSDKhYsz2i+OpU3P0/3f+BiC8gwg=; b=Bhmn8TE8F5gPf4U5xjT1q3a8+
	W7+n5EJhzKOGBICQLuxiS3TADzcZwOlFwtwJw0jeRfG/xtnUNEiXQibYQOQoeDYsjb7oPLiZQ55ls
	6a0dDQyqf6+RJP2JNZx9OzG13vuuFoQxDSpd+bfZQCS7BJb1u+oa1LSM/mg9D0WkInstrrmS6O2bx
	Sbhhz1pRahZkov8rxHcqYTdnbLvodCbuWveFdBB69voN/Zu07r1H3haHQxAPsatz3yqGSkG6WoVG+
	jSvAemFC2/MPsfWWsZ1aLw74K7oOdf4Tr9IdMZZ1S4DDvz/rjMzxkwAJAaNS1w1YGjfieJpXKU/dv
	I29iD+7Ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIy3G-0001QW-UA; Thu, 17 Sep 2020 17:50:34 +0000
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIy3F-0001Py-Ar
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 17:50:34 +0000
Received: by mail-ot1-x334.google.com with SMTP id u25so2719142otq.6
 for <linux-nvme@lists.infradead.org>; Thu, 17 Sep 2020 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VxNOaXEECYIPiRMfEtgGM6J1GaNFcdRWrXQNfSu136U=;
 b=qSY5F6BDO89WMA1sSn7TKzY4HEDf4VLctTXFU6b+T/WBItGXomuSgN+7+NMY5BhScG
 ip0r54waBP9e1I7OQGS2akynGeo4RhDqTdMS8Vk1TUN2HwSBISGr8mApFjtpPwA/IVrh
 //msBJVf0pH4LGY0Lkl0ZLuKCN4Tyyw917nmch5DdE23duXnAfZT7QyqV765S9dYX/dm
 ooFMWohAP2+hij2S/DoUoZ47GKbmQyrBV8/TaWUcSe+u2Jkdo5tDjbLBhAPUSRsyquOT
 nNSnCrr3VxOskVGOOk1KqCeMY1+x9E6QJMID6jfYDyAYJOz3UKbFKdcp04M9jRaph4gy
 w0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VxNOaXEECYIPiRMfEtgGM6J1GaNFcdRWrXQNfSu136U=;
 b=UB5c8Zg2Umm/qQ2mozN9DQIzL3o3Bg4OFDiJU1QO245oLgqE37Y/Q1RG0QepSzNXWV
 VdMGgco6ep2xCLYzNl+y7otz8uG+fJnBvL6qIoHMrRVeiiuwv6RwkWPTpgSswfoeo68p
 iQSpWfPBTlqhHYCV0AMXKfbuvxS1GCMw7Cx7d4d2dFIMw3d5PjyNytZthWLbtCb1mSq7
 7MEHrqZ84eO05A4ameiEdfcvZDf0ofrqioYJ3+qGwAZWETMCVUsGV43cbuyt0GOkks6E
 KaimR8jlCUUJRNv6JVqAv3gEShdHoq/jFhy21Ys7olHOdFT4FwB4e7+cVuKzGooUrbIw
 Hq+A==
X-Gm-Message-State: AOAM5321sYMHN6V7tc+/RdCY8zMj73K0heBE1bP7fnBUHrutAIRWCjOl
 99BO+hEZoWqZW9+CHXUTntEmVA==
X-Google-Smtp-Source: ABdhPJzwaXf26BDvAr9jXYMUUqbBTXgS9OmYfDxadvq7iqdRZ8UO9UrLPu3sOlKvXnAJJwXdfBaGhg==
X-Received: by 2002:a9d:5509:: with SMTP id l9mr22106336oth.154.1600365029636; 
 Thu, 17 Sep 2020 10:50:29 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id h28sm356619ote.28.2020.09.17.10.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 10:50:29 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.9
To: Christoph Hellwig <hch@infradead.org>
References: <20200917173654.GA3311729@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e2954fdd-c161-5a5b-def5-f93dcbcefcc0@kernel.dk>
Date: Thu, 17 Sep 2020 11:50:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917173654.GA3311729@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_135033_505030_702D9F07 
X-CRM114-Status: GOOD (  13.77  )
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

On 9/17/20 11:36 AM, Christoph Hellwig wrote:
> The following changes since commit 709192d531e5b0a91f20aa14abfe2fc27ddd47af:
> 
>   s390/dasd: Fix zero write for FBA devices (2020-09-14 19:40:21 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-17

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

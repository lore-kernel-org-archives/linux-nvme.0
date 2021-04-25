Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD116C433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 20:19:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B0661184
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 20:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B0661184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HIoUmLfUTCJGqOO/ApsPD1AuD7qnd7YrRYDhC3zATE0=; b=X8r4FP4wvIS81wpRJ4NbjVft+
	qX1m3pgmayADn0YJ+eeI4kHMqtgGh+qLadVwK3ZtWlK0YamZo5UnihLElMMQzaAay7my/w5E7xIEU
	CUHpEv28lXWI5aWMHF3Iwvg8BzpubF5i4i1jaHiU9VQY5I14+AYnfy/9xw1TBahZjdbcu8A/cjoIQ
	O6xBEHim6NeeZEvk1KpcHzQvkFABYsSe0svXbnEZQjAH+mskTjaZfTCeT1MKMO4DrXcfUvNfz2DAO
	7e6j2Sj3jhDjBQNmX+d35ShDO7rAyw1Or1V5GvhghDyJ2LRDi02SKTwxC+NxJgiGY7UgMV/dFy+Iz
	NP223bfUA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lalDQ-006DdS-Cn; Sun, 25 Apr 2021 20:18:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lalDL-006DdI-Vv
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 20:18:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ctZ2CQtJPnMYclVf07dU+sHVR4/FEattLgQ8J9FusIY=; b=QSELPDMeZyusKdsc5dqOkKMMvT
 +/nl21X8ueAWZ618HBez1onfEGh83Dii/LE4tk/qpQB2VMj4CmWFmvUtgiVOuqxw3PhSxN7DUeR9y
 c40jY2twSMn6NLkYl5+KP/auJMoopvCChA/6b3aCtbn7QiLy+b0Uz4ZRep0wrMa7aW2v4/lEquLzi
 YPSNMDih3fkGX1LwdBbdbTDu8QRtmv563WOVEJt0FYpnIUqCmwqCsV0nu6R6HZOwbUqycW5kmfW76
 wgrkvi5ERJG0oB3EGMq8YocTvH/23lmerpdnSkyw6o1Wl9zr1QoiF+x2cr/mQR66xRtZ6C15ov1xj
 8n0UfoMw==;
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lalDJ-00FaBP-5g
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 20:18:46 +0000
Received: by mail-pg1-x531.google.com with SMTP id z16so38725424pga.1
 for <linux-nvme@lists.infradead.org>; Sun, 25 Apr 2021 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ctZ2CQtJPnMYclVf07dU+sHVR4/FEattLgQ8J9FusIY=;
 b=FcsUGlNC6jMoTfhFRoKwZCHIbL19ZNpqM02JFdnKa4S5UZ/t1sJo7DS7lIzLwo4pUG
 TEWNvEGHaSKVjPvNRUr1gtAbeDCjlNvLIxui3EkhvrS7bth1CnNAvc7rx6mwgGdC3JNZ
 btiMvTjfUPBlcd7/2RuabQrNETMEVslobeKXVpEDE3DiLxjDv+nZlGa/iQWcex4+B79r
 zoJl0GL3lkFbpeF6R0YrgMMMUGcDP1sLRC+Rm4b6bD/VDKDW0azaCm91mEwzzDzVRmZz
 fi8HrHjY8r9lPZMlmGWd5LmiPXUl+SR9WnWFWQ6G1r/9zKqNqdC5VhQDHSUDFs07n16B
 uJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ctZ2CQtJPnMYclVf07dU+sHVR4/FEattLgQ8J9FusIY=;
 b=VzhGLrmGVb7Cs6hfgPD4AY4dDzwQnlEQAFxbihTFLMcDITUEXPnyOn3GDL/1omqOpU
 DqnicNp7UEedemOB0u+pMThQ5X16enpQnX75nfhT1Ps2TH9XOQ8Y4GjtGKIJLuQ5PCEX
 5SHrKkaCv0sB0QfQMipJBXMrmkdZNWZdKOJ7XIdlxqdx4vCvJ0M8GpnkwfEsnLDuZwsc
 teaqB3p6nBFVYUOQbJkno4UUyoDuG+j6NatKjrtvMG0YlPHlvTQepa3cKn40SfKNys//
 5tazHCBrdGdcgncNYjhc3W5/VmjKZ74mL82rsANROgMCnBUqzgg5wSPtg06uXdGnTZaZ
 a0Tw==
X-Gm-Message-State: AOAM533DSXQfgAmsqCU9qmbMEsqahaAd9YScpOoNSS1dLJH696A5j1sK
 B6Lxo7prKhOW1EAwGvGr2opzdA==
X-Google-Smtp-Source: ABdhPJzeQ0v5+IQ8etbmEF/bVIM9K9+k8nJ25bYhaJ5TaAHfCSNuxoLpR0JF/CSBFWgB5skRmSxAvw==
X-Received: by 2002:a63:2d81:: with SMTP id t123mr7029607pgt.224.1619381923984; 
 Sun, 25 Apr 2021 13:18:43 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id h18sm8635748pfv.158.2021.04.25.13.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 13:18:43 -0700 (PDT)
Subject: Re: [PATCH 0/8] blk-mq: fix request UAF related with iterating over
 tagset requests
To: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <77cbc472-279e-5c9a-3428-b1a485b3f1b7@kernel.dk>
 <f4d43e0d-cdd7-4a8c-9852-bbc99053fd81@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dc5a66fe-2678-994d-d7ff-6160c3626d83@kernel.dk>
Date: Sun, 25 Apr 2021 14:18:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f4d43e0d-cdd7-4a8c-9852-bbc99053fd81@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_131845_290924_744B4F75 
X-CRM114-Status: GOOD (  19.62  )
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

On 4/25/21 12:39 PM, Bart Van Assche wrote:
> On 4/25/21 9:17 AM, Jens Axboe wrote:
>> I'm going to pull the UAF series for now so we don't need to do a series
>> of reverts if we deem this a better approach. I'll take a further look
>> at it tomorrow.
> 
> Please give me the time to post review comments. My opinion about this
> series is that (a) the analysis on which some patches are based is wrong
> and also (b) that some patches introduce new bugs that are worse than
> the current state of the for-next branch and also make it worse than the
> v5.11 kernel.

Just to be clear, I did not apply this series, "pull the UAF series" just
meant un-applying your series so we have a sane baseline for something
that everybody likes. There's plenty of time to figure this out for
5.13.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

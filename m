Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EF1C433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 16:17:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633EB610FA
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 16:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633EB610FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QJsrknzIP9uEtHAkNv54hNqXovMt1OWkzK+uPgLD4hM=; b=DkvoeqfBstACpfc0psDgpiW1e
	dkc1WycwbaUBrpfa8HouEaYB8wS7PiiMEia0EYnCDuV1fa22DJcsSMZ+dKRH8R1BI/UGFCExaBn2L
	5iTo5q8Pscb0gUxNxNUihUUTriKQLR/QH+NFHM4E5gK3iN4NfYkFOk1GNz6hGNJGXA06JOVHWeYeL
	hEMPx/Dj+KEOU17yiNM0vYaEPSEm5FhF1jufPxZcxaT9ZqCI8+WPLo/f6TcFp6U6cPfQ3egXZ5fuV
	d2XRIw/CCXCH2Pz7SQ4qe9B3plOUFRpdCiQzo32SV7vzSvKkLZXjz3r96p+rRuHuKUpvbiW18vzs6
	eqvMsEiyA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lahRd-005t39-19; Sun, 25 Apr 2021 16:17:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lahRY-005t0v-C5
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 16:17:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=/CgjknHmTbeCE3qHm1ZKMHULGEo8L8qg3hm7ZUKCAB8=; b=Cuorsg8H2562qK5I7MLueFB7hc
 XFVSPso5nKHBrgg3MBx4+Z83QWnQnEuzwz402QD+kpNwH0pBOXVyTlwUw2BzH+YV4Y/eEcZzwA0dP
 B2ri2Py/tAT2ClbZpfKtDaXfZgO8HvcdemuvUd9IAChLmXbD6r8Fd+yR8JtDTAqTJiQC5+SMGun25
 UyYmlFkrX9CpfvN4Rf0d5cIIIW3iUqp1SATIRwDxbMQXDq0mJceJ3eZEiHqumvXdG7ERqpv4nK/fk
 CwkJi+GoLKYXabJuiAxq5btYBRoaRyfapY0ua0G9lVHHZR6hM7HRmaEJV1JnLVTA3hSHUtASXJW/a
 fsvHjyBQ==;
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lahRU-00FVb5-RA
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 16:17:10 +0000
Received: by mail-pg1-x52b.google.com with SMTP id m12so17787663pgr.9
 for <linux-nvme@lists.infradead.org>; Sun, 25 Apr 2021 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/CgjknHmTbeCE3qHm1ZKMHULGEo8L8qg3hm7ZUKCAB8=;
 b=CwkD7LZ2gjDf1jUOl+BTcW8S5J2jaGTZTB/NU5HDfpmvSA+mwTH01PgAnQRHkJyfGY
 et4vXfuSk+XeNiGfUpVM80X/eBBEiO4vUrab27Ti1zVGHx6N1wkAjtj2KbBPiGLxD+8C
 BiiDvh5kONzRdMm4MD+d2QsJamO0otPwX8nE4Qa8i4fJAbbvcItLjCup/b8XvtvnxZj5
 fyg6yvX7ww0tIPTROJuJqFS5lcLlubrY+j1eSdbm5tyfflY0qgLbYB3NNrfx/+N2sow7
 KTF5axmykWytJj61DzPAd5qeYwFnT3vubO1+GTXi8z30yGI8oid4bzT8QfDKOptVEBNW
 mOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/CgjknHmTbeCE3qHm1ZKMHULGEo8L8qg3hm7ZUKCAB8=;
 b=CI8jGo61OP+x9AHUfCT4H9cQ+DbUSjsuMddNofHGg+yWV4K33I88ZtNBOnaEzqPM+D
 DnRL5o8Y0gJdw+BGIYjQ6mh1MxERk3CFCQ1WGj3Ext7MIxgqRT7ChaWOWONjJfTxS5cY
 XIalBmgNW+VuRVSeQU6P6nA05orePcYw368ZroJKEwDrrn9wUBevogSYDOhLL96pXffM
 MffisLQSL40W6fwI+NIu1tnfGcUVN8faF0ylKm9LEKS7fzYLVFTZcsx8rYc5WH/EZ2C8
 O6OXR2h2yCLjoDTzEzeONSyiLKELrFgRVaNe4sHiYnvfnVeZOmG73XjFMEXEY8sXEYKJ
 FHOg==
X-Gm-Message-State: AOAM5307Zonyh+LKZYgEbNYrYcmIP8yZ0GR0O/M4EtnfzJTbV5VW70/3
 qn9N87dSQFFUi+RqTOUhnNJ5Gg==
X-Google-Smtp-Source: ABdhPJwXiKeutKRiBmXDFfYFHWo7CYfXl/YngWn0hLcnMONUYMfSiRTFl3d0IAvP+SBSTFR29TusYw==
X-Received: by 2002:a62:5c6:0:b029:24d:e97f:1b1d with SMTP id
 189-20020a6205c60000b029024de97f1b1dmr13801534pff.40.1619367424423; 
 Sun, 25 Apr 2021 09:17:04 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id q26sm9585477pfg.146.2021.04.25.09.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 09:17:03 -0700 (PDT)
Subject: Re: [PATCH 0/8] blk-mq: fix request UAF related with iterating over
 tagset requests
To: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <77cbc472-279e-5c9a-3428-b1a485b3f1b7@kernel.dk>
Date: Sun, 25 Apr 2021 10:17:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_091708_907208_C18CF79A 
X-CRM114-Status: GOOD (  20.25  )
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

On 4/25/21 2:57 AM, Ming Lei wrote:
> Hi Guys,
> 
> Revert 4 patches from Bart which try to fix request UAF issue related
> with iterating over tagset wide requests, because:
> 
> 1) request UAF caused by normal completion vs. async completion during
> iterating can't be covered[1]
> 
> 2) clearing ->rqs[] is added in fast path, which causes performance loss
> by 1% according to Bart's test
> 
> 3) Bart's approach is too complicated, and some changes aren't needed,
> such as adding two versions of tagset iteration
> 
> This patchset fixes the request UAF issue by one simpler approach,
> without any change in fast path.
> 
> 1) always complete request synchronously when the completing is run
> via blk_mq_tagset_busy_iter(), done in 1st two patches
> 
> 2) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
> and release it after calling ->fn, so ->fn won't be called for one
> request if its queue is frozen, done in 3rd patch
> 
> 3) clearing any stale request referred in ->rqs[] before freeing the
> request pool, one per-tags spinlock is added for protecting
> grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
> in bt_tags_iter() is avoided, done in 4th patch.

I'm going to pull the UAF series for now so we don't need to do a series
of reverts if we deem this a better approach. I'll take a further look
at it tomorrow.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

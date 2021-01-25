Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02408C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 01:24:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A46721D94
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 01:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A46721D94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NY+QzQ32dlOFHEl2De2gjEb9Crh10uUcWULMikpGDX0=; b=tn6sJ9C7AFLan08T8D0deMxcK
	4YO/UUrFb+qDCerxpIsPtvUJRRKgRs7xnqtzn0VyHj90C+0tCjeMD+M/c4HETBcqMj86MjSjN8A/r
	on+KXO+H+Su2q4OlxlIjp8AAzlK3RE8XT6f+Z/jEHMQ9xWCOihL5IdlfKIcu3XOr9MsSYyiAPvfRO
	MYlZC+x1RTMm2AuVZS2BBZMPerPtJCY9lkHi9vmkks2AXLOpE1Dab5a2gmuvOj14c/fTym3sgmNAE
	tVRkSWtzE0x4fhL+fIrfjQEKIG0zBP9gb+WMOGxtmMxunqirqtYO51qZ3jgLw8UgAxpzv7pQxpkr+
	3bgEaCDaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l3qc6-0000Ip-9R; Mon, 25 Jan 2021 01:24:18 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3qc1-0000Hl-RI
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 01:24:16 +0000
Received: by mail-pg1-x52c.google.com with SMTP id c132so7852785pga.3
 for <linux-nvme@lists.infradead.org>; Sun, 24 Jan 2021 17:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MSpVHwkCX6jn2zmjsM3ERb1RCWT/CaWYVTGYkGxLPMQ=;
 b=cANH8e1JsQWWCA6K7c2yEeTbdiEO1GVf52BOvOvHMuuzuOwLMbDpTIG8lwpolK0icK
 0L3S/ocwk1bn0K4m4mezLZfUoMQFkPMVdzF0swABRaRDvhjPdS//d4rYF/hhSVlIj0e5
 GCTjUL4+USqxWngHHgmkMMISuZnFlCQ/DjAcXqZTPP+gCqtwV9N6H5Us2R2RTf4/Wm3l
 v9dC6xJ3eOcxO2kdzsIP9/VK8pDSh3vIrWiQigEURvRp6ZKeNDds2ga8oMas6khTZbUU
 bAXCXf9s6wkbPhLdiUZZx1F3c1+XzZivD4vAPVU1i93DCZ5GpPiHbaFqNE9Ar2HplqEB
 J7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MSpVHwkCX6jn2zmjsM3ERb1RCWT/CaWYVTGYkGxLPMQ=;
 b=G3LuA8LHhTfR8UGnvW1RWwW6luzNIY59DIbmjR4rTWqfSsOenhNUEhOHXrBod0myJ7
 +xVYmvoA1sOZl4A+PrtbYRipRY28o7mrQAMxg/GHYokpExpWhYjvi9nQvvDV3nVUzmnq
 WSDwe7jUPw3FQZLr++4cxFyBfxUgNBNWkBAAaMOAYPKMAPN891cgzcvobCzLJ7zh6In4
 cU8lR2Er9nmVEiA2T9IU85Ar4xQHzzw4Jw0NzgWUC1buXsQutmjExnkuZ4q/V07tPuQV
 /xHPTevUCqeyvEgZ/AwobRZuIGhNIT11gjEbMbrCagp6LIIPqBFgmwJYJ7XD4MEduaG6
 dhSg==
X-Gm-Message-State: AOAM530udJUahJaOT9VhenpWo/cEFF/MzExCirInl76lz4xG1aov4uur
 KjgRuRVgO+9ozOAHgsDK7afanw==
X-Google-Smtp-Source: ABdhPJwGmmoJHjWbM4oOrfmGt+RyPavosTLmBxchZDys8SFvm/6ZSwmX7zSbzb/FwCp9pNaqXVDW9g==
X-Received: by 2002:a63:e30d:: with SMTP id f13mr8331115pgh.39.1611537849731; 
 Sun, 24 Jan 2021 17:24:09 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 b18sm15216556pfi.173.2021.01.24.17.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Jan 2021 17:24:08 -0800 (PST)
Subject: Re: [PATCH V2 0/2] remove unused argument from blk_execute_rq_nowait
 and blk_execute_rq
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
Date: Sun, 24 Jan 2021 18:24:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210124_202413_889924_1093D217 
X-CRM114-Status: GOOD (  11.99  )
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
Cc: hch@infradead.org, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/22/21 2:28 AM, Guoqing Jiang wrote:
> V2 changes:
> 1. update commit header per Christoph's comment.
> 
> Hi Jens,
> 
> This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
> Also update the comment for blk_execute_rq_nowait.

What's this against? The lightnvm patch doesn't apply.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

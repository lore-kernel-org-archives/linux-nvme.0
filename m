Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9776EC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 21:19:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39676109F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 21:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39676109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+0tMpx5/6GAvsW7fj0rHwHUmaTJ13424GQFAGAe61nY=; b=E/RF/yG+n6V/avVodNAuSQLt8
	5lYMCI0/XcVLX5yA7jbow54GVUB7o/EwJdEbJf44JCk4mfHs03hrUdq90aQ0A/nEP2YGoocCRitlC
	e45RvWloDOuJ+/MPnV+5SWKKpQ0amrqcvJyX/SygJVBMLgkT8ZBeKqmIEOEHhHM9k2hKT45z3sbWF
	5n/MV/oHQz1jD8J803TtvtnfgU2k0zdhiS2GsKJiiIrZJ4AXermHqYFUqrwCKrVsLieTEU3Z1fwa5
	YD8TmRepIfqiAq6ZDxis83ruhUcfsGbLxK55e27BM2QcWFW1CEl9jKIPo/7nSoNZC2pRNkgxII08E
	c/Z9miUHw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhIiu-006S1x-Js; Thu, 13 May 2021 21:18:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhIir-006S1a-Bp
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 21:18:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=mvZf3JNCBPnJCp6W7ETlVadxetawitWuzaHn0wwc8uQ=; b=zWShdbdClexymN4BwMnRUtScg0
 PLcCm8CohGKXlnaa0VbZsdppkCRVHKkwlf3+hjBbWCmnI0j1iqJ/kepNcgZFgSzonBDMDeeacMSFK
 tm/DGui7VEOpNwG8SbAkZqs6ilfVw3uHuiWwMAzDfnhD83VQrzY/zUo87GV5sowW1YZzOVXTGL/nC
 4viN36U+0EjBhZOWWkzEbof2OgVNW8K/T2yaI/w8UaYffdLjM/rP7VD7qRAb8HmtrRhXPXjlWewtv
 kppeQ5lmf3W1hMR/AYLFGymJcpt/64yeXf+nc4OJyjlgHvcALglqpzUx4o3qVhgamEj7TZW58bfC6
 XkgKzjeQ==;
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhIio-00BXIk-Nl
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 21:18:20 +0000
Received: by mail-pl1-f175.google.com with SMTP id z18so11466689plg.8
 for <linux-nvme@lists.infradead.org>; Thu, 13 May 2021 14:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mvZf3JNCBPnJCp6W7ETlVadxetawitWuzaHn0wwc8uQ=;
 b=q0z90BaEesUMjuwWlTIc0d9dAc0t2lPRp6A18EKMa17ZIRSf82yaNJllLA3lK3yr20
 jca3hjBXhFi+/9Jwq1eAP0u7uJ1DELnn8mkyWhhMzeOHPAGUrDo6fs3IRCAvjRiRGW58
 KhBqmPTx8J0TVgyflIkDDffOzNkcOAkJ61BO4EDDlZWqrRk3uAt6MeK3/lUt7ubbNeHV
 DzW+ixk74UYPAo33tYPSH2ftvJlKfcC5z8rqHYAhXEM8OQMtebREvb1Ln2Kvy3PDEhuK
 wTEHoqtLm/V9V2aebfYiR9H+FCmWeD+KUIXfKk/5wgTip/OtbjxNixDiTLeUNZoDdCwM
 L/oA==
X-Gm-Message-State: AOAM5332YxnLI4IL9GgnkxcbS+wqBXIfZcKr2ZTLdhP5vuMLcXwOVSjY
 SblQHAyzyx7BR2aU0VFhGDw=
X-Google-Smtp-Source: ABdhPJwewpa0foiOfv5+uWT766FJFkGKaXiL58aPMNLdz8Z3MaXuEV5io4OkQpitS3h5OFIBnffzhg==
X-Received: by 2002:a17:90b:84:: with SMTP id bb4mr6992032pjb.60.1620940697238; 
 Thu, 13 May 2021 14:18:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:54a8:4531:57a:cfd8?
 ([2601:647:4000:d7:54a8:4531:57a:cfd8])
 by smtp.gmail.com with ESMTPSA id l35sm2809109pgm.10.2021.05.13.14.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 14:18:16 -0700 (PDT)
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
To: Mikulas Patocka <mpatocka@redhat.com>, Milan Broz <gmazyland@gmail.com>,
 Theodore Ts'o <tytso@mit.edu>, Changheun Lee <nanich.lee@samsung.com>
Cc: alex_y_xu@yahoo.ca, axboe@kernel.dk, bgoncalv@redhat.com,
 dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
 linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, yi.zhang@redhat.com, dm-devel@redhat.com
References: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org>
 <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com>
 <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <fdee795d-7a4b-9506-b9ca-359b9bcbec34@acm.org>
Date: Thu, 13 May 2021 14:18:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_141818_805322_5DC65C05 
X-CRM114-Status: GOOD (  13.21  )
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

On 5/13/21 12:22 PM, Mikulas Patocka wrote:
> We already had problems with too large bios in dm-crypt and we fixed it by 
> adding this piece of code:
> 
>         /*
>          * Check if bio is too large, split as needed.
>          */
>         if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_VECS << PAGE_SHIFT)) &&
>             (bio_data_dir(bio) == WRITE || cc->on_disk_tag_size))
>                 dm_accept_partial_bio(bio, ((BIO_MAX_VECS << PAGE_SHIFT) >> SECTOR_SHIFT));
> 
> It will ask the device mapper to split the bio if it is too large. So, 
> crypt_alloc_buffer can't receive a bio that is larger than BIO_MAX_VECS << 
> PAGE_SHIFT.

Hi Mikulas,

Are you perhaps referring to commit 4e870e948fba ("dm crypt: fix error
with too large bios")? Did that commit go upstream before multi-page
bvec support? Can larger bios be supported in case of two or more
contiguous pages now that multi-page bvec support is upstream?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

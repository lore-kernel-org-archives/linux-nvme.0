Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E12C6787B
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Aug 2023 16:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eHst9wbGGDzmwYR4dacoLOvw9Cpq6xs5Zent4DwnkY0=; b=2lJCvLsegIjooI6F6x6J8uddpD
	eWHIutPYGWLdPM4VvaHTq055fBwgwT5eln9Jri3y2nkqOuuqeHQsgiUUA7kIUg65SMqd6BOQN/ksG
	v05wZQ3cVL5lWEPk35iWyEY9FPa/UwdLrglxb6BZcrl+uBzTg5+4j3WLpG022x82mwq9tSDrNEI5L
	Tcs14X3eC/qraQREANpIqmWcEqbAc726RvADyYe7fPkMHF28/GVFFDY/EIq0quNTVzyhd0lBNteph
	qAgzd9XouQPYXMZBhUidrOfgyK1qG0wUhTXD8MbBAgAXy4K7bVSmKgLsn5DuoJpDCXYaCTRFWx+62
	tH2/OfjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZZx8-005kZH-2Q;
	Fri, 25 Aug 2023 16:46:30 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZZx5-005kYq-0N
	for linux-nvme@lists.infradead.org;
	Fri, 25 Aug 2023 16:46:28 +0000
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-68a410316a2so965571b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Aug 2023 09:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981986; x=1693586786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHst9wbGGDzmwYR4dacoLOvw9Cpq6xs5Zent4DwnkY0=;
        b=lngPc1B+kxq4jSR3rGbr9Jp3FYVIPNkukAaXCVZnUIjakOgCZxvI/UcxJTSri1HoWu
         HHlkfiDf5vhixfjC5MooLp62yXcfjjg3+iwJQZsofO2GBCVb2RE828GxVVle3BH6Go68
         yEjtnJHsAfcbmrld9zlAOqQgJI0SnbQ0iH5plc47maIxA1zlPo7TpUwNrEu7tEkiXvIo
         TVrraUodydlafrPUCjreUjJn9hQr62u/acdbp+M9jCEulWo9UKVEC50Zkg9e4zlkyMyK
         RiByuBbIsBKqUm0/Rn/Xih37h0CmnFP89iPAj7lgWM2eqcIvVl+uAYkgk8hS1vWEmfjP
         utog==
X-Gm-Message-State: AOJu0YynBBQ9X0tp9hUhEL7xd+d6TdZj1T4/blGIzRQHThFmMNUVj/hQ
	YonfDtykXsSYGglJPomiQvE=
X-Google-Smtp-Source: AGHT+IF9CTZFuL1sZYQ1i3g6DcqcFpfaEsUGiGnEp/VyHT/Pw4GdDjdXgA2fmEjv4iNlkpotHMciMw==
X-Received: by 2002:a05:6a20:be30:b0:134:a8a1:3bf with SMTP id ge48-20020a056a20be3000b00134a8a103bfmr14583151pzb.30.1692981985492;
        Fri, 25 Aug 2023 09:46:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f521:8fc8:bb3a:811c? ([2620:15c:211:201:f521:8fc8:bb3a:811c])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00682a61fa525sm1821522pfb.91.2023.08.25.09.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 09:46:24 -0700 (PDT)
Message-ID: <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
Date: Fri, 25 Aug 2023 09:46:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230825_094627_155933_0046538D 
X-CRM114-Status: GOOD (  11.47  )
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

On 8/25/23 07:26, Daniel Wagner wrote:
> On Fri, Aug 25, 2023 at 06:45:25AM -0700, Bart Van Assche wrote:
>> I don't like the "new style". What is so hard about typing "$@" to pass all function
>> arguments to _nvmet_target_setup()? Leaving out "$@" makes it much harder than
>> necessary to figure out the intent of the code author - not passing any arguments
>> or passing all caller arguments implicitly.
> 
> Because "$@" is just not correct.

Why not?

Thanks,

Bart.


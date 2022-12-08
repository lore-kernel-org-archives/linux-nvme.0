Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6AFC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Dec 2022 20:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gOEgB4vY7Vf9s9y/1d2I/HfeVyQozy3an9un5pb6tMU=; b=cgkYLyySFpBRUQSIlFK2QWi5Hb
	d3+gGbLikFdntSlvZdoNUle6FzuqpY38M+MZNtgR8r4kzZWN06leFanTYCM1Z9ZZRxLq+vWtRaMmn
	UQfrkjOhT1gfZrfWK/JTBWs8nFvrhgyEMjkLOH/h8u6JT6iQY2sjl6LcUb3G4z9vhXNDb0QOB+G3T
	s+JECCyJUYeJ2n12mSPsi8+kf+g4FDEnBLgFYTyByvkfRgvfdhKs2+qWL9bOQrqkYETbi6CzyE8fO
	Am9ma4kAb4TxhB4LE/o/Hm/KH+9nSH0i5QeUGIyq5Tm67sAJ+sDm8bBNsfw3QxIMypEjjGiU6Bd7F
	dFEurO+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3NAC-00AGAf-51; Thu, 08 Dec 2022 20:06:36 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3NA9-00AG1j-3i
	for linux-nvme@lists.infradead.org; Thu, 08 Dec 2022 20:06:34 +0000
Received: by mail-ej1-x631.google.com with SMTP id x22so6572932ejs.11
        for <linux-nvme@lists.infradead.org>; Thu, 08 Dec 2022 12:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gOEgB4vY7Vf9s9y/1d2I/HfeVyQozy3an9un5pb6tMU=;
        b=7qI5u/hpkQ8c7Yxg7nwAikcgMlU2u2IheFs5DzIrzIuzVfrnhfcSo7l3k0OL9Pc/ca
         6VfpEKAqKrUAzdd4zh6S/lCdiobfuWE8Lb39pd3UfiONLKHLvaSSUv9FOuGVpmvAk9s6
         OChMDYG3hFr1UraYxsbQtswpwVVvknPa5AFJECaMKGG08o42eBAgjSH6XdDYXENNK7HL
         cg3csTUicMWEYUHWfg1ycsaMaARnmJam+td4tbMgYOf41xybfZsLJMstddT4aAr/A++F
         HZO+X82l47sHBjjvANAz3Do0uh/xfZQFp3DqFK/bLFvKKNui2zER7GqT5Fqvvq77d3D6
         x8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOEgB4vY7Vf9s9y/1d2I/HfeVyQozy3an9un5pb6tMU=;
        b=Zt6T6edWFyYVHESKKcVh0v4NLRx7J+un+ZIa/KGlLLAIgwDD9FdLrJFPa+TWzJhNQV
         LW103jVNIoHJi6/Hv4dQ/lQt3cFcP8HN84eb4QfItkEkuzKb5Bq7UsJcFnHBCIoI1d9z
         z9TiUU/F8hn4pfgvHWiv5TiDyyQHlzPWGyXnwwincQTh01W0wQ1/Hrlc7FzokA61QnmG
         /5l/UpDDry4JalQrRYkeZfdsf6Rl/cdeRgx6DalhFBpYFeLcFF6Ld44m+7EHJqK3YnNq
         EhJWhIjAD08HXqUv0y377wuCiFFUQlsx6hzZGWbrzr7MonY/yF7l1EbbEVub7t6aQsYI
         +M8A==
X-Gm-Message-State: ANoB5plJCrhWPM4toGOA5AyRokpErTVLBigXh1qjjMmHC/uLNPSSfVaU
	aZivVSEfD0qaNBthvx7YwzhODQ==
X-Google-Smtp-Source: AA0mqf7HrAYMaBrDD1fHZj3YzDUzHOO73MBpqvB8tB4DexXbV9fvKzhG/kCAkGmyYJhepCzYf38YNw==
X-Received: by 2002:a17:906:c413:b0:7c0:edc9:9a6b with SMTP id u19-20020a170906c41300b007c0edc99a6bmr2447191ejz.41.1670529990248;
        Thu, 08 Dec 2022 12:06:30 -0800 (PST)
Received: from localhost (89.239.251.72.dhcp.fibianet.dk. [89.239.251.72])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b007b8a8fc6674sm10064658ejh.12.2022.12.08.12.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:06:29 -0800 (PST)
Date: Thu, 8 Dec 2022 21:06:28 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <willy@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	Johannes.Thumshirn@wdc.com, bvanassche@acm.org,
	dongli.zhang@oracle.com, jefflexu@linux.alibaba.com,
	josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
	tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
	idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
	ebiggers@google.com, jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <20221208200628.5hr5tvdyfxgvzpjj@ArmHalley.local>
References: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
 <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
 <Y40DOJ+7WlqIwkbD@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y40DOJ+7WlqIwkbD@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221208_120633_186929_C3A971DC 
X-CRM114-Status: GOOD (  16.34  )
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

On 04.12.2022 20:29, Keith Busch wrote:
>On Sat, Dec 03, 2022 at 07:19:17AM +0300, Javier González wrote:
>>
>> > On 2 Dec 2022, at 17.58, Keith Busch <kbusch@kernel.org> wrote:
>> >
>> > ﻿On Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
>> >>> On 12/1/22 20:39, Matthew Wilcox wrote:
>> >>> On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
>> >>>> So nobody can get away with a lie.
>> >>>
>> >>> And yet devices do exist which lie.  I'm not surprised that vendors
>> >>> vehemently claim that they don't, or "nobody would get away with it".
>> >>> But, of course, they do.  And there's no way for us to find out if
>> >>> they're lying!
>> >>>
>> >> But we'll never be able to figure that out unless we try.
>> >>
>> >> Once we've tried we will have proof either way.
>> >
>> > As long as the protocols don't provide proof-of-work, trying this
>> > doesn't really prove anything with respect to this concern.
>>
>> Is this something we should bring to NVMe? Seems like the main disagreement can be addressed there.
>
>Yeah, proof for the host appears to require a new feature, so we'd need
>to bring this to the TWG. I can draft a TPAR if there's interest and
>have ideas on how the feature could be implemented, but I currently
>don't have enough skin in this game to sponser it.

Happy to review the TPAR, but I am in a similar situation.


Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6755DC433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 19:25:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B22B238A0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 19:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B22B238A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Xc6SAfQjthPBDEd2Q4Bp0C5QN+NNtuFDCxonF2d/SuA=; b=z36PL0sk1dhImRrF3jl1antin
	yU2t+gwtLQtsFgZ8cfShZVBWpfGXWHZJdWSP8EEe8uuxLDH5thQbhkhi3nc2ez+g+BrN1DJt8aNLg
	aj2K50iETCRTlm2yxs1Q+mptOYejomTPn1h0R3aLQkuu1qhtWR3qaL43gT8BDZShvK+t9j81ZgRdq
	XWe7mqoGGPJ5tf6zBGQKsKCglXhloP+LyDRvdXQKXXUIGWqS6qS8vfxTxPwDwRWHArhE+8i1cXQAG
	v6SKBq4gIltH7EQFQ7LjQCNO0skE5E+mOWP7aSe9lA2sRZzlX4JogdyzrAIAFzq7G4BA5PA4k9frB
	c10yCTZcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmM87-00018s-9r; Mon, 07 Dec 2020 19:25:03 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmM84-00017J-Rv
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 19:25:01 +0000
Received: by mail-ej1-x643.google.com with SMTP id ga15so21158070ejb.4
 for <linux-nvme@lists.infradead.org>; Mon, 07 Dec 2020 11:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IVD1p2kuvVXrBfr0DQp8uX8UYpU8DuPwPA/j+U9iw7o=;
 b=BT+NDgyuc4B9FYRdUmCPvz8gjOkn6+mHA6vCDn6QzeHfUUeVlC9fv9qefVr60Fi4o8
 N+o33ru5BmuDsrganRp9xPYlw9T4COKiKzJVIiibRWtkGYUeWzfA+vwEjIThXkXCM/Ob
 v+IduKCrHlR2/fbICCriKjUrIp3nu1m1Yjdr6Q9zzZw8wQ+/MzIoQ+PIjpI2AHX08tNF
 o79x236sD+eQzaNCTTmeXMydo7bCcfYZv2T91v+5zWh9xA1eXU1ksRhuj/YKDJDQ4LB1
 0EJPtboMkRXu+WFzXkzP01egTvP5VfJha5u1lyfPXyF4vmUc1wpvHu9UBb6KiowaNlCa
 iHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IVD1p2kuvVXrBfr0DQp8uX8UYpU8DuPwPA/j+U9iw7o=;
 b=EdApfy9ZvoXmW1rWEukpNF2ky+RN13s3OcXlosdR00vSCZsmI3HoM9Y6fQD2YnvyvQ
 LZBbwJGXVZDU1i/ARknRolflEhJ+SjL0H486cnJVhzUpru5DS729bRChkyQXw8vD4HI8
 EOZtWwV9tqSfLE8dpeJuZcaTVaUyprKukfmYQgnBMg6rBb9HWTFaNzUl7CmpMYvSjTN/
 8XaCswKwoRhf08LYZa4hZ5WWFfrc8EDF58ghlNJo9i9uvrTeF339KZ5KV3ro0cvWyv+t
 dnGoREsU9L9C2BZNQPY1HVrbKnYXi4UDv0xWYVfIPx+qCkIkfuEzCAr2HVGAKrzgfvcV
 JTbQ==
X-Gm-Message-State: AOAM5314VmNwzPKhG3Jq4Ho/zETv+fgoFHF/nN/BCShVLWyDONzoa0yn
 +639cdhpXERzF651/AFt47n7eQ==
X-Google-Smtp-Source: ABdhPJz9bYSQy3NHjmWx84lzpD6uTWLsBYmyjEhdoYT4EzGm+iefSEkI4OwWBZ212/zNmk1iIBD9rw==
X-Received: by 2002:a17:906:b08b:: with SMTP id
 x11mr20225762ejy.302.1607369095020; 
 Mon, 07 Dec 2020 11:24:55 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id b17sm13218700eju.76.2020.12.07.11.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 11:24:54 -0800 (PST)
From: "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?=
 <javier.gonz@samsung.com>
Date: Mon, 7 Dec 2020 20:24:53 +0100
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201207192453.vc6clbdhz73hzs7l@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
 <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_142500_936031_CB5BFF0E 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: axboe@kernel.dk, damien.lemoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me, snitzer@redhat.com,
 selvajove@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Mikulas Patocka <mpatocka@redhat.com>, joshi.k@samsung.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>, kbusch@kernel.org,
 linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 07.12.2020 15:56, Hannes Reinecke wrote:
>On 12/7/20 3:11 PM, Christoph Hellwig wrote:
>>So, I'm really worried about:
>>
>>  a) a good use case.  GC in f2fs or btrfs seem like good use cases, as
>>     does accelating dm-kcopyd.  I agree with Damien that lifting dm-kcopyd
>>     to common code would also be really nice.  I'm not 100% sure it should
>>     be a requirement, but it sure would be nice to have
>>     I don't think just adding an ioctl is enough of a use case for complex
>>     kernel infrastructure.
>>  b) We had a bunch of different attempts at SCSI XCOPY support form IIRC
>>     Martin, Bart and Mikulas.  I think we need to pull them into this
>>     discussion, and make sure whatever we do covers the SCSI needs.
>>
>And we shouldn't forget that the main issue which killed all previous 
>implementations was a missing QoS guarantee.
>It's nice to have simply copy, but if the implementation is _slower_ 
>than doing it by hand from the OS there is very little point in even 
>attempting to do so.
>I can't see any provisions for that in the TPAR, leading me to the 
>assumption that NVMe simple copy will suffer from the same issue.
>
>So if we can't address this I guess this attempt will fail, too.

Good point. We can share some performance data on how Simple Copy scales
in terms of bw / latency and the CPU usage. Do you have anything else in
mind?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

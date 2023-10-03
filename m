Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F8DE7AD7C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JjOvJviiB1YciK0Ddc9QDsHo4Z5SKKOd0Z6vFwPd3F0=; b=cgLapvCFlwWrlpPywfDI3dHsZ5
	qwsjjXEvUPYnwv2h2bs5ZIx7ObNiXhUaCZtea282tMivR5waQ4Lm01xbgO8ChB6XtgM+95ijTKpt6
	Ij9rakjzhxVHAvGom/4iy+CcTo1lTy3Jw89fD7eUQzV6EMqk5/D74IfoanJlxvHKpEXhHPgK5hmok
	rLrYdaBwqmBGDf1grQ2pFNkhtUkPcL29QBGr5Za2o1zDRePogZXQCiGis3RctqsBjxDIpIGdPq977
	01xoTqTaQ31VvmQlaw4Y54totMMVX/CprwwSP/+MtydREPib/94xFDgzzyD6/UzQPQe57oRkklxIN
	bqHT2nfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qniS4-00Eytv-1W;
	Tue, 03 Oct 2023 16:40:52 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qniS2-00Eyt3-2E
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 16:40:51 +0000
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso902932b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Oct 2023 09:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351248; x=1696956048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjOvJviiB1YciK0Ddc9QDsHo4Z5SKKOd0Z6vFwPd3F0=;
        b=RoAYuuCE5NgpT+Qj/4XLCDdyzzopg24+HQluQ7g8AQA8+AIydpvKg9m3D0zam4tI43
         +q3fThrBQeFITmd0c7OaeRCvt58/C+gnd3foxrDWCz3oigoSPPhFdwBAZQKja9wASDMZ
         wq/ROSSRN9Gf8ewWdiCdlxF9CuSFHyNk+UWzHfrAiWzydWJm/6G7xzm2txqX+B3IC2Ru
         kosGB973MRRheZyYQDJsXs2yJ025broOrCakT2Tj3JJUHOjaS3CEKEkyWg2cusUoMG0k
         WCxyZJeCAKqTZ0WjEt/+DH9N/7cxyRD+X1ALLtGa1qKexMiCPp9RoYeFfFgIypJcNmRL
         6gZg==
X-Gm-Message-State: AOJu0Yz3uj7ajB0PHSfdeI2j/j3n1yvibPa9858n4tjPmFrUm8qS5nnx
	wjtSLJB7sq5DCcAJPpkZ+ds=
X-Google-Smtp-Source: AGHT+IEkJC0j4q3G/j/OwL01WVjZmfBkxBT8BYOG8ftBNdCmA9VmlrrpSaGbeLg8MIWvhWr115Wo0Q==
X-Received: by 2002:a05:6a20:6a23:b0:160:57a6:7eea with SMTP id p35-20020a056a206a2300b0016057a67eeamr17004575pzk.37.1696351247970;
        Tue, 03 Oct 2023 09:40:47 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b001c41e1e9ca7sm1790448plz.215.2023.10.03.09.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:40:47 -0700 (PDT)
Message-ID: <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org>
Date: Tue, 3 Oct 2023 09:40:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] block: Add atomic write operations to request_queue
 limits
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-api@vger.kernel.org, Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-2-john.g.garry@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231003_094050_753486_1525D2A4 
X-CRM114-Status: GOOD (  11.91  )
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

On 9/29/23 03:27, John Garry wrote:
> +What:		/sys/block/<disk>/atomic_write_unit_min_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the smallest block which can
> +		be written atomically with an atomic write operation. All
> +		atomic write operations must begin at a
> +		atomic_write_unit_min boundary and must be multiples of
> +		atomic_write_unit_min. This value must be a power-of-two.

I have two comments about these descriptions:
- Referring to "atomic writes" only is not sufficient. It should be
   explained that in this context "atomic" means "indivisible" only and
   also that there are no guarantees that the data written by an atomic
   write will survive a power failure. See also the difference between
   the NVMe parameters AWUN and AWUPF.
- atomic_write_unit_min_bytes will always be the logical block size so I
   don't think it is useful to make the block layer track this value nor
   to export this value through sysfs.

Thanks,

Bart.


Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D7C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 22:29:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A9520897
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 22:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kcxm8E4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A9520897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=090Sdu7tbPaFeZk3fE+lHu0ZYdTiUXmC/No/wnp2Gyw=; b=Kcxm8E4OuFnEf8
	CgT/MJwJE1vIbhuiKu3mWpGQFWpXMOZvDtZqdfFE/PDIMepVK6gbZj8oxzk1U+goT69YWntb123Ss
	TNtyLXQ2LuYtsk8FSZ2EXXuvSTOi+4PpB7ikBo3p4eQQ8ec76hXUHk89WbiLf2rEQSWdFOHO3xe7d
	CbTOLPHsUy6Dnpzq4+1Ko8L80c4beHDCknzIl2ZomknC2bsAgMBXTGFhEEmWLydf9OkTGcc0KXp6t
	baEstlcHK4tyxBUdYQi99wO18/2qIvBCJrncHVHevhdzcMNZ77p/FOCUjkqV7eXIrD6IUR7sBSVx9
	gqfQbr1jwunGGJYUXiyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jenVA-0001fu-8E; Fri, 29 May 2020 22:29:20 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jenTW-0001V4-K4
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 22:27:39 +0000
Received: by mail-pg1-f195.google.com with SMTP id o6so575594pgh.2
 for <linux-nvme@lists.infradead.org>; Fri, 29 May 2020 15:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uj3jOfu9sZgVkoy6z1bnGkhIhe/u5i7DZ1LHuEhUq4k=;
 b=OXUaAN6bo4kfIlCtACoX2eYG4vxElWDsiCAGMVnyFIVhUSjXPgtyTwveJAN4+TiaI1
 oTSpbK5sDVxsZk6y2wKM+/Up5bhMS5i6i63N1U4lZCWsdfJ07vzYPi3+u+OuIaQgca1+
 JfKT7zXHNUrsGD5bindAyCGwkok6OfhKWv/S4N7MtGO/oVETxXk6PzEcxS+kIe0OmRnS
 lTzOsuK0w/j+g2NTkbk1nvxoMSJ6hmGYD0nA9aMXKKpRanfR5a+xCdq8c9ZozxrPAI2R
 Ewmg7FNjQU+H0B4/KtECItWBbFjFMZMT3y6vHF+7RNho4Scm+6WPv6Dz71Fc/l1S0Wpb
 jRUA==
X-Gm-Message-State: AOAM533ehHcmHtoTCi+nJUy/c4gU+Oo18TN/SRK1EFT9seYMpgwxEZ1S
 wGFmnrRhmF6LQWWY6LVgjyo=
X-Google-Smtp-Source: ABdhPJzkx0rRv4fPXpaH+eGPI9Rz92YeiO90Kl2s/syEtIcubIlPO+kx/PaWYdL/3NTAiK6BZEWOCA==
X-Received: by 2002:a63:1312:: with SMTP id i18mr10339525pgl.142.1590791254159; 
 Fri, 29 May 2020 15:27:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9d55:11e:7174:3ec6?
 ([2601:647:4000:d7:9d55:11e:7174:3ec6])
 by smtp.gmail.com with ESMTPSA id g7sm349470pjs.48.2020.05.29.15.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 15:27:33 -0700 (PDT)
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
To: Matthew Wilcox <willy@infradead.org>, Kaitao Cheng <pilgrimtao@gmail.com>
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <20200529202713.GC19604@bombadil.infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <c7a5bbc4-ffc2-6a63-fed3-9874969afc31@acm.org>
Date: Fri, 29 May 2020 15:27:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529202713.GC19604@bombadil.infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200529_152738_660238_7ED5E987 
X-CRM114-Status: GOOD (  15.71  )
X-Mailman-Approved-At: Fri, 29 May 2020 15:29:19 -0700
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
Cc: hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
 linux-nvme@lists.infradead.org, dhowells@redhat.com, clm@fb.com,
 deepa.kernel@gmail.com, houtao1@huawei.com, hch@lst.de,
 linux-s390@vger.kernel.org, gor@linux.ibm.com, darrick.wong@oracle.com,
 mark@fasheh.com, satyat@google.com, hch@infradead.org, borntraeger@de.ibm.com,
 ajay.joshi@wdc.com, chaitanya.kulkarni@wdc.com, chao@kernel.org,
 josef@toxicpanda.com, ming.lei@redhat.com, viro@zeniv.linux.org.uk,
 songmuchun@bytedance.com, dsterba@suse.com, jaegeuk@kernel.org,
 jlbec@evilplan.org, sagi@grimberg.me, axboe@kernel.dk, balbi@kernel.org,
 damien.lemoal@wdc.com, martin.petersen@oracle.com, joseph.qi@linux.alibaba.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, asml.silence@gmail.com,
 linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-05-29 13:27, Matthew Wilcox wrote:
> On Fri, May 29, 2020 at 10:11:00PM +0800, Kaitao Cheng wrote:
>> There is a function named ilog2() exist which can replace blksize.
>> The generated code will be shorter and more efficient on some
>> architecture, such as arm64. And ilog2() can be optimized according
>> to different architecture.
> 
> We'd get the same benefit from a smaller patch with just:
> 
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1502,15 +1502,9 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
>  	return !(addr & alignment) && !(len & alignment);
>  }
>  
> -/* assumes size > 256 */
>  static inline unsigned int blksize_bits(unsigned int size)
>  {
> -	unsigned int bits = 8;
> -	do {
> -		bits++;
> -		size >>= 1;
> -	} while (size > 256);
> -	return bits;
> +	return ilog2(size);
>  }
>  
>  static inline unsigned int block_size(struct block_device *bdev)

Hi Matthew,

I had suggested to change all blksize_bits() calls into ilog2() calls
because I think that a single function to calculate the logarithm base 2
is sufficient.

Thanks,

Bart.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

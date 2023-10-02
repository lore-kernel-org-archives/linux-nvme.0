Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A81E74913
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Oct 2023 19:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QUdRRJDEOEUkLfFy9sPy2x/dfu57//lkDWppt3CgCr0=; b=z9wWahNsFl1ELwkx4ZqXR1ovgi
	+wyIKFl1aUBJHRlGFTevrKZwgDEyZ7to6St4RR7XnqMQ02Hh1A7A3ycPO2gXGNLSzIANWCCFatMd8
	X74RBoIugNsbhGXmRxrTmZi3HiMVqUWxowLm3Pe8nOg/ymQa5b6TCS5Yfg+5xf/pprkI0jgQwQ9Kp
	HHBSIx735yliXPBuU5pScrm6ume5j6+P2Xj4LJ3b4W36Vme6XrFWqqw6nZIYdBeki90T5tF1Y7j70
	HstqqCNQxzHb9HR518A2im1otzl5FEHvYld7IXEvXoywSuCBEUOnla0RmU7x9j46rM2uTdL9bbK43
	LNj0uhEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnOLg-00DGlW-1w;
	Mon, 02 Oct 2023 19:12:56 +0000
Received: from mail-oi1-f169.google.com ([209.85.167.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnOLe-00DGkT-0N
	for linux-nvme@lists.infradead.org;
	Mon, 02 Oct 2023 19:12:55 +0000
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3af5fcb5e37so84422b6e.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 12:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273972; x=1696878772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUdRRJDEOEUkLfFy9sPy2x/dfu57//lkDWppt3CgCr0=;
        b=FatbxZMl+qpMc7Kk+94BtR48KdBpa+kbVn7CF/HY8emLHkkFZopzfUWRxB/Xg/bjdI
         LvA8XvfWyOQFZqKWge8zW9zL0lH+l+OviG2jCDFIpGhmJirqeriHaCfvA+aDNAYzocP8
         upzx5YjQIkt4/pmrb5cV5XG/BNq4/JvObDijkMGT4lal+ABj/uVTNfkhmg4G5Z7iUZsK
         ybBlR3GVdRNOy/cF8Ls9VpWPRwUJtd2gXco1IRH/JQGFnWEjnBMottN0CgkNUFTgp5wz
         x7dI0Bw+pTEFSjTzZe4z2m5nMrLWXYEafSZb1KOuGVzwV0RM+UfAzoEzSweFkS6Wtjhm
         4Ngg==
X-Gm-Message-State: AOJu0YxB0FnqzZL04rRnKCRuacRLs05dhvIfSyWMUYRBEYtvi8Ec7jRW
	1VzqCJ+aXF2UDUI1wALME1s=
X-Google-Smtp-Source: AGHT+IH0PK11dn6H63Mr8RpWcPoILY0OrFw4a9OhWFOW8KKCEwPGNLXzRWfSUSCL5bhxshAKSBIzhQ==
X-Received: by 2002:aca:1911:0:b0:3a7:aabc:738f with SMTP id l17-20020aca1911000000b003a7aabc738fmr11881935oii.39.1696273971928;
        Mon, 02 Oct 2023 12:12:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id p4-20020a637f44000000b005637030d00csm19436115pgn.30.2023.10.02.12.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:12:51 -0700 (PDT)
Message-ID: <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
Date: Mon, 2 Oct 2023 12:12:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_121254_150599_970C2EAB 
X-CRM114-Status: GOOD (  22.06  )
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

On 10/2/23 03:10, John Garry wrote:
> On 29/09/2023 18:51, Bart Van Assche wrote:
>> On 9/29/23 03:27, John Garry wrote:
>  > +    if (pos % atomic_write_unit_min_bytes)
>  > +        return false;
> 
> See later rules.

Is atomic_write_unit_min_bytes always equal to the logical block size?
If so, can the above test be left out?

>  > +    if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
>  > +        return false;
> 
> For SCSI, there is an atomic write granularity, which dictates 
> atomic_write_unit_min_bytes. So here we need to ensure that the length 
> is a multiple of this value.

Are there any SCSI devices that we care about that report an ATOMIC 
TRANSFER LENGTH GRANULARITY that is larger than a single logical block?
I'm wondering whether we really have to support such devices.

>  > +    if (!is_power_of_2(iov_iter_count(iter)))
>  > +        return false;
> 
> This rule comes from FS block alignment and NVMe atomic boundary.
> 
> FSes (XFS) have discontiguous extents. We need to ensure that an atomic 
> write does not cross discontiguous extents. To do this we ensure extent 
> length and alignment and limit atomic_write_unit_max_bytes to that.
> 
> For NVMe, an atomic write boundary is a boundary in LBA space which an 
> atomic write should not cross. We limit atomic_write_unit_max_bytes such 
> that it is evenly divisible into this atomic write boundary.
> 
> To ensure that the write does not cross these alignment boundaries we 
> say that it must be naturally aligned and a power-of-2 in length.
> 
> We may be able to relax this rule but I am not sure it buys us anything 
> - typically we want to be writing a 64KB block aligned to 64KB, for 
> example.

It seems to me that the requirement is_power_of_2(iov_iter_count(iter))
is necessary for some filesystems but not for all filesystems. 
Restrictions that are specific to a single filesystem (XFS) should not 
occur in code that is intended to be used by all filesystems 
(blkdev_atomic_write_valid()).

Thanks,

Bart.



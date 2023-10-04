Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1471E7C4E7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7LK6nH29B+DiFq/Dp1LOVmQEn5e8xZV4jVqq1U2i/KY=; b=0r/E4VHWY7n1SQ3xsKZMYZJn0l
	CNuAJu56/xCAWBw5m51yt8gJ7/iI8styhnQz9hiT4aqhGPX/nctLOLOHUvUCcaSO6uHrUpJ2Lgrjz
	I2HwYChoxMcE+Vz9vNWzYlzx9CqeMiNecNXaNDjlrIu0CBqa4mZwP3HUbj0lReHR1/qGcUHO3F0Lg
	CnmfgGlG/AGobWGEpvLVgd34MhHF0GZORpw2iQvhPfzsaYwFhQAoMLz6p/cId8ET/EqT/M6UZkGw2
	nb1xnuvfFBEyN7u8Zrda47s8suLaQptfvqXJCj6yfZXcKmF05oJdo5gUGqt0n9o4m5EYogUcf0RKX
	wPyXFa1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo5fW-000b3p-1P;
	Wed, 04 Oct 2023 17:28:18 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo5fT-000b2i-1E
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 17:28:17 +0000
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c752caeaa6so18487915ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Oct 2023 10:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440494; x=1697045294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LK6nH29B+DiFq/Dp1LOVmQEn5e8xZV4jVqq1U2i/KY=;
        b=bAqLuXAiFqvg+peVJy9ebZMEIWqmsVY6C1JtPAI0g6cb/IQXjUqNzxe09zBHtGk3yN
         ZuiADFNRDdherOYATAnd9FQv0k90NBabzeCrJbUsC1LxNBUY8dDHsqEw+ZaKr1r1PfAd
         MCZfWz6qRrdwD/rEm6ujsMS+DGetvdaDxLnm8LZ4jRVUkdr4YpEh3kaptQAxUgxPk4XI
         PJTOYJPJdi1Nba0odv1t6qQO9Do/pw+BM4Em5/fa541mH0kf/CxUyKu1A0ihMYGb9g+N
         41r01KeFaPpoHOOGtDJfeBXhF+yYn3Nf9ToQq6yufZnOY50Tg/OQ+yXcwNh8abt1doXp
         ACmw==
X-Gm-Message-State: AOJu0YzahhOSnnjac10Be67frHsZmV+4TXE39uOy1gi4x+j7XKbn2nUF
	XYtD/fmwY3cbDcwVpe21s4g=
X-Google-Smtp-Source: AGHT+IEzHNMF3cksQjNCwZTYzT4iNYh55MYK+W6HHWMYfKqVCiASNzywosBXOHLZCyqVPviHJVldoA==
X-Received: by 2002:a17:903:26c3:b0:1c5:de65:f8a8 with SMTP id jg3-20020a17090326c300b001c5de65f8a8mr2878682plb.1.1696440494355;
        Wed, 04 Oct 2023 10:28:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090282cb00b001bf11cf2e21sm3947140plz.210.2023.10.04.10.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:28:13 -0700 (PDT)
Message-ID: <776ff7e4-879f-4967-ba46-fd170804a9e0@acm.org>
Date: Wed, 4 Oct 2023 10:28:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] block: Add atomic write operations to request_queue
 limits
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
 dchinner@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 jbongio@google.com, linux-api@vger.kernel.org,
 Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-2-john.g.garry@oracle.com>
 <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org>
 <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_102815_441391_E93F6B52 
X-CRM114-Status: GOOD (  14.81  )
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

On 10/3/23 20:00, Martin K. Petersen wrote:
> 
> Bart,
> 
>> also that there are no guarantees that the data written by an 
>> atomic write will survive a power failure. See also the difference 
>> between the NVMe parameters AWUN and AWUPF.
> 
> We only care about *PF. The *N variants were cut from the same cloth 
> as TRIM and UNMAP.

In my opinion there is a contradiction between the above reply and patch
19/21 of this series. Data written with the SCSI WRITE ATOMIC command is
not guaranteed to survive a power failure. The following quote from
SBC-5 makes this clear:

"4.29.2 Atomic write operations that do not complete

If the device server is not able to successfully complete an atomic
write operation (e.g., the command is terminated or aborted), then the
device server shall ensure that none of the LBAs specified by the atomic
write operation have been altered by any logical block data from the
atomic write operation (i.e., the specified LBAs return logical block
data as if the atomic write operation had not occurred).

If a power loss causes loss of logical block data from an atomic write
operation in a volatile write cache that has not yet been stored on the
medium, then the device server shall ensure that none of the LBAs
specified by the atomic write operation have been altered by any logical
block data from the atomic write operation (i.e., the specified LBAs
return logical block data as if the atomic write operation had not
occurred and writes from the cache to the medium preserve the specified
atomicity)."

In other words, if a power failure occurs, SCSI devices are allowed to
discard the data written with a WRITE ATOMIC command if no SYNCHRONIZE
CACHE command has been submitted after that WRITE ATOMIC command or if
the SYNCHRONIZE CACHE command did not complete before the power failure.

Thanks,

Bart.


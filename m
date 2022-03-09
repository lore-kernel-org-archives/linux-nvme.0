Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642F9C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xrbpP/Yfwao8lnj7LaSM/uRQpgaSVRznTS0TTH/HjZY=; b=Up+k51GPZhmxPkr6IDh5Obgg0M
	s7Ke7XibpTP1RqqEQ5b0IMzIMay/2jc9yd4gAL9PsU2Fdeo8jNDkJPEGgODSqzhNEthvac5jkdxL2
	ro1OslowRthEd6RTTUMgA2C1+MDGmu3KOtHExwNNApNAKx8K2XhWDU4+syhUVKHNsj6OrV82VR/5E
	Wpo0ExK1KGflour5zcCYRzOBL/zKqqJMWMiEC0b08ki4j2ktfGm0cws2VG05EllW+eit6gGuYoEI2
	I7uEMAa7LlGzUVA7j8Dtrvudt/erdKi5/JeTQonm8DojO6rFQMWZpeJAPbu/A5n5Gz6U7Uq4lpqlL
	2lEh5J/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRyZd-009Cvs-Fd; Wed, 09 Mar 2022 15:50:01 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRyZa-009Cv3-Mq
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 15:50:00 +0000
Received: by mail-ej1-x62b.google.com with SMTP id yy13so6042110ejb.2
 for <linux-nvme@lists.infradead.org>; Wed, 09 Mar 2022 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrikto-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=xrbpP/Yfwao8lnj7LaSM/uRQpgaSVRznTS0TTH/HjZY=;
 b=s3xFNi6w/peDGqcEmc0BfMkPZn7cwxFxTcYpMhZo8mLd849lJJCJPAfTNkd3VaRKMn
 8D/pjSsda3jU/kUBKgqXjBLnK+pfqfXsEJb+MLwdZg9xmpkHQylcEcckW1X1Ej7wxleM
 Ocg1MWV+93+ARFiP/QbJy1epHrG9KrAALd91YORM/vgENm4v3zou2T2CrXDJY1TL81SQ
 LAlXStVVmvhEUfG4kfQ4LJnb3TkAtXzEhDl4vxr5+owgko1gg5gks3ZdBIr/A+yDY/gM
 RO33ihV+A5M7uWuDaf1/mtjmApBj24Up9s8gK/ksaVxOtT85uLj8B9Ov6cycxj929zDc
 Fr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xrbpP/Yfwao8lnj7LaSM/uRQpgaSVRznTS0TTH/HjZY=;
 b=kZFPatYgXL3X2qmnvhuxnQUCweA0yhGmhRMbXGrm4Z3agJokeUHfkfpvQvaHWo/s7/
 f6kyynbtcwSn7zuGsUzGIx+O3w3/IaIVebMDpJL8Dax+r6ZySvGF3rVYphnc2W4CnKlr
 C2Vf424mF+cRcOwr6pPcXpAnQsEPxuSDv0CmQidSuFlYKghuQzvOc06NxHj/J4GkIX+V
 Dd7dPmVRaH76itwnkznLm2G3YWdKFfYo2vVYkOuKugZZv8+PxnS/uUdR0cR2HzNr/nCi
 IBk6uPcLKU5t1N5drD8G+JYKLb5eZYMm8zM4Dk353zpAcYSJJB8xjz04KK86k2A+ZT/1
 sKrQ==
X-Gm-Message-State: AOAM531blzYVM7cQ0hPFHSOEnpU9yd8vIB/sCyDmQSsKqHxIAIkJLfuU
 90ugnpHczIGNQ2KT2td+tF7A3g==
X-Google-Smtp-Source: ABdhPJxZ5pBljQ9c4cS3Z9+taf/t5M3OBOhL/UO8YvG/idZkX4Ez6hrxTSX+wbR+RbFNFZdxzRpO9g==
X-Received: by 2002:a17:907:7f2a:b0:6d6:df12:7f57 with SMTP id
 qf42-20020a1709077f2a00b006d6df127f57mr390349ejc.122.1646840996396; 
 Wed, 09 Mar 2022 07:49:56 -0800 (PST)
Received: from [172.16.10.50] (213.16.174.189.dsl.dyn.forthnet.gr.
 [213.16.174.189]) by smtp.gmail.com with ESMTPSA id
 h8-20020a50ed88000000b004160630c980sm960188edr.62.2022.03.09.07.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 07:49:55 -0800 (PST)
Message-ID: <2015a35a-915c-351f-81cf-bd7dfe4502a1@arrikto.com>
Date: Wed, 9 Mar 2022 17:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, "roland@purestorage.com"
 <roland@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
 "dsterba@suse.com" <dsterba@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
 "jack@suse.com" <jack@suse.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <012723a9-2e9c-c638-4944-fa560e1b0df0@arrikto.com>
 <c4124f39-1ee9-8f34-e731-42315fee15f9@nvidia.com>
 <23895da7-bcec-d092-373a-c3d961ab5c48@arrikto.com>
 <alpine.LRH.2.02.2203090347500.17712@file01.intranet.prod.int.rdu2.redhat.com>
From: Nikos Tsironis <ntsironis@arrikto.com>
In-Reply-To: <alpine.LRH.2.02.2203090347500.17712@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_074958_851617_F1D6FC84 
X-CRM114-Status: GOOD (  13.39  )
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

On 3/9/22 10:51, Mikulas Patocka wrote:
> 
> Hi
> 
> Note that you must submit kcopyd callbacks from a single thread, otherwise
> there's a race condition in snapshot.
> 

Hi,

Thanks for the feedback. Yes, I'm aware of that.

> The snapshot code doesn't take locks in the copy_callback and it expects
> that the callbacks are serialized.
> 
> Maybe, adding the locks to copy_callback would solve it.
> 

That's what I did. I used a lock to ensure that kcopyd callbacks are
serialized for persistent snapshots.

For transient snapshots we can lift this limitation, and complete
pending exceptions out-of-oder and in "parallel", i.e., without
explicitly serializing kcopyd callbacks. The locks in pending_complete()
are enough in this case.

Nikos


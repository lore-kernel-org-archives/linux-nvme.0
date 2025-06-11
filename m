Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97736C71134
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 19:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:MIME-Version:Date:Message-ID:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T4o6YcPRF1U1tvznrJTs87/iT7vaJoRM/tUg+dY5ocQ=; b=OlWCRo1LH8PJVgV7EMqy8+PpYQ
	hktrNdbmmbk8qTKDLFgX+dq+fH597m9WBXA1fkEtlYu7NQNEe4MspECNBjHwttl551VQkqjoYysyD
	bAD0Vt6UKqWaYW3ehl8pprz8MZhoiWA6N6N/AizFRNGasFHVdyAvxCWnbZQcFhlCnh9CE9I5h3Ud2
	fKNv5p51JjzOJLrx1dDzcCRVYtWC+6jLJYU+rsTH22WSGymyYWvv4eT2ng8XFMKdqIo2n2chTzD5G
	0cZKn6jZGRTuRBTvrnLssDoqfhK4qER3iDnEl7XNwsupJVCumvkh9Cs81/XojQjwaQ3v18qRJpn3r
	S+VgpRrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRXV-0000000B2o1-1uVc;
	Wed, 11 Jun 2025 19:55:13 +0000
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPNJC-0000000ANUG-2xLj
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 15:24:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749655450; x=1781191450;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=T4o6YcPRF1U1tvznrJTs87/iT7vaJoRM/tUg+dY5ocQ=;
  b=W/Qwl9S2MnJkQDuXGkdsmWpSZMK5NJ/YC8vch2AQMsHRbGReoo8Obl4P
   piq2FyNxWgKe1w+uiEaGsNDlKcnQ2BTApg9lxVJs+pSIu/lglkdLg4WSp
   3kYjkwv7OCo7OQK5DLYaWOL4kLyfnn1ZeDBvffPySRNHJjehb2HDzi7xA
   EC46aMEIStFkz8Fdgnc8uaPCCRASyIcY8pZuCDLWMt+hfpRDDWATduJ4B
   4GyD/OIuqnsC6KOo52J541bq1u12EPUZ/V8t52zFn4kHeoL5DReiHZtSI
   fy/9KjC0wEr8WKjlzl3yBBo1lRHe3wsSO+ZKtGnZRwT2q2O3upB0lhzAf
   g==;
X-IronPort-AV: E=Sophos;i="6.16,228,1744070400"; 
   d="scan'208";a="754310820"
Subject: Re: [PATCH] Revert "block: don't reorder requests in blk_add_rq_to_plug"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 15:24:08 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:34556]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.92:2525] with esmtp (Farcaster)
 id 3f9813e5-609c-48b8-930f-26a74422b933; Wed, 11 Jun 2025 15:24:08 +0000 (UTC)
X-Farcaster-Flow-ID: 3f9813e5-609c-48b8-930f-26a74422b933
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 15:24:08 +0000
Received: from [192.168.11.154] (10.106.82.32) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 15:24:07 +0000
Message-ID: <32c83d67-1d69-4d69-8d00-274cf0d0ff62@amazon.com>
Date: Wed, 11 Jun 2025 16:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ming Lei <ming.lei@redhat.com>
CC: <stable@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>, Hagar
 Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>, "Jens Axboe"
	<axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-nvme@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20250611121626.7252-1-abuehaze@amazon.com>
 <aEmcZLGtQFWMDDXZ@fedora>
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <aEmcZLGtQFWMDDXZ@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.82.32]
X-ClientProxiedBy: EX19D006EUC003.ant.amazon.com (10.252.51.252) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_082410_974394_3D8C057E 
X-CRM114-Status: GOOD (  11.99  )
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

On 11/06/2025 16:10, Ming Lei wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, Jun 11, 2025 at 12:14:54PM +0000, Hazem Mohamed Abuelfotoh wrote:
>> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
>>
>> Commit <e70c301faece> ("block: don't reorder requests in
>> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
>> list, this had significant impact on bio merging with requests exist on
>> the plug list. This impact has been reported in [1] and could easily be
>> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
>> having any filesystem on the disk.
>>
>> My benchmark is:
>>
>>      fio --time_based --name=benchmark --size=50G --rw=randwrite \
>>        --runtime=60 --filename="/dev/nvme1n1" --ioengine=psync \
>>        --randrepeat=0 --iodepth=1 --fsync=64 --invalidate=1 \
>>        --verify=0 --verify_fatal=0 --blocksize=4k --numjobs=4 \
>>        --group_reporting
>>
>> On 1.9TiB SSD(180K Max IOPS) attached to i3.16xlarge AWS EC2 instance.
>>
>> Kernel        |  fio (B.W MiB/sec)  | I/O size (iostat)
>> --------------+---------------------+--------------------
>> 6.15.1        |   362               |  2KiB
>> 6.15.1+revert |   660 (+82%)        |  4KiB
>> --------------+---------------------+--------------------
> 
> I just run one quick test in my test VM, but can't reproduce it.

Possibly you aren't hitting the Disk IOPS limit because you are using 
more powerful SSD? In this case I am using i3.16xlarge EC2 instance 
running AL2023 or may be fio has different behavior across Distribution. 
In AL2023 we have fio-3.32

> Also be curious, why does writeback produce so many 2KiB bios?

Good question unfortunately I don't have a good answer on why we have
2KB bios although I am specifying 4K as I/O size in fio, this is 
something we probably should explore further.

Hazem





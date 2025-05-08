Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C9BC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6SLg1KNKgK5VLUjWCVVNk8gAtIuPejd+dih/RcXevNk=; b=4d+tCnFNg+hCNKmWT33N2prJjm
	TahOLMM/ccDWq8zvZxUynYJpouGKvww4ET+FhJfJXCw+boYckNCAMDayenvCX9Kd2j7RRB7sDYV/M
	oE8oj6o8/+1a9VA3KzVeHDrwgjnWU1Qs+O2yGkfyFPFszfGIn2F0D9tHSFduMu0nxoj9TKMrzXBaJ
	dx6XY33zfAmmfVYAqYBelfdzEx0uDJhKOSbPo00YNdR9yoLhXHeCg2XujBeNw7lAhUo2nSCVb3XZR
	LfLPrwasNy16Ee9+3Q6XO3ksdFBDo/maNvlg5t7ZrSKkJ1YjYow5OuPPMUVs6+GSTUBkljTlfoA5r
	DjqA3Xtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0Eg-00000000aOi-1T2E;
	Thu, 08 May 2025 12:20:22 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0By-00000000ZsE-0cDl
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 12:17:36 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZtWNH0344zYQtvr
	for <linux-nvme@lists.infradead.org>; Thu,  8 May 2025 20:17:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5906E1A018D
	for <linux-nvme@lists.infradead.org>; Thu,  8 May 2025 20:17:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl_KoBxoXus0Lw--.707S3;
	Thu, 08 May 2025 20:17:16 +0800 (CST)
Message-ID: <68172a9e-cf68-4962-8229-68e283e894e1@huaweicloud.com>
Date: Thu, 8 May 2025 20:17:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, john.g.garry@oracle.com,
 bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
 brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
 <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
 <20250506043907.GA27061@lst.de>
 <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
 <20250506121102.GA21905@lst.de>
 <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
 <20250508050147.GA26916@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250508050147.GA26916@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnSl_KoBxoXus0Lw--.707S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF43ZFW3Zry3Aw48Kw1xKrg_yoWrtrWDpF
	W8WF1jkF4DKr13Cw1v9w4Igrn0vFs3AF15C39Ykr48Cw45XF13KFnaga40yF9rXryxZayD
	tFZ0kFyUZa1Iy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_051734_482080_1D921646 
X-CRM114-Status: GOOD (  29.57  )
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

On 2025/5/8 13:01, Christoph Hellwig wrote:
> On Wed, May 07, 2025 at 03:33:23PM +0800, Zhang Yi wrote:
>> On 2025/5/6 20:11, Christoph Hellwig wrote:
>>> On Tue, May 06, 2025 at 07:16:56PM +0800, Zhang Yi wrote:
>>>> Sorry, but I don't understand your suggestion. The
>>>> STATX_ATTR_WRITE_ZEROES_UNMAP attribute only indicate whether the bdev
>>>> and the block device that under the specified file support unmap write
>>>> zeroes commoand. It does not reflect whether the bdev and the
>>>> filesystems support FALLOC_FL_WRITE_ZEROES. The implementation of
>>>> FALLOC_FL_WRITE_ZEROES doesn't fully rely on the unmap write zeroes
>>>> commoand now, users simply refer to this attribute flag to determine
>>>> whether to use FALLOC_FL_WRITE_ZEROES when preallocating a file.
>>>> So, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES doesn't
>>>> have strong relations, why do you suggested to put this into the ext4
>>>> and bdev patches that adding FALLOC_FL_WRITE_ZEROES?
>>>
>>> So what is the point of STATX_ATTR_WRITE_ZEROES_UNMAP?
>>
>> My idea is not to strictly limiting the use of FALLOC_FL_WRITE_ZEROES to
>> only bdev or files where bdev_unmap_write_zeroes() returns true. In
>> other words, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES
>> are not consistent, they are two independent features. Even if some
>> devices STATX_ATTR_WRITE_ZEROES_UNMAP are not set, users should still be
>> allowed to call fallcoate(FALLOC_FL_WRITE_ZEROES). This is because some
>> devices and drivers currently cannot reliably ascertain whether they
>> support the unmap write zero command; however, certain devices, such as
>> specific cloud storage devices, do support it. Users of these devices
>> may also wish to use FALLOC_FL_WRITE_ZEROES to expedite the zeroing
>> process.
> 
> What are those "cloud storage devices" where you set it reliably,
> i.e.g what drivers?

I don't have these 'cloud storage devices' now, but Ted had mentioned
those cloud-emulated block devices such as Google's Persistent Desk or
Amazon's Elastic Block Device in. I'm not sure if they can accurately
report the BLK_FEAT_WRITE_ZEROES_UNMAP feature, maybe Ted can give more
details.

https://lore.kernel.org/linux-fsdevel/20250106161732.GG1284777@mit.edu/

> 
>> Therefore, I think that the current point of
>> STATX_ATTR_WRITE_ZEROES_UNMAP (possibly STATX_WRITE_ZEROES_UNMAP) should
>> be to just indicate whether a bdev or file supports the unmap write zero
>> command (i.e., whether bdev_unmap_write_zeroes() returns true). If we
>> use standard SCSI and NVMe storage devices, and the
>> STATX_ATTR_WRITE_ZEROES_UNMAP attribute is set, users can be assured
>> that FALLOC_FL_WRITE_ZEROES is fast and can choose to use
>> fallocate(FALLOC_FL_WRITE_ZEROES) immediately.
> 
> That's breaking the abstracton again.  An attribute must say something
> about the specific file, not about some underlying semi-related feature.

OK.

> 
>> Would you prefer to make STATX_ATTR_WRITE_ZEROES_UNMAP and
>> FALLOC_FL_WRITE_ZEROES consistent, which means
>> fallcoate(FALLOC_FL_WRITE_ZEROES) will return -EOPNOTSUPP if the block
>> device doesn't set STATX_ATTR_WRITE_ZEROES_UNMAP ?
> 
> Not sure where the block device comes from here, both of these operate
> on a file.

I am referring to the block device on which the filesystem is mounted.
The support status of the file is directly dependent on this block
device.

> 
>> If so, I'd suggested we need to:
>> 1) Remove STATX_ATTR_WRITE_ZEROES_UNMAP since users can check the
>>    existence by calling fallocate(FALLOC_FL_WRITE_ZEROES) directly, this
>>    statx flag seems useless.
> 
> Yes, that was my inital thought.
> 
>> 2) Make the BLK_FEAT_WRITE_ZEROES_UNMAP sysfs interface to RW, allowing
>>    users to adjust the block device's support state according to the
>>    real situation.
> 
> No, it's a feature and not a flag.
> 

I am a bit confused about the feature and the flag, I checked the other
features, and it appears that features such as BLK_FEAT_ROTATIONAL allow
to be modified, is this flexibility due to historical reasons or for the
convenience of testing?

Think about this again, I suppose we should keep the
BLK_FEAT_WRITE_ZEROES_UNMAP as read-only and add a new flag,
BLK_FALG_WRITE_ZEROES_UNMAP_DISABLED, to disable the
FALLOC_FL_WRITE_ZEROES. Since the Write Zeroes does not guarantee
performance, and some devices may claim to support **UNMAP** Write Zeroes
but exhibit extremely slow write-zeroes speeds. Users may want be able to
disable it. Thoughts？

Thanks,
Yi.



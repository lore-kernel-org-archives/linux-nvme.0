Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB3CD1356B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 06:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a5Gj5a/SMU3rWyW/A/nal7ZkVMs+IQYf4lU/WytkNsA=; b=HEbfzwgJg/9VxvRkTecfnnFWCy
	8mWTjQZ1TB7xiU+JVy6myPj5N+Pf+/fK0w5xwlbUq1VCph4DTy6jmwwFRfB9cRIyTphW6sg6rJ63b
	jlEDSR/18Zpe0TXGjXIFEWU6eXsHRcXoVITWqCXGVC4dntCZwoDfHEk6mEFUh67/oXd1YypV8iQab
	F6qfSbReBdF/ssFErrq8TFU7ENe7a0Ocv1xygXsDv1T+A5rmrDK5MO5RnUPcE1VDun3XLf7gAaha2
	fKs/rYuXObWoVVOTItBGwleG2qtDWSRMJZzofchRkkTGfhTmKb/KBZVjz0weAxlm4CF2U37ioVW5e
	R1YxsLJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fzi-0000000DOzM-1zJi;
	Tue, 29 Oct 2024 06:46:22 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fzc-0000000DOyV-1qza
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 06:46:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730184371; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=a5Gj5a/SMU3rWyW/A/nal7ZkVMs+IQYf4lU/WytkNsA=;
	b=EFhq5eeaRe0v8vYfOm343ZHUp1YRY4sKgL1o43jf4uvq812tUOvTDuxNt+nk6vtY23Y5BbrqVmQxMOBVvkv5s8w1XnxsLWtE+6kKYLl/xsDYs7azMHf+S1lGWlPzSKqnWrTJkilI9DDLXjL1UadiShgKy1fGZPf9M0SDsbs5e3U=
Received: from 30.178.81.234(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WI98.If_1730184367 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 14:46:08 +0800
Message-ID: <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
Date: Tue, 29 Oct 2024 14:46:05 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_234618_581524_7C398F78 
X-CRM114-Status: UNSURE (   5.85  )
X-CRM114-Notice: Please train this message.
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


在 2024/10/29 13:04, Chaitanya Kulkarni 写道:
> On 10/28/24 18:49, Guixin Liu wrote:
>> Make nvmet_wq visible in sysfs, allowing for tuning the it's attr
>> through sysfs.
>>
>> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
>> ---
> do you happened have a usecase for this?
>
> -ck

Sometimes, in order to respond promptly to certain events or

manage commands, we need to reserve resources and partition

the CPU cores. For example, if there are 4 cores available,

we can initially allocate them by dedicating one core for

management while the remaining 3 cores are specifically for handling IO.

Best Regards,

Guixin Liu

>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B3BEB5979
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Mime-Version:To:In-Reply-To:Message-Id:Subject:Cc:
	Date:References:Content-Type:From:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YpKc6yOuTbCEZVNyOdM6S6S4lGv43npX1qdpkXI0FR0=; b=ECDoUFMtOla23uG3aaVpN9DMHB
	R/yOvMv5f8Ht+eocIMHRGovCPP/zaNcBsBAn8UZ0OxlFCP36VYlW4hEgmRBGTY9dWe5V0mAsF+Esl
	S/nmUWElhfd8EpcS6VhhOVlyOifxkVHG38TxWzXHjMiMKIEt7w0lndUYQMNSbzuZX87o12Yl5T8pl
	LbLXV+ujVqIW3jhaFblJ3NiBi8w8RunHMFTh6JCyjl0M9D2vuSEjn//fjiUtb/UVGchlU4m3Ynf3w
	QWGEHAk+IE+PfumaUN15Q9+b1r0UZALk9F0NmURfcTo8l6CMmmktNgVjIYQacyAyHtMmPX8zOlrtO
	0egsLoBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq5Fb-00000000N1m-2WOA;
	Wed, 11 Feb 2026 08:07:07 +0000
Received: from sg-1-30.ptr.blmpb.com ([118.26.132.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq5FW-00000000N0x-2a5U
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 08:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770797210;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=YpKc6yOuTbCEZVNyOdM6S6S4lGv43npX1qdpkXI0FR0=;
 b=uxCW6gf7lFzK5h6En8xfFA8sizOV7wFk0LvmoAIanh3B4KWgjWR0IKkbRobLyKhqQasvWV
 cU1kkmsd43cbWKRlhbfEKnapbLouRtIcQeTffLTCplcCVjOrqwW02WkhjmzyTERRkxJhNd
 05HwGx3vlzxM6dUN/A2w5lfJowEgSpTFd/aafPKOdf7hzJZP36DV0Q0oTYGci1pvcBHUWr
 e1WngX1xZ4CsPp49xlNfkNymFR7IbXDh3EfYNYwsUTpoJee7Oz5bS4e+wuOiyxkJa/NK06
 qSNY3TF+WPrJCX5nI5wxUOvd58FMj2ahcjwhjRrcZkv2uat9MDLxr9chkQzu0Q==
From: "Yu Kuai" <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-5-yukuai@fnnas.com> <f5da8810-84cd-408b-a1e6-8e80c8578168@linux.ibm.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Date: Wed, 11 Feb 2026 16:06:46 +0800
X-Lms-Return-Path: <lba+2698c3899+155a77+lists.infradead.org+yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Cc: <tj@kernel.org>, <ming.lei@redhat.com>, <neal@gompa.dev>, 
	<asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs file creation
Message-Id: <5c255e26-3108-4622-b500-486c1d68d498@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Wed, 11 Feb 2026 16:06:48 +0800
In-Reply-To: <f5da8810-84cd-408b-a1e6-8e80c8578168@linux.ibm.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <sven@kernel.org>, 
	<j@jannau.net>, <linux-block@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, <yukuai@fnnas.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_000703_539908_DADB8C03 
X-CRM114-Status: GOOD (  14.42  )
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
Reply-To: yukuai@fnnas.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

=E5=9C=A8 2026/2/11 15:20, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 2/9/26 1:59 PM, Yu Kuai wrote:
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index faeaa1fc86a7..03583d0d3972 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -613,11 +613,6 @@ static void debugfs_create_files(struct request_que=
ue *q, struct dentry *parent,
>>   				 const struct blk_mq_debugfs_attr *attr)
>>   {
>>   	lockdep_assert_held(&q->debugfs_mutex);
>> -	/*
>> -	 * Creating new debugfs entries with queue freezed has the risk of
>> -	 * deadlock.
>> -	 */
>> -	WARN_ON_ONCE(q->mq_freeze_depth !=3D 0);
>>   	/*
>>   	 * debugfs_mutex should not be nested under other locks that can be
>>   	 * grabbed while queue is frozen.
>> @@ -628,9 +623,19 @@ static void debugfs_create_files(struct request_que=
ue *q, struct dentry *parent,
>>   	if (IS_ERR_OR_NULL(parent))
>>   		return;
>>  =20
>> +	/*
>> +	 * Avoid creating debugfs files while the queue is frozen, wait for
>> +	 * the queue to be unfrozen and prevent new freeze while creating
>> +	 * debugfs files.
>> +	 */
>> +	if (blk_queue_enter(q, 0))
>> +		return;
>> +
>>   	for (; attr->name; attr++)
>>   		debugfs_create_file_aux(attr->name, attr->mode, parent,
>>   				    (void *)attr, data, &blk_mq_debugfs_fops);
>> +
>> +	blk_queue_exit(q);
>>   }
>>  =20
>>   void blk_mq_debugfs_register(struct request_queue *q)
> I also noticed that we use other debugfs helpers such as debugfs_create_d=
ir()
> from some block paths, which could run into the same fs-reclaim recursion=
 issue.
> So we may need to consider those call sites as well to ensure consistent =
handling.

Yes, sounds correct.

>
> On another note, instead of waiting for queue to be unfreezed, does it ma=
kes sense to
> wrap the debugfs code under NOIO context (as Christoph pointed in another=
 thread)?
> IMO, if fs-reclaim recursion is the only issue here we would be better of=
f using
> NOIO context instead of blocking for queue to be unfrozen from other cont=
exts.

I can try this. So far, debugfs_mutex related deadlocks are related to fs-r=
eclaim,
although I'm not that confident there won't be any other  implicit dependen=
cy.
Meanwhile, looks like the previous patches for nvme targets are not necessa=
ry anymore.

> Thanks,
> --Nilay
>
--=20
Thansk,
Kuai


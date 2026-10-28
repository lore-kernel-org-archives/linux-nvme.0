Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648BE606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Aw71Q9Jp;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TVqhkpDU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mVwURAqx8whENUcqzNMtjh9XYTdXv9Q+JZFY9tJyvjU=; b=Aw71Q9JpUYB8fq
	7494UZDw32qmicQ9k5U8D7jpKDsW9jffD8JlITMJK3VpocQUhkQNg4MOtSyS8a5Tpfr0RuSLZae3j
	l0tQGGwdpZvnWIpCIAYSP2oI//4K4boqtZ/uzSYcXxQEQuC8NUeE1dG4gjzBqEiDP/SPGxe9Kn798
	Z3cv+jjfWUHl9RfVYyGg7HkronDd2LVfXYbaZYKj2S4tpzOSEsFnOUy76Jlt54of2VtAS/kwIldY2
	oOSkROykegbY5t5iFho3oZzurfeBM81QMsnmNMti+VPLi27u5vlib69Q9ml2chbIDDyGa5H9qks2o
	2QFW+tV5JgO5ZUy93IzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLt1D-000000064EL-3uFv;
	Wed, 28 Oct 2026 02:03:59 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLt1A-000000064Da-0uOX
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 02:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793153032; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mVwURAqx8whENUcqzNMtjh9XYTdXv9Q+JZFY9tJyvjU=;
	b=TVqhkpDUEbIaY6vjVOmFEduqWjli3gh5zhNA+bujMPu4NhadO7GQvWXPAdiDr3wBnKIqWJZqQU61lh6qMxQyhkNs7VCcXoh97cMLJNIFx2CQJrdfyiP/ultcVbbT5nFF1bfDQEUsLicJcCMkREP7GzeCJbzcOl5J5D2CAEFpAkw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDfLq9e_1793153030;
Received: from 30.178.69.77(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDfLq9e_1793153030 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 10:03:51 +0800
Message-ID: <020d512c-ee16-4360-b3b2-a3779f1b8a77@linux.alibaba.com>
Date: Wed, 28 Oct 2026 10:03:49 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-tcp: Validate the queue state under the queue
 lock in the address attribute
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261027123950.3122316-1-kanie@linux.alibaba.com>
 <auExzRCjbyQeOU78@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <auExzRCjbyQeOU78@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_190356_949850_4B1ADCBD 
X-CRM114-Status: GOOD (  10.84  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/28 07:20, Keith Busch 写道:
> On Tue, Oct 27, 2026 at 08:39:50PM +0800, Guixin Liu wrote:
>> @@ -3035,6 +3048,14 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>>  		goto out_free_ctrl;
>>  	}
>>  
>> +	/*
>> +	 * The queue locks are owned by the controller, not the queues:
>> +	 * they outlive the per-queue connect/disconnect cycles so that
>> +	 * sysfs readers can never race their destruction.
>> +	 */
>> +	for (i = 0; i < ctrl->ctrl.queue_count; i++)
>> +		mutex_init(&ctrl->queues[i].queue_lock);
>> +
> Could you rebase to the latest nvme-7.4 branch? There is already a loop
> happening here to initialize other fields in the queue.
Sure, I will do the rebase, changed in v4.

Best Regards,
Guixin Liu



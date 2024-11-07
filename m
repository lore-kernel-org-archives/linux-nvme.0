Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E236D29FA5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 02:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrIsF5fEl+aaQ1UmrGh7RnLcmCNMszZt/jUjsdMCadc=; b=OWqQG4rWtrcV13xBLinP5hRM6e
	fZbd/v/NpSRlHHCTmksFth2rH8r5v7RDk/WiQzp1a4rB/gbtIT4AQ3dcwQ35bSTpBjDkr7Ycyav+H
	VBwPg3ZyzL5plmgYx4VwZPy3XweyN3Psbo8MWxemLeaoQJLSaHA2rCO8aC8eI034xX6htp9H8lpHd
	1UZ9nYMyQPtk3qNMWO562AxkGX4W8puE+ohqO/JeIGjkInIDYkw0AS2biTM0Kry0XD/Wp5WcJep/X
	YFyJh5x1pCuVTrJ7K3IzdxRoXPhVi6TRmnWK5lVJedpij/4RzR2i+2qAVDMP1MGdilKVfzciF6ILv
	f6tYa6lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8s4n-00000005R2u-0n5O;
	Thu, 07 Nov 2024 02:16:49 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8rtI-00000005OfA-2vSR
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 02:04:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730945093; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RrIsF5fEl+aaQ1UmrGh7RnLcmCNMszZt/jUjsdMCadc=;
	b=nN17yXVxe8jNap+DlrozQN0EYKlS6bntvCXZWJdihr2Di00M1pFiohRTR6vV7cBp75WtBOl9rjxb00Lq/06C3Fp0ab2GTSwkIEV+Hd/OTlyS0IKTe5hbozUy8IdKLU7N//1YQuXWxYmUC9uioFutPrWOch0f+ZHA1B0RtvybfA4=
Received: from 30.178.82.60(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WItohOs_1730945089 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 10:04:50 +0800
Message-ID: <62e4bbe2-a23f-48ef-a768-4a258caa9248@linux.alibaba.com>
Date: Thu, 7 Nov 2024 10:04:49 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvme-multipath: introduce service-time iopolicy
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20241106103410.62157-1-kanie@linux.alibaba.com>
 <ZyuUUokeCSsU_1-Y@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ZyuUUokeCSsU_1-Y@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_180456_905225_C58C68F1 
X-CRM114-Status: UNSURE (   7.06  )
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


在 2024/11/7 00:07, Keith Busch 写道:
> On Wed, Nov 06, 2024 at 06:34:10PM +0800, Guixin Liu wrote:
>> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_ST) {
>> +		atomic_add(blk_rq_bytes(rq), &ns->ctrl->inflight_size);
>> +		nvme_req(rq)->flags |= NVME_MPATH_CNT_IOSIZE;
>> +	}
> ...
>
>>   static inline struct nvme_request *nvme_req(struct request *req)
>> @@ -367,6 +368,7 @@ struct nvme_ctrl {
>>   	struct timer_list anatt_timer;
>>   	struct work_struct ana_work;
>>   	atomic_t nr_active;
>> +	atomic_t inflight_size;
> You're counting bytes, so this should probably be an atomic64_t.

Sure it is, changed in v2, thanks.

Best Regards,

Guixin Liu



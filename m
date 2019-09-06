Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28683C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 08:51:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B0020842
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 08:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="do0WA62s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B0020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qigVfjLEANLUX1ED8dW9HOTEXmXSqdrUlrUXrNmt63I=; b=do0WA62s2y5GVZd5CylZ2bBxl
	E2KhSuoOOS4LRODnI06toK0oE9Xr7jJ9UasMDfiNf0IpDeAYX5eU6ez7JtymzK042Zr+9LI2tex0Z
	jTyCQ/0SSMYb3mySq6v21xvBqsqUpW+ailA35rVxvnLp5CpQ9CwpsevSBZpxm9GlVhblErlIkIZkZ
	VtDoPTxnQ0Jt4e+bvhbLjnQKoiNW7WQVWE3bE1QVv6aGv06gZoBIaiv1CgSEM4JXKLPVJJ4BtbNtT
	C8jODG52hlwyomDKjIN0azTEarJaUkcpeafECpXeRXciZZjTjlIzAPFJLWfEtccZF/Jj5k7SPt1pN
	Jitw1wlFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i69xO-0000Lt-2O; Fri, 06 Sep 2019 08:51:02 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i69xK-0000Jz-ED
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 08:51:00 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id AB95A56F62A0480BF6C4;
 Fri,  6 Sep 2019 16:50:44 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0;
 Fri, 6 Sep 2019 16:50:33 +0800
Subject: Re: [PATCH 4/4] genirq: use irq's affinity for threaded irq with
 IRQF_RESCUE_THREAD
To: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20190827085344.30799-1-ming.lei@redhat.com>
 <20190827085344.30799-5-ming.lei@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <0214c66d-6496-10b9-7e37-e5b37d3022ef@huawei.com>
Date: Fri, 6 Sep 2019 09:50:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190827085344.30799-5-ming.lei@redhat.com>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_015058_672756_B4FB5732 
X-CRM114-Status: GOOD (  18.91  )
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 chenxiang <chenxiang66@hisilicon.com>, Peter Zijlstra <peterz@infradead.org>,
 Long Li <longli@microsoft.com>, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Ingo
 Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 27/08/2019 09:53, Ming Lei wrote:
> In case of IRQF_RESCUE_THREAD, the threaded handler is only used to
> handle interrupt when IRQ flood comes, use irq's affinity for this thread
> so that scheduler may select other not too busy CPUs for handling the
> interrupt.
>
> Cc: Long Li <longli@microsoft.com>
> Cc: Ingo Molnar <mingo@redhat.com>,
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>


> ---
>  kernel/irq/manage.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 1566abbf50e8..03bc041348b7 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -968,7 +968,18 @@ irq_thread_check_affinity(struct irq_desc *desc, str=
uct irqaction *action)
>  	if (cpumask_available(desc->irq_common_data.affinity)) {
>  		const struct cpumask *m;
>
> -		m =3D irq_data_get_effective_affinity_mask(&desc->irq_data);
> +		/*
> +		 * Managed IRQ's affinity is setup gracefull on MUNA locality,

gracefully

> +		 * also if IRQF_RESCUE_THREAD is set, interrupt flood has been
> +		 * triggered, so ask scheduler to run the thread on CPUs
> +		 * specified by this interrupt's affinity.
> +		 */

Hi Ming,

> +		if ((action->flags & IRQF_RESCUE_THREAD) &&
> +				irqd_affinity_is_managed(&desc->irq_data))

This doesn't look to solve the other issue I reported - that being that =

we handle the interrupt in a threaded handler natively, and the hard =

irq+threaded handler fully occupies the cpu, limiting throughput.

So can we expand the scope to cover that scenario also? I don't think =

that it=92s right to solve that separately. So if we're continuing this =

approach, can we add separate judgment for spreading the cpumask for the =

threaded part?

Thanks,
John

> +			m =3D desc->irq_common_data.affinity;
> +		else
> +			m =3D irq_data_get_effective_affinity_mask(
> +					&desc->irq_data);
>  		cpumask_copy(mask, m);
>  	} else {
>  		valid =3D false;
>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A79E7717F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Dec 2024 02:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/OcfktP/vzoA37xkZA5zyJB6tG8UGPc/4htwqiYqx3Y=; b=wmM9JuUsAy+kwjVnTRTwn0+EXS
	DebXQqHFpC6C6uZgosLfvt3/6zORAsVBLaa9W0DZrdHMGyErBFq9CspWRjudeQxffRLRJ4AE3BMDa
	W1K+iumXiVa3JS0uOLNxsBIBgI/oyAtA62MOOoQKplxhpnvj893BqtTFGxZda2jNXppp+zyJVGUmt
	l401nPeNWTLFFcZBSWfL+CnhhrCJ+ihLUz4lbw6+w9Pfuh8JmM40JD4FYUuZz0cCCt03J33iOdp31
	1I3Zv36EUPuAw+CsFV+hT7iC6Us/cXfJe43y1jHYl1gnajjc+0Jty2VwpsYRoEKfdQV8CPy1qODFY
	3YaGVgqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMHrq-00000005Yx4-0T7X;
	Sat, 14 Dec 2024 02:26:54 +0000
Received: from m16.mail.163.com ([220.197.31.5])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMHrI-00000005Yto-3O9R
	for linux-nvme@lists.infradead.org;
	Sat, 14 Dec 2024 02:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/OcfktP/vzoA37xkZA5zyJB6tG8UGPc/4htwqiYqx3Y=;
	b=NHQ7zNw2P3d/JOnEvJ1u8rZ+q8m47kLlVyX6Zb1FF8X6YLydbqSixVJhSTlIY9
	9mTozuN4yQNRuzJm5l4itAe0ux4llJFFg8zxXrHoVZ5Nx5xvSwVo5EqHqfWMxhX2
	F59uDZK9p33iWhfiz4IzBkQmZhiCp4Y/8c8OJw1oC/exw=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC35PDC7FxnqUWVAg--.55774S2;
	Sat, 14 Dec 2024 10:26:11 +0800 (CST)
Date: Sat, 14 Dec 2024 10:26:10 +0800
From: Honggang LI <honggangli@163.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Subject: Re: workqueue: WQ_MEM_RECLAIM nvmet-wq:nvmet_rdma_release_queue_work
 [nvmet_rdma] is flushing !WQ_MEM_RECLAIM irdma-cleanup-wq:irdma_flush_worker
 [irdma]
Message-ID: <Z1zswha52zdJcEXp@fc39>
References: <Z1wBEgluXUDrDJmN@fc39>
 <d6067519-26ab-4851-ba58-3ebe254e88d1@linux.dev>
 <0d0ee443-a903-406e-9bec-b02b1391b7d0@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0ee443-a903-406e-9bec-b02b1391b7d0@linux.dev>
X-CM-TRANSID: PSgvCgC35PDC7FxnqUWVAg--.55774S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy8CrWUWF13urWUKF1kGrg_yoWDGFb_uF
	yqvr9xWw1DuFnFvr4ktr13uFy5Ka1UZw1fury3K343AasIqwn5Zw4kGFWfW34UJay0yFsr
	Jr15Jr4xKrsagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRCwZ2PUUUUU==
X-Originating-IP: [125.33.14.1]
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiDwi1RWdc6q8xAgAAs6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_182621_266973_6999C5E6 
X-CRM114-Status: UNSURE (   9.87  )
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

On Fri, Dec 13, 2024 at 08:30:01PM +0100, Zhu Yanjun wrote:
> I delved into this problem. It seems that it is a known problem.
> Can you apply the following to make tests again?
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c
> b/drivers/infiniband/hw/irdma/hw.c
> index ad50b77282f8..31501ff9f282 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -1872,7 +1872,7 @@ int irdma_rt_init_hw(struct irdma_device *iwdev,
>                  * free cq bufs
>                  */
>                 iwdev->cleanup_wq = alloc_workqueue("irdma-cleanup-wq",
> -                                       WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
> +                                       WQ_UNBOUND|WQ_MEM_RECLAIM,

After add flag WQ_MEM_RECLAIM, the warning message is gone. However,
it may raise similar issue fixed by commit 2cc7d150550 again.

thanks

commit 2cc7d150550cc981aceedf008f5459193282425c
Author: Sindhu Devale <sindhu.devale@intel.com>
Date:   Tue Apr 23 11:27:17 2024 -0700

    i40e: Do not use WQ_MEM_RECLAIM flag for workqueue



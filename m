Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEAFFD064D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8qrdW7ad9UeZdBd4OSxjRGPl/Ygb5YzCVAxbPDsNc0=; b=qFYqRBXYTo7iwyicbUnrIb8zCS
	yxf9Ptd5RuO3cVXz7Karh9S6YcVgFvq1sa9h9JFL9G6atR8/9HKrLrc+Dp6p/s2ibB6GOxJqWCZuw
	u+6dlNIxw+GfUIEnx9i66V2stVi+amvHAluXKrdr2Ttk0+j21m/V7tAJ+KVcWxsszfXp+LK162Jhb
	pQ7h1ORiq+G+Z+gMpcmYFfL8KnbDzt3oOKwE/EbZInnJjauZwLY4HyE44HKKCQdsIaD0zOWdDRIyE
	orFG7gGwrVA0stQciIQKZ8mGlff+mcqpS4VITxCblQ5b4jQcr7t7xhfqdPsQ4NY4Oa5+8thpDXCDw
	IX0apu2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0E7X-0000000B4B4-45Gk;
	Wed, 11 Mar 2026 07:36:43 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0E7O-0000000B4AY-1q8C
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 07:36:38 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 1f15775b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 08:29:51 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 08:29:51 +0100
Message-Id: <DGZRYXTKC049.1I6QFQSMSD88H@arkamax.eu>
To: "Yi Zhang" <yi.zhang@redhat.com>, "Shinichiro Kawasaki"
 <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v7.0-rc1 kernel
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <aZ_-cH8euZLySxdD@shinmob>
 <CAHj4cs8mzSZez+n2qLu5931YAuQ4=RxNt6D6YJCsMEwGrm4UtA@mail.gmail.com>
In-Reply-To: <CAHj4cs8mzSZez+n2qLu5931YAuQ4=RxNt6D6YJCsMEwGrm4UtA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_003634_823389_A95AB9DD 
X-CRM114-Status: UNSURE (   8.73  )
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

On Wed Mar 11, 2026 at 1:35 AM CET, Yi Zhang wrote:
> On Thu, Feb 26, 2026 at 4:09=E2=80=AFPM Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
>>
>
> I also reproduced this kmemleak issue with the blktests nvme/rdma
> test. Here is the log:
>
> unreferenced object 0xffff8882e7545a40 (size 32):
>   comm "kworker/0:0H", pid 36658, jiffies 4303559899
>   hex dump (first 32 bytes):
>     02 81 aa 09 00 ea ff ff 00 00 00 00 00 10 00 00  ................
>     00 40 a0 6a 82 88 ff ff 00 10 00 00 00 00 00 00  .@.j............
>   backtrace (crc e5de3e0c):
>     __kmalloc_noprof+0x6f1/0xa10
>     sgl_alloc_order+0x9e/0x370
>     nvmet_req_alloc_sgls+0x294/0x4f0 [nvmet]
>     nvmet_rdma_map_sgl_keyed+0x25a/0x940 [nvmet_rdma]
>     nvmet_rdma_handle_command+0x1ed/0x4e0 [nvmet_rdma]
>     __ib_process_cq+0x139/0x4b0 [ib_core]
>     ib_cq_poll_work+0x4d/0x160 [ib_core]
>     process_one_work+0x8b1/0x15e0
>     worker_thread+0x5e9/0xfc0
>     kthread+0x36b/0x470
>     ret_from_fork+0x5bf/0x910
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xffff8882e7545280 (size 32):
>   comm "kworker/0:0H", pid 36658, jiffies 4303559900
>   hex dump (first 32 bytes):
>     02 2b 82 0b 00 ea ff ff 00 00 00 00 00 10 00 00  .+..............
>     00 c0 8a e0 82 88 ff ff 00 10 00 00 00 00 00 00  ................
>   backtrace (crc 42d20147):
>     __kmalloc_noprof+0x6f1/0xa10
>     sgl_alloc_order+0x9e/0x370
>     nvmet_req_alloc_sgls+0x294/0x4f0 [nvmet]
>     nvmet_rdma_map_sgl_keyed+0x25a/0x940 [nvmet_rdma]
>     nvmet_rdma_handle_command+0x1ed/0x4e0 [nvmet_rdma]
>     __ib_process_cq+0x139/0x4b0 [ib_core]
>     ib_cq_poll_work+0x4d/0x160 [ib_core]
>     process_one_work+0x8b1/0x15e0
>     worker_thread+0x5e9/0xfc0
>     kthread+0x36b/0x470
>     ret_from_fork+0x5bf/0x910
>     ret_from_fork_asm+0x1a/0x30

Maybe the problem is in the nvmet_rdma_map_sgl_keyed() function

static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
                struct nvme_keyed_sgl_desc *sgl, bool invalidate)
{
        u64 addr =3D le64_to_cpu(sgl->addr);
        u32 key =3D get_unaligned_le32(sgl->key);
        struct ib_sig_attrs sig_attrs;
        int ret;

        rsp->req.transfer_len =3D get_unaligned_le24(sgl->length);

        /* no data command? */
        if (!rsp->req.transfer_len)
                return 0;

        if (rsp->req.metadata_len)
                nvmet_rdma_set_sig_attrs(&rsp->req, &sig_attrs);

        ret =3D nvmet_req_alloc_sgls(&rsp->req);
        if (unlikely(ret < 0))
                goto error_out;

        ret =3D nvmet_rdma_rw_ctx_init(rsp, addr, key, &sig_attrs);
        if (unlikely(ret < 0))
                goto error_out;
        rsp->n_rdma +=3D ret;

        if (invalidate)
                rsp->invalidate_rkey =3D key;

        return 0;

error_out:
        rsp->req.transfer_len =3D 0;
        return NVME_SC_INTERNAL;
}

If nvmet_rdma_rw_ctx_init() fails, shouldn't it call
nvmet_req_free_sgls() before returning an error?

Maurizio


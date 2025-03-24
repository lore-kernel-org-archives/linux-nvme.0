Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A312C36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNq6jyyhFGEzQRVHAKOAb//fJgOIoxxfkvEDjEU0oAo=; b=xp3r+j6XHGQnp2RGrnwXMS5Kqv
	+WS5oOF5tIh1aIuXSTFDrN2mU1Q3LLIpB+/Wto5grMRMO/lJgofLFuW6pZbJaCH7h7wQEgYfiaCM5
	LQLoV++NP1AC9jij0qu5M9GLsJWUOqEa5eHI+otBpd+LsPWC8WY/iK9xD7OXwM13WQ8cBV3QULoMT
	qU8VyhcKRCifsFqGMQB7Y9iDq5l1lqkOStkDCUiusPTy0k44cQC0N9CMxvGFcm1KqTGTzHLOtD7aS
	T/yWGbmp0Rl+vuLydySxs58z3OuiNoa9FvRRVm/V0QOixDRQuDHYA6e8uXBAxhmzVan3b5Y993SYW
	Z2IFz9og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twfVK-00000002tRF-3G5S;
	Mon, 24 Mar 2025 10:58:02 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twfML-00000002sGz-2U8z
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:48:47 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 59e3081f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 11:48:40 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Mar 2025 11:48:39 +0100
Message-Id: <D8OFRDU1AVWC.1G6DIBZPLJ78@bsdbackstore.eu>
Cc: "Christoph Hellwig" <hch@lst.de>, <axboe@kernel.dk>,
 <linux-nvme@lists.infradead.org>, "Linux List Kernel Mailing"
 <linux-kernel@vger.kernel.org>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Subject: Re: 6.13/regression/bisected - new nvme timeout errors
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>, "Keith Busch"
 <kbusch@kernel.org>
X-Mailer: aerc
References: <CABXGCsMcxu3pCF8jYPeqF_jN34saBwc8Fci+c-Dg2Lh7rqvuFQ@mail.gmail.com> <Z8m9AbD3tjNpBt6p@kbusch-mbp> <CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaSJuCxQRO7cjPtgWg@mail.gmail.com>
In-Reply-To: <CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaSJuCxQRO7cjPtgWg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_034845_980028_6C010D10 
X-CRM114-Status: GOOD (  21.86  )
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

On Sun Mar 23, 2025 at 10:49 AM CET, Mikhail Gavrilov wrote:
> On Thu, Mar 6, 2025 at 8:19=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>>
>> >
>> >     nvme-pci: reverse request order in nvme_queue_rqs
>>
>> The patch here uses the order recieved to dispatch commands in
>> consequetive submission queue entries, which is supposed to be the
>> desired behavior for any device. I did some testing on mailine, and it
>> sure looks like the order the driver does this is optimal, so I'm not
>> sure what's going on with your observation.
>>
>> Do you have a scheduler enabled on your device?
>>
>> How are you generating IO? Is it a pattern I should be able to replicate
>> with 'fio'?
>
> Sorry for not answering for a long time, but all because I was testing
> the off-list patch that was sent to me by Maurizio Lombardi.
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 950289405ef2..990d9ef1eef9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -989,6 +989,9 @@ static void nvme_submit_cmds(struct nvme_queue
> *nvmeq, struct rq_list *rqlist)
>  {
>         struct request *req;
>
> +       if (rq_list_empty(rqlist))
> +               return;
> +
>         spin_lock(&nvmeq->sq_lock);
>         while ((req =3D rq_list_pop(rqlist))) {
>                 struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
>
> And I want to say right away that this patch solved my problem. I
> double checked, and both times the system worked for 4 days without
> errors:
>

Glad to hear it worked!

Keith, I think the problem here is simply that nvme_write_sq_db() ends up
being called even when the rqlist is empty and this couldn't happen before
the changes introduced by commit "nvme-pci: reverse request order in
nvme_queue_rqs".

If you say that this change makes sense I can submit a formal patch.

Maurizio


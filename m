Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575F606A31B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=leDEETIj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JXTSBkHb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2A1+00jvrnNf7fqGHqc8ys6TlCrlf1oE14AvYJeLS/c=; b=leDEETIjOHizlI
	WakIrvZfPUckV8P2Zoxw7m85pt9x7GQjOTXfvlgD5DFJF7uLxVlel8cejDh0WCYxuJ6SNHM0ZIClB
	8QUCMnmeKQFLCy08gTBBDxRBGMchNG5kfXDSJ1esL75al4cXww0Lk+/OPpsQ9JERaZh/h0uwcODpC
	/mYzgo/pgN/5IU5d9lfrQMg39f/hBNQnb8Zu2AiatDg02Qyx/1OE2tOgKvHvTopK5tAeKRXZhEOtD
	AnbvOQy8U3JlQ81J+p/5VwCq43E7keKImeBYzhStSvBZrl/75nfJ9yO5+mTVB1qIJ3/NfRimnaT1q
	f1DjnGR4FscSM1S8Kgtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOK4t-00000003Vuw-1HuD;
	Tue, 03 Nov 2026 19:21:51 +0000
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOK4p-00000003VuD-2Lsu
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:21:50 +0000
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-4e4a4d77e5bso703801b6e.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 11:21:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793733705; cv=none;
        d=google.com; s=arc-20260327;
        b=oX4XIUvY2Xv/aGzOWsgsl48eI5Miz96/E5HEYFH89HiezwfIgRXHFWQQXv6gX7Mfxj
         lZ6SSLI0caML3OrkQ8C3nBrY2oawuPB6CFCCnqO8EkD2dxZlEzxTzXPw1QmveOjByS/8
         dazWNv6xPw9RQw16qORKsI7PT3w1gmm6KBW7TyzzEJqM6cNTQZ3LuZWPF7wnV6wPmQTU
         vQLTTNgKuBTEolDiAkvvOLPSb3FwrQeLtQIP5qx4FcEy665QrN/D6DHw+HRsGT5WyvYP
         CpW5nDNOrCrhrpTwj9URTq7KnCYW+CvTXLm2c4YJzS4yuV55oMqokkkDrte9TkojQ2pY
         jQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2A1+00jvrnNf7fqGHqc8ys6TlCrlf1oE14AvYJeLS/c=;
        fh=5CQWocftCOfVxkAHdv7Zj8cbDq6Y7KNvT4XmDtLOuos=;
        b=frXIZzCjPUbfZCI5iRIOV24+wEU10+81v4S/BwNJUISLUevEJF03XXIBTz+Bonu8RV
         1fZOEV1F2Uy6nb45oB3l+9VkdfNdJFUY7K2gRsCFli9cb4h2sm/BrXX0S8oZJjU5qvEh
         FybxQ1Rb7VaBYQB525Xirz8zBiVL41G/XzpTTMCZJm6Oq/zhkc8e84mzdal0BnphxD23
         oZUB/Kv4VIbfT4huS9HEom57Q6M2htieGNBD2XcTDYQe4XqKrdOZ9Gd/qrvOVEScVjqs
         hqu+bX/YvXzyG43041NMfYdIPbxL+j0Hhl6x1gVi1NCHtQLCIgJh7sITrUVgEN45SMzV
         rEdQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793733705; x=1794338505; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2A1+00jvrnNf7fqGHqc8ys6TlCrlf1oE14AvYJeLS/c=;
        b=JXTSBkHbOm5yro+blfIM1xYcC2wEwi2Lpaq6etMxZ13mfIjlG8KNxfIyzfjh+O7+Om
         OpoXHU+s5PU1n/wEQSs0QtGVFyTeNU7WnvCE0MnL+kOU+J5eqeCYzEUxBQ76YqF6yVsX
         Q+y5aZHWwSaGTZ88FLrAWemazfu1TE0xwtMSPyZQE7T/LOY045vZ7QswRfyKYwYKMDOO
         0HR+1M8fw4CXhrtNnsX9p85Qh7uDisb3JPs3irSm4qg/w7yCt80gkFlYv9Bifhzg+EeQ
         G0PO8bBkeSsKTxygisqd/ZLN63VpUm3ncFw7rebcoMr8Tx1F6ZZ5sg9FfIMOkEOqvklW
         0drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793733705; x=1794338505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2A1+00jvrnNf7fqGHqc8ys6TlCrlf1oE14AvYJeLS/c=;
        b=KVqY19WH0XAvSR7aihX+vUMm3cZhXE81M8Wu345sipvrRvlUbeg+btslcctfy+YaM5
         Fxqk5lzxGbTpYY+OlGcTRQnfUHWn0h4uMmtAsCT+LMuOYvyAQ9Gx8Qtcr5sk0On89+co
         gcXt4xc7MetgOWJ3ZkU83sk4efrIBw4ob2Y+BKACxk8t6SU9b+vFtdnWHordQL7OvVlH
         x+N3ud7t/QH2cHsPefXH9SAltwxh3tX4eQBZHvDKMnLwSd19/gnEoaCvgmY8HEnT08e2
         RBKbcZQe+nqLIcHOOkd4f7xmepVLHw9mul/t44Ajs6ktFxPXza75fsEOJrjKYUbce6aH
         R55A==
X-Forwarded-Encrypted: i=1; AKwUvBxcjU1w5l6JyxKl+E5TzR02hD7FG1qLu/DUILUBIPr2CR5Pi2ilvLJidDEo4di9azflVBxMFMMfykP+@lists.infradead.org
X-Gm-Message-State: APuU4Z/IzEfT+FL5iJJnz+ZRtab5+2fAI8jePborJAwo+6qbOf9PiKaa
	g4Lp/eRS+c7dFh4vZCOIzae3lPL6UykW/rZp2wyKQHZBp+Q+n+uSCwzNma1WNyhgf0T3yy5VRGj
	zwkl7Um034WWgUquA2c8rfmq4hACqmJ0=
X-Gm-Gg: AYBFou1lawEtqfPB9PmokIQFEv5+8uNuDrWO6+4FrE7ZCdmi2XHY9Im9D0lUHSGIhK+
	0i1moW18mxOlbQ1rtdd8Y+FNxLwTEgnXFhchhWMgQZxBPlOQfa2b2jyF6aWPril+Qmy15D9uBV2
	ef6AkUi7b3PzwdFTJc4EyAmv9eUBOrn/4tnWgOAf2HQKzqA5LNzuTqTYdiraPRBY9iFFCoGiU//
	X9A0tugN/nN1jITEqaLv6Ea4tTi+Geecm+D4OA6U8oZiHGpubshfVXDnBXAtHBd85aNaiQkL0+J
	mEqmCSVjKwbghWW7zhT53g1UUEA43qumsHMN0fqGQ8WG6hOLZ1XQ1i3L5gCVhYdrdu9mcUE/qIG
	tVfagQrBnw0gsE0HJjOTTnwcn+fZ5yjsNr9s7
X-Received: by 2002:a05:6808:4f13:b0:53a:1c29:cb37 with SMTP id
 5614622812f47-563efbabc76mr8210157b6e.38.1793733705389; Tue, 03 Nov 2026
 11:21:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
In-Reply-To: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
From: K <coshi036@gmail.com>
Date: Tue, 3 Nov 2026 14:21:31 -0500
X-Gm-Features: AclHuK82vppXzIrwdOK2yIIRwoykiWBsd13OjY3_tJWGGEeLsCKM7ty2jD_EoBQ
Message-ID: <CACd_6n03YaDPrJgD6EB=bHoN+sQ=aCH0XvPfpdkm_68WpPMqJw@mail.gmail.com>
Subject: Re: [PATCH] nvme: reject completions for requests that are not in flight
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, kernel-dev@igalia.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_112147_608905_80D11757 
X-CRM114-Status: GOOD (  36.97  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks, pls let me take a look, it looks like all AI generated. May I
know what kind of test you run or LLM run?

Regards,
Chao

On Tue, Nov 3, 2026 at 2:17=E2=80=AFPM Mauricio Faria de Oliveira
<mfo@igalia.com> wrote:
>
> From: Chao Shi <coshi036@gmail.com>
>
> There are a few kernel crash reports from the Steam Deck where incorrect
> completions received by the nvme driver have a command id/tag associated
> with a freed request (rq->mq_hctx =3D NULL), dereferencing a NULL pointer=
.
>
>   nvme_handle_cqe()
>   -> nvme_try_complete_req(req, ...)
>      -> blk_mq_complete_request_remote(req)
>         -> if ((rq->mq_hctx->nr_ctx =3D=3D 1 &&   /* Oops! */
>
> Although the usual suspect is the nvme device firmware, one report shows
> incorrect completions also received by the ath11k wireless driver at the
> same time, which suggests the underlying issue might be something else.
>
>   [ 2585.223155] ath11k_pci 0000:03:00.0: tx completion for unknown msdu_=
id 0
>   [ 2585.223163] ath11k_pci 0000:03:00.0: tx completion for unknown msdu_=
id 0
>   ...
>   [ 2585.228077] nvme nvme0: request 0xec genctr mismatch (got 0x2 expect=
ed 0xa)
>   [ 2585.228079] nvme nvme0: invalid id 8428 completed on queue 3
>   [ 2585.228205] nvme nvme0: request 0xe2 genctr mismatch (got 0xe expect=
ed 0x2)
>   [ 2585.228208] nvme nvme0: invalid id 57570 completed on queue 3
>   ...
>   [ 2585.228726] BUG: kernel NULL pointer dereference, address: 000000000=
00000fe
>   ...
>   [ 2585.228752] RIP: 0010:blk_mq_complete_request_remote+0x1c/0x160
>   ...
>   [ 2585.228787] Call Trace:
>   [ 2585.228790]  <IRQ>
>   [ 2585.228828]  nvme_poll_cq+0x14b/0x300
>   [ 2585.228838]  nvme_irq+0x41/0x80
>   [ 2585.228845]  __handle_irq_event_percpu+0x4a/0x180
>   [ 2585.228850]  handle_irq_event+0x38/0x90
>   [ 2585.228853]  handle_edge_irq+0x8b/0x230
>   [ 2585.228858]  __common_interrupt+0x3e/0x90
>   [ 2585.228862]  common_interrupt+0x80/0xa0
>   [ 2585.228866]  </IRQ>
>   [ 2585.228868]  <TASK>
>   ...
>
> However, even when the nvme device firmware is at fault and need an updat=
e,
> it is interesting for the kernel not to crash, so that it is even possibl=
e
> to run the firmware update where the issue happens frequently or early on=
,
> and while waiting for the update to be made available by the device vendo=
r.
>
> The fix is to check that a request is actually in-flight before completin=
g
> it. This has been previously reported and proposed by Chao Shi, found wit=
h
> fuzzing, but without further feedback since July. I happened to learn of =
it
> only after root-cause analysis and reaching a similar conclusion, checkin=
g
> for prior work/feedback, thus keeping them as Author/Signed-off-by, addin=
g
> myself as Co-developed-by for the commit message and root cause analysis.
>
> In Chao Shi's patch, there's been feedback/question of whether this shoul=
d
> be done in blk-mq, as this is not specific to nvme. I'd say no, at first:
> - Some blk-mq calls for completion have no return value (e.g., completion
>   on other CPUs), which suggests maybe an API change and updates to many
>   callers, all for an edge case.
> - An alternative available currently might be blk_mq_ops.complete(), but
>   that is handled in the driver anyway, with risk of hitting an error in
>   blk-mq (like this) as the code changes, and seems semantically wrong,
>   i.e., completing a request that should not have been completed.
> - Keeping in mind a small fix for stable, for now, should this be merged.
> - But happy to take suggestions if blk-mq is indeed the way to go.
>
> This has been tested with a synthetic reproducer produced by an LLM.
>
> Originally-by: Chao Shi <coshi036@gmail.com>
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> Link: https://lore.kernel.org/linux-nvme/20260522153034.2168862-1-coshi03=
6@gmail.com/
> Link: https://lore.kernel.org/linux-nvme/20260715005105.1115958-1-coshi03=
6@gmail.com/
> Co-developed-by: Mauricio Faria de Oliveira <mfo@igalia.com>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
> ---
>  drivers/nvme/host/nvme.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2d8f681079e85601a92624d196e77f1ba3ace34a..3ba0666da7be6a3de2e5f0fd5=
0155af115b4e1f6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -708,6 +708,11 @@ static inline struct request *nvme_find_rq(struct bl=
k_mq_tags *tags,
>                         tag, genctr, nvme_genctr_mask(nvme_req(rq)->genct=
r));
>                 return NULL;
>         }
> +       if (unlikely(blk_mq_rq_state(rq) !=3D MQ_RQ_IN_FLIGHT)) {
> +               dev_err(nvme_req(rq)->ctrl->device,
> +                       "completion for request %#x not in flight\n", tag=
);
> +               return NULL;
> +       }
>         return rq;
>  }
>
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-nvme-double-cmpl-uaf-blk-mq-e3d28f74cdaf
>
> Best regards,
> --
> Mauricio Faria de Oliveira <mfo@igalia.com>
>


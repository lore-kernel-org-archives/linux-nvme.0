Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37C5F46C76
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2026 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmRqNSjoQ6HmN96H9YNTUi3Ybw54x0ujPHGqFzaEd9A=; b=TpxEJjor7uxMkZi24sNYRAXKBn
	gtUyTzhU3ElS4D0dOcZkOU2PFRgK04uPV4gBCBI+g35QA9KWVPREefzlTb8u1DfJUtfNFz/IHP2ZJ
	rU7rMhYtB7TYZNMVue7qoXsWv038c6T8WIE+DT9+NpPFfmHfxwqOK8+2x55ewG1dF0E3ZQDLTK8x3
	U+DErLwM/+qaqIDT+Gd2hW1f5xwDcXnB7tarxOyJ3asnAtn6pW5AnWjWt49xu2YJ/2DKljhfU6hBT
	inQrt/Hd7w7ghQwpMmfy7PwRLT5IqRVnrIC2M5sfoMmBx5+3vfv4MD7c5XaW9jU1L2+RGRm425SDi
	Q0e8Cu0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9pa5-00000005S7v-3xgi;
	Mon, 06 Apr 2026 19:25:53 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9pa3-00000005S7B-2WkO
	for linux-nvme@lists.infradead.org;
	Mon, 06 Apr 2026 19:25:52 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-43b983bb07eso2423968f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2026 12:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775503550; cv=none;
        d=google.com; s=arc-20240605;
        b=c51w2/ZDzeKMlzN33LVEdbAuwvrYGmvnTRMMP2Kas1/Vny9XzcKWqFdx+aEAj+0jdn
         6t90U3ELkjekk+Kc4+cW62vA6f+RqzH/u2tmu7Yh4FS0+lxTP7JXY5KPwPjvdv8vb5XR
         vcOkr1iPAb+btQnuiJ/BrrLiVbpUlSkzctsHzWMkCejIVSTsOAKNSDyRUwvJ6tccS6iv
         Om0iEx1SRyBMHLuZzNQjzDOSjAOa49/+402NLgCfqPgeRIam/6r/Rqgihz2wmva38+Jm
         7lsOuNz1bBBfhck/2UizEDvzg3t7v0M+uG94gJ00swWsv0NuPzIWC2pZtqzRh+/sIqul
         bdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mmRqNSjoQ6HmN96H9YNTUi3Ybw54x0ujPHGqFzaEd9A=;
        fh=BPZvehKtNikTlRdhvPKPb1An1yH4PVVMiOubb1WKWSM=;
        b=NMYfOW/OYLTQ4U2Focp0NeY54ezWxAJYrOQuWKKQQuiNrIMMH0lIX2p45tQ0VihFHc
         q762TLoblbcQiA0462Lmwj2DvfDKvGYoIJFRkArkYD4ZP3JZtwoqEIk6m4lI2xhszTr/
         mxOfsuyxj5FHIzcJm/8KG9vADL6lxOZi/XchDgBV/FkJnHp3OR+QU66CVNE8RcX7hz5L
         d+KirayE6h/26oPx4T4PMejbax6dsmPTJGa2l6Xwtu2ZnXqO+lj6YfkaApAIIJqzSAfR
         b24Ne8Na6t8YWVfkpzr4uMWUFx3PTJqy6q+bY3VIu6SNxMyCYGUViYa01x2Klm7mLuRB
         aAfQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775503550; x=1776108350; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmRqNSjoQ6HmN96H9YNTUi3Ybw54x0ujPHGqFzaEd9A=;
        b=no+M3a3+aTcGTZHgqVUFhrRcpu0TZYae7GF+kCUY4mr3z8NR772oVqVE9oczinE0kK
         bLI21G5yP6eP2g4ti7U8TIzhqk5BbDMs6zu2i0oWjHvpvivvto3Nugej2AOTrZOhS1hQ
         ZjNLoXdbnVVbkptKd2jjCVGFhYUH//YFhhuwKB9Ha4beMF8LmqgVHd6cJ3OCBMTfQ8W4
         7/7uCZm1XENYTqcY2bWrFEmXeFiZAhidbskFJtw04dU/FXsAjoemlZPD1oJe4GJUFpU6
         aRZ6Bseu1qvX9O3hSwp3AE1F0qmuKjyP/Sf9TNzHWFMXcA0++pPfIp+dIU7AWn3VVwoq
         VI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775503550; x=1776108350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mmRqNSjoQ6HmN96H9YNTUi3Ybw54x0ujPHGqFzaEd9A=;
        b=TIOwQKn3c4elipMsMnVEEGUnF8jFofFV5u3HWnWR40xf5y3NpuEAY3SxIM4Mc0jqNk
         mE5Ds68cz5uzbjEi+m0TJWbPOr2HCOtQzNd3gVxpQJT7opem41Zoa460Y/YdyvyX36Tm
         aLYOZecG7p4bxwLhk0YeVj6ti6ThI/lLZMzUbYXHflG1ti77q5zzsQ6mx8UVGeAO0hYt
         ZVP0A1T7tK0tiYkbEddVHl0L1xa3U1kpkSknUIFMy0cXRO/GTbNaSkDEhg+7pGmXFxBm
         M4SCaIW7Xn7UMAPc3DpsIRP0jkrKAGj+cjP+liAVLiKNgaIxN7UbVOkUJ9qbRL6pGKiF
         Z5aA==
X-Forwarded-Encrypted: i=1; AJvYcCWKIIf58WmT2O/rbEIS1ETbNrzZjNodPftTbhlkfp4LgBJHtNys6jb27r7IZaRBh/KUM7DPfDCazWof@lists.infradead.org
X-Gm-Message-State: AOJu0YymSiTJK88S6zN5qrH2UmukrCvKOgxZ3KSAJ/68UHAUjog/7mag
	y76fgc74aXdAOi/3woQSDYMZ979F1wzgLEMoIiz2l4DCQh07jXs44zWaUqQTplKnS5MV83EPAy2
	5tgliL7qNvXcnyViF4LriP1hqVkMEoVY=
X-Gm-Gg: AeBDies87RUTn3oXnRiP8BcYRi2O+TWsKnzWHTzg6tFabk/EZETaCuIVNuAjvVimmPl
	rHOMD6D9nBqcnGospfJSjSDFtmwiBDAHqkYNqaTIbVRI5eezlQYCQWkrBeo8bu1kdK1dnYRALzG
	BugojxBWwDUPfFi490KeWxYVeJdG0HlApG1MNo2yXQI2d+4PRIrEq4h17HFW+iQhnW37Gbd+1Nj
	JMlfHikJ3AxIKgmpNzJFqFGko8kMVNEepQ8J/z68m5zrOVKJNwBfkN/L2ppl/Ul/UdDC1BZXQPT
	fap3b04=
X-Received: by 2002:a05:6000:188e:b0:43d:4c:22a5 with SMTP id
 ffacd0b85a97d-43d292ff507mr20291458f8f.40.1775503549308; Mon, 06 Apr 2026
 12:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ysrS+QrbGfOLk=e0=PZ-py-KO_xZgn827nEg7mh7hGhdUAAw@mail.gmail.com>
 <2026031827-carving-overdrawn-5b1f@gregkh> <CA+ysrSLcSJSgEC7i0GYXPiRY9sbbyEGT60Nh1SJ6PqXWENgSOw@mail.gmail.com>
 <CA+ysrSL+3YVGvTKhJ=jL92XZPwjoDpt5D2BK-HeCU975vO-fCQ@mail.gmail.com>
 <CA+ysrSJQ2tDiB=zL+GwF=ckhmO62v6GC2bWVUVVDVn7d8Km1mw@mail.gmail.com>
 <27f3f1b4-5f27-41d6-aa5e-646e5f3ce1e9@nvidia.com> <CA+ysrSLqMrw0wY8WGcfCxTi=G54v4Gg-jUcEvkw5tyr6J7cLWg@mail.gmail.com>
 <e39c9bfa-6b53-4517-a00f-f0068ef0b290@nvidia.com>
In-Reply-To: <e39c9bfa-6b53-4517-a00f-f0068ef0b290@nvidia.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 6 Apr 2026 15:25:37 -0400
X-Gm-Features: AQROBzDKDoPUULv-3rUwL9ZmwglK73tM2pAVWwCQ1SqsB6jf1K0X8xnz_4-a4X0
Message-ID: <CA+ysrSL_cRe4z6ey+W+LodVF-HXSg8jifGa_wLD3sHT2PLoMDQ@mail.gmail.com>
Subject: Re: [Bug Report] nvmet-tcp: unbalanced percpu_ref_put on data digest
 error after nvmet_req_init failure causes refcount underflow, use-after-free,
 and permanent workqueue deadlock
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "security@kernel.org" <security@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_122551_747280_81EC28F8 
X-CRM114-Status: GOOD (  41.88  )
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

On Mon, Apr 6, 2026 at 12:24=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> Shivam,
>
>
> On 4/5/26 12:55, Shivam Kumar wrote:
> > Hi all,
> >
> > Just following up on this report. Please let me know if there are any
> > questions about the analysis or if any additional information would be
> > helpful.
> >
> > Thanks,
> > Shivam Kumar
> >
> > On Wed, Mar 25, 2026 at 12:29=E2=80=AFAM Chaitanya Kulkarni
> > <chaitanyak@nvidia.com> wrote:
> >> +linux-nvme list as well.
> >>
> >> On 3/24/26 21:22, Shivam Kumar wrote:
> >>> Hi Greg, Christoph, Sagi, Chaitanya
> >>>
> >>> Following up on my previous report (percpu_ref underflow in
> >>> nvmet_tcp_try_recv_ddgst). During testing with the percpu_ref patch
> >>> applied, I identified a separate vulnerability triggered by the same
> >>> PoC. This one affects the queue kref (not the SQ percpu_ref) and has =
a
> >>> different root cause.
> >>>
> >>> # Bug Overview
> >>>
> >>> nvmet_tcp_handle_icreq() sets queue->state =3D NVMET_TCP_Q_LIVE witho=
ut
> >>> holding state_lock and without checking whether teardown has already
> >>> started. When a client closes the connection immediately after sendin=
g
> >>> an ICReq and a malformed CapsuleCmd, the FIN can arrive and be
> >>> processed before io_work reads the ICReq from the socket buffer. The
> >>> FIN handler sets queue->state =3D NVMET_TCP_Q_DISCONNECTING and calls
> >>> kref_put (1->0). Then io_work processes the ICReq and handle_icreq
> >>> blindly overwrites the state back to NVMET_TCP_Q_LIVE. This defeats
> >>> the guard in nvmet_tcp_schedule_release_queue(), which relies on stat=
e
> >>> =3D=3D NVMET_TCP_Q_DISCONNECTING to prevent a second kref_put.
> >>>
> >>> When the subsequent digest error triggers nvmet_tcp_fatal_error() ->
> >>> kernel_sock_shutdown(), the socket teardown synchronously processes
> >>> any pending TCP packets in the socket backlog via release_sock() ->
> >>> tcp_done() -> nvmet_tcp_state_change() ->
> >>> nvmet_tcp_schedule_release_queue(). Because the state was overwritten
> >>> to LIVE, the guard passes and kref_put is called on an already-zero
> >>> kref, triggering the underflow.
> >>>
> >>> # Root Cause
> >>>
> >>> The vulnerable code in nvmet_tcp_handle_icreq() (tcp.c):
> >>>
> >>> queue->state =3D NVMET_TCP_Q_LIVE;
> >>> nvmet_prepare_receive_pdu(queue);
> >>> return 0;
> >>>
> >>> This state transition is not protected by state_lock and does not
> >>> check the current state. All other state transitions to
> >>> NVMET_TCP_Q_DISCONNECTING in nvmet_tcp_schedule_release_queue() are
> >>> protected by the spinlock, but handle_icreq bypasses this
> >>> synchronization entirely.
> >>>
> >>> # Race Sequence
> >>>
> >>> The PoC sends ICReq + CapsuleCmd + close() in rapid succession. On th=
e wire:
> >>>
> >>> [TCP handshake] -> [ICReq] -> [CapsuleCmd] -> [FIN]
> >>>
> >>> All data arrives in order in the socket buffer, but the FIN triggers
> >>> a TCP state change callback (softirq context) that races with io_work
> >>> (process context) reading the application data.
> >>>
> >>> # ftrace evidence (queue 29)
> >>>
> >>> Step 1: FIN arrives, teardown begins (softirq context):
> >>>
> >>> kworker/-74 1b..2. 125826488us : nvmet_tcp_state_change: DEBUG queue
> >>> 29: In schedule_release before checking state variable state is 0,
> >>> kref=3D1, caller=3Dtcp_fin+0x278/0x4f0
> >>> kworker/-74 1b..2. 125826492us : nvmet_tcp_state_change: DEBUG queue
> >>> 29: kref_put in schedule_release state changed to 3, kref=3D1,
> >>> caller=3Dtcp_fin+0x278/0x4f0
> >>>
> >>> State transitions from CONNECTING(0) to DISCONNECTING(3), kref decrem=
ented 1->0.
> >>>
> >>> Step 2: io_work processes ICReq, overwrites state (process context):
> >>>
> >>> kworker/-74 1..... 125826529us : nvmet_tcp_try_recv_pdu: DEBUG queue
> >>> 29: Inside nvmet_tcp_handle_icreq_pdu before changing state is 3,
> >>> kref=3D0, caller=3Dnvmet_tcp_io_work+0x12b/0x1fc0
> >>> kworker/-74 1..... 125826532us : nvmet_tcp_try_recv_pdu: DEBUG queue
> >>> 29: Inside nvmet_tcp_handle_icreq_pdu after changing state is 2,
> >>> kref=3D0, caller=3Dnvmet_tcp_io_work+0x12b/0x1fc0
> >>>
> >>> handle_icreq see's state=3DDISCONNECTING(3) but overwrites it to LIVE=
(2)
> >>> without holding state_lock. kref is already 0.
> >>>
> >>> Step 3: Digest error triggers fatal_error -> kernel_sock_shutdown
> >>> (process context):
> >>>
> >>> kworker/-74 1..... 125831291us : nvmet_tcp_fatal_error: DEBUG queue
> >>> 29: fatal_error, state=3D2, ctrl=3D0000000000000000,
> >>> caller=3Dnvmet_tcp_try_recv_ddgst+0x74f/0x9a0
> >>>
> >>> Step 4: kernel_sock_shutdown -> release_sock processes backlog -> tcp=
_done
> >>> re-enters state_change, guard bypassed because state is LIVE(2):
> >>>
> >>> kworker/-74 1b..2. 125831626us : nvmet_tcp_state_change: DEBUG queue
> >>> 29: In schedule_release before checking state variable state is 2,
> >>> kref=3D0, caller=3Dtcp_done+0x1d7/0x350
> >>> kworker/-74 1b..2. 125831629us : nvmet_tcp_state_change: DEBUG queue
> >>> 29: kref_put in schedule_release state changed to 3, kref=3D0,
> >>> caller=3Dtcp_done+0x1d7/0x350
> >>>
> >>> schedule_release_queue see's state=3DLIVE(2), guard passes,
> >>> kref_put called on kref=3D0 -> underflow -> CRASH.
> >>>
> >>> The critical evidence is Step 2: handle_icreq reads state=3D3(DISCONN=
ECTING)
> >>> and writes state=3D2(LIVE) =E2=80=94 proving the unsynchronized overw=
rite.
> >>>
> >>> # Additional Observation: Double fatal_error Call
> >>>
> >>> The ftrace also shows that fatal_error is called twice per error: onc=
e
> >>> from nvmet_tcp_try_recv_ddgst (digest mismatch) and again from
> >>> nvmet_tcp_socket_error in nvmet_tcp_io_work (propagated error return)=
.
> >>> Both calls invoke kernel_sock_shutdown, doubling the window for the
> >>> reentrant state_change.
> >>>
> >>> # Crash Trace (with percpu_ref patch applied)
> >>>
> >>> refcount_t: underflow; use-after-free.
> >>> WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xc5/0x110
> >>> Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> >>> Call Trace:
> >>> <TASK>
> >>> nvmet_tcp_state_change+0x3e6/0x470
> >>> tcp_done+0x1d7/0x350
> >>> tcp_rcv_state_process+0x392c/0x6d80
> >>> tcp_v4_do_rcv+0x1b1/0xa80
> >>> __release_sock+0x2ab/0x340
> >>> release_sock+0x58/0x1c0
> >>> inet_shutdown+0x1f6/0x3c0
> >>> nvmet_tcp_fatal_error+0x13c/0x1c0
> >>> nvmet_tcp_try_recv_ddgst+0x74f/0x9a0
> >>> nvmet_tcp_io_work+0xd43/0x1fc0
> >>> process_one_work+0x8cf/0x1a40
> >>>
> >>> # Affected Code
> >>>
> >>> - Subsystem: drivers/nvme/target/tcp.c
> >>> - Function: nvmet_tcp_handle_icreq()
> >>> - Tested on: Linux 7.0-rc3
> >>>
> >>> # Suggested Fix Direction
> >>>
> >>> The state transition in nvmet_tcp_handle_icreq() needs to be
> >>> synchronized under state_lock with a check for
> >>> NVMET_TCP_Q_DISCONNECTING. If the queue is already tearing down,
> >>> handle_icreq should not set the state to LIVE and should stop
> >>> processing. I'll defer to you on the exact error handling semantics
> >>> (return value and cleanup path).
> >>>
> >>> This bug is independent of the percpu_ref underflow in the previous
> >>> report. The percpu_ref patch fixes the SQ refcount underflow; this bu=
g
> >>> affects the queue kref through an unsynchronized state transition.
> >>>
> >>> I am available for further discussion and testing.
> >>>
> >>> Thanks,
> >>> Shivam Kumar
> >>> PhD Student, Computer Science
> >>> SYNE Lab, Syracuse University
> >>> skumar47@syr.edu
> >> I'll try to have a look at this over the weekend.
> >>
> >> -ck
> >>
> >>
> Let's avoid top posting. Sorry for the delay.
>
> Can the following patch fix the ref count underflow issue ?
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 4b8b02341ddc..69e971b179ae 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1310,7 +1310,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tc=
p_queue *queue)
>                         queue->idx, cmd->req.cmd->common.command_id,
>                         queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_dd=
gst),
>                         le32_to_cpu(cmd->exp_ddgst));
> -               nvmet_req_uninit(&cmd->req);
> +               if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +                       nvmet_req_uninit(&cmd->req);
>                 nvmet_tcp_free_cmd_buffers(cmd);
>                 nvmet_tcp_fatal_error(queue);
>                 ret =3D -EPROTO;
> --
> 2.39.5
>
> and something like following can fix the race between ICReq handling
> and queue teardown ?
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 69e971b179ae..5c03a6505319 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -408,6 +408,8 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_qu=
eue *queue)
>   static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int s=
tatus)
>   {
>         queue->rcv_state =3D NVMET_TCP_RECV_ERR;
> +       if (status =3D=3D -ESHUTDOWN)
> +               return;
>         if (status =3D=3D -EPIPE || status =3D=3D -ECONNRESET)
>                 kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>         else
> @@ -922,11 +924,21 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_=
queue *queue)
>         iov.iov_len =3D sizeof(*icresp);
>         ret =3D kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>         if (ret < 0) {
> -               queue->state =3D NVMET_TCP_Q_FAILED;
> +               spin_lock_bh(&queue->state_lock);
> +               if (queue->state !=3D NVMET_TCP_Q_DISCONNECTING)
> +                       queue->state =3D NVMET_TCP_Q_FAILED;
> +               spin_unlock_bh(&queue->state_lock);
>                 return ret; /* queue removal will cleanup */
>         }
>
> +       spin_lock_bh(&queue->state_lock);
> +       if (queue->state =3D=3D NVMET_TCP_Q_DISCONNECTING) {
> +               spin_unlock_bh(&queue->state_lock);
> +               /* Tell nvmet_tcp_socket_error() teardown is already in p=
rogress. */
> +               return -ESHUTDOWN;
> +       }
>         queue->state =3D NVMET_TCP_Q_LIVE;
> +       spin_unlock_bh(&queue->state_lock);
>         nvmet_prepare_receive_pdu(queue);
>         return 0;
>   }
> --
> 2.39.5
>
>
> -ck
>
>

Hi Chaitanya

I tested both the patches; these patches fix both the crash paths.

Patch 1 is the same fix I sent earlier, which has Christoph's Reviewed-by.

Tested-by: Shivam Kumar<kumar.shivam43666@gmail.com>

Thanks,
Shivam Kumar


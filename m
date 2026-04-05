Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A2FE9D80D
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sFImrzcAZ+IKqXfGdMJm+cF+3eLOpl4Q3uZEkUAcKmQ=; b=S96+N6LwlCZ4qjhLdWpdOoYl6v
	ycFsJrw3h8EQzyck94LM2yljTcNImVYOvMzILJQ1h8NESTDaKF+SPUVxMOt4zxWIbCZP6LsNS0Tc7
	7jLKXuC8dsHZRFpEzUyHDdbaFs/4nqDyTAuAgmzjCkWCnutRHJcvdojqU5EKAlohVRPCLIYJwZCne
	yKbNI6pPkYyVe5YjvrWEtzg6hpJ7VINhws5UvTiWqn1BKUVPsalxTlgWvHYpkcrSLcqIyHTVeuxnY
	SihYC7kCWUxDvnbEz8KEYJ3xsaJP6jShnFaJtHcCDyOPgTfWWB2zHOXewtRCQ6BWbyLSPM/btbNpK
	p1AV+7nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9TZH-00000004S0Y-1yGF;
	Sun, 05 Apr 2026 19:55:35 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9TZE-00000004RzU-3GRV
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 19:55:33 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-43cfb723698so3064991f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 12:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775418931; cv=none;
        d=google.com; s=arc-20240605;
        b=W7+4vSgO0PbP/JhUXk+a7Ay7TFUFHHRmwut1IJC+leIK9urNX8on2hfp4admJDVIrt
         W31gD2QCeMcl1fxNrkA1u9LIudOxKUYRAHRmyx22qtJbyCM+ZJBLZpPNnbiwl0SIYSkH
         2tkokiKyCP+hdt0IfzLFouaYX7n7YcOZKSLdhmPw205+tbpkr1X9XqIcMNrdLW8fkOXl
         XcDIpZNDdGiOp+ih7Z/BDSD1/UhcZAZpv+OHc8jjVi/iEL3gLCE5jMAAPrZ6ClMDQ1vm
         eG/uEdF2mXOVEdX6vND3Z9c7e9EFkW75dJD5zx1bzs/Sw84AAEaCM8xsNrzHHDQ67P72
         EqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sFImrzcAZ+IKqXfGdMJm+cF+3eLOpl4Q3uZEkUAcKmQ=;
        fh=O/nZ0pyd38lZ9QHMd6Z3dsj+P2NycQPnCCqM/tqfeik=;
        b=Ra5GhNdXcr7FHeHQTBdUCmVUyeHCy6ovP45dWLlhuY1YNTBwH7GKnkpmXJ/ZN/Rzm7
         xZnk4jXsWbC0htdKZmPX1DAzsabY3ccPxD0S/PxUYQDIuk1fy9dQeKQQwQcLCAHmhddk
         pSUyDIUXzcydPCeYt0tvBHepIErm4CXvXn4/WeyPIa+DhW7r0a++MPDjZTNAeK00FM1D
         SRgYPUKEXk4UXccoo42Lk2prKo+90uc4u5WLoVUlBHmSULln+/ZSH+ZKOHVFoqJNQ+cp
         Aw9kn9hhRa0DEGdNIsVuG5etzkMte0RQ2ukZMUT5rkYYAGK9FMy2HMQh0+w/JmhZSxcE
         nQeg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775418931; x=1776023731; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFImrzcAZ+IKqXfGdMJm+cF+3eLOpl4Q3uZEkUAcKmQ=;
        b=hS1TphYVOi3TY325GgGnuHcdkDPi6vuAiIIklpaV8uuWlIf48AnGaFzfuu5EREaxBT
         nqrps0umrCfHeklcGnhJBVa6VME1U7U9dhUMaLXb+wT7rZIG8k4VskeeMYiks+j8lQpE
         VXg+nNWXpPFwsaBqN1D+/Pgj8JUdQ/Cy5kOFoPr9wCMlr5oi8XtIJHe6ync4alDlcD+r
         d94X0QeHd66dKoMoD1/nqu4wqOOAGoGVTJNGxbms2yr3xUGt+ksNL2ZCa0H47hYYD2Jz
         MDXpcDg2ocw0mLPlqdcId8bLRzvbGcilXf0dObYHdlzVVdyyyYBqLrwuxTuf3LSn/xM8
         pCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775418931; x=1776023731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sFImrzcAZ+IKqXfGdMJm+cF+3eLOpl4Q3uZEkUAcKmQ=;
        b=qPX+SfYeCVdZ9nH0JqRWZIswMvq0irKogRDLHSPAk7dvscmSAaq/lZ8s7G5ctKrY25
         5bOc8Ng/K+1wTPn7/aU3+oUdOrEWiB8FK8TlCzphI/V/2HKF6c+g1sIjlfH/23jpwFiu
         bquoLedLzsTPWaAw/9jTpENirz6c++rFI0p7hSg9lNeOWmb0rD7IOd3O9Ovk3mxPAFLk
         pI6bu1Num2rtFPAqf7dtzhWzpHERYYR7ekhQ71uu0T/soE2mcFr8Dz3GQqYHPDZI5big
         rBv3cacgOxbIInxS8Jd75EcY00ppCcLto8xFlG2giKoh+UhQ+0iRKc9MrlVz89/+Nl47
         qsuw==
X-Forwarded-Encrypted: i=1; AJvYcCUo/0QlzwkpuCcYvtM9sroc/ZwbiyBVCWnYPY4A12p+ol1MWKEEK8cvWh3OaTizheq/UqDkcwkf5BY6@lists.infradead.org
X-Gm-Message-State: AOJu0Ywdw43NV9au4dKIBb2utDTaMm3UpMDix0QyhHwam93wz6eENWDm
	xQufXqPDc5uk3hg7KJhSqxAhNVk7Wt4+jihyxXveRkfHksG3RvJQS5EaR+lEefzGcVK2wY9EtK5
	T1F1ypxwRq26k+9YgIYXhd5KRn/bMrmg=
X-Gm-Gg: AeBDieso0XGg8gRnLgWKS7v7M2K5XjM42LxTEHesxOAANEpzV0e49ie4Yuh+ZtXrYNO
	V3GvG2bdrGVxLeUBbYS2A0j9dR/7o7FPVEkiVysaf7fUHQCWq96L3taVIa/3OvlfhIifEPLtUzE
	N8FrMct7qE6uWRxQ3bMafor34ALDwl87G692ONgxDULZRIuvkr9bOuwFVcYQ0xAqjvDI45b1UNE
	ux8dN3QHcx2nT+/OnOcjhRuF0Bu5K1Nw1G7eOZ47cGp5J3SPoGcDH9i2d1R8y1MiVhzDVr7Pof8
	phheCw==
X-Received: by 2002:a5d:5d05:0:b0:43c:fbcd:4b4f with SMTP id
 ffacd0b85a97d-43d292e800dmr15910051f8f.47.1775418930684; Sun, 05 Apr 2026
 12:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ysrS+QrbGfOLk=e0=PZ-py-KO_xZgn827nEg7mh7hGhdUAAw@mail.gmail.com>
 <2026031827-carving-overdrawn-5b1f@gregkh> <CA+ysrSLcSJSgEC7i0GYXPiRY9sbbyEGT60Nh1SJ6PqXWENgSOw@mail.gmail.com>
 <CA+ysrSL+3YVGvTKhJ=jL92XZPwjoDpt5D2BK-HeCU975vO-fCQ@mail.gmail.com>
 <CA+ysrSJQ2tDiB=zL+GwF=ckhmO62v6GC2bWVUVVDVn7d8Km1mw@mail.gmail.com> <27f3f1b4-5f27-41d6-aa5e-646e5f3ce1e9@nvidia.com>
In-Reply-To: <27f3f1b4-5f27-41d6-aa5e-646e5f3ce1e9@nvidia.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Sun, 5 Apr 2026 15:55:19 -0400
X-Gm-Features: AQROBzD4rLHnviJpTXyKgslc-Z_w1S_EzotqZevOJUPh40XorGh1n-rCGGAs-8k
Message-ID: <CA+ysrSLqMrw0wY8WGcfCxTi=G54v4Gg-jUcEvkw5tyr6J7cLWg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260405_125532_875393_B906D395 
X-CRM114-Status: GOOD (  32.81  )
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

Hi all,

Just following up on this report. Please let me know if there are any
questions about the analysis or if any additional information would be
helpful.

Thanks,
Shivam Kumar

On Wed, Mar 25, 2026 at 12:29=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> +linux-nvme list as well.
>
> On 3/24/26 21:22, Shivam Kumar wrote:
> > Hi Greg, Christoph, Sagi, Chaitanya
> >
> > Following up on my previous report (percpu_ref underflow in
> > nvmet_tcp_try_recv_ddgst). During testing with the percpu_ref patch
> > applied, I identified a separate vulnerability triggered by the same
> > PoC. This one affects the queue kref (not the SQ percpu_ref) and has a
> > different root cause.
> >
> > # Bug Overview
> >
> > nvmet_tcp_handle_icreq() sets queue->state =3D NVMET_TCP_Q_LIVE without
> > holding state_lock and without checking whether teardown has already
> > started. When a client closes the connection immediately after sending
> > an ICReq and a malformed CapsuleCmd, the FIN can arrive and be
> > processed before io_work reads the ICReq from the socket buffer. The
> > FIN handler sets queue->state =3D NVMET_TCP_Q_DISCONNECTING and calls
> > kref_put (1->0). Then io_work processes the ICReq and handle_icreq
> > blindly overwrites the state back to NVMET_TCP_Q_LIVE. This defeats
> > the guard in nvmet_tcp_schedule_release_queue(), which relies on state
> > =3D=3D NVMET_TCP_Q_DISCONNECTING to prevent a second kref_put.
> >
> > When the subsequent digest error triggers nvmet_tcp_fatal_error() ->
> > kernel_sock_shutdown(), the socket teardown synchronously processes
> > any pending TCP packets in the socket backlog via release_sock() ->
> > tcp_done() -> nvmet_tcp_state_change() ->
> > nvmet_tcp_schedule_release_queue(). Because the state was overwritten
> > to LIVE, the guard passes and kref_put is called on an already-zero
> > kref, triggering the underflow.
> >
> > # Root Cause
> >
> > The vulnerable code in nvmet_tcp_handle_icreq() (tcp.c):
> >
> > queue->state =3D NVMET_TCP_Q_LIVE;
> > nvmet_prepare_receive_pdu(queue);
> > return 0;
> >
> > This state transition is not protected by state_lock and does not
> > check the current state. All other state transitions to
> > NVMET_TCP_Q_DISCONNECTING in nvmet_tcp_schedule_release_queue() are
> > protected by the spinlock, but handle_icreq bypasses this
> > synchronization entirely.
> >
> > # Race Sequence
> >
> > The PoC sends ICReq + CapsuleCmd + close() in rapid succession. On the =
wire:
> >
> > [TCP handshake] -> [ICReq] -> [CapsuleCmd] -> [FIN]
> >
> > All data arrives in order in the socket buffer, but the FIN triggers
> > a TCP state change callback (softirq context) that races with io_work
> > (process context) reading the application data.
> >
> > # ftrace evidence (queue 29)
> >
> > Step 1: FIN arrives, teardown begins (softirq context):
> >
> > kworker/-74 1b..2. 125826488us : nvmet_tcp_state_change: DEBUG queue
> > 29: In schedule_release before checking state variable state is 0,
> > kref=3D1, caller=3Dtcp_fin+0x278/0x4f0
> > kworker/-74 1b..2. 125826492us : nvmet_tcp_state_change: DEBUG queue
> > 29: kref_put in schedule_release state changed to 3, kref=3D1,
> > caller=3Dtcp_fin+0x278/0x4f0
> >
> > State transitions from CONNECTING(0) to DISCONNECTING(3), kref decremen=
ted 1->0.
> >
> > Step 2: io_work processes ICReq, overwrites state (process context):
> >
> > kworker/-74 1..... 125826529us : nvmet_tcp_try_recv_pdu: DEBUG queue
> > 29: Inside nvmet_tcp_handle_icreq_pdu before changing state is 3,
> > kref=3D0, caller=3Dnvmet_tcp_io_work+0x12b/0x1fc0
> > kworker/-74 1..... 125826532us : nvmet_tcp_try_recv_pdu: DEBUG queue
> > 29: Inside nvmet_tcp_handle_icreq_pdu after changing state is 2,
> > kref=3D0, caller=3Dnvmet_tcp_io_work+0x12b/0x1fc0
> >
> > handle_icreq see's state=3DDISCONNECTING(3) but overwrites it to LIVE(2=
)
> > without holding state_lock. kref is already 0.
> >
> > Step 3: Digest error triggers fatal_error -> kernel_sock_shutdown
> > (process context):
> >
> > kworker/-74 1..... 125831291us : nvmet_tcp_fatal_error: DEBUG queue
> > 29: fatal_error, state=3D2, ctrl=3D0000000000000000,
> > caller=3Dnvmet_tcp_try_recv_ddgst+0x74f/0x9a0
> >
> > Step 4: kernel_sock_shutdown -> release_sock processes backlog -> tcp_d=
one
> > re-enters state_change, guard bypassed because state is LIVE(2):
> >
> > kworker/-74 1b..2. 125831626us : nvmet_tcp_state_change: DEBUG queue
> > 29: In schedule_release before checking state variable state is 2,
> > kref=3D0, caller=3Dtcp_done+0x1d7/0x350
> > kworker/-74 1b..2. 125831629us : nvmet_tcp_state_change: DEBUG queue
> > 29: kref_put in schedule_release state changed to 3, kref=3D0,
> > caller=3Dtcp_done+0x1d7/0x350
> >
> > schedule_release_queue see's state=3DLIVE(2), guard passes,
> > kref_put called on kref=3D0 -> underflow -> CRASH.
> >
> > The critical evidence is Step 2: handle_icreq reads state=3D3(DISCONNEC=
TING)
> > and writes state=3D2(LIVE) =E2=80=94 proving the unsynchronized overwri=
te.
> >
> > # Additional Observation: Double fatal_error Call
> >
> > The ftrace also shows that fatal_error is called twice per error: once
> > from nvmet_tcp_try_recv_ddgst (digest mismatch) and again from
> > nvmet_tcp_socket_error in nvmet_tcp_io_work (propagated error return).
> > Both calls invoke kernel_sock_shutdown, doubling the window for the
> > reentrant state_change.
> >
> > # Crash Trace (with percpu_ref patch applied)
> >
> > refcount_t: underflow; use-after-free.
> > WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xc5/0x110
> > Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> > Call Trace:
> > <TASK>
> > nvmet_tcp_state_change+0x3e6/0x470
> > tcp_done+0x1d7/0x350
> > tcp_rcv_state_process+0x392c/0x6d80
> > tcp_v4_do_rcv+0x1b1/0xa80
> > __release_sock+0x2ab/0x340
> > release_sock+0x58/0x1c0
> > inet_shutdown+0x1f6/0x3c0
> > nvmet_tcp_fatal_error+0x13c/0x1c0
> > nvmet_tcp_try_recv_ddgst+0x74f/0x9a0
> > nvmet_tcp_io_work+0xd43/0x1fc0
> > process_one_work+0x8cf/0x1a40
> >
> > # Affected Code
> >
> > - Subsystem: drivers/nvme/target/tcp.c
> > - Function: nvmet_tcp_handle_icreq()
> > - Tested on: Linux 7.0-rc3
> >
> > # Suggested Fix Direction
> >
> > The state transition in nvmet_tcp_handle_icreq() needs to be
> > synchronized under state_lock with a check for
> > NVMET_TCP_Q_DISCONNECTING. If the queue is already tearing down,
> > handle_icreq should not set the state to LIVE and should stop
> > processing. I'll defer to you on the exact error handling semantics
> > (return value and cleanup path).
> >
> > This bug is independent of the percpu_ref underflow in the previous
> > report. The percpu_ref patch fixes the SQ refcount underflow; this bug
> > affects the queue kref through an unsynchronized state transition.
> >
> > I am available for further discussion and testing.
> >
> > Thanks,
> > Shivam Kumar
> > PhD Student, Computer Science
> > SYNE Lab, Syracuse University
> > skumar47@syr.edu
>
> I'll try to have a look at this over the weekend.
>
> -ck
>
>


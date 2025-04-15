Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EF9C369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Rq73IbpUmNtbdh1FOL4RVMdkG0NHYMFilgFpf4Rdoc=; b=bw/vCGHgUxDQCQze5E/uogooOF
	vWMZZRSGVwZl5xFCLzjlfZPKHU+HPM2XH87HyucxUOlZGOmAgrXCW7P8DzxOQh3ZfnMXMsM9N0ri+
	40XVyaC1oRWlAHkXgIfkTb6nkkIuoemNdGFaW6JbaA96eO4eRi2OPDrtstIMZGCofD6nV0Uuowx5U
	XknpQu6y9ik6E+NNJj6GZW5ocpo42HBgxwHJPdBYDFeahK8LVKRIfIiksw+kpoEi05pp/ADh5OVZ+
	nLWJq+uUdHLmCMzulHV1FvBZ8K6+9GwTMgUIhYWNh4TWrY9KesHBrjbXbHCueaklmKhG0fDAHShT3
	R7EYtKeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4hw6-00000006DCN-3osn;
	Tue, 15 Apr 2025 15:10:54 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4huR-00000006Cwm-2VJn
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 15:09:12 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-30332dfc820so6379663a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744729751; x=1745334551; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Rq73IbpUmNtbdh1FOL4RVMdkG0NHYMFilgFpf4Rdoc=;
        b=TQ9egHzaqRCJTa3w4IK5SWFll9N0HvXQogCaxRQeMo/0PtfpnzxWQS4OP01vSj3FAd
         3g7lr3eiQ8orxOMBvAkEPpRB0tv4HTq+uuZ9y8PsxSC9ERIDKodroCfEoXrFWIR/k68R
         aLZugLRxLAPT4TTbhZ6txiYhS/nDhzOABQM0mTjCO4J3P2uCFLG9qUhUFEm+q6ql5qd9
         r0oLNRKVuJq3PsVSIJk+TkRKYAu/HXHYJLlZrqX1OSBtB64llk7p2GpTPFY1uM8cZKab
         6XQ1IDd0jZubIQEPTEbzet/tOw0rnLw2cTx04ih0RsAzG9NlUwkM/rLwebg1N5lXzViU
         XnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744729751; x=1745334551;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Rq73IbpUmNtbdh1FOL4RVMdkG0NHYMFilgFpf4Rdoc=;
        b=hYAsinGjDszKtXeQ1rsRb+DqcqCmqCpdZf6qNlkOI4JRl0QUgi32lrymfl7PEnyYUY
         tn97w7+9JUw5o7xVa6YEbqkYIBamuxU/Q8fKAJ666NCx/z7wDDDeQ28cLfZSDCWwpQF+
         sWyu6Gj36GfUyOVuxkYgVMgDA/3179ROl3cPNd3d87cj3LGmVR1Bp1HHAyRx5UfwV1pX
         TSApEttgahqILokXS+Uk+cSfCmlxc6uU91Mh/HG2fzn7xHIauaB3+mTtUT/PpJwD3qB8
         2ykD0OrS6s9u7RQvTBXbcezFmLSyNJn8crTpT7u22KSTRCxLBfyBv+Q/OErN5QPB12cT
         YOqA==
X-Forwarded-Encrypted: i=1; AJvYcCWsHWHRyB4/Z4Ci7AqF4YdodDfhbTPUQ8jxbIcpeTBNv09lUic1j+8NWI9fKfhBt9ZQcC1rgfIkDULA@lists.infradead.org
X-Gm-Message-State: AOJu0Yxhq+ZdYREzgTDjNbZbGMFkFIdqw7cAPLCfdoohZBz8jzz22Uye
	Pb5pFw1YQTUPSMCjo03R/50PlaNSnRT6l6gnfYeJih56lCvEkQiYP6wAyfVpefQ=
X-Gm-Gg: ASbGncvQwkicSttx2wi2dlQF6zPCidtpcL6T/UKvOzssTJIjcPfX9otGBPEeGJXoasL
	SeCNf+PNqScrdM/bK76R2/0it4Lbe8WAS4hZW53DhtdQSdYyAR4OtFq1t+mt0zl8QOxtg8pDjsQ
	tqDBztI215ld/rWe6JESIGlHbLb0NcVZ/FEZJCeXNiKgfXrjYKyWM+dynrGIo9jsp4EF43bohBM
	popkUOgpawCktsGryYeC92xNnQYo58+38pZlT+1lTR1y5NN9pEyOVa0FYiOYIA1EGffQUl+fskQ
	71B24/8MryLdlbeNr7wIG/5kEIGMwYmWxGvEqNYYlH8=
X-Google-Smtp-Source: AGHT+IFKXx8B3GB3eZVGQf50YCeku81UOza8x5Lsxk7p5cMtrXUHnRiBtRcjsGpqtgvr2s85lCgtXA==
X-Received: by 2002:a17:90b:2f05:b0:303:703f:7f8 with SMTP id 98e67ed59e1d1-3082367fac1mr20946681a91.34.1744729750330;
        Tue, 15 Apr 2025 08:09:10 -0700 (PDT)
Received: from smtpclient.apple ([103.85.74.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3082a58c27csm8475039a91.20.2025.04.15.08.09.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Apr 2025 08:09:09 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
From: Jiewei Ke <jiewei@smartx.com>
In-Reply-To: <424fe473-8472-42b8-99c7-8b0534771343@flourine.local>
Date: Tue, 15 Apr 2025 23:08:55 +0800
Cc: wagi@kernel.org,
 hare@suse.de,
 hch@lst.de,
 jmeneghi@redhat.com,
 kbusch@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 mkhalfella@purestorage.com,
 randyj@purestorage.com,
 sagi@grimberg.me
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A03047E-4267-42E7-A1BB-E0D86FC57986@smartx.com>
References: <8F2489FD-1663-4A52-A50B-F15046AC2878@163.com>
 <424fe473-8472-42b8-99c7-8b0534771343@flourine.local>
To: Daniel Wagner <dwagner@suse.de>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_080911_637967_E8B555EF 
X-CRM114-Status: GOOD (  35.45  )
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

Hi Daniel,

> 2025=E5=B9=B44=E6=9C=8815=E6=97=A5 20:34=EF=BC=8CDaniel Wagner =
<dwagner@suse.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Jiewei,
>=20
> On Thu, Apr 10, 2025 at 11:44:13PM +0800, Jiewei Ke wrote:
>> I just noticed that your patchset addresses a similar issue to the =
one I =E2=80=99m
>> trying to solve with my recently submitted patchset [1]. Compared to =
your
>> approach, mine differs in a few key aspects:
>>=20
>> 1. Only aborted requests are delayed for retry. In the current =
implementation,
>> nvmf_complete_timed_out_request and nvme_cancel_request set the =
request status
>> to NVME_SC_HOST_ABORTED_CMD. These requests are usually already sent =
to the
>> target, but may have timed out or been canceled before a response is =
received.
>> Since the target may still be processing them, the host needs to =
delay retrying
>> to ensure the target has completed or cleaned up the stale requests. =
On the
>> other hand, requests that are not aborted =E2=80=94 such as those =
that never got
>> submitted due to no usable path (e.g., from nvme_ns_head_submit_bio), =
or those
>> that already received an ANA error from the target =E2=80=94 do not =
need
>> delayed retry.
>=20
> If I understand you correctly, you are concerned about delaying all
> commands even these which are not transmitted yet. If there are no
> garantees on ordering it would be possible to failover these commands
> immediately. Sure something which could be improved in my series.

Yes, your patchset delays all commands. In fact, some distinction needs =
to be made:
commands with path errors and those that haven't been sent yet can be =
failed over
immediately. You might consider applying the delay only to commands with =
status
NVME_SC_HOST_ABORTED_CMD.

>> 2. The host explicitly disconnects and stops KeepAlive before delay =
scheduling
>> retrying requests. This aligns with Section 9.6 "Communication Loss =
Handling"
>> of the NVMe Base Specification 2.1. Once the host disconnects, the =
target may
>> take up to the KATO interval to detect the lost connection and begin =
cleaning
>> up any remaining requests. Retrying too early may still lead to data
>> corruption issues.
>=20
> The host error handler is executed thus all communication is stopped.
> This part hasn't changed. Not sure what you are referring too. The =
only
> thing which changes in this series is when we enqueue the failed
> commands again.

In your patch as shown below, I think nvme_schedule_failover should be =
called after
nvme_rdma_teardown_admin_queue for two reasons:

* nvme_rdma_teardown_io_queues will call nvme_cancel_tagset, and then =
the inflight
  commands will be added to the ctrl's request_list. So =
nvme_schedule_failover should be
  after nvme_rdma_teardown_io_queues to kick them.

* This does not follow the rule of starting the delay timer(aka =
nvme_schedule_failover)
   after all communication is stopped.

> @@ -2153,6 +2154,7 @@ static const struct blk_mq_ops =
nvme_rdma_admin_mq_ops =3D {
> =20
> static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool =
shutdown)
> {
> + nvme_schedule_failover(&ctrl->ctrl);
> nvme_rdma_teardown_io_queues(ctrl, shutdown);
> nvme_quiesce_admin_queue(&ctrl->ctrl);
> nvme_disable_ctrl(&ctrl->ctrl, shutdown);
> nvme_rdma_teardown_admin_queue(ctrl, shutdown);

>> @@ -2178,6 +2180,7 @@ static void nvme_rdma_shutdown_ctrl(struct =
nvme_rdma_ctrl *ctrl, bool shutdown)
>> nvme_quiesce_admin_queue(&ctrl->ctrl);
>> nvme_disable_ctrl(&ctrl->ctrl, shutdown);
>> nvme_rdma_teardown_admin_queue(ctrl, shutdown);
>> + nvme_delay_kick_retry_lists(&ctrl->ctrl); <<< delay kick retry
>> after teardown all queues
>=20
> Without the kick it hangs. The admin has explicitly removed the ctrl.
>=20
> As I already said, this is a RFC for the sake to figure out if this
> approach is a good idea. We all agreed, we should first try to sort =
this
> out before introducing a new queue. There are many problems which it
> will introduce, like the one from above 'why delaying not send
> requests?', 'What happens when we have several short
> disconnects/connects?', ...
>=20
> BTW, there is already a hack in disconnect/connect state transition.
> Ideally we solve this in a more generic manner.

I agree that introducing a controller-level queue is necessary, these =
commands pending
retry should be uniformly delayed after the controller finishes =
disconnecting.

Regarding the issue of multiple connections and disconnections, in my =
patchset I avoided
using delayed_work, and instead used a synchronous msleep approach. This =
prevents
premature retries.

If we use delayed_work, the following issue may arise: during a =
controller reset, suppose
an inflight command (command 1) is canceled and added to the =
controller=E2=80=99s request_list,
then the connection is torn down and nvme_schedule_failover is called. =
Command 1 will
be scheduled to retry after 30 seconds. And then the reconnection =
completes, but
command 2 encounters an I/O timeout and is also added to the =
request_list. At this point,
the 30-second delay expires, and command 2 might be mistakenly retried =
immediately.

The current state machine cannot avoid this issue if using delayed_work.

Thanks,
Jiewei=


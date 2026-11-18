Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA5606A32A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mfsmOTXn;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=c/Rm9lHk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=I4V3zZNRZtAND4sC5JKkRGbHBTz7Q9OCgn45waVu3As=; b=mfsmOTXnWrCoyLS1fUOEARHFFV
	AHwRfXLbfntFZW3ejmBXbaLA5PJHn1EZpWB0Lllg+53+ZXu/3Iv0KOhoiA/lPAi+87QxFrx9kLiXf
	3O6GBh9bFp1EQfEnvs1XSNkBbicF1RI2uFZkWq5oYoQEEf7emttec9VtBL6L1c8xQ9B87egMYKxRv
	2SAs2rjJ5zDRgAbMILCy0Si2eOf58qQcfv0xkFdPoj77KbE1QTICK3PQ0pKw6v+WDu4xrY256aaIr
	hTpfzmazEFe2mtcjE2KkUz+tzUmuQRHEozQ20EMiJjkCX1Dik8wo8FjKP9D45MjpEklHRDsOdn58y
	tXSqJelg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTzI-00000007PsR-2XpP;
	Wed, 18 Nov 2026 00:57:24 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTz8-00000007Prz-2z8D
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 00:57:19 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso748620eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794963433; x=1795568233; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4V3zZNRZtAND4sC5JKkRGbHBTz7Q9OCgn45waVu3As=;
        b=c/Rm9lHk9YZv7zlsNYFPAOwLrek/VLZzR7IkRFWjuY+rvqhpEx4iQ6DCykr6FR16Vc
         DsiV9OISgPcHqXy03CUSAQPdzyt+7QsFWWx0iX8g96o5oID1CY8rWc6ftT/JHd9MPAmi
         lgEN0a9o1fgOAUMvFtRoGNRe0afXXmWDTo/7x+oBKRHlD1YqDJhkTV068bsPr/pP93RE
         eN75N8RnfoSTl9U9BktRch0uGBUCf5KJDppC9GrsRCnU5wyVwzfbEQISKag6dqiWOs80
         JmL9zA/RxSA5zojvyAHSM9qJLqqtnbN7G/hDCKi+7n7oEllOBqpWrIb2XLOtnSEcJH4R
         0lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794963433; x=1795568233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I4V3zZNRZtAND4sC5JKkRGbHBTz7Q9OCgn45waVu3As=;
        b=hXLeT9MPaTr5g9CujGhzAo/GQ68mzNtzndDOmRWnmggzV+uAztXepxcjMW3ejUkdWl
         1XqEBC/lVRCiV/UFb65Ryt83j9sYXnacIpzCt/aDVXF+QNYM0C0HFXA07stM3HJ5WxBi
         a7rITQmbcULXNZ0BIlDFbx0FJn0g+E7HbpSM5X7uLnP2Yu2Zw3Bx30ddiFVdFFGl8k9t
         My6ltbTdE5tuKP16JZ/fDMQcCfr9rNy88TUOQCF2RFPYbHtxBMC2yG/vPSnho6x+G37z
         COUSZYDOp11DdZb0XUnrqsjFpfXw0l+tlMNRl4jEYzVUlVqDRA6kiQk4YAiIHQIR5vsn
         QP1w==
X-Gm-Message-State: APuU4Z/sf2gGYnLymqZkBMVbPZNL78CP2KD+xdVx+2qcHwM5BhzDNDTX
	DgdJaGwYjyHqQ0NWL5i4qqZ1hOP0hR5I8MLBWq12RNdHd0sFhaWyUviZ4mnwwGHUpU4kKlsxXTg
	CarCg7aY=
X-Gm-Gg: AZFdTZfQ+/RTQkY9rAQOuvt0TJUq1XmGO6DKJFryPt7+9tR51W0LDPjm5jDIlhkX8QL
	8th+ANWa7OqRccSRoOHQ0aeJ3JHpXQzVkFeiTcH5yVpeHxS3DRY4GX8rv/ub/gpTIq3UcYYuDDC
	HW3jmVfX0NMeMDwiUSYf9EZ+x5kxdp93rhUg+WT4xZ3IVH5UtmxG8qRh29onGpAwtKCb6KEcvrA
	k9i3yQ9M4Z/ZiXOOJeWOIKzc/rKtpM2pLqBorWIC9sjEkHAcPhukdL3knte5Ev8AxCaNrZS/WK3
	7AJ3rI3Y7+voCugFdp3rYujniKFT2A/U+Bl/bNMU2RWfVpP8G5SeSp5q+Nr/OJWBy6G2IE3nQDp
	RdvqTw09CMenbrnAJRrFZxLW4QeAsWJUuAWQuE6gSGFqebs002FnRTQmr5FiNKmMCDz6JbcPQ++
	axFOkG3X+LzHNE703jYjwobz0DMgyn8/Lq4vFujFskMD98YMqKzn0H/yYRQUrxynuogBJq0yw3v
	NS2Z8ansY779QrTwEtP8ggJczbazkfCZ7sbf1fXZn3LXDvdmd8V2rj4HRHKiQT41WmhzD5oDLLj
	c2WBrQE+r9oS9TXHf9uEUwQxf+oKUCzlfKWb+fkf9CXteryhNQgsOaKgLnPH01AoZcrZF7A=
X-Received: by 2002:a05:7301:428b:b0:36e:b05e:9a74 with SMTP id 5a478bee46e88-3828161a511mr990033eec.30.1794963432641;
        Tue, 17 Nov 2026 16:57:12 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-382a6304ff2sm1732644eec.6.2026.11.17.16.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:57:12 -0800 (PST)
Date: Tue, 17 Nov 2026 16:57:10 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 07/17] nvme: Introduce FENCING and FENCED controller
 states
Message-ID: <20261118005710.GF1670230-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-8-mkhalfella@purestorage.com>
 <sashiko-outbox-214110@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-214110@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_165714_971763_F0E47B26 
X-CRM114-Status: GOOD (  23.47  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat 2026-11-14 03:29:31 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] nvme: premature non-mpath I/O failure in
>   nvme_fail_nonready_command()
> - [Medium] nvme: live queues re-enabled in nvme_check_ready() when
>   deleting from FENCING
> --
> 
> commit 78ddca4023a9ef3590c04ed05791d87621f68277
> Author: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> nvme: Introduce FENCING and FENCED controller states
> 
> This commit adds the NVME_CTRL_FENCING and NVME_CTRL_FENCED controller
> states along with their state machine transitions, readiness checks,
> multipath path availability handling, and sysfs state names.
> 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 38b27d8db0119..4be3ce2e72a78 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> 
> [ ... ]
> 
> > @@ -622,6 +641,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >  		case NVME_CTRL_LIVE:
> >  		case NVME_CTRL_RESETTING:
> >  		case NVME_CTRL_CONNECTING:
> > +		case NVME_CTRL_FENCING:
> > +		case NVME_CTRL_FENCED:
> >  			changed = true;
> >  			fallthrough;
> >  		default:
> 
> [Severity: Medium]
> When a controller in NVME_CTRL_FENCING or NVME_CTRL_FENCED transitions
> to NVME_CTRL_DELETING, can new I/O be dispatched onto its still-live
> queues while nvme_stop_ctrl() waits for fencing to finish?
> 
> While in NVME_CTRL_FENCING, the transport queues remain live and new
> requests are blocked only because __nvme_check_ready() and
> nvme_path_get_state() reject NVME_CTRL_FENCING and NVME_CTRL_FENCED.
> In nvme_do_delete_ctrl(), ctrl->state stays NVME_CTRL_DELETING across
> nvme_stop_ctrl() until nvme_remove_namespaces() sets
> NVME_CTRL_DELETING_NOIO, and both nvme_check_ready() and
> nvme_path_get_state() treat NVME_CTRL_DELETING on a live queue as ready
> and enabled:
> 
> drivers/nvme/host/nvme.h:nvme_check_ready() {
> 	if (likely(state == NVME_CTRL_LIVE))
> 		return true;
> 	if (ctrl->ops->flags & NVME_F_FABRICS && state == NVME_CTRL_DELETING)
> 		return queue_live;
> 	return __nvme_check_ready(ctrl, rq, queue_live, state);
> }
> 
> drivers/nvme/host/multipath.c:nvme_path_get_state() {
> 	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
> 		return NVME_PATH_DISABLED_CTRL_DOWN;
> }
> 
> As a result, deleting a fencing controller re-enables multipath
> selection and allows new requests to be queued to the broken controller
> throughout the fence wait instead of failing over immediately.

Commit ecca390e8056 ("nvme: fix deadlock in disconnect during scan_work
and/or ana_work") allowed IOs during DELETING state. This is not
different from the transition RESETTING -> DELETING.

> 
> > @@ -786,6 +807,8 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
> >  
> >  	if (state != NVME_CTRL_DELETING_NOIO &&
> >  	    state != NVME_CTRL_DELETING &&
> > +	    state != NVME_CTRL_FENCING &&
> > +	    state != NVME_CTRL_FENCED &&
> >  	    state != NVME_CTRL_DEAD &&
> >  	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
> >  	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
> 
> [Severity: High]
> Does excluding NVME_CTRL_FENCING and NVME_CTRL_FENCED here cause
> non-multipath I/O to fail immediately with BLK_STS_TRANSPORT during
> fencing?
> 
> Multipath requests (REQ_NVME_MPATH or REQ_FAILFAST_TRANSPORT) already
> bypass the BLK_STS_RESOURCE return via the trailing checks and call
> nvme_host_path_error(rq), so excluding NVME_CTRL_FENCING and
> NVME_CTRL_FENCED here only changes the behavior for normal
> non-multipath requests.  Because the queues are not quiesced during
> NVME_CTRL_FENCING, nvme_host_path_error() -> nvme_complete_rq() ->
> nvme_decide_disposition() returns RETRY, and nvme_retry_req() requeues
> the request with zero delay until nvme_max_retries is exhausted in a
> tight loop, after which __nvme_end_req() logs an uninitialized
> nr->cmd->common.opcode in nvme_log_error() (since nvme_check_ready()
> failed before nvme_setup_cmd()) and fails the I/O to the caller.

[  T189] nvme nvme0: CCR failed, switch to time-based recovery, timeout = 45000ms
[  T185] nvme0n1: Flush(0x0) @ LBA 0, 8 blocks, Host Pathing Error (sct 0x3 / sc 0x70)
[  T185] recoverable transport error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 2


           <...>-200     [005] .....   124.297588: block_bio_queue: 259,0 RS 0 + 8 [dd]
           <...>-200     [005] .....   124.297626: block_getrq: 259,0 RS 0 + 8 [dd]
           <...>-200     [005] .....   124.297628: block_io_start: 259,0 RS 4096 () 0 + 8 be,0,4 [dd]
           <...>-200     [005] .....   124.297637: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/5:1H-185     [005] .....   124.297853: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/5:1H-185     [005] .....   124.297941: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/5:1H-185     [005] .....   124.297970: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/5:1H-185     [005] .....   124.297998: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/5:1H-185     [005] .....   124.298092: block_rq_complete: 259,0 RS () 0 + 8 be,0,4 [-67]
    kworker/5:1H-185     [005] .....   124.298134: block_rq_error: 259,0 RS () 0 + 8 be,0,4 [-67]
    kworker/5:1H-185     [005] .....   124.298194: block_io_done: 259,0 RS 0 () 0 + 0 none,0,0 [kworker/5:1H]


Running with multipath=false reproduced the issue above. Yes, the log
line is not valid because opcode was not set yet. And 5 retries show up
just like noted by sashiko. The issue does not happen if multipath is
enabled, which is the default.



           <...>-203     [000] .....    81.537373: block_bio_queue: 259,0 RS 0 + 8 [dd]
           <...>-203     [000] .....    81.537441: block_getrq: 259,0 RS 0 + 8 [dd]
              dd-203     [000] .....    81.537443: block_io_start: 259,0 RS 4096 () 0 + 8 be,0,4 [dd]
              dd-203     [000] .....    81.537451: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
              dd-203     [000] .....    81.537466: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/0:1H-190     [000] .....    81.552951: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/0:1H-190     [000] .....    81.572836: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/0:1H-190     [000] .....    81.592993: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/0:1H-190     [000] .....    81.612912: block_rq_requeue: 259,0 RS () 0 + 8 be,0,4 [0]

    kworker/0:1H-190     [000] .....   137.406869: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=8, cmdid=113, nsid=10, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
    kworker/0:1H-190     [000] .....   137.406889: block_rq_issue: 259,0 RS 4096 () 0 + 8 be,0,4 [kworker/0:1H]
    kworker/0:1H-190     [000] .....   137.408240: nvme_complete_rq: nvme0: disk=nvme0n1, qid=8, cmdid=113, res=0x0, retries=0, flags=0x0, status=0x0
    kworker/0:1H-190     [000] .....   137.408297: block_rq_complete: 259,0 RS () 0 + 8 be,0,4 [0]
    kworker/0:1H-190     [000] .....   137.408496: block_io_done: 259,0 RS 0 () 0 + 0 none,0,0 [kworker/0:1H]


Deleting the two lines result in different behavior. queue_rq returns
BLK_STS_RESOURCE and block layer keeps retrying during the entire
fencing window 81 - 137. This is similar to the current behavior in
CONNECTING state. I will drop the hunk to keep the current behavior.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261114030454.2836543-1-mkhalfella@purestorage.com?part=7


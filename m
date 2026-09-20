Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8CFC982DA
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EcxAKjEfH2MK0I8aTIhf1/PJHO0akVhMcP4QQf38ues=; b=UJ9tJehwWLFuwpyB30DHPIk0Le
	jnRkILOJEPMbZL8SFA4TsM2/sAPjoz6SFgGXXS1zfIg1gLVeio7O012J0lbNOflrgsPv8MUfqTngG
	fD5Oy/Y3sAM4W5wzg5maZYg/GOy2Tq1xLR9lCz1czVbpssx2AydoOY8PVRGuVhwd+lS/QZX5svqxH
	KQxU++i2VbUumcvQHNV8W5WiOvSK4gODjN3Xzb3SmY0VtUAZZIOvFjiDBwCPhZfvD07HUf2t+IeMq
	WNUK+a2coaTP3TEFcYMEO7wVc1EFH3+1uhIBPsJ5k7mIc+ay+fC2osShX5RGQD9CdZzLlMWHscrvp
	zSd6SLGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MMs-00000000FLV-2P4v;
	Sun, 20 Sep 2026 18:34:26 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MMp-00000000FKP-40w0
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:34:25 +0000
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1889111a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929263; x=1790534063; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EcxAKjEfH2MK0I8aTIhf1/PJHO0akVhMcP4QQf38ues=;
        b=aDKPobHECbwTFXjz3SsJN9zqFoSud3fP2cjLeqLb3zVMck0yzjpJKgDMeiC9utpwT4
         Wa7kwdlZEv8j8O/8m02cdenGghyyCA3IUnc1SGOoKpE5pQ5nZua1oEoR2FjriSiZfUR1
         WqQPykGSj2T7yerNgJx+4htqpv9LyZuCfaKWG86Kg2TlZE1v7CAmMVA1k0OBbGF+BTXx
         1VB8mif77bM+fQzeMzyUQSd+x5UuA1xJshZM1fQb4zBK40oS8+AEEtXPZMBJX83wiYbu
         Y08sPzf0RUifvCHOAlUT+x9/lE7CB3kN9F8IhSFpYVnfnz06kJa9JzD13MyxlzslDS0V
         WpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929263; x=1790534063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EcxAKjEfH2MK0I8aTIhf1/PJHO0akVhMcP4QQf38ues=;
        b=YQ4AO5ZmN8aGzHX9Tb0RE5KpEIbYMLXlvW59ikkZe+AYMIZ6q8xCR2T6jPlVY+AWR0
         dCaQ/d8PcKt+8AgYrJwLO5INLnAoE7Vh4cpFHXj9snpp1iktZltMZz68k7fjrUgZFwji
         2OW6Pj1NE0GMxMW/LXEpE3IqwreBT4pA7FP0jjPr6GjhIM4Rwej83e3PfyXaXUG6F2io
         Mtpn2Eu2UWw3/gg6XJNC7VbAs1zD0vbGmgIzOzUn0bs1KkW5gwYN6IbZrhhLtLXLf31/
         QwqsWFutY5ZK0FsRVpUAAQ3zTows+h9uxN1As/AL5Hspi8s96hgnmG2J9FvSsUdrhp8N
         AVZg==
X-Forwarded-Encrypted: i=1; AKwUvByeDGc0HDUmyP9JBy1BKejGccS0ei8lCrXzfw5A9+e5hbgEXknD+SudNuv0RLojdsdYZErN266I1DCN@lists.infradead.org
X-Gm-Message-State: AFuF++l0gOoUtM+xJNJWOxUZtVZrWCjD3lvSGYCo73uMGiWxy+16anO1
	KDYueV6qWQmucqFtAMhcvoS29Bng01S7Ftk/Qyjb7mRzUDG8w3CiJqQA56LC25/nHbk=
X-Gm-Gg: AYBFou0Gw6LSJDrRZG/GzxD5mfrhhxlglynkunYso5K3Pf0g/3tiAYIDSYoMIAEwPIP
	VONrgD0sSAlW7RlL2dk+VElCRJEQzMWt2oNhiHXASg6bkaX8+U8KYPy1aZ/t2eZ9OYE+KesOAep
	KAVaT1O3inf5FP7hRTSOflhAKruZHE8zmRyCvfSUvur2J+UUCd79HO52vzBDPGrCCPh9Ce0gtVq
	BbIr+Rtbq4h4ZSx7GODT2kLi85TYiC96CzrVPqLtZOgIiiNitNYsk/Y79UkfwxZoh643Xq82NLF
	N9istT1oYhsaWgc2bBPA/fY6T2jCUJ/Gd5SMZftE+sZPnhIFYbT336Rbl6iHBHHMsxUYCQvvf+i
	rlhdufWtr6gL6uejvqAjN/+47I0mwh85UtIJ3y8LWzTbA4ZA5qMj7PjLXEc6Ug/f4N5smD9hzvq
	FRq5DhjIeEE08U6c28h/FSS4wZOG1ugWUpjjkHr+kqGleQ4HjMzT3d4mYCB++GMcLHbypPa62xJ
	BtPLw==
X-Received: by 2002:a05:6a21:482:b0:3dd:a006:559a with SMTP id adf61e73a8af0-3dda00655bcmr9278168637.40.1789929263026;
        Sun, 20 Sep 2026 11:34:23 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c3313d96esm13071254eec.12.2026.09.20.11.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:34:22 -0700 (PDT)
Date: Sun, 20 Sep 2026 11:34:20 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] TP8028 Rapid Path Failure Recovery
Message-ID: <20260920183420.GH5552-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113424_034260_FA84D195 
X-CRM114-Status: GOOD (  52.27  )
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

On Fri 2026-09-18 11:14:00 -0700, Mohamed Khalfella wrote:
> This patchset adds support for TP8028 Rapid Path Failure Recovery for
> both the nvme target and initiator. Rapid Path Failure Recovery brings
> Cross-Controller Reset (CCR) functionality to nvme. This allows an nvme
> host to send an nvme command to a source nvme controller to reset the
> impacted nvme controller, provided that both source and impacted
> controllers are in the same nvme subsystem.
> 
> The main use of CCR is when one path to the nvme subsystem fails.
> Inflight IOs on the impacted nvme controller need to be terminated
> first before they can be retried on another path. Otherwise, data
> corruption may happen. CCR provides a quick way to terminate these IOs
> on the unreachable nvme controller, allowing recovery to move quickly
> and avoid unnecessary delays. In case CCR is not possible, inflight
> requests are held for a duration defined by TP4129 KATO Corrections
> and Clarifications before they are allowed to be retried.
> 
> On the target side:
> 
> * New struct members have been added to support CCR. struct
>   nvme_id_ctrl has been updated with CIU (Controller Instance
>   Uniquifier), CIRN (Controller Instance Random Number), and CQT
>   (Command Quiesce Time). The combination of CIU, CNTLID, and CIRN is
>   used to identify the impacted controller in the CCR command.
> 
> * The CCR nvme command implemented on the target causes the impacted
>   controller to fail and drop its connections to the host.
> 
> * The CCR log page contains the status of pending CCR requests. An
>   entry is added to the log page after a CCR request is validated.
>   Completed CCR requests are removed from the log page when the
>   controller becomes ready or when requested in the Get Log Page
>   command.
> 
> * An AEN is sent when a CCR completes to let the host know that it is
>   safe to retry inflight requests.
> 
> On the host side:
> 
> * CIU, CIRN, and CQT have been added to struct nvme_ctrl. CIU and CIRN
>   have been added to sysfs to make the values visible to the user. CIU
>   and CIRN can be used to construct and manually send admin-passthru
>   CCR commands.
> 
> * New controller states FENCING and FENCED have been added to make
>   sure that inflight requests do not get canceled if they time out
>   during the fencing process. FENCED exists so that the controller
>   state machine does not have a transition from FENCING to RESETTING.
>   Instead, FENCING -> FENCED -> RESETTING. This prevents a controller
>   being fenced from getting reset. Only after fencing finishes is the
>   impacted controller reset.
> 
> * Controller recovery in nvme_fence_ctrl() is invoked when a LIVE
>   controller hits an error or when a request times out. CCR is
>   attempted first to reset the impacted controller. If it fails,
>   inflight requests are held until it is safe to retry them.
> 
> * Updated the nvme fabric transports nvme-tcp, nvme-rdma, and nvme-fc
>   to use CCR recovery.
> 
> * Controller deletion now waits for an active fencing window to end
>   instead of failing, so a sysfs disconnect, rdma device removal, or
>   module unload during fencing no longer drops the deletion or leaks
>   the controller.
> 
> Ideally, all inflight requests should be held during controller
> recovery and only retried after recovery is done. However, there are
> known situations where that is not the case in this implementation.
> These gaps will be addressed in future patches:
> 
> * A manual controller reset from sysfs of a LIVE controller will
>   result in the controller going to the RESETTING state and all
>   inflight requests being canceled immediately, and they may be
>   retried on another path. A reset issued during a fencing window is
>   rejected by the state machine.
> 
> * A manual controller delete from sysfs of a LIVE controller will also
>   result in all inflight requests being canceled immediately, and they
>   may be retried on another path. A delete issued during a fencing
>   window now waits for fencing to end instead of being dropped.
> 
> * In nvme-fc, the nvme controller will be deleted if the remote port
>   disappears with no timeout specified. For a LIVE controller this
>   still results in immediate cancellation of requests that may be
>   retried on another path. If the controller is already fencing, the
>   association is torn down without completing the held requests and
>   they are only allowed to fail over once fencing ends.
> 
> * In nvme-rdma, if the HCA is removed, all nvme controllers will be
>   deleted. Deleting LIVE controllers still cancels inflight IOs, and
>   they may be retried on another path. Controllers in a fencing window
>   are now deleted only after fencing ends.
> 
> Changes from v5:
> 
> - nvme: Introduce FENCING and FENCED controller states
>   - Treat FENCING/FENCED controllers as available paths in
>     nvme_available_path() so a multipath head does not fail all IO
>     while its last path is being fenced
> 
> - nvme-fc: Refactor IO error recovery
>   - Split into two patches, "nvme-fc: start error recovery instead of
>     aborting timed out IOs" and "nvme-fc: perform error recovery
>     directly from ioerr_work"
>   - nvme_fc_start_ioerr_recovery() queues ioerr_work directly in
>     DELETING/DELETING_NOIO so that a dead target does not hang
>     controller deletion
>   - nvme_fc_ctrl_ioerr_work() claims RESETTING before tearing the
>     association down and skips recovery when another state owns it
>   - nvme_fc_reset_ctrl_work() tears the association down before
>     nvme_stop_ctrl() so that flushing ana_work or fw_act_work does not
>     get stuck waiting on IOs that never complete
> 
> - nvme-fc: Use CCR to recover controller that hits an error
>   - Tear the association down at the start of fencing_work, releasing
>     all LLDD resources as soon as the controller enters FENCING. This
>     fixes a use-after-free followed by a panic when the LLDD is
>     unloaded or shut down (e.g. lpfc during kexec) while a fencing
>     window is running: the LLDD's bounded unload waits expire before
>     the fence does, its resources are freed, and the post-fence
>     remoteport_delete upcall lands on freed memory
>   - Stop keep-alive and cancel async_event_work before the teardown.
>     AER submission bypasses blk-mq and must not reach the LLDD after
>     the hw queues are deleted. cancel_work_sync() is used instead of
>     flush_work() because fencing_work runs on nvme_wq, the same
>     rescuer-equipped workqueue async_event_work is queued on
> 
> - nvme-fc: Hold inflight requests while in FENCING state
>   - Split nvme_fc_delete_association() into
>     __nvme_fc_teardown_association() and
>     nvme_fc_flush_held_requests(). fencing_work now runs only the
>     teardown at fence start and the held requests are completed on the
>     FENCING -> FENCED transition, so they can fail over only after CCR
>     succeeds or time-based recovery ends
>   - Complete the held requests while still in FENCING, before moving
>     to FENCED, so an io timeout cannot claim FENCED -> RESETTING and
>     start reconnecting while the flush is running
> 
> - nvme: Add support for CQT to nvme host
>   - nvme-fc: complete the held requests in fenced_work when time-based
>     recovery finishes, matching fencing_work
>   - Dropped the Reviewed-by tags due to the above change
> 
> - New patch "nvme: let controller deletion wait out a fencing window"
>   - DELETING is not reachable from FENCING or FENCED, so during a
>     fencing window nvme_delete_ctrl() fails with -EBUSY and its
>     callers silently lose the deletion: a sysfs disconnect is dropped,
>     rdma device removal returns early, and module unload leaks live
>     controllers. Add nvme_delete_ctrl_wait(), use it in the tcp/rdma
>     module exit paths and rdma device removal, and make
>     nvme_delete_ctrl_sync() wait the same way
> 
> v5: https://lore.kernel.org/all/20260712022437.3743117-1-mkhalfella@purestorage.com/
> 
> 
> Mohamed Khalfella (18):
>   nvmet: Rapid Path Failure Recovery set controller identify fields
>   nvmet/debugfs: Export controller CIU and CIRN via debugfs
>   nvmet: Implement CCR nvme command
>   nvmet: Implement CCR logpage
>   nvmet: Send an AEN on CCR completion
>   nvme: Rapid Path Failure Recovery read controller identify fields
>   nvme: Introduce FENCING and FENCED controller states
>   nvme: Implement cross-controller reset recovery
>   nvme: Implement cross-controller reset completion
>   nvme-tcp: Use CCR to recover controller that hits an error
>   nvme-rdma: Use CCR to recover controller that hits an error
>   nvme-fc: start error recovery instead of aborting timed out IOs
>   nvme-fc: perform error recovery directly from ioerr_work
>   nvme-fc: Use CCR to recover controller that hits an error
>   nvme-fc: Hold inflight requests while in FENCING state
>   nvmet: Add support for CQT to nvme target
>   nvme: Add support for CQT to nvme host
>   nvme: let controller deletion wait out a fencing window
> 
>  drivers/nvme/host/constants.c   |   1 +
>  drivers/nvme/host/core.c        | 275 +++++++++++++++++++++++++-
>  drivers/nvme/host/fc.c          | 333 +++++++++++++++++++++++++-------
>  drivers/nvme/host/multipath.c   |   2 +
>  drivers/nvme/host/nvme.h        |  27 +++
>  drivers/nvme/host/rdma.c        |  61 +++++-
>  drivers/nvme/host/sysfs.c       |  27 +++
>  drivers/nvme/host/tcp.c         |  59 +++++-
>  drivers/nvme/target/admin-cmd.c | 126 ++++++++++++
>  drivers/nvme/target/configfs.c  |  36 ++++
>  drivers/nvme/target/core.c      | 115 ++++++++++-
>  drivers/nvme/target/debugfs.c   |  21 ++
>  drivers/nvme/target/nvmet.h     |  20 +-
>  include/linux/nvme.h            |  70 ++++++-
>  14 files changed, 1083 insertions(+), 90 deletions(-)
> 
> 
> base-commit: fd9beb8870736e1c6a0b2351d88a161aaeb2b326
> -- 
> 2.55.0
> 

Oops, looks like I forgot to add -v 6 to git-send-email. Resent the
patches with the correct subject.

https://lore.kernel.org/all/20260920182936.2317916-1-mkhalfella@purestorage.com/


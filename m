Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6E1C7618D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 09:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CRpF/wpSEvT4uoPxB8XVdZ/7yAoyRAq5Mz/5Aaj7Mk8=; b=1b8bdMWMYNxaSkoI+4nrY1CLW/
	DvLpQoFihqlB3M0ENS9HBCyj8ZecyZf+ZxczgGGufy9/0idz/xZmRPPLs1QkQTWwKRbE5Nf38Y+Wv
	WjvaPrqBPzJizRdmaYOOv/2iBrMQ2qcy/sKRhhn9y/C3I06jpDQ5ZAIzRFTbjCTl/mm4hiX3C7riu
	Qg6qo+7Ppl+BNGPt/U86MNQkf7RVSWzrGq7hW2fEg2gy3MtcxljznO+0L9vzYne1cLjvFljhny42M
	CKym+PZ/9PLLfnR7OhdavnuXK29BFlxMqb8HQmGOEwY+WZo3H7Zj/J3HuURfwpmykAokwey17/6so
	oM0w3eXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkLcG-006pd5-27;
	Thu, 06 Apr 2023 09:09:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkLcD-006pbv-0B
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 09:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680772147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CRpF/wpSEvT4uoPxB8XVdZ/7yAoyRAq5Mz/5Aaj7Mk8=;
	b=f2WXDs7kBjwpqz+xDohtItxdB/CcHKB6pn0SfMHROz/yAZc7+2ns6Dea9dGHmsPjHsqY6e
	ChkYOSK5Pbs7ERemTVbephcrreBuL7MM6POvevfxZvodw40uVzsmCSFjTpRjA0OUqBLEC3
	xzQc3lH8FOdI6IX2akwA3eVtlTJKwYI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-9OSAR4nYOpey25ZsGLlU0Q-1; Thu, 06 Apr 2023 05:09:07 -0400
X-MC-Unique: 9OSAR4nYOpey25ZsGLlU0Q-1
Received: by mail-pl1-f198.google.com with SMTP id c8-20020a170902d48800b001a1e0fd4085so22923680plg.20
        for <linux-nvme@lists.infradead.org>; Thu, 06 Apr 2023 02:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680772146;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRpF/wpSEvT4uoPxB8XVdZ/7yAoyRAq5Mz/5Aaj7Mk8=;
        b=M9Vin/2JvXOxSyNOng8lrsFxBkMoF6A11m+NEVcqYYZcWHhTm+Zq3R5rYddr1fL+oI
         HVNBZtVbASTfVSt6KOmmvHR2gqJ4/mITShlebd3DX10TjrVp6RJGJDeFMoNZAseWo2qp
         8da5YEbochQOUZGvWf6jt5r94LZxiOp9L5oI7MI7AG6kgl+pYrIQZDUBJrO+Sx1A7GiG
         GSmryr7K6CGRQwcHj2ZtjOyCdqU2CmPs/fojYcFv376Vvx0xjm9P7EuXhAy+2iRQWP90
         76bWU2rZEItw8LKtDeP32pO3OVx5UspFO9UFKg0dmhN8WAuri8ccUcHfJu5Y/wmrJr+9
         sJAQ==
X-Gm-Message-State: AAQBX9frHAR68xkrH6UaV/YIE35ceCzRX4K6H8Z9L6RokwoEV28J4E2/
	z0lfwkGmeXhjsXRJJil9MZaw804ueBxu68vmChVeMvof2hkB/u9sk7Sypl430XGPKzlZMRixZIU
	42JbEbp+Ag55IxV1l5WRhsTSGmI+BAU+4inKLP562AtYmEDsqJkSWfIJj
X-Received: by 2002:a17:902:bb95:b0:1a2:a843:d363 with SMTP id m21-20020a170902bb9500b001a2a843d363mr3851901pls.10.1680772145674;
        Thu, 06 Apr 2023 02:09:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350YMUPNp1hpdHvTiIJRHLVCSWO7BSfGrtBZIA7l8AksZ9J+I3KzfBA5dceH+VeiQ872Aga/Q77ZMO7rA/Y7Rp3Y=
X-Received: by 2002:a17:902:bb95:b0:1a2:a843:d363 with SMTP id
 m21-20020a170902bb9500b001a2a843d363mr3851892pls.10.1680772145303; Thu, 06
 Apr 2023 02:09:05 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 6 Apr 2023 17:08:54 +0800
Message-ID: <CAHj4cs-XKcJnMK1RBPMUgWEw5sTNcXPoy2X6a5KgouyRaqoagQ@mail.gmail.com>
Subject: [bug report] WARNING: possible recursive locking detected during
 blktests nvme/fc nvme/003
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_020909_165739_35A16A58 
X-CRM114-Status: UNSURE (   5.44  )
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

Hello
Below recursive locking triggered during blktests nvme-fc tests on the
latest linux-block/for-next, pls help check it and let me know if you
need any info/test for it, thanks.

[ 2130.170179] run blktests nvme/003 at 2023-04-06 04:27:14
[ 2141.053697] nvme nvme2: NVME-FC{2}: transport association event:
transport detected io error
[ 2141.062196] nvme nvme2: NVME-FC{2}: resetting controller
[ 2141.084280] nvmet: connect request for invalid subsystem
blktests-subsystem-1!
[ 2141.091689] nvme nvme2: Connect Invalid Data Parameter, subsysnqn
"blktests-subsystem-1"
[ 2141.100024] nvme nvme2: NVME-FC{2}: reconnect failure
[ 2141.187301] nvmet: connect request for invalid subsystem
nqn.2014-08.org.nvmexpress.discovery!
[ 2141.196020] nvme nvme0: Connect Invalid Data Parameter, subsysnqn
"nqn.2014-08.org.nvmexpress.discovery"
[ 2141.205569] nvme nvme0: NVME-FC{0}: reconnect failure
[ 2141.258438]
[ 2141.259939] ============================================
[ 2141.265253] WARNING: possible recursive locking detected
[ 2141.270564] 6.3.0-rc5+ #2 Not tainted
[ 2141.274231] --------------------------------------------
[ 2141.279544] kworker/3:2/613 is trying to acquire lock:
[ 2141.284684] ffff888102c6b1e8
((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at:
__flush_work+0xb3/0x190
[ 2141.294337]
[ 2141.294337] but task is already holding lock:
[ 2141.300171] ffffc90002c2fdb8
((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at:
process_one_work+0x7cb/0x1550
[ 2141.310344]
[ 2141.310344] other info that might help us debug this:
[ 2141.316869]  Possible unsafe locking scenario:
[ 2141.316869]
[ 2141.322787]        CPU0
[ 2141.325243]        ----
[ 2141.327695]   lock((work_completion)(&tport->ls_work));
[ 2141.332921]   lock((work_completion)(&tport->ls_work));
[ 2141.338144]
[ 2141.338144]  *** DEADLOCK ***
[ 2141.338144]
[ 2141.344064]  May be due to missing lock nesting notation
[ 2141.344064]
[ 2141.350849] 2 locks held by kworker/3:2/613:
[ 2141.355122]  #0: ffff88838a944d48
((wq_completion)nvmet-wq){+.+.}-{0:0}, at:
process_one_work+0x79d/0x1550
[ 2141.364778]  #1: ffffc90002c2fdb8
((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at:
process_one_work+0x7cb/0x1550
[ 2141.375385]
[ 2141.375385] stack backtrace:
[ 2141.379745] CPU: 3 PID: 613 Comm: kworker/3:2 Kdump: loaded Not
tainted 6.3.0-rc5+ #2
[ 2141.387569] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.14.2 03/21/2022
[ 2141.395136] Workqueue: nvmet-wq fcloop_tport_lsrqst_work [nvme_fcloop]
[ 2141.401671] Call Trace:
[ 2141.404124]  <TASK>
[ 2141.406229]  dump_stack_lvl+0x60/0xb0
[ 2141.409896]  check_deadlock+0x63b/0x880
[ 2141.413736]  __lock_acquire+0x1b5e/0x23e0
[ 2141.417750]  ? __pfx___lock_acquire+0x10/0x10
[ 2141.422107]  ? lockdep_unlock+0xee/0x250
[ 2141.426032]  ? __lock_acquire+0x1dcf/0x23e0
[ 2141.430218]  lock_acquire+0x1d8/0x5d0
[ 2141.433884]  ? __flush_work+0xb3/0x190
[ 2141.437637]  ? __pfx_lock_acquire+0x10/0x10
[ 2141.441822]  ? mark_lock.part.0+0xca/0xa90
[ 2141.445921]  ? __free_one_page+0x12e/0x14f0
[ 2141.450108]  __flush_work+0xd3/0x190
[ 2141.453686]  ? __flush_work+0xb3/0x190
[ 2141.457439]  ? __pfx___flush_work+0x10/0x10
[ 2141.461624]  ? __pfx___lock_release+0x10/0x10
[ 2141.465984]  ? __mod_zone_page_state+0xcd/0x170
[ 2141.470518]  ? mark_held_locks+0xa5/0xf0
[ 2141.474442]  ? _raw_spin_unlock_irqrestore+0x59/0x70
[ 2141.479406]  ? lockdep_hardirqs_on+0x79/0x100
[ 2141.483766]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[ 2141.488732]  ? __free_pages_ok+0x6c2/0x1070
[ 2141.492921]  fcloop_targetport_delete+0x32/0xb0 [nvme_fcloop]
[ 2141.498673]  nvmet_fc_free_tgtport+0x367/0x540 [nvmet_fc]
[ 2141.504081]  ? _raw_spin_unlock_irqrestore+0x59/0x70
[ 2141.509048]  nvmet_fc_disconnect_assoc_done+0x29f/0x3b0 [nvmet_fc]
[ 2141.515237]  fcloop_rport_lsrqst_work+0x185/0x2b0 [nvme_fcloop]
[ 2141.521165]  process_one_work+0x8b6/0x1550
[ 2141.525263]  ? __lock_acquired+0x209/0x830
[ 2141.529360]  ? __pfx_process_one_work+0x10/0x10
[ 2141.533894]  ? __pfx___lock_acquired+0x10/0x10
[ 2141.538342]  ? worker_thread+0x160/0xed0
[ 2141.542266]  worker_thread+0x5ac/0xed0
[ 2141.546021]  ? __pfx_worker_thread+0x10/0x10
[ 2141.550291]  kthread+0x29f/0x340
[ 2141.553523]  ? __pfx_kthread+0x10/0x10
[ 2141.557276]  ret_from_fork+0x29/0x50
[ 2141.560858]  </TASK>
[ 2141.650837] nvme_fcloop: fcloop_exit: Failed deleting target port
[ 2141.657267] nvme_fcloop: fcloop_exit: Failed deleting remote port
[ 2141.663366] nvme_fcloop: fcloop_exit: Failed deleting target port
[ 2141.669467] nvme_fcloop: fcloop_exit: Failed deleting remote port
[ 2141.675568] nvme_fcloop: fcloop_exit: Failed deleting target port
[ 2141.681661] nvme_fcloop: fcloop_exit: Failed deleting remote port
[ 2141.687761] nvme_fcloop: fcloop_exit: Failed deleting target port
[ 2141.693853] nvme_fcloop: fcloop_exit: Failed deleting remote port
[ 2141.699945] nvme_fcloop: fcloop_exit: Failed deleting target port
[ 2141.706037] nvme_fcloop: fcloop_exit: Failed deleting remote port
[ 2141.712130] nvme_fcloop: fcloop_exit: Failed deleting target port
[ 2141.718223] nvme_fcloop: fcloop_exit: Failed deleting remote port
--snip--
[ 4586.441435] nvme_fcloop: fcloop_exit: Failed deleting target port
[ 4586.453602] nvme_fcloop: fcloop_exit: Failed deleting remote port
[ 4586.465770] nvme_fcloop: fcloop_exit: Failed deleting target port
-- 
Best Regards,
  Yi Zhang



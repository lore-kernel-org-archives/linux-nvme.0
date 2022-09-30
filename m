Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752F0C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kl6KJ20sKnrY/VU5ObppNnwx3Bg+jIEpviSVkbsk0xI=; b=cESqDl5XhEGiFudg982AL2HFzf
	wEmhA/BrE5j50bW0js7A+Xv0xWQo/rvyWj8NhRL3RgoYf/HQSy8L4EoLHlg9UOQ+J8eYveVtZdYqs
	+7SN95fvu8m9JPYO77A5Daf7d4O2Typl1A4zSgxSV/xjFwQTxNHFY4TqZ5qog0XS3ILjNhkBEO6pU
	ncPICF7e9ZgVusr5ycQZbag5wYZW+UjATffNMxGXHkNIJw7qoDnLytLHZGoylWNI3ShbCmtCOEqUj
	drbkbqd36QDSL3SQOZuQEGfIYIJFwD59TVfbPY8aLHblnb64VZH45F4xPwuj1bhWtMdvMTzzp3bBI
	rX+/8CDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeDqc-008khi-V1; Fri, 30 Sep 2022 11:06:26 +0000
Received: from www262.sakura.ne.jp ([202.181.97.72])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeDqa-008ked-BL
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 11:06:26 +0000
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28UB6BjC040455;
	Fri, 30 Sep 2022 20:06:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Fri, 30 Sep 2022 20:06:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28UB6BUs040449
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 30 Sep 2022 20:06:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
Date: Fri, 30 Sep 2022 20:06:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: lockdep WARNING at blktests block/011
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220930001943.zdbvolc3gkekfmcv@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_040624_667074_B7B81F06 
X-CRM114-Status: GOOD (  13.09  )
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

On 2022/09/30 9:19, Shinichiro Kawasaki wrote:
> Kernel v6.0-rc7 triggered the WARN "possible circular locking dependency
> detected" at blktests test case block/011 for NVME devices [1]. The trigger
> commit was c0feea594e05 ("workqueue: don't skip lockdep work dependency in
> cancel_work_sync()"). The commit was backported to v5.15.71 stable kernel and
> the WARN is observed with the stable kernel also. It looks that the possible
> deadlock scenario has been hidden for long time and the commit revealed it now.

Right.

> I tried to understand the deadlock scenario, but can not tell if it is for real,
> or false-positive. Help to understand the scenario will be appreciated. The
> lockdep splat mentions three locks (ctrl->namespaces_rwsem, dev->shutdown_lock
> and q->timeout_work).

Right.

This is a circular locking problem which involves three locks.

  (A) (work_completion)(&q->timeout_work) --> &dev->shutdown_lock

  (B) &dev->shutdown_lock --> &ctrl->namespaces_rwsem

  (C) &ctrl->namespaces_rwsem --> (work_completion)(&q->timeout_work)

(A) and (B) happens due to

  INIT_WORK(&q->timeout_work, blk_mq_timeout_work);

  blk_mq_timeout_work(work) { // Is blocking __flush_work() from cancel_work_sync().
    blk_mq_queue_tag_busy_iter(blk_mq_check_expired) {
      bt_for_each(blk_mq_check_expired) == blk_mq_check_expired() {
        blk_mq_rq_timed_out() {
          req->q->mq_ops->timeout(req) == nvme_timeout(req) {
            nvme_dev_disable() {
              mutex_lock(&dev->shutdown_lock); // Holds dev->shutdown_lock
              nvme_start_freeze(&dev->ctrl) {
                down_read(&ctrl->namespaces_rwsem); // Holds ctrl->namespaces_rwsem which might block
                up_read(&ctrl->namespaces_rwsem);
              }
              mutex_unlock(&dev->shutdown_lock);
            }
          }
        }
      }
    }
  }

(C) happens due to

  nvme_sync_queues(ctrl) {
    nvme_sync_io_queues(ctrl) {
      down_read(&ctrl->namespaces_rwsem); // Holds ctrl->namespaces_rwsem which might block
      /*** Question comes here. Please check the last block in this mail. ***/
      blk_sync_queue(ns->queue) {
	cancel_work_sync(&q->timeout_work) {
          __flush_work((&q->timeout_work, true) {
            // Might wait for completion of blk_mq_timeout_work() with ctrl->namespaces_rwsem held.
          }
        }
      }
      up_read(&ctrl->namespaces_rwsem);
    }
  }

>                       In the related function call paths, it looks that
> ctrl->namespaces_rwsem is locked only for read, so the deadlock scenario does
> not look possible for me.

Right.

>                           (Maybe I'm misunderstanding something...)

Although ctrl->namespaces_rwsem is a rw-sem and is held for read in these paths,
there are paths which hold ctrl->namespaces_rwsem for write. If someone is trying
to hold that rw-sem for write, these down_read(&ctrl->namespaces_rwsem) will be blocked.

That is, it also depends on whether
  down_read(&ctrl->namespaces_rwsem);
and
  down_write(&ctrl->namespaces_rwsem);
might run in parallel.

Question:
  Does someone else call down_write(&ctrl->namespaces_rwsem) immediately after
  someone's down_read(&ctrl->namespaces_rwsem) succeeded?

nvme_alloc_ns()/nvme_ns_remove()/nvme_remove_invalid_namespaces()/nvme_remove_namespaces() calls
down_write(&ctrl->namespaces_rwsem), and some of these are called from work callback functions
which might run in parallel with other work callback functions?



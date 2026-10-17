Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46636CCF2CC
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Oct 2026 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=98lvOFB4BKc/fdFgIwOSXoD4lQbopt4a5ggn5fPV5lM=; b=E7xLvtDYbNAbJjGuJrTPN21kMP
	4mAzk1BFjXxttLc845NqY+7hX/RJDdrZG3NCXHO5Pzawze2GVqaGTIdcseCBq1uXgdD01f9m+41xT
	vfKlslIsiwQJhz2xzBA/6uGhf01c5Tn66PdWwxAa65V93UgJ53SZczhQVsclAC41lfAaKIjIqGy4j
	2LTSFZZdK8k47104NUgxDptch4blDnx5sG+FFEoWukoXlKFJJIH4YSOVvYv5cJdqQjcQWlhY0RJIL
	gChNZ3AqP0w75/B7SAM1rGgzDCQPJBUz/hsiA+y2BKDTPv3fkZH90uR0tZ25QjwjYq5U3Elinatpl
	+EBqBwdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIC5t-00000005H69-1FWz;
	Sat, 17 Oct 2026 21:37:33 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIC5q-00000005H5Y-1NdT
	for linux-nvme@lists.infradead.org;
	Sat, 17 Oct 2026 21:37:32 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-354ba08cfd1so1494307eec.1
        for <linux-nvme@lists.infradead.org>; Sat, 17 Oct 2026 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792273049; x=1792877849; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98lvOFB4BKc/fdFgIwOSXoD4lQbopt4a5ggn5fPV5lM=;
        b=YB1Qxt1nZIbmxZSG/5NPB2O+htpKRU4gUPiFj5YcrAYx1X9jbBnlGxbce4Qy+kdYkg
         5byTdEq2ImoMPNynbW/EcgdeWg5+kfOBTOeUG2le26TuUu4GRKSziqgnXWy+jjnf8Jr0
         TsnZJ27HKir38wNRY4fSqDU+2XV80lBP05ewFFaKEAYhAYVYONY2Q3/0+xismuJNmOhL
         MYThc67vrMNN2emG+F5ckWaYTtse+LcnHp2FAC39D4FBBdbB3rvWuqbDEPGyUfmPgSGW
         NZyaxZpOheaAKnLLeItrUMiPSVnil4lw5B6tcohnIXr825qIISqSZS5rdqhwIaYByC6C
         w6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273049; x=1792877849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=98lvOFB4BKc/fdFgIwOSXoD4lQbopt4a5ggn5fPV5lM=;
        b=tHyPraT1XYlZ0x7luEpgvZCBpD9dVw0QU1qisFm1wZfZGO2LOdHk1XbhJkXkqIN5J5
         Gue1JUOD663ESkCzQP+NEPmwNLurkmSljgwIMu45jJxcu1+bsrKJq17n9eyGOaiXwged
         mGaPFKX4yqFwvIQgY8QmHWhpq5LtWPYztTENmRZTgfWXbl/NwDEhxtfv0qhbHfUCAjim
         cPrlp/qtF3zsSQ1diQ6G+st0+/Qwyhb36nKCV4ChnMbZZBcyrBiDOCDOC0rJnEw2c52L
         yMKc7iTfbhGYZ1/8JMVRfg0LqCg7cNtUy5igeonKULiYtMIT2RTjdYmLft5wbKEuIPw9
         KfYA==
X-Forwarded-Encrypted: i=1; AKwUvByU141JRtSK1iiTbvFiEA3QXJPyoVC6FZfnv5bthdZrfp5wpn8UM8Kpbx6UQZZCJkSayq8Xp4mV7plJ@lists.infradead.org
X-Gm-Message-State: AFq9FYJxmoIhXpABxUzKVu+8laPfupwnxANGK0QdgWIuqFmuejlA/9PF
	XbBd/RaY3qCD+pxWDcKVSq+Osq1mF6x1jkfIve/Dhxl/tNo3U5d3lWHjMe60UTmuymshPT9YZKw
	HYiKTnrYWfA==
X-Gm-Gg: AYBFou3oaz06lrl/D8IZebrazitgfaruV+ABHKyJx1+aB668Ki+tk2wPPv6Yob+cVOo
	/3RErpfHxL3RhAa6HL0uN34VLzt5iUDNDgeoiau6gXpWCCLGQnzDJG5h0H6Zz3kjj3JOf+Su1qs
	oYnd7SUJFFSWmXNSm2cF7P5ouvxmNDCo52HV+MptnNpa0YTHJEvMm6Ouq5hAmDtwgomuhNQ3Ool
	6TRFykw0L8t0G5UiV4WTBui4ZSy4n79rky+gAhW2B07LuymJCosCUs1MCeuBVoRvN4oPNOuzUic
	SfeTNouSglwfcATkBkZiMvPcLecbQXm1/RrCj6G+dBC4uY1PUz5Ze2U2CZhLKmU4+JRI3hVwy8t
	rX4CGhB2dLF2IEMfgvI/RlCHcBo7I8ItgTy1DzwUfrvUsw0fa33OLVWU5mb+fMFu9m8G5wnLMgt
	UhZmMQdax1gS903/SwwY63Sw1JMX1pGq2YjQ+7I+E/1j4R4DGmDOD8mJaii0BC3EPxh4WJo8/aw
	RFYYjqT4kfORKwdzwC2MTb6EZlg1bBJ43A5lQ5Illo=
X-Received: by 2002:a05:7301:6447:b0:359:2729:1797 with SMTP id 5a478bee46e88-361a224d1a7mr6629144eec.30.1792273049428;
        Sat, 17 Oct 2026 14:37:29 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm18104511eec.18.2026.10.17.14.37.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 14:37:28 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Daniel Wagner <dwagner@suse.de>
Cc: Saravanan D <saravanand@crusoe.ai>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/5] nvme-tcp: initialize pf_cache_lock when allocating the controller
Date: Sat, 17 Oct 2026 14:37:15 -0700
Message-ID: <20261017213722.74846-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org> <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261017_143730_933019_52E3B7FF 
X-CRM114-Status: GOOD (  12.13  )
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

On Wed, Oct 14, 2026 at 09:46:39AM +0200, Daniel Wagner wrote:
> Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
> and startup") the I/O tag set is allocated before the I/O queues.
> blk_mq_alloc_tag_set calls nvme_tcp_init_request for every request,
> which takes pf_cache_lock of the request's queue, but nvme_tcp_alloc_queue
> initializes that mutex only later.  With CONFIG_DEBUG_MUTEXES the first
> connect triggers DEBUG_LOCKS_WARN_ON(lock->magic != lock) in
> __mutex_lock and lock debugging is disabled.

I hit the same warning on nvme-7.4, and also a second path to it, a
reconnect that grows the queue count. Every teardown frees the I/O
queues, and nvme_tcp_free_queue() destroys their pf_cache_lock. When
a reconnect raises the queue count, blk_mq_update_nr_hw_queues()
initializes the requests of the added hardware contexts, and with them
takes pf_cache_lock of their queues, before nvme_tcp_setup_io_queues()
allocates those queues.

  shrink, 4 -> 3 queues
    nvme_tcp_free_queue(4)        mutex_destroy(q4 pf_cache_lock)
  grow, 3 -> 4 queues
    blk_mq_update_nr_hw_queues()
      nvme_tcp_init_request()     mutex_lock(q4 pf_cache_lock)  <- WARN
    nvme_tcp_setup_io_queues()
      nvme_tcp_alloc_queue(4)     mutex_init(q4 pf_cache_lock)

  WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x434/0x117c
  Call trace:
   __mutex_lock+0x434/0x117c (P)
   mutex_lock_nested+0x24/0x30
   nvme_tcp_init_request+0xb0/0x260
   blk_mq_alloc_map_and_rqs+0x388/0x670
   blk_mq_update_nr_hw_queues+0xb30/0x1058
   nvme_tcp_setup_ctrl+0xa9c/0xda4
   nvme_tcp_reconnect_ctrl_work+0x70/0x2d8
   process_one_work+0x7a0/0x1b5c

Dropping the mutex_destroy() from nvme_tcp_free_queue(), as this patch
does, fixes that path too. It may be worth mentioning this fact in the
changelog.

Tested against nvmet-tcp over loopback with lockdep, KASAN and
DEBUG_KOBJECT_RELEASE, covering connect, reset loops under I/O,
shrinking and growing the queue count through attr_qid_max, and
reconnects while the port is removed.

Tested-by: Saravanan D <saravanand@crusoe.ai>

Thanks,
Saravanan D.


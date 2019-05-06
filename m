From: kbusch@kernel.org (Keith Busch)
Date: Mon, 6 May 2019 09:56:32 -0600
Subject: [PATCH] nvme-loop: Fix race between completions and shutdown
In-Reply-To: <1ced3919-af4a-7899-8d49-026b9cc82e2b@gmail.com>
References: <20190506145203.2851-1-minwoo.im.dev@gmail.com>
 <20190506145327.GA2164@localhost.localdomain>
 <0db7e312-0ff2-45f2-8ee1-7ad7b6fd3e5a@gmail.com>
 <20190506151727.GB2164@localhost.localdomain>
 <1ced3919-af4a-7899-8d49-026b9cc82e2b@gmail.com>
Message-ID: <20190506155632.GA2219@localhost.localdomain>

On Tue, May 07, 2019@12:52:34AM +0900, Minwoo Im wrote:
> 
> I think it's possible to happen in nvme-pci also.  When a CPU is handling a
> request completed with nvme_complete_rq(), the controller reset by sysfs can
> occur.  In this case, blk_mq_tagset_busy_iter() will iterate over the
> requests allocated in nvme_dev_disable().
> 
> Does nvme-pci host driver handle this kind of situation ?

Yes, we have barriers that ensure no other thread can be operating on
a completion queue entry at the point we iterate the tagset.

From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Mar 2018 13:37:41 -0700
Subject: [PATCH] Revert "nvme: create 'slaves' and 'holders' entries for
 hidden controllers"
In-Reply-To: <CALjAwxgic8ACMRW_56W+BVnikUK+FzNmp-UMJ3qNYmxPZ3idsg@mail.gmail.com>
References: <20180307131358.20275-1-hch@lst.de>
 <1c1332d4-1d92-af8f-974c-2eafcde741f2@suse.de>
 <20180307150344.GE30975@localhost.localdomain>
 <CALjAwxgLXdk1hhmtb3Dp2=U_o1E-MqObBxUroAj+sJU2uNHx4g@mail.gmail.com>
 <20180307171805.GA810@lst.de>
 <20180307173842.GA3766@localhost.localdomain>
 <CALjAwxgic8ACMRW_56W+BVnikUK+FzNmp-UMJ3qNYmxPZ3idsg@mail.gmail.com>
Message-ID: <20180307203741.GC3766@localhost.localdomain>

On Wed, Mar 07, 2018@05:47:34PM +0000, Sitsofe Wheeler wrote:
> The only thing that concerns me is where do the stats live? Over in
> https://github.com/axboe/fio/pull/526#issuecomment-369521772 we found
> the main device doesn't record stats. Will that still be the case?

The stats still live in the same place at
/sys/block/nvmeXcYnZ/queue/stats. This patch just removes symlinks to the
each path block device in the multipath block device's slave directory,
so 'fio' won't see them at the moment.

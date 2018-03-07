From: sitsofe@gmail.com (Sitsofe Wheeler)
Date: Wed, 7 Mar 2018 21:42:38 +0000
Subject: [PATCH] Revert "nvme: create 'slaves' and 'holders' entries for
 hidden controllers"
In-Reply-To: <20180307203741.GC3766@localhost.localdomain>
References: <20180307131358.20275-1-hch@lst.de>
 <1c1332d4-1d92-af8f-974c-2eafcde741f2@suse.de>
 <20180307150344.GE30975@localhost.localdomain>
 <CALjAwxgLXdk1hhmtb3Dp2=U_o1E-MqObBxUroAj+sJU2uNHx4g@mail.gmail.com>
 <20180307171805.GA810@lst.de> <20180307173842.GA3766@localhost.localdomain>
 <CALjAwxgic8ACMRW_56W+BVnikUK+FzNmp-UMJ3qNYmxPZ3idsg@mail.gmail.com>
 <20180307203741.GC3766@localhost.localdomain>
Message-ID: <CALjAwxhgaG7wp-htvrHvJKY+1CDvS_=qT12FEqiAiGOvwfWiiw@mail.gmail.com>

On 7 March 2018@20:37, Keith Busch <keith.busch@intel.com> wrote:
>
> The stats still live in the same place at
> /sys/block/nvmeXcYnZ/queue/stats. This patch just removes symlinks to the
> each path block device in the multipath block device's slave directory,
> so 'fio' won't see them at the moment.

Fair enough - things can be reworked after if/when a replacement link lands.

-- 
Sitsofe | http://sucs.org/~sits/

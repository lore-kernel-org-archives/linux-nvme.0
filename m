From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 29 Mar 2018 16:57:25 -0400
Subject: [PATCH v3] nvme: expand nvmf_check_if_ready checks
In-Reply-To: <20180328202102.9267-1-jsmart2021@gmail.com>
References: <20180328202102.9267-1-jsmart2021@gmail.com>
Message-ID: <20180329205725.GA7747@redhat.com>

On Wed, Mar 28 2018 at  4:21pm -0400,
James Smart <jsmart2021@gmail.com> wrote:

> The nvmf_check_if_ready() checks that were added are very simplistic.
> As such, the routine allows a lot of cases to fail ios during windows
> of reset or re-connection. In cases where there are not multi-path
> options present, the error goes back to the callee - the filesystem
> or application. Not good.
> 
> The common routine was rewritten and calling syntax slightly expanded
> so that per-transport is_ready routines don't need to be present.
> The transports now call the routine directly. The routine is now a
> fabrics routine rather than an inline function.
> 
> The routine now looks at controller state to decide the action to
> take. Some states mandate io failure. Others define the condition where
> a command can be accepted.  When the decision is unclear, a generic
> queue-or-reject check is made to look for failfast or multipath ios and
> only fails the io if it is so marked. Otherwise, the io will be queued
> and wait for the controller state to resolve.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v2:
>   needed to set nvme status when rejecting io
> v3:
>   renamed qlive to queue_live and connectivity to is_connected
>   converted from inline routine to fabrics exported routine.

Hey James,

I tried this patch against my test_01_nvme_offline test in the dm-mpath
"mptest" testsuite: git clone git://github.com/snitm/mptest.git

Unfortunately I'm still seeing that nvmefcloop path recovery take ages
(as compared to native FC, via tcmloop).  And that errors aren't
noticed, and paths switched by DM multipath, until after a considerable
stall while waiting for nvme (I assume connection recovery, etc).

As such mptest's tests/test_01_nvme_offline still doesn't even come
close to achieving the level of fitness, or throughput, that the SCSI
one does (tests/test_01_sdev_offline).

Now it could easily be that the same SCSI test ported to NVMe, like I've
done, is just a misplaced attempt at having NVMe do something it
cannot.

Contrast mptest's lib/failpath_nvme_offline vs lib/failpath_sdev_offline
-- as you can see the lib/failpath_nvme_offline has quite a few sleeps
to prop up the test to allow fio to make _any_ progress at all.  Whereas
the tcmloop variant can quickly transition devices from "offline" to
"running" and vice-versa.  Could be my del_remote_ports to
add_remote_ports (and vice-versa) in a loop just isn't even close to
equivalent?  E.g. way more heavy than SCSI's "offline" to "running".

If you'd like to try mptest out here are some things to help you get
going quickly:

install targetcli, fio, nvme-cli, nvmetcli

1) To run NVMe fcloop tests, you need to modify runtest:
   export MULTIPATH_QUEUE_MODE="bio"
   export MULTIPATH_BACKEND_MODULE="nvmefcloop"
   export NVME_FCLOOP_DEVICE="/dev/some_test_device"
   (e.g. /dev/pmem0, /dev/nvme0n1, /dev/sdb or whatever)
   then:
   ./runtest tests/test_01_nvme_offline

2) To run SCSI tcmloop tests, you need to modify runtest:
   export MULTIPATH_BACKEND_MODULE="tcmloop"
   then:
   ./runtest tests/test_01_sdev_offline

3) Ideally the various sleeps in lib/failpath_nvme_offline would be
removed, but right now if you were to do that the test wouldn't make any
forward progress and the multipath device would fail to teardown due to
pending IO that never completes due to the devices getting torn down
quicker than any IO could be issued.

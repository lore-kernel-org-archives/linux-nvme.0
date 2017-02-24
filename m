From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 24 Feb 2017 14:35:57 -0700
Subject: NVMe IO error due to abort..
In-Reply-To: <18390BD4-644C-40DD-A6FF-E8327962D5F2@kernel.dk>
References: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
 <CA+55aFxpdWPL3=X1gop4jeCk7JQpT4KMvaUq2aAeSfNNW6N=kg@mail.gmail.com>
 <CA+55aFwA+=ojRqcydxa-6ZGqHo+YJqEQqaa9w6HpKtYPmsN+jw@mail.gmail.com>
 <CA+55aFzb8uLKbYaAdGHkJzRfSSqzr3irh0EOQ5NTO4Noeb8htw@mail.gmail.com>
 <18390BD4-644C-40DD-A6FF-E8327962D5F2@kernel.dk>
Message-ID: <7cc18f03-935e-c053-8752-1c42b711f441@kernel.dk>

On 02/24/2017 02:16 PM, Jens Axboe wrote:
> 
> On Feb 24, 2017,@2:09 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> On Fri, Feb 24, 2017 at 1:02 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> And it was just after the kernel compile finished.
>>
>> Timing-wise, it might be the IO flushing after the biggest final link
>> or something. Still, that's really not all that heavy IO, but it might
>> trigger something.
>>
>> Maybe it's even the same use-after-free with md that Bart has seen.
>> That's new to this merge window, isn't it?
> 
> Yes, that one is a regression in this window. And you are using dm...
> You could try and pull my for-linus and see if that changes anything
> for you?

BTW, when/if you do that, note that you would now have to set
mq-deadline as the scheduler. Might be worth running with the default
first, then switch to mq-deadline to see if it reproduces, once you are
confident that it didn't trigger without.

# echo mq-deadline > /sys/block/nvme0n1/queue/scheduler

And below is the branch info. I was going to send this in pretty soon
anyway, but lets see what happens.


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Andy Lutomirski (2):
      nvme: Add a quirk mechanism that uses identify_ctrl
      nvme: Enable autonomous power state transitions

Christoph Hellwig (1):
      scsi: zero per-cmd driver data before each I/O

Christophe JAILLET (1):
      nvmet-rdma: Fix error handling

Colin Ian King (1):
      nvme: admin-cmd: fix spelling mistake: "Counld" -> "Could"

Daniel Roschka (1):
      nvme: detect NVMe controller in recent MacBooks

James Smart (2):
      nvmet_fc: cleanup of abort flag processing in fcp_op_done
      nvme-fc: don't bother to validate ioccsz and iorcsz

Jan Kara (3):
      block: Move bdev_unhash_inode() after invalidate_partition()
      block: Unhash also block device inode for the whole device
      block: Revalidate i_bdev reference in bd_aquire()

Jens Axboe (2):
      block: get rid of blk-mq default scheduler choice Kconfig entries
      dm-rq: don't dereference request payload after ending request

Johannes Thumshirn (1):
      nvme: make nvmf_register_transport require a create_ctrl callback

Jon Derrick (4):
      block/sed: Use ssize_t on atom parsers to return errors
      block/sed: Add helper to qualify response tokens
      block/sed: Check received header lengths
      block/sed: Embed function data into the function sequence

Josef Bacik (3):
      nbd: cleanup ioctl handling
      nbd: set the logical and physical blocksize properly
      nbd: cleanup workqueue on error properly

Keith Busch (3):
      nvme/pci: Disable on removal when disconnected
      nvme/core: Fix race kicking freed request_queue
      nvme/pci: No special case for queue busy on IO

Max Gurtovoy (5):
      nvmet: avoid dereferencing nvmet_req
      nvme: add semicolon in nvme_command setting
      nvme-rdma: move nvme cm status helper to .h file
      nvmet-rdma: use nvme cm status helper
      nvme-rdma: add support for host_traddr

Omar Sandoval (3):
      scsi_transport_sas: fix BSG ioctl memory corruption
      blk-mq: use sbq wait queues instead of restart for driver tags
      blk-mq-sched: separate mark hctx and queue restart operations

Parav Pandit (1):
      nvme: Use CNS as 8-bit field and avoid endianness conversion

Sagi Grimberg (2):
      nvmet: Make cntlid globally unique
      nvme: Make controller state visible via sysfs

Scott Bauer (3):
      block/sed-opal: Introduce free_opal_dev to free the structure and clean up state
      nvme/pci: re-check security protocol support after reset
      block/sed-opal: Propagate original error message to userland.

Tobin C. Harding (3):
      cciss: Fix checkpatch TRAILING_WHITESPACE
      cciss: Fix checkpatch OPEN_BRACE
      cciss: Remove kmalloc cast

 block/Kconfig.iosched             |  44 ---
 block/blk-mq-sched.c              |  29 +-
 block/blk-mq-sched.h              |  26 +-
 block/blk-mq.c                    |  64 ++++-
 block/elevator.c                  |  19 +-
 block/genhd.c                     |   4 +-
 block/sed-opal.c                  | 577 +++++++++++++++++---------------------
 drivers/block/cciss_scsi.c        | 182 ++++++------
 drivers/block/nbd.c               | 307 ++++++++++----------
 drivers/md/dm-rq.c                |   6 +-
 drivers/nvme/host/core.c          | 257 ++++++++++++++++-
 drivers/nvme/host/fabrics.c       |   7 +-
 drivers/nvme/host/fabrics.h       |   2 +-
 drivers/nvme/host/fc.c            |  15 +-
 drivers/nvme/host/nvme.h          |  12 +
 drivers/nvme/host/pci.c           |  27 +-
 drivers/nvme/host/rdma.c          |  48 ++--
 drivers/nvme/target/admin-cmd.c   |   4 +-
 drivers/nvme/target/core.c        |  10 +-
 drivers/nvme/target/discovery.c   |   4 +-
 drivers/nvme/target/fabrics-cmd.c |   6 +-
 drivers/nvme/target/fc.c          |   8 +-
 drivers/nvme/target/loop.c        |   3 +-
 drivers/nvme/target/nvmet.h       |   1 -
 drivers/nvme/target/rdma.c        |   7 +-
 drivers/scsi/scsi_lib.c           |   2 +-
 drivers/scsi/scsi_transport_sas.c |  24 +-
 fs/block_dev.c                    |  11 +-
 include/linux/blk-mq.h            |   2 +
 include/linux/nvme-rdma.h         |  24 ++
 include/linux/nvme.h              |  10 +-
 include/linux/sed-opal.h          |   5 +
 32 files changed, 986 insertions(+), 761 deletions(-)

-- 
Jens Axboe

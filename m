From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 11 Aug 2016 09:40:41 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
 <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
Message-ID: <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>

> > couple of questions:
> >
> > 1. bringing down the interface means generating DEVICE_REMOVAL
> > event?
> >
> 
> No.  Just ifconfig ethX down; sleep 10; ifconfig ethX up.  This simply causes
> the pending work requests to take longer to complete and kicks in the kato
> logic.
> 
> 
> > 2. keep-alive timeout expires means that nvme_rdma_timeout() invokes
> > kicks error_recovery and set:
> > rq->errors = NVME_SC_ABORT_REQ | NVME_SC_DNR
> >
> > So I'm not at all convinced that the keep-alive is the request that
> > being re-issued. Did you verify that?
> 
> The request that caused the crash had rq->errors == NVME_SC_ABORT_REQ.  I'm
> not
> sure that is always the case though.  But this is very easy to reproduce, so I
> should be able to drill down and add any debug code you think might help.
> 

Here is the nvme_rdma_request and request that caused the crash this time:

crash> nvme_rdma_request ffff8801c7e3a5b0
struct nvme_rdma_request {
  mr = 0xffff8801c7e1d298,
  sqe = {
    cqe = {
      done = 0xffffffffa0853320 <nvme_rdma_send_done>
    },
    data = 0xffff8801c7e1b2c8,
    dma = 7648424648
  },
  sge = {{
      addr = 7648424648,
      length = 64,
      lkey = 0
    }, {
      addr = 7814166528,
      length = 2048,
      lkey = 0
    }},
  num_sge = 2,
  nents = 1,
  inline_data = true,
  need_inval = false,
  reg_wr = {
    wr = {
      next = 0x0,
      {
        wr_id = 0,
        wr_cqe = 0x0
      },
      sg_list = 0x0,
      num_sge = 0,
      opcode = IB_WR_RDMA_WRITE,
      send_flags = 0,
      ex = {
        imm_data = 0,
        invalidate_rkey = 0
      }
    },
    mr = 0x0,
    key = 0,
    access = 0
  },
  reg_cqe = {
    done = 0x0
  },
  queue = 0xffff8801d6484038,
  sg_table = {
    sgl = 0xffff8801c7e3a658,
    nents = 1,
    orig_nents = 1
  },
  first_sgl = 0xffff8801c7e3a658
}
crash> nvme_rdma_queue 0xffff8801d6484038
struct nvme_rdma_queue {
  rsp_ring = 0xffff8801ce699158,
  sig_count = 147 '\223',
  queue_size = 128,
  cmnd_capsule_len = 4160,
  ctrl = 0xffff8801d6308958,
  device = 0xffff8803836f44b8,
  ib_cq = 0xffff8801d65366b8,
  qp = 0xffff8801d6524518,
  flags = 0,
  cm_id = 0xffff8801d6525508,
  cm_error = 0,
  cm_done = {
    done = 0,
    wait = {
      lock = {
        {
          rlock = {
            raw_lock = {
              val = {
                counter = 0
              }
            }
          }
        }
      },
      task_list = {
        next = 0xffff8801d6484098,
        prev = 0xffff8801d6484098
      }
    }
  }
}
crash> gdb p ((struct request *)0xffff8801c7e3a5b0 - 1)
$1 = (struct request *) 0xffff8801c7e3a440
crash> request 0xffff8801c7e3a440
struct request {
  queuelist = {
    next = 0xffff8801c7e3a440,
    prev = 0xffff8801c7e3a440
  },
  {
    csd = {
      llist = {
        next = 0xffff8801c7e3b690
      },
      func = 0xffffffff81336c00 <__blk_mq_complete_request_remote>,
      info = 0xffff8801c7e3a440,
      flags = 0
    },
    fifo_time = 18446612139962775184
  },
  q = 0xffff8801d636dbb8,
  mq_ctx = 0xffffe8ffffc04100,
  cpu = -1,
  cmd_type = 1,
  cmd_flags = 2305843009784119304,
  atomic_flags = 2,
  __data_len = 2048,
  __sector = 13992,
  bio = 0xffff8801c34565c0,
  biotail = 0xffff8801c34565c0,
  {
    hash = {
      next = 0x0,
      pprev = 0x0
    },
    ipi_list = {
      next = 0x0,
      prev = 0x0
    }
  },
  {
    rb_node = {
      __rb_parent_color = 18446612139962770632,
      rb_right = 0x0,
      rb_left = 0x0
    },
    completion_data = 0xffff8801c7e3a4c8
  },
  {
    elv = {
      icq = 0x0,
      priv = {0x0, 0x0}
    },
    flush = {
      seq = 0,
      list = {
        next = 0x0,
        prev = 0x0
      },
      saved_end_io = 0x0
    }
  },
  rq_disk = 0xffff8801d63092a8,
  part = 0xffff8801d63092f0,
  start_time = 4361672618,
  rl = 0x0,
  start_time_ns = 67003651063676,
  io_start_time_ns = 0,
  nr_phys_segments = 1,
  nr_integrity_segments = 0,
  ioprio = 0,
  special = 0x0,
  tag = 121,
  errors = 7,
  __cmd = "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
  cmd = 0xffff8801c7e3a548 "",
  cmd_len = 0,
  extra_len = 0,
  sense_len = 0,
  resid_len = 2048,
  sense = 0x0,
  deadline = 4361722943,
  timeout_list = {
    next = 0xffff8801c7e3a580,
    prev = 0xffff8801c7e3a580
  },
  timeout = 30000,
  retries = 0,
  end_io = 0x0,
  end_io_data = 0x0,
  next_rq = 0x0
}

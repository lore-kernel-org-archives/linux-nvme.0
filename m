From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 18 Jan 2018 00:00:31 +0900
Subject: [PATCH V2] nvme: free pre-allocated queue if create ioq goes wrong
In-Reply-To: <20180115020016.GB13580@localhost.localdomain>
References: <1515963650-3805-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180115020016.GB13580@localhost.localdomain>
Message-ID: <CAA7jztd_Ewejj9DZJKeYRWPi6t-PKW3tB4SR7h+fBT_8ztv0aQ@mail.gmail.com>

On Mon, Jan 15, 2018@11:00 AM, Keith Busch <keith.busch@intel.com> wrote:
> Unless this is the very first pass at initialisation, I don't think we
> can free queues until after blk_mq_update_nr_hw_queues since the hctx
> could otherwise point to freed memory.

If not in the first initial step, if (_online_queues_ < 2) driver will
kill queues and
remove namespaces. I thought this "killing queue" will handle what you concerned
about. If I misunderstand what it is, please let me know.

Otherwise if (_online_queues_ >= 2) which means that
at least one or more IO queue is prepared, blk_mq_update_nr_hw_queues()
will be triggered as you said.

From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 18 Jan 2018 13:27:49 +0800
Subject: [PATCH V2] nvme: free pre-allocated queue if create ioq goes wrong
In-Reply-To: <CAA7jztd_Ewejj9DZJKeYRWPi6t-PKW3tB4SR7h+fBT_8ztv0aQ@mail.gmail.com>
References: <1515963650-3805-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180115020016.GB13580@localhost.localdomain>
 <CAA7jztd_Ewejj9DZJKeYRWPi6t-PKW3tB4SR7h+fBT_8ztv0aQ@mail.gmail.com>
Message-ID: <e402e9f4-b884-df4b-3841-445ea38142d2@oracle.com>

Hi Minwoo 

On 01/17/2018 11:00 PM, Minwoo Im wrote:
> On Mon, Jan 15, 2018@11:00 AM, Keith Busch <keith.busch@intel.com> wrote:
>> Unless this is the very first pass at initialisation, I don't think we
>> can free queues until after blk_mq_update_nr_hw_queues since the hctx
>> could otherwise point to freed memory.
> 
> If not in the first initial step, if (_online_queues_ < 2) driver will
> kill queues and
> remove namespaces. I thought this "killing queue" will handle what you concerned
> about. If I misunderstand what it is, please let me know.
> Think of the following scenario:
nvme_reset_work
  -> nvme_setup_io_queues
    -> nvme_create_io_queues
      -> nvme_free_queues
  -> nvme_kill_queues
    -> blk_set_queue_dying   // just freeze the queue here, but will not wait to be drained.
                                not new requests come in, but maybe still residual requests in blk-mq queues.
    -> blk_mq_unquiesce_queue

the queues are _unquiesced_ here, then the residual requests will be queued
and go through nvme_queue_rq. Then the freed nvme_queue structure will be accessed.
:)

Thanks
Jianchao

> Otherwise if (_online_queues_ >= 2) which means that
> at least one or more IO queue is prepared, blk_mq_update_nr_hw_queues()
> will be triggered as you said.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=DkKtzCStCZ1WNuxsJ2wSR-xMZ6lJWOHwGIdXYLbzPYc&s=BO4fWOEqPAS4YnfcEoj8jFyeEH68XPsseHc6Fc4PpsQ&e=
> 

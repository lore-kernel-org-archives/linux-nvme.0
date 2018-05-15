From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 15 May 2018 17:08:29 +0800
Subject: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
In-Reply-To: <20180515003335.GB15199@localhost.localdomain>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <20180511205028.GB7772@localhost.localdomain>
 <20180512002110.GA23631@ming.t460p>
 <20180514151821.GE7772@localhost.localdomain>
 <20180514234701.GA21743@ming.t460p>
 <20180515003335.GB15199@localhost.localdomain>
Message-ID: <CACVXFVM_K+6u4JhCQcyNSWF=gu5_hDqW373PaKtsWWDeTho2pQ@mail.gmail.com>

On Tue, May 15, 2018 at 8:33 AM, Keith Busch
<keith.busch@linux.intel.com> wrote:
> On Tue, May 15, 2018@07:47:07AM +0800, Ming Lei wrote:
>> > > > [  760.727485] nvme nvme1: EH 0: after recovery -19
>> > > > [  760.727488] nvme nvme1: EH: fail controller
>> > >
>> > > The above issue(hang in nvme_remove()) is still an old issue, which
>> > > is because queues are kept as quiesce during remove, so could you
>> > > please test the following change?
>> > >
>> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> > > index 1dec353388be..c78e5a0cde06 100644
>> > > --- a/drivers/nvme/host/core.c
>> > > +++ b/drivers/nvme/host/core.c
>> > > @@ -3254,6 +3254,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>> > >          */
>> > >         if (ctrl->state == NVME_CTRL_DEAD)
>> > >                 nvme_kill_queues(ctrl);
>> > > +       else {
>> > > +               if (ctrl->admin_q)
>> > > +                       blk_mq_unquiesce_queue(ctrl->admin_q);
>> > > +               nvme_start_queues(ctrl);
>> > > +       }
>> > >
>> > >         down_write(&ctrl->namespaces_rwsem);
>> > >         list_splice_init(&ctrl->namespaces, &ns_list);
>> >
>> > The above won't actually do anything here since the broken link puts the
>> > controller in the DEAD state, so we've killed the queues which also
>> > unquiesces them.
>>
>> I suggest you to double check if the controller is set as DEAD
>> in nvme_remove() since there won't be any log dumped when this happen.
>
> Yes, it's dead. pci_device_is_present returns false when the link is
> broken.
>
> Also, the logs showed the capacity was set to 0, which only happens when
> we kill the namespace queues, which supposedly restarts the queues too.
>

Right, nvme_kill_queues() may trigger that, and in my 019 test, not see
pci_device_is_present() returns false, but nvme_kill_queues() has been
called in nvme_remove_dead_ctrl_work(),  and still didn't reproduce
the hang in blk_cleanup_queue() yet.

Looks a bit weird, but debugfs may show some clue, :-)

Thanks,
Ming Lei

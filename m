From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 1 Sep 2016 14:14:25 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <08b701d1f8ba$a709ae10$f51d0a30$@opengridcomputing.com>
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
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
 <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
 <045601d1f803$a9d73a20$fd85ae60$@opengridcomputing.com>
 <69c0e819-76d9-286b-c4fb-22f087f36ff1@grimberg.me>
 <08b701d1f8ba$a709ae10$f51d0a30$@opengridcomputing.com>
Message-ID: <01c301d20485$0dfcd2c0$29f67840$@opengridcomputing.com>

> > >
> > > So it appears the queue is stopped, yet a request is being processed for
> > that
> > > queue.  Perhaps there is a race where QUEUE_FLAG_STOPPED is set after a
> > request
> > > is scheduled?
> >
> > Umm. When the keep-alive timeout triggers we stop the queues. only 10
> > seconds (or reconnect_delay) later we free the queues and reestablish
> > them, so I find it hard to believe that a request was queued, and spent
> > so long in queue_rq until we freed the queue-pair.
> 
> I agree.
> 
> >
> >  From you description of the sequence it seems that after 10 seconds we
> > attempt a reconnect and during that time an IO request crashes the
> > party.
> >
> 
> Yes.
> 
> > I assume this means you ran traffic during the sequence yes?
> 
> Mega fio test streaming to all 10 devices.  I start the following script,
> and then bring the link down a few seconds later, which triggers the kato,
> then 10 seconds later reconnecting starts and whamo...
> 
> 
> for i in $(seq 1 20) ; do
> 
>          fio --ioengine=libaio --rw=randwrite --name=randwrite --size=200m
> --direct=1 \
>         --invalidate=1 --fsync_on_close=1 --group_reporting --exitall
> --runtime=20 \
>         --time_based --filename=/dev/nvme0n1 --filename=/dev/nvme1n1 \
>         --filename=/dev/nvme2n1 --filename=/dev/nvme3n1
> --filename=/dev/nvme4n1 \
>         --filename=/dev/nvme5n1 --filename=/dev/nvme6n1
> --filename=/dev/nvme7n1 \
>         --filename=/dev/nvme8n1 --filename=/dev/nvme9n1 --iodepth=4
> --numjobs=32 \
>         --bs=2K |grep -i "aggrb\|iops"
>         sleep 3
>         echo "### Iteration $i Done ###"
> done
> 

Ok, back to this issue. :)

The same crash happens with mlx4_ib, so this isn't related to cxgb4.  To sum up:

With pending NVME IO on the nvme-rdma host, and in the presence of kato
recovery/reconnect due to the target going away, some NVME requests get
restarted that are referencing nvmf controllers that have freed queues.  I see
this also with my recent v4 series that corrects the recovery problems with
nvme-rdma when the target is down, but without pending IO.  

So the crash in this email is yet another issue that we see when the nvme host
has lots of pending IO requests during kato recovery/reconnect...

My findings to date:  the IO is not an admin queue IO.  It is not the kato
messages.  The io queue has been stopped, yet the request is attempted and
causes the crash.

Any help is appreciated...

Steve.

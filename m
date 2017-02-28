From: artur.paszkiewicz@intel.com (Artur Paszkiewicz)
Date: Tue, 28 Feb 2017 08:42:19 +0100
Subject: [PATCHv2 2/2] nvme: Complete all stuck requests
In-Reply-To: <20170227191459.GA1170@localhost.localdomain>
References: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
 <1487896561-10454-2-git-send-email-keith.busch@intel.com>
 <b66a614e-140e-86e9-56bf-d3eafb750aa5@grimberg.me>
 <20170227150107.GA5789@localhost.localdomain>
 <4c952c67-9871-249d-86b0-5f81acf00571@grimberg.me>
 <20170227191459.GA1170@localhost.localdomain>
Message-ID: <913d4d24-b80b-b7f6-2374-8095bc6fc047@intel.com>

On 02/27/2017 08:15 PM, Keith Busch wrote:
> On Mon, Feb 27, 2017@07:27:51PM +0200, Sagi Grimberg wrote:
>> OK, I think we can get it for fabrics too, need to figure out how to
>> handle it there too.
>>
>> Do you have a reproducer?
> 
> To repro, I have to run a buffered writer workload then put the system into S3.
> 
> This fio job seems to reproduce for me:
> 
>   fio --name=global --filename=/dev/nvme0n1 --bsrange=4k-128k --rw=randwrite --ioengine=libaio --iodepth=8 --numjobs=8 --name=foobar
> 
> I use rtcwake to test suspend/resume:
> 
>   rtcwake -m mem -s 10
> 
> Without the patch we'll get stuck after "Disabling non-boot CPUs ..."
> when blk-mq waits to freeze some entered queues after nvme was disabled.

I'm observing the same thing when hibernating during mdraid resync on
nvme - it hangs in blk_mq_freeze_queue_wait() after "Disabling non-boot
CPUs ...". This patch did not help but when I put nvme_wait_freeze()
right after nvme_start_freeze() it appeared to be working. Maybe the
difference here is that requests are submitted from a non-freezable
kernel thread (md sync_thread)?

Thanks,
Artur

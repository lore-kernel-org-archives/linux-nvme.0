From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 18 Apr 2017 15:17:47 +0300
Subject: cqe dump errors on target while running nvme-of large block read
 IO
In-Reply-To: <DE927C68B458BE418D582EC97927A9285505F0C9@ORSMSX113.amr.corp.intel.com>
References: <DE927C68B458BE418D582EC97927A9285505C9EA@ORSMSX113.amr.corp.intel.com>
 <47f19583-1882-09d4-ce1c-534b8e59068b@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285505F0C9@ORSMSX113.amr.corp.intel.com>
Message-ID: <52c550c1-849b-7ea5-ab34-56543cb9069d@mellanox.com>



On 4/14/2017 7:38 PM, Gruher, Joseph R wrote:
>> hi Joe,
>> can you run and repro it with null_blk backing store instead the nvme ?
>> you can emulate the delay of the nvme device using module param
>> completion_nsec.
>> is it reproducable in case B2B connectivity ?
>
> Hey Max,
>
> I ran overnight using null_blk devices but was unable to reproduce in that configuration.  I set completion_nsec to 50000.  Although my measured completion latencies in FIO were more like 17-18usec so not sure why they did not come in closer to 50usec.  Anyway, failure did not reproduce using null_blk instead of real NVMe SSDs.

Hi,
you should set also the irqmode=2 (timer) and run local fio with 
iodepth=1 and numjobs=1 to verify the latency (worked for me).
Let's try to repro again with the new configuration, to be sure that 
this is not a transport issue.

Thanks.

>
> By B2B connectivity do you mean direct target-to-initiator connection with no switch?  I don't think that is possible in this configuration since target uses a 100Gb QSFP NIC and initiator uses a 25Gb SFP28 NIC.  I could perhaps swap the target side NIC for a matching 25Gb device and run direct connected that way if we think we need that data point, we would need to first establish if the failure even happens in that configuration, based on other testing we've done on an all-25Gb configuration I suspect it may not.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

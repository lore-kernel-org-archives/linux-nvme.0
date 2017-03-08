From: yizhan@redhat.com (Yi Zhang)
Date: Wed, 8 Mar 2017 14:41:23 +0800
Subject: kernel NULL pointer on nvmet with stress
 rescan_controller/reset_controller test during I/O
In-Reply-To: <8f4f2a1c-8bca-1ca3-8cf1-97572a729a9e@grimberg.me>
References: <1855135937.31179102.1488539265795.JavaMail.zimbra@redhat.com>
 <8f4f2a1c-8bca-1ca3-8cf1-97572a729a9e@grimberg.me>
Message-ID: <003061f2-39e3-79e8-24aa-0ad9027dbef3@redhat.com>



On 03/06/2017 07:52 PM, Sagi Grimberg wrote:
>> Hi
>
> Hi Yi,
>
>> I always can reproduce this issue during stress test on 
>> rescan_controller/reset_controller, could you help check it, thanks.
>>
>> Reproduce steps on Initiator side:
>> #fio -filename=/dev/nvme0n1 -iodepth=1 -thread -rw=randwrite 
>> -ioengine=psync 
>> -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 
>> -bs_unaligned -runtime=1200 -size=-group_reporting -name=mytest 
>> -numjobs=60 &
>> #num=0
>> while [ $num -lt 200 ]
>> do
>>         echo "-------------------------------$num"
>>         echo 1 >/sys/block/nvme0n1/device/rescan_controller || exit 1
>>         echo 1 >/sys/block/nvme0n1/device/reset_controller || exit 1
>>         ((num++))
>> done
>
> nvmet-rdma makes sure that no inflight IO nor completions are pending
> when destroying the queue. The below looks like we got a recv completion
> event after we freed all the tasks for the queue (which happens after
> ib_drain_qp and rdma_destroy_qp).
>
> So this is definitely weird. Which device are you using? I ran
> the exact scenario on my VM and didn't see any NULL deref...
Here is the device I used:
07:00.0 Network controller: Mellanox Technologies MT27500 Family 
[ConnectX-3]

Could your run this test with more cycles, I always can reproduce this 
issue with less than 200 times.

Thanks
Yi

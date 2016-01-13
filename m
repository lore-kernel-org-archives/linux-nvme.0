From: axboe@fb.com (Jens Axboe)
Date: Wed, 13 Jan 2016 11:55:41 -0700
Subject: NVM and swap device
In-Reply-To: <20160113105122.03fb7e63@xeon-e3>
References: <20160112194030.5b74ecdc@xeon-e3> <56968DBC.1040609@fb.com>
 <20160113105122.03fb7e63@xeon-e3>
Message-ID: <56969DAD.5050602@fb.com>

On 01/13/2016 11:51 AM, Stephen Hemminger wrote:
> On Wed, 13 Jan 2016 10:47:40 -0700
> Jens Axboe <axboe@fb.com> wrote:
>
>> On 01/12/2016 08:40 PM, Stephen Hemminger wrote:
>>> I have a nice shiny new Intel NVM PCI card; decided to use it for a filesystem and swap.
>>> The filesystem (btrfs) is doing fine, but the swap device was throwing occasional
>>> random errors. Suspect a driver problem rather than hardware.
>>>
>>> I am using 4.4 kernel without patches.
>>>
>>> kern.log:Jan 12 08:11:57 xeon-e3 kernel: [159474.037390] Read-error on swap-device (259:0:17597808)
>>> kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855526] Read-error on swap-device (259:0:11355648)
>>> kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855530] Read-error on swap-device (259:0:11355656)
>>> kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87939.855467] Read-error on swap-device (259:0:16180824)
>>> kern.log.1:Jan  8 08:24:07 xeon-e3 kernel: [63670.777981] Read-error on swap-device (259:0:32690768)
>>> kern.log.1:Jan  9 09:25:02 xeon-e3 kernel: [153720.919325] Read-error on swap-device (259:0:220488)
>>> kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.957675] Read-error on swap-device (259:0:24476232)
>>> kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.962673] Read-error on swap-device (259:0:33292816)
>>>
>>> The swap device was being added via /etc/fstab by UUID.
>>>
>>> I gave up and went back to spinning rust for swap device for stabilty.
>>
>> That's very odd. Why are you suspecting a driver problem? Have you tried
>> to thoroughly beat the device up with normal IO?
>>
>
> I will try it tonight. Do you have a favorite test?

I'd run something that just beats up on it, reads and writes. If you 
have fio installed, something ala:

fio --ioengine=libaio --iodepth=8 --direct=1 --bs=4k 
--filename=/dev/nvme0n1 --numjobs=4 --norandommap --runtime=1h 
--time_based=1 --name=reads --rw=randread --name=writes --rw=randwrite

This will run 4 processes that randomly read from the device, and 4 that 
randomly write. Replace /dev/nvme0n1 with your swap partition. The test 
will run for 1 hour.

-- 
Jens Axboe

From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 22 Mar 2018 15:32:45 -0600
Subject: [GIT PULL] nvme fix for 4.16-rc6
In-Reply-To: <20180322210917.GK12909@localhost.localdomain>
References: <20180316160110.GC720@localhost.localdomain>
 <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>
 <20180316161655.GA13293@lst.de>
 <8734416c-cd14-8bfb-8e2c-6eab84e0ce5d@kernel.dk>
 <20180321205958.GH12909@localhost.localdomain>
 <dc2798b4-5654-9fc3-444e-efbce5775ca4@kernel.dk>
 <e8fecf76-08db-154b-fcfb-b15acbc7acac@kernel.dk>
 <20180322210917.GK12909@localhost.localdomain>
Message-ID: <71eda309-fa4a-7641-9292-fcc6c77d44af@kernel.dk>

On 3/22/18 3:09 PM, Keith Busch wrote:
> On Wed, Mar 21, 2018@03:44:32PM -0600, Jens Axboe wrote:
>>
>> [   30.241598] nvme nvme2: pci function 0000:0b:00.0                            
>> [   30.247205] nvme nvme3: pci function 0000:81:00.0                            
>> [   30.252684] nvme nvme4: pci function 0000:82:00.0                            
>> [   30.258144] nvme nvme5: pci function 0000:83:00.0                            
>> [   30.263606] nvme nvme6: pci function 0000:84:00.0                            
>> [   30.360555] nvme nvme3: could not set timestamp (8194)                       
>> [   30.481649] nvme nvme6: Shutdown timeout set to 8 seconds                    
>> [   38.790949] nvme nvme4: Device not ready; aborting initialisation            
>> [   38.797857] nvme nvme4: Removing after probe failure status: -19             
>> [   60.708816] nvme nvme3: I/O 363 QID 8 timeout, completion polled             
>> [   60.708820] nvme nvme6: I/O 781 QID 7 timeout, completion polled             
>> [   68.068772] nvme nvme2: I/O 769 QID 28 timeout, completion polled            
>> [   91.108626] nvme nvme6: I/O 781 QID 7 timeout, completion polled             
>> [   98.660581] nvme nvme2: I/O 769 QID 28 timeout, completion polled            
>> [  121.702691] nvme nvme6: I/O 100 QID 7 timeout, completion polled             
>> [  128.998648] nvme nvme3: I/O 387 QID 4 timeout, completion polled             
>> [  152.038523] nvme nvme6: I/O 781 QID 7 timeout, completion polled             
>>
>> This is just doing an fdisk -l after load. No interrupts triggering,
>> looking at /proc/interrupts for the queues that timeout.
> 
> So no interrupts triggered for the queues that timeout, but you are
> getting interrupts for other queues. Are there by chance many spurious
> interrupts for those other queues?

I picked one device, and I did:

for i in $(seq 0 47); do echo cpu $i; taskset -c $i dd if=/dev/nvme6n1 of=/dev/null bs=4k iflag=direct count=1; done
[...]
cpu 17
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 30.608 s, 0.1 kB/s

same slowness for CPU 19, 21, 23, 41, 43, 45, 47. Looking at dmesg:
[  701.725191] nvme nvme6: I/O 912 QID 7 timeout, completion polled
[  732.124646] nvme nvme6: I/O 896 QID 7 timeout, completion polled
[  762.652479] nvme nvme6: I/O 840 QID 7 timeout, completion polled
[  793.052259] nvme nvme6: I/O 754 QID 7 timeout, completion polled
[  823.644082] nvme nvme6: I/O 339 QID 7 timeout, completion polled
[  853.979878] nvme nvme6: I/O 86 QID 7 timeout, completion polled
[  884.571686] nvme nvme6: I/O 997 QID 7 timeout, completion polled
[  914.907506] nvme nvme6: I/O 694 QID 7 timeout, completion polled

we see them all timing out after 30s, and all being on QID 7, which
is hctx6. There are 8 hw queues (and interrupts), only some of
them seem to be actually triggering looking at /proc/interrupts.

There seems to be some mismatch. nvme6q7 is 244:

# cat /proc/irq/244/smp_affinity_list 
49,51,53,55,57,59,61,63

and 243 is nvme6q6:

# cat /proc/irq/243/smp_affinity_list 
17,19,21,23,41,43,45,47

244 has never triggered, if I do:

# taskset -c 17 dd if=/dev/nvme6n1 of=/dev/null bs=4k iflag=direct count=1

then look at interrupts, none of the nvme6 associated interrupts have
triggered.

-- 
Jens Axboe

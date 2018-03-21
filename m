From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 21 Mar 2018 15:44:32 -0600
Subject: [GIT PULL] nvme fix for 4.16-rc6
In-Reply-To: <dc2798b4-5654-9fc3-444e-efbce5775ca4@kernel.dk>
References: <20180316160110.GC720@localhost.localdomain>
 <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>
 <20180316161655.GA13293@lst.de>
 <8734416c-cd14-8bfb-8e2c-6eab84e0ce5d@kernel.dk>
 <20180321205958.GH12909@localhost.localdomain>
 <dc2798b4-5654-9fc3-444e-efbce5775ca4@kernel.dk>
Message-ID: <e8fecf76-08db-154b-fcfb-b15acbc7acac@kernel.dk>

On 3/21/18 3:02 PM, Jens Axboe wrote:
> On 3/21/18 2:59 PM, Keith Busch wrote:
>> On Fri, Mar 16, 2018@09:26:24AM -0700, Jens Axboe wrote:
>>> It's not that I dislike the patch (in fact it makes the code
>>> easier to read), but it's pretty late for something that isn't
>>> a regression in this series. I can queue it up for some testing,
>>> but it's then -rc7 time. I guess we can see how it goes and
>>> push the decision until start next week.
>>
>> Hi Jens,
>>
>> Do you need more time on this one or have you decided where you want
>> this fix to go? I'm planning to send the first nvme 4.17 pull request
>> this week, so just checking if I should include this one.
> 
> Let's ship it for 4.16.

On 2nd though, let's not. While it worked fine on one box, my other
test box (that has a bunch of drives) is not very happy:

[   30.241598] nvme nvme2: pci function 0000:0b:00.0                            
[   30.247205] nvme nvme3: pci function 0000:81:00.0                            
[   30.252684] nvme nvme4: pci function 0000:82:00.0                            
[   30.258144] nvme nvme5: pci function 0000:83:00.0                            
[   30.263606] nvme nvme6: pci function 0000:84:00.0                            
[   30.360555] nvme nvme3: could not set timestamp (8194)                       
[   30.481649] nvme nvme6: Shutdown timeout set to 8 seconds                    
[   38.790949] nvme nvme4: Device not ready; aborting initialisation            
[   38.797857] nvme nvme4: Removing after probe failure status: -19             
[   60.708816] nvme nvme3: I/O 363 QID 8 timeout, completion polled             
[   60.708820] nvme nvme6: I/O 781 QID 7 timeout, completion polled             
[   68.068772] nvme nvme2: I/O 769 QID 28 timeout, completion polled            
[   91.108626] nvme nvme6: I/O 781 QID 7 timeout, completion polled             
[   98.660581] nvme nvme2: I/O 769 QID 28 timeout, completion polled            
[  121.702691] nvme nvme6: I/O 100 QID 7 timeout, completion polled             
[  128.998648] nvme nvme3: I/O 387 QID 4 timeout, completion polled             
[  152.038523] nvme nvme6: I/O 781 QID 7 timeout, completion polled             

This is just doing an fdisk -l after load. No interrupts triggering,
looking at /proc/interrupts for the queues that timeout. The commands
do complete eventually, but only because we poll the queue. Ignore
the probe failure, that one is expected.

So that's a pretty horrific failure, about half (or more) of the
devices simply don't work. For something being pushed aggressively
at -rc6 time, I'd say your testing is lacking.

I'm going to drop it from my 4.16 queue, and don't queue it up for
4.17 before we figure out what's going on here.

-- 
Jens Axboe

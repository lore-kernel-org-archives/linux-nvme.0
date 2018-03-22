From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Mar 2018 15:09:17 -0600
Subject: [GIT PULL] nvme fix for 4.16-rc6
In-Reply-To: <e8fecf76-08db-154b-fcfb-b15acbc7acac@kernel.dk>
References: <20180316160110.GC720@localhost.localdomain>
 <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>
 <20180316161655.GA13293@lst.de>
 <8734416c-cd14-8bfb-8e2c-6eab84e0ce5d@kernel.dk>
 <20180321205958.GH12909@localhost.localdomain>
 <dc2798b4-5654-9fc3-444e-efbce5775ca4@kernel.dk>
 <e8fecf76-08db-154b-fcfb-b15acbc7acac@kernel.dk>
Message-ID: <20180322210917.GK12909@localhost.localdomain>

On Wed, Mar 21, 2018@03:44:32PM -0600, Jens Axboe wrote:
> 
> [   30.241598] nvme nvme2: pci function 0000:0b:00.0                            
> [   30.247205] nvme nvme3: pci function 0000:81:00.0                            
> [   30.252684] nvme nvme4: pci function 0000:82:00.0                            
> [   30.258144] nvme nvme5: pci function 0000:83:00.0                            
> [   30.263606] nvme nvme6: pci function 0000:84:00.0                            
> [   30.360555] nvme nvme3: could not set timestamp (8194)                       
> [   30.481649] nvme nvme6: Shutdown timeout set to 8 seconds                    
> [   38.790949] nvme nvme4: Device not ready; aborting initialisation            
> [   38.797857] nvme nvme4: Removing after probe failure status: -19             
> [   60.708816] nvme nvme3: I/O 363 QID 8 timeout, completion polled             
> [   60.708820] nvme nvme6: I/O 781 QID 7 timeout, completion polled             
> [   68.068772] nvme nvme2: I/O 769 QID 28 timeout, completion polled            
> [   91.108626] nvme nvme6: I/O 781 QID 7 timeout, completion polled             
> [   98.660581] nvme nvme2: I/O 769 QID 28 timeout, completion polled            
> [  121.702691] nvme nvme6: I/O 100 QID 7 timeout, completion polled             
> [  128.998648] nvme nvme3: I/O 387 QID 4 timeout, completion polled             
> [  152.038523] nvme nvme6: I/O 781 QID 7 timeout, completion polled             
> 
> This is just doing an fdisk -l after load. No interrupts triggering,
> looking at /proc/interrupts for the queues that timeout.

So no interrupts triggered for the queues that timeout, but you are
getting interrupts for other queues. Are there by chance many spurious
interrupts for those other queues?

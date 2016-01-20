From: stephen@networkplumber.org (Stephen Hemminger)
Date: Wed, 20 Jan 2016 13:30:06 -0800
Subject: NVM and swap device
In-Reply-To: <56969DAD.5050602@fb.com>
References: <20160112194030.5b74ecdc@xeon-e3> <56968DBC.1040609@fb.com>
 <20160113105122.03fb7e63@xeon-e3> <56969DAD.5050602@fb.com>
Message-ID: <20160120133006.483d8ebb@xeon-e3>

On Wed, 13 Jan 2016 11:55:41 -0700
Jens Axboe <axboe@fb.com> wrote:

> I'd run something that just beats up on it, reads and writes. If you 
> have fio installed, something ala:
> 
> fio --ioengine=libaio --iodepth=8 --direct=1 --bs=4k 
> --filename=/dev/nvme0n1 --numjobs=4 --norandommap --runtime=1h 
> --time_based=1 --name=reads --rw=randread --name=writes --rw=randwrite
> 
> This will run 4 processes that randomly read from the device, and 4 that 
> randomly write. Replace /dev/nvme0n1 with your swap partition. The test 
> will run for 1 hour.

The fio test ran fine without errors. I am beginning to think it something
unique to how I/O in swap path gets done.

Will turn it back on for swap and see what happens.

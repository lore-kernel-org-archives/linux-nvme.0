From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Apr 2016 13:21:14 +0000
Subject: I/O 0 QID 0 timeout, disable controller - kernel 4.4 / 4.5
 NVMe controller dropouts
In-Reply-To: <1DC99E13-F6CB-4B7F-AFD7-187825DEE523@fastmail.com>
References: <1DC99E13-F6CB-4B7F-AFD7-187825DEE523@fastmail.com>
Message-ID: <20160414132113.GA21794@localhost.localdomain>

On Thu, Apr 14, 2016@03:13:22PM +1000, Sam McLeod wrote:
> We have 6 Supermicro servers all of the same (or very similar spec),
> 
> Since Kernel 4.4 / 4.5 we've had NVMe devices randomly dropping.
> It does not relate to a particular server, disk, controller etc... and downgrading to kernel 4.1.
> 
> With kernel 4.4 the servers would load and the disk randomly disappear.
> With 4.5 the server loads with one of the disks missing every time.
> 
> 
> ```
> [   66.856719] nvme 0000:03:00.0: I/O 0 QID 0 timeout, disable controller
> [   66.957911] nvme 0000:03:00.0: Identify Controller failed (-4)
> [   66.957961] nvme 0000:03:00.0: Removing after probe failure status: -5
> ```

Looks like more fallout from reducing the scope of admin queue completion
polling...

Jens:

Could we please apply the MSI-x fix commit to 4.6 instead of 4.7 so 4.6
isn't equally broken? Currently staged in for-next here:

  http://git.kernel.dk/?p=linux-block.git;a=commitdiff;h=788e15abbb9408c9399d7e3445ac9afb3b2fd7d6;hp=e0489487ec9cd79ee1fa0dc5d3789c08b0e51a2c

I'd also like to submit an apporpriate port to stable if no objections.

Thanks,
Keith

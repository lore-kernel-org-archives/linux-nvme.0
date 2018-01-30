From: keith.busch@intel.com (Keith Busch)
Date: Tue, 30 Jan 2018 13:30:11 -0700
Subject: WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527
 nvme_setup_cmd+0x3d3
In-Reply-To: <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
References: <45f93661-da0d-94c5-1740-85242df8776e@kernel.dk>
 <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
Message-ID: <20180130203011.GE27205@localhost.localdomain>

On Tue, Jan 30, 2018@08:57:49AM -0700, Jens Axboe wrote:
> 
> Looking at the disassembly, 'n' is 2 and 'segments' is 0xffff.

Is this still a problem if you don't use an IO scheduler? With deadline,
I'm not finding any path to bio_attempt_discard_merge which is where the
nr_phys_segments is supposed to get it set to 2. Not sure how it could
becmoe 0xffff, though.

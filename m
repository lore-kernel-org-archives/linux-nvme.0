From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 10 Oct 2018 11:52:57 -0700
Subject: [PATCH] blk: optimization for classic polling
In-Reply-To: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
Message-ID: <6425d6fc-59d7-7ea0-487f-bb5d0985653c@gmail.com>

On 05/29/2083 08:21 PM, Nitesh Shetty wrote:
> This removes the dependency on interrupts to wake up task. Set task
> state as TASK_RUNNING, if need_resched() returns true,
> while polling for IO completion.
> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> This made some IO take very long when interrupt-coalescing is enabled in
> NVMe.
> 
> Reference:
> http://lists.infradead.org/pipermail/linux-nvme/2018-February/015435.html
> Signed-off-by: Nitesh Shetty <nj.shetty at samsung.com>

There is something seriously wrong with the date on your computer, this
patch is dated from May 29th 2083,... I would not be surprised if it
messed up people's email client and you did not get any response because
of that...
-- 
Florian

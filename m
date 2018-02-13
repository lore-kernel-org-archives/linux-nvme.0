From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 13 Feb 2018 09:12:18 -0700
Subject: [PATCH v3] blk: optimization for classic polling
In-Reply-To: <1518536892-2051-1-git-send-email-nj.shetty@samsung.com>
References: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <CGME20180213154752epcas1p35e3c13d150d2108a06342781ec5e64d7@epcas1p3.samsung.com>
 <1518536892-2051-1-git-send-email-nj.shetty@samsung.com>
Message-ID: <f797a075-4ef2-410f-4eda-fa70d426d58f@kernel.dk>

On 2/13/18 8:48 AM, Nitesh Shetty wrote:
> This removes the dependency on interrupts to wake up task. Set task
> state as TASK_RUNNING, if need_resched() returns true,
> while polling for IO completion.
> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> This made some IO take very long when interrupt-coalescing is enabled in
> NVMe.

Thanks, applied.

-- 
Jens Axboe

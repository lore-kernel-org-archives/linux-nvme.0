From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 13 Dec 2018 13:39:29 -0700
Subject: [PATCH] nvme: fix kernel paging oops
In-Reply-To: <20181213203407.2374-1-sagi@grimberg.me>
References: <20181213203407.2374-1-sagi@grimberg.me>
Message-ID: <ab607e4c-6277-90ef-2608-4251fe218974@kernel.dk>

On 12/13/18 1:34 PM, Sagi Grimberg wrote:
> free the controller discard_page correctly.

Huh, I wonder why I haven't hit that. But obviously correct...

Christoph, I'll apply this one directly.

-- 
Jens Axboe

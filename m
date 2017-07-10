From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 13:13:35 +0300
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <20170710091054.GD5105@linux-x5ow.site>
References: <20170707094838.GD16648@linux-x5ow.site>
 <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>
 <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
 <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>
 <20170710091054.GD5105@linux-x5ow.site>
Message-ID: <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>


> Tried up to 120 now, still broken.

Then something else is broken. 120 seconds is literally forever
in IB world. can you please turn on pr_debug in
nvmet_execute_keep_alive() and check that the target sees it
in a timely manner?

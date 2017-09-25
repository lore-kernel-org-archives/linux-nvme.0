From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Sep 2017 08:37:44 +0300
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
In-Reply-To: <20170921051915.cfj2j5vu4bjqn5za@linux-x5ow.site>
References: <20170920104032.14014-1-jthumshirn@suse.de>
 <20170920145931.GA5208@lst.de>
 <20170921051915.cfj2j5vu4bjqn5za@linux-x5ow.site>
Message-ID: <83264609-d5f9-8990-d79e-0b6eed1b2471@grimberg.me>


> So why exposing it then in the first time? I know you don't want dm-mpath in
> NVMe (neither do I) but we have to have something until your patchset and ANA
> is merged. And with this patch it's trivial to build a path checker that just
> looks at the state attribute in sysfs.

Can't we just not use path-checkers for nvme (we already have one in
nvme)?

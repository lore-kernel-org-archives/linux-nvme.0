From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 30 Mar 2017 16:05:25 +0300
Subject: [PATCH 1/1] nvme: don't ignore tagset allocation failures
In-Reply-To: <6e05fb1e-edf2-2b0d-b680-7fddf1e3ecf1@mellanox.com>
References: <1490778212-11007-1-git-send-email-maxg@mellanox.com>
 <a7db55a8-d40a-81e9-332e-2bd0306687bc@grimberg.me>
 <20170329173241.GC20181@localhost.localdomain>
 <fb263c4e-0403-c39c-1c88-be47d846c2b6@grimberg.me>
 <20170329231029.GE20181@localhost.localdomain>
 <0d85bb44-eb90-8712-1fcd-2f0885649cdf@grimberg.me>
 <6e05fb1e-edf2-2b0d-b680-7fddf1e3ecf1@mellanox.com>
Message-ID: <72a31473-8d8c-a278-e87b-2af799e3a7c6@grimberg.me>


> hi Sagi,
>
> what do you think about this solution that we don't keep the ctrl:

I'd say that if you got a transient error, try reset again...

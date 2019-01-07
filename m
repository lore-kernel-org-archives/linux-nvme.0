From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 7 Jan 2019 09:59:23 -0600
Subject: [PATCH v3] nvmet-rdma: fix null dereference under heavy load
In-Reply-To: <b5f8ffb7-b912-60d1-95e3-0cb49899b771@grimberg.me>
References: <20190103173531.7987-1-rajur@chelsio.com>
 <b5f8ffb7-b912-60d1-95e3-0cb49899b771@grimberg.me>
Message-ID: <3c2a416a-89c0-d63c-aedf-4f871dc26fc8@opengridcomputing.com>


On 1/3/2019 5:13 PM, Sagi Grimberg wrote:
> Wonder how the original fix got a tested-by...
>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

That was my bad.? But the testers said they couldn't reproduce the
issue, so I assumed that meant it was fixed.? I guess they weren't
stressing it enough.

Steve.

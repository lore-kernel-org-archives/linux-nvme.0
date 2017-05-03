From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 May 2017 19:01:14 +0300
Subject: [PATCH v4, under testing] nvme-rdma: support devices with queue
 size < 32
In-Reply-To: <1493827096.3901.4.camel@sandisk.com>
References: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
 <823aa3f0-685f-4569-11d6-238cc4f0b126@grimberg.me>
 <780938034.8003164.1493824767084.JavaMail.zimbra@kalray.eu>
 <20170503155316.GA14334@obsidianresearch.com>
 <1493827096.3901.4.camel@sandisk.com>
Message-ID: <77ada146-67eb-9dce-d252-6ac630c9a1e8@grimberg.me>


> Hello Jason,
>
> As far as I know the compiler only does that for compile-time constants. In
> this case the divisor (max(queue_size / 2, 1)) is not a compile-time constant.

We could theoretically do a (sig_count & max(queue_size / 2, 1)) but
that would only do well with power of 2 sized queues...

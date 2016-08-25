From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 26 Aug 2016 01:06:47 +0300
Subject: nvme_rdma - leaves provider resources allocated
In-Reply-To: <023301d1ff1c$79333020$6b999060$@opengridcomputing.com>
References: <014301d1fd5f$a2da7000$e88f5000$@opengridcomputing.com>
 <98396d58-4a16-0e1f-e42b-912edb8a7cf6@grimberg.me>
 <006501d1fe11$2c3e6200$84bb2600$@opengridcomputing.com>
 <ef285ffd-a176-b86d-beb3-2cfe9e10c5ea@grimberg.me>
 <023301d1ff1c$79333020$6b999060$@opengridcomputing.com>
Message-ID: <54db331d-22c8-3aa2-036e-775bcf9e0b15@grimberg.me>


> This won't quite do it.  The reconnect thread can timeout and give up before any
> event arrives, and that path also needs to destroy the queue resources if it was
> allocated.  This is my current patch.  I appreciate any comments.  (but I'll
> resend this formally tomorrow with other changes)...

Makes sense...

With 2 patches now adding queue flags I think it's time to ramp
a proper state machine? Looks like we starting to need it for
all the corner cases...

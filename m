From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 20 Mar 2019 08:08:48 -0700
Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
Message-ID: <1553094528.65329.29.camel@acm.org>

On Tue, 2019-03-19@16:41 +0200, Maxim Levitsky wrote:
> * Polling kernel thread is used. The polling is stopped after a 
> predefined timeout (1/2 sec by default).
> Support for all interrupt driven mode is planned, and it shows promising results.

Which cgroup will the CPU cycles used for polling be attributed to? Can the
polling code be moved into user space such that it becomes easy to identify
which process needs most CPU cycles for polling and such that the polling
CPU cycles are attributed to the proper cgroup?

Thanks,

Bart.

From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 5 Sep 2017 04:53:56 -0700
Subject: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
In-Reply-To: <1503605798.2899.43.camel@wdc.com>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
 <1503512512.2484.16.camel@wdc.com> <20170824085954.GD19504@lst.de>
 <1503605798.2899.43.camel@wdc.com>
Message-ID: <20170905115356.GA16927@infradead.org>

On Thu, Aug 24, 2017@08:17:32PM +0000, Bart Van Assche wrote:
> For NVMe over RDMA, how about the simulate_network_failure_loop() function in
> https://github.com/bvanassche/srp-test/blob/master/lib/functions? It simulates
> a network failure by writing into the reset_controller sysfs attribute.

FYI, I've tested lots of reset_controllers.  But automatic them is of
course even better.

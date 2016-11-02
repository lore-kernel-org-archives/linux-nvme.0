From: hch@lst.de ('Christoph Hellwig')
Date: Wed, 2 Nov 2016 16:15:40 +0100
Subject: nvmet_rdma crash - DISCONNECT event with NULL queue
In-Reply-To: <004601d2351a$d9db85b0$8d929110$@opengridcomputing.com>
References: <6f42d056-284d-00fc-2b98-189f54957980@grimberg.me>
 <01cc01d2345b$d445acd0$7cd10670$@opengridcomputing.com>
 <4cc25277-429a-4ab9-470c-b3af1428ce93@grimberg.me>
 <01d101d2345e$2f054390$8d0fcab0$@opengridcomputing.com>
 <dbe5f18d-7928-f065-920f-753b30fb99a2@grimberg.me>
 <01d901d2345f$da0d2e00$8e278a00$@opengridcomputing.com>
 <1d09c064-1cbe-7e6e-43d2-cfa6cf0c19ea@grimberg.me>
 <024e01d23476$6668b890$333a29b0$@opengridcomputing.com>
 <3512b8bb-4d29-b90a-49e1-ebf1085c47d7@grimberg.me>
 <004601d2351a$d9db85b0$8d929110$@opengridcomputing.com>
Message-ID: <20161102151540.GB14825@lst.de>

On Wed, Nov 02, 2016@10:07:38AM -0500, Steve Wise wrote:
> I'm not sure I understand the "subsystem" concept.  I never noticed before that
> any target device had the same controller ID.  The target json config file is
> inserted below.  There are 10 ramdisks exported over 2 ports of a cxgb4 40GE
> device and 1 port of an mlx4 RoCE device.   For this test, the NVMF host
> connects to all 10 targets over 1 port of the cxgb4 device.  Like this:

Yes, you have multiple subsystems.  It's sort of the NVMe equivalent
of a target which can have multiple LUNs, aka Namespaces in NVMe.

Btw, I want to actually make the ctrlid global for the target instead of
per-subsystem to ease a few things, and debuggability is just one more
on the list.

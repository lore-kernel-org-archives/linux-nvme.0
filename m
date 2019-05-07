From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Tue, 7 May 2019 11:44:58 -0600
Subject: [PATCH v2 6/7] nvme-pci: add device coredump support
In-Reply-To: <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
Message-ID: <eb4f578c-2126-c4e8-97a9-2f65e4784359@intel.com>



On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> This enables to capture snapshot of controller information via device
> coredump machanism.

s/machanism/mechanism/

> 
> The nvme device coredump creates the following coredump files.
> 
> - regs: NVMe controller registers (00h to 4Fh)
> - sq<qid>: Submission queue
> - cq<qid>: Completion queue
> - telemetry-ctrl-log: Telemetry controller-initiated log (if available)
> - data: Empty
> 
> The reason for an empty 'data' file is to provide a uniform way to notify
> the device coredump is no longer needed by writing the 'data' file.
> 
> Since all existing drivers using the device coredump provide a 'data' file
> if the nvme device coredump doesn't provide it, the userspace programs need
> to know which driver provides what coredump file.
> 
> Cc: Johannes Berg <johannes at sipsolutions.net>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev at gmail.com>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>

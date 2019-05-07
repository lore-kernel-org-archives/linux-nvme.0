From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Tue, 7 May 2019 11:43:56 -0600
Subject: [PATCH v2 0/7] nvme-pci: support device coredump
In-Reply-To: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <99ac233a-e8d6-495b-5ec9-f7067fa40c4b@intel.com>



On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> This enables to capture snapshot of controller information via device
> coredump machanism, and it helps diagnose and debug issues.

s/machanism/mechanism/
> 
> The nvme device coredump is triggered when command timeout occurs, and
> creates the following coredump files.
> 
>   - regs: NVMe controller registers (00h to 4Fh)
>   - sq<qid>: Submission queue
>   - cq<qid>: Completion queue
>   - telemetry-ctrl-log: Telemetry controller-initiated log (if available)
>   - data: Empty

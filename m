From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Oct 2017 10:44:40 -0600
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
Message-ID: <20171027164440.GA8644@localhost.localdomain>

On Fri, Oct 27, 2017@10:35:58AM -0600, Jens Axboe wrote:
> If someone attempts to do IO to a drive while it is under format,
> we risk timing out that IO. That potentially leads to the driver
> triggering a controller reset, and subsequently the format is ruined and
> the device goes away.
> 
> Prevents this by freezing IO access to the device around a format.
> Without this, the following set of commands can easily make your device
> disappear:
> 
> parted -s /dev/nvme3n1 mklabel gpt
> parted -s /dev/nvme3n1 mkpart primary 0G 100G
> parted -s /dev/nvme3n1 rm 1
> nvme format /dev/nvme3
> 
> since the last partition removal will trigger a udev partition reload,
> which happens while the format is running. If the format takes longer
> than the normal IO timeout, we start timing it out:
> 
> [  456.799438]  nvme3n1:
> [  456.833656]  nvme3n1: p1
> [  456.842025]  nvme3n1: p1
> [  456.887368]  nvme3n1:
> [  487.699023] nvme nvme3: I/O 879 QID 12 timeout, aborting
> [  518.098840] nvme nvme3: I/O 879 QID 12 timeout, reset controller
> [  571.700471] nvme nvme3: Abort status: 0x7
> [  571.798306] nvme nvme3: Removing after probe failure status: -22
> [  571.811330] nvme3n1: detected capacity change from 4000787030016 to 0
> [  571.819189] print_req_error: I/O error, dev nvme3n1, sector 7814036992
> 
> and the device is gone, needing a driver reload or reboot to bring it
> back. Same thing happens if you just do a dd from the device and then
> start a format. Behavior is vendor agnostic, basically just timing
> dependent.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>

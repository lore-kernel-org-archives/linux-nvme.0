From: james.smart@broadcom.com (James Smart)
Date: Sun, 14 Jul 2019 07:49:14 -0700
Subject: [PATCH rfc v2 09/10] nvme-cli: add --quiet option
In-Reply-To: <46dcab64-c4f9-74dc-b75c-4f4b8926051d@grimberg.me>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-10-jsmart2021@gmail.com>
 <46dcab64-c4f9-74dc-b75c-4f4b8926051d@grimberg.me>
Message-ID: <898fcfa4-e70f-fd0d-0905-cc4af74d4cda@broadcom.com>



On 7/12/2019 10:35 AM, Sagi Grimberg wrote:
>
> Q is already a short-arg (queue-size). Lets have it 'S' (stand for 
> Suppress). 

ok...

> Also, when I tested it locally for some reason it did not
> take:
> -- 
> Jul 12 17:30:00 nvmc systemd[1]: Started NVMf auto-connect scan upon 
> nvme discovery controller Events.
> Jul 12 17:30:00 nvmc sh[2767]: Failed to write to /dev/nvme-fabrics: 
> Operation already in progress
> Jul 12 17:30:00 nvmc sh[2767]: traddr=192.168.123.1 is already connected
> Jul 12 17:30:00 nvmc kernel: nvme nvme2: creating 4 I/O queues.
> Jul 12 17:30:00 nvmc kernel: nvme nvme2: mapped 4/0/0 
> default/read/poll queues.
> Jul 12 17:30:00 nvmc kernel: nvme nvme2: new ctrl: NQN "testnqn2", 
> addr 192.168.123.1:8009
> -- 
>
> Adding print to add_ctrl:
> Jul 12 17:30:00 nvmc sh[2767]: errno 114 quiet 0
>
> When I pass it manually it works, but not from udev... Not sure what
> is going on...

?? I'll check it on my side

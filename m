From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 6 Mar 2017 13:23:33 +0200
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
References: <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
Message-ID: <95e045a8-ace0-6a9a-b9a9-555cb2670572@grimberg.me>


> Hi experts
>
> I reproduced this issue during stress test on reset_controller, could you help check it, thanks.
>
> Reproduce steps on initiator side:
> num=0
> while [ 1 ]
> do
> 	echo "-------------------------------$num"
> 	echo 1 >/sys/block/nvme0n1/device/reset_controller || exit 1
> 	((num++))
> done
>
> Here is the full log:
> http://pastebin.com/mek9fb0b

I'm using CX5-LX device and have not seen any issues with it.

Would it be possible to retest with kmemleak?

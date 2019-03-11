From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 15:58:02 -0700
Subject: [PATCH v2] nvme: test out-of-range I/O access (file backend)
In-Reply-To: <20190311224904.GE1315@vader>
References: <20190311221855.27375-1-sagi@grimberg.me>
 <20190311224904.GE1315@vader>
Message-ID: <763669e2-7a87-6876-feae-49e82c5d4c8f@grimberg.me>


> Ah, so this fails for me because I have nvme-cli 1.7 which is missing
> your 9c891c139894 ("nvmet: check fileio lba range access boundaries").
> How about we just look at the exit code of nvme read instead of relying
> on that output?

Fine by me, you can fold it in..

> 
> diff --git a/tests/nvme/018 b/tests/nvme/018
> index 30140ae..b09c29c 100755
> --- a/tests/nvme/018
> +++ b/tests/nvme/018
> @@ -2,7 +2,8 @@
>   # SPDX-License-Identifier: GPL-3.0+
>   # Copyright (C) 2018 Sagi Grimberg
>   #
> -# Test NVMe out of range access on a file backend
> +# Test NVMe out of range access on a file backend. Regression test for commit
> +# 9c891c139894 ("nvmet: check fileio lba range access boundaries").
>   
>   . tests/nvme/rc
>   
> @@ -38,11 +39,12 @@ test() {
>   	cat "/sys/block/${nvmedev}n1/uuid"
>   	cat "/sys/block/${nvmedev}n1/wwid"
>   
> -	sectors=$(blockdev --getsz /dev/${nvmedev}n1)
> -	bs=$(blockdev --getbsz /dev/${nvmedev}n1)
> +	local sectors
> +	local bs
> +	sectors="$(blockdev --getsz "/dev/${nvmedev}n1")"
> +	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
>   
> -	nvme read "/dev/${nvmedev}n1" -s $sectors -c 0 -z $bs
> -	if [[ ! $? ]]; then
> +	if nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs"; then
>   		echo "ERROR: Successfully read out of device lba range"
>   	fi
>   
> diff --git a/tests/nvme/018.out b/tests/nvme/018.out
> old mode 100755
> new mode 100644
> index 0ab3b2a..68a0194
> --- a/tests/nvme/018.out
> +++ b/tests/nvme/018.out
> @@ -1,6 +1,5 @@
>   Running nvme/018
>   91fdba0d-f87b-4c25-b80f-db7be1418b9e
>   uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
> -read:CAP_EXCEEDED: The execution of the command has caused the capacity of the namespace to be exceeded(6081)
>   NQN:blktests-subsystem-1 disconnected 1 controller(s)
>   Test complete
> 

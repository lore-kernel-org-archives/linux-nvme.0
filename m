From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Tue, 02 Jun 2015 09:58:34 +0200
Subject: NVMe scalability issue
In-Reply-To: <1433199171.7699.22.camel@ssi>
References: <1433199171.7699.22.camel@ssi>
Message-ID: <556D622A.805@bjorling.me>

On 06/02/2015 12:52 AM, Ming Lin wrote:
> Hi list,
>
> [global]
> rw=randread
> bs=4k
> direct=1
> ioengine=libaio
> iodepth=64
> time_based
> runtime=60
> group_reporting
> numjobs=4
>
> [job0]
> filename=/dev/nvme0n1
>
> [job1]
> filename=/dev/nvme1n1
>
> [job2]
> filename=/dev/nvme2n1
>
> [job3]
> filename=/dev/nvme3n1
>
> [job4]
> filename=/dev/nvme4n1
>
> [job5]
> filename=/dev/nvme5n1
>
> [job6]
> filename=/dev/nvme6n1
>
> [job7]
> filename=/dev/nvme7n1
>

A wild guess, the jobs might run on a remote CPU compared to the device. 
Try to affinitize the jobs so they run on the CPU with the attached device.

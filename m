From: pickup112@gmail.com (=?UTF-8?B?5p2O5pil?=)
Date: Thu, 31 May 2018 12:09:12 +0800
Subject: can not load more than 51 nvme rdma device
In-Reply-To: <47711850-d805-d5b3-2b7b-ed9acbee514a@mellanox.com>
References: <CAGpjB9J2F3VhGnPe+uXSmuu-H0dTfbQT+5fOem4j_vsBcwGfwQ@mail.gmail.com>
 <47711850-d805-d5b3-2b7b-ed9acbee514a@mellanox.com>
Message-ID: <CAGpjB9Lfe7snBNTjcJAnvGjiLHuW2PpzkXrcs_wGcmcTvYP62Q@mail.gmail.com>

Hi Max:
I found the command to get a max_mr of mellanox card: ibv_devinfo -v
|grep max_mr.
Two network card are plugged into our servers: 100GbE ConnectX-5 and
56Gb ConnectX-3. The output is as follows. The max_mr of ConnectX-5
cards is 32 times that of ConnectX-3:
```
#ibv_devinfo -v |grep max_mr
         Max_mr_size: 0xffffffffffffffff
         Max_mr: 16777216
         Max_mr_size: 0xffffffffffffffff
         Max_mr: 16777216
         Max_mr_size: 0xffffffffffffffff
         Max_mr: 524032
```
As you said, a 100GbE network card can create more than 51 subsystems.
But I still have a few questions:
* Is there a precise calculation formula to calculate how many
subsystems a network card can support?
Max Gurtovoy <maxg at mellanox.com> ?2018?5?16??? ??5:47???
>
>
>
> On 5/16/2018 8:57 AM, ?? wrote:
> > Hi:
>
> Hi,
>
> >
> > I encountered a problem of nvme-rdma on mellanox network card.
> > Thanks in advance for your help.
> >
> >
> > # Problem Description
> >
> > ## Steps to Reproduce
> > * Two nodes (nodeA, nodeB) are linked through the mellanox 56Gb
> > connectX-3 network card.
> > * nodeA outputs 100 disks through 100 subsystems via nvmet-rdma, one disk
> > per subsystem.
>
> Any reason for this type of 1:1 configuration ?
> Can you expose all 100 disks using 1 subsystem or 10 disks per subsystem ?
> Do you understand the difference in resource allocation between both cases ?
>
> > * Load the disk with "nvme connect" on nodeB. When it is loaded into
> > the 51st disk, it will complain ```Failed to write to
> > /dev/nvme-fabrics: Cannot allocate memory```. The disk load command is as
> > follows, using 10 queues to load the disk:
>
> This is because you try to allocate more MRs that the maximum support of
> the device.
> In NVNe/RDMA We create "queue-size" number of MRs per each created IO queue.
>
> >
> > ```
> > nvme connect -t rdma -a 172.16.128.51 -s 4421 -n s01.4421.01
> > --nr-io-queues=10 -k 1 -l 6000 -c 1 -q woqu
>
> try to use --queue-size=16 in your conect command.
> You don't realy need so many resources (10 io queues with 128 queue-size
> each) to saturate 56Gb wire.
>
> > ```
> >
> > * If you load the disk with 1 queue at this time, it can be loaded
> > successfully without error.
> >
> > * Additional Information: This problem does not occur when we load
> > with a 100GbE network adapter.
>
> The max_mr for this adapter is much bigger.
> If the above solutions are not enough, then we can dig-in more to low
> level drivers...
>
> >
> >
> > ## log information
> > * When the nodeB is normally loaded, the /var/log/message information is as
> > follows:
> >
> > ```
> > May 8 19:10:37 qdata-lite52-dev kernel: nvme nvme47: creating 10 I/O queues.
> > May 8 19:10:37 qdata-lite52-dev kernel: nvme nvme47: new ctrl: NQN
> > "s01.4421.48", addr 172.16.128.51:4421
> > ```
> >
> >
> > * Warning message when loading the 50th disk
> > ```
> > May 8 15:26:55 qdata-lite52-dev kernel: nvme nvme50: creating 10 I/O queues.
> > May 8 15:26:55 qdata-lite52-dev kernel: blk-mq: reduced tag depth (128 ->
> > 16)
> > May 8 15:26:55 qdata-lite52-dev kernel: nvme nvme50: new ctrl: NQN
> > "s01.4421.45", addr 172.16.128.51:4421
> > ```
> >
> >
> > * Error will be reported when loading the 51st disk
> > ```
> > May 8 15:26:55 qdata-lite52-dev kernel: blk-mq: reduced tag depth (31 -> 15)
> > May 8 15:26:55 qdata-lite52-dev kernel: nvme nvme51: creating 10 I/O queues.
> > May 8 15:26:55 qdata-lite52-dev kernel: blk-mq: failed to allocate request
> > map
> > ```
> >
> >
> > ## environment
> >
> > * OS?rhel 7.4
> > * network card?56Gb ConnectX-3
> > ```
> > 44:00.0 Network controller: Mellanox Technologies MT27500 Family
> > [ConnectX-3]
> > ```
> >
> >



-- 
?? Pickup Li
?????  ?????

www.woqutech.com
????????????

?????????1190?????A?1004?  310052
Hangzhou WOQU Technology Co., Ltd.
Room 1004, Building A, D-innovation Center, No. 1190, Bin' an road,
Hangzhou 310052


T?(0571) 87770835
M?(86)18989451982
F?(0571) 86805750
E?pickup.li at woqutech.com

From: yyt168@gmail.com (Tony Yang)
Date: Mon, 25 Dec 2017 14:57:47 +0800
Subject: How to Persistent nvme Storage?
In-Reply-To: <8b1b3096-5c03-6f8d-b3f2-fe0cfa025a5b@grimberg.me>
References: <CADL4p-oX+AojAs-rSL5CY_p2hZYaK_cJ+Px+NkVeKhh428OUDw@mail.gmail.com>
 <8b1b3096-5c03-6f8d-b3f2-fe0cfa025a5b@grimberg.me>
Message-ID: <CADL4p-r1bLz4jM_YoJbanBVE3kPDuoy35iJyRGPSt7KATYUeDQ@mail.gmail.com>

Thanks .

      Merry Christmas?I'm sorry to bother you at the festival, but I
really need your help, I downloaded the latest nvme-cli version,
currently 1.4, I use two ib cards to connect to the same device, but I
do not know how to use it Multipathing binds these two nvme
devices.Hope to receive your reply?Thanks


[root at cesdb01 ~]# dmesg | grep "enabling port"
[   69.753031] nvmet_rdma: enabling port 1 (10.1.1.21:4420)
[18730.016827] nvmet_rdma: enabling port 2 (10.1.1.121:4420)
[root at cesdb01 ~]# nvme discover -t rdma -a 10.1.1.121 -s 4420

Discovery Log Number of Records 1, Generation counter 5
=====Discovery Log Entry 0======
trtype:  rdma
adrfam:  ipv4
subtype: nvme subsystem
treq:    not specified
portid:  2
trsvcid: 4420

subnqn:  CESDB01A
traddr:  10.1.1.121

rdma_prtype: not specified
rdma_qptype: connected
rdma_cms:    rdma-cm
rdma_pkey: 0x0000
[root at cesdb01 ~]# nvme connect -t rdma -n CESDB01A  -a 10.1.1.21 -s 4420
[root at cesdb01 ~]# nvme connect -t rdma -n CESDB01A  -a 10.1.1.121 -s 4420
[root at cesdb01 ~]# nvme list
Node             SN                   Model
        Namespace Usage                      Format           FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1     66903eb81cd10252     Linux
        10          3.20  TB /   3.20  TB    512   B +  0 B   4.13.0-r
/dev/nvme1n1     66903eb81cd10252     Linux
        10          3.20  TB /   3.20  TB    512   B +  0 B   4.13.0-r

[root at cesdb01 ~]# nvme -version
nvme version 1.4

2017-12-21 3:04 GMT+08:00 Sagi Grimberg <sagi at grimberg.me>:
> Tony,
>
>> Dear All:
>>
>>        I download the new nvme multipath version (git clone from
>> git.infradead.org nvme.git),I want to know how to use the
>>        multipath, because I want use udev to Persistent Storage,But
>> when use scsi_id command not found any messages.
>>        What method can nvme achieve multi-path? Can you provide an
>> example? Thank you
>
>
> If you opt in CONFIG_NVME_MULTIPATH the nvme device nodes you see
> will actually be multipath devices (no scsi device identification
> needed). Johannes submitted a nvme-cli code to get some more information
> wrt to multipathing.

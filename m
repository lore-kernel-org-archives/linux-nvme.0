From: sudheendra.sampath@gmail.com (Sudheendra Sampath)
Date: Fri, 12 Oct 2018 11:08:21 -0700
Subject: Help needed: nvmet configuration
Message-ID: <CABnqofxasv=-xbQQ+XZH8jad4Oa0gnvKusk5sF_a-kdSLvK1Ww@mail.gmail.com>

Hello,


I am using nvmetcli to configure the target.


Below are the steps that I am following :


[root at test38 config]# modprobe -v iw_cxgb4

insmod /lib/modules/4.15.0/kernel/drivers/net/ethernet/chelsio/libcxgb/libcxgb.ko

insmod /lib/modules/4.15.0/kernel/drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko

insmod /lib/modules/4.15.0/kernel/drivers/infiniband/core/ib_core.ko

insmod /lib/modules/4.15.0/kernel/drivers/infiniband/hw/cxgb4/iw_cxgb4.ko

[root at test38 config]# modprobe -v rdma_ucm

insmod /lib/modules/4.15.0/kernel/drivers/infiniband/core/ib_cm.ko

insmod /lib/modules/4.15.0/kernel/drivers/infiniband/core/iw_cm.ko

insmod /lib/modules/4.15.0/kernel/drivers/infiniband/core/rdma_cm.ko

insmod /lib/modules/4.15.0/kernel/drivers/infiniband/core/ib_uverbs.ko

insmod /lib/modules/4.15.0/kernel/drivers/infiniband/core/rdma_ucm.ko

[root at test38 config]# ifup enp59s0

Connection successfully activated (D-Bus active path:
/org/freedesktop/NetworkManager/ActiveConnection/4)

[root at test38 config]# modprobe -v null_blk

insmod /lib/modules/4.15.0/kernel/drivers/block/null_blk.ko

[root at test38 config]# modprobe -v nvmet

insmod /lib/modules/4.15.0/kernel/drivers/nvme/target/nvmet.ko

[root at test38 config]# modprobe -v nvmet-rdma

insmod /lib/modules/4.15.0/kernel/drivers/nvme/target/nvmet-rdma.ko

[root at test38 config]# nvme list

Node             SN                   Model
        Namespace Usage                      Format           FW Rev

---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------

/dev/nvme0n1     S3VJNY0K500089       SAMSUNG MZQLB3T8HALS-000AZ
        1           0.00   B /   3.84  TB    512   B +  0 B   ETA50K18

/dev/nvme1n1     S3VJNY0K500104       SAMSUNG MZQLB3T8HALS-000AZ
        1           0.00   B /   3.84  TB    512   B +  0 B   ETA50K18

[root at test38 config]# nvmetcli

/> cd subsystems

/subsystems> create testvm

/subsystems> cd testvm/namespaces

/subsystems/testvm/namespaces> create nsid=1

/subsystems/testvm/namespaces> cd 1

/subsystems/t.../namespaces/1> set device path=/dev/nvme0n1

Parameter path is now '/dev/nvme0n1'.

/subsystems/t.../namespaces/1> cd ../../

/subsystems/testvm> set attr allow_any_host=1

Parameter allow_any_host is now '1'.

/subsystems/testvm> cd namespaces/1

/subsystems/t.../namespaces/1> enable

The Namespace has been enabled.

/subsystems/t.../namespaces/1> cd ../../../..

/> cd ports

/ports> create 1

/ports> cd 1

/ports/1> set addr adrfam=ipv4

Parameter adrfam is now 'ipv4'.

/ports/1> set addr trtype=rdma

Parameter trtype is now 'rdma'.

/ports/1> set addr trsvcid=4420

Parameter trsvcid is now '4420'.

/ports/1> set addr traddr=12.12.12.38

Parameter traddr is now '12.12.12.38'.

/ports/1> cd subsystems

/ports/1/subsystems> create testvm

Could not symlink testvm in configFS: [Errno 19] No such device

/ports/1/subsystems> exit


When I look at ?dmesg?, I see :



[Fri Oct 12 10:42:16 2018] null: module loaded

[Fri Oct 12 10:42:54 2018] nvmet: adding nsid 1 to subsystem testvm

[Fri Oct 12 10:44:53 2018] nvmet_rdma: binding CM ID to
12.12.12.38:4420 failed (-19)

[root at test38 config]#





enp216s0f0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9000

        inet 12.12.14.38  netmask 255.255.255.0  broadcast 12.12.14.255

        inet6 fe80::ee0d:9aff:fe9c:93a2  prefixlen 64  scopeid 0x20<link>

        ether ec:0d:9a:9c:93:a2  txqueuelen 1000  (Ethernet)

        RX packets 2  bytes 120 (120.0 B)

        RX errors 0  dropped 0  overruns 0  frame 0

        TX packets 16  bytes 1196 (1.1 KiB)

        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0



root at test38 config]# lsmod | grep nvme

nvme_rdma              32768  0

nvme_fabrics           24576  1 nvme_rdma

nvmet_rdma             28672  0

rdma_cm                69632  3 nvme_rdma,rdma_ucm,nvmet_rdma

ib_core               253952  9
ib_cm,rdma_cm,ib_umad,nvme_rdma,ib_uverbs,iw_cm,ib_ucm,rdma_ucm,nvmet_rdma

nvmet                  61440  7 nvmet_rdma

nvme                   45056  0

nvme_core              77824  4 nvme_fabrics,nvme_rdma,nvme

[root at test38 config]# uname -r

4.15.0

[root at test38 config]#



Below is my target setup configuration :



{

  "hosts": [],

  "ports": [

    {

      "addr": {

        "adrfam": "ipv4",

        "traddr": "12.12.12.38",

        "treq": "not specified",

        "trsvcid": "4420",

        "trtype": "rdma"

      },

      "portid": 1,

      "referrals": [],

      "subsystems": []

    }

  ],

  "subsystems": [

    {

      "allowed_hosts": [],

      "attr": {

        "allow_any_host": "1",

        "serial": "472997b23fb70a38",

        "version": "1.3"

      },

      "namespaces": [

        {

          "device": {

            "nguid": "00000000-0000-0000-0000-000000000000",

            "path": "/dev/nvme0n1",

            "uuid": "1e6b9ac5-1623-4349-bd43-5843642b6c91"

          },

          "enable": 1,

          "nsid": 1

        }

      ],

      "nqn": "test"

    }

  ]

}



Here are the drives:



[root at xxxxx ~]# nvme list

Node             SN                   Model
        Namespace Usage                      Format           FW Rev

---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------

/dev/nvme0n1     xxxxxxxx       SAMSUNG xxxxxxxx-000AZ               1
          0.00   B /   3.84  TB    512   B +  0 B   ABCDEF

/dev/nvme1n1     xxxxxxxx       SAMSUNG xxxxxxxx-000AZ               1
          0.00   B /   3.84  TB    512   B +  0 B   ABCDEF

[root at xxxxx ~]#



[root at test38 config]# pwd

/sys/kernel/config



[root at test38 config]# tree nvmet/

nvmet/

??? hosts

??? ports

?   ??? 1

?       ??? addr_adrfam

?       ??? addr_traddr

?       ??? addr_treq

?       ??? addr_trsvcid

?       ??? addr_trtype

?       ??? referrals

?       ??? subsystems

??? subsystems

    ??? test

        ??? allowed_hosts

        ??? attr_allow_any_host

        ??? attr_serial

        ??? attr_version

        ??? namespaces

            ??? 1

                ??? device_nguid

                ??? device_path

                ??? device_uuid

                ??? enable



10 directories, 12 files



Any help appreciated.



Thanks,



-Sudheendra G Sampath


-- 
Regards

Sudheendra Sampath

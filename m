From: narayan.ayalasomayajula@kazan-networks.com (Narayan Ayalasomayajula)
Date: Mon, 12 Sep 2016 20:49:29 +0000
Subject: Failure with 8K Write operations
Message-ID: <BY2PR08MB181580B3E2779DAF024CAD7DC0FF0@BY2PR08MB1815.namprd08.prod.outlook.com>

Hello All,

I am running into a failure with the 4.8.0 branch and wanted to see this is a known issue or whether there is something I am not doing right in my setup/configuration. The issue that I am running into is that the Host is indicating a NAK (Remote Access Error) condition when executing an FIO script that is performing 100% 8K Write operations. Trace analysis shows that the target has the expected Virtual Address and R_KEY values in the READ REQUEST but for some reason, the Host flags the request as an access violation. I ran a similar test with iWARP Host and Target systems and the did see a Terminate followed by FIN from the Host. The cause for both failures appears to be the same.

The details of the configuration on the Host and Target systems are provided below and attached as well.

The repository where I retrieved the 4.8.0 branch is:

       git clone git://git.infradead.org/nvme-fabrics.git --branch=nvmf-4.8-rc

Test Configuration:
The Linux Host is using a ConnectX-4 (single port 100G, firmware-version: 12.16.1020) connected to a Mellanox switch and the Linux Target is a ConnectX-3 (single port 10G, firmware-version: 2.36.5000) connected to the same switch. Normal flow control is enabled on all ports of the switch (along with Jumbo frame). I am using null_blk as the target (so the IOs are not being serviced by a "real" nvme target).

FIO script:
        [global]
?????? ioengine=libaio
?????? direct=1

?????? runtime=10m
?????? size=800g
?????? time_based
?????? norandommap
?????? group_reporting

?????? bs=8k
?????? numjobs=8
?????? iodepth=16
?????? 

?????? [rand_write]
?????? filename=/dev/nvme0n1
?????? rw=randwrite

If I missed providing any information on the failure, please let me know. Any help or guidance is appreciated.

Thanks,
Narayan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Configuration_for_NAK_issue.docx
Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document
Size: 13396 bytes
Desc: Configuration_for_NAK_issue.docx
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160912/8ca9b75d/attachment-0003.docx>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Linux_Host_dmesg_log_for_NAK_issue.docx
Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document
Size: 17285 bytes
Desc: Linux_Host_dmesg_log_for_NAK_issue.docx
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160912/8ca9b75d/attachment-0004.docx>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Linux_Target_dmesg_log_for_NAK_issue.docx
Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document
Size: 20879 bytes
Desc: Linux_Target_dmesg_log_for_NAK_issue.docx
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160912/8ca9b75d/attachment-0005.docx>

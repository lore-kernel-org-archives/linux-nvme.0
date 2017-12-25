From: yyt168@gmail.com (Tony Yang)
Date: Mon, 25 Dec 2017 16:13:16 +0800
Subject: How to Persistent nvme Storage?
In-Reply-To: <5b609220-cb69-6995-6422-5f203bfb3cfb@grimberg.me>
References: <CADL4p-oX+AojAs-rSL5CY_p2hZYaK_cJ+Px+NkVeKhh428OUDw@mail.gmail.com>
 <8b1b3096-5c03-6f8d-b3f2-fe0cfa025a5b@grimberg.me>
 <CADL4p-r1bLz4jM_YoJbanBVE3kPDuoy35iJyRGPSt7KATYUeDQ@mail.gmail.com>
 <66c5e406-6f4f-497f-9633-f1d85de7e303@grimberg.me>
 <CADL4p-qifp4VXTJuh6GkHsuMdFSCeHOYvXM7-+QuMTOq3imMtA@mail.gmail.com>
 <5b609220-cb69-6995-6422-5f203bfb3cfb@grimberg.me>
Message-ID: <CADL4p-pT6TpmYz5fCmJQQAFQzuttX=h20V-ROoHV67a9C-XMJg@mail.gmail.com>

Thanks Sagi

     I always use the latest nvme-cli

the download address is :https://github.com/linux-nvme/nvme-cli

[root at cesdb01 ~]# nvme -version
nvme version 1.4



2017-12-25 15:49 GMT+08:00 Sagi Grimberg <sagi at grimberg.me>:
>
>> [root at cesdb01 ~]# nvme list
>> Node             SN                   Model
>>          Namespace Usage                      Format           FW Rev
>> ---------------- --------------------
>> ---------------------------------------- ---------
>> -------------------------- ---------------- --------
>> /dev/nvme0n1     66903eb81cd10252     Linux
>>          10          3.20  TB /   3.20  TB    512   B +  0 B   4.13.0-r
>> /dev/nvme1n1     66903eb81cd10252     Linux
>>          10          3.20  TB /   3.20  TB    512   B +  0 B   4.13.0-r
>> /dev/nvme2n1     539f93d6b088e284     Linux
>>          10          3.20  TB /   3.20  TB    512   B +  0 B   4.13.0-r
>> /dev/nvme3n1     5dd2e0fe188db860     Linux
>>          10        600.13  GB / 600.13  GB    512   B +  0 B   4.13.0-r
>> /dev/nvme4n1     38718b8ad7d5e19b     Linux
>>          10          1.92  TB /   1.92  TB    512   B +  0 B   4.13.0-r
>> /dev/nvme5n1     a70df79680a5c834     Linux
>>          10          3.20  TB /   3.20  TB    512   B +  0 B   4.13.0-r
>> /dev/nvme6n1     f592f9994c0d6469     Linux
>>          10          2.00  TB /   2.00  TB    512   B +  0 B   4.13.0-r
>> /dev/nvme7n1     c6e151aae72ee9ec     Linux
>>          10          1.92  TB /   1.92  TB    512   B +  0 B   4.13.0-r
>> /dev/nvme8n1     66113fb757713fcd     Linux
>>          10          1.92  TB /   1.92  TB    512   B +  0 B   4.13.0-r
>> [root at cesdb01 ~]# nvme list-subsys
>> no NVMe subsystem(s) detected.
>> [root at cesdb01 ~]#
>
>
> Please make sure you are running with the latest nvme-cli:
> git at github.com:linux-nvme/nvme-cli.git

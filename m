From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 7 May 2019 01:54:09 +0900
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
In-Reply-To: <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>

> We need to get rid the string comparison as much as we can e.g.
> in following output the nvme-cli output should not be compared
> but the return value itself.
> 
> -Discovery Log Number of Records 1, Generation counter 1
> +Discovery Log Number of Records 1, Generation counter 2
> =====Discovery Log Entry 0======
> trtype: loop
> adrfam: pci
> subtype: nvme subsystem
> -treq: not specified
> +treq: not specified, sq flow control disable supported
> portid: X
> trsvcid:
> subnqn: blktests-subsystem-1
> 
> Reason :- we cannot rely on the output as it tends to change
> with development which triggers fixes in blktests, unless
> testcase is focused on entirely on examining the output of
> the tool.

Totally agree with you.  nvme-cli is going to keep updated and output 
format might be changed which may cause test failure in blktests.

If Johannes who wrote these tests agrees to not check output result from 
nvme-cli, I'll get rid of them.

By the way, Checking the return value of a program like nvme-cli might 
not be enough to figure out what happened because this test looks like 
wanted to check the output of discover get log page is exactly the same 
with what it wanted to be in case data size is greater than 4K.

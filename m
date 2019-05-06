From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 6 May 2019 16:46:42 +0000
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
Message-ID: <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>

On 05/06/2019 09:38 AM, Minwoo Im wrote:
> On 5/7/19 1:25 AM, Chaitanya Kulkarni wrote:
>> We need to get rid of the string comparison here.
> Chaitanya,
>
> Do you mean that test case bash script should check the result of output
> and return some error value instead of zero instead of *.out comparison ?
>
> Thanks,
>

We need to get rid the string comparison as much as we can e.g.
in following output the nvme-cli output should not be compared
but the return value itself.

-Discovery Log Number of Records 1, Generation counter 1
+Discovery Log Number of Records 1, Generation counter 2
=====Discovery Log Entry 0======
trtype: loop
adrfam: pci
subtype: nvme subsystem
-treq: not specified
+treq: not specified, sq flow control disable supported
portid: X
trsvcid:
subnqn: blktests-subsystem-1

Reason :- we cannot rely on the output as it tends to change
with development which triggers fixes in blktests, unless
testcase is focused on entirely on examining the output of
the tool.

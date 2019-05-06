From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 6 May 2019 17:47:34 +0000
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
Message-ID: <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>

On 05/06/2019 09:54 AM, Minwoo Im wrote:
>> We need to get rid the string comparison as much as we can e.g.
>> in following output the nvme-cli output should not be compared
>> but the return value itself.
>>
>> -Discovery Log Number of Records 1, Generation counter 1
>> +Discovery Log Number of Records 1, Generation counter 2
>> =====Discovery Log Entry 0======
>> trtype: loop
>> adrfam: pci
>> subtype: nvme subsystem
>> -treq: not specified
>> +treq: not specified, sq flow control disable supported
>> portid: X
>> trsvcid:
>> subnqn: blktests-subsystem-1
>>
>> Reason :- we cannot rely on the output as it tends to change
>> with development which triggers fixes in blktests, unless
>> testcase is focused on entirely on examining the output of
>> the tool.
>
> Totally agree with you.  nvme-cli is going to keep updated and output
> format might be changed which may cause test failure in blktests.
>
> If Johannes who wrote these tests agrees to not check output result from
> nvme-cli, I'll get rid of them.
>
> By the way, Checking the return value of a program like nvme-cli might
> not be enough to figure out what happened because this test looks like
> wanted to check the output of discover get log page is exactly the same
> with what it wanted to be in case data size is greater than 4K.
>

I wasn't clear enough.

It doesn't check for the return value for now. What needs to happen is :-

1. Get rid of the variable strings which are not part of the discovery
    log page entries such as Generation counter.
2. Validate each log page entry content.
3. Check the return value.

We cannot *only* rely on the nvme-cli return value or on the output.

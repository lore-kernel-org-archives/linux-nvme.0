From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 7 Mar 2019 08:45:03 +0100
Subject: [PATCH 2/2 blktests] nvme: test out-of-range I/O access
In-Reply-To: <SN6PR04MB45276238286089534AEA3D0C86730@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190306094643.10262-1-sagi@grimberg.me>
 <20190306094643.10262-2-sagi@grimberg.me>
 <SN6PR04MB452756E3DF3765A66DE3120086730@SN6PR04MB4527.namprd04.prod.outlook.com>
 <0d3d4384-7f75-cac4-ff8a-5ca4b8f879d2@grimberg.me>
 <SN6PR04MB45276238286089534AEA3D0C86730@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <9d2e3b5b-1b9a-456c-9f0d-a04d7f5492ec@suse.de>

On 06/03/2019 21:31, Chaitanya Kulkarni wrote:
> On 3/6/19 12:28 PM, Sagi Grimberg wrote:
>>
>>>> +DESCRIPTION="unit test NVMe-oF out of range access"
>>> it will be great if you can specify above back-end type (bdev/file)
>>
>> OK
>>
>>>> +QUICK=1
>>>> +
>>>> +requires() {
>>>> +	_have_program nvme && _have_modules nvme-loop && _have_modules loop && \
>>>> +		_have_configfs
>>>
>>> need to check for the blockdev.
>>
>> Other tests use blockdev and don't check for it..
> 
> Yes, while looking at the code, I've also observed we don't check for 
> the truncate as well. At least for the NVMe I'll send a patch-series to 
> fix that for all the other tests.


Truncate is in coreutils and IIRC util-linux and coreutils are the olny
dependency blktests has, so this should be ok.


-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

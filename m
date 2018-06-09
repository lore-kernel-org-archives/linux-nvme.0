From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 9 Jun 2018 15:37:24 +0000
Subject: [PATCH 07/12] blktests: add NVMeoF data verification test for
 bdev-ns
In-Reply-To: <20180609135135.44nxxjespgwtj7fy@linux-x5ow.site>
References: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
 <20180606005210.4197-8-chaitanya.kulkarni@wdc.com>
 <20180606074144.cd4fmoecaiw2hlzt@linux-x5ow.site>
 <DM5PR04MB12138A3A89F921B64F6D2C5686650@DM5PR04MB1213.namprd04.prod.outlook.com>
 <20180607070037.7f6bmleeufjpk3b3@linux-x5ow.site>
 <BN6PR04MB12032A2B64CD4F46E0A5C6CB867B0@BN6PR04MB1203.namprd04.prod.outlook.com>,
 <20180609135135.44nxxjespgwtj7fy@linux-x5ow.site>
Message-ID: <63610918-4D25-4D8E-8771-E127B7D87355@wdc.com>

Sounds good, thanks Johannes.

> On Jun 9, 2018,@6:51 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> 
>> On Fri, Jun 08, 2018@07:00:19PM +0000, Chaitanya Kulkarni wrote:
>> Okay, I agree that we should move the fio to common/fio, but I've some more
>> testcases with fio, how about let me complete the testcase porting first and
>> then optimize the code i.e. move everything to fio?
> 
> I just had a quick look into nvmftests and as far as I remember it's
> mostly using fio and dd. Both are perfectly fine to be used in
> blktests, depending on what you want to do.
> 
>> Otherwise, when I look at the tests with this patch series and next one it will
>> trigger modifying common/fio every time, I'd rather do it all at once. 
> 
> I don't think there is a problem when you modify common/fio in every
> other series. Doing so has the advantage that a reviewer actually sees
> why the code is added in the first place and not just because we could
> maybe need it later.
> 
> Byte,
>    Johannes
> -- 
> Johannes Thumshirn                                          Storage
> jthumshirn at suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
> Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

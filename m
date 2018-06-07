From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 7 Jun 2018 08:58:25 +0200
Subject: [PATCH 03/12] blktests: add NVMeOF bdev-ns target creation test
In-Reply-To: <DM5PR04MB12131353AC241CAB01D90AC686650@DM5PR04MB1213.namprd04.prod.outlook.com>
References: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
 <20180606005210.4197-4-chaitanya.kulkarni@wdc.com>
 <20180606073026.pg76kaxtnh3qnpxa@linux-x5ow.site>
 <DM5PR04MB12131353AC241CAB01D90AC686650@DM5PR04MB1213.namprd04.prod.outlook.com>
Message-ID: <20180607065825.jm6keh4vdhqcegnx@linux-x5ow.site>

On Wed, Jun 06, 2018@06:09:54PM +0000, Chaitanya Kulkarni wrote:
> 004 uses connect command to create host, this testcase exercises target-side
> code.
> 
> 005 uses multipath code, we don't use multipathing here.

005 accidentally uses mutlipath as nvme-loop doesn't support multipath
yet (haven't seen Christoph's patch being merged).

It's a mistake I did when migrating it over from another test case
with nvme-fcloop to nvme-loop.

I'll send a patch to fix it up.

> 
> 
> We need a separate test for target subsys creation instead of relying on the
> implicit testing given that we have multiple types of target ns supported (file
> /block device).
> 
> 
> This is the base test and 006 is an incremental test (maybe I should switch
> order), also this test has QUICK=1 so it is for more of a sanity check than 006
> is more of the long-running test.


Yes I think switching the order would be good, indeed.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

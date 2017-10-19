From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 19 Oct 2017 09:56:20 +0000
Subject: NVMe target log page offset not supported
In-Reply-To: <mqdh8uv1pa7.fsf@linux-x5ow.site>
References: <A5F28D4A728A7E41839CDC5C3B5A01E887295CEF@FMSMSX103.amr.corp.intel.com>
 <20171019085111.GB14227@lst.de>,<mqdh8uv1pa7.fsf@linux-x5ow.site>
Message-ID: <MWHPR04MB1008D60CB5469DD12F6896BE86420@MWHPR04MB1008.namprd04.prod.outlook.com>

Hi Johannes,

I was able to incorporate all the comments received on the first version and added some new testcases.

Please have a look at the following link:-

https://github.com/ChaitanayaKulkarni/nvmftests.

Following is the list of the changes since V1 :-

    1. Addition of new testcases to improve the coverage.
    2. Improved directory structure for code clarity.
    3. Libification of the common code.
    4. Support to use different block devices on the target side.
    5. Centralize test configuration management.
    6. Support to execute File System related operations on the host side.
    7. Adjust the code to incorporate the comments received for the
       first version.
    8. Support for setting different log levels for each component.
    9. Support for quick performance measurements.
    10. Class hierarchy documentation and sequence diagram.
    11. Improved workqueue management for host namesapce to
        run parallel commands.

It will be great if I can get some feedback, I'll be happy to incorporate
the comments and make it more usable.

After completing the comments for this version may be we can tag a release.

Regards,
-Chaitanya







From: Johannes Thumshirn <jthumshirn@suse.de>
Sent: Thursday, October 19, 2017 2:04 AM
To: Christoph Helwig
Cc: Verkamp, Daniel; Sagi Grimberg; linux-nvme at lists.infradead.org; Chaitanya Kulkarni; Hannes Reinecke
Subject: Re: NVMe target log page offset not supported
?    
Christoph Helwig <hch at lst.de> writes:
> Chaitanya has a really nice test framework, I think it might be a good

Do you (or Chaitanya) have a link to this test framework? You
promised it to me quite some time ago ;-)

Thanks,
??????? Johannes
-- 
Johannes Thumshirn????????????????????????????????????????? Storage
jthumshirn at suse.de??????????????????????????????? +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
    

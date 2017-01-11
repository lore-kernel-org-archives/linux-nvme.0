From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 11 Jan 2017 01:24:47 -0800
Subject: [LFS/MM TOPIC][LFS/MM ATTEND]: - Storage Stack and Driver
 Testing methodology.
In-Reply-To: <20170111091945.GD6286@linux-x5ow.site>
References: <CO2PR04MB218427BF42159B20FB26F74186670@CO2PR04MB2184.namprd04.prod.outlook.com>
 <CO2PR04MB2184DB653C04FB620B41435486670@CO2PR04MB2184.namprd04.prod.outlook.com>
 <20170111091945.GD6286@linux-x5ow.site>
Message-ID: <20170111092447.GA13600@infradead.org>

On Wed, Jan 11, 2017@10:19:45AM +0100, Johannes Thumshirn wrote:
> Well, something I was thinking about but didn't find enough time to actually
> implement is making a xfstestes like test suite written using sg3_utils for
> SCSI.

Ronnie's libiscsi testsuite can use SG_IO for a new years now:

https://github.com/sahlberg/libiscsi/tree/master/test-tool

and has been very useful to find bus in various protocol
implementations.

> This idea could very well be extented to NVMe

Chaitanya suite is doing something similar for NVMe, although the
coverage is still much more limited so far.

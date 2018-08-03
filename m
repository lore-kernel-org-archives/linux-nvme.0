From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 3 Aug 2018 18:58:22 +0200
Subject: How /dev/nvme numbers are allocated/mapped to BDF
In-Reply-To: <20180803165411.GA4551@localhost.localdomain>
References: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
 <20180803071820.GA22003@infradead.org>
 <20180803144025.GA4381@localhost.localdomain>
 <097442158bb64b9cbf07cc6e6c25ef1a@ausx13mps321.AMER.DELL.COM>
 <20180803165411.GA4551@localhost.localdomain>
Message-ID: <20180803165822.7ygbpvn3aqhe4aam@linux-x5ow.site>

On Fri, Aug 03, 2018@10:54:11AM -0600, Keith Busch wrote:
> > [root at g-prime mrnuke]# nvme list
> > Node             SN                    Model                                    Namespace  Usage                      Format           FW Rev
> > ---------------- --------------------  ---------------------------------------- ---------  -------------------------- ---------------- --------
> > /dev/nvme0n1     PHLF7363029G1P0GGN   Dell Express Flash NVMe P4500  1.0TB SFF  1           1.00  TB /   1.00  TB     512   B +  0 B   QDV1DP12
> > /dev/nvme1n1     PHLE7260008Z3P2EGN   Dell Express Flash NVMe P4600  3.2TB SFF  1           3.20  TB /   3.20  TB     512   B +  0 B   QDV1DP12
> > /dev/nvme2n1           S39YNX0HB00195 Dell Express Flash PM1725a 800GB  SFF     1           800.17  GB / 800.17  GB   512   B +  0 B   1.0.4
> > /dev/nvme3n1           S39YNX0HB00293 Dell Express Flash PM1725a 800GB  SFF     1           800.17  GB / 800.17  GB   512   B +  0 B   1.0.4
> 
> The sammy drives do not have compliant serial number. Spec requires
> strings are left justified, padding spaces to the right.

OMG, do we need quirks for serial numbers now?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

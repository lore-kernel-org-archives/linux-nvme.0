From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 15 Jul 2019 09:15:22 +0200
Subject: [PATCH blktests 07/12] nvme/018: Ignore error message generated
 by nvme read]
In-Reply-To: <20190712235742.22646-8-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190712235742.22646-8-logang@deltatee.com>
Message-ID: <20190715071522.GB4495@x250>

On Fri, Jul 12, 2019@05:57:37PM -0600, Logan Gunthorpe wrote:
> nvme-cli at some point started printing the error message:
> 
>   NVMe status: CAP_EXCEEDED: The execution of the command has caused the
> 	capacity of the namespace to be exceeded(0x6081)
> 
> This was not accounted for by test 018 and caused it to fail.
> 
> This test does not need to test the error message content, it's
> only important that a read past the end of the file fails. Therefore,
> pipe stderr of nvme-cli to /dev/null.

How about redirecting all of the output to $FULL?

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

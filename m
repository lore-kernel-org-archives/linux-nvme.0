From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Thu, 9 Nov 2017 20:06:01 -0800 (PST)
Subject: [PATCH v2 0/4] qla2xxx: Add FC-NVMe Target support
In-Reply-To: <20171109093321.GA17246@lst.de>
References: <20171109031754.10270-1-himanshu.madhani@cavium.com>
 <20171109093321.GA17246@lst.de>
Message-ID: <alpine.OSX.2.21.1711092004500.44710@n5102mv83lvdv1.qlogic.org>



On Thu, 9 Nov 2017, 1:33am, Christoph Hellwig wrote:

> Before even looking at the patches:  they seem to add a lot of new
> sparse warnings, mostly about endianess issues.  Given that FC-NVMe
> is a mix of BE and LE structures getting this right is important.
> Please fix them up first.
> 
> 
> 

Sure, will fix up endianess warnings and resubmit patches.

Thanks,
Himanshu

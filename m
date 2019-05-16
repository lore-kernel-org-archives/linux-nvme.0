From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 16 May 2019 10:58:43 -0400
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <20190516144452.GB23372@localhost.localdomain> (Keith Busch's
 message of "Thu, 16 May 2019 08:44:52 -0600")
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
 <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
 <20190516144452.GB23372@localhost.localdomain>
Message-ID: <yq17eaqbg4c.fsf@oracle.com>


Keith,

>> to keep in line with the other symlinks in /dev/disk/by-id/ The
>> controller symlinks don't really fall into this category, though; we
>> could create a 'nvme' subdirectory (much like MD does), and create
>> symlinks in there.
>
> Cool, I would also like to see persistent char dev names, but I wasn't
> sure where they'd go. If we can make our own 'nvme' subdirectory,
> that'd be great.

Should be fine. As long as /dev/disk stays intact.

It would be really nice to have a clear indication of
subsys/controller/namespace relationships. So much confusion as a result
of the current approach...

-- 
Martin K. Petersen	Oracle Linux Engineering

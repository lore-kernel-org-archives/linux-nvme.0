From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 14 Jun 2017 11:14:48 -0400
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <20170614150025.GD26073@localhost.localdomain> (Keith Busch's
 message of "Wed, 14 Jun 2017 11:00:25 -0400")
References: <20170614063537.1044-1-hch@lst.de>
 <20170614150025.GD26073@localhost.localdomain>
Message-ID: <yq1injyvbx3.fsf@oracle.com>


Keith,

>> TEST UNIT READY wa broken for a year and a half, and FORMAT UNIT and
>> WRITE BUFFER for two years.  Instead of fixing them up remove them - no
>> one should be sending SCSI commands to non-scsi devices anyway.
>
> This is a step in the right direction, but I don't think it goes far
> enough. Can we remove the whole thing now?

I agree. Let's just get rid of the whole thing.

-- 
Martin K. Petersen	Oracle Linux Engineering

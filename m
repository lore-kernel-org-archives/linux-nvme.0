From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 18 Dec 2017 23:04:28 -0500
Subject: [PATCH v2] NVMe: Format fix when going from 4k sector size to 512
 bytes
In-Reply-To: <20171215221539.4427-1-jeff.lien@wdc.com> (Jeff Lien's message of
 "Fri, 15 Dec 2017 16:15:39 -0600")
References: <20171215221539.4427-1-jeff.lien@wdc.com>
Message-ID: <yq13747jrcj.fsf@oracle.com>


Jeff,

> If you format a device with a 4k sector size back to 512 bytes, the
> queue limit values for physical block size and IO sizes were not

s/IO sizes/minimum IO size/

> getting updated; only the logical block size was being updated.  This
> patch adds code to update the physical block and IO sizes.

s/and IO sizes/and minimum IO sizes/

Otherwise OK.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

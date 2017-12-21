From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 20 Dec 2017 20:38:47 -0500
Subject: [PATCH v3] NVMe: Format fix when going from 4k sector size to 512
 bytes
In-Reply-To: <20171219192415.8468-1-jeff.lien@wdc.com> (Jeff Lien's message of
 "Tue, 19 Dec 2017 13:24:15 -0600")
References: <20171219192415.8468-1-jeff.lien@wdc.com>
Message-ID: <yq1shc4hnbs.fsf@oracle.com>


Jeff,

> If you format a device with a 4k sector size back to 512 bytes, the
> queue limit values for physical block size and minimum IO size were
> not getting updated; only the logical block size was being updated.
> This patch adds code to update the physical block and IO minimum
> sizes.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

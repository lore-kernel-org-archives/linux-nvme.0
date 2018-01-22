From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 22 Jan 2018 16:31:11 -0500
Subject: Report long suspend times of NVMe devices (mostly firmware/device
 issues)
In-Reply-To: <9e398971-762d-bb1a-f798-bf0b18cb5b6b@molgen.mpg.de> (Paul
 Menzel's message of "Mon, 22 Jan 2018 22:02:12 +0100")
References: <9e398971-762d-bb1a-f798-bf0b18cb5b6b@molgen.mpg.de>
Message-ID: <yq1efmhk2cg.fsf@oracle.com>


Paul,

> In my opinion anything longer than 200 ms should be reported similar to
> [2], and maybe worded like below.

There are many controllers out there that take double-digit seconds to
shut down.

-- 
Martin K. Petersen	Oracle Linux Engineering

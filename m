From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 15 Sep 2017 21:02:22 -0400
Subject: [PATCH] qla2xxx: convert nvme Transport error to internal error
In-Reply-To: <5CEF2024-2483-401C-8134-3709DF54CBB6@cavium.com> (Himanshu
 Madhani's message of "Thu, 14 Sep 2017 19:39:05 +0000")
References: <20170914183015.21540-1-jsmart2021@gmail.com>
 <5CEF2024-2483-401C-8134-3709DF54CBB6@cavium.com>
Message-ID: <yq1poartq01.fsf@oracle.com>


Himanshu,

>> Patch removing transport-specific errors crosssed with a qla2xxx update
>> that referenced the status value being removed.
>> 
>> Swap status to an internal error.

Applied to 4.14/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering

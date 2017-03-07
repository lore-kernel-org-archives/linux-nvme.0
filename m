From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 06 Mar 2017 23:09:02 -0500
Subject: [PATCH 00/20] lpfc: Update lpfc to revision 11.2.0.10
In-Reply-To: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com> (jsmart's
 message of "Sat, 4 Mar 2017 09:30:20 -0800")
References: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
Message-ID: <yq1d1dtk9sx.fsf@oracle.com>

>>>>> "James" == jsmart2021  <jsmart2021 at gmail.com> writes:

James,

James> This set of patches are mainly cleanups and fixes to the large
James> nvme post that was recently integrated. It includes a patch to
James> break the mandate for both NVME and SCSI subystems.

A couple of the patches in this series felt quite a bit bigger than "a
fix". I let them in because I acknowledge that it was a pretty big chunk
of code that just got merged and that some fallout was inevitable.

Applied to 4.11/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering

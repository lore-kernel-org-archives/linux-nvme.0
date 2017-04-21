From: james.smart@broadcom.com (James Smart)
Date: Fri, 21 Apr 2017 09:41:31 -0700
Subject: [PATCH-v1 00/22] lpfc updates for 11.2.0.12
In-Reply-To: <yq1h91im2a8.fsf@oracle.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420183047.GD22378@kernel.dk> <20170421070027.GB26346@linux-x5ow.site>
 <yq1h91im2a8.fsf@oracle.com>
Message-ID: <08e8252e-826e-2560-7ae7-08253413fa96@broadcom.com>

On 4/21/2017 4:24 AM, Martin K. Petersen wrote:
> Johannes Thumshirn <jthumshirn at suse.de> writes:
>
>> Just for clarification, shouldn't Martin take the patches? They're for
>> drivers/scsi/lpfc/ after all. I just want to avoid confusion and possible
>> merge conflicts.
> Yeah, at this point I think it's better we do a second stage merge
> through 4.12/scsi-fixes. I'll set that up after Linus pulls from Jens.
>
no - most of the fixes are nvme related.  There are at best 3 that are 
"generic" or scsi specific.  Given the nvme parts need the nvme-fc api 
in the 2 dependencies... this won't be something that works well going 
through scsi.

-- james

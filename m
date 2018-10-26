From: Himanshu.Madhani@cavium.com (Madhani, Himanshu)
Date: Fri, 26 Oct 2018 17:36:02 +0000
Subject: [PATCH v3 2/5] qla2xxx_nvmet: Add files for FC-NVMe Target support
In-Reply-To: <5b980254-3214-d377-5ba8-9c63fcb4c105@broadcom.com>
References: <20180928224626.19777-1-himanshu.madhani@cavium.com>
 <20180928224626.19777-3-himanshu.madhani@cavium.com>
 <5b980254-3214-d377-5ba8-9c63fcb4c105@broadcom.com>
Message-ID: <8774E1D0-E7F4-4C44-B355-4416D0EB4250@cavium.com>

Hi James, 

> On Oct 25, 2018,@11:23 AM, James Smart <james.smart@broadcom.com> wrote:
> 
> External Email
> 
> On 9/28/2018 3:46 PM, Himanshu Madhani wrote:
>> +     .target_features        = NVMET_FCTGTFEAT_READDATA_RSP |
>> +                                     NVMET_FCTGTFEAT_CMD_IN_ISR |
>> +                                     NVMET_FCTGTFEAT_OPDONE_IN_ISR,
>> 
> 
> Himanshu,
> 
> I'm looking at these but had a quick question.   Did you really want the
> IN_ISR flags set ?  they schedule processing vs calling the nvmet
> routines inline. The intent was the queueing was only needed if in the
> hard isr routine. Last contact I had with your group said you were in
> soft isr routines and inline calling would be used.  I'm asking because
> I had intended to remove these flags/features.
> 
> -- james
> 

Looks like there was a miss to remove these flags when we rebased code on 4.20/scsi-queue. 
After the original submission where this flag was present, we have removed this flag in our 
internal testing but the code sent out after rebase missed that update. I?ll send v4 with 
the flag removed. 

Please let me know you have any other comments that I can incorporate in v4 

Thanks,
- Himanshu

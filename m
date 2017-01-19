From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Jan 2017 18:07:31 -0800
Subject: [PATCH 02/17] lpfc: NVME Initiator: Base modifications Part A
In-Reply-To: <4686b4f0-06ab-d0cc-6630-524f839d6842@suse.de>
References: <587ec2ed.BwM2pzG0hT3uy4dN%jsmart2021@gmail.com>
 <4686b4f0-06ab-d0cc-6630-524f839d6842@suse.de>
Message-ID: <0602b020-2837-1f73-a29c-f44ba5d20722@gmail.com>



On 1/17/2017 11:07 PM, Hannes Reinecke wrote:
>
>> - * lpfc_sli4_post_scsi_sgl_list - Post blocks of scsi buffer sgls from a list
>> + * lpfc_sli4_post_scsi_sgl_list - Psot blocks of scsi buffer sgls from a list
>>    * @phba: pointer to lpfc hba data structure.
>>    * @post_sblist: pointer to the scsi buffer list.
>>    *
> Psot?

> Repsot? The reverse of 'Psot'?

lol...

>
> bdea?

Crud - caught a bunch of those but looks like a couple got through. 
Surprised checkpatch let them through. oh well.

anyway - will fix and repost (repsot?) what you mentioned.

-- james

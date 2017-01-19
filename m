From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Jan 2017 18:34:02 -0800
Subject: [PATCH 02/17] lpfc: NVME Initiator: Base modifications Part A
In-Reply-To: <20170118094921.GB3514@linux-x5ow.site>
References: <587ec2ed.BwM2pzG0hT3uy4dN%jsmart2021@gmail.com>
 <20170118094921.GB3514@linux-x5ow.site>
Message-ID: <af9d3d56-2239-232c-7317-7ae0ec25be90@gmail.com>



On 1/18/2017 1:50 AM, Johannes Thumshirn wrote:

>> @@ -4959,11 +4968,11 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct scsi_cmnd *cmnd,
>>   	int status;
>>   
>>   	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
>> -	if (!rdata || !rdata->pnode || !NLP_CHK_NODE_ACT(rdata->pnode))
>> -		return FAILED;
> OK, I don't get this hunk. lpfc_rport_data_from_scsi_device() cannot return
> NULL anymore?
>
> I at least expected something like:
>
>    	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
> 	if (!rdata || !rdata->pnode)
> 		return FAILED;
> 	
> 	pnode = rdata->pnode;
> 	if (!NLP_CHK_NODE_ACT(pnode)
> 		return FAILED;

it can and the order of precedence for the if check allows for it. I 
don't see any difference in what you wrote vs what's there, other than 
pnode gets an assignment.


Agree with all your other comments and will address them.

-- james

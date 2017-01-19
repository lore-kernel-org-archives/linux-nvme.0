From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jan 2017 09:04:36 +0100
Subject: [PATCH 02/17] lpfc: NVME Initiator: Base modifications Part A
In-Reply-To: <af9d3d56-2239-232c-7317-7ae0ec25be90@gmail.com>
References: <587ec2ed.BwM2pzG0hT3uy4dN%jsmart2021@gmail.com>
 <20170118094921.GB3514@linux-x5ow.site>
 <af9d3d56-2239-232c-7317-7ae0ec25be90@gmail.com>
Message-ID: <20170119080436.GB5054@linux-x5ow.site>

On Wed, Jan 18, 2017@06:34:02PM -0800, James Smart wrote:
> 
> 
> On 1/18/2017 1:50 AM, Johannes Thumshirn wrote:
> 
> >>@@ -4959,11 +4968,11 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct scsi_cmnd *cmnd,
> >>  	int status;
> >>  	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
> >>-	if (!rdata || !rdata->pnode || !NLP_CHK_NODE_ACT(rdata->pnode))
> >>-		return FAILED;
> >OK, I don't get this hunk. lpfc_rport_data_from_scsi_device() cannot return
> >NULL anymore?
> >
> >I at least expected something like:
> >
> >   	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
> >	if (!rdata || !rdata->pnode)
> >		return FAILED;
> >	
> >	pnode = rdata->pnode;
> >	if (!NLP_CHK_NODE_ACT(pnode)
> >		return FAILED;
> 
> it can and the order of precedence for the if check allows for it. I don't
> see any difference in what you wrote vs what's there, other than pnode gets
> an assignment.

You're doing:
rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
pnode = rdata->pnode;
if (!pnode || !NLP_CHK_NODE_ACT(pnode)) 
	return FAILED;

So if rdata is already NULL, the pnode = rdata->pnode line will blow up.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

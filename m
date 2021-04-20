Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A25C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 12:39:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D369611F2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 12:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D369611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TZWrAxOfk5IIWOPIsGDHR0FclQItQ6o4oiGxBAPOXbI=; b=qhUocnj5OHbZ/GEIweWMCiulJ
	fJBkwUEXnV3zvYpJue20sw+pJPy2lOfrbHjMV7NpTuJGsJRiK5JdXhSGIWUJcGdj2+VlE5zLrSF9+
	0L3R2/WzWV8ONqu/epqsa90aPr3JkASlicz8vZf6NFAOWopkP3qsMTgeljRd3jfgS0043mRnNM/bA
	3iXNbjLekMryhAXs4Q+SmZO0ycpoX3JSQp0FXE97j3ivkhaRCkyPW0JbFbFNgoFeRizKtvpjKcV/v
	43g6ijgsMBnL9Sy7ZRTcVjXw1jtldfSmHAv5kX9wlr1g+0pKjqBrqzyyWzz1w/IWrAGVb4MdSL7VE
	03AftuoCA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYpeN-00C6ms-P0; Tue, 20 Apr 2021 12:38:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYpeJ-00C6mN-OL
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 12:38:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Sender:In-Reply-To:Content-Type:References:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
 bh=cM4snMEz3w5B344j6o8ruCX/KOxW+0D1o/cVs+oTAgs=; b=bg2hM5xXSKMMNi0ktFsHWZcyV
 Rt8bOWqt+dAGxLX9SsU1bI3ue3/LefDRarKAtC42ugW7mYL1p43Tj1fcQwCx8Mf60QwaYbt3XI6sH
 ExF2teCVqvadqdn57goO9q9m0REwuwOvtjz0Y8pTuBRdiFLfv2KOmmE25d0/nukx1P+/p7MKApBn6
 fL0NQmO26DV9v6HjfYUry9F5fleKtBO6V7eCb5Pbe6/7yNjHATX5tfw+E9GVm2mhp8hcsMxtidDTf
 gALGN2U29tTejjDBC1PnpNDrSsQIL1kzWENof3u9A024AV9WElMjEq1cX84VrYKtdEaxlemLUxCA9
 Im/35igeQ==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYpeG-00C6r3-8m
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 12:38:38 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13KCX1Ko062622; Tue, 20 Apr 2021 08:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cM4snMEz3w5B344j6o8ruCX/KOxW+0D1o/cVs+oTAgs=;
 b=lXEXYXfcWgLLeofHV9N05ChSaNSn9eN6FadHO7nlCyzpdq2YYSnX2plXeHa7o8Lp/RtY
 G8EerqXNdnS6M8if9FRXDNxGCh5d5MNhRfmFqEK9osasSNMX4kl3DcCOcYS5IyZDlraZ
 wyLEJRXPxlDIBwdQlLFyBa2THuQCG58rzE73TCH8N673w0J+8d5ThLG58lJIg7mZRef6
 yhsQX7lRIN7zTYtQkTeYWR90Q4GYdX4V+lr7/oEjUcOy+a1zY1DgUPwtvuVElkWZe4Ef
 wL6g51RMRmZbZ4ncWtZdK7oJYx6bl+CKQslzS/X5Oaq3D1Aop9JyUuT1QsWTl1hD+OD0 DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 381xebse58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Apr 2021 08:38:29 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KCXwww068288;
 Tue, 20 Apr 2021 08:38:29 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 381xebse3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Apr 2021 08:38:29 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KCUppn031437;
 Tue, 20 Apr 2021 12:38:25 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06fra.de.ibm.com with ESMTP id 37ypxh8xk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Apr 2021 12:38:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13KCcMWO29557032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Apr 2021 12:38:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A218A5204F;
 Tue, 20 Apr 2021 12:38:22 +0000 (GMT)
Received: from t480-pf1aa2c2.fritz.box (unknown [9.145.82.95])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8D1875204E;
 Tue, 20 Apr 2021 12:38:22 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2.fritz.box with local (Exim 4.94)
 (envelope-from <bblock@linux.ibm.com>)
 id 1lYpe2-003M5U-1e; Tue, 20 Apr 2021 14:38:22 +0200
Date: Tue, 20 Apr 2021 14:38:21 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Muneendra <muneendra.kumar@broadcom.com>, hare@suse.de,
 jsmart2021@gmail.com
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
 Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH v9 07/13] lpfc: vmid: Implements ELS commands for appid
 patch
Message-ID: <YH7LPd8c4PZa1qFC@t480-pf1aa2c2.linux.ibm.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-8-git-send-email-muneendra.kumar@broadcom.com>
Content-Disposition: inline
In-Reply-To: <1617750397-26466-8-git-send-email-muneendra.kumar@broadcom.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _rjTI-pF-XsAwhb3IRamnLhqEsdnOb7U
X-Proofpoint-GUID: FF29OEsVyztW4zseUeyliYReET61WUrV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-20_06:2021-04-20,
 2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104200095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_053836_537168_E0D89ADF 
X-CRM114-Status: GOOD (  34.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey,

On Wed, Apr 07, 2021 at 04:36:31AM +0530, Muneendra wrote:
> From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> =

> This patch implements ELS command like QFPA and UVEM for the priority
> tagging appid support. Other supporting functions are also part of this
> patch.
> =

> Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> =

> ---
> v9:
> Added a lock while accessing a flag
> =

> v8:
> Added log messages modifications, memory allocation API changes,
> return error codes
> =

> v7:
> No change
> =

> v6:
> Added Forward declarations, static functions and
> removed unused variables
> =

> v5:
> Changed Return code to non-numeric/Symbol.
> Addressed the review comments by Hannes
> =

> v4:
> No change
> =

> v3:
> No change
> =

> v2:
> Ported the patch on top of 5.10/scsi-queue
> ---
>  drivers/scsi/lpfc/lpfc_els.c | 366 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 362 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index a04546eca18f..22a87559f62d 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -10260,3 +10309,312 @@ lpfc_sli_abts_recover_port(struct lpfc_vport *v=
port,
>  	lpfc_unreg_rpi(vport, ndlp);
>  }
>  =

> +static void lpfc_init_cs_ctl_bitmap(struct lpfc_vport *vport)
> +{
> +	bitmap_zero(vport->vmid_priority_range, LPFC_VMID_MAX_PRIORITY_RANGE);
> +}
> +
> +static void
> +lpfc_vmid_set_cs_ctl_range(struct lpfc_vport *vport, u32 min, u32 max)
> +{
> +	u32 i;
> +
> +	if ((min > max) || (max > LPFC_VMID_MAX_PRIORITY_RANGE))
> +		return;
> +
> +	for (i =3D min; i <=3D max; i++)
> +		set_bit(i, vport->vmid_priority_range);
> +}
> +
> +static void lpfc_vmid_put_cs_ctl(struct lpfc_vport *vport, u32 ctcl_vmid)
> +{
> +	set_bit(ctcl_vmid, vport->vmid_priority_range);
> +}
> +
> +u32 lpfc_vmid_get_cs_ctl(struct lpfc_vport *vport)
> +{
> +	u32 i;
> +
> +	i =3D find_first_bit(vport->vmid_priority_range,
> +			   LPFC_VMID_MAX_PRIORITY_RANGE);
> +
> +	if (i =3D=3D LPFC_VMID_MAX_PRIORITY_RANGE)
> +		return 0;
> +
> +	clear_bit(i, vport->vmid_priority_range);
> +	return i;
> +}
> +
> +#define MAX_PRIORITY_DESC	255
> +
> +static void
> +lpfc_cmpl_els_qfpa(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
> +		   struct lpfc_iocbq *rspiocb)
> +{
> +	struct lpfc_vport *vport =3D cmdiocb->vport;
> +	struct priority_range_desc *desc;
> +	struct lpfc_dmabuf *prsp =3D NULL;
> +	struct lpfc_vmid_priority_range *vmid_range =3D NULL;
> +	u32 *data;
> +	struct lpfc_dmabuf *dmabuf =3D cmdiocb->context2;
> +	IOCB_t *irsp =3D &rspiocb->iocb;
> +	u8 *pcmd, max_desc;
> +	u32 len, i;
> +	struct lpfc_nodelist *ndlp =3D (struct lpfc_nodelist *)cmdiocb->context=
1;
> +
> +	prsp =3D list_get_first(&dmabuf->list, struct lpfc_dmabuf, list);
> +	if (!prsp)
> +		goto out;
> +
> +	pcmd =3D prsp->virt;
> +	data =3D (u32 *)pcmd;
> +	if (data[0] =3D=3D ELS_CMD_LS_RJT) {
> +		lpfc_printf_vlog(vport, KERN_WARNING, LOG_SLI,
> +				 "3277 QFPA LS_RJT x%x  x%x\n",
> +				 data[0], data[1]);
> +		goto out;
> +	}
> +	if (irsp->ulpStatus) {
> +		lpfc_printf_vlog(vport, KERN_ERR, LOG_SLI,
> +				 "6529 QFPA failed with status x%x  x%x\n",
> +				 irsp->ulpStatus, irsp->un.ulpWord[4]);
> +		goto out;
> +	}
> +
> +	if (!vport->qfpa_res) {
> +		max_desc =3D FCELSSIZE / sizeof(*vport->qfpa_res);
> +		vport->qfpa_res =3D kcalloc(max_desc, sizeof(*vport->qfpa_res),
> +					  GFP_KERNEL);
> +		if (!vport->qfpa_res)
> +			goto out;
> +	}
> +
> +	len =3D *((u32 *)(pcmd + 4));
> +	len =3D be32_to_cpu(len);
> +	memcpy(vport->qfpa_res, pcmd, len + 8);
> +	len =3D len / LPFC_PRIORITY_RANGE_DESC_SIZE;
> +
> +	desc =3D (struct priority_range_desc *)(pcmd + 8);
> +	vmid_range =3D vport->vmid_priority.vmid_range;
> +	if (!vmid_range) {
> +		vmid_range =3D kcalloc(MAX_PRIORITY_DESC, sizeof(*vmid_range),
> +				     GFP_KERNEL);
> +		if (!vmid_range) {
> +			kfree(vport->qfpa_res);
> +			goto out;
> +		}
> +		vport->vmid_priority.vmid_range =3D vmid_range;
> +	}
> +	vport->vmid_priority.num_descriptors =3D len;
> +
> +	for (i =3D 0; i < len; i++, vmid_range++, desc++) {
> +		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_ELS,
> +				 "6539 vmid values low=3D%d, high=3D%d, qos=3D%d, "
> +				 "local ve id=3D%d\n", desc->lo_range,
> +				 desc->hi_range, desc->qos_priority,
> +				 desc->local_ve_id);
> +
> +		vmid_range->low =3D desc->lo_range << 1;
> +		if (desc->local_ve_id =3D=3D QFPA_ODD_ONLY)
> +			vmid_range->low++;
> +		if (desc->qos_priority)
> +			vport->vmid_flag |=3D LPFC_VMID_QOS_ENABLED;
> +		vmid_range->qos =3D desc->qos_priority;

I'm curios, if the FC-switch signals it supports QoS for a range here, how
exactly interacts this with the VM IDs that you seem to allocate
dynamically during runtime for cgroups that request specific App IDs?
You don't seem to use `LPFC_VMID_QOS_ENABLED` anywhere else in the
series.

Would different cgroups get different QoS classes/guarantees depending
on the selected VM ID (higher VM ID gets better QoS class, or something
like that?)? Would the tagged traffic be handled differently than the
ordinary traffic in the fabric?

I tried to get something from FC-LS (-5) or FC-FS (-6), but they are extrem=
ely
sparse somehow. FC-LS-5 just says "QoS priority provided" for the
field.. and FC-FS doesn't say anything regarding QoS if the tagging
extension in CS_CTL is used.

> +
> +		vmid_range->high =3D desc->hi_range << 1;
> +		if ((desc->local_ve_id =3D=3D QFPA_ODD_ONLY) ||
> +		    (desc->local_ve_id =3D=3D QFPA_EVEN_ODD))
> +			vmid_range->high++;
> +	}
> +	lpfc_init_cs_ctl_bitmap(vport);
> +	for (i =3D 0; i < vport->vmid_priority.num_descriptors; i++) {
> +		lpfc_vmid_set_cs_ctl_range(vport,
> +				vport->vmid_priority.vmid_range[i].low,
> +				vport->vmid_priority.vmid_range[i].high);
> +	}
> +
> +	vport->vmid_flag |=3D LPFC_VMID_QFPA_CMPL;
> + out:
> +	lpfc_els_free_iocb(phba, cmdiocb);
> +	lpfc_nlp_put(ndlp);
> +}
> +
> +int lpfc_issue_els_qfpa(struct lpfc_vport *vport)
> +{
> +	struct lpfc_hba *phba =3D vport->phba;
> +	struct lpfc_nodelist *ndlp;
> +	struct lpfc_iocbq *elsiocb;
> +	u8 *pcmd;
> +	int ret;
> +
> +	ndlp =3D lpfc_findnode_did(phba->pport, Fabric_DID);
> +	if (!ndlp || ndlp->nlp_state !=3D NLP_STE_UNMAPPED_NODE)
> +		return -ENXIO;
> +
> +	elsiocb =3D lpfc_prep_els_iocb(vport, 1, LPFC_QFPA_SIZE, 2, ndlp,
> +				     ndlp->nlp_DID, ELS_CMD_QFPA);
> +	if (!elsiocb)
> +		return -ENOMEM;
> +
> +	pcmd =3D (u8 *)(((struct lpfc_dmabuf *)elsiocb->context2)->virt);
> +
> +	*((u32 *)(pcmd)) =3D ELS_CMD_QFPA;
> +	pcmd +=3D 4;
> +
> +	elsiocb->iocb_cmpl =3D lpfc_cmpl_els_qfpa;
> +
> +	elsiocb->context1 =3D lpfc_nlp_get(ndlp);
> +	if (!elsiocb->context1) {
> +		lpfc_els_free_iocb(vport->phba, elsiocb);
> +		return -ENXIO;
> +	}
> +
> +	ret =3D lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 2);
> +	if (ret !=3D IOCB_SUCCESS) {
> +		lpfc_els_free_iocb(phba, elsiocb);
> +		lpfc_nlp_put(ndlp);
> +		return -EIO;
> +	}
> +	vport->vmid_flag &=3D ~LPFC_VMID_QOS_ENABLED;
> +	return 0;
> +}

-- =

Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Sys=
tems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/pri=
vacy
Vorsitz. AufsR.: Gregor Pillen         /        Gesch=E4ftsf=FChrung: Dirk =
Wittkopp
Sitz der Gesellschaft: B=F6blingen / Registergericht: AmtsG Stuttgart, HRB =
243294

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

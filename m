Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E09CCD18D
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 07:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=93McTgIQfTdSfO9feyKIvRLM2A/6YG9TYDLrl6hqRlg=; b=DsEJO3S5lDRcVjmFrjvTirWcxM
	jiSi6eryhiUtRg/03EpiLK7nlw/5XDHLOgp7qvdIbMqHRF9q03TTUuzsZEF7+LDyFjO28H6YhDLyZ
	CsngiV3BtQr1SSUU0w2sgg9nirnFWX5Ur/7oMsuEKv/XCvRVcBlBn+0iRzVrg3s8PgycXukNtrIur
	eN/0Q2O/vzQyUwso22g0st2eW3d+nm/P39kfLMZOpo46caVhOhTKGbleU/EKNMCAKrVu4USv5cRzL
	O1OhZh1YVXzUBdMR9Pwul4Rh1Mz+plzHRqDRBCjldGFM3yX3H3pSyWkCcrHvn7xmfE8DXg+vFj6Fz
	zjG5dtRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqpWg-00000007iQz-1Bld;
	Wed, 18 Sep 2024 07:55:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqpVa-00000007iEf-2puI
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 07:53:57 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HIM8qV007614;
	Wed, 18 Sep 2024 07:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=9
	3McTgIQfTdSfO9feyKIvRLM2A/6YG9TYDLrl6hqRlg=; b=teaXfDweD0ET9muqr
	BL1rCoc1QxEp4fe7BHVD04YFY/YFNsh6rKOkFqH2Ufzxo8Lt1vlAomU2COBSh6hD
	mSrMphKd903hjDTq8lyjoie87b8FYjqXNiQ4jB6P+c35gttIFiupS+hh0G9+0DtL
	cmTn6RQHofKkTqXWuqj4c6uU2gEDfB3jQnnMe98XoV5DQiEhwHj+cJId20qQNijw
	B5P2mJVmyGAyvhc/xSvffeqVTZG0XCPu/OwkpInD9dxY/sXFIEz4io51c3fiiUjB
	SIfZazgbDRXPLUlJW+32JtzafSqXiSD49Q3uZXOiRoGjNh2/Ck/7ghAQaZ6s2ovv
	ktG+A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdmncr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 07:53:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48I6UDAo000628;
	Wed, 18 Sep 2024 07:52:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn719y01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 07:52:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48I7qvhm30081466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 07:52:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B76455805D;
	Wed, 18 Sep 2024 07:52:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A88A58058;
	Wed, 18 Sep 2024 07:52:54 +0000 (GMT)
Received: from [9.171.71.185] (unknown [9.171.71.185])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Sep 2024 07:52:53 +0000 (GMT)
Message-ID: <8b17203f-ea4b-403b-a204-4fbc00c261ca@linux.ibm.com>
Date: Wed, 18 Sep 2024 13:22:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-passthru: allow nvme ns-id descriptor list to clear
 EUID/NGUID/UUID
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, kbusch@kernel.org,
        axboe@fb.com, gjoyce@linux.ibm.com,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>, Martin Wilck <martin.wilck@suse.com>
References: <20240917085112.155173-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240917085112.155173-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B_yvr4IkDAa94cPhp44gHoevK8FAILzH
X-Proofpoint-GUID: B_yvr4IkDAa94cPhp44gHoevK8FAILzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_06,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409180045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_005354_979989_F0F9F1C3 
X-CRM114-Status: GOOD (  31.56  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/17/24 14:21, Nilay Shroff wrote:
> When nvme passthru is configured using loop target, the clear_ids
> attribute is, by default, set to true. This attribute would ensure that
> EUID/NGUID/UUID is cleared for the loop passthru target.
> 
> The newer NVMe disk supporting the NVMe spec 1.3 or higher, typically,
> implements the support for "Namespace Identification Descriptor list"
> command. This command when issued from host returns EUID/NGUID/UUID
> assigned to the inquired namespace. Not clearing these values, while
> using nvme passthru using loop target, would result in NVMe host driver
> rejecting the namespace. This check was implemented in the commit
> 2079f41ec6ff ("nvme: check that EUI/GUID/UUID are globally unique").
> 
> The fix implemented in this commit ensure that when host issues ns-id
> descriptor list command, the EUID/NGUID/UUID are cleared by passthru
> target. In fact, the function nvmet_passthru_override_id_descs() which
> clears those unique ids already exits, so we just need to ensure that
> ns-id descriptor list command falls through the corretc code path. And
> while we're at it, we also combines the three passthru admin command
> cases together which shares the same code.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/nvme/target/passthru.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 24d0e2418d2e..d786d8dee131 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -535,10 +535,6 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
>  		break;
>  	case nvme_admin_identify:
>  		switch (req->cmd->identify.cns) {
> -		case NVME_ID_CNS_CTRL:
> -			req->execute = nvmet_passthru_execute_cmd;
> -			req->p.use_workqueue = true;
> -			return NVME_SC_SUCCESS;
>  		case NVME_ID_CNS_CS_CTRL:
>  			switch (req->cmd->identify.csi) {
>  			case NVME_CSI_ZNS:
> @@ -547,7 +543,11 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
>  				return NVME_SC_SUCCESS;
>  			}
>  			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
> +		case NVME_ID_CNS_CTRL:
> +			fallthrough;
>  		case NVME_ID_CNS_NS:
> +			fallthrough;
> +		case NVME_ID_CNS_NS_DESC_LIST:
>  			req->execute = nvmet_passthru_execute_cmd;
>  			req->p.use_workqueue = true;
>  			return NVME_SC_SUCCESS;

On a sidenote: This issue could be reproduced (where we find passthru target namespeace being 
ignored on the host due to duplicate IDs) using blktest nvme/033. I have a system with NVMe disk
which supports NVMe spec 1.3. On this system, when I run this blktest I can always reproduce 
this issue:

# nvme list -v 
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys0     nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358                                      nvme0

Device   SN                   MN                                       FR       TxPort Asdress        Slot   Subsystem    Namespaces      
-------- -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
nvme0    S6EUNA0R500358       1.6TB NVMe Gen4 U.2 SSD                  REV.SN49 pcie   0018:01:00.0          nvme-subsys0 nvme0n1

Device       Generic      NSID       Usage                      Format           Controllers     
------------ ------------ ---------- -------------------------- ---------------- ----------------
/dev/nvme0n1 /dev/ng0n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme0

# nvme show-regs /dev/nvme0 -H 
<snip>
version : 10300
	NVMe specification 1.3
<snip>

# ./check tests/nvme/033 
nvme/033 => nvme0n1 (tr=loop) (create and connect to an NVMeOF target with a passthru controller)

Here, the above blktest hangs indefinitely. 

And the relevant kernel logs:
# dmesg
nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
nvme nvme1: D3 entry latency set to 10 seconds
nvme nvme1: creating 32 I/O queues.
nvme nvme1: new ctrl: "blktests-subsystem-1"
nvme nvme1: Failed to configure AEN (cfg 300)
nvme nvme1: VID:144d model:1.6TB NVMe Gen4 U.2 SSD firmware:REV.SN49
nvme nvme1: ignoring nsid 1 because of duplicate IDs

I have another system using an NVMe disk supporting NVMe spec 1.2 and on this system, running 
the above test would PASS.

Moreover, I think we should fix the blktest nvme/033 so that it would bail out 
after some time instead of hanging indefinitely. Also we don't have an nvme-cli 
command which supports ns-id descriptor list command. We may also want to add 
support of this new command in nvme-cli? 

Thanks,
--Nilay


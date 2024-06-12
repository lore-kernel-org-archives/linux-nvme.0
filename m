Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE91C27C77
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e/HFuU2SPwb/S+c7dHqYVCXSW+Q8mLdg5oHfD8AeYgQ=; b=Ppv6M93/4d20T6+BvihYhILzoD
	P1VosA+REaUsrGSm0JtAx39OYKxeNic3iaB0UW90w3/mGgU54eFtL5khSSTrPRwnUtEsf03ze0Fx7
	3VMYcQhHoIFFdEoQyqBeEC/uFCdhsJactg2xXffOhMMMyGJKehnMfMdPboelwwwZszMdoz4s30+Rs
	uWAhSkQBnrzxxvPbrGh//FKrJV7KIMNIIiAzAWXF1hMqwdo3Hp7wrdcrOJx2MnClU2IPMsKX/Jh6c
	DHec15mZKq7pUfpMoIsvneCovqEIkKDOzAGhn/wDLxSW1/eu/phLXD2fVIN4VQvkv/6AUJ/zx3fYk
	KxgVxWdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLq1-0000000COMa-3GBC;
	Wed, 12 Jun 2024 11:08:21 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLpy-0000000COLr-1VcR
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 11:08:20 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CARK38024687;
	Wed, 12 Jun 2024 11:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=e
	/HFuU2SPwb/S+c7dHqYVCXSW+Q8mLdg5oHfD8AeYgQ=; b=I4SMFdiZPHTzVP40H
	BykzYufoIjBW8DaHARi6EQj1NAiBM2W1Wn8Fw3xZgKYVGtJ965/C8sioa+HYkI7P
	bHJgksVzrsZgnFq/AY+B1Lrxk5FhBla5tVMaREqJtaM+VtNSkqni/VnCNVnwzyBz
	uINbIofhJWbGlwGkVVsHtYxwwgfyj5P9s+16OsL/QABmYyQ2lMNck5HhUrVzNjxH
	d+rkXeUwK6/pRsuCM8iGlDnygBtzrICV9wp+fUw4Dpooi9sDwxh3IQECm72K04tc
	RdkiJe2l1ox32hd0T16g9Bfim2B6tH9nCwNaZPIwth1Id2LTns9LTUz3WwWMC9+w
	U7rzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yq7rm0ept-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 11:07:32 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45CB7WsX019006;
	Wed, 12 Jun 2024 11:07:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yq7rm0epq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 11:07:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45C9g68E020063;
	Wed, 12 Jun 2024 11:07:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34n4v7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 11:07:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45CB7SB219530486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 11:07:30 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53FF45807A;
	Wed, 12 Jun 2024 11:07:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79E385806B;
	Wed, 12 Jun 2024 11:07:25 +0000 (GMT)
Received: from [9.43.104.93] (unknown [9.43.104.93])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Jun 2024 11:07:25 +0000 (GMT)
Message-ID: <15192c9d-ce45-4dbc-bdbb-752cdfd4e663@linux.ibm.com>
Date: Wed, 12 Jun 2024 16:37:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme-pci : Fix EEH failure on ppc after subsystem
 reset
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, axboe@fb.com
References: <20240604091523.1422027-1-nilay@linux.ibm.com>
 <20240604091523.1422027-2-nilay@linux.ibm.com>
 <CAFL455ndCZipuN1bFTWgqjj4Sfh6AB3WUX014W1V2WY4gqzK8w@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFL455ndCZipuN1bFTWgqjj4Sfh6AB3WUX014W1V2WY4gqzK8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZwVwC0O3uFc1K0LRX84VwNPnWBKVzplB
X-Proofpoint-ORIG-GUID: wWlgI_2vIgWHtf0rnRQRDKhEmYRM8BMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_040818_781357_61AA3D0F 
X-CRM114-Status: GOOD (  21.44  )
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



On 6/10/24 18:02, Maurizio Lombardi wrote:
> út 4. 6. 2024 v 11:16 odesílatel Nilay Shroff <nilay@linux.ibm.com> napsal:
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f5d150c62955..afb8419566a9 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -562,6 +562,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>>                 switch (old_state) {
>>                 case NVME_CTRL_NEW:
>>                 case NVME_CTRL_LIVE:
>> +               case NVME_CTRL_CONNECTING:
>>                         changed = true;
>>                         fallthrough;
>>                 default:
> 
> Side note:
> 
> I believe this could fix a race condition in the nvme-tcp driver.
> Some time ago we received a kernel dump where the controller was
> flagged as NVME_CTRL_LIVE but the sockets were marked as TCP_CLOSED,
> the kernel was hanging into io_work.
> It might be possible that the socket's nvme_tcp_error_recovery
> callback was executed while the ctrl was still marked as
> NVME_CTRL_CONNECTING, nvme_change_ctrl_state() doesn't allow a
> reconnecting controller to switch to the resetting state and therefore
> nvme_tcp_error_recovery() simply returns without triggering an error
> recovery.
> 
> nvme_tcp_setup_ctrl() then moves the ctrl to the LIVE state, but with
> closed tcp sockets.
> 
> I guess that this change would fix the possible race condition, even
> if I am not completely sure what could happen in case of a race
> between nvme_tcp_setup_ctrl() and the error recovery code.
> 
I think for your case you shall consider using nvme_wait_reset() before 
queuing error recovery work. For instance, it could be done something 
like below  assuming that all callers of nvme_tcp_error_recovery() are
allowed to sleep (not fully tested) :

static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
{
	if (!nvme_wait_reset(ctrl))
		return;

	dev_warn(ctrl->device, "starting error recovery\n");
	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
}

The nvme_wait_reset() shall wait until the nvme_tcp_setup_ctrl() finish 
its work and then the tcp error recovery work would be initiated. 

Thanks,
--Nilay


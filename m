Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42855CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ueVKU53JfVPnC5pxCxU9lgnD6nXuVvVKNAfctTpwU38=; b=FoMnnWphQmOelV7DN1AxE/RKoe
	Sw2my8Eyhv9cX9o1rr7ul+U7RcRgYoIWLpssfOCxuG7lUau3rTBWYEkDBFrlkuTkxauUG+E5REV7W
	qDBHHY1M7sMbT3k7voOuv3MgtQ6npwLswP6y1g/+79Bi79reVvUv32gjgsHl9aeXkWWzNyEqHWeuB
	6ybT5rRkphcBqnrwPNtjnxIFD1v0Zl7c9DfyASnZ5uZQTAeg9Y04jN61uRA4HAdli8Gtstuv1TVdt
	jkB2OztXqf9/QvocNtz3MMcc7BZbzaAaeFjOJr8TPGQrl6PVfI1HfD7rqrtm3IiHmoD0Nt3vLL3EJ
	MRpkP3qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrzs8-0000000FxtO-3kq9;
	Wed, 03 Apr 2024 12:37:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrzs5-0000000FxsA-1ysF
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 12:37:42 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433CZ45Q026820;
	Wed, 3 Apr 2024 12:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ueVKU53JfVPnC5pxCxU9lgnD6nXuVvVKNAfctTpwU38=;
 b=mwGGJOv+J6p/4BzgQZ0uxXnbfNamgJkao2VlUue7grRWY2eZnyr7YW80UD4LB3z3hCyG
 NXhNdCNvycQO+92+9hcvOGhNssl9UYPAPm5dcIL+jYE7iMc/ygAoY4LkCe7WjFrA0um0
 UhSCHEgU2bp0Qy6tqQwavJ3dCH+OCS7vfbXdBcFGnV36Pgu0OZJuS9WMGtoS6jxnq0lt
 dHlzNtcXJb0zPrL79X3XcANeq18tW0aDXf8kUkPe/qHWaGpDR5m13IPtcqYT6PN4AHLC
 SiXa1gLs1DsfOFOMgmCuPnMwRgGnmxSkIS2Fggkn5U/o0yJKunH5+3MydMLt921SdP8C IA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9783805q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:37:36 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4339igL8015241;
	Wed, 3 Apr 2024 12:37:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6y9m4w5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:37:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433CbW6M14287504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 12:37:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACAC658056;
	Wed,  3 Apr 2024 12:37:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B92F058052;
	Wed,  3 Apr 2024 12:37:30 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 12:37:30 +0000 (GMT)
Message-ID: <bce9276a-c1bf-4faa-8fab-bfc81724646e@linux.ibm.com>
Date: Wed, 3 Apr 2024 18:07:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_nvme-cli_=E2=80=98nvme_connect=E2=80=99_--duplicate?=
 =?UTF-8?Q?-connect_flag_=28-D=29_is_not_supported_anymore?=
Content-Language: en-US
To: "Engel, Amit" <Amit.Engel@Dell.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Cohen, Yonatan" <Yonatan.Cohen@Dell.com>,
        Daniel Wagner
 <dwagner@suse.de>, Gregory Joyce <gjoyce@ibm.com>
References: <CO1PR19MB48850C446CA2FED70F7E5D69EE3D2@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CO1PR19MB48850C446CA2FED70F7E5D69EE3D2@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A7s7w9gUOpbpJZlQ3BHP_6ZBFSbJPZPp
X-Proofpoint-ORIG-GUID: A7s7w9gUOpbpJZlQ3BHP_6ZBFSbJPZPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=961 priorityscore=1501 clxscore=1011 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_053741_655142_8240C1C2 
X-CRM114-Status: GOOD (  17.74  )
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



On 4/3/24 16:02, Engel, Amit wrote:
> Hello,
> 
> It seems like nvme-cli ‘nvme connect’ --duplicate-connect flag (-D) is not supported anymore
> nvme-cli version 1.16 ‘nvme connect’ -D flag allows duplicate connections between same transport host and subsystem port
> However, when trying to use nvme-cli 2.4 version, we get ‘already connected’ error:
> nvme connect -t tcp -a <ip_address> -s 4420 -n <subsystem_nqn> -D
> already connected
> 
> I can’t find a reason to remove this support. any idea? Is that by mistake?
> 
I think this is a bug in nvme-cli. If you write nvmf-connect options 
directly to /dev/nvme-fabrics then it would work. The fabrics driver code 
would allow a host to create duplicate connections to the same target. 

You may try this directly by-passing nvme-cli:
# echo "nqn=<subsystem_nqn>,transport=tcp,traddr=<ip_address>,trsvcid=4420,duplicate_connect" > /dev/nvme-fabrics

If you want to use nvme-cli then you may try this patch:

--- a/fabrics.c
+++ b/fabrics.c
@@ -999,7 +999,7 @@ int nvmf_connect(const char *desc, int argc, char **argv)
        };
 
        c = lookup_ctrl(h, &trcfg);
-       if (c && nvme_ctrl_get_name(c)) {
+       if (c && nvme_ctrl_get_name(c) && !cfg.duplicate_connect) {
                fprintf(stderr, "already connected\n");
                errno = EALREADY;
                goto out_free;

Thanks,
--Nilay 


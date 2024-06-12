Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC78C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1HFQ3uJZ8bQzBvBBHDCzaXQd/+KvnO9Teylpop0jGeo=; b=JuA9HerxtzyA/E/UA25eH2iN/L
	DkQQ4D47pQY5fFVP3naVPC33ltUPlGUEuazz5YR0qUDnJXCiQTMJCppgpWZo8j61yiNY3gtqlkigh
	56VzuY0FZOpVfKBgxc0p0N1jZSqu0BC8WcDBZmUWmvapp1rT8H28eGZeQ0DX/3IE2TSYbOMLTitu9
	xAJifUGd5tDgFDvMkvufsM0WfdXZyTo0k2DlFqeJeoLqTyzVlxAD+1h+YpgLeZmX1iKAOe19JW1hT
	oLuRlIwnDHUNoMC6OytKx1kNDL4lZECaWqR52MAipmIOsIsDgUl8VwXtStSbb/vNv67zUBzVhdoLN
	f75pbd/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHRSI-0000000DVVY-387L;
	Wed, 12 Jun 2024 17:08:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHRSD-0000000DVTG-2puF
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 17:08:13 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CEx775030970;
	Wed, 12 Jun 2024 17:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
	HFQ3uJZ8bQzBvBBHDCzaXQd/+KvnO9Teylpop0jGeo=; b=im3stDKBZvzjXIkQO
	Vo1FHMh6B7OGoJbLKx/Y9QOtVRNVYPuhbWET+4wblEdp2dPZU1Zjubc1u1jMspj0
	DVCGcDSngj3wK7B11zkebF7hc3or8vl/gkjv2xj3TexCNkDgcFKWJDxQDap0gC4G
	qQp/oN5lhFmU9X9bZpW7lg5P3zLxzQwJMoNnOMuDeYXFaK37zUHj8xbw2jqxtmlM
	/hQBp4zJwrcl6kSqywbUCuNqHpioFV1QpZDxCbMzkh/grdFHyLYexh0HO38lsIwX
	pRdeVBEMnqyABgN5GsuIL0B0lyNwqK//KJSda7Jfj+O+0o6sCx6lKfU0uz8vCPez
	CeufQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqdwf0cqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 17:08:04 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45CH5QS7008575;
	Wed, 12 Jun 2024 17:08:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqdwf0cqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 17:08:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45CFOK2G020066;
	Wed, 12 Jun 2024 17:08:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34n7skk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 17:08:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45CH7xQ49503352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 17:08:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC08558062;
	Wed, 12 Jun 2024 17:07:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7033158059;
	Wed, 12 Jun 2024 17:07:57 +0000 (GMT)
Received: from [9.43.75.155] (unknown [9.43.75.155])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Jun 2024 17:07:57 +0000 (GMT)
Message-ID: <d9d64808-397e-49ba-9f03-e9a8e773d135@linux.ibm.com>
Date: Wed, 12 Jun 2024 22:37:56 +0530
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
 <15192c9d-ce45-4dbc-bdbb-752cdfd4e663@linux.ibm.com>
 <CAFL455kRzW25EB+89dWBMV608PyDVEfuM0Re1q69gXKZ3Uc=mg@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFL455kRzW25EB+89dWBMV608PyDVEfuM0Re1q69gXKZ3Uc=mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mVv1Ey3IdnKnhf5VngLtX6qn1lZS1d7N
X-Proofpoint-ORIG-GUID: rVAoeqOp5VLNDoYLMkZnbAGkNK-Yd9q1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=904 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_100809_968893_B21F56F3 
X-CRM114-Status: GOOD (  11.19  )
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



On 6/12/24 18:40, Maurizio Lombardi wrote:
> st 12. 6. 2024 v 13:07 odesílatel Nilay Shroff <nilay@linux.ibm.com> napsal:
>> I think for your case you shall consider using nvme_wait_reset() before
>> queuing error recovery work. For instance, it could be done something
>> like below  assuming that all callers of nvme_tcp_error_recovery() are
>> allowed to sleep (not fully tested) :
>>
>> static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>> {
>>         if (!nvme_wait_reset(ctrl))
>>                 return;
> 
> Nice idea but in this case I don't think it can work
> because socket's callbacks run in interrupt context.
> 
Ok so in that case how about calling nvme_wait_reset() 
from nvme_tcp_error_recovery_work()?

Thanks,
--Nilay


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F86CC54E67
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x7sNNOLrBNxo252K/8fD+FyCgbNVzn9GIT0+NumgSM4=; b=QCmY6CupikBqVetf7BiVYQYjBD
	cgQjtQHJ1JcZa4EWBxBD9z7TkAeJNsleU3gs5TcEvxsfZc55eCyI0mY9EH/nG3qfqSv6tw7zW+maV
	QU04tN8FWTd5q25fnD5M3YI+Xda3EM7QHqO1JDwjrPlfdA/aFjAu3fdP/l60UieNEFaUNoFTYz8on
	GOGMMpvs829amQTlQp2xy2KzomEGFL+RpXIr6BWi5A5v3ETpiLEhMFa4aSQNmPC/cLbKdGo8zE5qm
	jUmGw585aKzIu4lHA84RiY4DlnOIEVkv9x5onCET47nUb8J9cV6nV8so9r49ZaFdQ8G4VcmEiY6Co
	Vwm3WbNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp0qs-00000003ND5-1oRK;
	Tue, 26 Mar 2024 07:04:06 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp0qm-00000003NCJ-08Ki
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 07:04:05 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q6mAMb026977;
	Tue, 26 Mar 2024 07:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=x7sNNOLrBNxo252K/8fD+FyCgbNVzn9GIT0+NumgSM4=;
 b=e0OPr1NrfAk24hJ4ZqAc7U36cMiz5oYADFBYQEiRP6unW1c2iwQAhv+7WWjt4qcS107Q
 AvIy5UeuDtF1vqXgfDn/q630et8b9TJ6dOu/XLwQTOK1h726iUP+iEcP03/KxB1MYabS
 u8m1IIh3b6cDCKmCsbMo+lm3sphzCvnjni7CTgh/1sEpE8LY7rFXwGCMFdwGC79LpP6o
 yGV7GHp/TQUFKY3hqrRARR+/+ouwmI+n6XyzpmVOnFFlPZJhaKYsBWihYoHJPA7V+cjx
 Lv6kHAAMkx/jllFQA4v5Pcpknjx8o0gFCT/8JAo96dUFcvoA3ryFmzhm5cuklApRk10Y AQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3sd8r17u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:03:55 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q4OLo2011285;
	Tue, 26 Mar 2024 07:03:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmkwt1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:03:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42Q73q8U19923706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 07:03:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCE6D58056;
	Tue, 26 Mar 2024 07:03:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6302F58065;
	Tue, 26 Mar 2024 07:03:49 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 07:03:49 +0000 (GMT)
Message-ID: <7ef8c5e0-4291-43f2-83ef-588b12176b36@linux.ibm.com>
Date: Tue, 26 Mar 2024 12:33:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tree: Add NVM subsystem controller identifier
Content-Language: en-US
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, dwagner@suse.de, gjoyce@ibm.com
References: <20240326065752.164286-1-nilay@linux.ibm.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240326065752.164286-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wV1dAbimYmwey-Wz5j0KYfA82YiAK8My
X-Proofpoint-GUID: wV1dAbimYmwey-Wz5j0KYfA82YiAK8My
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_000403_267587_BC3B7BB5 
X-CRM114-Status: GOOD (  34.07  )
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

I forgot to add that this is libnvme patch in the subject. Sorry about that.

Thanks,
--Nilay

On 3/26/24 12:27, Nilay Shroff wrote:
> This commit introduces a field "cntlid" for controller,
> that contains the NVM subsystem unique identifier assigned
> to each controller device in an NVM subsystem.
> 
> While attaching a namespace, typically user needs to specify the
> controller identifier (cntlid). The cntlid could be referenced from
> sysfs (/sys/class/nvme/nvmeX/cntlid) but it would be nice to have
> a direct option.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Hi all,
> 
> While attaching an NVMe namespace using nvme-cli command 
> "nvme attach-ns", we need to specifiy controller identifier 
> (cntlid) against which the namespace is being attached. 
> 
> Not specifying cntlid while attaching namespace would result in 
> no actual change in namespace attachment. For instance,
> 
> # nvme create-ns /dev/nvme0 --nsze=0x156d56 --ncap=0x156d56  --block-size=4096 
> create-ns: Success, created nsid:1
> 
> # nvme attach-ns /dev/nvme0 -n 1
> warning: empty controller-id list will result in no actual change in namespace attachment
> attach-ns: Success, nsid:1
> 
> # nvme list -o json
> {
>   "Devices":[
>   ]
> }
> 
> Though it's possible to find the cntlid looking at the sysfs file, 
> it'd be convenient to have it readily avaliable under nvme list 
> verbose output. 
> 
> This patch adds support for retrieving the cntlid in libnvme, 
> the subsequent nvme-cli patch shall use this information to 
> print the cntlid field in nvme list verbose output.
> 
> Thanks,
> --Nilay
> 
> ---
>  src/libnvme.map    | 1 +
>  src/nvme/private.h | 1 +
>  src/nvme/tree.c    | 7 +++++++
>  src/nvme/tree.h    | 7 +++++++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/src/libnvme.map b/src/libnvme.map
> index c03a99d1..8710c41f 100644
> --- a/src/libnvme.map
> +++ b/src/libnvme.map
> @@ -9,6 +9,7 @@ LIBNVME_1.9 {
>  		nvme_submit_passthru;
>  		nvme_submit_passthru64;
>  		nvme_update_key;
> +		nvme_ctrl_get_cntlid;
>  };
>  
>  LIBNVME_1_8 {
> diff --git a/src/nvme/private.h b/src/nvme/private.h
> index 11744c25..723740be 100644
> --- a/src/nvme/private.h
> +++ b/src/nvme/private.h
> @@ -86,6 +86,7 @@ struct nvme_ctrl {
>  	char *dhchap_key;
>  	char *dhchap_ctrl_key;
>  	char *cntrltype;
> +	char *cntlid;
>  	char *dctype;
>  	char *phy_slot;
>  	bool discovery_ctrl;
> diff --git a/src/nvme/tree.c b/src/nvme/tree.c
> index 584e3f6a..6efdf992 100644
> --- a/src/nvme/tree.c
> +++ b/src/nvme/tree.c
> @@ -1008,6 +1008,11 @@ const char *nvme_ctrl_get_dhchap_host_key(nvme_ctrl_t c)
>  	return c->dhchap_key;
>  }
>  
> +const char *nvme_ctrl_get_cntlid(nvme_ctrl_t c)
> +{
> +	return c->cntlid;
> +}
> +
>  void nvme_ctrl_set_dhchap_host_key(nvme_ctrl_t c, const char *key)
>  {
>  	if (c->dhchap_key) {
> @@ -1117,6 +1122,7 @@ void nvme_deconfigure_ctrl(nvme_ctrl_t c)
>  	FREE_CTRL_ATTR(c->address);
>  	FREE_CTRL_ATTR(c->dctype);
>  	FREE_CTRL_ATTR(c->cntrltype);
> +	FREE_CTRL_ATTR(c->cntlid);
>  	FREE_CTRL_ATTR(c->phy_slot);
>  }
>  
> @@ -1800,6 +1806,7 @@ static int nvme_configure_ctrl(nvme_root_t r, nvme_ctrl_t c, const char *path,
>  		}
>  	}
>  	c->cntrltype = nvme_get_ctrl_attr(c, "cntrltype");
> +	c->cntlid = nvme_get_ctrl_attr(c, "cntlid");
>  	c->dctype = nvme_get_ctrl_attr(c, "dctype");
>  	c->phy_slot = nvme_ctrl_lookup_phy_slot(r, c->address);
>  
> diff --git a/src/nvme/tree.h b/src/nvme/tree.h
> index a30e8eb7..1d635baa 100644
> --- a/src/nvme/tree.h
> +++ b/src/nvme/tree.h
> @@ -1025,6 +1025,13 @@ const char *nvme_ctrl_get_host_iface(nvme_ctrl_t c);
>   */
>  const char *nvme_ctrl_get_dhchap_host_key(nvme_ctrl_t c);
>  
> +/**
> + *  nvme_ctrl_get_cntlid() - Controller id
> + *  @c:	Controller to be checked
> + *
> + *  Return : Controller id of @c
> + */
> +const char *nvme_ctrl_get_cntlid(nvme_ctrl_t c);
>  /**
>   * nvme_ctrl_set_dhchap_host_key() - Set host key
>   * @c:		Host for which the key should be set


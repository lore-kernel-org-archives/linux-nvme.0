Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F2EC28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 18:15:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EB620747
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 18:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jX8twmsD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vUV53PV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EB620747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4B3Jl0cUfGcD8Ao7Ivug0JSpmtjnvhNcrueWiuGMZhM=; b=jX8twmsD7YctDr
	G/wXwnP4eetclV3TG1dPR47wXpMHFazDrB/8D5TLRZf8qtFsFvKUxYSG1AOqLxF95XJLf5RS/jjqD
	oEuvecGVIc+siMbKINlffHua/9ZqGE8T1rdgutUjSsGqsN+WDu1i6HOL442sUKauDDMI5p3tgmm2a
	a+mg5R+FrMRvJgcS2R71IkQczcQbkq2378o0iikoIptasPavBcNnetQrQwqIzbAToOMhlGn2CT5i5
	Bwlk51SoUKAxIisv0W0TguEuXkxXwlTJBFE+8Og20ppKnFf6fM7m94XvdrwyieR6ucpgqeYu/Xyws
	aQzstEDKdvi0T01jFYSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWOa1-0005xa-UO; Wed, 06 May 2020 18:15:37 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWOZP-0002x7-Q2
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 18:15:01 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046IE4Xa160314;
 Wed, 6 May 2020 18:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=bCuKAZQERoZyDTGrbOPdmZFWnRv6OVOOQura9CbIaiY=;
 b=vUV53PV6cHyV4sxCK1IWG2l9RCOWSgFQsj+/YVtweCCTEcQekNRmPeMJYIb6kLKOIWNu
 7sPhRA5kC8xon/3TJQPmQuEr+nDs2gl4+lJ3ltBqcChOZQZmZ5FIDfka02nIiUCte5gZ
 mNvqbqhbmSAhM1lE9fQeHBBE+GtNb70YICV71DONs/f5X7LDYNkUG6BA8gH9MLTaCZJ1
 BLkbZupR1B5TtLWJrCqW08PeliHeyzynmBmY3V9LTyLx29xxdWgv+RxHjGAfGFVcJv/4
 lgddxYg52qsp7rTsPxsZsuvtQIDU/yp+XU0ecyuQi82TP8OggKG0qy8nJXv32beQw55/ bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 30s1gnbtkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 18:14:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046ICpqt106526;
 Wed, 6 May 2020 18:14:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 30sjdw2kyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 18:14:42 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046IEfrN018559;
 Wed, 6 May 2020 18:14:41 GMT
Received: from [10.159.232.76] (/10.159.232.76)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 May 2020 11:14:41 -0700
Subject: Re: How to setup nvme-loop with multipath
To: Christoph Hellwig <hch@infradead.org>
References: <a3692e2f-c3a3-4d2a-8dc7-b49058e01347@default>
 <20200506063023.GA6928@infradead.org>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <39ceafc1-a724-20b6-1691-381334f61d1d@oracle.com>
Date: Wed, 6 May 2020 11:14:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506063023.GA6928@infradead.org>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_111459_917743_AA5A2B4B 
X-CRM114-Status: GOOD (  20.92  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/5/20 11:30 PM, Christoph Hellwig wrote:
> On Sun, May 03, 2020 at 01:14:25PM -0700, Dongli Zhang wrote:
>> Hi nvme developers,
>>
>> Would you please help confirm if it is feasible to support multi-path (indeed
>> shared namespace as id->cmic is always set for nvme-over-fabric) for nvme-loop
>> so that we would be able to have much more complex topology configuration for
>> nvme multi-path.
>>
>> Below is my sample json file. While both disk1.img and disk2.img are belong to
>> 'testnqn', disk3.img is belong to 'testnqn2'.
>>
>> Is there any way to have disk2.img as shared namespace used by both 'testnqn'
>> and 'testnqn2'?
> 
> All the namespace are shared by default.  Just run your connect command
> line again and you get another path (just use a different traddr to
> make sure duplicates aren't sorted out)
> 
> This is my simple test connect script:
> 
> ---
> et -e
> set +x
> 
> HOSTNQN=nqn.2014-08.org.nvmexpress:NVMf:uuid:77dca664-0d3e-4f67-b8b2-04c70e3f991f
> NQN=nqn.2014-08.org.nvmexpress:NVMf:uuid:77dca664-0d3e-4f67-b8b2-04c70e3f991d
> 
> echo "transport=loop,hostnqn=$HOSTNQN,nqn=$NQN" > /dev/nvme-fabrics
> echo "transport=loop,hostnqn=$HOSTNQN,nqn=$NQN,traddr=192.168.7.68" > /dev/nvme-
> fabrics
> 

Thank you very much!

This works for me. As 'traddr' is used, there is just extra requirement to add
below to the default sample loop.json.

  "ports": [
    {
      "addr": {
        "adrfam": "ipv4",
        "traddr": "10.0.2.15",
        "treq": "not specified",
        "trsvcid": "",
        "trtype": "loop"
      },

Thank you very much!

Dongli Zhang

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
